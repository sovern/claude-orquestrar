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
