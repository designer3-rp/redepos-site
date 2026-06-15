-- RedePOS · Seed inicial. Rode DEPOIS do schema.sql.

insert into autores (id, nome, cargo, linkedin_url) values
  ('a1111111-1111-1111-1111-111111111111', $RP$Sabryna Vasconcelos$RP$, $RP$UX Designer$RP$, $RP$https://www.linkedin.com/in/sabryna-vasconcelos$RP$),
  ('a2222222-2222-2222-2222-222222222222', $RP$Rafael Queiroz$RP$, $RP$Lead Mobile Developer$RP$, $RP$https://www.linkedin.com/in/rafaelmqueiroz93$RP$),
  ('a3333333-3333-3333-3333-333333333333', $RP$Morgana Maria$RP$, $RP$UX Designer$RP$, $RP$https://www.linkedin.com/in/morgana-maria$RP$)
on conflict (id) do nothing;

insert into posts (slug, titulo, categoria, resumo, capa_url, corpo_html, autor_id, publicado, data_publicacao) values
  ($RP$como-melhorar-a-experiencia$RP$, $RP$Como melhorar a experiência de Chatbots aplicando boas práticas de UX e as Heurísticas de Nielsen$RP$, $RP$Chatbots$RP$, $RP$Insights de um projeto real de redesenho de chatbot guiado por UX e pelas 10 heurísticas de Nielsen.$RP$, $RP$https://framerusercontent.com/images/DapMoTMZtVWW6TqeexuFSd3NI.png$RP$, $RP$<blockquote><em>A experiência do usuário (UX) é essencial em qualquer interação digital, e quando falamos de chatbots, isso não poderia ser diferente. A construção de um fluxo conversacional eficiente, claro e amigável é um diferencial competitivo, especialmente para atender um público diverso e de diferentes faixas etárias e socioeconômicas.</em></blockquote>
<figure><img src="https://framerusercontent.com/images/DapMoTMZtVWW6TqeexuFSd3NI.png" alt="UX para chatbots"></figure>
<p>Nos últimos dias, eu e Laura trabalhamos em um projeto focado em melhorar o chatbot de um aplicativo, aplicando as boas práticas de UX e as 10 heurísticas de Nielsen. Queremos compartilhar aqui alguns dos insights desse processo.</p>
<p>“Confesso que me inspirei bastante no sucesso da IA Bia do Bradesco, após ver uma palestra sensacional no DexConf 2024 em SP. Receber esse projeto foi trazer movimento e pulsão de vida para os meus dias. Li bastante sobre design conversacional. Mas bora lá!”</p>
<h3>Primeiro passo: análise do fluxo atual</h3>
<p>Iniciamos com uma análise detalhada do estado atual do chatbot e das interações mais frequentes no SAC no período de duas semanas. Mapeamos as principais dúvidas e pontos de atrito que os usuários enfrentavam, além de conversar com o time de atendimento para entender as frustrações mais recorrentes.</p>
<p>Durante essa fase, descobrimos que 28% dos usuários relataram dificuldades em visualizar seus produtos após a compra, enquanto 19% buscavam ajuda para correções cadastrais. Percebemos também um aumento expressivo de interações entre 9h e 12h, com foco nos mesmos temas: “não visualizo meu produto” e “correção de cadastro”.</p>
<h3>Segundo passo: aplicando boas práticas de UX</h3>
<p>O chatbot é muitas vezes o primeiro ponto de contato entre o usuário e o serviço, por isso deve proporcionar uma experiência não só positiva, mas também simples e eficiente. Algumas práticas que nos guiaram:</p>
<ul>
<li><strong>Clareza e objetividade:</strong> respostas diretas, sem termos técnicos que confundam o usuário. Linguagem simples, amigável e acessível.</li>
<li><strong>Fluxo conversacional didático:</strong> caminhos objetivos e perguntas direcionadas, para o usuário achar a solução rapidamente.</li>
<li><strong>Escalabilidade nas opções:</strong> oferecer alternativas quando o chatbot não resolve, encaminhando para um atendente.</li>
</ul>
<h3>Aplicando as 10 Heurísticas de Nielsen</h3>
<p>Jakob Nielsen é o nome mais respeitado quando o assunto é usabilidade. Aplicar as heurísticas ao chatbot foi um dos pilares para transformar a experiência do usuário.</p>
<p><strong>1. Visibilidade do status do sistema:</strong> mantemos o usuário sempre informado sobre o andamento da solicitação, como “Estamos buscando um assistente para te atender”, além de respostas rápidas.</p><figure><img src="https://framerusercontent.com/images/wZjuvsbSQENA0R36ArYzeuy6ob0.png" alt=""></figure>
<p><strong>2. Correspondência entre sistema e mundo real:</strong> adaptamos a linguagem ao nível do usuário, evitando termos técnicos e usando uma comunicação mais natural e cotidiana.</p><figure><img src="https://framerusercontent.com/images/WEwgYwHcqQadfKkitWAmt143Wbo.png" alt=""></figure>
<p><strong>3. Controle e liberdade do usuário:</strong> sempre oferecemos a opção de voltar ao menu principal ou falar com um atendente, dando sensação de controle.</p><figure><img src="https://framerusercontent.com/images/8cJuOcsjhCEWUBBx1loErKAMLc.png" alt=""></figure>
<p><strong>4. Consistência e padrões:</strong> mantivemos consistência nas respostas, evitando variações de termos para o mesmo conceito (ex.: “saldo da carteira” vs “crédito na conta”).</p><figure><img src="https://framerusercontent.com/images/ts7eb0MDH6xByCZmUewCa63I.png" alt=""></figure>
<p><strong>5. Prevenção de erros:</strong> identificamos pontos de erro comuns e oferecemos instruções preventivas — por exemplo, checar se o usuário está logado antes da correção de cadastro.</p><figure><img src="https://framerusercontent.com/images/u4hLzXdHxSnVjRfPfA3irbsy28.png" alt=""></figure>
<p><strong>6. Reconhecimento em vez de memorização:</strong> mantivemos padrões e categorias para não sobrecarregar os fluxos.</p>
<p><strong>7. Flexibilidade e eficiência de uso:</strong> atalhos e links diretos para as páginas mais acessadas, e ações claras como habilitar o botão enviar e confirmar o fechamento do chat.</p><figure><img src="https://framerusercontent.com/images/ckw3bUaKJ99BiS6lj0RlrydJFD8.png" alt=""></figure>
<p><strong>8. Design estético e minimalista:</strong> reestruturamos as respostas para evitar excesso de informação, focando no essencial da tarefa.</p>
<p><strong>9. Ajuda a reconhecer, diagnosticar e recuperar de erros:</strong> respostas mais humanas e detalhadas para situações de erro, sugerindo alternativas e mais opções, sem aumentar o estresse do usuário.</p><figure><img src="https://framerusercontent.com/images/Xww2cOYOqVM4qV7cfVhbKUNljE.png" alt=""></figure>
<p><strong>10. Ajuda e documentação:</strong> guias passo a passo nos fluxos principais e a opção de falar com um atendente sempre disponível.</p>
<h3>Terceiro passo: revisão e conversa</h3>
<p>Após a reformulação dos fluxos, apresentamos as mudanças para o time e a diretoria e coletamos feedbacks valiosos. Uma melhoria foi a inclusão de um passo voltado à coleta de dados quantitativos e qualitativos, para monitorar continuamente o comportamento dos usuários e identificar novos pontos de melhoria.</p>
<figure><img src="https://framerusercontent.com/images/goqgGMokxi4DdguXZdT4AjrRo.png" alt="Fluxo anterior x fluxo atual"><figcaption>Imagem reduzida do fluxo anterior x fluxo atual</figcaption></figure>
<h3>Resultados e próximos passos</h3>
<p>Com essas melhorias, o chatbot ficou mais eficiente, amigável e acessível, proporcionando uma experiência mais fluida e menos frustrante. O próximo passo é analisar os dados de interação para ajustar ainda mais o fluxo.</p>
<p>Quando desenhamos um chatbot, criamos uma ponte direta entre a empresa e seus usuários — e a qualidade dessa interação impacta diretamente a percepção da marca. Se você pensa em melhorar o fluxo do seu chatbot, comece aplicando as heurísticas de Nielsen.</p>
<p>Grande abraço e foi um prazer ❤️ Saúde!</p>$RP$, 'a3333333-3333-3333-3333-333333333333', true, '2024-10-18'),
  ($RP$devmode$RP$, $RP$Construindo o sucesso: a revolução do Dev Mode no Figma$RP$, $RP$Design$RP$, $RP$Como o Dev Mode do Figma torna a entrega de design para desenvolvimento mais fluida e precisa.$RP$, $RP$https://framerusercontent.com/images/033EbitsZGCT0BZkvTPnYGlimKY.webp$RP$, $RP$<p>O UX design desempenha um papel crucial na criação de produtos digitais bem-sucedidos, colocando as necessidades, desejos e comportamentos dos usuários no centro de tudo. Uma boa interface não apenas facilita a realização de tarefas, como também cria uma conexão emocional com os usuários, promovendo a satisfação, a fidelidade e o sucesso do produto num mercado altamente competitivo. No entanto, transformar um design intuitivo numa experiência funcional pode ser bastante desafiador.</p>
<figure><img src="https://framerusercontent.com/images/033EbitsZGCT0BZkvTPnYGlimKY.webp" alt="Dev Mode no Figma"></figure>
<p>Um dos principais obstáculos é a falta de clareza nas especificações de design. Um design é mais do que uma imagem estática — é um conjunto de interações e comportamentos que precisam ser expressos claramente e, por vezes, designers acabam focando na aparência visual, sem fornecer informações detalhadas sobre a funcionalidade e o comportamento esperado do produto. Isso acaba gerando interpretações equivocadas e lacunas na implementação.</p>
<p>Outro desafio vem da natureza do design, que está em constante evolução. Somos sempre incentivados a pensar fora da caixa e explorar soluções inovadoras. Contudo, mudanças rápidas e frequentes podem dificultar o trabalho dos desenvolvedores. A falta de estabilidade pode levar a atrasos, retrabalhos e, por fim, à frustração de ambos os lados.</p>
<p>Mas aí vem a parte boa: uma comunicação eficaz tem um papel essencial na mitigação desses desafios. Pensando nisso, o <strong>Figma</strong> lançou uma funcionalidade chamada Dev Mode, que está abrindo novas possibilidades para a colaboração eficiente entre designers e desenvolvedores, tornando o processo de traduzir o design em código muito mais fluido e preciso.</p>
<p>Então, vamos aprender a usar o Dev Mode? Um guia passo a passo para usar o Dev Mode está disponível na Comunidade do Figma, permitindo que mais pessoas aprendam a utilizar essa ferramenta de forma prática. Originalmente escrito em inglês, tomei a liberdade de traduzir para que o idioma não seja um obstáculo nessa experiência de aprendizagem.</p>
<p>Após abrir o link abaixo, clique no botão “<strong>Open in Figma</strong>” e divirta-se! 😄</p>
<p>🖥️ <a href="https://www.figma.com/community/file/1255621430738822520" target="_blank" rel="noopener">Playground para desenvolvedores</a></p>
<p>🎨 <a href="https://www.figma.com/community/file/1255621841284367737" target="_blank" rel="noopener">Playground completo</a></p>$RP$, 'a1111111-1111-1111-1111-111111111111', true, '2023-06-27'),
  ($RP$componentes-dinamicos$RP$, $RP$Componentes dinâmicos: a abordagem para componentes “lazy” no Angular$RP$, $RP$Angular$RP$, $RP$Como montar componentes sob demanda no Angular e ganhar desempenho com lazy loading.$RP$, $RP$https://framerusercontent.com/images/c5FhJ3DTi0YWKhHdl82xCQblk4.png$RP$, $RP$<p>Ao mostrar uma tela no Angular, todos os componentes são montados com base nos dados disponíveis inicialmente. Mas o que acontece se quisermos montar um componente dinamicamente, em tempo de execução?</p>
<figure><img src="https://framerusercontent.com/images/c5FhJ3DTi0YWKhHdl82xCQblk4.png" alt="Componentes dinâmicos no Angular"></figure>
<p>Uma aplicação em Angular, ao iniciar, monta toda a árvore de componentes e remonta sempre que há uma atualização dos dados conectados ao <em>template</em>. Mas também há a opção de fazer com que um componente seja montado sob demanda (por meio de um evento, <em>timer</em> ou qualquer função).</p>
<p>Esse tipo de controle de montagem de componentes é conhecido como “<em>lazy loading</em>”, e oferece um ganho de desempenho ao permitir carregar, inicialmente, apenas o necessário. No próprio Angular também podemos carregar módulos seguindo essa lógica, mas isso é assunto para uma próxima conversa.</p>
<p>O objetivo desse artigo é mostrar como fazer a montagem dinâmica de componentes e falar um pouco sobre vantagens e a complexidade envolvida. E para isso vamos criar um componente com uma lista de cartões de contato colapsáveis (conhecidos como <em>accordions</em>).</p>
<h3>Mãos na massa</h3>
<p>O código final usado neste guia está <a href="https://stackblitz.com/edit/angular-ltetza" target="_blank" rel="noopener">disponível para experimentos</a> (muahahaaaa), e a abordagem usada só está disponível a partir do Angular 13.</p>
<p>Primeiro vamos ver como seria essa interface sem os componentes dinâmicos. Aqui temos o componente raiz da aplicação:</p>
<pre><code>import { Component } from &#x27;@angular/core&#x27;;
import { Card } from &#x27;./card.model&#x27;;

@Component({
  selector: &#x27;my-app&#x27;,
  template: `
  &lt;h1&gt;Cards dinamicos&lt;/h1&gt;
  &lt;div class=&quot;card&quot; *ngFor=&quot;let card of cards&quot;&gt;
    &lt;app-card [card]=&quot;card&quot;&gt;&lt;/app-card&gt;
  &lt;/div&gt;
  `,
  styleUrls: [&#x27;./app.component.css&#x27;],
})
export class AppComponent {
  name = &#x27;Angular&#x27;;
  cards: Card[] = [
    { id: 0, name: &#x27;Raphael&#x27;, phone: &#x27;9999 0000&#x27;, city: &#x27;Recife&#x27;, address: &#x27;Rua da Aurora&#x27; },
    { id: 1, name: &#x27;Donatello&#x27;, phone: &#x27;9876 1234&#x27;, city: &#x27;Olinda&#x27;, address: &#x27;Rua do Carmo&#x27; },
  ];
}</code></pre>
<p>Componente do cartão colapsável de contato:</p>
<pre><code>&lt;div class=&quot;card&quot;&gt;
  &lt;div class=&quot;card-header&quot;&gt;
    &lt;h3&gt;{{ card.name }}&lt;/h3&gt;
    &lt;span class=&quot;show-button&quot; (click)=&quot;toggleShow()&quot;&gt;{{ isShown ? &#x27;Hide&#x27; : &#x27;Show&#x27; }}&lt;/span&gt;
  &lt;/div&gt;
  &lt;card-content *ngIf=&quot;isShown&quot; [card]=&quot;card&quot;&gt;&lt;/card-content&gt;
&lt;/div&gt;</code></pre>
<p>Agora vamos fazer a mesma interface com componentes dinâmicos. Precisamos criar um <em>container</em> para receber o componente montado dinamicamente, e para isso uma diretiva que nos permita manipulá-lo no nosso <em>typescript</em>.</p>
<pre><code>import { Directive, ViewContainerRef } from &#x27;@angular/core&#x27;;

@Directive({ selector: &#x27;[dynamicComponentLoader]&#x27; })
export class DynamicComponentLoaderDirective {
  constructor(public viewContainerRef: ViewContainerRef) {}
}</code></pre>
<p>Por fim, o código que cria e insere o componente dinâmico, controlado pelo botão de mostrar/esconder:</p>
<pre><code>import { Component, Input, ViewChild } from &#x27;@angular/core&#x27;;
import { CardContentComponent } from &#x27;../card-content/card-content.component&#x27;;
import { Card } from &#x27;../card.model&#x27;;
import { DynamicComponentLoaderDirective } from &#x27;../dinamic-loader.directive&#x27;;

@Component({
  selector: &#x27;app-card&#x27;,
  templateUrl: &#x27;./card.component.html&#x27;,
  styleUrls: [&#x27;./card.component.css&#x27;],
})
export class CardComponent {
  @Input() card!: Card;
  isShown = false;

  @ViewChild(DynamicComponentLoaderDirective, { static: true })
  dynamicCardContent!: DynamicComponentLoaderDirective;

  toggleShow(): void {
    this.isShown = !this.isShown;
    this.clearDynamicContent();
    if (this.isShown) this.createDynamicContent(this.card);
  }

  clearDynamicContent() {
    this.dynamicCardContent.viewContainerRef.clear();
  }

  createDynamicContent(card: Card): void {
    const ref = this.dynamicCardContent.viewContainerRef.createComponent(CardContentComponent);
    ref.instance.card = card;
  }
}</code></pre>
<h3>Conclusão</h3>
<p>Apesar da complexidade necessária para implementar essa gambi… ops, essa MANOBRA TÉCNICA, o ganho de desempenho ao iniciar uma tela pode ser muito grande dependendo da quantidade e complexidade de componentes. Com certeza é uma técnica que vale a pena ter na caixa de ferramentas.</p>
<h3>Referências</h3>
<p><a href="https://angular.io/guide/dynamic-component-loader" target="_blank" rel="noopener">Dynamic Component Loader — Angular docs</a></p>$RP$, 'a2222222-2222-2222-2222-222222222222', true, '2022-09-27')
on conflict (slug) do nothing;

insert into vagas (titulo, tags, link, ativo, ordem) values
  ($RP$Pessoa Desenvolvedora Back-end$RP$, ARRAY[$RP$Node.js / Go$RP$,$RP$Remoto$RP$,$RP$Pleno / Sênior$RP$], $RP$https://SUA-PLATAFORMA/vaga/back-end$RP$, true, 1),
  ($RP$Pessoa Desenvolvedora Front-end$RP$, ARRAY[$RP$React$RP$,$RP$Remoto$RP$,$RP$Pleno$RP$], $RP$https://SUA-PLATAFORMA/vaga/front-end$RP$, true, 2),
  ($RP$Analista de Compliance$RP$, ARRAY[$RP$Mercado regulado$RP$,$RP$Híbrido · Recife$RP$,$RP$Pleno / Sênior$RP$], $RP$https://SUA-PLATAFORMA/vaga/compliance$RP$, true, 3)
on conflict do nothing;

insert into redes_sociais (rede, ativo, url, ordem) values
  ($RP$linkedin$RP$, true, $RP$https://www.linkedin.com/company/redepos$RP$, 1),
  ($RP$instagram$RP$, true, $RP$https://www.instagram.com/redepos_/$RP$, 2),
  ($RP$email$RP$, true, $RP$contato@redepos.com.br$RP$, 3),
  ($RP$whatsapp$RP$, false, $RP$$RP$, 4),
  ($RP$facebook$RP$, false, $RP$$RP$, 5),
  ($RP$x$RP$, false, $RP$$RP$, 6),
  ($RP$youtube$RP$, false, $RP$$RP$, 7),
  ($RP$tiktok$RP$, false, $RP$$RP$, 8)
on conflict (rede) do nothing;

insert into form_campos (label, name, tipo, obrigatorio, placeholder, ordem) values
  ($RP$Nome$RP$, $RP$nome$RP$, $RP$text$RP$, true, $RP$Seu nome$RP$, 1),
  ($RP$E-mail$RP$, $RP$email$RP$, $RP$email$RP$, true, $RP$voce@empresa.com$RP$, 2),
  ($RP$Empresa$RP$, $RP$empresa$RP$, $RP$text$RP$, false, $RP$Sua empresa$RP$, 3),
  ($RP$Mensagem$RP$, $RP$mensagem$RP$, $RP$textarea$RP$, true, $RP$Conte o seu desafio...$RP$, 4)
on conflict do nothing;

insert into form_assuntos (assunto, ordem) values
  ($RP$Quero uma plataforma / solução$RP$, 1),
  ($RP$Parceria comercial$RP$, 2),
  ($RP$Banco de talentos$RP$, 3),
  ($RP$Outro assunto$RP$, 4)
on conflict do nothing;

insert into config (id, form_action, form_method, banco_ativo, banco_titulo, banco_texto, banco_link) values
  (1, $RP$$RP$, $RP$POST$RP$, true, $RP$Não encontrou sua vaga?$RP$, $RP$Entre para o nosso banco de talentos — adoramos conhecer gente boa antes da hora.$RP$, $RP$https://SUA-PLATAFORMA/banco-de-talentos$RP$)
on conflict (id) do update set
  form_action=excluded.form_action, banco_texto=excluded.banco_texto, banco_link=excluded.banco_link;

-- ============================================================
--  SUPER ADMIN
--  1) Crie o usuário em Authentication > Users (e-mail abaixo + senha).
--  2) Rode o comando abaixo (já preenchido). Se o usuário ainda não
--     existir, ele não faz nada (sem erro) — rode de novo depois de criar.
-- ============================================================
insert into perfis (id, nome, role)
select id, 'Designer RedePOS', 'super_admin'
  from auth.users where email = 'designer3@redepos.com.br'
on conflict (id) do update set role = 'super_admin';
