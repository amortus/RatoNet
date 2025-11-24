# Opções para Build do RatoNet

## ❌ Build Local no Windows - Não Disponível

**Não é possível fazer build completo do app iOS no Windows** porque:
- Requer **Xcode** (disponível apenas no macOS)
- Requer **iOS SDK** e ferramentas de build da Apple
- Requer **Code signing** e certificados Apple

## ✅ Alternativas Disponíveis

### 1. **GitHub Actions (Recomendado - Gratuito)**

O projeto já tem um workflow configurado que faz build automaticamente:

**Arquivo**: `.github/workflows/all.yml`

**O que faz**:
- Executa em macOS (macos-26)
- Instala Xcode
- Faz linting e formatação
- Faz build do app
- Executa em cada push/PR

**Como usar**:
1. Faça push do código para o GitHub
2. O GitHub Actions executará automaticamente
3. Veja os resultados em: `Actions` tab no GitHub

**Comando de build usado**:
```bash
xcodebuild \
    -scheme RatoNet \
    -skipPackagePluginValidation \
    build \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO
```

### 2. **Mac Remoto / VM**

Se você tiver acesso a um Mac (físico, VM ou na nuvem):

```bash
# 1. Clonar o repositório
git clone https://github.com/amortus/RatoNet.git
cd RatoNet

# 2. Abrir no Xcode
open RatoNet.xcodeproj

# 3. Build via linha de comando
xcodebuild \
    -scheme RatoNet \
    -skipPackagePluginValidation \
    build \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO

# 4. Ou build para simulador
xcodebuild \
    -scheme RatoNet \
    -sdk iphonesimulator \
    -destination 'platform=iOS Simulator,name=iPhone 15' \
    build
```

### 3. **Serviços de Mac na Nuvem**

- **MacStadium**: https://www.macstadium.com/
- **MacinCloud**: https://www.macincloud.com/
- **AWS EC2 Mac**: https://aws.amazon.com/ec2/instance-types/mac/

### 4. **Validações que PODEM ser feitas no Windows**

#### A. Linting e Formatação (se tiver SwiftLint/SwiftFormat)
```bash
# Instalar SwiftLint (via Docker ou WSL)
docker run --rm -v "$PWD:/work" ghcr.io/realm/swiftlint:latest lint

# Ou usar SwiftFormat
swiftformat --lint RatoNet/
```

#### B. Validação de Sintaxe Swift (parcial)
```bash
# Instalar Swift para Windows
# https://swift.org/download/#windows
# Limitação: Não inclui UIKit, apenas Swift puro
```

#### C. Testes de Integração (APIs, etc.)
```bash
# Testar APIs REST
curl https://api.twitch.tv/...

# Testar WebSocket
# Usar ferramentas como Postman ou scripts Python
```

## 🚀 Como Fazer Build Agora

### Opção 1: Usar GitHub Actions (Mais Fácil)

1. **Fazer commit e push**:
```bash
git add .
git commit -m "Atualizações"
git push origin main
```

2. **Verificar build**:
   - Vá para: https://github.com/amortus/RatoNet/actions
   - Veja o workflow executando
   - Verifique se o build passou

### Opção 2: Trigger Manual do Workflow

Você pode criar um workflow que pode ser executado manualmente:

```yaml
name: Manual Build

on:
  workflow_dispatch:  # Permite execução manual

jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - uses: maxim-lobanov/setup-xcode@v1
        with:
          xcode-version: latest-stable
      - name: Build
        run: |
          xcodebuild \
              -scheme RatoNet \
              -skipPackagePluginValidation \
              build \
              CODE_SIGN_IDENTITY="" \
              CODE_SIGNING_REQUIRED=NO
```

## 📋 Checklist de Build

### ✅ O que PODE ser feito no Windows:
- [ ] Validação de código (linting via Docker/WSL)
- [ ] Testes de APIs e integrações
- [ ] Validação de JSON/configurações
- [ ] Análise estática de código
- [ ] Commit e push para GitHub (trigger GitHub Actions)

### ❌ O que NÃO pode ser feito no Windows:
- [ ] Build completo do app iOS
- [ ] Executar simulador iOS
- [ ] Testar em dispositivo real
- [ ] Gerar .ipa para distribuição

## 💡 Recomendação

**Para desenvolvimento ativo**: Use GitHub Actions para builds automatizados (gratuito e funciona bem).

**Para testes locais**: Considere um Mac (físico, VM ou na nuvem) para desenvolvimento completo.

## 🔗 Links Úteis

- [GitHub Actions para iOS](https://docs.github.com/en/actions/guides/building-and-testing-swift)
- [Xcode Command Line Tools](https://developer.apple.com/xcode/)
- [Swift para Windows](https://swift.org/download/#windows)

