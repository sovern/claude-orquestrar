# Paralelismo com worktrees

## Regra
Uma tarefa paralela = um `git worktree` + um branch. Dois implementadores no mesmo working tree conflitam em arquivos
e em builds incrementais.

```bash
git worktree add -b <branch> ../<repo>-<tarefa> HEAD
```

## Armadilhas
- **Arquivos ignorados não vêm no worktree** (assets grandes, mapas, `config` local, chaves). Copie-os do checkout
  principal logo após criar o worktree, ou o build/boot falha de jeitos confusos.
- **Scripts de build com caminho fixo** (`cd /d C:\repo`): gere uma cópia por worktree com o caminho trocado.
  Cuidado com CRLF ao substituir texto (abra em modo binário).
- **Build do zero por worktree** é lento na primeira vez; reutilize caches/diretórios de dependências compartilhados
  (ex. `VCPKG_INSTALLED_DIR`) quando o sistema de build permitir.
- **Builds simultâneos** competem por CPU e disco com o dono: veja "Carga" em `delegar.md`.
- **Stash é compartilhado** entre worktrees: nunca `git stash` puro; prefira commit WIP.
- **Integração:** commite no branch do worktree, faça `rebase` sobre o branch principal, rode build/testes, e traga com
  `cherry-pick`. Se o branch principal está sendo editado por outro implementador, só faça cherry-pick quando não houver
  sobreposição de arquivos com o trabalho em andamento — ou espere ele terminar.
- **Conflito no cherry-pick** quando dois branches mexeram na mesma função: não cole os dois lados. Use a
  versão mais nova como base, reaplique nela a intenção do outro lado e confira com um diff contra a base.
- **Limpeza**, só depois de confirmar que o trabalho foi integrado: `git -C <dir> status --short` sem
  alterações pendentes e o commit presente no branch principal (`git branch --contains <commit>`). Então
  `git worktree remove <dir>` (sem `--force`) e `git branch -d <branch>` (`-d`, que recusa apagar branch não
  integrado). Use `--force`/`-D` só se o usuário confirmar que o que sobrou pode ser descartado.

- **Depois de todo merge:** `git diff --name-only --diff-filter=U` inteiro, `grep -rn '^<<<<<<<'` no repo e build.
  Dois branches que acrescentam itens numa lista de tamanho limitado (ex. tupla de sistemas) estouram só na soma.
  Número absurdo depois do merge (0 testes) é quebra, não resultado.
- **Arquivos gerados no merge:** textos (ARB/JSON) pela união das chaves a partir dos estágios (`git show :2:` /
  `:3:`); código gerado e imagens: fique com o principal e regenere; depois procure chave duplicada.
- **Frentes que se consomem:** a frente consumidora ganha um teste de cobertura contra o contrato da outra (tipos de
  evento, IDs, chaves); rode a suíte depois do merge, não só em cada branch.
