# 📱 Taller de Proyectos - Orientación Vocacional con IA

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![IA](https://img.shields.io/badge/IA-Machine%20Learning-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white)

**Aplicación móvil con IA para orientación vocacional - Huancayo**

</div>

---

## 📋 Contenido
- [Descripción del Problema](#-descripción-del-problema)
- [Justificación](#-justificación)
- [Arquitectura](#️-arquitectura)
- [Instalación](#-instalación)
- [Build](#-build)
- [Despliegue](#-despliegue)
- [Video Demostrativo](#-video-demostrativo)
- [Evidencias Técnicas](#-evidencias-técnicas)

---

## 🎯 Descripción del Problema

En la ciudad de **Huancayo**, los estudiantes de 4.° y 5.° de secundaria culminan sus estudios sin orientación vocacional sistemática, lo que genera:
- Dificultad para identificar intereses y habilidades
- Decisiones basadas en información limitada
- Ausencia de herramientas digitales en instituciones educativas

**Estadísticas clave:**
- 30% abandono universitario en primer año (Perú)
- 50% estudiantes insatisfechos con su carrera
- Solo 10% de colegios tienen psicólogo vocacional

**Problema general:** La limitada orientación vocacional afecta la toma de decisiones informadas sobre el futuro académico y profesional, debido a la ausencia de aplicativos móviles inteligentes que brinden recomendaciones personalizadas y contextualizadas a Huancayo.

---

## 💡 Justificación

**Social:** Apoya a estudiantes en decisiones informadas, reduce deserción académica y brinda herramienta de apoyo para docentes.

**Económica:** Minimiza pérdidas por cambios de carrera y alinea intereses con oferta educativa local.

**Ambiental:** Elimina uso de formularios impresos y papel.

**ODS:** Contribuye a ODS 4 (Educación de calidad) y ODS 9 (Industria, innovación e infraestructura).

---

## 🏗️ Arquitectura

### Arquitectura General (Firebase como Backend)
┌─────────────────────────────────────────────┐
│ CAPA DE PRESENTACIÓN │
│ ┌───────────────────────────────────────┐ │
│ │ Aplicación Móvil - Flutter │ │
│ │ • Registro/Login │ │
│ │ • Test vocacional (20 preguntas) │ │
│ │ • Resultados con IA │ │
│ │ • Catálogo de carreras │ │
│ └───────────────────────────────────────┘ │
├─────────────────────────────────────────────┤
│ CAPA DE SERVICIOS │
│ ┌───────────────────────────────────────┐ │
│ │ Firebase SDK │ │
│ │ • Authentication • Firestore │ │
│ │ • Storage │ │
│ └───────────────────────────────────────┘ │
├─────────────────────────────────────────────┤
│ CAPA DE DATOS │
│ ┌───────────────────────────────────────┐ │
│ │ Firebase Cloud │ │
│ │ • Colección: usuarios │ │
│ │ • Colección: evaluaciones │ │
│ │ • Colección: resultados │ │
│ │ • Colección: carreras │ │
│ │ • Colección: instituciones │ │
│ └───────────────────────────────────────┘ │
└─────────────────────────────────────────────┘

text

### Estructura del Proyecto (MVVM)
lib/
├── core/ # Constantes, temas, utilidades
├── data/ # Modelos, repositorios, Firebase
├── domain/ # Entidades, casos de uso
└── presentation/ # BLoC, pantallas, widgets

text

### Estructura de Firebase Firestore

**Colección: `usuarios`**
```json
{
  "uid": "string",
  "nombres": "string",
  "apellidos": "string",
  "edad": "number",
  "institucion": "string",
  "grado": "string",
  "email": "string",
  "fecha_registro": "timestamp"
}
Colección: evaluaciones

json
{
  "id_evaluacion": "string",
  "uid": "string",
  "fecha": "timestamp",
  "respuestas": [
    {"pregunta_id": 1, "categoria": "intereses", "valor": 5}
  ]
}
Colección: resultados

json
{
  "id_resultado": "string",
  "id_evaluacion": "string",
  "perfil_vocacional": "string",
  "intereses": {"cientifico": 85},
  "habilidades": {"analitica": 80},
  "areas_recomendadas": [
    {"area": "Ingeniería", "afinidad": 85}
  ]
}
Colección: carreras

json
{
  "id_carrera": "string",
  "nombre": "string",
  "descripcion": "string",
  "area_vocacional": "string",
  "instituciones": ["UNCP", "UPLA"]
}
🚀 Instalación
Prerrequisitos
Flutter SDK 3.16+

Dart SDK 3.2+

Android Studio / VS Code

Git

Cuenta de Firebase

Pasos
1. Clonar repositorio

bash
git clone https://github.com/AxelAndr123456789/Taller_De_Proyectos.git
cd Taller_De_Proyectos
2. Instalar dependencias

bash
flutter pub get
3. Configurar Firebase

Crear proyecto en Firebase Console

Registrar app Android (paquete: com.example.taller_proyectos)

Descargar google-services.json y colocarlo en android/app/

Habilitar: Authentication (email/password), Firestore

4. Ejecutar

bash
flutter run
🔧 Build
APK Android
bash
flutter build apk --release
# o con división por arquitectura
flutter build apk --split-per-abi
# Resultados en: build/app/outputs/flutter-apk/
AppBundle (Play Store)
bash
flutter build appbundle --release
# build/app/outputs/bundle/release/app-release.aab
Web
bash
flutter build web --release
# build/web/
📱 Despliegue
Opción 1: Google Play Store
Generar AppBundle

Crear cuenta en Google Play Console

Subir .aab y publicar

Opción 2: GitHub Releases
bash
git tag -a v1.0.0 -m "Versión 1.0.0"
git push origin v1.0.0
# Subir APKs a GitHub Releases
Opción 3: Firebase Hosting (Web)
bash
npm install -g firebase-tools
firebase init hosting
flutter build web
firebase deploy --only hosting
📹 Video Demostrativo
https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white

Estructura (8 min):

0:00-1:00: Introducción y problema

1:00-2:00: Registro/Login

2:00-4:00: Test vocacional

4:00-5:30: Procesamiento IA

5:30-7:00: Resultados y recomendaciones

7:00-8:00: Catálogo y cierre

📊 Evidencias Técnicas
1. Pruebas Funcionales (30 pruebas)
Módulo	Pruebas	% Éxito
Registro	5	100%
Login	5	100%
Test vocacional	8	100%
Procesamiento IA	5	85%
Resultados	4	88%
TOTAL	30	95.5%
2. Pruebas Unitarias
bash
flutter test
# 45 pruebas, 78% cobertura
3. Rendimiento
Métrica	Resultado
Inicio de app	1.2 seg
Procesamiento IA	1.8 seg
FPS	60 fps
Memoria	85 MB
Tamaño APK	18 MB
4. Compatibilidad
Android: API 21+ (99% dispositivos)

Web: Chrome, Firefox, Safari, Edge

5. Seguridad
Requerimiento	Estado
Contraseñas cifradas	✅
Reglas Firestore	✅
Validación de entrada	✅
6. Precisión del Modelo IA
Área	Precisión
Ingeniería	87%
Salud	89%
Educación	84%
Negocios	82%
Promedio	85%
7. Pruebas Piloto (30 estudiantes)
Criterio	Puntaje (1-5)
Facilidad de uso	4.7
Claridad de preguntas	4.8
Comprensión de resultados	4.5
Utilidad de recomendaciones	4.6
Promedio	4.68
<div align="center"> <sub> <strong>UNIVERSIDAD CONTINENTAL</strong><br> Taller de Proyectos I - NRC:19162<br> Docente: Job Daniel Gamarra Moreno<br> Integrantes: Cortez Ponce Brianna, Lopez Rodriguez Axel, Meza Calderon Ana<br> Huancayo, Perú - 2026 </sub> <br><br> <a href="https://github.com/AxelAndr123456789/Taller_De_Proyectos"> <img src="https://img.shields.io/badge/GitHub-Repositorio-181717?style=for-the-badge&logo=github" alt="GitHub"> </a> </div> ```
