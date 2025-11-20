# Base de Datos MySQL

Este proyecto busca generar una base de datos utilizando MySQL para generar tablas 

## Requisitos Previos

[Docker](https://docs.docker.com/engine/install/ubuntu)<br>
[Docker Compose](https://docs.docker.com/compose/install/linux)

## Estructura

```yml
services:
```


```yml
networks:
  mysql-network:
    driver: bridge
```
## Configuracion

### Servicios

**MySQL**

```yml
  mysql-db:
    image: mysql:8.0
    container_name: mysql-admlinux
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: sistema_facultad
      
      # Usuario administrador
      MYSQL_USER: admlinux
      MYSQL_PASSWORD: admin
      
      # Usuario de solo lectura
      MYSQL_READONLY_USER: usuario_lectura
      MYSQL_READONLY_PASSWORD: user
      
    ports:
      - "3306:3306"
    volumes:
      - ./data:/var/lib/mysql
      - ./scripts:/docker-entrypoint-initdb.d
    networks:
      - mysql-network
```

**phpMyAdmin**


```yml
  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: phpmyadmin-admlinux
    restart: unless-stopped
    environment:
      PMA_HOST: mysql-db
      PMA_PORT: 3306
      MYSQL_ROOT_PASSWORD: root
      UPLOAD_LIMIT: 128M
    ports:
      - "8080:80"
    networks:
      - mysql-network
    depends_on:
      - mysql-db
```

>[!Note]
>En caso de no clonar el repositorio completo, es necesario crear en la carpeta del proyecto dos directorios: ```config``` y ```scripts``` y dentro copiar los códigos adjuntados en las secciones

👉 [Conf Adicional](#conf-adicional-en-config)<br>
👉 [Base de Datos de Prueba](#base-de-datos-de-prueba-en-scripts) <!-- Arreglar los botones -->

## Conf Adicional en (```config```)

<details>
  <summary> Desplegar </summary>
  
```ini
[mysqld]
character-set-server = utf8mb4
collation-server= utf8mb4_unicode_ci
default_authentication_plugin=mysql_native_password
max_connections = 100


[client]
default-character-set = utf8mb4
```
</details>

## Base de Datos de Prueba en (```scripts```)

<details>
<summary>Desplegar</summary>
  
```sql
-- Crear usuarios con permisos
CREATE USER IF NOT EXISTS 'admlinux'@'%' IDENTIFIED BY 'blabla';
GRANT ALL PRIVILEGES ON *.* TO 'admlinux'@'%' WITH GRANT OPTION;

CREATE USER IF NOT EXISTS 'usuario_lectura'@'%' IDENTIFIED BY 'blabla';
GRANT SELECT ON sistema_facultad.* TO 'usuario_lectura'@'%';
GRANT SELECT ON information_schema.* TO 'usuario_lectura'@'%';

FLUSH PRIVILEGES;

-- Crear y usar la base de datos de la facultad
CREATE DATABASE IF NOT EXISTS sistema_facultad;
USE sistema_facultad;

-- Tabla de estudiantes
CREATE TABLE IF NOT EXISTS estudiantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    legajo VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de materias
CREATE TABLE IF NOT EXISTS materias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    creditos INT DEFAULT 0
);

-- Insertar datos de ejemplo
INSERT IGNORE INTO estudiantes (nombre, apellido, legajo, email) VALUES
('Juan', 'Pérez', 'LP12345', 'juan.perez@facultad.edu'),
('Iara', 'Gómez', 'LP12346', 'maria.gomez@facultad.edu'),
('Carlos', 'López', 'LP12347', 'carlos.lopez@facultad.edu');

INSERT IGNORE INTO materias (nombre, codigo, creditos) VALUES
('Linux y Virtualización', 'LINUX01', 4),
('Bases de Datos', 'BDAT02', 6),
('CALCULO III', 'DOCK03', 4);```
  
</details>
