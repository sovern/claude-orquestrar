# Instala a skill /orquestrar e os agentes no perfil do usuário do Claude Code.
# - A skill é ligada por junction ao clone: editar a skill instalada = editar o repositório.
# - Os agentes são copiados (rode de novo para sincronizar depois de um pull).
# Uso: powershell -ExecutionPolicy Bypass -File install.ps1

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $MyInvocation.MyCommand.Path
$claude = Join-Path $env:USERPROFILE '.claude'
$skills = Join-Path $claude 'skills'
$agents = Join-Path $claude 'agents'
New-Item -ItemType Directory -Force $skills, $agents | Out-Null

$skillLink = Join-Path $skills 'orquestrar'
if (Test-Path $skillLink) {
    $item = Get-Item $skillLink -Force
    if ($item.LinkType -ne 'Junction') {
        throw "$skillLink existe e não é junction; mova-o antes de instalar."
    }
} else {
    New-Item -ItemType Junction -Path $skillLink -Target (Join-Path $repo 'skill') | Out-Null
}

Get-ChildItem (Join-Path $repo 'agents') -Filter *.md | ForEach-Object {
    Copy-Item $_.FullName (Join-Path $agents $_.Name) -Force
}

Write-Host "Skill: $skillLink -> $(Join-Path $repo 'skill')"
Write-Host "Agentes copiados para: $agents"
Write-Host "Abra uma nova sessão do Claude Code para os agentes carregarem."
