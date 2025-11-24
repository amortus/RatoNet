#!/bin/bash
# Script para modificar temporariamente o PRODUCT_NAME do RatoNetWatch
# Isso resolve o conflito de arquivos de saída durante o build

set -e

PROJECT_FILE="RatoNet.xcodeproj/project.pbxproj"
BACKUP_FILE="${PROJECT_FILE}.backup"

echo "Ajustando PRODUCT_NAME do RatoNetWatch para evitar conflito..."

# Fazer backup
if [ ! -f "$BACKUP_FILE" ]; then
    cp "$PROJECT_FILE" "$BACKUP_FILE"
    echo "Backup criado: $BACKUP_FILE"
fi

# Modificar PRODUCT_NAME do RatoNetWatch de "RatoNet" para "RatoNetWatchApp"
# Apenas nas seções que têm SDKROOT = watchos (que identifica o Watch app)
# Usando Python para fazer a substituição de forma mais precisa
python3 << 'PYTHON_SCRIPT'
import re

project_file = "RatoNet.xcodeproj/project.pbxproj"

with open(project_file, 'r') as f:
    content = f.read()

# Padrão: encontrar PRODUCT_NAME = RatoNet; que está antes de SDKROOT = watchos;
# Isso identifica especificamente o RatoNetWatch
pattern = r'(PRODUCT_NAME = RatoNet;\s+SDKROOT = watchos;)'
replacement = r'PRODUCT_NAME = RatoNetWatchApp;\n\t\t\t\tSDKROOT = watchos;'

modified_content = re.sub(pattern, replacement, content)

if modified_content != content:
    with open(project_file, 'w') as f:
        f.write(modified_content)
    print("✅ PRODUCT_NAME do RatoNetWatch modificado de 'RatoNet' para 'RatoNetWatchApp'")
else:
    print("⚠️  Não foi possível modificar o PRODUCT_NAME (pode já estar modificado)")
PYTHON_SCRIPT

echo "Script concluído"

