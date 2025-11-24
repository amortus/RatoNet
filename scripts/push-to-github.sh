#!/bin/bash
# Script para fazer commit e push do projeto RatoNet para GitHub

set -e

echo "=== Push do RatoNet para GitHub ==="
echo ""

# Navegar para o diretório raiz do projeto
cd "$(dirname "$0")/.." || exit 1

echo "1. Verificando remote atual..."
git remote -v
echo ""

echo "2. Configurando remote para https://github.com/amortus/RatoNet.git..."
git remote set-url origin https://github.com/amortus/RatoNet.git 2>/dev/null || \
git remote add origin https://github.com/amortus/RatoNet.git
echo ""

echo "3. Verificando status do git..."
git status --short
echo ""

echo "4. Adicionando todos os arquivos modificados..."
git add -A
echo ""

echo "5. Verificando arquivos staged..."
git status --short
echo ""

echo "6. Fazendo commit..."
git commit -m "feat: renomear projeto de Moblin para RatoNet

- Renomeado todos os arquivos, diretórios e referências de Moblin para RatoNet
- Atualizado bundle identifiers, app groups e URL schemes
- Mantida compatibilidade com comandos !moblin e !ratonet no chat bot
- Atualizado README, documentação e configurações
- Adicionado suporte dual para comandos de chat bot (!moblin e !ratonet)
- Atualizado deep links de moblin:// para ratonet://
- Mantidos CodingKeys antigos para compatibilidade com dados salvos
- Adicionados documentos de análise e troubleshooting"
echo ""

echo "7. Verificando branch atual..."
BRANCH=$(git branch --show-current 2>/dev/null || git rev-parse --abbrev-ref HEAD)
echo "Branch: $BRANCH"
echo ""

echo "8. Fazendo push para origin/$BRANCH..."
git push -u origin "$BRANCH"
echo ""

echo "=== Concluído! ==="
echo "Repositório: https://github.com/amortus/RatoNet"

