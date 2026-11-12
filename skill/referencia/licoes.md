# Lições

Regras que não cabem no fluxo (`SKILL.md`), no checklist, no `paralelismo.md` nem no `spec-template.md`. Uma regra
curta por item, agrupadas por assunto. O que virou regra num desses arquivos sai daqui.

## Retomada e sessão
- Subagente morre com a sessão. Tarefa longa: prefira o implementador externo destacado. Encerrando com subagentes no
  meio: pare-os, escreva o handoff no ticket e faça commit WIP no branch de cada um. Cota do externo acabou: subagentes
  com o prompt "audite o parcial".

## Verificação de UI e jogos
- "Compila" não é "funciona": percorra o fluxo real (clique/tecla → tela seguinte). Exija nas specs um gancho de
  depuração (estado exposto, avanço manual do tempo, roteiro de teclas e capturas com semente fixa).
- Proíba automação de janela (SendKeys, foco) na máquina do dono: o roteiro do app é o único jeito de dirigi-lo.
- Ferramenta de observação não pode acionar regra do sistema observado (espectador que conta como jogador).
- Antes de usar uma ferramenta de comparação como régua, rode-a duas vezes no principal: diferença grande entre
  rodadas iguais é defeito da ferramenta (ex. semente que não era exportada), não ruído a tolerar.
- Roteiro por tempo de relógio diverge sob carga: comparação de capturas só vale em tela estática; o comportamento fica
  nos testes. Prefira roteiro por quadro.
- Smoke que falha às vezes: rode de novo antes de culpar o merge; registre como instável e abra tarefa para torná-lo
  determinístico.
- App web sem build: dev com `Cache-Control: no-store`; service worker novo limpa o cache e recarrega as abas. "Não
  funciona" do dono: leia o log do servidor (os 404 mostram a versão carregada).

## Medição
- Meça antes de mexer e diga onde está o tempo (o gargalo pedido pode ser outro, ex. linker em vez do jogo).
- Outlier medido é rastreado até a causa antes de virar achado; depois de corrigir, meça de novo.
- Duas rodadas sem acertar um alvo de qualidade visual: leve ao dono cancelar ou trocar de abordagem.

## Implementador
- Testes dele não usam recurso fixo (porta, arquivo) que o orquestrador usa; servidor ou processo de teste é
  encerrado antes de terminar (confira quem escuta a porta antes de verificar).
- Unificação "de brinde" (texto que passou a aparecer, caminho escondido atrás de função) é desvio: o ticket manda.

## Windows
- Caminho com `\` dentro de heredoc ou string de script vira caractere de controle (`\t`, `\a`, `\v`): escreva o
  arquivo com a ferramenta de escrita, ou use `/`. Script que gera arquivo com caminho (prompt, script de build)
  monta a barra em código (`chr(92)`, `os.path.join`), nunca em `sed` ou literal. Depois de gerar, procure
  `[\x00-\x08\x0b\x0c\x0e-\x1f]`. Reincidiu em três sessões seguidas.
- `git commit -m` com aspas no PowerShell 5.1 quebra: `git commit -F <arquivo>`.
- Lance o CLI externo pelo shell onde ele resolve (`.cmd` não roda pelo Git Bash).
