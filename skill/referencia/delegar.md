# Delegar e vigiar (passo 6)

Prompt do implementador: caminho absoluto da spec e do worktree, o que não tocar (proibições repetidas no prompt, não
só na spec), regras do agente, "não commitar"; havendo parcial, "audite contra a spec, não descarte, não recomece às
cegas".

- **Vigia no lançamento**, sempre: no mesmo passo, uma espera única em background que sai sozinha quando o processo
  termina (PID ou linha de saída no log). Nada de laço infinito (vira órfão; no fim do lote, procure e encerre os que
  sobraram). Confira o log no primeiro minuto: implementador que nem arrancou parece "concluído".
- **Monitorar** três sinais: linhas novas na mailbox, `git diff --stat` e saída do processo. A mailbox sozinha engana
  (nome errado, agente que para de escrever). Tudo parado por muito tempo = travado. Monitor rearmado reimprime linhas
  antigas: compare o horário com o do lançamento.
- **Corrigir rumo** pela caixa de entrada da spec, que o agente relê entre passos; confira o `ack` na saída. Escopo
  novo no meio da execução vira tarefa nova (reabrir trabalho multiplica o tempo). Adendo relevante vai também para o
  arquivo da spec (sobrevive à queda da sessão).
- **Carga:** implementadores em paralelo dividem a máquina com o dono. Com o dono usando o PC, poucos de cada vez e em
  prioridade baixa (`nice`/`ionice`, ou `Start-Process -Priority`).
