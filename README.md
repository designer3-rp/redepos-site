# Site RedePOS

Site institucional + blog + painel administrativo. HTML/CSS/JS puro no front, **Supabase** (Postgres + Auth + Storage) no backend.

## Início rápido

### 1. Banco (Supabase → SQL Editor)
1. Rode `supabase/schema.sql`
2. Rode `supabase/seed.sql`
3. Confira: `select count(*) from posts;` → deve dar **3**

### 2. Seu acesso admin
1. **Authentication → Settings:** desligue "Allow new users to sign up"
2. **Authentication → Users:** crie o usuário `designer3@redepos.com.br` com uma senha
3. Rode de novo o bloco final do `seed.sql` (já preenchido com seu e-mail) pra virar super admin
4. **Authentication → URL Configuration:** adicione `http://localhost:5173`

### 3. Edge Function (convite de usuários)
```bash
supabase functions deploy invite-user
```

### 4. Rodar localmente
**Não** abra os `.html` com duplo-clique. Sirva por HTTP:
```bash
python3 -m http.server 5173
```
- Site:   http://localhost:5173/
- Blog:   http://localhost:5173/blog.html
- Painel: http://localhost:5173/admin/

## Arquivos
| Arquivo | O quê |
|---|---|
| `index.html` | Home (one-pager) |
| `blog.html` / `post.html` | Blog |
| `admin/index.html` | Painel administrativo |
| `supabase/schema.sql` | Estrutura do banco (rodar 1º) |
| `supabase/seed.sql` | Dados iniciais + 3 posts (rodar 2º) |
| `supabase/functions/invite-user/index.ts` | Edge Function de convite |
| `CLAUDE.md` | Documentação completa do projeto |

Detalhes de tudo (marca, RLS, convenções, pendências) estão no **`CLAUDE.md`**.
