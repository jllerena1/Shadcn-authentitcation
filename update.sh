#!/bin/bash

# Script para actualizar el repositorio rápidamente
# Uso: ./update.sh "mensaje del commit"

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar que se proporcionó un mensaje de commit
if [ -z "$1" ]; then
    echo -e "${RED}❌ Error: Debes proporcionar un mensaje de commit${NC}"
    echo -e "${YELLOW}Uso: ./update.sh \"tu mensaje de commit\"${NC}"
    echo -e "${YELLOW}Ejemplo: ./update.sh \"Agregar nueva funcionalidad de login\"${NC}"
    exit 1
fi

COMMIT_MESSAGE="$1"

echo -e "${YELLOW}🔄 Actualizando repositorio...${NC}"

# Verificar el estado de git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}❌ Error: No estás en un repositorio Git${NC}"
    exit 1
fi

# Mostrar cambios pendientes
echo -e "\n${YELLOW}📋 Cambios detectados:${NC}"
git status -s

# Agregar todos los cambios
echo -e "\n${YELLOW}➕ Agregando cambios...${NC}"
git add .

# Verificar si hay cambios para commitear
if git diff --staged --quiet; then
    echo -e "${YELLOW}⚠️  No hay cambios para commitear${NC}"
    exit 0
fi

# Hacer commit
echo -e "\n${YELLOW}💾 Haciendo commit...${NC}"
git commit -m "$COMMIT_MESSAGE"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Commit realizado exitosamente${NC}"
else
    echo -e "${RED}❌ Error al hacer commit${NC}"
    exit 1
fi

# Hacer push
echo -e "\n${YELLOW}🚀 Subiendo cambios a GitHub...${NC}"
git push

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}✅ ¡Todo actualizado exitosamente!${NC}"
    echo -e "${GREEN}📝 Mensaje: $COMMIT_MESSAGE${NC}"
else
    echo -e "${RED}❌ Error al hacer push${NC}"
    echo -e "${YELLOW}💡 Intenta hacer push manualmente: git push${NC}"
    exit 1
fi

