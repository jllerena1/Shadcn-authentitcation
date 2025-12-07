# 🚀 Guía de Scripts de Actualización

## Script de Actualización Rápida

Script mejorado que permite gestionar tu repositorio Git de manera rápida y sencilla con múltiples acciones.

## 📋 Scripts Disponibles

### `update.sh` (macOS/Linux)
Script bash completo con múltiples funciones.

### `update.bat` (Windows)
Script batch para sistemas Windows.

## 🎯 Uso Básico

### ⭐ Modo Automático (MÁS FÁCIL - Sin argumentos):
```bash
./update.sh
```
El script detecta cambios, muestra qué cambió, sugiere un mensaje y hace todo automáticamente. Solo presiona Enter para usar el mensaje sugerido o escribe uno personalizado.

### Modo Rápido con Mensaje:
```bash
./update.sh "tu mensaje de commit"
```

### Ver todas las opciones:
```bash
./update.sh help
```

## 📚 Todas las Opciones Disponibles

### 1. **Modo Rápido** (más común)
```bash
bash update.sh "mensaje del commit"
```
Hace automáticamente: `add` → `commit` → `push`

### 2. **Agregar cambios**
```bash
# Agregar todos los cambios
bash update.sh add

# Agregar un archivo específico
bash update.sh add src/components/Button.tsx
```

### 3. **Eliminar del staging**
```bash
bash update.sh remove archivo.txt
```

### 4. **Solo hacer commit**
```bash
bash update.sh commit "mensaje del commit"
```

### 5. **Solo hacer push**
```bash
bash update.sh push
```

### 6. **Ver estado**
```bash
bash update.sh status
```

### 7. **Ayuda**
```bash
bash update.sh help
```

## 📝 Ejemplos de Uso

### Ejemplo 1: Actualización simple
```bash
./update.sh "Agregar validación de email"
```

### Ejemplo 2: Corrección de bugs
```bash
./update.sh "Corregir error en formulario de login"
```

### Ejemplo 3: Nueva funcionalidad
```bash
./update.sh "Agregar funcionalidad de registro de usuarios"
```

### Ejemplo 4: Mejoras
```bash
./update.sh "Mejorar diseño responsive de la página"
```

## ✨ Características del Script

El script `update.sh` hace automáticamente:

1. ✅ **Verifica** que estés en un repositorio Git
2. 📋 **Muestra** los cambios detectados
3. ➕ **Agrega** todos los cambios (`git add .`)
4. 💾 **Hace commit** con tu mensaje
5. 🚀 **Sube** los cambios a GitHub (`git push`)

## 🎨 Salida del Script

El script muestra mensajes con colores:
- 🟢 Verde: Operaciones exitosas
- 🟡 Amarillo: Información y advertencias
- 🔴 Rojo: Errores

## ⚠️ Notas Importantes

- **Mensaje obligatorio**: Debes proporcionar un mensaje de commit
- **Sin cambios**: Si no hay cambios, el script te lo indicará
- **Errores**: Si algo falla, el script te mostrará el error

## 🔧 Personalización

Si quieres modificar el script, puedes editarlo con:

```bash
nano update.sh
# o
code update.sh
```

## 📚 Comandos Alternativos

Si prefieres hacerlo manualmente:

```bash
# Ver cambios
git status

# Agregar cambios
git add .

# Hacer commit
git commit -m "tu mensaje"

# Subir a GitHub
git push
```

## 💡 Tips

- **Mensajes descriptivos**: Usa mensajes claros que expliquen qué cambiaste
- **Commits frecuentes**: Haz commits pequeños y frecuentes
- **Revisa antes**: El script muestra los cambios antes de commitear

## 🆘 Solución de Problemas

### Error: "No estás en un repositorio Git"
- Asegúrate de estar en la carpeta del proyecto

### Error: "Debes proporcionar un mensaje de commit"
- Siempre incluye un mensaje entre comillas: `./update.sh "mensaje"`

### Error al hacer push
- Verifica tu conexión a internet
- Asegúrate de tener permisos en el repositorio
- Intenta hacer push manualmente: `git push`

