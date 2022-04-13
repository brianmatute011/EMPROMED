USE EMPROMED;
create table ProdFarm
(
    IDP        INT UNIQUE NOT NULL,
    nombre     VARCHAR(250),
    fecha_venc DATE,
    tipo       VARCHAR(1),
    PRIMARY KEY (IDP)
);

create table CompQuim
(
    IDCQ   INT UNIQUE          NOT NULL,
    nombre VARCHAR(250) UNIQUE NOT NULL,
    PH     VARCHAR(1),
    PRIMARY KEY (IDCQ, nombre)
);

CREATE TABLE Departamentos
(
    IDDPT  INT UNIQUE NOT NULL,
    nombre VARCHAR(250),
    tipo   VARCHAR(1),
    PRIMARY KEY (IDDPT)
);

CREATE TABLE Trabajador
(
    CI             BIGINT UNIQUE NOT NULL,
    nombre         VARCHAR(250),
    edad           SMALLINT,
    sexo           VARCHAR(1),
    cargo          VARCHAR(250),
    anhios_trabajo SMALLINT,
    CDEP           INT           NOT NULL,
    salario        FLOAT,
    PRIMARY KEY (CI),
    FOREIGN KEY (CDEP) REFERENCES Departamentos (IDDPT) ON DELETE CASCADE
);

CREATE TABLE Produccion
(
    IDPROC   INT UNIQUE NOT NULL,
    fecha    DATE,
    cantidad INT,
    CPROD    INT        NOT NULL,
    CDEP     INT        NOT NULL,
    CIRESP   BIGINT     NOT NULL,
    PRIMARY KEY (IDPROC),
    FOREIGN KEY (CPROD)  REFERENCES ProdFarm (IDP) ON DELETE CASCADE,
    FOREIGN KEY (CDEP)   REFERENCES Departamentos (IDDPT) ON DELETE CASCADE,
    FOREIGN KEY (CIRESP) REFERENCES Trabajador (CI) ON DELETE CASCADE
);

CREATE TABLE Evaluacion
(
    IDEVAL    INT UNIQUE NOT NULL,
    fecha     DATE,
    resultado VARCHAR(1),
    CPROD     INT        NOT NULL,
    CIRESP    BIGINT     NOT NULL,
    PRIMARY KEY (IDEVAL),
    FOREIGN KEY (CPROD)  REFERENCES Produccion (IDPROC) ON DELETE CASCADE,
    FOREIGN KEY (CIRESP) REFERENCES Trabajador (CI) ON DELETE CASCADE
);
CREATE TABLE Elabora
(
    CPROD INT NOT NULL,
    CCQ   INT NOT NULL,
    FOREIGN KEY (CPROD) REFERENCES ProdFarm (IDP)  ON DELETE CASCADE,
    FOREIGN KEY (CCQ)   REFERENCES CompQuim (IDCQ) ON DELETE CASCADE
);

CREATE TABLE Realiza
(
    CPROD INT NOT NULL,
    CDPT  INT NOT NULL,
    FOREIGN KEY (CPROD) REFERENCES ProdFarm (IDP) ON DELETE CASCADE,
    FOREIGN KEY (CDPT)  REFERENCES Departamentos (IDDPT) ON DELETE CASCADE
);


#Los trabajadores que laboran en el departamento de produccion
SELECT T.nombre, T.CDEP
FROM Trabajador T, Departamentos D
WHERE T.CDEP = D.IDDPT AND D.tipo = 'P';

#Los trabajadores que laboran en el departamentos de calidad
SELECT T.nombre, T.CDEP
FROM Trabajador T, Departamentos D
WHERE T.CDEP = D.IDDPT AND D.tipo = 'C';

#Responsable de una produccion dada con su fecha
SELECT T.nombre, P.fecha
FROM  ProdFarm PF, Produccion P, Trabajador T
WHERE PF.nombre = 'Clohidrato Difenhidramina'
  AND PF.tipo = 'J' AND PF.IDP = P.CPROD AND P.CIRESP = T.CI;


#Responsable de una evaluacion de calidad dada
SELECT T.nombre
FROM Evaluacion E, Trabajador T
WHERE E.resultado = 'A' AND E.CIRESP = T.CI GROUP BY T.nombre;

#Subir un 10% del salario a los trabajadores con mas de  15 anhios de experiencia
UPDATE  Trabajador T
SET T.salario = T.salario + (T.salario * .10)
WHERE T.anhios_trabajo > 10;


#Calacular el salario promedio
SELECT AVG(T.salario) SP FROM Trabajador T;

#Eliminar todo uso de componentes quimicos con PH Neutros en la industria
DELETE FROM CompQuim WHERE PH = 'N';


#Mostrar la cantidad total de productos fabricados entre 2019-01-01 y el 2021-01-01
SELECT SUM(P.cantidad) Total
FROM Produccion P
WHERE P.fecha BETWEEN '2019-01-01' AND '2021-01-01';


#Crear una tabla con los nombres de los responsbales de produccion que han tenido una evaluacion por debajo de la media
CREATE VIEW Produccion_Baja AS
SELECT T.nombre
FROM Evaluacion E, Trabajador T
WHERE E.resultado = 'D' AND T.CI = E.CIRESP GROUP BY T.nombre;

