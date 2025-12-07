@echo off
REM Script para Windows - Actualizar repositorio rápidamente
REM Uso: update.bat "mensaje del commit"

if "%~1"=="" (
    echo Error: Debes proporcionar un mensaje de commit
    echo Uso: update.bat "tu mensaje de commit"
    echo Ejemplo: update.bat "Agregar nueva funcionalidad de login"
    exit /b 1
)

set COMMIT_MESSAGE=%~1

echo Actualizando repositorio...

REM Verificar si estamos en un repositorio Git
git rev-parse --git-dir >nul 2>&1
if errorlevel 1 (
    echo Error: No estas en un repositorio Git
    exit /b 1
)

echo.
echo Cambios detectados:
git status -s

echo.
echo Agregando cambios...
git add .

REM Verificar si hay cambios para commitear
git diff --staged --quiet
if errorlevel 0 (
    echo No hay cambios para commitear
    exit /b 0
)

echo.
echo Haciendo commit...
git commit -m "%COMMIT_MESSAGE%"

if errorlevel 1 (
    echo Error al hacer commit
    exit /b 1
)

echo Commit realizado exitosamente

echo.
echo Subiendo cambios a GitHub...
git push

if errorlevel 1 (
    echo Error al hacer push
    echo Intenta hacer push manualmente: git push
    exit /b 1
)

echo.
echo Todo actualizado exitosamente!
echo Mensaje: %COMMIT_MESSAGE%

