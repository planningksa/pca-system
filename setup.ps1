# ============================================================
# PCA SYSTEM - SETUP COMPLETO
# ============================================================
Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   🚀 PCA SYSTEM - CONFIGURACIÓN AUTOMÁTICA         ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# ----- SUPABASE -----
Write-Host "PASO 1: CONFIGURAR SUPABASE" -ForegroundColor Yellow
Write-Host "  1. Ve a https://supabase.com/dashboard" -ForegroundColor Gray
Write-Host "  2. Crea un proyecto o entra a uno existente" -ForegroundColor Gray
Write-Host "  3. Ve a Project Settings → API" -ForegroundColor Gray
Write-Host "  4. Copia 'Project URL' y 'anon public key'" -ForegroundColor Gray
Write-Host ""
$supabaseUrl = Read-Host "  PEGA tu Project URL (ej: https://xyz.supabase.co)"
$supabaseKey = Read-Host "  PEGA tu anon public key"

# ---- Insertar en HTML -----
$htmlPath = Join-Path $PSScriptRoot "index.html"
$html = Get-Content $htmlPath -Raw
$html = $html -replace "'https://TU_PROYECTO.supabase.co'", "'$supabaseUrl'"
$html = $html -replace "'TU_ANON_KEY'", "'$supabaseKey'"
Set-Content $htmlPath $html -NoNewline
Write-Host "  ✅ Configuración de Supabase insertada en index.html" -ForegroundColor Green

# ---- SQL -----
Write-Host ""
Write-Host "PASO 2: EJECUTAR SQL EN SUPABASE" -ForegroundColor Yellow
Write-Host "  1. Ve a Supabase Dashboard → SQL Editor" -ForegroundColor Gray
Write-Host "  2. Abre el archivo 'supabase-setup.sql' (está en esta carpeta)" -ForegroundColor Gray
Write-Host "  3. Pega y ejecuta el SQL" -ForegroundColor Gray
Write-Host "  4. Ve a Authentication → Settings y DESACTIVA 'Confirm email'" -ForegroundColor Gray
Write-Host ""

Read-Host "Presiona ENTER después de ejecutar el SQL"

# ---- GITHUB -----
Write-Host "PASO 3: SUBIR A GITHUB Y HACER DEPLOY" -ForegroundColor Yellow
Write-Host "  ¿Quieres que configure Git y suba a GitHub automáticamente?" -ForegroundColor Gray
$resp = Read-Host "  (S/N)"
if ($resp -eq 'S' -or $resp -eq 's') {
  $gitPath = "C:\Users\admin\AppData\Local\GitHubDesktop\app-3.5.11\resources\app\git\cmd\git.exe"
  if (Test-Path $gitPath) {
    $repoName = Read-Host "  Nombre del repo en GitHub (ej: pca-system)"
    
    # Inicializar git
    & $gitPath init
    & $gitPath add -A
    & $gitPath commit -m "Initial commit: PCA Document Cabinet"
    
    Write-Host ""
    Write-Host "  Ahora necesitas crear un repo vacío en GitHub:" -ForegroundColor Yellow
    Write-Host "  1. Ve a https://github.com/new" -ForegroundColor Gray
    Write-Host "  2. Nombre: $repoName" -ForegroundColor Gray
    Write-Host "  3. NO marques 'Add README' ni '.gitignore' (repo vacío)" -ForegroundColor Gray
    Write-Host "  4. Haz clic en 'Create repository'" -ForegroundColor Gray
    Write-Host ""
    $ghUser = Read-Host "  Tu usuario de GitHub"
    
    & $gitPath remote add origin "https://github.com/$ghUser/$repoName.git"
    & $gitPath branch -M main
    
    Write-Host ""
    Write-Host "  Para subir, ejecuta en una terminal NORMAL (no VS Code):" -ForegroundColor Green
    Write-Host "  -----------------------------------------" -ForegroundColor Gray
    Write-Host "  cd `"$PSScriptRoot`"" -ForegroundColor White
    Write-Host "  `"$gitPath`" push -u origin main" -ForegroundColor White
    Write-Host "  -----------------------------------------" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  DESPUÉS, para hacer deploy en Vercel gratis:" -ForegroundColor Yellow
    Write-Host "  1. Ve a https://vercel.com/import" -ForegroundColor Gray
    Write-Host "  2. Importa el repo de GitHub" -ForegroundColor Gray
    Write-Host "  3. Vercel lo despliega automáticamente" -ForegroundColor Gray
    Write-Host "  4. Obtienes: https://$repoName.vercel.app" -ForegroundColor Gray
  }
}

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   ✅ CONFIGURACIÓN COMPLETADA                       ║" -ForegroundColor Cyan
Write-Host "║                                                    ║" -ForegroundColor Cyan
Write-Host "║   Tu web quedará en:                               ║" -ForegroundColor Cyan
Write-Host "║   https://TU_APP.vercel.app                        ║" -ForegroundColor Cyan
Write-Host "║                                                    ║" -ForegroundColor Cyan
Write-Host "║   Usuario: planning                                ║" -ForegroundColor Cyan
Write-Host "║   Contraseña: (la que elijas)                      ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Read-Host "Presiona ENTER para salir"
