# Checklist de revisão do orquestrador

Leia o diff real (`git diff`, arquivos novos inteiros). O relatório do implementador é uma alegação, não evidência.

## Correção
- [ ] Cada requisito da spec está implementado (marque item a item).
- [ ] "Correções" de padrões existentes eram mesmo bugs? (ex.: um `%` em `LIKE` que era curinga, não escape).
- [ ] Operações destrutivas checam sucesso antes de apagar (copiar-e-apagar, mover, sobrescrever).
- [ ] Transações: nada abre transação dentro de outra; o que precisa ser atômico está numa transação.
- [ ] Encoding de caminhos/strings: UTF-8 de ponta a ponta (no Windows, `path.string()` usa a code page ANSI).
- [ ] Comportamento antigo preservado onde a spec exige (ex.: SQL idêntico no backend antigo).
- [ ] Gating: o recurso só liga onde deve (flags/config), e o resto fica byte-idêntico.

## Desempenho
- [ ] Nada de I/O síncrono em laço na thread principal/dispatcher (agrupe em transação, fatie, ou mova para async).
- [ ] Laços por entidade (por jogador, por item, por bot) têm custo medido, não estimado.

## Restrições
- [ ] O implementador respeitou as proibições (não subiu serviços proibidos, não tocou dados reais, não mexeu em
      outros worktrees). Se violou, registre no relatório ao usuário e numa lição.
- [ ] Sem lixo: diretórios scratch, logs, arquivos temporários fora do `.gitignore`.
- [ ] Finais de linha e estilo preservados (diff com milhares de linhas = finais de linha trocados).

## Armadilhas recorrentes
- [ ] Widget usa `ref`/`context` depois de `await` (diálogo de identidade, navegação)? Capture tudo antes.
- [ ] Campo novo sincronizado que depende de outro (soma, total, referência): uma edição parcial vinda de versão antiga
      ou concorrente deixa o registro legível?
- [ ] Teste de interface acha elementos por chave, não por texto visível que outro ticket pode renomear.
- [ ] Recurso que fala com a plataforma (canal nativo, permissões) foi exercitado no emulador/aparelho, não só com farsa.

## Procedência (pesquisa)
- [ ] Cada fonte citada foi de fato acessada (bata com o que o relatório diz). Dado de memória é marcado `unverified`.

## Verificação
- [ ] Rode o build você mesmo.
- [ ] Rode os testes/smokes relevantes, incluindo uma regressão do caminho antigo.
- [ ] Liste ao usuário o que ficou sem verificação (ex.: cliques de UI).
