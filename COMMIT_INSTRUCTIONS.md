# Instruções para Commit e Push

## Arquivo Modificado
- `vectorize-workspace.yml` - Adicionado projeto RatoNet com 9 coleções

## Comandos para Executar

Execute os seguintes comandos no diretório raiz do Vectorizer (`E:\PROJETOS\Vectorizer` ou `/mnt/e/PROJETOS/Vectorizer`):

```bash
# 1. Verificar status
git status

# 2. Adicionar arquivo modificado
git add vectorize-workspace.yml

# 3. Fazer commit
git commit -m "feat: adicionar projeto RatoNet ao vectorize-workspace.yml

- Adicionado projeto RatoNet com 9 coleções configuradas
- Caminho configurado para formato WSL: /mnt/e/PROJETOS/Vectorizer/RatoNet
- Coleções incluídas:
  - ratonet-docs: documentação
  - ratonet-source-main: código Swift principal
  - ratonet-source-common: código compartilhado
  - ratonet-source-watch: app Apple Watch
  - ratonet-source-widget: widget extension
  - ratonet-source-screen-recording: screen recording extension
  - ratonet-tests: testes
  - ratonet-config: arquivos de configuração
  - ratonet-utils: scripts Python"

# 4. Fazer push
git push
```

## Alternativa: Usar o Script

Um script foi criado em `scripts/commit-ratonet-workspace.sh`. Execute:

```bash
cd /mnt/e/PROJETOS/Vectorizer
chmod +x scripts/commit-ratonet-workspace.sh
./scripts/commit-ratonet-workspace.sh
```

## Mudanças Realizadas

1. **Projeto RatoNet adicionado** ao `vectorize-workspace.yml`
2. **Caminho configurado**: `/mnt/e/PROJETOS/Vectorizer/RatoNet` (formato WSL)
3. **9 coleções configuradas**:
   - ratonet-docs
   - ratonet-source-main
   - ratonet-source-common
   - ratonet-source-watch
   - ratonet-source-widget
   - ratonet-source-screen-recording
   - ratonet-tests
   - ratonet-config
   - ratonet-utils

