# SENAParking 🚗🅿️

## Descripción 📄
SENAParking es un sistema de gestión de parqueaderos desarrollado con **Node.js, Express y MariaDB** en el backend, y **HTML, CSS y Bootstrap** en el frontend. 

Este sistema permite el control eficiente del acceso de vehículos, la gestión de usuarios del parqueadero, la asignación de permisos y la generación de reportes.

## Características ✨
- 📌 **Gestión de usuarios** (administradores, supervisores, guardias y usuarios del parqueadero).
- 🚘 **Registro y control de vehículos**.
- 🚪 **Registro de accesos** al parqueadero.
- 🔐 **Gestión de permisos** por tipo de usuario.
- 📊 **Generación de reportes y estadísticas**.
- 🌐 **Interfaz web amigable y responsiva**.

---

## 📂 Estructura del Proyecto

```
📁 SENAParking/
├── 🖥️ backend/                    # Lógica del sistema (API REST con Node.js)
│   ├── 🎛️ controllers/            # Controladores (lógica de los módulos)
│   │   ├── 👥 usuarioSistemaController.js         # (Módulo: Gestión de Usuarios del Sistema)
│   │   ├── 🚗 usuarioParqueaderoController.js     # (Módulo: Gestión de Usuarios del Parqueadero)
│   │   ├── 🚘 vehiculoController.js               # (Módulo: Gestión de Vehículos)
│   │   ├── 🚪 accesoController.js                 # (Módulo: Registro de Accesos)
│   │   ├── 🔐 permisosController.js               # (Módulo: Gestión de Permisos)
│   │   ├── 📜 actividadController.js              # (Módulo: Registro de Actividad de Usuarios)
│   │   ├── 📊 reportesController.js               # (Módulo: Reportes y Estadísticas)
│   ├── 🗄️ models/                 # Modelos de la base de datos
│   │   ├── 👥 usuarioSistema.js                   # (Módulo: Gestión de Usuarios del Sistema)
│   │   ├── 🚗 usuarioParqueadero.js               # (Módulo: Gestión de Usuarios del Parqueadero)
│   │   ├── 🚘 vehiculo.js                          # (Módulo: Gestión de Vehículos)
│   │   ├── 🚪 acceso.js                            # (Módulo: Registro de Accesos)
│   │   ├── 🔐 permisos.js                          # (Módulo: Gestión de Permisos)
│   │   ├── 📜 actividad.js                         # (Módulo: Registro de Actividad de Usuarios)
│   │   ├── 📊 reportes.js                          # (Módulo: Reportes y Estadísticas)
│   ├── 🛤️ routes/                 # Rutas de la API
│   │   ├── 👥 usuarioSistemaRoutes.js             # (Módulo: Gestión de Usuarios del Sistema)
│   │   ├── 🚗 usuarioParqueaderoRoutes.js         # (Módulo: Gestión de Usuarios del Parqueadero)
│   │   ├── 🚘 vehiculoRoutes.js                    # (Módulo: Gestión de Vehículos)
│   │   ├── 🚪 accesoRoutes.js                      # (Módulo: Registro de Accesos)
│   │   ├── 🔐 permisosRoutes.js                    # (Módulo: Gestión de Permisos)
│   │   ├── 📜 actividadRoutes.js                   # (Módulo: Registro de Actividad de Usuarios)
│   │   ├── 📊 reportesRoutes.js                    # (Módulo: Reportes y Estadísticas)
│   ├── ⚙️ config/                 # Configuración del servidor y base de datos
│   │   ├── 🗄️ database.js                         # Conexión a MariaDB
│   │   ├── 🚀 server.js                           # Configuración del servidor
│   ├── 📦 package.json             # Dependencias del proyecto
│   ├── 🔑 .env                     # Variables de entorno (credenciales DB, etc.)
│
├── 🎨 frontend/                   # Interfaz de usuario (HTML, CSS, Bootstrap)
│   ├── 🎨 css/                    # Hojas de estilo
│   │   ├── 🎨 estilos.css
│   ├── 📜 js/                     # Scripts de interacción con la API
│   │   ├── 👥 usuarioSistema.js                  # (Módulo: Gestión de Usuarios del Sistema)
│   │   ├── 🚗 usuarioParqueadero.js              # (Módulo: Gestión de Usuarios del Parqueadero)
│   │   ├── 🚘 vehiculo.js                         # (Módulo: Gestión de Vehículos)
│   │   ├── 🚪 acceso.js                           # (Módulo: Registro de Accesos)
│   │   ├── 🔐 permisos.js                         # (Módulo: Gestión de Permisos)
│   │   ├── 📜 actividad.js                        # (Módulo: Registro de Actividad de Usuarios)
│   │   ├── 📊 reportes.js                         # (Módulo: Reportes y Estadísticas)
│   ├── 📄 views/                  # Vistas HTML organizadas por rol
│   │   ├── 🔑 login.html                        # Página de inicio de sesión
│   │   ├── 🛡️ dashboard_guardia.html            # Vista del guarda (Registro de Accesos)
│   │   ├── 👨‍💼 dashboard_supervisor.html         # Vista del supervisor (Gestión y Reportes)
│   │   ├── 🏢 dashboard_admin.html              # Vista del administrador (Gestión completa)
│   │   ├── 📊 reportes.html                     # Vista para generación de reportes
│   ├── 🏠 index.html              # Página principal
│
├── 📚 docs/                       # Documentación
│   ├── 🗄️ base_datos.sql          # Código SQL de la base de datos
│   ├── 🏗️ arquitectura.pdf        # Explicación de la arquitectura
│
├── 📖 README.md                   # Información general del proyecto

```

---

## 🚀 Instalación y Configuración

### 1️⃣ Requisitos
- Node.js y npm instalados.
- MariaDB configurado.
- Un archivo `.env` con las credenciales de la base de datos.

### 2️⃣ Instalación del Backend
```sh
cd backend
npm install
npm start
```

### 3️⃣ Instalación del Frontend
Solo necesitas abrir `index.html` en un navegador.

---

## 📌 Tecnologías Utilizadas
- **Backend:** Node.js, Express, MariaDB
- **Frontend:** HTML, CSS, Bootstrap, JavaScript
- **Otros:** Dotenv, Sequelize (ORM para MariaDB)

---

## 📞 Contacto
Si tienes preguntas o sugerencias, ¡contáctanos!
📧 Email: soporte@senaparking.com
🌐 Página web: www.senaparking.com

---

💡 *SENAParking - Facilitando la gestión de parqueaderos con tecnología moderna.* 🚗
