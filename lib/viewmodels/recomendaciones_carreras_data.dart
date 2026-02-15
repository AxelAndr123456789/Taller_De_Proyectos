import '../models/carrera.dart';

class CarrerasData {
  static const List<Carrera> carreras = [
    // CARRERAS PROFESIONALES (Universitarias) - 5 años

    // Administración
    Carrera(
      nombre: 'Administración de Empresas',
      descripcion: 'Formación en gestión empresarial, dirección de organizaciones, planificación estratégica y toma de decisiones empresariales.',
      imagenUrl: 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&h=400&fit=crop',
      habilidades: ['Gestión empresarial', 'Liderazgo', 'Análisis financiero', 'Toma de decisiones'],
      duracion: '5 años',
      mercadoLaboral: 'Empresas públicas y privadas, consultorías, instituciones financieras y emprendimiento.',
    ),
    Carrera(
      nombre: 'Administración y Finanzas',
      descripcion: 'Especialización en gestión financiera empresarial, análisis contable, inversiones y planificación financiera.',
      imagenUrl: 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&h=400&fit=crop',
      habilidades: ['Análisis financiero', 'Presupuestos', 'Evaluación de proyectos', 'Contabilidad gerencial'],
      duracion: '5 años',
      mercadoLaboral: 'Bancos, empresas financieras, consultorías, áreas financieras y auditoría.',
    ),
    Carrera(
      nombre: 'Administración y Gestión Pública',
      descripcion: 'Dirección de entidades públicas y políticas gubernamentales. Gestión de recursos estatales y desarrollo territorial.',
      imagenUrl: 'https://images.unsplash.com/photo-1541872703-74c5e44368f9?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1521791136064-7986c2920216?w=800&h=400&fit=crop',
      habilidades: ['Gestión pública', 'Políticas públicas', 'Presupuesto estatal', 'Desarrollo territorial'],
      duracion: '5 años',
      mercadoLaboral: 'Municipalidades, ministerios, organismos públicos y ONGs.',
    ),
    Carrera(
      nombre: 'Administración y Marketing',
      descripcion: 'Gestión empresarial con enfoque en estrategias de mercado. Investigación de mercados y gestión de marca.',
      imagenUrl: 'https://images.unsplash.com/photo-1533750349088-cd871a92f312?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1551434678-e076c223a692?w=800&h=400&fit=crop',
      habilidades: ['Estrategia de marketing', 'Investigación de mercados', 'Branding', 'Gestión comercial'],
      duracion: '5 años',
      mercadoLaboral: 'Empresas de consumo masivo, agencias de publicidad, retail y consultorías de marketing.',
    ),
    Carrera(
      nombre: 'Administración y Negocios Internacionales',
      descripcion: 'Gestión empresarial en contexto global. Comercio exterior, logística internacional y negociación multicultural.',
      imagenUrl: 'https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&h=400&fit=crop',
      habilidades: ['Comercio exterior', 'Logística internacional', 'Negociación', 'Idiomas'],
      duracion: '5 años',
      mercadoLaboral: 'Empresas exportadoras, agencias aduaneras, consultorías de comercio y multinacionales.',
    ),

    // Agronomía
    Carrera(
      nombre: 'Agronomía',
      descripcion: 'Ciencia aplicada a la producción agrícola. Manejo de cultivos, suelos, plagas y tecnologías agrícolas.',
      imagenUrl: 'https://images.unsplash.com/photo-1574943320219-553eb213f72d?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop',
      habilidades: ['Manejo de cultivos', 'Edafología', 'Fitosanidad', 'Agricultura sostenible'],
      duracion: '5 años',
      mercadoLaboral: 'Empresas agrícolas, exportadoras, consultorías, investigación y desarrollo rural.',
    ),

    // Antropología
    Carrera(
      nombre: 'Antropología',
      descripcion: 'Estudio de las culturas humanas y sus manifestaciones. Investigación social y gestión cultural.',
      imagenUrl: 'https://images.unsplash.com/photo-1461360370896-922624d12aa1?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?w=800&h=400&fit=crop',
      habilidades: ['Investigación etnográfica', 'Análisis cultural', 'Metodología cualitativa', 'Preservación patrimonial'],
      duracion: '5 años',
      mercadoLaboral: 'Investigación social, museos, patrimonio cultural, desarrollo comunitario y consultoría.',
    ),

    // Arquitectura
    Carrera(
      nombre: 'Arquitectura',
      descripcion: 'Diseño y planificación de espacios habitables. Integración de arte, técnica y funcionalidad en proyectos arquitectónicos.',
      imagenUrl: 'https://images.unsplash.com/photo-1503387762-592deb58ef4e?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&h=400&fit=crop',
      habilidades: ['Diseño arquitectónico', 'Software CAD', 'Modelado 3D', 'Gestión de proyectos'],
      duracion: '5 años',
      mercadoLaboral: 'Estudios de arquitectura, constructoras, desarrollo inmobiliario y consultorías.',
    ),

    // Ciencias de la Comunicación
    Carrera(
      nombre: 'Ciencias de la Comunicación',
      descripcion: 'Estudio de los procesos de comunicación humana. Periodismo, relaciones públicas y producción audiovisual.',
      imagenUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&h=400&fit=crop',
      habilidades: ['Periodismo', 'Redacción', 'Producción audiovisual', 'Relaciones públicas'],
      duracion: '5 años',
      mercadoLaboral: 'Medios de comunicación, agencias de relaciones públicas, empresas, gobierno y freelance.',
    ),

    // Contabilidad
    Carrera(
      nombre: 'Contabilidad',
      descripcion: 'Registro y análisis de operaciones financieras. Elaboración de estados financieros y cumplimiento tributario.',
      imagenUrl: 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1554224154-26032ffc0d07?w=800&h=400&fit=crop',
      habilidades: ['Contabilidad general', 'Software contable', 'Tributación', 'Análisis financiero'],
      duracion: '5 años',
      mercadoLaboral: 'Empresas de todos los sectores, estudios contables, auditorías y consultorías tributarias.',
    ),
    Carrera(
      nombre: 'Contabilidad y Finanzas',
      descripcion: 'Formación integral en contabilidad y gestión financiera. Análisis de inversiones y planificación patrimonial.',
      imagenUrl: 'https://images.unsplash.com/photo-1554224154-26032ffc0d07?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&h=400&fit=crop',
      habilidades: ['Contabilidad avanzada', 'Finanzas corporativas', 'Auditoría', 'Presupuestos'],
      duracion: '5 años',
      mercadoLaboral: 'Empresas financieras, banca, auditorías, consultorías y áreas financieras.',
    ),

    // Derecho
    Carrera(
      nombre: 'Derecho',
      descripcion: 'Formación en normas jurídicas y su aplicación. Litigación, asesoría legal y gestión de conflictos jurídicos.',
      imagenUrl: 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1505664194779-8beaceb93744?w=800&h=400&fit=crop',
      habilidades: ['Argumentación jurídica', 'Redacción legal', 'Análisis de casos', 'Negociación'],
      duracion: '5 años',
      mercadoLaboral: 'Estudios de abogados, empresas, sector público, defensoría y poder judicial.',
    ),
    Carrera(
      nombre: 'Derecho y Ciencias Políticas',
      descripcion: 'Integración de derecho con análisis político. Relaciones internacionales y gestión pública.',
      imagenUrl: 'https://images.unsplash.com/photo-1541872703-74c5e44368f9?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?w=800&h=400&fit=crop',
      habilidades: ['Derecho constitucional', 'Política comparada', 'Relaciones internacionales', 'Gestión pública'],
      duracion: '5 años',
      mercadoLaboral: 'Sector público, diplomacia, organismos internacionales, ONGs y consultoría política.',
    ),

    // Diseño Profesional de Interiores
    Carrera(
      nombre: 'Diseño Profesional de Interiores',
      descripcion: 'Especialización en diseño de espacios interiores funcionales y estéticos. Gestión de proyectos de decoración y remodelación.',
      imagenUrl: 'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=800&h=400&fit=crop',
      habilidades: ['Diseño de interiores', 'Renderización', 'Gestión de proyectos', 'Selección de materiales'],
      duracion: '5 años',
      mercadoLaboral: 'Estudios de diseño, constructoras, hoteles, retail y consultorías especializadas.',
    ),

    // Economía
    Carrera(
      nombre: 'Economía',
      descripcion: 'Análisis de sistemas económicos y políticas públicas. Investigación económica y asesoría financiera.',
      imagenUrl: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&h=400&fit=crop',
      habilidades: ['Análisis económico', 'Estadística', 'Investigación', 'Modelado económico'],
      duracion: '5 años',
      mercadoLaboral: 'Banca central, ministerios, investigación económica, consultorías y academia.',
    ),

    // Educación
    Carrera(
      nombre: 'Educación',
      descripcion: 'Formación docente para diferentes niveles educativos. Pedagogía, didáctica y gestión educativa.',
      imagenUrl: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=800&h=400&fit=crop',
      habilidades: ['Pedagogía', 'Gestión del aula', 'Planificación didáctica', 'Evaluación educativa'],
      duracion: '5 años',
      mercadoLaboral: 'Colegios públicos y privados, instituciones educativas, consultorías y gestión educativa.',
    ),
    Carrera(
      nombre: 'Educación Inicial',
      descripcion: 'Formación docente para la primera infancia. Desarrollo integral de niños de 0 a 5 años.',
      imagenUrl: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?w=800&h=400&fit=crop',
      habilidades: ['Didáctica infantil', 'Psicología del desarrollo', 'Creatividad', 'Juego educativo'],
      duracion: '5 años',
      mercadoLaboral: 'Instituciones educativas inicial, jardines, guarderías, consultoría educativa y ONGs.',
    ),
    Carrera(
      nombre: 'Educación Primaria',
      descripcion: 'Preparación para la enseñanza en nivel primario. Formación integral en pedagogía y didáctica.',
      imagenUrl: 'https://images.unsplash.com/photo-1509062522246-3755977927d7?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=800&h=400&fit=crop',
      habilidades: ['Pedagogía', 'Gestión del aula', 'Planificación didáctica', 'Evaluación educativa'],
      duracion: '5 años',
      mercadoLaboral: 'Colegios públicos y privados, instituciones educativas, consultorías y gestión educativa.',
    ),
    Carrera(
      nombre: 'Educación Secundaria',
      descripcion: 'Especialización docente para nivel secundario. Formación en diversas áreas del conocimiento.',
      imagenUrl: 'https://images.unsplash.com/photo-1427504740701-44c33e1d62f2?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=800&h=400&fit=crop',
      habilidades: ['Especialización disciplinar', 'Didáctica especializada', 'Gestión del aula', 'Tutoría'],
      duracion: '5 años',
      mercadoLaboral: 'Colegios secundarios, institutos, academias, universidades e instituciones educativas.',
    ),

    // Enfermería
    Carrera(
      nombre: 'Enfermería',
      descripcion: 'Formación en atención integral del paciente, administración de medicamentos, cuidados de enfermería y apoyo en procedimientos médicos.',
      imagenUrl: 'https://images.unsplash.com/photo-1551076805-e1869033e561?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&h=400&fit=crop',
      habilidades: ['Atención al paciente', 'Trabajo bajo presión', 'Empatía', 'Comunicación efectiva'],
      duracion: '5 años',
      mercadoLaboral: 'Alta demanda en hospitales públicos y privados, clínicas, centros de salud, empresas mineras y oportunidades internacionales.',
    ),

    // Estomatología
    Carrera(
      nombre: 'Estomatología',
      descripcion: 'Especialización en diagnóstico y tratamiento de enfermedades del sistema estomatognático. Incluye cirugía maxilofacial.',
      imagenUrl: 'https://images.unsplash.com/photo-1606811971618-4486d14f3f99?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1629909613654-28e377c37b09?w=800&h=400&fit=crop',
      habilidades: ['Cirugía oral', 'Diagnóstico', 'Destreza quirúrgica', 'Atención al paciente'],
      duracion: '5 años',
      mercadoLaboral: 'Hospitales, clínicas estomatológicas, consultorios privados y servicios de salud pública.',
    ),

    // Farmacia y Bioquímica
    Carrera(
      nombre: 'Farmacia y Bioquímica',
      descripcion: 'Formación en ciencias farmacéuticas, análisis clínicos y bioquímica. Preparación para el desarrollo y control de medicamentos.',
      imagenUrl: 'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1583947581924-860b8c7d7e3f?w=800&h=400&fit=crop',
      habilidades: ['Análisis químico', 'Control de calidad', 'Gestión farmacéutica', 'Investigación'],
      duracion: '5 años',
      mercadoLaboral: 'Laboratorios clínicos, farmacias, industria farmacéutica, investigación científica y control de calidad.',
    ),

    // Ingenierías
    Carrera(
      nombre: 'Ingeniería Ambiental',
      descripcion: 'Desarrollo de soluciones para la protección del medio ambiente. Gestión de residuos, tratamiento de aguas y energías renovables.',
      imagenUrl: 'https://images.unsplash.com/photo-1497436072909-60f360e1d4b1?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1466611653911-95081537e5b7?w=800&h=400&fit=crop',
      habilidades: ['Gestión ambiental', 'Tratamiento de aguas', 'Energías renovables', 'Normativa ambiental'],
      duracion: '5 años',
      mercadoLaboral: 'Consultorías ambientales, empresas mineras, industria y sector público.',
    ),
    Carrera(
      nombre: 'Ingeniería Civil',
      descripcion: 'Diseño, construcción y mantenimiento de infraestructuras como puentes, carreteras, edificios y sistemas de agua.',
      imagenUrl: 'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=800&h=400&fit=crop',
      habilidades: ['Diseño estructural', 'Gestión de proyectos', 'Cálculo de estructuras', 'Software CAD'],
      duracion: '5 años',
      mercadoLaboral: 'Constructoras, consultoras, sector público, empresas mineras e hidrocarburos.',
    ),
    Carrera(
      nombre: 'Ingeniería del Medio Ambiente',
      descripcion: 'Formación en sostenibilidad y gestión de recursos naturales. Proyectos de remediación y conservación ambiental.',
      imagenUrl: 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?w=800&h=400&fit=crop',
      habilidades: ['Sostenibilidad', 'Gestión de recursos', 'Evaluación de impacto', 'Legislación ambiental'],
      duracion: '5 años',
      mercadoLaboral: 'ONGs, empresas comprometidas con sostenibilidad, gobiernos y organismos internacionales.',
    ),
    Carrera(
      nombre: 'Ingeniería de Minas',
      descripcion: 'Extracción y procesamiento de minerales. Gestión de operaciones mineras y seguridad en faenas extractivas.',
      imagenUrl: 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1565008447742-97f6f38c985c?w=800&h=400&fit=crop',
      habilidades: ['Operaciones mineras', 'Geomecánica', 'Seguridad industrial', 'Optimización de procesos'],
      duracion: '5 años',
      mercadoLaboral: 'Empresas mineras, consultorías, proveedores mineros y sector energético.',
    ),
    Carrera(
      nombre: 'Ingeniería de Sistemas',
      descripcion: 'Integración de tecnologías de información para optimizar procesos organizacionales. Gestión de redes y sistemas computacionales.',
      imagenUrl: 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&h=400&fit=crop',
      habilidades: ['Gestión de redes', 'Seguridad informática', 'Administración de sistemas', 'Análisis de procesos'],
      duracion: '5 años',
      mercadoLaboral: 'Empresas de todos los sectores, consultorías TI, telecomunicaciones y desarrollo de software.',
    ),
    Carrera(
      nombre: 'Ingeniería de Sistemas e Informática',
      descripcion: 'Enfoque en soluciones tecnológicas integrales. Desarrollo de software, gestión de bases de datos y transformación digital.',
      imagenUrl: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1504639725590-34d0984388bd?w=800&h=400&fit=crop',
      habilidades: ['Desarrollo de software', 'Análisis de datos', 'Gestión de proyectos TI', 'Cloud computing'],
      duracion: '5 años',
      mercadoLaboral: 'Empresas tecnológicas, consultoras, banca, telecomunicaciones e industria.',
    ),
    Carrera(
      nombre: 'Ingeniería de Sistemas y Computación',
      descripcion: 'Formación en ciencias de la computación aplicada. Diseño de algoritmos, inteligencia artificial y computación avanzada.',
      imagenUrl: 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&h=400&fit=crop',
      habilidades: ['Algoritmos', 'Inteligencia artificial', 'Computación distribuida', 'Investigación'],
      duracion: '5 años',
      mercadoLaboral: 'Investigación, desarrollo de tecnología, empresas de software, academia y startups.',
    ),
    Carrera(
      nombre: 'Ingeniería de Software',
      descripcion: 'Diseño, desarrollo y mantenimiento de aplicaciones y sistemas informáticos. Programación en diversos lenguajes y metodologías ágiles.',
      imagenUrl: 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800&h=400&fit=crop',
      habilidades: ['Programación', 'Diseño de sistemas', 'Bases de datos', 'Metodologías ágiles'],
      duracion: '5 años',
      mercadoLaboral: 'Empresas tecnológicas, startups, consultorías TI, desarrollo de apps y videojuegos.',
    ),
    Carrera(
      nombre: 'Ingeniería Eléctrica',
      descripcion: 'Generación, transmisión y distribución de energía eléctrica. Diseño de sistemas eléctricos y automatización.',
      imagenUrl: 'https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&h=400&fit=crop',
      habilidades: ['Sistemas eléctricos', 'Automatización', 'Electrónica de potencia', 'Software de diseño'],
      duracion: '5 años',
      mercadoLaboral: 'Empresas eléctricas, industria manufacturera, energías renovables y sector construcción.',
    ),
    Carrera(
      nombre: 'Ingeniería Eléctrica y Electrónica',
      descripcion: 'Integración de sistemas eléctricos y electrónicos. Desarrollo de circuitos, control automático y telecomunicaciones.',
      imagenUrl: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1563770660941-20978e870e26?w=800&h=400&fit=crop',
      habilidades: ['Electrónica', 'Control automático', 'Telecomunicaciones', 'Diseño de circuitos'],
      duracion: '5 años',
      mercadoLaboral: 'Industria electrónica, telecomunicaciones, automatización y energía.',
    ),
    Carrera(
      nombre: 'Ingeniería Industrial',
      descripcion: 'Optimización de procesos productivos y sistemas de manufactura. Gestión de operaciones y mejora continua en organizaciones.',
      imagenUrl: 'https://images.unsplash.com/photo-1565043666747-69f6646db940?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1565514020176-dbf2277e495e?w=800&h=400&fit=crop',
      habilidades: ['Gestión de operaciones', 'Lean manufacturing', 'Logística', 'Control de calidad'],
      duracion: '5 años',
      mercadoLaboral: 'Industria manufacturera, retail, logística, consultorías y empresas de servicios.',
    ),
    Carrera(
      nombre: 'Ingeniería Mecánica',
      descripcion: 'Diseño y análisis de sistemas mecánicos. Desarrollo de maquinaria, vehículos y equipos industriales.',
      imagenUrl: 'https://images.unsplash.com/photo-1537462715879-360eeb61a0ad?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=800&h=400&fit=crop',
      habilidades: ['Diseño mecánico', 'Termodinámica', 'Materiales', 'Mantenimiento industrial'],
      duracion: '5 años',
      mercadoLaboral: 'Industria automotriz, manufacturera, energética, minera y consultorías especializadas.',
    ),
    Carrera(
      nombre: 'Ingeniería Mecatrónica',
      descripcion: 'Integración de mecánica, electrónica e informática. Diseño de sistemas robóticos y automatización industrial.',
      imagenUrl: 'https://images.unsplash.com/photo-1581092160562-40aa08e78837?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=800&h=400&fit=crop',
      habilidades: ['Robótica', 'Control automático', 'Electrónica', 'Programación de PLC'],
      duracion: '5 años',
      mercadoLaboral: 'Industria manufacturera, automotriz, robótica, automatización y energía.',
    ),
    Carrera(
      nombre: 'Ingeniería Metalúrgica y de Materiales',
      descripcion: 'Procesamiento de metales y desarrollo de nuevos materiales. Optimización de procesos metalúrgicos y control de calidad.',
      imagenUrl: 'https://images.unsplash.com/photo-1565043666747-69f6646db940?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1504328345606-18bbc8c9d7d1?w=800&h=400&fit=crop',
      habilidades: ['Metalurgia', 'Ciencia de materiales', 'Procesos industriales', 'Ensayos mecánicos'],
      duracion: '5 años',
      mercadoLaboral: 'Industria minera, metalúrgica, cementera, automotriz y manufacturera.',
    ),
    Carrera(
      nombre: 'Ingeniería Química',
      descripcion: 'Diseño de procesos químicos industriales. Producción de alimentos, farmacéuticos, petroquímicos y materiales.',
      imagenUrl: 'https://images.unsplash.com/photo-1579165466949-3180a3d056d5?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1581093458791-9d42e3c7e117?w=800&h=400&fit=crop',
      habilidades: ['Procesos químicos', 'Balances de masa', 'Operaciones unitarias', 'Control de procesos'],
      duracion: '5 años',
      mercadoLaboral: 'Industria petroquímica, alimentaria, farmacéutica, minera y ambiental.',
    ),

    // Medicina Humana
    Carrera(
      nombre: 'Medicina Humana',
      descripcion: 'Preparación para el diagnóstico, tratamiento y prevención de enfermedades. Incluye formación clínica integral y prácticas en diversas especialidades médicas.',
      imagenUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1504813184591-01572f98c85f?w=800&h=400&fit=crop',
      habilidades: ['Diagnóstico clínico', 'Toma de decisiones', 'Análisis crítico', 'Comunicación médico-paciente'],
      duracion: '7 años',
      mercadoLaboral: 'Estable en ESSALUD, MINSA, hospitales privados, clínicas especializadas y consultorios particulares.',
    ),

    // Medicina Veterinaria y Zootecnia
    Carrera(
      nombre: 'Medicina Veterinaria y Zootecnia',
      descripcion: 'Cuidado de la salud animal y producción pecuaria. Incluye medicina veterinaria, reproducción y nutrición animal.',
      imagenUrl: 'https://images.unsplash.com/photo-1628009368231-7bb7cfcb0def?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1548767797-d8c844163c4c?w=800&h=400&fit=crop',
      habilidades: ['Cirugía veterinaria', 'Producción animal', 'Salud pública', 'Gestión ganadera'],
      duracion: '5 años',
      mercadoLaboral: 'Clínicas veterinarias, granjas, industria alimentaria, laboratorios e inspección sanitaria.',
    ),

    // Nutrición
    Carrera(
      nombre: 'Nutrición Humana',
      descripcion: 'Estudio de los alimentos y su impacto en la salud. Planificación de dietas personalizadas y prevención de enfermedades nutricionales.',
      imagenUrl: 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&h=400&fit=crop',
      habilidades: ['Planificación dietética', 'Educación nutricional', 'Análisis de alimentos', 'Asesoría'],
      duracion: '5 años',
      mercadoLaboral: 'Hospitales, clínicas, gimnasios, industria alimentaria, consultorios y programas de salud pública.',
    ),
    Carrera(
      nombre: 'Nutrición y Dietética',
      descripcion: 'Especialización en alimentación saludable y dietética clínica. Diseño de planes nutricionales para diversas condiciones de salud.',
      imagenUrl: 'https://images.unsplash.com/photo-1505576399279-565b52d4ac71?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=800&h=400&fit=crop',
      habilidades: ['Dietética clínica', 'Educación alimentaria', 'Gestión de servicios', 'Investigación'],
      duracion: '5 años',
      mercadoLaboral: 'Servicios de alimentación, hospitales, centros de rehabilitación y consulta privada.',
    ),

    // Obstetricia
    Carrera(
      nombre: 'Obstetricia',
      descripcion: 'Atención especializada en el embarazo, parto y puerperio. Cuidado integral de la mujer y el recién nacido.',
      imagenUrl: 'https://images.unsplash.com/photo-1559757175-5700dde675bc?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1559757175-5700dde675bc?w=800&h=400&fit=crop',
      habilidades: ['Atención neonatal', 'Cuidado prenatal', 'Trabajo en equipo', 'Toma de decisiones'],
      duracion: '5 años',
      mercadoLaboral: 'Hospitales de maternidad, clínicas ginecológicas, centros de salud y consultorios privados.',
    ),

    // Odontología
    Carrera(
      nombre: 'Odontología',
      descripcion: 'Especialización en salud bucal, diagnóstico y tratamiento de enfermedades dentales. Incluye cirugía oral, ortodoncia y rehabilitación dental.',
      imagenUrl: 'https://images.unsplash.com/photo-1606811971618-4486d14f3f99?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=800&h=400&fit=crop',
      habilidades: ['Destreza manual', 'Precisión quirúrgica', 'Empatía', 'Gestión de consultorio'],
      duracion: '5 años',
      mercadoLaboral: 'Muy bueno, con opciones de consultorio propio, clínicas dentales, hospitales y especializaciones.',
    ),

    // Optometría
    Carrera(
      nombre: 'Optometría',
      descripcion: 'Cuidado de la salud visual. Examen de la vista, prescripción de lentes correctivos y detección de enfermedades oculares.',
      imagenUrl: 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1580121441575-41bcb5c6b47c?w=800&h=400&fit=crop',
      habilidades: ['Examen visual', 'Adaptación de lentes', 'Atención al cliente', 'Tecnología óptica'],
      duracion: '5 años',
      mercadoLaboral: 'Ópticas, clínicas oftalmológicas, hospitales y consultorios especializados.',
    ),

    // Psicología
    Carrera(
      nombre: 'Psicología',
      descripcion: 'Estudio de la conducta humana y los procesos mentales. Formación en evaluación, diagnóstico e intervención psicológica en diversos contextos.',
      imagenUrl: 'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1493836512294-502baa1986e2?w=800&h=400&fit=crop',
      habilidades: ['Escucha activa', 'Análisis conductual', 'Empatía', 'Comunicación terapéutica'],
      duracion: '5 años',
      mercadoLaboral: 'Creciente demanda en clínicas, empresas, escuelas, hospitales y consultorios privados.',
    ),

    // Radiología
    Carrera(
      nombre: 'Radiología',
      descripcion: 'Especialización en técnicas de imagen diagnóstica. Uso de rayos X, tomografía, resonancia magnética y otros equipos.',
      imagenUrl: 'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1579154204601-01588f351e67?w=800&h=400&fit=crop',
      habilidades: ['Operación de equipos', 'Anatomía radiológica', 'Protección radiológica', 'Interpretación de imágenes'],
      duracion: '5 años',
      mercadoLaboral: 'Centros de diagnóstico por imagen, hospitales, clínicas y laboratorios especializados.',
    ),

    // Sociología
    Carrera(
      nombre: 'Sociología',
      descripcion: 'Análisis de la estructura y dinámica social. Investigación sobre grupos, instituciones y procesos sociales.',
      imagenUrl: 'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1531206715517-5c0ba140b2b8?w=800&h=400&fit=crop',
      habilidades: ['Análisis social', 'Metodología de investigación', 'Estadística social', 'Teoría sociológica'],
      duracion: '5 años',
      mercadoLaboral: 'Investigación social, ONGs, desarrollo social, planificación urbana y consultoría.',
    ),

    // Tecnología Médica
    Carrera(
      nombre: 'Tecnología Médica – Laboratorio Clínico y Anatomía Patológica',
      descripcion: 'Análisis de muestras biológicas para diagnóstico médico. Estudio de tejidos y células para detección de enfermedades.',
      imagenUrl: 'https://images.unsplash.com/photo-1582719471384-894fbb16e074?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1579165466949-3180a3d056d5?w=800&h=400&fit=crop',
      habilidades: ['Análisis de muestras', 'Técnicas de laboratorio', 'Microscopía', 'Control de calidad'],
      duracion: '5 años',
      mercadoLaboral: 'Laboratorios clínicos, hospitales, centros de investigación y bancos de sangre.',
    ),
    Carrera(
      nombre: 'Tecnología Médica',
      descripcion: 'Formación en procedimientos diagnósticos y terapéuticos especializados. Múltiples especialidades dentro del área de la salud.',
      imagenUrl: 'https://images.unsplash.com/photo-1532938911079-1b06ac7ceec7?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?w=800&h=400&fit=crop',
      habilidades: ['Procedimientos técnicos', 'Operación de equipos', 'Análisis de resultados', 'Trabajo en equipo'],
      duracion: '5 años',
      mercadoLaboral: 'Laboratorios, hospitales, clínicas especializadas y centros de diagnóstico por imagen.',
    ),
    Carrera(
      nombre: 'Tecnología Médica – Terapia Física y Rehabilitación',
      descripcion: 'Tratamiento de pacientes con discapacidades físicas mediante técnicas de rehabilitación, ejercicios terapéuticos y agentes físicos.',
      imagenUrl: 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&h=400&fit=crop',
      habilidades: ['Rehabilitación física', 'Evaluación funcional', 'Planificación terapéutica', 'Trabajo interdisciplinario'],
      duracion: '5 años',
      mercadoLaboral: 'Centros de rehabilitación, hospitales, clínicas deportivas, geriátricos y consultorios privados.',
    ),

    // Terapia Física
    Carrera(
      nombre: 'Terapia Física',
      descripcion: 'Restauración de la funcionalidad física mediante técnicas terapéuticas. Trabajo con pacientes post-operatorios y traumatológicos.',
      imagenUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=800&h=400&fit=crop',
      habilidades: ['Masoterapia', 'Electroterapia', 'Ejercicios terapéuticos', 'Valoración física'],
      duracion: '5 años',
      mercadoLaboral: 'Hospitales, clínicas de rehabilitación, centros deportivos, geriátricos y práctica privada.',
    ),

    // Trabajo Social
    Carrera(
      nombre: 'Trabajo Social',
      descripcion: 'Intervención social para mejorar la calidad de vida. Atención a grupos vulnerables y desarrollo comunitario.',
      imagenUrl: 'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1469571486292-0ba58a3f068b?w=800&h=400&fit=crop',
      habilidades: ['Intervención social', 'Trabajo comunitario', 'Empatía', 'Gestión de casos'],
      duracion: '5 años',
      mercadoLaboral: 'Municipalidades, programas sociales, ONGs, hospitales y servicios de bienestar social.',
    ),

    // Zootecnia
    Carrera(
      nombre: 'Zootecnia',
      descripcion: 'Producción y mejoramiento genético de animales domésticos. Nutrición, reproducción y sanidad animal.',
      imagenUrl: 'https://images.unsplash.com/photo-1500595046743-cd271d694d30?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1500595046743-cd271d694d30?w=800&h=400&fit=crop',
      habilidades: ['Producción animal', 'Nutrición animal', 'Reproducción', 'Sanidad animal'],
      duracion: '5 años',
      mercadoLaboral: 'Granjas, industria pecuaria, alimentos, investigación y consultoría agropecuaria.',
    ),

    // CARRERAS TÉCNICAS (Institutos) - 3 años

    // Administración Técnica
    Carrera(
      nombre: 'Administración de Empresas (Técnica)',
      descripcion: 'Formación técnica en operaciones administrativas empresariales. Gestión de recursos y procesos organizacionales.',
      imagenUrl: 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&h=400&fit=crop',
      habilidades: ['Gestión administrativa', 'Organización', 'Atención al cliente', 'Software ofimático'],
      duracion: '3 años',
      mercadoLaboral: 'Empresas de todos los sectores, oficinas administrativas y servicios ejecutivos.',
    ),
    Carrera(
      nombre: 'Administración de Negocios Bancarios y Financieros',
      descripcion: 'Formación técnica en operaciones bancarias y servicios financieros. Gestión de créditos, inversiones y riesgos financieros.',
      imagenUrl: 'https://images.unsplash.com/photo-1565514020176-dbf2277e495e?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&h=400&fit=crop',
      habilidades: ['Operaciones bancarias', 'Análisis crediticio', 'Riesgo financiero', 'Productos financieros'],
      duracion: '3 años',
      mercadoLaboral: 'Bancos, instituciones financieras, cooperativas, aseguradoras y fondos de inversión.',
    ),
    Carrera(
      nombre: 'Asistencia Administrativa',
      descripcion: 'Apoyo en funciones administrativas y secretariales. Manejo de correspondencia, agendas y documentación.',
      imagenUrl: 'https://images.unsplash.com/photo-1521791136064-7986c2920216?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=800&h=400&fit=crop',
      habilidades: ['Ofimática avanzada', 'Redacción', 'Organización', 'Comunicación telefónica'],
      duracion: '3 años',
      mercadoLaboral: 'Oficinas administrativas, consultorios, embajadas y servicios ejecutivos.',
    ),
    Carrera(
      nombre: 'Gestión Administrativa',
      descripcion: 'Formación técnica en procesos administrativos. Organización de documentos, atención al cliente y gestión de oficina.',
      imagenUrl: 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&h=400&fit=crop',
      habilidades: ['Organización administrativa', 'Software ofimático', 'Archivo documental', 'Atención al cliente'],
      duracion: '3 años',
      mercadoLaboral: 'Empresas de todos los sectores, oficinas gubernamentales y servicios administrativos.',
    ),

    // Construcción
    Carrera(
      nombre: 'Construcción Civil',
      descripcion: 'Formación técnica en procesos constructivos. Supervisión de obras y gestión de recursos en proyectos de construcción.',
      imagenUrl: 'https://images.unsplash.com/photo-1503387762-592deb58ef4e?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=800&h=400&fit=crop',
      habilidades: ['Supervisión de obras', 'Lectura de planos', 'Control de calidad', 'Gestión de materiales'],
      duracion: '3 años',
      mercadoLaboral: 'Constructoras, consultoras, proyectos inmobiliarios y sector público.',
    ),
    Carrera(
      nombre: 'Gestión de la Construcción',
      descripcion: 'Administración de proyectos de construcción. Control de costos, plazos y calidad en obras civiles.',
      imagenUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=800&h=400&fit=crop',
      habilidades: ['Gestión de proyectos', 'Control de costos', 'Planificación', 'Administración de obras'],
      duracion: '3 años',
      mercadoLaboral: 'Constructoras, inmobiliarias, consultoras y empresas de gestión de proyectos.',
    ),

    // Contabilidad Técnica
    Carrera(
      nombre: 'Contabilidad (Técnica)',
      descripcion: 'Formación técnica en registro y análisis de operaciones financieras. Manejo de software contable y tributación básica.',
      imagenUrl: 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1554224154-26032ffc0d07?w=800&h=400&fit=crop',
      habilidades: ['Contabilidad general', 'Software contable', 'Tributación', 'Análisis financiero'],
      duracion: '3 años',
      mercadoLaboral: 'Empresas de todos los sectores, estudios contables y consultorías tributarias.',
    ),

    // Diseño Técnico
    Carrera(
      nombre: 'Desarrollo de Sistemas de Información',
      descripcion: 'Formación técnica en análisis y desarrollo de software. Creación de aplicaciones y gestión de bases de datos.',
      imagenUrl: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800&h=400&fit=crop',
      habilidades: ['Programación', 'Bases de datos', 'Análisis de requerimientos', 'Testing'],
      duracion: '3 años',
      mercadoLaboral: 'Empresas de software, startups, consultorías TI y departamentos de sistemas.',
    ),
    Carrera(
      nombre: 'Diseño de Interiores (Técnico)',
      descripcion: 'Creación de ambientes interiores atractivos y funcionales. Selección de mobiliario, colores, texturas e iluminación.',
      imagenUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?w=800&h=400&fit=crop',
      habilidades: ['Decoración', 'Diseño de mobiliario', 'Iluminación', 'Renderización'],
      duracion: '3 años',
      mercadoLaboral: 'Estudios de diseño, tiendas de decoración, constructoras y clientes particulares.',
    ),
    Carrera(
      nombre: 'Diseño de Modas',
      descripcion: 'Creación de prendas de vestir y accesorios. Desarrollo de colecciones, patronaje y gestión de marca de moda.',
      imagenUrl: 'https://images.unsplash.com/photo-1558171813-4c088753af8f?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=800&h=400&fit=crop',
      habilidades: ['Diseño de prendas', 'Patronaje', 'Tendencias de moda', 'Ilustración de moda'],
      duracion: '3 años',
      mercadoLaboral: 'Marcas de moda, talleres textiles, exportación, retail y emprendimiento propio.',
    ),
    Carrera(
      nombre: 'Diseño Gráfico Publicitario',
      descripcion: 'Creación de piezas visuales para comunicación y marketing. Diseño de identidad corporativa, publicidad y medios digitales.',
      imagenUrl: 'https://images.unsplash.com/photo-1626785774573-4b799315345d?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800&h=400&fit=crop',
      habilidades: ['Diseño editorial', 'Branding', 'Ilustración', 'Software de diseño'],
      duracion: '3 años',
      mercadoLaboral: 'Agencias de publicidad, estudios de diseño, empresas de marketing y freelance.',
    ),
    Carrera(
      nombre: 'Diseño y Programación Web',
      descripcion: 'Creación de interfaces digitales y desarrollo frontend. Diseño UX/UI y programación de sitios web funcionales.',
      imagenUrl: 'https://images.unsplash.com/photo-1547658719-da2b51169166?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=400&fit=crop',
      habilidades: ['Diseño web', 'HTML/CSS/JavaScript', 'UX/UI', 'Responsive design'],
      duracion: '3 años',
      mercadoLaboral: 'Agencias digitales, empresas tecnológicas, startups y trabajo freelance.',
    ),

    // Electricidad
    Carrera(
      nombre: 'Electricidad Industrial',
      descripcion: 'Formación técnica en instalaciones eléctricas industriales. Mantenimiento de sistemas eléctricos y automatización básica.',
      imagenUrl: 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&h=400&fit=crop',
      habilidades: ['Instalaciones eléctricas', 'Mantenimiento', 'Lectura de planos', 'Seguridad eléctrica'],
      duracion: '3 años',
      mercadoLaboral: 'Industria manufacturera, constructoras, empresas eléctricas y servicios de mantenimiento.',
    ),

    // Enfermería Técnica
    Carrera(
      nombre: 'Enfermería Técnica',
      descripcion: 'Formación técnica en cuidados de enfermería básicos. Asistencia en procedimientos médicos y atención al paciente hospitalizado.',
      imagenUrl: 'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1581056771107-24ca5f033842?w=800&h=400&fit=crop',
      habilidades: ['Cuidados básicos', 'Administración de medicamentos', 'Toma de signos vitales', 'Atención al paciente'],
      duracion: '3 años',
      mercadoLaboral: 'Hospitales, clínicas, centros de salud, servicios de enfermería domiciliaria.',
    ),

    // Farmacia Técnica
    Carrera(
      nombre: 'Farmacia Técnica',
      descripcion: 'Preparación técnica para el manejo de medicamentos. Dispensación farmacéutica y atención en farmacias y boticas.',
      imagenUrl: 'https://images.unsplash.com/photo-1585435557343-3b092031a831?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1631549916768-4119b2e5f926?w=800&h=400&fit=crop',
      habilidades: ['Dispensación de medicamentos', 'Atención farmacéutica', 'Control de inventario', 'Regulaciones sanitarias'],
      duracion: '3 años',
      mercadoLaboral: 'Farmacias, boticas, hospitales, distribuidoras farmacéuticas y laboratorios.',
    ),

    // Gastronomía
    Carrera(
      nombre: 'Gastronomía',
      descripcion: 'Arte culinario y gestión de negocios gastronómicos. Técnicas de cocina, administración de restaurantes y tendencias gastronómicas.',
      imagenUrl: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800&h=400&fit=crop',
      habilidades: ['Técnicas culinarias', 'Gestión de cocina', 'Arte de mesa', 'Control de costos'],
      duracion: '3 años',
      mercadoLaboral: 'Restaurantes, hoteles, servicios de catering, emprendimiento gastronómico y consultoría.',
    ),

    // Logística
    Carrera(
      nombre: 'Gestión Logística',
      descripcion: 'Administración de la cadena de suministro. Gestión de inventarios, transporte y distribución de productos.',
      imagenUrl: 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1553413077-190dd305871c?w=800&h=400&fit=crop',
      habilidades: ['Gestión de inventarios', 'Transporte y distribución', 'Software logístico', 'Compras'],
      duracion: '3 años',
      mercadoLaboral: 'Empresas de logística, retail, manufactura, transporte y comercio exterior.',
    ),

    // Maquinaria Pesada
    Carrera(
      nombre: 'Mantenimiento de Maquinaria Pesada',
      descripcion: 'Formación técnica especializada en diagnóstico y reparación de equipos pesados. Electrónica aplicada a maquinaria.',
      imagenUrl: 'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=400&h=300&fit=crop',
      portadaUrl: 'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=800&h=400&fit=crop',
      habilidades: ['Diagnóstico mecánico', 'Hidráulica', 'Electrónica diesel', 'Sistemas de transmisión'],
      duracion: '3 años',
      mercadoLaboral: 'Empresas mineras, constructoras, sector agrícola y servicios de maquinaria pesada.',
    ),
  ];
}
