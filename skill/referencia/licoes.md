# Lições aprendidas

Formato: **data — contexto** · lição · como aplicar. Mais recentes no fim. Generalize; cite projeto só como exemplo.

## 2026-10-24 — sessão inicial (projeto de exemplo: Canary/OTClient single-player)

1. **Implementador "corrige" o que não era bug.** Um `LIKE 'player%.x'` virou `'player.x'` porque o agente achou que
   `%` era escape. · Antes de aceitar uma "correção" de padrão existente, confira o formato real dos dados.
2. **I/O síncrono em laço no dispatcher.** Refresh de mercado fazia ~3000 escritas avulsas na thread do jogo (~51 s).
   Agrupar por fatia numa transação levou a ~0,2 s. · Procure laços com escrita no checklist de desempenho.
3. **Transação aninhada.** Envolver chamadas que já abrem transação própria quebra no SQLite. · Antes de embrulhar em
   transação, verifique o que as funções chamadas fazem.
4. **Copiar-e-apagar sem checagem = perda de dados.** "Renomear save" copiava a pasta e apagava a original sem ver se
   a cópia deu certo. · Renomeie metadados em vez de mover dados; nunca apague sem confirmar a cópia.
5. **Caminhos ANSI vs UTF-8 no Windows.** `std::filesystem::path::string()` converte para a code page; APIs como
   SQLite esperam UTF-8. · Use `u8string()` ao cruzar fronteiras de API.
6. **Implementador violou restrição explícita** (subiu MariaDB portátil apesar de proibido). · Revise restrições no
   checklist; repita a proibição no prompt, não só na spec.
7. **Cota do implementador externo esgotou no meio de 3 tarefas.** · Tenha fallback (subagentes) e prompt de retomada
   "audite o parcial, não descarte".
8. **Caminho relativo da spec** quebrou a execução do implementador externo (workspace diferente do cwd). · Sempre
   caminhos absolutos.
9. **Agentes customizados criados no meio da sessão não carregam** até a próxima sessão. · Use `general-purpose` com
   `model` e cole as regras no prompt.
10. **Reescrita de arquivo por script trocou finais de linha** (diff de 1600 linhas). · Leia/escreva em binário e
    preserve o terminador original; desconfie de diffs enormes.
11. **Worktree sem arquivos ignorados** (mapa de 189 MB) fez o boot falhar com erro enganoso. · Copie ignorados ao
    criar o worktree.
12. **Medir, não estimar.** Desempenho de população de bots nunca tinha sido medido acima de 4. · Peça tabela com
    números reais para cada escala relevante e defina o default a partir dela.
13. **Fonte citada sem ter sido lida.** O pesquisador não conseguiu acessar nenhuma fonte e mesmo assim pôs uma URL da wiki
    como fonte de 144 entradas montadas de memória. · Na spec de pesquisa, exija "cite só o que você de fato abriu; se
    nada abriu, marque `unverified`". Na revisão, cruze as fontes citadas com as que o relatório diz ter acessado.
14. **Testes do implementador ocupam recursos fixos** (porta 7171) e bloqueiam os smokes do orquestrador. · Na spec,
    mande o implementador usar portas ou recursos alternativos em todo estado descartável.
15. **Mudar o escopo de um implementador em execução custa caro.** Sete mensagens de escopo novo durante a mesma
    tarefa transformaram uma execução de cerca de 2 h em mais de 8 h. Cada mensagem reabria trabalho já feito.
    · Ideia nova durante a execução vira tarefa nova, enfileirada. Só interrompa para corrigir um rumo errado
    (bug, decisão invalidada).
16. **Tarefa grande demais para um único implementador.** Diagnóstico, calibração, grupos, desempenho e medição
    numa tarefa só fazem tudo rodar em série. · Fatie em tarefas de 1–2 h, cada uma com uma verificação curta
    própria. Use rodadas de medição curtas na iteração e deixe a rodada longa só para o fechamento.

## 2026-10-25 — mesma linha de trabalho, sessão retomada

17. **Subagentes morrem com a sessão que os criou.** Quando a sessão anterior caiu, três implementadores pararam
    no meio de um comando, sem relatório final. Os adendos de escopo que tinham ido só por mensagem se perderam
    junto. · Todo adendo relevante vai também para o arquivo da spec. Para retomar, vale a lição 7. Para tarefa
    longa, prefira o implementador externo destacado (serviço), que sobrevive à sessão. Se for preciso encerrar
    com subagentes no meio, não espere por eles: pare-os, escreva você mesmo o handoff no ticket e faça um commit
    WIP no branch de cada um.
18. **"Compila" não é "funciona" em código de UI.** Um módulo de cliente compilou, mas nunca abria a janela: o
    layout só definia o estilo e não criava a instância. · Em entregas de UI, exija um teste rodando, mesmo
    mínimo. Sem como ver a tela, ponha log temporário nos pontos do fluxo (enviar, receber, abrir) e leia o log
    antes de pedir o teste ao usuário.
19. **A ferramenta de observação altera o que observa.** O espectador GM invisível contava como "humano por
    perto". Isso disparava a regra anti-humano dos bots, que fugiam por teleporte, e o espectador ia atrás em
    loop. · Ao criar ferramenta de debug ou observação, verifique que regras do sistema observado ela aciona.
    Observadores precisam ser invisíveis também para a lógica, não só na tela.
20. **Cherry-pick de branches paralelos que tocam a mesma função.** Colar os dois lados do conflito teria
    misturado duas versões incompatíveis da ativação de party. · A regra está em `paralelismo.md`.

## 2026-10-27 — dez tickets em paralelo num app com sync (Flutter)

21. **Conflito de rebase em arquivos gerados.** Textos (ARB/JSON), código gerado e goldens conflitaram em quase todo
    merge paralelo. · Resolva o arquivo de textos pela união das chaves a partir dos estágios (`git show :2:` /
    `:3:`). Nos gerados e nas imagens, fique com a main e regenere. Depois confira chave duplicada e rode a suíte.
22. **Teste de interface que procura por texto quebra quando outro ticket renomeia um rótulo.** Uma aba renomeada
    fez três testes acharem a aba em vez do bloco. · Na spec, peça busca por chave, não por texto visível.
23. **Bug que só aparece no aparelho.** A confirmação de identidade remontava a tela no celular; o widget usava o
    estado depois do `await` e o recurso nunca ligava, mas a farsa do canal passava nos testes. · Antes de liberar,
    exercite no emulador/aparelho todo recurso que fala com a plataforma; na revisão, procure uso de estado do
    widget depois de `await` e capture tudo antes.
24. **Sync com "último vence" por campo e campo composto.** Um aparelho antigo que muda só o total deixa as partes
    somando outro valor. · Na revisão de campo novo que depende de outro, pergunte o que uma edição parcial vinda de
    versão antiga ou concorrente faz; a leitura tolera e degrada, nunca descarta o registro.

## 2026-11-02 — simulador de balanceamento num jogo web (implementador externo)

25. **O implementador externo nem chegou a rodar.** Lançado em background pelo Git Bash, o CLI (um `.cmd` do
    Windows) não estava no PATH. Saiu com 127 em segundos, e o "concluído" parecia sucesso. · Lance pelo shell
    onde o comando resolve (no Windows, PowerShell) e confira o log no primeiro minuto, antes de ir para outra frente.
26. **Número implausível passado adiante como "talvez legítimo".** O implementador mediu um boss de 16 mil HP
    morrendo em 0,0 s e deixou a dúvida no relatório. A primeira sonda achou um multiplicador composto e parou ali.
    Depois da correção, a nova medição mostrou o boss ainda morrendo em 0,5 s. A causa principal era outra: um
    projétil acertando o mesmo alvo em passos seguidos. · Todo outlier medido é rastreado até a causa antes de
    virar "bug" ou "achado". Sonde no passo exato do evento, registrando cada contribuição, não só a primeira
    suspeita. Depois de corrigir, meça de novo: a primeira causa plausível pode não ser a única.
27. **Processo de teste do implementador sobreviveu ao fim da tarefa.** O muse subiu um `http.server` para testar e
    não o encerrou. A sessão dele ficou presa e a porta, ocupada, respondendo conexões vazias ao orquestrador. · Na
    spec e no prompt, peça para encerrar todo servidor ou processo de teste antes de terminar. Antes de verificar,
    confira quem está escutando a porta (`Get-NetTCPConnection` + linha de comando do processo).
28. **Navegador mostrando código velho num app web sem build.** O `http.server` do Python deixa o navegador guardar
    módulos ES em cache, e o service worker da versão anterior (cache-first) serviu um `index.html` antigo que
    apontava para arquivos movidos. O dono viu "a nave não responde". · Num app web reorganizado, sirva o dev com
    `Cache-Control: no-store`. Se havia service worker, o novo precisa limpar o cache **e recarregar as abas**. Ao
    receber "não funciona" do dono, leia o log do servidor antes de mexer no código: os 404 mostram qual versão ele
    carregou.
29. **"Headless: DOM ok, zero erros" e o mapa quebrava ao abrir.** O implementador conferiu o HTML estático e os IDs. O
    erro só aparecia ao percorrer o fluxo: uma função limpava o contêiner com `innerHTML = ''` e apagava o `<svg>` que
    outra função usava logo depois. · Para UI, a verificação é percorrer o fluxo real (clique/tecla → tela seguinte). Dê
    ao app um gancho de depuração (estado exposto + avanço manual do tempo, que funciona com a aba oculta) e use-o na
    revisão. Exija esse gancho nas specs.
30. **Mensagem de commit com aspas some no PowerShell 5.1.** Uma here-string com `"..."` passada ao `git commit -m`
    foi quebrada em vários argumentos, e o git tentou tratá-los como caminhos. · Escreva a mensagem num arquivo e use
    `git commit -F <arquivo>` (ou commite pelo Bash).
31. **Duas frentes em paralelo e o merge quase silencioso.** O áudio (worktree) e as árvores (branch principal) mexeram
    no mesmo `main.js`. Os conflitos de texto eram triviais, mas a T10 criou 11 tipos de evento que o áudio não
    conhecia. Quem pegou foi um teste da T11 que extrai os tipos de evento do código da sim e exige som para cada um.
    · Ao paralelizar, peça à frente "consumidora" um teste de cobertura contra o contrato da outra (tipos de evento,
    IDs, chaves) e marque os pontos de integração com um comentário único (`// T11 áudio`) para o merge. Rode a suíte e
    o smoke depois do merge, não só em cada branch.
32. **Smoke de navegador com falha intermitente.** Um passo de "a bolha volta em 10 s" falhou 1 em 3 rodadas, sem
    relação com a mudança. · Antes de culpar o merge, rode o smoke de novo. Se falhar só às vezes, registre como
    instável no relatório e abra tarefa para tornar o passo determinístico (congelar o resto da sim, isolar a entidade).

## 2026-11-06 — jogo Rust/Bevy portado para o Windows, sete tickets (implementador externo + Opus na arte)

33. **Caminho do Windows atravessando heredoc e string do Python perdeu barras.** Quatro vezes na mesma sessão:
    `\t`, `\v`, `\b`, `\a` e `\r` de caminhos (`\tickets`, `\vstudo`, `\blender`, `\arena`, `\rico`) viraram
    caracteres de controle em prompts, no HANDOFF e no gerador de prompts. Um prompt quebrado chegou a ser lançado. ·
    Arquivo com caminho do Windows: escreva com a ferramenta de escrita de arquivo (texto exato), ou monte o caminho
    em código (`ntpath.join`, `chr(92)`), ou use `/`. Depois de gerar, procure caracteres de controle
    (`\x00-\x08\x0b\x0c\x0e-\x1f`) antes de usar o arquivo. Reincidiu no dia seguinte, num script Python que editava
    o HANDOFF (`\arena` virou `\x07rena`) e num `assert` com o texto escapado: edição de arquivo com caminho do Windows
    ou barra invertida vai pela ferramenta de edição de arquivo, não por string dentro de script.
34. **Implementador testou o jogo mandando teclas para o desktop do dono.** Sem ferramenta de automação no Windows, o
    muse usou `SendKeys`/`AppActivate`: puxou a janela para frente e digitou enquanto o dono usava o PC. · Proíba no
    prompt toda automação de janela. Dê ao app um roteiro próprio (variável de ambiente com teclas, capturas e saída,
    semente fixa) e faça dele o único jeito de dirigir o app. É a lição 29 aplicada a jogos: o gancho entra antes da
    primeira tarefa que precisa de captura.
35. **"Terminou?" pela mailbox engana.** Um implementador gravou a mailbox com outro nome (`42.md` em vez de
    `t42.md`). Outro parou de atualizar a mailbox enquanto trabalhava. Um terceiro terminou e o monitor só viu a
    mailbox. · Monitore três sinais: linhas novas na mailbox, arquivo de relatório e saída do processo (PID salvo no
    lançamento). Rearmado, o monitor reimprime linhas antigas: compare o horário com o do lançamento antes de agir.
36. **"Acelera a otimização" e o gargalo era outro.** O dono pediu para antecipar o ticket de performance porque o gate
    demorava. O jogo não era o lento: o rebuild incremental levava 134 s (linker e debuginfo) e cada worktree
    recompilava 370 dependências do zero. · Meça antes de mexer e diga ao dono onde está o tempo. Num projeto
    compilado: linker mais rápido, debuginfo reduzido só no crate que muda, e `target/` dos worktrees por hardlink
    só das dependências de terceiros (nunca dos crates do repo, que colidem). Aqui: rebuild 134 s → 17-28 s, primeiro
    gate de worktree novo de minutos → 38 s.
37. **Merge de dois branches deixou marca de conflito num arquivo que eu não vi.** Os dois acrescentaram testes no
    fim do mesmo módulo; o `git status` mostrava os conflitos que eu esperava, e o terceiro passou despercebido até a
    contagem de testes dar 0. Na mesma integração, cada branch acrescentou um sistema numa lista de tamanho limitado
    (20) e a soma estourou. · Depois de todo merge: `git diff --name-only --diff-filter=U` inteiro, `grep` por
    `^<<<<<<<` no repo e build. Um número absurdo (0 testes) é sinal de quebra, não de resultado.

## 2026-11-07 — mesmo jogo, dia longo: arte em lotes paralelos, som e logo gerados por IA, inventário

38. **Medição de custo inválida aceita duas vezes.** O implementador mediu o custo de quadro com a janela escondida,
    onde o sistema trava em 60 fps, e concluiu "sem regressão". O método válido estava no handoff do projeto, não na
    spec. · Ponha o método de medição na spec (como medir e o que invalida) e recuse número medido de outro jeito.
    Medição que precisa de janela visível na tela do dono: peça antes, ela aparece no monitor dele.
39. **O implementador julga mal as próprias capturas.** Num efeito visual (gel translúcido), o relatório dizia
    "silhueta densa, olhos nítidos" e o recorte ampliado mostrava o contrário; foram três rodadas até o dono cancelar.
    · Olhe as capturas você mesmo, ampliadas, lado a lado com o antes. Dê alvos numéricos já na primeira rodada.
    Depois de duas rodadas sem acertar um alvo de qualidade, leve ao dono a opção de cancelar ou trocar de abordagem
    em vez de uma terceira rodada igual.
40. **A spec dizia "14" e listava 12.** O plano contou errado os slots escolhidos pelo dono; o implementador inventou
    dois para fechar a conta, sem perguntar. · Antes de entregar uma spec, confira que todo número bate com a lista que
    ele resume. Se o implementador "completar" algo para casar com um número, trate como divergência na revisão.
41. **Vigias órfãos.** Um script de vigia em laço infinito por ticket continuou rodando depois que o monitor da
    ferramenta expirou: 35 processos acumulados em dois dias. · Para "me avise quando terminar", use uma espera única
    que sai sozinha (laço no PID, em background), não um laço infinito. No fim de cada lote, procure e encerre vigias
    que sobraram.

## 2026-11-09 — implementadores externos headless em paralelo (Rust/Bevy)

42. **Implementador headless sem canal de volta.** Corrigir rumo exigia matar o processo e recomeçar do zero. · Toda
    spec leva uma caixa de entrada que o agente relê entre passos (`spec-template.md`, "Mailbox"); o orquestrador
    escreve nela e confere o `ack` na saída. Vale só para correção de rumo (lição 15).
