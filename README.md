# 📱 Sistema de Orientación Vocacional con IA

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)

**Aplicación móvil desarrollada en Flutter con Firebase como Backend**

Huancayo - Perú | 2026

</div>

---

## 📌 Descripción del Proyecto

Aplicación móvil desarrollada para brindar orientación vocacional a estudiantes de 4.° y 5.° de secundaria en la ciudad de Huancayo.

El sistema permite:

- Registro e inicio de sesión de usuarios
- Desarrollo de test vocacional
- Procesamiento de resultados
- Recomendación de carreras afines
- Almacenamiento de resultados en la nube

---

## 🎯 Problema Identificado

Muchos estudiantes finalizan la secundaria sin una orientación vocacional clara, lo que genera:

- Elección incorrecta de carrera
- Insatisfacción académica
- Abandono universitario temprano

El sistema propone una solución digital utilizando análisis de resultados y almacenamiento en la nube.

---

## 🏗 Arquitectura del Sistema

La aplicación sigue el patrón **MVVM (Model - View - ViewModel)**.

### 📂 Estructura del Proyecto

```
lib/
│
├── models/        # Modelos de datos
├── services/      # Servicios Firebase
├── viewmodels/    # Lógica de negocio
├── views/         # Interfaces de usuario
└── main.dart
```

---

## ☁️ Backend - Firebase

Se utiliza Firebase como Backend-as-a-Service (BaaS):

- Firebase Authentication (registro/login)
- Cloud Firestore (base de datos NoSQL)

---

## 🗄 Estructura de Base de Datos (Firestore)

### 📁 Colección: usuarios

Almacena información del perfil del estudiante.

```json
{
  "nombreCompleto": "Ana",
  "correo": "ana@gmail.com",
  "colegio": "Colegio Ingeniería",
  "grado": "5to año de secundaria",
  "telefono": "987654567"
}
```

---

### 📁 Colección: resultados

Almacena los resultados generados tras completar el test vocacional.

```json
{
  "areaPrincipal": "Salud",
  "carrerasAfines": [
    "Medicina Humana",
    "Psicología",
    "Tecnología Médica"
  ],
  "porcentajesTest": {
    "Aptitudes": 40,
    "Intereses": 35,
    "Personalidad": 25
  },
  "respuesta": "Enfermería",
  "fecha": "timestamp"
}
```

---

### 📁 Colección: carreras

Contiene información general de cada carrera profesional.

```json
{
  "nombre": "Administración de Empresas",
  "descripcion": "Carrera orientada a la gestión organizacional y estratégica."
}
```

---

## 🚀 Instalación

### 🔹 Prerrequisitos

- Flutter SDK 3.16+
- Dart SDK 3.2+
- Android Studio o VS Code
- Cuenta en Firebase

---

### 🔹 Clonar el repositorio

```bash
git clone https://github.com/AxelAndr123456789/Taller_De_Proyectos.git
cd Taller_De_Proyectos
```

---

### 🔹 Instalar dependencias

```bash
flutter pub get
```

---

### 🔹 Configurar Firebase

1. Crear proyecto en Firebase Console.
2. Registrar aplicación Android.
3. Descargar `google-services.json`.
4. Colocar el archivo en:

```
android/app/
```

5. Habilitar:
   - Authentication (Email/Password)
   - Cloud Firestore

---

### 🔹 Ejecutar la aplicación

```bash
flutter run
```

---

## 🔧 Build de Producción

### APK

```bash
flutter build apk --release
```

### AppBundle (Play Store)

```bash
flutter build appbundle --release
```

---

## 📊 Pruebas Realizadas

- Registro de usuario ✅
- Inicio de sesión ✅
- Desarrollo completo del test vocacional ✅
- Generación de resultados ✅
- Almacenamiento en Firestore ✅

---

## 🔐 Seguridad

- Autenticación gestionada por Firebase Authentication.
- Base de datos protegida mediante reglas de seguridad de Firestore.
- Validación de campos en formularios.

---

## 🎓 Proyecto Académico

**Universidad Continental**  
Taller de Proyectos I  

Integrantes:
- Cortez Ponce Brianna
- Lopez Rodriguez Axel
- Meza Calderon Ana  

Huancayo - Perú  
2026

---

🔗 Repositorio:
https://github.com/AxelAndr123456789/Taller_De_Proyectos
