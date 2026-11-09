---
name: orquestrar
description: Workflow de orquestração em camadas. O Opus organiza, delega, revisa, testa e commita; quem implementa são agentes menores, escolhidos pela complexidade (Haiku para buscas e trabalho mecânico, Sonnet para código de verdade) ou um implementador externo (ex. muse) quando houver cota. Use quando o usuário pedir para delegar, paralelizar, "soltar tarefas", orquestrar agentes, economizar modelo, ou digitar /orquestrar. Também deve ser seguida em qualquer trabalho de várias frentes num projeto onde a memória diga que este workflow vale.
---

# /orquestrar: Opus organiza, agentes menores implementam

## Papéis

| Papel | Quem | Faz | Não faz |
|---|---|---|---|
| Orquestrador | o modelo principal (Opus) | fatia, escreve specs, escolhe modelo, revisa diffs, compila, testa, commita, fala com o usuário | implementar peças grandes (correção pequena de revisão pode) |
| Implementador externo | CLI do projeto (ex. `muse`) | implementa a partir da spec | commitar |
| `implementer` | Sonnet | código não trivial seguindo spec | commitar, subir de modelo sozinho |
| `implementer-lite` | Haiku | edição mecânica totalmente especificada | decidir design |
| `scout` | Haiku | buscas e leituras com `arquivo:linha` | editar, opinar |

Implementador externo declarado no projeto (memória ou CLAUDE.md) e com cota substitui `implementer`/`implementer-lite`;
os subagentes ficam de reserva.

Agentes criados no meio da sessão só carregam na próxima; até lá, `general-purpose` com `model` (`haiku`/`sonnet`) e
as regras do arquivo do agente coladas no prompt.

## Economia (inegociável)

1. Toda tarefa começa pelo modelo menor que resolve: leitura → `scout`; padrão definido → `implementer-lite`;
   raciocínio de código → `implementer`.
2. Ninguém sobe de modelo sozinho: o agente para a parte e escreve "Escalation request" com o motivo; o orquestrador
   julga, relança maior ou fatia mais.
3. Opus em subagente só com justificativa de por que Sonnet não basta.

## Fluxo

1. **Mapear.** `scout`/`Explore` em paralelo levantam fatos com `arquivo:linha`; não leia o repositório inteiro.
2. **Decisões do usuário.** Perguntas que mudam escopo, todas de uma vez, recomendada primeiro. Default óbvio: decida,
   registre na spec, avise.
3. **Fatiar, depois especificar.** Menor tarefa que entrega algo verificável sozinha: uma área ou poucos arquivos, um
   teste ou medida própria, principal verde depois dela. Na dúvida, divida. Refatoração grande por estrangulamento
   (caminho único primeiro, depois uma família por tarefa). Tabela "tarefa → depende de" diz o que roda em paralelo.
   Spec por tarefa (`referencia/spec-template.md`), guardada no repositório do projeto.
4. **Isolar.** Uma tarefa paralela = um worktree + um branch (`referencia/paralelismo.md`).
5. **Escolher o modelo** de cada tarefa e dizer ao usuário por quê, uma linha cada.
6. **Delegar e vigiar** em background: leia `referencia/delegar.md` antes do primeiro lançamento (prompt, vigia de
   término no mesmo passo, monitoramento, correção de rumo).
7. **Revisar** com `referencia/checklist-revisao.md`, lendo o diff; o relatório é alegação.
8. **Verificar você mesmo:** build, testes, smokes, capturas. Número medido pelo método da spec.
9. **Integrar:** commit (o orquestrador), merge, conferência de conflito, worktree removido, handoff do projeto.
10. **Reportar:** pronto, corrigido na revisão, não verificado, o que depende do usuário.

## Evolução da skill

Ao fim de sessão em que algo deu errado ou certo de forma instrutiva, siga `referencia/evolucao.md`.

Este arquivo carrega em toda sessão: detalhe vai para `referencia/`.
