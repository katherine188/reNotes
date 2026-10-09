import '../models/proyecto.dart';
import '../models/nota.dart';
import '../models/etiqueta.dart';

final List<Etiqueta> etiquetasPrueba = [
  Etiqueta(
    id: 1,
    nombre: 'Metodología',
    color: 'Azul',
  ),
  Etiqueta(
    id: 2,
    nombre: 'Marco teórico',
    color: 'Verde',
  ),
  Etiqueta(
    id: 3,
    nombre: 'Bibliografía',
    color: 'Morado',
  ),
  Etiqueta(
    id: 4,
    nombre: 'Análisis',
    color: 'Naranja',
  ),
  Etiqueta(
    id: 5,
    nombre: 'Resultados',
    color: 'Rojo',
  ),
  Etiqueta(
    id: 6,
    nombre: 'Tecnología',
    color: 'Turquesa',
  ),
  Etiqueta(
    id: 7,
    nombre: 'Pendiente',
    color: 'Amarillo',
  ),
  Etiqueta(
    id: 8,
    nombre: 'Sin usar',
    color: 'Gris',
  ),
];

final List<Proyecto> proyectosPrueba = [
  Proyecto(
    id: 1,
    nombre: 'Inteligencia Artificial',
    descripcion:
        'Investigación sobre aplicaciones y avances de la inteligencia artificial.',
    fechaCreacion: DateTime(2026, 9, 1),
    fechaModificacion: DateTime(2026, 10, 1),
  ),
  Proyecto(
    id: 2,
    nombre: 'Ciberseguridad',
    descripcion:
        'Estudio de amenazas, protección de sistemas y seguridad de la información.',
    fechaCreacion: DateTime(2026, 9, 3),
    fechaModificacion: DateTime(2026, 10, 2),
  ),
  Proyecto(
    id: 3,
    nombre: 'Tecnologías Educativas',
    descripcion:
        'Investigación sobre herramientas tecnológicas aplicadas a la educación.',
    fechaCreacion: DateTime(2026, 9, 5),
    fechaModificacion: DateTime(2026, 10, 3),
  ),
];

final List<Nota> notasPrueba = [
  Nota(
    id: 1,
    proyectoId: 1,
    titulo: 'Introducción a la Inteligencia Artificial',
    descripcion:
        'La inteligencia artificial es un área de la informática que busca desarrollar sistemas capaces de realizar tareas que normalmente requieren capacidades asociadas con la inteligencia humana. Entre estas tareas se encuentran el reconocimiento de patrones, el procesamiento del lenguaje natural, la toma de decisiones y el aprendizaje a partir de datos. En los últimos años, la inteligencia artificial ha tenido un crecimiento importante debido al aumento de la capacidad de procesamiento y a la disponibilidad de grandes cantidades de información. Su aplicación se encuentra presente en diferentes sectores, como la educación, la medicina, las finanzas, la industria y las comunicaciones. El estudio de esta tecnología permite comprender tanto sus posibilidades como sus limitaciones y los aspectos éticos relacionados con su utilización.',
    fechaCreacion: DateTime(2026, 9, 2),
    fechaModificacion: DateTime(2026, 10, 1),
    etiquetaIds: [1, 2],
  ),
  Nota(
    id: 2,
    proyectoId: 1,
    titulo: 'Aplicaciones de la IA',
    descripcion:
    'Las aplicaciones de la inteligencia artificial abarcan numerosos campos y continúan creciendo a medida que se desarrollan nuevas técnicas y herramientas. En el ámbito educativo puede utilizarse para personalizar los procesos de aprendizaje, analizar el rendimiento de los estudiantes y ofrecer recursos adaptados a sus necesidades. En la medicina existen sistemas capaces de analizar información clínica y colaborar en la identificación de determinados patrones. También se emplea en sistemas de recomendación, asistentes virtuales, reconocimiento de imágenes y automatización de procesos. En la industria puede contribuir a optimizar tareas y detectar posibles fallos en los equipos. Sin embargo, su incorporación requiere considerar aspectos relacionados con la privacidad, la seguridad de los datos, la transparencia y la responsabilidad de quienes desarrollan estas tecnologías. Por esta razón, además de estudiar sus capacidades técnicas, resulta importante analizar sus limitaciones y el impacto que puede producir su utilización en diferentes áreas de la sociedad.',
    fechaCreacion: DateTime(2026, 9, 4),
    fechaModificacion: DateTime(2026, 10, 1),
    etiquetaIds: [1, 4],
  ),
  Nota(
    id: 3,
    proyectoId: 1,
    titulo: 'Metodologías para estudiar IA',
    descripcion:
    'Para estudiar un problema relacionado con la inteligencia artificial es necesario definir una metodología adecuada que permita organizar el trabajo y obtener resultados confiables. El proceso puede comenzar con la identificación del problema, seguida por la revisión de investigaciones anteriores y la recopilación de información relevante. Posteriormente, se seleccionan los datos y las técnicas que serán utilizadas para realizar el análisis. Es importante establecer objetivos claros y determinar qué criterios se emplearán para evaluar los resultados obtenidos. Durante la investigación deben revisarse la calidad de los datos, las posibles limitaciones de los métodos y los factores que pueden influir en las conclusiones. También es necesario documentar cada etapa para facilitar la comprensión y reproducción del estudio por parte de otros investigadores. Finalmente, los resultados deben interpretarse teniendo en cuenta el contexto del problema y compararse con trabajos anteriores. Una metodología organizada permite identificar errores, justificar las decisiones tomadas y obtener conclusiones más claras y útiles.',
    fechaCreacion: DateTime(2026, 9, 6),
    fechaModificacion: DateTime(2026, 10, 2),
    etiquetaIds: [1, 3],
  ),
  Nota(
    id: 4,
    proyectoId: 2,
    titulo: 'Conceptos básicos de ciberseguridad',
    descripcion:
    'La ciberseguridad comprende las prácticas, herramientas y tecnologías destinadas a proteger los sistemas informáticos, las redes y los datos frente a diferentes amenazas. Entre sus principales objetivos se encuentran preservar la confidencialidad, la integridad y la disponibilidad de la información. Las amenazas pueden presentarse mediante programas maliciosos, ataques de ingeniería social, accesos no autorizados y técnicas destinadas a robar datos personales o interrumpir servicios. Para reducir estos riesgos es necesario combinar medidas técnicas con buenas prácticas por parte de los usuarios. El uso de contraseñas seguras, la autenticación en varios pasos, las actualizaciones de software y las copias de seguridad son algunas medidas preventivas importantes. También resulta fundamental reconocer los mensajes sospechosos y evitar abrir archivos o enlaces de procedencia desconocida. En las organizaciones, la capacitación del personal y la elaboración de planes de respuesta ayudan a reducir las consecuencias de posibles incidentes. La seguridad debe considerarse un proceso continuo, ya que las amenazas evolucionan constantemente y requieren nuevas estrategias de prevención, detección y recuperación.',
    fechaCreacion: DateTime(2026, 9, 7),
    fechaModificacion: DateTime(2026, 10, 2),
    etiquetaIds: [2, 6],
  ),
  Nota(
    id: 5,
    proyectoId: 3,
    titulo: 'Tecnología aplicada a la educación',
    descripcion:
    'Las tecnologías educativas permiten incorporar diferentes herramientas digitales dentro de los procesos de enseñanza y aprendizaje. Estas herramientas pueden facilitar el acceso a materiales, apoyar la comunicación entre docentes y estudiantes y ofrecer nuevas formas de presentar la información. El uso de plataformas digitales también permite organizar contenidos, distribuir actividades y realizar un seguimiento del progreso académico. Algunas herramientas incorporan recursos interactivos que ayudan a comprender conceptos complejos mediante imágenes, simulaciones y ejercicios prácticos. Sin embargo, la incorporación de tecnología debe responder a objetivos educativos concretos y no solamente a la disponibilidad de una herramienta. Es necesario analizar las características de los estudiantes, los recursos disponibles y las condiciones en las que se desarrollará el proceso educativo. También deben considerarse las dificultades relacionadas con el acceso a dispositivos, la conexión a internet y la capacitación de los docentes. Una integración adecuada puede complementar los métodos tradicionales, favorecer la colaboración y proporcionar nuevas oportunidades para investigar, resolver problemas y desarrollar habilidades relacionadas con el uso responsable de la tecnología.',
    fechaCreacion: DateTime(2026, 9, 8),
    fechaModificacion: DateTime(2026, 10, 3),
    etiquetaIds: [1, 6],
  ),
  Nota(
    id: 6,
    proyectoId: 2,
    titulo: 'Tipos de amenazas informáticas',
    descripcion:
        'Las amenazas informáticas pueden afectar la seguridad de los sistemas y de la información. Entre ellas se encuentran el malware, el phishing, los ataques de ingeniería social y los accesos no autorizados. Cada amenaza puede utilizar diferentes métodos para intentar obtener información o afectar el funcionamiento de un sistema. Conocer sus características permite establecer medidas de prevención y respuesta.',
    fechaCreacion: DateTime(2026, 9, 9),
    fechaModificacion: DateTime(2026, 10, 2),
    etiquetaIds: [4, 6],
  ),
  Nota(
    id: 7,
    proyectoId: 2,
    titulo: 'Protección de la información',
    descripcion:
        'La protección de la información requiere establecer medidas que reduzcan el riesgo de pérdida, modificación o acceso no autorizado. Las organizaciones pueden utilizar controles de acceso, copias de seguridad, cifrado y mecanismos de autenticación. También es importante mantener actualizados los sistemas y capacitar a los usuarios sobre prácticas seguras.',
    fechaCreacion: DateTime(2026, 9, 10),
    fechaModificacion: DateTime(2026, 10, 3),
    etiquetaIds: [2, 6],
  ),
  Nota(
    id: 8,
    proyectoId: 3,
    titulo: 'Herramientas digitales educativas',
    descripcion:
        'Las herramientas digitales pueden apoyar diferentes actividades educativas. Entre ellas se encuentran plataformas de aprendizaje, aplicaciones interactivas, recursos multimedia y sistemas de comunicación. Su utilización puede facilitar la organización de contenidos y permitir que los estudiantes accedan a materiales desde diferentes dispositivos.',
    fechaCreacion: DateTime(2026, 9, 11),
    fechaModificacion: DateTime(2026, 10, 3),
    etiquetaIds: [6],
  ),
  Nota(
    id: 9,
    proyectoId: 3,
    titulo: 'Beneficios de la tecnología en el aprendizaje',
    descripcion:
        'La tecnología puede proporcionar nuevas formas de acceder a la información y desarrollar actividades de aprendizaje. Los recursos digitales permiten combinar texto, imágenes, audio y video, facilitando la presentación de determinados contenidos. También pueden favorecer la colaboración y la comunicación entre estudiantes y docentes.',
    fechaCreacion: DateTime(2026, 9, 12),
    fechaModificacion: DateTime(2026, 10, 3),
    etiquetaIds: [2, 5],
  ),
  Nota(
    id: 10,
    proyectoId: 1,
    titulo: 'Inteligencia artificial y análisis de datos',
    descripcion:
        'El análisis de datos es una de las áreas donde se utilizan técnicas de inteligencia artificial. Los sistemas pueden procesar grandes cantidades de información para identificar patrones y generar resultados útiles para la toma de decisiones. La calidad de los datos y la selección de métodos adecuados son factores importantes para obtener resultados confiables.',
    fechaCreacion: DateTime(2026, 9, 13),
    fechaModificacion: DateTime(2026, 10, 4),
    etiquetaIds: [4, 5],
  ),
  Nota(
    id: 11,
    proyectoId: 1,
    titulo: 'Ética en la inteligencia artificial',
    descripcion:
        'El desarrollo de sistemas de inteligencia artificial plantea diferentes cuestiones éticas. Es importante considerar la privacidad de los datos, la transparencia de los sistemas y las posibles consecuencias de las decisiones automatizadas. También se debe analizar la responsabilidad de las personas y organizaciones que desarrollan y utilizan estas tecnologías.',
    fechaCreacion: DateTime(2026, 9, 14),
    fechaModificacion: DateTime(2026, 10, 4),
    etiquetaIds: [2, 7],
  ),
  Nota(
    id: 12,
    proyectoId: 2,
    titulo: 'Buenas prácticas de seguridad',
    descripcion:
        'Las buenas prácticas de seguridad ayudan a disminuir los riesgos asociados al uso de sistemas informáticos. Mantener los programas actualizados, utilizar contraseñas adecuadas, evitar enlaces sospechosos y realizar copias de seguridad son algunas medidas que pueden contribuir a proteger la información.',
    fechaCreacion: DateTime(2026, 9, 15),
    fechaModificacion: DateTime(2026, 10, 4),
    etiquetaIds: [7],
  ),
  Nota(
    id: 13,
    proyectoId: 3,
    titulo: 'Investigación sobre aprendizaje digital',
    descripcion:
        'El aprendizaje digital puede estudiarse desde diferentes perspectivas. Es posible analizar las herramientas utilizadas, la participación de los estudiantes y los resultados obtenidos durante las actividades. La recopilación organizada de información permite identificar ventajas y dificultades relacionadas con el uso de recursos tecnológicos.',
    fechaCreacion: DateTime(2026, 9, 16),
    fechaModificacion: DateTime(2026, 10, 5),
    etiquetaIds: [3, 5],
  ),
  Nota(
    id: 14,
    proyectoId: 3,
    titulo: 'Retos de la educación tecnológica',
    descripcion:
        'La incorporación de tecnología en la educación también presenta retos. Entre ellos pueden encontrarse las diferencias en el acceso a dispositivos, la disponibilidad de conexión y la necesidad de capacitación. Estos aspectos deben considerarse para que las herramientas digitales puedan utilizarse de manera adecuada y contribuir realmente al proceso educativo.',
    fechaCreacion: DateTime(2026, 9, 17),
    fechaModificacion: DateTime(2026, 10, 5),
    etiquetaIds: [4],
  ),
  Nota(
    id: 15,
    proyectoId: 2,
    titulo: 'Conclusiones preliminares',
    descripcion:
        'Esta nota se utiliza para registrar conclusiones preliminares del proyecto y organizar ideas que serán revisadas posteriormente.',
    fechaCreacion: DateTime(2026, 9, 18),
    fechaModificacion: DateTime(2026, 10, 5),
    etiquetaIds: [],
  ),
];