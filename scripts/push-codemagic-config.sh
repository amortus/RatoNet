#!/bin/bash
# Script para fazer push da configuração do Codemagic

set -e

cd "$(dirname "$0")/.." || exit 1

echo "=== Push da Configuração do Codemagic ==="
echo ""

echo "1. Verificando status do git..."
git status --short
echo ""

echo "2. Adicionando arquivos do Codemagic..."
git add codemagic.yaml exportOptions.plist docs/CODEMAGIC_SETUP.md
echo ""

echo "3. Verificando arquivos staged..."
git status --short
echo ""

echo "4. Fazendo commit..."
git commit -m "feat: adicionar configuração do Codemagic CI/CD

- Adicionado codemagic.yaml com workflow para build iOS
- Adicionado exportOptions.plist para exportação de IPA
- Configurado para projeto Xcode nativo (RatoNet)
- Suporte para Swift Package Manager
- Documentação completa em docs/CODEMAGIC_SETUP.md"
echo ""

echo "5. Verificando remote..."
git remote -v
echo ""

echo "6. Fazendo push..."
BRANCH=$(git branch --show-current 2>/dev/null || git rev-parse --abbrev-ref HEAD)
echo "Branch: $BRANCH"
git push origin "$BRANCH"
echo ""

echo "=== Concluído! ==="
echo ""
echo "✅ Arquivos enviados para o repositório"
echo "📝 Próximo passo: Configure o projeto no Codemagic"
echo "   - Vá para: https://codemagic.io/"
echo "   - Selecione o projeto"
echo "   - Clique em 'Set type manually'"
echo "   - Selecione 'Native iOS'"
echo "   - Clique em 'Finish'"

