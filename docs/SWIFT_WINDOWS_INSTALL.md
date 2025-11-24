# Instalação do Swift no Windows

## 📋 Requisitos

- Windows 10/11
- PowerShell (como Administrador)
- Conexão com internet
- ~10GB de espaço livre (para Visual Studio)

## 🚀 Método 1: Instalação Nativa no Windows (Recomendado)

### Passo 1: Instalar Dependências

O Swift requer Visual Studio Community 2022 com componentes específicos:

```powershell
# Execute PowerShell como Administrador
winget install --id Microsoft.VisualStudio.2022.Community --exact --force --accept-package-agreements --accept-source-agreements --custom "--add Microsoft.VisualStudio.Component.Windows11SDK.22000 --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.VC.Tools.ARM64"
```

**Nota**: Esta instalação pode levar 30-60 minutos e requer ~10GB de espaço.

### Passo 2: Instalar Swift

```powershell
winget install --id Swift.Toolchain -e --accept-package-agreements --accept-source-agreements
```

### Passo 3: Verificar Instalação

Feche e reabra o terminal, depois execute:

```powershell
swift --version
```

Você deve ver algo como:
```
Swift version 5.9.0 (swift-5.9-RELEASE)
Target: x86_64-unknown-windows-msvc
```

## 🐧 Método 2: Via WSL (Windows Subsystem for Linux)

Se você prefere usar WSL:

### Passo 1: Instalar WSL (se ainda não tiver)

```powershell
wsl --install
```

### Passo 2: Instalar Swift no WSL

```bash
# No terminal WSL
sudo apt-get update
sudo apt-get install -y binutils git gnupg2 libc6-dev libcurl4 libedit2 libgcc-9-dev libpython3.8 libsqlite3-0 libstdc++-9-dev libxml2 libz3-dev pkg-config tzdata uuid-dev zlib1g-dev

# Baixar Swift
SWIFT_VERSION="5.9"
wget https://swift.org/builds/swift-${SWIFT_VERSION}-release/ubuntu2004/swift-${SWIFT_VERSION}-RELEASE/swift-${SWIFT_VERSION}-RELEASE-ubuntu20.04.tar.gz

# Extrair
tar -xzf swift-${SWIFT_VERSION}-RELEASE-ubuntu20.04.tar.gz
sudo mv swift-${SWIFT_VERSION}-RELEASE-ubuntu20.04 /opt/swift

# Adicionar ao PATH
echo 'export PATH="/opt/swift/usr/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Verificar
swift --version
```

## 📝 Scripts de Instalação Automática

O projeto inclui scripts para facilitar a instalação:

### Windows Nativo (PowerShell)
```powershell
# Execute como Administrador
.\scripts\install-swift-windows.ps1
```

### WSL (Bash)
```bash
chmod +x scripts/install-swift-windows.sh
./scripts/install-swift-windows.sh
```

## ✅ Verificar Instalação

Após a instalação, teste criando um projeto simples:

```bash
# Criar diretório de teste
mkdir swift-test
cd swift-test

# Inicializar projeto Swift
swift package init --type executable

# Executar
swift run
```

Você deve ver a saída:
```
Hello, world!
```

## 🎯 O que Você Pode Fazer com Swift no Windows

### ✅ Funcionalidades Disponíveis:
- Compilar código Swift puro
- Swift Package Manager
- Testes unitários
- Lógica de negócio sem dependências de plataforma
- Análise estática de código

### ❌ Limitações:
- **NÃO inclui UIKit** (apenas para macOS/iOS)
- **NÃO inclui AppKit** (apenas para macOS)
- **NÃO pode compilar apps iOS** (requer Xcode)
- **NÃO pode usar simuladores iOS**
- Frameworks específicos da Apple não estão disponíveis

## 🔧 Configuração do Editor

### Visual Studio Code

1. Instale a extensão Swift:
   - Abra VS Code
   - Vá para Extensions (Ctrl+Shift+X)
   - Procure por "Swift"
   - Instale a extensão oficial da Swift Server Work Group

2. Configure o caminho do Swift:
   ```json
   {
     "swift.path": "C:\\Library\\Developer\\Toolchains\\swift-latest.xctoolchain\\usr\\bin\\swift.exe"
   }
   ```

## 🐛 Troubleshooting

### Swift não encontrado após instalação

1. **Feche e reabra o terminal**
2. **Reinicie o computador** (garante que variáveis de ambiente sejam atualizadas)
3. **Verifique manualmente o PATH**:
   ```powershell
   $env:Path -split ';' | Select-String -Pattern "swift"
   ```
4. **Adicione manualmente ao PATH** se necessário:
   - Windows: `C:\Library\Developer\Toolchains\swift-latest.xctoolchain\usr\bin`
   - WSL: `/opt/swift/usr/bin` ou `$HOME/swift/usr/bin`

### Erro ao compilar: "cannot find -lFoundation"

Isso é esperado no Windows. Foundation não está completamente disponível. Use apenas Swift puro sem frameworks da Apple.

### Erro: "Visual Studio not found"

Certifique-se de que o Visual Studio Community 2022 está instalado com os componentes corretos:
- Windows 11 SDK (22000 ou superior)
- C++ build tools (x86, x64, ARM64)

## 📚 Recursos

- [Swift.org - Windows Installation](https://www.swift.org/install/windows/)
- [Swift Package Manager](https://www.swift.org/package-manager/)
- [Swift para Windows - GitHub](https://github.com/apple/swift)

## ⚠️ Importante

**Swift no Windows é útil para:**
- Desenvolver lógica de negócio multiplataforma
- Testar código Swift puro
- Aprender Swift sem precisar de Mac
- Desenvolver servidores e ferramentas de linha de comando

**Para desenvolvimento iOS completo, você ainda precisa:**
- Mac com Xcode
- Ou usar GitHub Actions (já configurado no projeto)
- Ou serviços de Mac na nuvem

## 🚀 Próximos Passos

Após instalar Swift:

1. **Teste a instalação** com um projeto simples
2. **Explore Swift Package Manager** para gerenciar dependências
3. **Considere usar GitHub Actions** para builds completos do app iOS
4. **Para desenvolvimento iOS ativo**, considere um Mac ou serviço na nuvem

