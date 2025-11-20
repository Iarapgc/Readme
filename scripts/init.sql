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
('CALCULO III', 'DOCK03', 4);
