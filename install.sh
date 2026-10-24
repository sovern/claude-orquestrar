#!/usr/bin/env sh
# Instala a skill /orquestrar e os agentes no perfil do usuário do Claude Code (macOS/Linux).
# A skill é um symlink para o clone (editar a instalada = editar o repositório); os agentes são copiados.
set -eu
repo=$(cd "$(dirname "$0")" && pwd)
claude="$HOME/.claude"
mkdir -p "$claude/skills" "$claude/agents"

link="$claude/skills/orquestrar"
if [ -e "$link" ] && [ ! -L "$link" ]; then
  echo "$link existe e não é symlink; mova-o antes de instalar." >&2
  exit 1
fi
[ -L "$link" ] || ln -s "$repo/skill" "$link"

cp "$repo"/agents/*.md "$claude/agents/"
echo "Skill: $link -> $repo/skill"
echo "Agentes copiados para: $claude/agents"
echo "Abra uma nova sessão do Claude Code para os agentes carregarem."
