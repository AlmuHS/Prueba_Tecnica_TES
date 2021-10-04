DROP DATABASE IF EXISTS TEST_DB;

CREATE TABLE IF NOT EXISTS USUARIOS(
    id int primary key,
    usuario varchar(20) UNIQUE,
    nombre varchar(100),
    apellidos varchar(100),
    email varchar(50)
);

CREATE TABLE IF NOT EXISTS ALUMNOS(
    ID INT,
    CURSO INT,
    ETAPA VARCHAR(20),
    PRIMARY KEY(ID),
    FOREIGN KEY(ID) REFERENCES USUARIOS(ID)
);

CREATE TABLE IF NOT EXISTS PROFESORES(
    ID INT,
    TUTOR INT,
    ASIGNATURA VARCHAR(30),
    DEPARTAMENTO VARCHAR(30)
);

-- Inserta usuarios

INSERT INTO USUARIOS(ID, USUARIO, NOMBRE, apellidos, email) 
    VALUES(1, "jaime123", "Jaime", "Gonzalez", "jgon@gmail.com");

INSERT INTO USUARIOS(ID, USUARIO, NOMBRE, apellidos, email)
    VALUES(2, "cfernandez", "Carlos", "Fernandez", "cfer2000@hotmail.com");

INSERT INTO USUARIOS(ID, USUARIO, NOMBRE, apellidos, email)
    VALUES(3, "mgarcia", "Maria Teresa", "Garcia", "maite_gar@hotmail.com");

INSERT INTO USUARIOS(ID, USUARIO, NOMBRE, apellidos, email)
    VALUES(4, "tgonz", "Tomás", "Gonzalez", "tom@postmail.com");

INSERT INTO USUARIOS(ID, USUARIO, NOMBRE, apellidos, email)
    VALUES(5, "dani2003", "Daniel", "Alcaráz", "dani@postmail.com");

INSERT INTO USUARIOS(ID, USUARIO, NOMBRE, apellidos, email)
    VALUES(6, "anita", "Ana", "Hernandez", "ana_h@jmail.com");

INSERT INTO USUARIOS(ID, USUARIO, NOMBRE, apellidos, email)
    VALUES(7, "marta", "Marta", "Hernandez", "marta_1990@jmail.com");


-- Inserta alumnos

INSERT INTO ALUMNOS(ID, CURSO, ETAPA)
    VALUES(1, 2, "Primaria");

INSERT INTO ALUMNOS(ID, CURSO, ETAPA)
    VALUES(5, 2, "Secundaria");

INSERT INTO ALUMNOS(ID, CURSO, ETAPA)
    VALUES(6, 5, "Primaria");

INSERT INTO ALUMNOS(ID, CURSO, ETAPA)
    VALUES(2, 2, "Bachillerato");

-- Inserta profesores

INSERT INTO PROFESORES(ID, TUTOR, ASIGNATURA, DEPARTAMENTO)
    VALUES(7, 0, "Lengua Castellana y Literatura", "Lengua Castellana");

INSERT INTO PROFESORES(ID, TUTOR, ASIGNATURA, DEPARTAMENTO)
    VALUES(3, 1, "Inglés", "Idiomas");

INSERT INTO PROFESORES(ID, TUTOR, ASIGNATURA, DEPARTAMENTO)
    VALUES(4, 1, "Filosofía", "Ética y filosofía");

