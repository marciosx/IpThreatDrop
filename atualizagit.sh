#!/bin/bash
#
# push_github.sh — Commit e push automático para o repositório IpThreatDrop
#
# Uso: ./push_github.sh
#      ./push_github.sh "Mensagem customizada"
#

set -e

# ==============================================
# CONFIGURAÇÕES
# ==============================================
REPO_DIR="$HOME/GitHub/IpThreatDrop"
BRANCH="main"
REMOTE="origin"
DEFAULT_MSG="Atualização automática - $(date '+%Y-%m-%d %H:%M')"

# ==============================================
# CORES
# ==============================================
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

log()   { echo -e "${CYAN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"; }
ok()    { echo -e "${GREEN}✅ $1${NC}"; }
warn()  { echo -e "${YELLOW}⚠️  $1${NC}"; }
erro()  { echo -e "${RED}❌ $1${NC}"; }

# ==============================================
# HEADER
# ==============================================
echo ""
echo "=================================================="
echo "  PUSH AUTOMÁTICO — IpThreatDrop"
echo "=================================================="
echo "  Repo:    $REPO_DIR"
echo "  Branch:  $BRANCH"
echo "  Remote:  $REMOTE"
echo "  Data:    $(date '+%Y-%m-%d %H:%M:%S')"
echo "=================================================="
echo ""

# ==============================================
# VERIFICAÇÕES
# ==============================================
if [ ! -d "$REPO_DIR" ]; then
    erro "Diretório não encontrado: $REPO_DIR"
    exit 1
fi

cd "$REPO_DIR"

if [ ! -d ".git" ]; then
    erro "Não é um repositório Git: $REPO_DIR"
    exit 1
fi

# ==============================================
# DEFINE MENSAGEM
# ==============================================
if [ -n "$1" ]; then
    MSG="$1"
else
    MSG="$DEFAULT_MSG"
fi

log "Mensagem do commit: $MSG"
echo ""

# ==============================================
# 1) GIT ADD
# ==============================================
log "Executando 'git add .'..."
git add .
ok "Arquivos adicionados"
echo ""

# ==============================================
# 2) GIT STATUS
# ==============================================
log "Executando 'git status'..."
echo ""
git status
echo ""

# ==============================================
# 3) VERIFICA SE HÁ MUDANÇAS
# ==============================================
if git diff --cached --quiet; then
    warn "Nenhuma mudança para commitar. Nada a fazer."
    exit 0
fi

# ==============================================
# 4) GIT COMMIT
# ==============================================
log "Executando 'git commit'..."
git commit -m "$MSG"
ok "Commit realizado"
echo ""

# ==============================================
# 5) GIT PUSH
# ==============================================
log "Executando 'git push'..."

# Verifica se a branch tem upstream configurado
if git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
    git push "$REMOTE" "$BRANCH"
    ok "Push realizado"
else
    warn "Branch '$BRANCH' sem upstream configurado. Configurando..."
    git push --set-upstream "$REMOTE" "$BRANCH"
    ok "Push realizado + upstream configurado"
fi

echo ""
echo "=================================================="
ok "PIPELINE CONCLUÍDO COM SUCESSO"
echo "=================================================="
echo ""

exit 0
