# Changelog

## 2026-11-02 — v1.8

- Lições 29–30: verificar UI percorrendo o fluxo com gancho de depuração (não só DOM estático); `git commit -F` em vez de `-m` com aspas no PowerShell 5.1.

## 2026-11-02 — v1.7

- Lições 27–28: encerrar processos de teste do implementador; cache de módulos e service worker antigo mascarando a versão nova num app web.
- Revisão do passo 0: não repetem a 25 (implementador que não iniciou) nem a 23 (bug só no aparelho).

## 2026-11-02 — v1.6

- Lições 25–26: confirmar que o implementador externo de fato iniciou (log no primeiro minuto); rastrear todo
  outlier medido até a causa antes de classificá-lo.
- Revisão do passo 0: as lições novas não repetem a 8 (caminho da spec), a 12 (medir, não estimar) nem as 21–24,
  que tratam de outra coisa; nenhum conflito ou conteúdo perigoso encontrado.

## 2026-10-27 — v1.5

- Lição 17 ampliada (encerrar com subagentes no meio: pare, escreva o handoff, commit WIP), sem duplicar.
- Lições 21–24: conflitos em arquivos gerados, teste de UI por texto frágil, bug só no aparelho, campo composto sob
  "último vence" por campo. Checklist ganhou "Armadilhas recorrentes".
- Revisão do passo 0: a lição nova sobre subagentes repetia a 17 e foi fundida nela; sem conflito com o fluxo; nada
  perigoso adicionado (sem comandos destrutivos, segredos ou caminhos pessoais).

## 2026-10-26 — v1.4

- Spec ganha a seção "Progress mailbox": o implementador anota o progresso num arquivo a cada ~10 min e a
  cada marco.
- Fluxo, passo 6: o orquestrador monitora cada tarefa em background com uma checagem periódica da mailbox
  e do diff. Implementador externo headless não recebe mensagens no meio da execução.
- Revisão do passo 0: sem repetição ou conflito com as regras existentes; nada perigoso adicionado.

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
