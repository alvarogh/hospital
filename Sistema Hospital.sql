 CREATE TABLE empleado (
    nif               VARCHAR2(9) NOT NULL,
    falta             VARCHAR2(240),
    nombre            VARCHAR2(20),
    comision          NUMBER(6,2),
    salario           NUMBER(6,2),
    oficio            VARCHAR2(20),
    apellidos         VARCHAR2(40),
    nif_dependiente   VARCHAR2(9),
    CONSTRAINT emp_pk PRIMARY KEY ( nif ),
    CONSTRAINT emp_emp_fk FOREIGN KEY ( nif_dependiente )
        REFERENCES empleado ( nif )
);

CREATE TABLE hospital (
    codigo      NUMBER(2,0) NOT NULL,
    telefono    NUMBER(9),
    nombre      VARCHAR2(12),
    numcamas    NUMBER(4,0),
    direccion   VARCHAR2(50),
    CONSTRAINT hosp_pk PRIMARY KEY ( codigo )
);

CREATE TABLE enfermo (
    numsegsocial   NUMBER(9,0) NOT NULL,
    direccion      VARCHAR2(50),
    nombre         VARCHAR2(20),
    apellidos      VARCHAR2(40),
    fnacimiento    DATE,
    sexo           CHAR(1) NOT NULL,
    CONSTRAINT enf_pk PRIMARY KEY ( numsegsocial ),
    CONSTRAINT avcon_1247567854_sexo_000 CHECK ( sexo IN (
        'M',
        'F'
    ) )
);


CREATE TABLE plantilla (
    nif         VARCHAR2(9) NOT NULL,
    salario     NUMBER(7,2),
    nombre      VARCHAR2(20),
    turno       CHAR(1) NOT NULL,
    apellidos   VARCHAR2(40),
    funcion     VARCHAR2(20),
    CONSTRAINT plan_pk PRIMARY KEY ( nif ),
    CONSTRAINT avcon_1247567854_turno_000 CHECK ( turno IN (
        'M',
        'T',
        'N'
    ) )
);


CREATE TABLE sala (
    hosp_codigo   NUMBER(2,0) NOT NULL,
    codigo        NUMBER(2,0) NOT NULL,
    numcamas      NUMBER(2,0),
    nombre        VARCHAR2(30),
    CONSTRAINT sala_pk PRIMARY KEY ( codigo,
    hosp_codigo ),
    CONSTRAINT sala_hosp_fk FOREIGN KEY ( hosp_codigo )
        REFERENCES hospital ( codigo )
);

CREATE TABLE plantilla_sala (
    sala_hosp_codigo   NUMBER(2,0) NOT NULL,
    sala_codigo        NUMBER(2,0) NOT NULL,
    plan_nif           VARCHAR2(9) NOT NULL,
    CONSTRAINT plan_sala_pk PRIMARY KEY ( plan_nif,
    sala_codigo,
    sala_hosp_codigo ),
    CONSTRAINT plan_sala_sala_fk FOREIGN KEY ( sala_codigo,
    sala_hosp_codigo )
        REFERENCES sala ( codigo,
        hosp_codigo ),
    CONSTRAINT plan_sala_plan_fk FOREIGN KEY ( plan_nif )
        REFERENCES plantilla ( nif )
);

CREATE TABLE hospital_enfermo (
    hosp_codigo        NUMBER(2,0) NOT NULL,
    inscripcion        NUMBER(8,0) NOT NULL,
    enf_numsegsocial   NUMBER(9,0) NOT NULL,
    finscripcion       DATE,
    CONSTRAINT hosp_enf_pk PRIMARY KEY ( inscripcion,
    hosp_codigo,
    enf_numsegsocial ),
    CONSTRAINT hosp_enf_hosp_fk FOREIGN KEY ( hosp_codigo )
        REFERENCES hospital ( codigo ),
    CONSTRAINT hosp_enf_enf_fk FOREIGN KEY ( enf_numsegsocial )
        REFERENCES enfermo ( numsegsocial )
);


CREATE TABLE doctor (
    nif            VARCHAR2(9) NOT NULL,
    apellidos      VARCHAR2(20),
    nombre         VARCHAR2(20),
    especialidad   VARCHAR2(40),
    CONSTRAINT doc_pk PRIMARY KEY ( nif )
);


CREATE TABLE doctor_hospital (
    hosp_codigo   NUMBER(2,0) NOT NULL,
    doc_nif       VARCHAR2(9) NOT NULL,
    CONSTRAINT doc_hosp_pk PRIMARY KEY ( doc_nif,
    hosp_codigo ),
    CONSTRAINT doc_hosp_hosp_fk FOREIGN KEY ( hosp_codigo )
        REFERENCES hospital ( codigo ),
    CONSTRAINT doc_hosp_doc_fk FOREIGN KEY ( doc_nif )
        REFERENCES doctor ( nif )
);

CREATE TABLE empleado_hospital (
    hosp_codigo   NUMBER(2,0) NOT NULL,
    emp_nif       VARCHAR2(9) NOT NULL,
    CONSTRAINT emp_hosp_pk PRIMARY KEY ( emp_nif,
    hosp_codigo ),
    CONSTRAINT emp_hosp_hosp_fk FOREIGN KEY ( hosp_codigo )
        REFERENCES hospital ( codigo ),
    CONSTRAINT emp_hosp_emp_fk FOREIGN KEY ( emp_nif )
        REFERENCES empleado ( nif )
);

CREATE TABLE departamento (
    codigo   NUMBER(2,0) NOT NULL,
    nombre   VARCHAR2(20),
    CONSTRAINT dept_pk PRIMARY KEY ( codigo )
);


CREATE TABLE departamento_empleado (
    dept_codigo   NUMBER(2,0) NOT NULL,
    emp_nif       VARCHAR2(9) NOT NULL,
    CONSTRAINT dept_emp_pk PRIMARY KEY ( emp_nif,
    dept_codigo ),
    CONSTRAINT dept_emp_dept_fk FOREIGN KEY ( dept_codigo )
        REFERENCES departamento ( codigo ),
    CONSTRAINT dept_emp_emp_fk FOREIGN KEY ( emp_nif )
        REFERENCES empleado ( nif )
);


CREATE INDEX ix1_enfermo ON
    enfermo ( nombre );

CREATE INDEX ix2_enfermo ON
    enfermo ( apellidos );

CREATE UNIQUE INDEX ix1_departamento ON
    departamento ( nombre );



CREATE SEQUENCE seq_inscripcion START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999999 NOCYCLE NOCACHE;

/* Insercion de datos sobre las tablas de la estructura hospitalaria */
-- Inserciones en la tabla HOSPITAL
INSERT INTO hospital
values (1,'916644264','Provincial',502,'O Donell 50');

INSERT INTO hospital
values (2,'915953111','General',987,'Atocha s/n');

INSERT INTO hospital
values (3,'919235411','La Paz',412,'Castellana 100');

INSERT INTO hospital
values (4,'915971500','San Carlos',845,'Ciudad Universitaria');

INSERT INTO hospital
values (5,'915971500','Gr. Marañon',300,'Francisco Silvela');

INSERT INTO hospital
values (6,'915971500','Doce Octubre',200,'Avda. Cordoba');

INSERT INTO hospital
values (7,'915971500','La Zarzuela',100,'Moncloa');

-- Inserciones en la tabla ENFERMO
INSERT INTO enfermo
VALUES(280862482,'Goya20','Jose','M.M.',to_date('16051956','ddmmyyyy'),'M');

INSERT INTO enfermo
VALUES(280862481,'Granada 35','Javier','R.R.',to_date('16081970','ddmmyyyy'),'M');

INSERT INTO enfermo
VALUES(280862480,'Sevilla 32','Ruben','S.S.',to_date('10091971','ddmmyyyy'),'M');

INSERT INTO enfermo
VALUES(280862483,'Toledo 1','Rocio','K.K.',to_date('10091968','ddmmyyyy'),'F');

INSERT INTO enfermo
VALUES(280862484,'Malaga 2','Laura','J.J.',to_date('10091971','ddmmyyyy'),'F');

INSERT INTO enfermo
VALUES(280862485,'Barcelona 2','Beatriz','A.A.',to_date('10091988','ddmmyyyy'),'M');


-- Inserciones en la tabla HOSPITAL_ENFERMO
INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862482,to_date('01012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862482,to_date('02012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862482,to_date('03012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862482,to_date('04012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862482,to_date('05012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862481,to_date('01012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862481,to_date('02012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862481,to_date('03012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862480,to_date('01102002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862480,to_date('02102002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862480,to_date('03102002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862483,to_date('03102002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862484,to_date('04102002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(1,seq_inscripcion.nextval,280862485,to_date('03112002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(2,seq_inscripcion.nextval,280862482,to_date('02012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(2,seq_inscripcion.nextval,280862482,to_date('03012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(2,seq_inscripcion.nextval,280862482,to_date('04012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(2,seq_inscripcion.nextval,280862482,to_date('05012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(2,seq_inscripcion.nextval,280862481,to_date('02012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(2,seq_inscripcion.nextval,280862481,to_date('03012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(2,seq_inscripcion.nextval,280862480,to_date('02102002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(2,seq_inscripcion.nextval,280862480,to_date('03102002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(2,seq_inscripcion.nextval,280862484,to_date('04102002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(2,seq_inscripcion.nextval,280862485,to_date('03112002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(3,seq_inscripcion.nextval,280862482,to_date('03012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(3,seq_inscripcion.nextval,280862482,to_date('04012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(3,seq_inscripcion.nextval,280862482,to_date('05012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(3,seq_inscripcion.nextval,280862480,to_date('03102002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(3,seq_inscripcion.nextval,280862485,to_date('03112002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(4,seq_inscripcion.nextval,280862482,to_date('04012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(4,seq_inscripcion.nextval,280862482,to_date('05012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(4,seq_inscripcion.nextval,280862485,to_date('03112002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(5,seq_inscripcion.nextval,280862482,to_date('05012002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(5,seq_inscripcion.nextval,280862485,to_date('03112002','ddmmyyyy'));

INSERT INTO hospital_enfermo
VALUES(6,seq_inscripcion.nextval,280862485,to_date('03112002','ddmmyyyy'));


-- Inserciones en la tabla SALA
INSERT INTO sala
VALUES (1,1,24,'Maternidad');

INSERT INTO sala
VALUES (1,2,21,'Cuidados intensivos');

INSERT INTO sala
VALUES (1,3,67,'Psiquiatrico');

INSERT INTO sala
VALUES (1,4,53,'Cardiologia');

INSERT INTO sala
VALUES (1,5,10,'Recuperacion');

INSERT INTO sala
VALUES (2,1,88,'Maternidad');

INSERT INTO sala
VALUES (2,2,88,'Cuidados intensivos');

INSERT INTO sala
VALUES (2,3,88,'Psiquiatrico');

INSERT INTO sala
VALUES (2,4,88,'Cardiologia');

INSERT INTO sala
VALUES (2,5,88,'Recuperacion');

INSERT INTO sala
VALUES (3,5,99,'Maternidad');

INSERT INTO sala
VALUES (3,4,99,'Cuidados intensivos');

INSERT INTO sala
VALUES (3,3,99,'Psiquiatrico');

INSERT INTO sala
VALUES (3,2,99,'Cardiologia');

INSERT INTO sala
VALUES (3,1,99,'Recuperacion');

INSERT INTO sala
VALUES (4,1,10,'Maternidad');

INSERT INTO sala
VALUES (4,2,11,'Cuidados intensivos');

INSERT INTO sala
VALUES (4,3,12,'Psiquiatrico');

INSERT INTO sala
VALUES (4,4,13,'Cardiologia');

INSERT INTO sala
VALUES (5,1,10,'Maternidad');

INSERT INTO sala
VALUES (5,2,11,'Cuidados intensivos');

INSERT INTO sala
VALUES (5,3,12,'Psiquiatrico');

INSERT INTO sala
VALUES (6,1,10,'Maternidad');

INSERT INTO sala
VALUES (6,2,11,'Cuidados intensivos');

INSERT INTO sala
VALUES (7,1,99,'Maternidad');


-- Inserciones en la tabla DOCTOR
INSERT INTO doctor
VALUES ('12345678A','Gutierrez J.','Raimundo','Cardiologia');

INSERT INTO doctor
VALUES ('12345678F','Gutierrez J.','Perico','Cardiologia');

INSERT INTO doctor
VALUES ('12345678J','Gutierrez T.','Iñaqui','Cardiologia');

INSERT INTO doctor
VaLUES ('12345678B','Soledad B.','Ines','Ginecologia');

INSERT INTO doctor
VaLUES ('12345678K','Casas B.','Bartolome','Ginecologia');

INSERT INTO doctor
VALUES ('12345678C','Moreno D.','Rosa','Pediatria');

INSERT INTO doctor
VALUES ('12345678L','Moreno D.','Maria','Pediatria');

INSERT INTO doctor
VALUES ('12345678M','Moreno D.','Isidoro','Pediatria');

INSERT INTO doctor
VALUES ('12345678N','Moreno D.','Antonio','Pediatria');

INSERT INTO doctor
VALUES ('12345678D','Del Toro D.','Ramiro','Psiquiatria');

INSERT INTO doctor
VALUES ('22345678A','Fermin J.','Edmunto','Cardiologia');

INSERT INTO doctor
VALUES ('22345678J','Lopez T.','Iñaqui','Cardiologia');

INSERT INTO doctor
VaLUES ('22345678B','Acaso B.','Ines','Ginecologia');

INSERT INTO doctor
VaLUES ('22345678K','Torres B.','Bartolome','Ginecologia');

INSERT INTO doctor
VALUES ('22345678C','Moreno D.','Rosa','Pediatria');

INSERT INTO doctor
VALUES ('32345678A','Fernandez J.','Loli','Cardiologia');

INSERT INTO doctor
VALUES ('32345678P','Fermin J.','Jorge','Cardiologia');

INSERT INTO doctor
VALUES ('32345678J','Lopez T.','Samuel','Cardiologia');

INSERT INTO doctor
VaLUES ('32345678B','Acaso B.','Maria','Ginecologia');

INSERT INTO doctor
VaLUES ('32345678K','Torres B.','Tirano','Ginecologia');

INSERT INTO doctor
VALUES ('42345678A','Fernandez J.','Ramon','Cardiologia');

INSERT INTO doctor
VALUES ('42345678M','Fermin J.','Fede','Cardiologia');

INSERT INTO doctor
VALUES ('42345678J','Lopez T.','Loles','Cardiologia');

INSERT INTO doctor
VaLUES ('42345678B','Acaso B.','Maica','Ginecologia');

INSERT INTO doctor
VaLUES ('42345678K','Torres B.','Toñin','Ginecologia');

INSERT INTO doctor
VALUES ('52345678A','Fernandez J.','Ramon','Cardiologia');

INSERT INTO doctor
VALUES ('52345678T','Fermin J.','Fede','Cardiologia');

INSERT INTO doctor
VALUES ('52345678J','Lopez T.','Loles','Cardiologia');

INSERT INTO doctor
VaLUES ('52345678B','Acaso B.','Maica','Ginecologia');

INSERT INTO doctor
VALUES ('62345678A','Fernandez J.','Rocio','Cardiologia');

INSERT INTO doctor
VALUES ('62345678J','Lopez T.','Carlos','Cardiologia');

INSERT INTO doctor
VaLUES ('62345678K','Torres B.','Juan','Ginecologia');

INSERT INTO doctor
VALUES ('72345678J','Lopez T.','JuanMa','Cardiologia');

-- Inserciones en la tabla DOCTOR_HOSPITAL

INSERT INTO doctor_hospital
VALUES (1,'12345678A');

INSERT INTO doctor_hospital
VALUES (1,'12345678F');

INSERT INTO doctor_hospital
VALUES (1,'12345678J');

INSERT INTO doctor_hospital
VaLUES (1,'12345678B');

INSERT INTO doctor_hospital
VaLUES (1,'12345678K');

INSERT INTO doctor_hospital
VALUES (1,'12345678C');

INSERT INTO doctor_hospital
VALUES (1,'12345678L');

INSERT INTO doctor_hospital
VALUES (1,'12345678M');

INSERT INTO doctor_hospital
VALUES (1,'12345678N');

INSERT INTO doctor_hospital
VALUES (1,'12345678D');

INSERT INTO doctor_hospital
VALUES (2,'12345678A');

INSERT INTO doctor_hospital
VALUES (2,'22345678A');

INSERT INTO doctor_hospital
VALUES (2,'22345678J');

INSERT INTO doctor_hospital
VaLUES (2,'22345678B');

INSERT INTO doctor_hospital
VaLUES (2,'22345678K');

INSERT INTO doctor_hospital
VALUES (2,'22345678C');

INSERT INTO doctor_hospital
VALUES (3,'32345678A');

INSERT INTO doctor_hospital
VALUES (3,'32345678P');

INSERT INTO doctor_hospital
VALUES (3,'32345678J');

INSERT INTO doctor_hospital
VaLUES (3,'32345678B');

INSERT INTO doctor_hospital
VaLUES (3,'32345678K');

INSERT INTO doctor_hospital
VALUES (3,'22345678C');

INSERT INTO doctor_hospital
VALUES (4,'42345678A');

INSERT INTO doctor_hospital
VALUES (4,'42345678M');

INSERT INTO doctor_hospital
VALUES (4,'42345678J');

INSERT INTO doctor_hospital
VaLUES (4,'42345678B');

INSERT INTO doctor_hospital
VaLUES (4,'42345678K');

INSERT INTO doctor_hospital
VALUES (5,'52345678A');

INSERT INTO doctor_hospital
VALUES (5,'52345678T');

INSERT INTO doctor_hospital
VALUES (5,'52345678J');

INSERT INTO doctor_hospital
VaLUES (5,'52345678B');

INSERT INTO doctor_hospital
VALUES (6,'62345678A');

INSERT INTO doctor_hospital
VALUES (6,'62345678J');

INSERT INTO doctor_hospital
VaLUES (6,'62345678K');

INSERT INTO doctor_hospital
VALUES (7,'62345678A');

INSERT INTO doctor_hospital
VALUES (7,'72345678J');

-- Inserciones en la tabla DEPARTAMENTO

INSERT INTO departamento
VALUES(1,'CONTABILIDAD');

INSERT INTO departamento
VALUES(2,'INVESTIGACION');

INSERT INTO departamento
VALUES(3,'FACTURACION');

INSERT INTO departamento
VALUES(4,'ADMINISTRACION');

INSERT INTO departamento
VALUES(5,'FARMACIA');

INSERT INTO departamento
VALUES(6,'LIMPIEZA');


-- Inserciones en la tabla EMPLEADO

INSERT INTO empleado
VALUES('10000000A',TO_DATE('10012002','DDMMYYYY'),'Jorge',1000.22,3000.11,'DIRECTOR','Perez Sala',NULL);

INSERT INTO empleado
VALUES('20000000B',TO_DATE('11012002','DDMMYYYY'),'Javier',500.22,2000.22,'GERENTE','Sala Rodriguez','10000000A');

INSERT INTO empleado
VALUES('30000000C',TO_DATE('11012002','DDMMYYYY'),'Soledad',500.33,2000.33,'ADMISTRADOR','Lopez J.','10000000A');

INSERT INTO empleado
VALUES('40000000D',TO_DATE('12012002','DDMMYYYY'),'Sonia',NULL,1800.44,'JEFE FARMACIA','Moldes R.','20000000B');

INSERT INTO empleado
VALUES('50000000E',TO_DATE('12012002','DDMMYYYY'),'Antonio',300.44,1800.44,'JEFE LABORATORIO','Lopez A.','20000000B');

INSERT INTO empleado
VALUES('60000000F',TO_DATE('12012002','DDMMYYYY'),'Carlos',500.55,1800.55,'CONTABLE','Roa D.','30000000C');

INSERT INTO empleado
VALUES('70000000G',TO_DATE('13012002','DDMMYYYY'),'Lola',NULL,1000,'ADMINISTRATIVO','Sanchez D.','60000000F');

INSERT INTO empleado
VALUES('80000000L',TO_DATE('13012002','DDMMYYYY'),'Angel',NULL,1000,'ADMINISTRATIVO','Perez','60000000F');

INSERT INTO empleado
VALUES('90000000M',TO_DATE('12012002','DDMMYYYY'),'Ramon',NULL,1500,'JEFE LIMPIEZA','Maria Casas','20000000B');

INSERT INTO empleado
VALUES('11000000P',TO_DATE('14012002','DDMMYYYY'),'Luis',NULL,700,'HIGIENE','Sanchez D.','90000000M');

INSERT INTO empleado
VALUES('12000000Q',TO_DATE('14012002','DDMMYYYY'),'Rosa',NULL,700,'HIGIENE','Torres A.','90000000M');

INSERT INTO empleado
VALUES('10000000N',TO_DATE('14012002','DDMMYYYY'),'Sara',200,1000,'INVESTIGADOR','Gomez A.','50000000E');


-- Inserciones en la tabla EMPLEADO_HOSPITAL

INSERT INTO empleado_hospital
VALUES(1,'10000000A');

INSERT INTO empleado_hospital
VALUES(1,'20000000B');

INSERT INTO empleado_hospital
VALUES(1,'30000000C');

INSERT INTO empleado_hospital
VALUES(1,'40000000D');

INSERT INTO empleado_hospital
VALUES(1,'50000000E');

INSERT INTO empleado_hospital
VALUES(1,'60000000F');

INSERT INTO empleado_hospital
VALUES(1,'70000000G');

INSERT INTO empleado_hospital
VALUES(1,'80000000L');

INSERT INTO empleado_hospital
VALUES(1,'90000000M');

INSERT INTO empleado_hospital
VALUES(1,'11000000P');

INSERT INTO empleado_hospital
VALUES(1,'12000000Q');

INSERT INTO empleado_hospital
VALUES(1,'10000000N');

INSERT INTO empleado_hospital
VALUES(2,'10000000A');

INSERT INTO empleado_hospital
VALUES(2,'20000000B');

INSERT INTO empleado_hospital
VALUES(2,'30000000C');

INSERT INTO empleado_hospital
VALUES(2,'40000000D');

INSERT INTO empleado_hospital
VALUES(2,'50000000E');

INSERT INTO empleado_hospital
VALUES(2,'70000000G');

INSERT INTO empleado_hospital
VALUES(2,'80000000L');

INSERT INTO empleado_hospital
VALUES(2,'90000000M');

INSERT INTO empleado_hospital
VALUES(2,'11000000P');

INSERT INTO empleado_hospital
VALUES(2,'12000000Q');

INSERT INTO empleado_hospital
VALUES(2,'10000000N');

INSERT INTO empleado_hospital
VALUES(3,'10000000A');

INSERT INTO empleado_hospital
VALUES(3,'20000000B');

INSERT INTO empleado_hospital
VALUES(3,'30000000C');

INSERT INTO empleado_hospital
VALUES(3,'40000000D');

INSERT INTO empleado_hospital
VALUES(3,'80000000L');

INSERT INTO empleado_hospital
VALUES(3,'90000000M');

INSERT INTO empleado_hospital
VALUES(3,'11000000P');

INSERT INTO empleado_hospital
VALUES(3,'12000000Q');

INSERT INTO empleado_hospital
VALUES(3,'10000000N');

INSERT INTO empleado_hospital
VALUES(4,'10000000A');

INSERT INTO empleado_hospital
VALUES(4,'20000000B');

INSERT INTO empleado_hospital
VALUES(4,'30000000C');

INSERT INTO empleado_hospital
VALUES(4,'40000000D');

INSERT INTO empleado_hospital
VALUES(4,'80000000L');

INSERT INTO empleado_hospital
VALUES(4,'90000000M');

INSERT INTO empleado_hospital
VALUES(4,'12000000Q');

INSERT INTO empleado_hospital
VALUES(4,'10000000N');

INSERT INTO empleado_hospital
VALUES(5,'10000000A');

INSERT INTO empleado_hospital
VALUES(5,'20000000B');

INSERT INTO empleado_hospital
VALUES(5,'30000000C');

INSERT INTO empleado_hospital
VALUES(5,'40000000D');

INSERT INTO empleado_hospital
VALUES(5,'80000000L');

INSERT INTO empleado_hospital
VALUES(5,'12000000Q');

INSERT INTO empleado_hospital
VALUES(5,'10000000N');

INSERT INTO empleado_hospital
VALUES(6,'10000000A');

INSERT INTO empleado_hospital
VALUES(6,'20000000B');

INSERT INTO empleado_hospital
VALUES(6,'30000000C');

INSERT INTO empleado_hospital
VALUES(6,'40000000D');

INSERT INTO empleado_hospital
VALUES(6,'12000000Q');

INSERT INTO empleado_hospital
VALUES(6,'10000000N');

-- Inserciones en la tabla PLANTILLA
INSERT INTO plantilla
VALUES('11111111A',15000.22,'Alejandro','M','A.A.','ENFERMERO');

INSERT INTO plantilla
VALUES('11111111B',15000.22,'Bartolome','T','B.B.','ENFERMERO');

INSERT INTO plantilla
VALUES('11111111C',15000.22,'Carlos','N','C.C.','ENFERMERO');

INSERT INTO plantilla
VALUES('22222222A',15000.22,'Adriana','M','A.A.','ENFERMERA');

INSERT INTO plantilla
VALUES('22222222B',15000.22,'Bibiana','T','B.B.','ENFERMERA');

INSERT INTO plantilla
VALUES('22222222C',15000.22,'Casilda','N','C.C.','ENFERMERA');

INSERT INTO plantilla
VALUES('33333333A',15000.22,'Alberto','M','A.A.','ENFERMERO');

INSERT INTO plantilla
VALUES('33333333B',15000.22,'Bonifacio','T','B.B.','ENFERMERO');

INSERT INTO plantilla
VALUES('33333333C',15000.22,'Casimiro','N','C.C.','ENFERMERO');

INSERT INTO plantilla
VALUES('44444444A',15000.22,'Amelia','M','A.A.','ENFERMERA');

INSERT INTO plantilla
VALUES('44444444B',15000.22,'Bony','T','B.B.','ENFERMERA');

INSERT INTO plantilla
VALUES('44444444C',15000.22,'Casandra','N','C.C.','ENFERMERA');

INSERT INTO plantilla
VALUES('55555555A',15000.22,'Armando','M','A.A.','ENFERMERO');

INSERT INTO plantilla
VALUES('55555555B',15000.22,'Benicio','T','B.B.','ENFERMERO');

INSERT INTO plantilla
VALUES('55555555C',15000.22,'Ciceron','N','C.C.','ENFERMERO');

 

-- Inserciones en la tabla PLANTILLA_SALA

INSERT INTO plantilla_sala
VALUES(1,1,'11111111A');

INSERT INTO plantilla_sala
VALUES(1,1,'11111111B');

INSERT INTO plantilla_sala
VALUES(1,1,'11111111C');

INSERT INTO plantilla_sala
VALUES(1,2,'22222222A');

INSERT INTO plantilla_sala
VALUES(1,2,'22222222B');

INSERT INTO plantilla_sala
VALUES(1,2,'22222222C');

INSERT INTO plantilla_sala
VALUES(1,3,'33333333A');

INSERT INTO plantilla_sala
VALUES(1,3,'33333333B');

INSERT INTO plantilla_sala
VALUES(1,3,'33333333C');

INSERT INTO plantilla_sala
VALUES(1,4,'44444444A');

INSERT INTO plantilla_sala
VALUES(1,4,'44444444B');

INSERT INTO plantilla_sala
VALUES(1,4,'44444444C');

INSERT INTO plantilla_sala
VALUES(1,5,'55555555A');

INSERT INTO plantilla_sala
VALUES(1,5,'55555555B');

INSERT INTO plantilla_sala
VALUES(1,5,'55555555C');

INSERT INTO plantilla_sala
VALUES(2,1,'11111111A');

INSERT INTO plantilla_sala
VALUES(2,1,'11111111B');

INSERT INTO plantilla_sala
VALUES(2,2,'22222222A');

INSERT INTO plantilla_sala
VALUES(2,2,'22222222B');

INSERT INTO plantilla_sala
VALUES(2,3,'33333333A');

INSERT INTO plantilla_sala
VALUES(2,3,'33333333B');

INSERT INTO plantilla_sala
VALUES(2,4,'44444444A');

INSERT INTO plantilla_sala
VALUES(2,4,'44444444B');

INSERT INTO plantilla_sala
VALUES(2,5,'55555555A');

INSERT INTO plantilla_sala
VALUES(2,5,'55555555B');

INSERT INTO plantilla_sala
VALUES(3,1,'11111111A');

INSERT INTO plantilla_sala
VALUES(3,2,'22222222A');

INSERT INTO plantilla_sala
VALUES(3,3,'33333333A');

INSERT INTO plantilla_sala
VALUES(3,4,'44444444A');

INSERT INTO plantilla_sala
VALUES(3,5,'55555555A');

INSERT INTO plantilla_sala
VALUES(4,1,'11111111A');

INSERT INTO plantilla_sala
VALUES(4,2,'22222222A');

INSERT INTO plantilla_sala
VALUES(4,3,'33333333A');

INSERT INTO plantilla_sala
VALUES(4,4,'44444444A');

INSERT INTO plantilla_sala
VALUES(6,1,'11111111A');

INSERT INTO plantilla_sala
VALUES(6,2,'22222222A');

INSERT INTO plantilla_sala
VALUES(7,1,'11111111A');


-- Inserciones en la tabla DEPARTAMENTO_EMPLEADO

INSERT INTO departamento_empleado
VALUES(4,'10000000A');

INSERT INTO departamento_empleado
VALUES(4,'20000000B');

INSERT INTO departamento_empleado
VALUES(4,'30000000C');

INSERT INTO departamento_empleado
VALUES(5,'40000000D');

INSERT INTO departamento_empleado
VALUES(2,'50000000E');

INSERT INTO departamento_empleado
VALUES(1,'60000000F');

INSERT INTO departamento_empleado
VALUES(1,'70000000G');

INSERT INTO departamento_empleado
VALUES(1,'80000000L');

INSERT INTO departamento_empleado
VALUES(6,'90000000M');

INSERT INTO departamento_empleado
VALUES(6,'11000000P');

INSERT INTO departamento_empleado
VALUES(6,'12000000Q');

INSERT INTO departamento_empleado
VALUES(2,'10000000N');

-- Inserciones en la tabla EMPLEADO

INSERT INTO empleado
VALUES('12345678B',TO_DATE('11011970','DDMMYYYY'),'Juan',NULL,3000,'DIRECTOR','Lopez Z.',NULL);

INSERT INTO empleado
VALUES('87654321A',TO_DATE('12011975','DDMMYYYY'),'Fermin',1000,2000,'GERENTE','Garcia L.','12345678B');

INSERT INTO empleado
VALUES('64328285C',TO_DATE('13011979','DDMMYYYY'),'Rosa',NULL,1500,'ADMINISTRADOR','Miranda R.','87654321A');

INSERT INTO empleado
VALUES('83253235F',TO_DATE('14011980','DDMMYYYY'),'Miguel',300,1000,'CONTABLE','Soria T.','64328285C');



-- Inserciones en la tabla DEPARTAMENTO_EMPLEAO
INSERT INTO departamento_empleado
VALUES(4,'12345678B');

INSERT INTO departamento_empleado
VALUES(4,'87654321A');

INSERT INTO departamento_empleado
VALUES(4,'64328285C');

INSERT INTO departamento_empleado
VALUES(4,'83253235F');

COMMIT;

--Data Retrieval Using the SQL SELECT Statement.

-- Selecting All Columns.

SELECT * FROM DEPARTAMENTO;

SELECT * FROM DEPARTAMENTO_EMPLEADO;

SELECT * FROM DOCTOR;

SELECT * FROM DOCTOR_HOSPITAL;

SELECT * FROM EMPLEADO;

SELECT * FROM EMPLEADO_HOSPITAL;

SELECT * FROM ENFERMO;

SELECT * FROM HOSPITAL;

SELECT * FROM HOSPITAL_ENFERMO;

SELECT * FROM PLANTILLA;

SELECT * FROM PLANTILLA_SALA;

SELECT * FROM SALA;

SELECT * FROM EMPLEADO WHERE NOMBRE IN('Jorge','Lola');

SELECT * FROM HOSPITAL_ENFERMO WHERE inscripcion = 1;

SELECT * FROM HOSPITAL_ENFERMO HE,HOSPITAL H,ENFERMO E 
              WHERE HE.HOSP_CODIGO =H.CODIGO
              AND  e.numsegsocial =he.enf_numsegsocial;

 