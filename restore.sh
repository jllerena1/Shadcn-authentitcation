#!/bin/bash

# Script para restaurar el repositorio desde GitHub
# Uso: ./restore.sh [opción]
# Sin argumentos: modo interactivo con confirmación

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

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}📚 Uso del script restore.sh${NC}\n"
    echo -e "${YELLOW}Modo interactivo (sin argumentos):${NC}\n"
    echo -e "  ${GREEN}./restore.sh${NC}"
    echo -e "    → Muestra cambios y pregunta confirmación antes de restaurar\n"
    echo -e "${YELLOW}Modo rápido (sin confirmación):${NC}\n"
    echo -e "  ${GREEN}./restore.sh --force${NC}"
    echo -e "    → Restaura inmediatamente sin preguntar\n"
    echo -e "${YELLOW}Otras opciones:${NC}\n"
    echo -e "  ${GREEN}./restore.sh --hard${NC}        → Restaura todo (reset --hard + clean)\n"
    echo -e "  ${GREEN}./restore.sh --soft${NC}       → Solo restaura archivos modificados\n"
    echo -e "  ${GREEN}./restore.sh --fetch${NC}      → Solo actualiza desde GitHub (fetch)\n"
    echo -e "  ${GREEN}./restore.sh --status${NC}     → Ver qué se restauraría\n"
    echo -e "  ${GREEN}./restore.sh help${NC}         → Mostrar esta ayuda\n"
}

# Función para mostrar cambios que se perderán
show_changes() {
    echo -e "${YELLOW}📋 Cambios locales que se perderán:${NC}\n"
    
    # Archivos modificados
    local modified=$(git diff --name-only)
    if [ -n "$modified" ]; then
        echo -e "${RED}  Archivos modificados:${NC}"
        echo "$modified" | sed 's/^/    - /'
        echo ""
    fi
    
    # Archivos en staging
    local staged=$(git diff --staged --name-only)
    if [ -n "$staged" ]; then
        echo -e "${YELLOW}  Archivos en staging:${NC}"
        echo "$staged" | sed 's/^/    - /'
        echo ""
    fi
    
    # Archivos sin trackear
    local untracked=$(git ls-files --others --exclude-standard)
    if [ -n "$untracked" ]; then
        echo -e "${CYAN}  Archivos nuevos (sin trackear):${NC}"
        echo "$untracked" | sed 's/^/    - /'
        echo ""
    fi
    
    # Verificar si hay cambios
    if [ -z "$modified" ] && [ -z "$staged" ] && [ -z "$untracked" ]; then
        echo -e "${GREEN}  ✓ No hay cambios locales${NC}"
        return 1
    fi
    
    return 0
}

# Función para obtener la rama actual
get_current_branch() {
    git branch --show-current 2>/dev/null || echo "main"
}

# Función para restaurar desde GitHub
restore_from_github() {
    local mode="$1"
    local branch=$(get_current_branch)
    local remote="origin"
    
    echo -e "${CYAN}🔄 Restaurando desde GitHub...${NC}\n"
    
    # Obtener información del remoto
    echo -e "${YELLOW}📡 Obteniendo última versión de GitHub...${NC}"
    git fetch "$remote" "$branch"
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Error al obtener cambios de GitHub${NC}"
        echo -e "${YELLOW}💡 Verifica tu conexión y que el remoto 'origin' esté configurado${NC}"
        exit 1
    fi
    
    # Verificar si hay diferencias
    local commits_behind=$(git rev-list --count HEAD.."$remote/$branch" 2>/dev/null || echo "0")
    local commits_ahead=$(git rev-list --count "$remote/$branch"..HEAD 2>/dev/null || echo "0")
    
    if [ "$commits_behind" -eq 0 ] && [ "$commits_ahead" -eq 0 ]; then
        echo -e "${GREEN}✓ Ya estás sincronizado con GitHub${NC}"
    else
        echo -e "${YELLOW}  Commits detrás: $commits_behind${NC}"
        echo -e "${YELLOW}  Commits adelante: $commits_ahead${NC}"
    fi
    
    # Restaurar según el modo
    case "$mode" in
        "hard")
            echo -e "\n${YELLOW}🗑️  Eliminando todos los cambios locales...${NC}"
            git reset --hard "$remote/$branch"
            git clean -fd
            ;;
        "soft")
            echo -e "\n${YELLOW}🔄 Restaurando archivos modificados...${NC}"
            git reset --hard "$remote/$branch"
            ;;
        *)
            echo -e "\n${YELLOW}🔄 Restaurando desde $remote/$branch...${NC}"
            git reset --hard "$remote/$branch"
            git clean -fd
            ;;
    esac
    
    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}✅ ¡Repositorio restaurado exitosamente!${NC}"
        echo -e "${GREEN}📦 Rama: $branch${NC}"
        echo -e "${GREEN}🌐 Remoto: $remote/$branch${NC}"
        
        # Mostrar último commit
        local last_commit=$(git log -1 --oneline)
        echo -e "${GREEN}📝 Último commit: $last_commit${NC}"
    else
        echo -e "${RED}❌ Error al restaurar${NC}"
        exit 1
    fi
}

# Modo interactivo: sin argumentos
if [ -z "$1" ] || [ "$1" = "--interactive" ]; then
    echo -e "${CYAN}🔄 Modo Interactivo - Restaurar desde GitHub${NC}\n"
    
    # Mostrar estado actual
    local branch=$(get_current_branch)
    echo -e "${BLUE}📌 Rama actual: ${YELLOW}$branch${NC}"
    echo -e "${BLUE}🌐 Remoto: ${YELLOW}origin/$branch${NC}\n"
    
    # Mostrar cambios
    if ! show_changes; then
        echo -e "\n${GREEN}✓ Tu repositorio ya está sincronizado con GitHub${NC}"
        exit 0
    fi
    
    echo ""
    echo -e "${RED}⚠️  ADVERTENCIA: Esta acción eliminará todos los cambios locales${NC}"
    echo -e "${RED}   y restaurará el código desde GitHub.${NC}"
    echo -e "${RED}   Los archivos no rastreados también serán eliminados.${NC}\n"
    
    # Preguntar confirmación
    echo -e "${YELLOW}¿Estás seguro de que quieres continuar? (sí/no):${NC}"
    read -r CONFIRM
    
    if [ "$CONFIRM" != "sí" ] && [ "$CONFIRM" != "si" ] && [ "$CONFIRM" != "yes" ] && [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "s" ]; then
        echo -e "${YELLOW}❌ Operación cancelada${NC}"
        exit 0
    fi
    
    restore_from_github "hard"
    exit 0
fi

ACTION="$1"

# Casos específicos
case "$ACTION" in
    "--force"|"-f")
        restore_from_github "hard"
        ;;
    
    "--hard"|"-h")
        echo -e "${CYAN}🔄 Restauración completa (hard reset + clean)${NC}\n"
        show_changes
        restore_from_github "hard"
        ;;
    
    "--soft"|"-s")
        echo -e "${CYAN}🔄 Restauración suave (solo archivos modificados)${NC}\n"
        show_changes
        restore_from_github "soft"
        ;;
    
    "--fetch"|"-F")
        echo -e "${CYAN}📡 Actualizando información desde GitHub...${NC}\n"
        local branch=$(get_current_branch)
        git fetch origin "$branch"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Información actualizada${NC}"
            echo -e "${YELLOW}💡 Usa './restore.sh' para restaurar los cambios${NC}"
        else
            echo -e "${RED}❌ Error al actualizar${NC}"
            exit 1
        fi
        ;;
    
    "--status"|"-S")
        echo -e "${CYAN}📊 Estado del repositorio vs GitHub${NC}\n"
        local branch=$(get_current_branch)
        echo -e "${BLUE}📌 Rama actual: ${YELLOW}$branch${NC}\n"
        
        # Obtener información
        git fetch origin "$branch" > /dev/null 2>&1
        
        local commits_behind=$(git rev-list --count HEAD.."origin/$branch" 2>/dev/null || echo "0")
        local commits_ahead=$(git rev-list --count "origin/$branch"..HEAD 2>/dev/null || echo "0")
        
        echo -e "${YELLOW}Commits detrás de GitHub: $commits_behind${NC}"
        echo -e "${YELLOW}Commits adelante de GitHub: $commits_ahead${NC}\n"
        
        show_changes
        
        if [ "$commits_behind" -eq 0 ] && [ "$commits_ahead" -eq 0 ]; then
            local has_changes=$(git diff --quiet && git diff --staged --quiet && [ -z "$(git ls-files --others --exclude-standard)" ] && echo "0" || echo "1")
            if [ "$has_changes" -eq "0" ]; then
                echo -e "\n${GREEN}✓ Repositorio sincronizado con GitHub${NC}"
            fi
        fi
        ;;
    
    "help"|"--help"|"-h")
        show_help
        ;;
    
    *)
        echo -e "${RED}❌ Opción desconocida: $ACTION${NC}\n"
        show_help
        exit 1
        ;;
esac
