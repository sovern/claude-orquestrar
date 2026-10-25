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
17. **Subagentes morrem com a sessão que os criou.** Quando a sessão anterior caiu, três implementadores pararam
    no meio de um comando, sem relatório final. Os adendos de escopo que tinham ido só por mensagem se perderam
    junto. · Todo adendo relevante vai também para o arquivo da spec. Ao retomar, o novo implementador recebe
    "audite o que existe na worktree e termine", nunca "comece".
18. **"Compila" não é "funciona" em código de UI.** Um módulo de cliente compilou, mas nunca abria a janela: o
    layout só definia o estilo e não criava a instância. · Em entregas de UI, exija um teste rodando, mesmo
    mínimo. Sem como ver a tela, ponha log temporário nos pontos do fluxo (enviar, receber, abrir) e leia o log
    antes de pedir o teste ao usuário.
19. **A ferramenta de observação altera o que observa.** O espectador GM invisível contava como "humano por
    perto". Isso disparava a regra anti-humano dos bots, que fugiam por teleporte, e o espectador ia atrás em
    loop. · Ao criar ferramenta de debug ou observação, verifique que regras do sistema observado ela aciona.
    Observadores precisam ser invisíveis também para a lógica, não só na tela.
20. **Cherry-pick de branches paralelos que tocam a mesma função.** Não resolva o conflito colando os dois
    lados. Escolha a versão mais nova como base e reaplique nela a intenção do outro lado. Depois confira com
    um diff contra a base que a região bate.
