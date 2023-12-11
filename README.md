# chq.to - Generador y Gestor de Enlaces Cortos

## Aplicación realizada para la materia de TTPS Opción Ruby 2023
### Alumno: María Emilia Romero

## Descripción del Proyecto

Este repositorio contiene el código fuente y la documentación para la aplicación web chq.to, una plataforma de generación y gestión de enlaces cortos. La aplicación tiene como objetivo proporcionar enlaces cortos para URLs arbitrariamente largas para compartir páginas web de manera sencilla.

## Requisitos Técnicos

- **Ruby:** Se requiere una versión de Ruby 2.7 o superior.
- **Ruby on Rails:** Ruby on Rails versión 7.1.2
- **Base de datos:** La aplicación utiliza SQLite para soporte de persistencia.

## Instalación y Ejecución

Siga estos pasos para configurar y ejecutar la aplicación en su entorno local:

1. **Clonar el Repositorio:**
```bash
git clone https://github.com/emrome/chq.to-TTPS-2023
cd chq.to
```
 
2. **Instalar Dependencias:**
```bash
bundle install
```

3. **Configurar la Base de Datos:**
```bash
rails db:migrate
```

4. **Iniciar el Servidor:**
```bash
rails server
```
- Otra opcion es:
```bash
rails s
```
La aplicación ahora debería estar disponible en `http://localhost:3000`.

## Para poblar la base de datos con información de prueba, puedes utilizar los datos proporcionados en el archivo db/seeds.rb.

1. **Poblar la Base de Datos:**
```bash
rails db:seed
```
*Este comando ejecutará el código en db/seeds.rb para crear usuarios y enlaces de ejemplo en la base de datos.*

**Nota:** Puedes modificar el archivo db/seeds.rb para ajustar los datos de prueba según tus necesidades.

## Comentarios sobre decisiones de diseño:

### Gestión de Usuarios
* Decidí realizar un borrado físico de los usuarios o sus links porque los usuarios no pueden recuperar sus cuentas y solo ellos tienen la capacidad de eliminarlas.
* El url de los enlaces debe ser único para ese usuario en la base de datos

### Estructura de Controladores:

* **Controlador de Accesos (`AccessController`):** Gestiona la lógica para el acceso a los enlaces y registra su acceso.

* **Controlador de Reportes (`ReportsController`):** Encargado de generar y presentar los reportes de acceso.

* **Controlador de Enlaces (`LinksController`):** Contiene la lógica para operaciones CRUD relacionadas con la gestión de enlaces.

Separación en distintos controladores con el objetivo de evitar la concentración de toda la lógica de la aplicación en un único controlador, que facilita la organización del código según la lógica funcional específica de cada componente.

### Reportes
* Sobre la cantidad de accesos por día, se puede visualizar los accesos según día de la semana o agrupados por fecha de acceso.


## Datos relevantes generados en el archivo seed:

### Usuarios:

| Correo electrónico           | Usuario   | Nombre   | Apellido | Contraseña    | Fecha de Creación      |
| ---------------------------- | --------- | -------- | -------- | ------------- | ---------------------- |
| john.doe@example.com         | johndoe   | John     | Doe      | password123   | 10 días atrás          |
| jane.smith@example.com       | janesmith | Jane     | Smith    | password456   |                        |

### Enlaces:
### Enlaces:

| Nombre          | URL                                                | Tipo de Enlace | Dueño      | Fecha de Expiración | Contraseña  | Visitas |
| --------------- | -------------------------------------------------- | -------------- | ---------- | ------------------- | ----------- | ------- |
| Imagine         | [https://www.youtube.com/watch?v=VOgFZfRVaww](https://www.youtube.com/watch?v=VOgFZfRVaww) | Privado        | John Doe   |                   | Imagine123  | 2       |
| The Godfather   | [https://www.youtube.com/watch?v=sY1S34973zA](https://www.youtube.com/watch?v=sY1S34973zA) | Regular        | John Doe   |                   |             | 2       |
| Google          | [https://www.google.com/](https://www.google.com/) | Efímero        | John Doe   |                   |             | 0 (No Expirado) |
| -               | [https://doodles.google/search/](https://doodles.google/search/) | Temporal       | John Doe   | 30 minutos después  |             | 3       |
| -               | [https://doodles.google/search/](https://doodles.google/search/) | Temporal       | Jane Smith | 1 minutos después   |             | 2       |
| Google   | [https://www.google.com/](https://www.google.com/) | Efímero        | Jane Smith |                   |             | 1 (Expirado)  |

**Notas:**
- La columna "Fecha de Expiración" indica la fecha en que el enlace temporal dejará de funcionar.
- La columna "Contraseña" se aplica solo a los enlaces privados y temporales.
- La columna "Visitas" muestra la cantidad de accesos registrados para los enlaces.

## Gemas instaladas para la aplicación
- [Bcrypt](https://github.com/codahale/bcrypt-ruby): Encriptación de contraseñas de links
- [Devise](https://github.com/heartcombo/devise): Manejo de usuarios
- [Groupdate](https://github.com/ankane/groupdate): Usado para agrupar fechas en los reportes