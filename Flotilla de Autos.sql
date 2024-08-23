-- Crear la base de datos
CREATE DATABASE FlotillaTaxisBD;
USE FlotillaTaxisBD;

-- Crear la tabla Ciudad
CREATE TABLE Ciudad (
    ID_Ciudad INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    PRIMARY KEY (ID_Ciudad)
);

-- Crear la tabla Seguro
CREATE TABLE Seguro (
    ID_Seguro INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Aseguradora VARCHAR(100) NOT NULL,
    Numero_Poliza VARCHAR(50) NOT NULL,
    Fecha_Vencimiento DATE NOT NULL,
    ID_Ciudad INT,
    FOREIGN KEY (ID_Ciudad) REFERENCES Ciudad(ID_Ciudad)
);

-- Crear la tabla Auto
CREATE TABLE Auto (
    ID_Auto INT AUTO_INCREMENT PRIMARY KEY,
    Número_Serie VARCHAR(50) NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Año YEAR NOT NULL,
    Placa VARCHAR(20) NOT NULL,
    ID_Seguro INT,
    ID_Ciudad INT,
    FOREIGN KEY (ID_Seguro) REFERENCES Seguro(ID_Seguro),
    FOREIGN KEY (ID_Ciudad) REFERENCES Ciudad(ID_Ciudad)
);

-- Crear la tabla Cliente
CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    ID_Ciudad INT,
    FOREIGN KEY (ID_Ciudad) REFERENCES Ciudad(ID_Ciudad)
);

-- Crear la tabla Operador
CREATE TABLE Operador (
    ID_Operador INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Licencia VARCHAR(50) NOT NULL,
    ID_Ciudad INT,
    FOREIGN KEY (ID_Ciudad) REFERENCES Ciudad(ID_Ciudad)
);

-- Crear la tabla Mantenimiento
CREATE TABLE Mantenimiento (
    ID_Mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    Descripcion TEXT,
    Costo DECIMAL(10,2) NOT NULL,
    ID_Auto INT,
    ID_Ciudad INT,
    ID_Operador INT,
    FOREIGN KEY (ID_Auto) REFERENCES Auto(ID_Auto),
    FOREIGN KEY (ID_Ciudad) REFERENCES Ciudad(ID_Ciudad),
    FOREIGN KEY (ID_Operador) REFERENCES Operador(ID_Operador)
);

-- Crear la tabla Horario
CREATE TABLE Horario (
    ID_Horario INT AUTO_INCREMENT PRIMARY KEY,
    Dia ENUM('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo') NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Hora_Fin TIME NOT NULL,
    ID_Operador INT,
    FOREIGN KEY (ID_Operador) REFERENCES Operador(ID_Operador)
);

-- Crear la tabla Servicio
CREATE TABLE Servicio (
    ID_Servicio INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Hora_Fin TIME NOT NULL,
    ID_Cliente INT,
    ID_Auto INT,
    ID_Operador INT,
    ID_Horario INT,
    ID_Ciudad INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
    FOREIGN KEY (ID_Auto) REFERENCES Auto(ID_Auto),
    FOREIGN KEY (ID_Operador) REFERENCES Operador(ID_Operador),
    FOREIGN KEY (ID_Horario) REFERENCES Horario(ID_Horario),
    FOREIGN KEY (ID_Ciudad) REFERENCES Ciudad(ID_Ciudad)
);

-- Crear la tabla Auto_Cliente
CREATE TABLE Servicio_Cliente (
    ID_Servicio INT,
    ID_Cliente INT,
    PRIMARY KEY (ID_Servicio, ID_Cliente),
    FOREIGN KEY (ID_Servicio) REFERENCES Servicio(ID_Servicio),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Crear la tabla Operador_Auto
CREATE TABLE Operador_Auto (
    ID_Auto INT,
    ID_Operador INT,
    PRIMARY KEY (ID_Auto, ID_Operador),
    FOREIGN KEY (ID_Auto) REFERENCES Auto(ID_Auto),
    FOREIGN KEY (ID_Operador) REFERENCES Operador(ID_Operador)
);

-- Crear la tabla Operador_Auto_Cliente_Servicio
CREATE TABLE Operador_Auto_Cliente_Servicio (
    ID_Operador INT,
    ID_Auto INT,
    ID_Cliente INT,
    ID_Servicio INT,
    PRIMARY KEY (ID_Operador, ID_Auto, ID_Cliente, ID_Servicio),
    FOREIGN KEY (ID_Operador, ID_Auto) REFERENCES Operador_Auto(ID_Operador, ID_Auto),
    FOREIGN KEY (ID_Cliente, ID_Servicio) REFERENCES Auto_Cliente(ID_Servicio, ID_Cliente)
);
