# Configuração do Codemagic para RatoNet

## 📋 Problema Resolvido

O Codemagic não estava detectando automaticamente o projeto iOS. Isso foi resolvido criando um arquivo `codemagic.yaml` na raiz do projeto.

## ✅ Arquivos Criados

1. **`codemagic.yaml`** - Configuração principal do workflow
2. **`exportOptions.plist`** - Opções de exportação do IPA
3. **`docs/CODEMAGIC_SETUP.md`** - Esta documentação

## 🚀 Como Usar no Codemagic

### Passo 1: Fazer Push dos Arquivos

Certifique-se de que os arquivos estão no repositório:

```bash
git add codemagic.yaml exportOptions.plist
git commit -m "Adicionar configuração do Codemagic"
git push origin main
```

### Passo 2: Configurar no Codemagic

1. **Acesse o Codemagic**: https://codemagic.io/
2. **Vá para seu projeto** (ou crie um novo)
3. **Na tela de configuração**:
   - **Project path**: Deixe como `.` (raiz do repositório)
   - **Select branch**: Selecione `main` (ou sua branch principal)
   - **Clique em "Set type manually"**
   - **Selecione**: "Native iOS"
   - **Clique em "Finish"**

### Passo 3: Configurar Code Signing (Opcional)

Se você quiser fazer build com code signing:

1. **No Codemagic**, vá para **App settings** > **Code signing**
2. **Adicione seus certificados**:
   - Certificado de distribuição
   - Provisioning profile
   - Ou use **Automatic code signing**

### Passo 4: Executar Build

1. **Vá para a aba "Builds"**
2. **Clique em "Start new build"**
3. **Selecione a branch** e **workflow** (`ios-workflow`)
4. **Clique em "Start build"**

## 📝 Configuração do codemagic.yaml

O arquivo `codemagic.yaml` está configurado com:

- **Workflow**: `ios-workflow`
- **Instance**: `mac_mini_m1` (pode mudar para `mac_pro` se necessário)
- **Xcode**: Versão mais recente
- **Scheme**: `RatoNet`
- **Workspace**: `RatoNet.xcodeproj`

### Variáveis Configuráveis

Você pode ajustar no Codemagic UI ou no arquivo:

- `XCODE_WORKSPACE`: Caminho do projeto Xcode
- `XCODE_SCHEME`: Scheme a ser usado
- `BUNDLE_ID`: Bundle identifier do app
- `APP_ID`: App ID (se tiver)

## 🔧 Personalizações

### Mudar Tipo de Instância

Se precisar de mais poder de processamento:

```yaml
instance_type: mac_pro  # ou mac_mini_m1
```

### Adicionar Code Signing

1. **No Codemagic UI**:
   - Vá para **App settings** > **Code signing**
   - Adicione seus certificados

2. **No codemagic.yaml**, descomente e ajuste:

```yaml
- name: Set up code signing settings on Xcode project
  script: |
    xcode-project use-profiles
```

### Publicar no App Store Connect

Descomente e configure a seção `publishing`:

```yaml
publishing:
  app_store_connect:
    auth: integration
    submit_to_testflight: true
    beta_groups:
      - Testers
```

## 🐛 Troubleshooting

### Erro: "Scheme not found"

**Solução**: Verifique se o scheme `RatoNet` existe no projeto:
```bash
xcodebuild -list -project RatoNet.xcodeproj
```

### Erro: "Code signing required"

**Solução**: 
- Configure code signing no Codemagic UI
- Ou ajuste o `exportOptions.plist` para usar `development` ou `ad-hoc`

### Erro: "Build timeout"

**Solução**: Aumente o `max_build_duration` no `codemagic.yaml`:
```yaml
max_build_duration: 180  # minutos
```

### Erro: "Dependencies not found"

**Solução**: O projeto usa Swift Package Manager. O Codemagic deve resolver automaticamente, mas você pode adicionar:

```yaml
scripts:
  - name: Resolve Swift packages
    script: |
      xcodebuild -resolvePackageDependencies -project RatoNet.xcodeproj -scheme RatoNet
```

## 📊 Monitoramento

Após configurar, você pode:

1. **Ver builds**: Aba "Builds" no Codemagic
2. **Ver logs**: Clique em um build para ver logs detalhados
3. **Baixar artefatos**: IPA e dSYM após build bem-sucedido
4. **Configurar notificações**: Email/Slack quando build completar

## 🔗 Recursos

- [Documentação do Codemagic](https://docs.codemagic.io/)
- [Configuração iOS no Codemagic](https://docs.codemagic.io/yaml/building/yaml-setting-up/)
- [Code Signing no Codemagic](https://docs.codemagic.io/code-signing/ios-code-signing/)

## 💡 Dicas

1. **Primeiro build**: Pode demorar mais (download de dependências)
2. **Cache**: O Codemagic cacheia dependências para builds subsequentes
3. **TestFlight**: Configure se quiser distribuir via TestFlight
4. **Notificações**: Configure email/Slack para ser notificado dos builds

## ✅ Checklist

- [ ] Arquivo `codemagic.yaml` criado
- [ ] Arquivo `exportOptions.plist` criado
- [ ] Push feito para o repositório
- [ ] Projeto configurado no Codemagic
- [ ] Tipo definido como "Native iOS"
- [ ] Code signing configurado (se necessário)
- [ ] Primeiro build executado com sucesso

