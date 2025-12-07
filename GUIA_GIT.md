# 📋 Guía: Conectar con GitHub y Hacer Commit

## ✅ Pasos Completados Automáticamente

1. ✅ Repositorio Git inicializado
2. ✅ Archivo `.gitignore` creado
3. ✅ Archivos agregados al staging

## 🔄 Pasos que Debes Hacer Tú

### Paso 1: Hacer tu Primer Commit

```bash
git commit -m "Initial commit: Página de autenticación con shadcn/ui"
```

### Paso 2: Crear Repositorio en GitHub

1. Ve a [GitHub.com](https://github.com) e inicia sesión
2. Haz clic en el botón **"+"** (arriba a la derecha) → **"New repository"**
3. Completa el formulario:
   - **Repository name**: `auth-page` (o el nombre que prefieras)
   - **Description**: "Página de autenticación con React y shadcn/ui"
   - **Visibility**: Elige Público o Privado
   - ⚠️ **NO marques** "Initialize this repository with a README" (ya tenemos uno)
   - ⚠️ **NO agregues** .gitignore ni license (ya los tenemos)
4. Haz clic en **"Create repository"**

### Paso 3: Conectar tu Repositorio Local con GitHub

Después de crear el repositorio, GitHub te mostrará comandos. Ejecuta estos (reemplaza `TU_USUARIO` con tu usuario de GitHub):

```bash
git remote add origin https://github.com/TU_USUARIO/auth-page.git
git branch -M main
git push -u origin main
```

**O si prefieres usar SSH:**

```bash
git remote add origin git@github.com:TU_USUARIO/auth-page.git
git branch -M main
git push -u origin main
```

### Paso 4: Verificar la Conexión

```bash
git remote -v
```

Deberías ver tu repositorio de GitHub listado.

## 📝 Comandos Útiles para el Futuro

### Ver el estado de tus archivos:
```bash
git status
```

### Agregar archivos específicos:
```bash
git add nombre-del-archivo.tsx
```

### Agregar todos los archivos modificados:
```bash
git add .
```

### Hacer commit:
```bash
git commit -m "Descripción de los cambios"
```

### Subir cambios a GitHub:
```bash
git push
```

### Ver el historial de commits:
```bash
git log --oneline
```

## 🎯 Ejemplo de Flujo de Trabajo Diario

```bash
# 1. Ver qué archivos has modificado
git status

# 2. Agregar los cambios
git add .

# 3. Hacer commit con un mensaje descriptivo
git commit -m "Agregar funcionalidad de registro de usuarios"

# 4. Subir a GitHub
git push
```

## ⚠️ Notas Importantes

- **Mensajes de commit**: Sé descriptivo. Ejemplos:
  - ✅ "Agregar validación de email en formulario de login"
  - ✅ "Corregir error de autenticación"
  - ❌ "cambios"
  - ❌ "fix"

- **Frecuencia**: Haz commits frecuentemente, no esperes a tener muchos cambios

- **Branching**: Para features grandes, considera crear una rama:
  ```bash
  git checkout -b feature/nombre-feature
  # ... hacer cambios ...
  git commit -m "Agregar feature X"
  git push origin feature/nombre-feature
  ```

