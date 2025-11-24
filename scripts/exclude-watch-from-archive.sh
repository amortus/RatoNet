#!/bin/bash
# Script para excluir temporariamente o RatoNetWatch do archive
# Isso resolve o conflito de arquivos de saída

set -e

PROJECT_FILE="RatoNet.xcodeproj/project.pbxproj"
BACKUP_FILE="${PROJECT_FILE}.backup"

echo "Excluindo RatoNetWatch do archive..."

# Fazer backup
cp "$PROJECT_FILE" "$BACKUP_FILE"

# Remover a dependência do RatoNetWatch do target RatoNet
# Procurar pela linha que adiciona RatoNetWatch como dependência
# e comentá-la temporariamente

# Esta é uma solução temporária - em produção, você deveria
# criar um scheme separado sem o Watch app

echo "Backup criado: $BACKUP_FILE"
echo "Nota: Este script precisa ser ajustado para modificar o project.pbxproj corretamente"


