# Changelog

## 2026-11-12 — v2.2

- `spec-template.md`: Constraints dizem quem depende de quem e mandam propor, não contornar, quando falta algo na
  interface; dicas novas: primeiro quadro x regime na medição, conferir fórmula e custo que a própria spec dita, prova
  de falha de cada teste novo.
- `checklist-revisao.md`: contorno de interface e teste que passa por construção.
- `delegar.md`: "nunca `git stash`" no prompt; três ou quatro implementadores externos por vez.
- `paralelismo.md`: lista que tarefas paralelas estendem, um item por linha; como resolver conflito nela.
- `licoes.md`: caminho do Windows em script gerado monta a barra em código (reincidiu de novo).

## 2026-11-09 — v2.1

- Lição: régua de comparação rodada duas vezes no principal antes de usar (a semente não exportada fez um dia
  inteiro de "ruído").

## 2026-11-09 — v2.0 (compactação)

- `SKILL.md` virou o mapa das etapas (7,6 KB → 3,7 KB); o detalhe é lido na etapa: `referencia/delegar.md` (passo 6:
  prompt, vigia de término, monitoramento, correção de rumo, carga) e `referencia/evolucao.md` (fim de sessão).
- `licoes.md` de 43 lições cronológicas (16,5 KB) para regras curtas por assunto (2,6 KB). Saiu o que já era regra em
  outro arquivo (checklist: transações, encoding, finais de linha, procedência, armadilhas; paralelismo: ignorados,
  cherry-pick; fluxo: fatiar, vigia, mailbox, escopo em execução, caminhos absolutos, agentes novos).
- Para o lugar onde são lidas: conferência de conflito depois do merge, arquivos gerados e teste de contrato →
  `paralelismo.md`; número da spec e método de medição → `spec-template.md`.
- Regra velha: "builds simultâneos, tudo bem" virou limite de carga com o dono usando a máquina. Caminho pessoal do
  clone saiu do README; o passo de push acha o clone pelo link da skill.
- Texto não aponta mais para lição por número (a numeração saiu).

## 2026-11-09 — v1.13

- Passo 3 vira "fatiar, depois especificar": menor tarefa verificável sozinha, estrangulamento em refatoração grande,
  tabela de dependências (promove a lição 16 a regra do fluxo).
- Passo 6: vigia de término armada no mesmo passo do lançamento, sem exceção para implementador externo (lição 43).
- Revisão do passo 0: as lições 16, 35 e 41 diziam o mesmo em forma de lição; agora o fluxo aponta para elas, sem
  repetir o texto; sem conflito; nada perigoso adicionado.

## 2026-11-09 — v1.12

- Mailbox de duas mãos: a spec ganha caixa de entrada que o implementador relê entre passos, inclusive o externo
  headless (lição 42). O passo 6 deixou de dizer que a spec é o único canal de ida.
- Licença: MIT ou WTFPL, à escolha de quem usa.
- Revisão do passo 0: a lição 15 (não mudar escopo em execução) limita a entrada a correção de rumo; a 35 (três
  sinais de monitoramento) continua valendo; sem repetição; nada perigoso adicionado.

## 2026-11-07 — v1.11

- Lições 38–41: método de medição na spec (janela visível só pedindo); conferir capturas você mesmo e oferecer
  cancelar depois de duas rodadas sem acertar; número da spec tem de bater com a lista; vigias órfãos.
- Lição 33 reincidiu: edição com caminho do Windows também pela ferramenta de edição de arquivo.
- Checklist de revisão: itens de captura e de medição.

## 2026-11-06 — v1.10

- Lições 33–37: caminho do Windows corrompido por escape; implementador automatizando o desktop do dono; monitor por
  mailbox + relatório + processo; medir o gargalo antes de otimizar (build vs. runtime); varrer conflitos e limites
  depois de merge.

## 2026-11-03 — v1.9

- Lições 31–32: teste de cobertura de contrato ao paralelizar frentes que se integram; smoke instável não é culpa do merge até reproduzir.

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
