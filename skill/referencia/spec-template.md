# Modelo de spec para implementador

Copie, preencha e salve no repositório do projeto (ex. `docs/tasks/<id>.md`). Specs boas são o que permite usar um
modelo menor: quanto mais fato verificado e menos ambiguidade, mais barato o implementador pode ser.

```markdown
# Task <ID> — <título curto>

Repositório/worktree: `<caminho absoluto>` (branch `<branch>`). Outros agentes trabalham em `<outros caminhos>`;
não toque neles.
Leia antes: <docs de design/ADRs relevantes>.

## Goal
<1 parágrafo: o resultado observável para o usuário.>

## Facts (verificados em <data>; verifique de novo)
- <fato> (`arquivo:linha`)
- <limitações/armadilhas já conhecidas>

## Decisions (já tomadas pelo dono; implemente)
1. <decisão + parâmetros/defaults>

## Requirements
1. <requisito verificável>
2. ...

## Constraints
- Estilo do código ao redor; comentários mínimos; sem refactors não relacionados.
- <o que é proibido: schema, protocolo, serviços externos, dados reais do usuário>
- Não commitar.

## Verify
1. Build: `<comando exato>` — zero erros.
2. Testes: `<comando>`.
3. Verificação ao vivo em estado descartável: `<como>`; remova tudo depois.

## Deliverable
Relatório conciso: arquivos alterados, decisões de design, saídas da verificação, o que não foi verificado, riscos,
"Escalation request" se houver.
```

Dicas:
- Coloque números de linha aproximados (`~1234`): poupam buscas do implementador.
- Separe "Facts" de "Decisions": o implementador não deve rediscutir decisões.
- Diga explicitamente o que **não** verificar com serviços reais (ex. "não suba o banco de produção").
- Para retomar trabalho interrompido, ponha um cabeçalho: "há um parcial no working tree; audite, não descarte, não
  recomece às cegas".
