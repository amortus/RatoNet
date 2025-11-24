# Troubleshooting: Coleções do RatoNet não aparecem no Vectorizer

## ✅ Mudanças Realizadas

1. **Caminho ajustado para formato WSL**: O caminho foi alterado de `E:/PROJETOS/Vectorizer/RatoNet` para `/mnt/e/PROJETOS/Vectorizer/RatoNet` (formato WSL, igual ao projeto "tos-server")

2. **Configuração verificada**: O arquivo `vectorize-workspace.yml` está correto com 9 coleções definidas

## 🔄 Como Fazer as Coleções Aparecerem

### Opção 1: Reiniciar o Vectorizer (Recomendado)
1. Feche completamente o Vectorizer GUI
2. Abra novamente o Vectorizer
3. As coleções devem aparecer automaticamente após o carregamento

### Opção 2: Verificar se o caminho está correto
O caminho no `vectorize-workspace.yml` está configurado como:
```yaml
path: "/mnt/e/PROJETOS/Vectorizer/RatoNet"
```

**Importante**: Se o Vectorizer estiver rodando em Windows (não WSL), o caminho pode precisar ser:
```yaml
path: "E:/PROJETOS/Vectorizer/RatoNet"
```

### Opção 3: Verificar logs do Vectorizer
1. Abra o Vectorizer GUI
2. Vá para a seção **Logs** ou **Console**
3. Procure por mensagens relacionadas a:
   - "ratonet"
   - "workspace"
   - "Failed to load"
   - "No workspace config found"

### Opção 4: Verificar se o arquivo está no local correto
O arquivo `vectorize-workspace.yml` deve estar no diretório raiz do Vectorizer:
```
E:\PROJETOS\Vectorizer\vectorize-workspace.yml
```

## 📋 Coleções Configuradas

As seguintes 9 coleções foram adicionadas:

1. **ratonet-docs** - Documentação e guias
2. **ratonet-source-main** - Código Swift do app principal
3. **ratonet-source-common** - Código compartilhado
4. **ratonet-source-watch** - App Apple Watch
5. **ratonet-source-widget** - Widget extension
6. **ratonet-source-screen-recording** - Screen Recording extension
7. **ratonet-tests** - Testes
8. **ratonet-config** - Arquivos de configuração
9. **ratonet-utils** - Scripts Python

## 🔍 Verificações Adicionais

### 1. Verificar sintaxe YAML
Execute o comando para validar:
```bash
python3 -c "import yaml; yaml.safe_load(open('vectorize-workspace.yml', 'r', encoding='utf-8'))"
```

### 2. Verificar se o diretório existe
No WSL:
```bash
ls -la /mnt/e/PROJETOS/Vectorizer/RatoNet
```

No Windows:
```powershell
Test-Path "E:\PROJETOS\Vectorizer\RatoNet"
```

### 3. Verificar permissões
Certifique-se de que o Vectorizer tem permissão para ler o diretório do projeto.

## 🐛 Problemas Comuns

### Problema: "No workspace config found"
**Solução**: Verifique se o arquivo `vectorize-workspace.yml` está no diretório raiz do Vectorizer.

### Problema: "Path not found"
**Solução**: 
- Se o Vectorizer roda em WSL, use formato: `/mnt/e/PROJETOS/Vectorizer/RatoNet`
- Se o Vectorizer roda em Windows, use formato: `E:/PROJETOS/Vectorizer/RatoNet`

### Problema: "YAML parse error"
**Solução**: Verifique a sintaxe do arquivo YAML, especialmente a indentação (deve usar espaços, não tabs).

## 📝 Próximos Passos

Após as coleções aparecerem:
1. As coleções precisarão ser indexadas pela primeira vez
2. Isso pode levar alguns minutos dependendo do tamanho do projeto
3. Você pode verificar o progresso na interface do Vectorizer

