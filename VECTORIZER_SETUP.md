# Configuração do RatoNet no Vectorizer

## ✅ Configuração Adicionada

O projeto RatoNet foi adicionado ao arquivo `vectorize-workspace.yml` com as seguintes coleções:

### Coleções Criadas

1. **ratonet-docs** - Documentação e guias
2. **ratonet-source-main** - Código Swift do app principal
3. **ratonet-source-common** - Código compartilhado
4. **ratonet-source-watch** - App Apple Watch
5. **ratonet-source-widget** - Widget extension
6. **ratonet-source-screen-recording** - Screen Recording extension
7. **ratonet-tests** - Testes
8. **ratonet-config** - Arquivos de configuração
9. **ratonet-utils** - Scripts Python

## 🔄 Como Fazer as Coleções Aparecerem

Se as coleções não aparecerem no Vectorizer GUI, tente:

### 1. Recarregar o Workspace
- No Vectorizer GUI, vá em **Configuration** ou **Workspace**
- Clique em **Reload** ou **Refresh** para recarregar o workspace
- Ou reinicie o Vectorizer completamente

### 2. Verificar o Caminho
O caminho está configurado como:
```yaml
path: "E:/PROJETOS/Vectorizer/RatoNet"
```

Se o projeto estiver em outro local, ajuste o caminho no arquivo `vectorize-workspace.yml`.

### 3. Verificar Sintaxe YAML
O arquivo deve estar com sintaxe YAML válida. Verifique se:
- A indentação está correta (espaços, não tabs)
- Todas as chaves estão fechadas
- Não há caracteres especiais problemáticos

### 4. Verificar Permissões
Certifique-se de que o Vectorizer tem permissão para acessar o diretório do projeto.

### 5. Verificar Logs
Verifique os logs do Vectorizer para ver se há erros ao carregar o workspace:
- Vá em **Logs** no Vectorizer GUI
- Procure por erros relacionados a "ratonet" ou "workspace"

## 📝 Estrutura do Projeto

O projeto está organizado da seguinte forma:
```
RatoNet/
├── docs/                    # Documentação
├── RatoNet/                 # App principal (Swift)
├── Common/                  # Código compartilhado
├── RatoNet Watch/           # App Watch
├── RatoNet Widget/          # Widget extension
├── RatoNet Screen Recording/ # Screen Recording extension
├── RatoNetTests/            # Testes
├── utils/                   # Scripts Python
└── RatoNet.xcodeproj/       # Projeto Xcode
```

## 🔍 Troubleshooting

Se as coleções ainda não aparecerem:

1. **Verifique se o arquivo foi salvo corretamente**
   - O arquivo `vectorize-workspace.yml` deve estar no diretório raiz do Vectorizer

2. **Verifique o caminho do projeto**
   - O caminho deve ser absoluto ou relativo ao diretório do workspace
   - No Windows, use formato: `E:/PROJETOS/Vectorizer/RatoNet`

3. **Reinicie o Vectorizer**
   - Feche completamente o Vectorizer
   - Abra novamente
   - As coleções devem aparecer após o reload

4. **Verifique se há arquivos para indexar**
   - Certifique-se de que existem arquivos que correspondem aos padrões de include
   - Por exemplo, verifique se há arquivos `.swift` em `RatoNet/**/*.swift`

## 📊 Status das Coleções

Após o reload, você deve ver 9 novas coleções no Vectorizer:
- ratonet-docs
- ratonet-source-main
- ratonet-source-common
- ratonet-source-watch
- ratonet-source-widget
- ratonet-source-screen-recording
- ratonet-tests
- ratonet-config
- ratonet-utils

