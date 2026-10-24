# claude-orquestrar

Skill do Claude Code (`/orquestrar`) para um fluxo de trabalho em camadas:

- **O Opus organiza e revisa.** Ele quebra o trabalho, escreve specs, escolhe o modelo de cada tarefa, revisa os diffs,
  compila, testa e commita.
- **Modelos menores implementam.** Cada tarefa vai para o modelo mais barato que dá conta dela. A tabela abaixo mostra
  qual agente faz o quê.
- **Para subir de modelo, é preciso justificar.** Um agente não troca para um modelo maior por conta própria. Ele escreve
  um "Escalation request" e o orquestrador decide.

O objetivo é gastar o modelo caro só onde ele faz diferença: coordenar, julgar e revisar.

## O que vem no repositório

```
skill/
  SKILL.md                      # o workflow (papéis, regra de economia, fluxo, evolução)
  referencia/
    spec-template.md            # modelo de spec para implementadores
    checklist-revisao.md        # o que o orquestrador confere em cada entrega
    paralelismo.md              # worktrees, armadilhas, integração
    licoes.md                   # lições aprendidas, acrescentadas a cada sessão
agents/
  scout.md                      # Haiku: buscas/leituras, sem edição
  implementer-lite.md           # Haiku: edições mecânicas totalmente especificadas
  implementer.md                # Sonnet: código não trivial a partir de spec
install.ps1 / install.sh        # instalação no perfil do usuário
CHANGELOG.md
```

## Instalação

```powershell
git clone https://github.com/sovern/claude-orquestrar.git
cd claude-orquestrar
powershell -ExecutionPolicy Bypass -File install.ps1   # Windows
# ou: sh install.sh                                    # macOS/Linux
```

O instalador faz duas coisas:

- **A skill é um link para o clone.** Ele cria `~/.claude/skills/orquestrar` como junction no Windows ou symlink no
  macOS/Linux. Por isso, quando o Claude evolui a skill, ele está editando o próprio repositório, e basta commitar e
  dar push.
- **Os agentes são copiados.** Ele copia `agents/*.md` para `~/.claude/agents/`. Depois de um `git pull`, rode o
  instalador de novo para sincronizá-los.

Os agentes só carregam numa **sessão nova** do Claude Code. Enquanto isso, a skill manda usar `general-purpose` com o
parâmetro `model` e colar as regras no prompt.

## Uso

Digite `/orquestrar` ou peça para "delegar", "paralelizar", "soltar tarefas" ou "orquestrar agentes".

Para que o workflow valha sempre num projeto, registre isso na memória ou no `CLAUDE.md` do projeto. Por exemplo:
"neste projeto, siga a skill orquestrar".

### Implementador externo (opcional)

Se você tem um CLI de agente de código, como o `muse`, declare-o na memória ou no `CLAUDE.md` do projeto, com o
comando e as flags. Enquanto ele tiver cota, a skill dá prioridade a ele e não aos subagentes do Claude. Os
subagentes ficam como reserva.

## Como os modelos são escolhidos

| Trabalho | Agente | Modelo |
|---|---|---|
| Achar arquivo, símbolo, call site, linha; ler trecho conhecido | `scout` | Haiku |
| Aplicar um padrão já definido (listas, dados, edições repetitivas) | `implementer-lite` | Haiku |
| Código que exige raciocínio (refactor, lógica nova, depuração) | `implementer` | Sonnet |
| Coordenar, decidir, revisar, integrar | orquestrador | Opus |

Opus em subagente só com justificativa explícita.

## Evolução

A skill se atualiza a cada sessão em que é usada:

1. A lição nova entra em `skill/referencia/licoes.md`.
2. Se a lição muda o fluxo, o Claude ajusta `SKILL.md` ou o checklist.
3. A mudança é registrada no `CHANGELOG.md`.
4. O Claude commita e dá push no repositório.

Veja a seção "Evolução da skill" em `skill/SKILL.md`.

Clone local do autor: `E:\Projects\claude-orquestrar`.
