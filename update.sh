#!/bin/bash

# Script para gestionar el repositorio Git rápidamente
# Uso: ./update.sh [acción] [mensaje/archivo]
# Sin argumentos: modo automático interactivo

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Verificar que estamos en un repositorio Git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}❌ Error: No estás en un repositorio Git${NC}"
    exit 1
fi

# Función para generar mensaje automático basado en cambios
generate_auto_message() {
    local changes=$(git status -s)
    local message=""
    
    # Contar tipos de cambios
    local modified=$(echo "$changes" | grep -c "^ M" || echo "0")
    local added=$(echo "$changes" | grep -c "^??" || echo "0")
    local deleted=$(echo "$changes" | grep -c "^ D" || echo "0")
    
    # Generar mensaje basado en cambios
    if [ "$added" -gt 0 ] && [ "$modified" -eq 0 ] && [ "$deleted" -eq 0 ]; then
        message="Agregar nuevos archivos"
    elif [ "$modified" -gt 0 ] && [ "$added" -eq 0 ] && [ "$deleted" -eq 0 ]; then
        message="Actualizar archivos existentes"
    elif [ "$deleted" -gt 0 ]; then
        message="Eliminar archivos"
    else
        message="Actualizar proyecto"
    fi
    
    # Agregar timestamp
    message="$message - $(date +'%Y-%m-%d %H:%M')"
    echo "$message"
}

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}📚 Uso del script update.sh${NC}\n"
    echo -e "${YELLOW}Modo automático (sin argumentos):${NC}\n"
    echo -e "  ${GREEN}./update.sh${NC}"
    echo -e "    → Detecta cambios, pregunta mensaje y hace add+commit+push\n"
    echo -e "${YELLOW}Modo rápido con mensaje:${NC}\n"
    echo -e "  ${GREEN}./update.sh \"mensaje\"${NC}"
    echo -e "    → Agrega cambios, hace commit y push con tu mensaje\n"
    echo -e "${YELLOW}Otras opciones:${NC}\n"
    echo -e "  ${GREEN}./update.sh add${NC}              → Solo agrega cambios\n"
    echo -e "  ${GREEN}./update.sh add archivo.txt${NC}  → Agrega archivo específico\n"
    echo -e "  ${GREEN}./update.sh remove archivo.txt${NC} → Elimina del staging\n"
    echo -e "  ${GREEN}./update.sh commit \"mensaje\"${NC} → Solo commit\n"
    echo -e "  ${GREEN}./update.sh push${NC}             → Solo push\n"
    echo -e "  ${GREEN}./update.sh status${NC}            → Ver estado\n"
    echo -e "  ${GREEN}./update.sh help${NC}              → Mostrar esta ayuda\n"
}

# Modo automático: sin argumentos
if [ -z "$1" ]; then
    echo -e "${CYAN}🚀 Modo Automático - Actualización Inteligente${NC}\n"
    
    # Verificar si hay cambios
    if git diff --quiet && git diff --staged --quiet; then
        echo -e "${YELLOW}⚠️  No hay cambios para commitear${NC}"
        exit 0
    fi
    
    # Mostrar cambios
    echo -e "${YELLOW}📋 Cambios detectados:${NC}"
    git status -s
    echo ""
    
    # Generar mensaje sugerido
    AUTO_MESSAGE=$(generate_auto_message)
    
    # Pedir mensaje de commit
    echo -e "${CYAN}💬 Mensaje de commit sugerido:${NC} ${GREEN}$AUTO_MESSAGE${NC}"
    echo -e "${YELLOW}Presiona Enter para usar el mensaje sugerido o escribe uno nuevo:${NC}"
    read -r USER_MESSAGE
    
    # Usar mensaje del usuario o el automático
    if [ -z "$USER_MESSAGE" ]; then
        COMMIT_MESSAGE="$AUTO_MESSAGE"
        echo -e "${GREEN}✓ Usando mensaje automático${NC}"
    else
        COMMIT_MESSAGE="$USER_MESSAGE"
        echo -e "${GREEN}✓ Usando tu mensaje personalizado${NC}"
    fi
    
    echo ""
    
    # Agregar todos los cambios
    echo -e "${YELLOW}➕ Agregando cambios...${NC}"
    git add .
    
    # Hacer commit
    echo -e "${YELLOW}💾 Haciendo commit...${NC}"
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

