# Changelog

## 2026-10-25 — v1.3

- Evolução da skill ganhou o passo 0: antes de alterar, reler a skill inteira procurando repetição,
  conflito entre regras e conteúdo perigoso.
- Lições 17–20: subagentes morrem com a sessão; UI exige teste rodando; a ferramenta de observação altera o
  que observa; conflito de cherry-pick em função editada em paralelo.
- Primeira revisão com o passo 0. Ela achou e corrigiu:
  - limpeza de worktree com `--force` e `branch -D` sem salvaguarda (`paralelismo.md`); agora só depois de
    confirmar a integração, com `-d` e sem `--force`;
  - lição 17 repetia a 7, e lição 20 era uma regra de integração fora do guia: foram enxugadas, e a regra de
    conflito foi para `paralelismo.md`;
  - lições de 2026-10-25 estavam sob o cabeçalho de 2026-10-24;
  - o v1.3 não tinha entrada neste changelog quando as lições 17–20 foram publicadas.

## 2026-10-24 — v1.2

- Lições 15–16: não mudar o escopo de um implementador em execução; fatiar tarefas grandes.

## 2026-10-24 — v1.1

- Lições 13–14: fonte citada sem ter sido lida; testes do implementador ocupando recursos fixos.
- Checklist de revisão ganhou a seção "Procedência".

## 2026-10-24 — v1

- A skill `/orquestrar` define os papéis (o orquestrador Opus, um implementador externo opcional, `implementer`,
  `implementer-lite` e `scout`), a regra de economia de modelo com "Escalation request" e o fluxo em 10 passos.
- Referências: modelo de spec, checklist de revisão e guia de paralelismo com worktrees.
- `referencia/licoes.md` traz 12 lições da sessão inicial, cujo projeto de exemplo é o Canary/OTClient single-player.
- Agentes `scout` e `implementer-lite` (Haiku) e `implementer` (Sonnet).
- Instaladores para Windows (junction) e para macOS/Linux (symlink).
