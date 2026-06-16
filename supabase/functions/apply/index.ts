// supabase/functions/apply/index.ts
// Recebe uma candidatura do site, salva em `candidaturas` e encaminha
// para o webhook configurado no painel (ex.: seu fluxo no n8n).
// Deploy:  supabase functions deploy apply
// (pode deixar a verificação de JWT ligada — o site chama com a anon key)

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
const json = (b: unknown, status = 200) =>
  new Response(JSON.stringify(b), { status, headers: { ...cors, "Content-Type": "application/json" } });

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });

  try {
    const URL = Deno.env.get("SUPABASE_URL")!;
    const SERVICE = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const admin = createClient(URL, SERVICE);

    const body = await req.json().catch(() => ({}));
    const { vaga_id, vaga_titulo, nome, email, telefone, linkedin, mensagem } = body ?? {};
    if (!nome || !email) return json({ error: "Nome e e-mail são obrigatórios." }, 400);

    // 1) salva a candidatura
    const { data: row, error: insErr } = await admin.from("candidaturas").insert({
      vaga_id: vaga_id || null, vaga_titulo: vaga_titulo || null,
      nome, email, telefone: telefone || null, linkedin: linkedin || null,
      mensagem: mensagem || null, payload: body,
    }).select().single();
    if (insErr) return json({ error: "Falha ao salvar: " + insErr.message }, 500);

    // 2) encaminha para o webhook (n8n) configurado no painel
    const { data: cfg } = await admin.from("config").select("candidaturas_webhook").eq("id", 1).single();
    const hook = cfg?.candidaturas_webhook?.trim();
    let encaminhado = false;
    if (hook) {
      try {
        const r = await fetch(hook, {
          method: "POST", headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ id: row.id, vaga_id, vaga_titulo, nome, email, telefone, linkedin, mensagem, recebido_em: row.created_at }),
        });
        encaminhado = r.ok;
      } catch (_) { encaminhado = false; }
      await admin.from("candidaturas").update({ encaminhado }).eq("id", row.id);
    }

    return json({ ok: true, id: row.id, encaminhado });
  } catch (e) {
    return json({ error: String((e as Error)?.message || e) }, 500);
  }
});
