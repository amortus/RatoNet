#!/bin/bash
# Script para fazer commit e push do projeto RatoNet

cd "$(dirname "$0")/.." || exit 1

echo "=== Commit e Push do Projeto RatoNet ==="
echo ""

echo "1. Verificando status do git..."
git status --short
echo ""

echo "2. Adicionando todos os arquivos modificados..."
git add -A
echo ""

echo "3. Verificando arquivos staged..."
git status --short
echo ""

echo "4. Fazendo commit..."
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

echo "5. Fazendo push..."
git push
echo ""

echo "=== Concluído! ==="

