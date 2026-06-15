// supabase/functions/invite-user/index.ts
// Convida um usuário por e-mail e cria o perfil dele.
// Só pode ser chamada por quem é super_admin (verificado pelo JWT de quem chama).
// Deploy:  supabase functions deploy invite-user
// (mantenha a verificação de JWT LIGADA — é o padrão)

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...cors, "Content-Type": "application/json" },
  });
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });

  try {
    // Estas variáveis são injetadas automaticamente pelo Supabase nas Edge Functions.
    const URL = Deno.env.get("SUPABASE_URL")!;
    const ANON = Deno.env.get("SUPABASE_ANON_KEY")!;
    const SERVICE = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

    // 1) Quem está chamando? Usa o JWT do cabeçalho pra identificar e checar o papel.
    const authHeader = req.headers.get("Authorization") ?? "";
    const caller = createClient(URL, ANON, { global: { headers: { Authorization: authHeader } } });

    const { data: { user }, error: userErr } = await caller.auth.getUser();
    if (userErr || !user) return json({ error: "Não autenticado." }, 401);

    const { data: perfil } = await caller.from("perfis").select("role").eq("id", user.id).single();
    if (!perfil || perfil.role !== "super_admin") return json({ error: "Sem permissão (apenas super admin)." }, 403);

    // 2) Dados do convite
    const { email, nome, role } = await req.json();
    if (!email) return json({ error: "E-mail é obrigatório." }, 400);
    const papel = role === "super_admin" ? "super_admin" : "editor";

    // 3) Cliente com service role (poderes de admin) pra convidar e criar o perfil
    const admin = createClient(URL, SERVICE);

    const { data: invited, error: inviteErr } = await admin.auth.admin.inviteUserByEmail(email);
    if (inviteErr || !invited?.user) return json({ error: inviteErr?.message || "Falha ao convidar." }, 400);

    const uid = invited.user.id;
    const { error: perfilErr } = await admin.from("perfis").upsert({ id: uid, nome: nome || email, role: papel });
    if (perfilErr) return json({ error: "Usuário convidado, mas falhou ao criar perfil: " + perfilErr.message }, 500);

    return json({ ok: true, id: uid, email });
  } catch (e) {
    return json({ error: String((e as Error)?.message || e) }, 500);
  }
});
