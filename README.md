# Página de Autenticación con shadcn/ui

Una página de autenticación moderna construida con React, Vite, TypeScript y componentes de shadcn/ui.

## 🚀 Características

- ✨ Interfaz moderna y responsive
- 🔐 Formulario de autenticación con validación
- 🎨 Componentes de shadcn/ui
- 📱 Diseño adaptable a diferentes tamaños de pantalla
- 🌙 Soporte para modo oscuro (preparado)
- ✅ Validación de formularios con Zod y React Hook Form

## 📦 Tecnologías

- **React 18** - Biblioteca de UI
- **Vite** - Build tool y dev server
- **TypeScript** - Tipado estático
- **Tailwind CSS** - Estilos
- **shadcn/ui** - Componentes UI
- **React Hook Form** - Manejo de formularios
- **Zod** - Validación de esquemas

## 🛠️ Instalación

1. Instala las dependencias:
```bash
npm install
```

2. Inicia el servidor de desarrollo:
```bash
npm run dev
```

3. Abre tu navegador en `http://localhost:5173`

## 📁 Estructura del Proyecto

```
├── src/
│   ├── components/
│   │   └── ui/          # Componentes de shadcn/ui
│   ├── lib/
│   │   └── utils.ts     # Utilidades
│   ├── pages/
│   │   └── AuthPage.tsx # Página de autenticación
│   ├── App.tsx
│   ├── main.tsx
│   └── index.css
├── components.json      # Configuración de shadcn
├── tailwind.config.js
└── vite.config.ts
```

## 🎨 Componentes Utilizados

- **Card** - Contenedor principal del formulario
- **Form** - Manejo de formularios con validación
- **Input** - Campos de entrada
- **Button** - Botón de envío
- **Label** - Etiquetas de formulario

## 🚀 Scripts de Actualización Rápida

Script mejorado para gestionar tu repositorio Git fácilmente:

### Modo Rápido (más común):
```bash
bash update.sh "tu mensaje de commit"
```
Hace automáticamente: `add` → `commit` → `push`

### Otras opciones disponibles:
```bash
bash update.sh add              # Agregar todos los cambios
bash update.sh add archivo.txt  # Agregar archivo específico
bash update.sh remove archivo.txt # Eliminar del staging
bash update.sh commit "mensaje"  # Solo hacer commit
bash update.sh push              # Solo hacer push
bash update.sh status            # Ver estado
bash update.sh help              # Ver todas las opciones
```

**Ejemplos:**
```bash
bash update.sh "Agregar validación de email"
bash update.sh add src/components/Button.tsx
bash update.sh commit "Corregir bug"
```

Para más detalles, consulta `GUIA_SCRIPTS.md`

## 🔧 Personalización

Puedes personalizar los colores y estilos editando:
- `src/index.css` - Variables CSS y estilos globales
- `tailwind.config.js` - Configuración de Tailwind

## 📝 Próximos Pasos

- [ ] Agregar funcionalidad de registro
- [ ] Implementar recuperación de contraseña
- [ ] Conectar con backend/API
- [ ] Agregar autenticación con OAuth
- [ ] Implementar manejo de sesiones

## 📄 Licencia

MIT
