-- ============================================================
--  RedePOS · Schema do banco (Supabase / Postgres) — v2 idempotente
--  Rode este arquivo PRIMEIRO no SQL Editor. Depois rode seed.sql.
--  Pode rodar novamente sem erro (tudo é "if exists / if not exists").
-- ============================================================

create extension if not exists "pgcrypto";

create or replace function set_updated_at() returns trigger as $$
begin new.updated_at = now(); return new; end;
$$ language plpgsql;

-- ============================== TABELAS ==============================
create table if not exists autores (
  id uuid primary key default gen_random_uuid(),
  nome text not null, cargo text, linkedin_url text, avatar_url text,
  created_at timestamptz default now()
);

create table if not exists posts (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null, titulo text not null, categoria text,
  resumo text, capa_url text, corpo_html text,
  autor_id uuid references autores(id) on delete set null,
  publicado boolean not null default false,
  data_publicacao date default current_date,
  created_at timestamptz default now(), updated_at timestamptz default now()
);
drop trigger if exists posts_updated on posts;
create trigger posts_updated before update on posts
  for each row execute function set_updated_at();
create index if not exists posts_pub_idx on posts (publicado, data_publicacao desc);

create table if not exists vagas (
  id uuid primary key default gen_random_uuid(),
  titulo text not null, tags text[] default '{}', link text,
  ativo boolean not null default true, ordem int default 0,
  created_at timestamptz default now()
);

create table if not exists redes_sociais (
  id uuid primary key default gen_random_uuid(),
  rede text not null unique
    check (rede in ('linkedin','instagram','facebook','x','youtube','tiktok','whatsapp','email')),
  ativo boolean not null default false, url text, ordem int default 0
);

create table if not exists form_campos (
  id uuid primary key default gen_random_uuid(),
  label text not null, name text not null,
  tipo text not null default 'text' check (tipo in ('text','email','tel','textarea')),
  obrigatorio boolean default false, placeholder text, ordem int default 0
);

create table if not exists form_assuntos (
  id uuid primary key default gen_random_uuid(),
  assunto text not null, ordem int default 0
);

create table if not exists config (
  id int primary key default 1 check (id = 1),
  form_action text default '', form_method text default 'POST',
  banco_ativo boolean default true, banco_titulo text default 'Não encontrou sua vaga?',
  banco_texto text, banco_link text
);

create table if not exists perfis (
  id uuid primary key references auth.users(id) on delete cascade,
  nome text, role text not null default 'editor' check (role in ('editor','super_admin')),
  created_at timestamptz default now()
);

-- ============================== HELPERS ==============================
create or replace function is_admin() returns boolean as $$
  select exists (select 1 from perfis where id = auth.uid());
$$ language sql security definer stable;

create or replace function is_super_admin() returns boolean as $$
  select exists (select 1 from perfis where id = auth.uid() and role = 'super_admin');
$$ language sql security definer stable;

-- ============================== RLS ==============================
alter table autores        enable row level security;
alter table posts          enable row level security;
alter table vagas          enable row level security;
alter table redes_sociais  enable row level security;
alter table form_campos    enable row level security;
alter table form_assuntos  enable row level security;
alter table config         enable row level security;
alter table perfis         enable row level security;

-- leitura pública
drop policy if exists "read autores"       on autores;        create policy "read autores"       on autores       for select using (true);
drop policy if exists "read posts"         on posts;          create policy "read posts"         on posts         for select using (publicado = true or is_admin());
drop policy if exists "read vagas"         on vagas;          create policy "read vagas"         on vagas         for select using (ativo = true or is_admin());
drop policy if exists "read redes"         on redes_sociais;  create policy "read redes"         on redes_sociais for select using (ativo = true or is_admin());
drop policy if exists "read form_campos"   on form_campos;    create policy "read form_campos"   on form_campos   for select using (true);
drop policy if exists "read form_assuntos" on form_assuntos;  create policy "read form_assuntos" on form_assuntos for select using (true);
drop policy if exists "read config"        on config;         create policy "read config"        on config        for select using (true);

-- escrita: somente admins do painel
drop policy if exists "write autores"       on autores;        create policy "write autores"       on autores       for all using (is_admin()) with check (is_admin());
drop policy if exists "write posts"         on posts;          create policy "write posts"         on posts         for all using (is_admin()) with check (is_admin());
drop policy if exists "write vagas"         on vagas;          create policy "write vagas"         on vagas         for all using (is_admin()) with check (is_admin());
drop policy if exists "write redes"         on redes_sociais;  create policy "write redes"         on redes_sociais for all using (is_admin()) with check (is_admin());
drop policy if exists "write form_campos"   on form_campos;    create policy "write form_campos"   on form_campos   for all using (is_admin()) with check (is_admin());
drop policy if exists "write form_assuntos" on form_assuntos;  create policy "write form_assuntos" on form_assuntos for all using (is_admin()) with check (is_admin());
drop policy if exists "write config"        on config;         create policy "write config"        on config        for all using (is_admin()) with check (is_admin());

-- perfis
drop policy if exists "read perfis"   on perfis; create policy "read perfis"   on perfis for select using (id = auth.uid() or is_super_admin());
drop policy if exists "manage perfis" on perfis; create policy "manage perfis" on perfis for all   using (is_super_admin()) with check (is_super_admin());

-- ============================== STORAGE (isolado: não derruba o resto) ==============================
do $$
begin
  insert into storage.buckets (id, name, public) values ('blog','blog',true) on conflict (id) do nothing;
exception when others then raise notice 'bucket blog: %', sqlerrm;
end $$;

do $$
begin
  drop policy if exists "blog read"   on storage.objects; create policy "blog read"   on storage.objects for select using (bucket_id = 'blog');
  drop policy if exists "blog insert" on storage.objects; create policy "blog insert" on storage.objects for insert with check (bucket_id = 'blog' and is_admin());
  drop policy if exists "blog update" on storage.objects; create policy "blog update" on storage.objects for update using (bucket_id = 'blog' and is_admin());
  drop policy if exists "blog delete" on storage.objects; create policy "blog delete" on storage.objects for delete using (bucket_id = 'blog' and is_admin());
exception when others then
  raise notice 'Políticas de Storage puladas (configure em Storage > Policies se precisar de upload): %', sqlerrm;
end $$;

-- recarrega o cache da API (PostgREST) para enxergar as tabelas novas
notify pgrst, 'reload schema';
