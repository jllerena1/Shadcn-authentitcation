#!/bin/bash

# Script para gestionar el repositorio Git rápidamente
# Uso: bash update.sh [acción] [mensaje/archivo]

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Verificar que estamos en un repositorio Git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}❌ Error: No estás en un repositorio Git${NC}"
    exit 1
fi

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}📚 Uso del script update.sh${NC}\n"
    echo -e "${YELLOW}Opciones disponibles:${NC}\n"
    echo -e "  ${GREEN}bash update.sh \"mensaje\"${NC}"
    echo -e "    → Agrega cambios, hace commit y push (rápido)\n"
    echo -e "  ${GREEN}bash update.sh add${NC}"
    echo -e "    → Solo agrega todos los cambios al staging\n"
    echo -e "  ${GREEN}bash update.sh add archivo.txt${NC}"
    echo -e "    → Agrega un archivo específico\n"
    echo -e "  ${GREEN}bash update.sh remove archivo.txt${NC}"
    echo -e "    → Elimina un archivo del staging\n"
    echo -e "  ${GREEN}bash update.sh commit \"mensaje\"${NC}"
    echo -e "    → Solo hace commit (sin push)\n"
    echo -e "  ${GREEN}bash update.sh push${NC}"
    echo -e "    → Solo hace push de los commits\n"
    echo -e "  ${GREEN}bash update.sh status${NC}"
    echo -e "    → Muestra el estado del repositorio\n"
    echo -e "${YELLOW}Ejemplos:${NC}"
    echo -e "  bash update.sh \"Agregar nueva funcionalidad\""
    echo -e "  bash update.sh add src/components/Button.tsx"
    echo -e "  bash update.sh remove archivo.txt"
    echo -e "  bash update.sh commit \"Corregir bug\""
}

# Si no hay argumentos, mostrar ayuda
if [ -z "$1" ]; then
    show_help
    exit 0
fi

ACTION="$1"

# Caso 1: Solo mensaje (modo rápido: add + commit + push)
if [ "$ACTION" != "add" ] && [ "$ACTION" != "remove" ] && [ "$ACTION" != "commit" ] && [ "$ACTION" != "push" ] && [ "$ACTION" != "status" ] && [ "$ACTION" != "help" ]; then
    COMMIT_MESSAGE="$1"
    
    echo -e "${YELLOW}🔄 Actualizando repositorio (modo rápido)...${NC}"
    
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
    
    exit 0
fi

# Caso 2: Comandos específicos
case "$ACTION" in
    "add")
        if [ -z "$2" ]; then
            # Agregar todos los cambios
            echo -e "${YELLOW}➕ Agregando todos los cambios...${NC}"
            git add .
            echo -e "${GREEN}✅ Cambios agregados${NC}"
            git status -s
        else
            # Agregar archivo específico
            echo -e "${YELLOW}➕ Agregando archivo: $2${NC}"
            git add "$2"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ Archivo agregado: $2${NC}"
                git status -s
            else
                echo -e "${RED}❌ Error al agregar archivo${NC}"
                exit 1
            fi
        fi
        ;;
    
    "remove")
        if [ -z "$2" ]; then
            echo -e "${RED}❌ Error: Debes especificar un archivo${NC}"
            echo -e "${YELLOW}Uso: bash update.sh remove archivo.txt${NC}"
            exit 1
        fi
        echo -e "${YELLOW}➖ Eliminando del staging: $2${NC}"
        git reset HEAD "$2"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Archivo eliminado del staging: $2${NC}"
            git status -s
        else
            echo -e "${RED}❌ Error al eliminar archivo${NC}"
            exit 1
        fi
        ;;
    
    "commit")
        if [ -z "$2" ]; then
            echo -e "${RED}❌ Error: Debes proporcionar un mensaje de commit${NC}"
            echo -e "${YELLOW}Uso: bash update.sh commit \"tu mensaje\"${NC}"
            exit 1
        fi
        COMMIT_MESSAGE="$2"
        
        # Verificar si hay cambios para commitear
        if git diff --staged --quiet; then
            echo -e "${YELLOW}⚠️  No hay cambios en staging para commitear${NC}"
            echo -e "${YELLOW}💡 Usa 'bash update.sh add' primero${NC}"
            exit 0
        fi
        
        echo -e "${YELLOW}💾 Haciendo commit...${NC}"
        git commit -m "$COMMIT_MESSAGE"
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Commit realizado exitosamente${NC}"
            echo -e "${GREEN}📝 Mensaje: $COMMIT_MESSAGE${NC}"
        else
            echo -e "${RED}❌ Error al hacer commit${NC}"
            exit 1
        fi
        ;;
    
    "push")
        echo -e "${YELLOW}🚀 Subiendo cambios a GitHub...${NC}"
        git push
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Push realizado exitosamente${NC}"
        else
            echo -e "${RED}❌ Error al hacer push${NC}"
            exit 1
        fi
        ;;
    
    "status")
        echo -e "${YELLOW}📋 Estado del repositorio:${NC}\n"
        git status
        echo -e "\n${YELLOW}📝 Cambios detallados:${NC}"
        git status -s
        ;;
    
    "help")
        show_help
        ;;
    
    *)
        echo -e "${RED}❌ Acción desconocida: $ACTION${NC}"
        show_help
        exit 1
        ;;
esac

