# Script para instalar Swift no Windows
# Requer PowerShell como Administrador

Write-Host "=== Instalação do Swift para Windows ===" -ForegroundColor Cyan
Write-Host ""

# Verificar se está executando como administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "⚠️  Este script precisa ser executado como Administrador!" -ForegroundColor Yellow
    Write-Host "   Clique com botão direito e selecione 'Executar como administrador'" -ForegroundColor Yellow
    exit 1
}

Write-Host "1. Verificando se winget está disponível..." -ForegroundColor Green
try {
    $wingetVersion = winget --version 2>&1
    Write-Host "   ✅ winget encontrado: $wingetVersion" -ForegroundColor Green
} catch {
    Write-Host "   ❌ winget não encontrado. Instale o App Installer da Microsoft Store." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "2. Verificando se Swift já está instalado..." -ForegroundColor Green
$swiftInstalled = Get-Command swift -ErrorAction SilentlyContinue
if ($swiftInstalled) {
    Write-Host "   ✅ Swift já está instalado!" -ForegroundColor Green
    swift --version
    Write-Host ""
    Write-Host "   Deseja reinstalar? (S/N)" -ForegroundColor Yellow
    $reinstall = Read-Host
    if ($reinstall -ne "S" -and $reinstall -ne "s") {
        Write-Host "   Instalação cancelada." -ForegroundColor Yellow
        exit 0
    }
}

Write-Host ""
Write-Host "3. Instalando dependências (Visual Studio Community 2022)..." -ForegroundColor Green
Write-Host "   ⚠️  Isso pode levar vários minutos e requer ~10GB de espaço..." -ForegroundColor Yellow
Write-Host "   Deseja continuar? (S/N)" -ForegroundColor Yellow
$continue = Read-Host
if ($continue -ne "S" -and $continue -ne "s") {
    Write-Host "   Instalação cancelada." -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "   Instalando Visual Studio Community 2022 com componentes necessários..." -ForegroundColor Cyan
winget install --id Microsoft.VisualStudio.2022.Community --exact --force --accept-package-agreements --accept-source-agreements --custom "--add Microsoft.VisualStudio.Component.Windows11SDK.22000 --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.VC.Tools.ARM64" 2>&1 | Tee-Object -Variable vsOutput

if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✅ Visual Studio instalado com sucesso!" -ForegroundColor Green
} else {
    Write-Host "   ⚠️  Aviso: Pode haver problemas na instalação do Visual Studio" -ForegroundColor Yellow
    Write-Host "   Continuando com a instalação do Swift..." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "4. Instalando Swift Toolchain..." -ForegroundColor Green
winget install --id Swift.Toolchain -e --accept-package-agreements --accept-source-agreements 2>&1 | Tee-Object -Variable swiftOutput

if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✅ Swift instalado com sucesso!" -ForegroundColor Green
} else {
    Write-Host "   ❌ Erro ao instalar Swift" -ForegroundColor Red
    Write-Host "   Saída: $swiftOutput" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "5. Atualizando variáveis de ambiente..." -ForegroundColor Green
Write-Host "   ⚠️  Você pode precisar reiniciar o terminal ou o computador" -ForegroundColor Yellow
Write-Host "   para que as variáveis de ambiente sejam atualizadas." -ForegroundColor Yellow

Write-Host ""
Write-Host "6. Verificando instalação..." -ForegroundColor Green
# Atualizar PATH na sessão atual
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

$swiftCheck = Get-Command swift -ErrorAction SilentlyContinue
if ($swiftCheck) {
    Write-Host "   ✅ Swift encontrado no PATH!" -ForegroundColor Green
    Write-Host ""
    Write-Host "   Versão do Swift:" -ForegroundColor Cyan
    swift --version
} else {
    Write-Host "   ⚠️  Swift não encontrado no PATH atual." -ForegroundColor Yellow
    Write-Host "   Tente:" -ForegroundColor Yellow
    Write-Host "   1. Fechar e reabrir o terminal" -ForegroundColor Yellow
    Write-Host "   2. Reiniciar o computador" -ForegroundColor Yellow
    Write-Host "   3. Verificar manualmente: C:\Library\Developer\Toolchains\swift-latest.xctoolchain\usr\bin" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Instalação concluída! ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "📝 Próximos passos:" -ForegroundColor Cyan
Write-Host "   1. Feche e reabra o terminal" -ForegroundColor White
Write-Host "   2. Execute: swift --version" -ForegroundColor White
Write-Host "   3. Teste criando um projeto: swift package init --type executable" -ForegroundColor White
Write-Host ""
Write-Host "⚠️  Lembre-se: Swift no Windows NÃO inclui UIKit ou frameworks iOS." -ForegroundColor Yellow
Write-Host "   Para desenvolvimento iOS completo, você precisa de um Mac com Xcode." -ForegroundColor Yellow

