#!/bin/bash
# Script para instalar Swift no Windows via WSL
# Alternativa para usuários que preferem WSL

set -e

echo "=== Instalação do Swift via WSL ==="
echo ""

# Verificar se está no WSL
if [[ ! -f /proc/version ]] || ! grep -q Microsoft /proc/version; then
    echo "⚠️  Este script é para WSL. Para Windows nativo, use install-swift-windows.ps1"
    exit 1
fi

echo "1. Atualizando pacotes..."
sudo apt-get update

echo ""
echo "2. Instalando dependências..."
sudo apt-get install -y \
    binutils \
    git \
    gnupg2 \
    libc6-dev \
    libcurl4 \
    libedit2 \
    libgcc-9-dev \
    libpython3.8 \
    libsqlite3-0 \
    libstdc++-9-dev \
    libxml2 \
    libz3-dev \
    pkg-config \
    tzdata \
    uuid-dev \
    zlib1g-dev

echo ""
echo "3. Baixando Swift para Linux..."
SWIFT_VERSION="5.9"
SWIFT_URL="https://swift.org/builds/swift-${SWIFT_VERSION}-release/ubuntu2004/swift-${SWIFT_VERSION}-RELEASE/swift-${SWIFT_VERSION}-RELEASE-ubuntu20.04.tar.gz"
SWIFT_DIR="$HOME/swift"
SWIFT_TAR="$HOME/swift.tar.gz"

mkdir -p "$SWIFT_DIR"
cd "$HOME"

if [ ! -f "$SWIFT_TAR" ]; then
    echo "   Baixando Swift ${SWIFT_VERSION}..."
    wget "$SWIFT_URL" -O "$SWIFT_TAR"
else
    echo "   Arquivo já existe, pulando download..."
fi

echo ""
echo "4. Extraindo Swift..."
tar -xzf "$SWIFT_TAR" -C "$SWIFT_DIR" --strip-components=1

echo ""
echo "5. Adicionando ao PATH..."
if ! grep -q "swift/bin" "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/swift/usr/bin:$PATH"' >> "$HOME/.bashrc"
    export PATH="$HOME/swift/usr/bin:$PATH"
    echo "   ✅ PATH atualizado no .bashrc"
else
    echo "   ✅ PATH já configurado"
fi

echo ""
echo "6. Verificando instalação..."
source "$HOME/.bashrc" 2>/dev/null || true
swift --version

echo ""
echo "=== Instalação concluída! ==="
echo ""
echo "📝 Próximos passos:"
echo "   1. Feche e reabra o terminal WSL"
echo "   2. Execute: swift --version"
echo "   3. Teste criando um projeto: swift package init --type executable"
echo ""
echo "⚠️  Lembre-se: Swift no Linux/WSL NÃO inclui UIKit ou frameworks iOS."
echo "   Para desenvolvimento iOS completo, você precisa de um Mac com Xcode."

