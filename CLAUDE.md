# CLAUDE.md — Site institucional RedePOS

Contexto pra qualquer sessão futura do Claude trabalhando neste projeto. **Comunicação com o cliente é em português do Brasil.**

## O que é
Site institucional da **RedePOS (RedePos Tecnologia)** — empresa de software/plataforma para o mercado regulado de **capitalização e loterias/sorteios** no Brasil ("mais que uma fábrica de software"). Referência visual: `https://redepos-stage.framer.website/`.

Começou como uma landing page estática de arquivo único e evoluiu para um **site multi-página estático + backend no Supabase** (Postgres + Auth + Storage) com **painel administrativo próprio**.

## Arquitetura
- **Front-end:** HTML/CSS/JS puro, sem build, sem framework. Cada página é um arquivo `.html` autossuficiente.
- **Dados:** Supabase (Postgres com RLS). O front lê via `@supabase/supabase-js` (CDN jsdelivr, UMD) com a **anon key** (pública, segura no cliente — RLS protege).
- **Auth + escrita:** só pelo painel (`/admin`), com usuário logado. Convite de usuários via Edge Function.
- **Hospedagem:** localhost por enquanto; infra própria depois.
- **Resiliência:** a home tem conteúdo de *fallback* embutido — se o Supabase não responder (timeout de ~9s), o site ainda renderiza. Blog e post dependem do banco.

## Estrutura de arquivos
```
index.html                         # Home (one-pager): hero, sobre, soluções, cases, vagas, contato
blog.html                          # Listagem de posts publicados
post.html                          # Post individual (?slug=...)
vagas.html                         # Carreira: "O que nos move" + benefícios + lista de vagas
vaga.html                          # Detalhe da vaga (?slug=) + formulário de candidatura
favicons/                          # Favicons (gerador padrão: favicon-32x32.png, apple-touch-icon.png, etc.)
admin/index.html                   # Painel admin (SPA própria: login + CRUD + editor visual)
supabase/schema.sql                # Schema do banco (idempotente — rodar primeiro)
supabase/seed.sql                  # Dados iniciais + 3 posts migrados (rodar depois do schema)
supabase/functions/invite-user/index.ts  # Edge Function: convida usuário (super_admin only)
supabase/functions/apply/index.ts         # Edge Function: recebe candidatura, salva e dispara webhook (n8n)
CLAUDE.md
```

## Marca (design tokens)
- **Laranja** `#E75314` (accent principal), variação `#FA7A36`.
- **Azul** `#1859D6` (`--brand-blue`). Hero usa gradiente azul-marinho escuro derivado dele (`#0d2152→#091736→#050c1c`).
- **Fontes:** `Sora` (display/títulos) + `Manrope` (corpo), via Google Fonts.
- **Logo:** embutida como SVG base64 no header/footer (variante branca + laranja). Assets originais vieram de `logos-rp.zip`.
- **Tom de voz:** humano, próposito ("conecta sonhos e prêmios"), usa 🧡 com parcimônia.

## Banco de dados (Supabase)
- Project URL: `https://ahhwkhccnpoqvvhgeyki.supabase.co`
- A **anon key** está embutida nos `.html` e na `admin/index.html` — isso é esperado e seguro. **Nunca** colocar a `service_role` key no front.
- Tabelas: `autores`, `posts`, `vagas`, `redes_sociais`, `form_campos`, `form_assuntos`, `config` (linha única id=1), `perfis` (liga a `auth.users`, papel `editor` | `super_admin`).
- Funções helper `SECURITY DEFINER`: `is_admin()`, `is_super_admin()`.
- **RLS:** leitura pública só de linhas publicadas/ativas; escrita só para quem tem perfil (`is_admin()`); `perfis` gerenciado por `super_admin`.
- **Storage:** bucket público `blog` (capas e imagens dos posts).

### Setup do zero (SQL Editor do Supabase)
1. Rodar **`supabase/schema.sql`** (pode rodar várias vezes — é idempotente; o bloco de Storage é isolado e não derruba a transação se faltar permissão).
2. Rodar **`supabase/seed.sql`**.
3. Conferir: `select count(*) from posts;` → deve dar 3.
4. **Authentication → Providers/Settings:** desligar "Allow new users to sign up" (acesso é só por convite).
5. **Authentication → Users:** criar o seu próprio usuário (e definir senha).
6. Rodar o bootstrap (já preenchido no fim do `seed.sql` com `designer3@redepos.com.br`) pra virar super admin:
   ```sql
   insert into perfis (id, nome, role)
   select id, 'Designer RedePOS', 'super_admin' from auth.users where email = 'designer3@redepos.com.br'
   on conflict (id) do update set role = 'super_admin';
   ```
7. **Authentication → URL Configuration:** adicionar a URL do localhost (ex.: `http://localhost:5173`) em Redirect URLs (pro reset de senha / convite voltarem certo).
8. **Edge Function:** `supabase functions deploy invite-user` (deixar a verificação de JWT ligada). As variáveis `SUPABASE_URL`, `SUPABASE_ANON_KEY` e `SUPABASE_SERVICE_ROLE_KEY` são injetadas automaticamente.

## Como rodar localmente
**Não** abrir os `.html` com duplo-clique (`file://` quebra as chamadas ao Supabase). Servir por HTTP:
```bash
cd <pasta-do-projeto>
python3 -m http.server 5173
# abrir http://localhost:5173/        (site)
#        http://localhost:5173/admin/ (painel)
```
Alternativa sem terminal: VS Code + extensão **Live Server** → botão direito no `index.html` → "Open with Live Server".

## Painel admin (`/admin`)
SPA de arquivo único. Login por e-mail/senha (Supabase Auth); checa `perfis.role`. Sem perfil = sem acesso. Seções: Posts, Autores, Vagas, Redes sociais, Assuntos do form, Campos do form, Configurações, e **Usuários** (só super_admin).
- **Editor de posts:** WYSIWYG `contenteditable` (P, H3, negrito, itálico, lista, citação, link e **imagem com legenda**). Upload de imagem/capa vai pro bucket `blog` e insere `<figure><img><figcaption>` — o `post.html` renderiza o `corpo_html` direto.
- **Usuários:** listar perfis, trocar papel (RLS exige super_admin), remover acesso, e **convidar** (chama a Edge Function `invite-user`, que dispara o e-mail de convite).

## Convenções
- Sem framework, sem bundler, sem dependências de build. Manter cada página autossuficiente.
- CDN do supabase-js: **jsdelivr UMD** (`https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2`) — `window.supabase.createClient`. (Evitar `esm.sh`, que travou em testes.)
- Toda chamada de dados tem **timeout** e trata erro visível na tela.
- Queries do blog **não** usam embedding de relação do PostgREST; buscam `autores` numa query separada e cruzam `autor_id → nome` no JS (mais robusto).
- O `corpo_html` dos posts é confiável (vem do painel autenticado) e renderizado via `innerHTML`.

## Pendências / próximos passos
- **Carreira/Vagas (já implementado):** vagas viram conteúdo rico no painel (slug, local, modelo, tipo, resumo, tags, descrição em editor visual). `vagas.html` lista benefícios ("O que nos move", tabela `beneficios`) + vagas → `vaga.html?slug=` mostra a descrição completa e o formulário de candidatura. A home mantém a prévia + "Ver todas as vagas".
- **Candidaturas:** o formulário em `vaga.html` chama a Edge Function `apply`, que (1) salva em `candidaturas` (visível no painel) e (2) encaminha pro **webhook do n8n** definido em Configurações (`config.candidaturas_webhook`). Deploy: `supabase functions deploy apply`. Se a vaga tiver `link` externo preenchido, o botão leva pra lá em vez do formulário.
- **Integração externa de vagas (futuro):** o schema já tem `vagas.fonte`/`vagas.external_id` e `config.vagas_source_url` para sincronizar vagas de uma plataforma externa via uma futura Edge Function `vagas-sync` (puxar e dar upsert na tabela `vagas`). Definir a plataforma/contrato da API.
- Trocar os **logos de cliente** placeholder no marquee da home (`<span class="client-logo">` → `<img>`), mantendo a lista duplicada 2x pro loop.
- Números reais de **stats/cases/vagas** (os atuais são ilustrativos).
- Configurar o **destino real do formulário** de contato em `config.form_action` (Formspree/Web3Forms) e o e-mail real (hoje `contato@redepos.com.br` é placeholder).
- **Deploy** em infra própria (URLs amigáveis tipo `/blog/slug` via nginx).
- Testar o painel ponta a ponta no localhost (login, CRUD, upload de imagem, convite de usuário).
