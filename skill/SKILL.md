---
name: orquestrar
description: Workflow de orquestração em camadas. O Opus organiza, delega, revisa, testa e commita; quem implementa são agentes menores, escolhidos pela complexidade (Haiku para buscas e trabalho mecânico, Sonnet para código de verdade) ou um implementador externo (ex. muse) quando houver cota. Use quando o usuário pedir para delegar, paralelizar, "soltar tarefas", orquestrar agentes, economizar modelo, ou digitar /orquestrar. Também deve ser seguida em qualquer trabalho de várias frentes num projeto onde a memória diga que este workflow vale.
---

# /orquestrar: Opus organiza, agentes menores implementam

## Papéis

| Papel | Quem | Faz | Não faz |
|---|---|---|---|
| Orquestrador | o modelo principal (Opus) | quebra o trabalho, escreve specs, escolhe o modelo de cada tarefa, revisa diffs, compila, roda testes/smokes, commita, conversa com o usuário | implementar peças grandes (correções pequenas de revisão são ok) |
| Implementador externo | CLI configurado no projeto (ex. `muse`) | implementa a partir de uma spec | commitar |
| `implementer` | Sonnet | código não trivial seguindo spec | commitar, subir de modelo por conta própria |
| `implementer-lite` | Haiku | edições mecânicas totalmente especificadas | decisões de design |
| `scout` | Haiku | buscas e leituras: arquivos, símbolos, call sites, linhas | editar, opinar |

**Prioridade de implementador:** se o projeto declara um implementador externo (memória ou CLAUDE.md) e ele tem cota,
ele substitui os agentes `implementer`/`implementer-lite`. Os subagentes do Claude são o fallback enquanto o externo
estiver indisponível. O papel do orquestrador não muda.

## Regra de economia (inegociável)

1. Toda tarefa e subtarefa começa avaliando se um modelo **menor** resolve. Busca e leitura sem raciocínio → `scout`.
   Padrão repetitivo já definido → `implementer-lite`. Só o que exige raciocínio de código → `implementer`.
2. Nenhum agente sobe de modelo sozinho. Se achar que precisa, para essa parte e escreve no relatório final uma seção
   **"Escalation request"** com o motivo concreto (o que tentou, por que está além dele). O orquestrador julga e só
   então relança com modelo maior — ou quebra a tarefa em partes menores.
3. O orquestrador também não usa Opus em subagente sem justificar para si mesmo por que Sonnet não basta.

## Fluxo

1. **Mapear antes de especificar.** Dispare `scout`/`Explore` (Haiku) em paralelo para levantar fatos com `arquivo:linha`.
   Nunca leia o repositório inteiro no contexto do orquestrador.
2. **Decisões do usuário.** Junte as perguntas que mudam escopo e faça de uma vez (AskUserQuestion), com a opção
   recomendada primeiro. Decisões com default óbvio: decida, registre na spec e avise.
3. **Spec por tarefa** (modelo em `referencia/spec-template.md`): objetivo, fatos verificados com `arquivo:linha`,
   requisitos numerados, restrições, verificação exata, entregável. Guarde a spec no repositório do projeto.
4. **Isolamento.** Uma tarefa paralela = um git worktree + um branch. Nunca dois implementadores no mesmo working tree.
   Veja `referencia/paralelismo.md` (arquivos ignorados, scripts de build com caminho fixo, builds simultâneos).
5. **Escolher o modelo** de cada tarefa e dizer ao usuário por quê (uma linha por tarefa).
6. **Delegar** em background. O prompt do implementador inclui: caminho absoluto da spec, worktree, o que não tocar,
   as regras do agente (ou o tipo de agente), "não commitar", e — se houver trabalho parcial — "audite o parcial
   contra a spec, não descarte, não recomece às cegas".
7. **Revisar** cada entrega com `referencia/checklist-revisao.md`. Leia o diff de verdade; não confie no relatório.
8. **Verificar você mesmo:** build, testes, smokes. Números medidos, não estimados.
9. **Commitar** (o orquestrador), integrar branches (cherry-pick/rebase), remover worktrees, atualizar o handoff do projeto.
10. **Reportar** ao usuário: o que ficou pronto, o que você corrigiu na revisão, o que não foi verificado, o que depende dele.

## Agentes customizados

Os tipos `scout`, `implementer`, `implementer-lite` ficam em `~/.claude/agents/` (instalados por este repositório).
Agentes criados no meio de uma sessão **só carregam na próxima sessão**; até lá use `general-purpose` com o parâmetro
`model` (`haiku`/`sonnet`) e cole no prompt as regras do arquivo do agente.

## Evolução da skill (a cada sessão)

Esta skill aprende. Ao fim de cada sessão em que foi usada (ou quando algo der errado/certo de forma instrutiva):

1. Acrescente a lição em `referencia/licoes.md` (data, contexto em uma linha, lição, como aplicar). Generalize: nada
   específico de um projeto, a menos que seja um exemplo.
2. Se a lição muda o fluxo, ajuste este `SKILL.md` ou o checklist.
3. Registre no `CHANGELOG.md` da raiz do repositório.
4. Commite e faça push no repositório da skill. O caminho do clone está no `README.md` (instalação por junction/symlink:
   editar a skill instalada é editar o clone). Se não houver acesso, avise o usuário que há mudanças locais pendentes.

Não infle a skill: prefira mover detalhe para `referencia/` e manter este arquivo curto.
