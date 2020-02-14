create database Proyecto1BD2;
use Proyecto1BD2;


create table PROVINCIAS
(
	Numero_provincia char(2) 
				constraint PK_Provincias_NumeroProvincia PRIMARY KEY
				constraint CHEK_Provincias_NumeroProvincia 
					check(Numero_provincia like('[0][1-9]')
					OR	Numero_provincia like('[1][0-3]')),
	Nombre_provincia char(35) 
				constraint CHEK_Provincias_NombreProvincia 
					check(Nombre_provincia in (
					'Bocas del toro','Coclé','Colón','Chiriquí','Darién','Herrera','Los Santos','Panamá','Veraguas','Panamá Oeste','Emberá-Wounaan','Guna-Yala,Madugandí,Wargandí','Ngabe-Buglé'))
)

create table CORREGIMIENTO
(
	Cod_corregimiento int identity
				constraint PK_corregimientoCodCorregimiento PRIMARY KEY,
	Nombre_Corregimiento char(40),
	Provincia_perteneciente char(2)
				constraint DF_CORREGIMIENTO_Provincia_perteneciente	default '08',
				constraint FK_corregimientoProvinciapertene
				foreign key (Provincia_perteneciente)
				references PROVINCIAS(Numero_provincia)ON UPDATE CASCADE 
)




create table DIRECTOR
(
	DNI_Director char(12) 
				constraint PK_Director_DNIdirector PRIMARY KEY
				constraint CHECK_Director_DNIdirector 
					check(DNI_Director like '[0][1-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'OR 
						DNI_Director like'[1][0-3][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'OR 
						DNI_Director like'[P][E][-][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'OR 
						DNI_Director like'[E][-][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'OR 
						DNI_Director like'[E][E][-][0-9][0-9][0-9][-][0-9][0-9][0-9]'OR 
						DNI_Director like'[N][-][0-9][0-9][0-9][-][0-9][0-9][0-9]'OR 
						DNI_Director like'[1,4,5,8,9][-][0-9][0-9][0-9][-][0-9][0-9][0-9]'OR 
						DNI_Director like'[3][5][B]'OR 
						DNI_Director like'[1-9][A][W][-][0-9][0-9][0-9][-][0-9][0-9][0-9]'),
	Nombre_Director char(40)not null,
	Apellido_Director char(40) not null,
	Fecha_Inicio date not null
				constraint CHECK_Director_FechaInicio 
					check(Fecha_Inicio<=getDate())
)

create table TELEFONO
(
	Numero_telefonico char(8)
				constraint PK_TELEFONO_Numero_telefonico primary key
				constraint CHEK_telefono_Numerotelefonico 
					check(Numero_telefonico like('[6][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
	Telefono_director char(12)
				constraint FK_Telefono_TelefonoDirector
				foreign key(Telefono_director)
				references DIRECTOR(DNI_Director) 
)


create table EMAIL
(
	Correo_eletronico char(40)
			constraint PK_EMAIL_Correo_eletronico primary key,
	Correo_director char(12)
				constraint FK_EMAIL_Correo_director
				foreign key(Correo_director)
				references DIRECTOR(DNI_Director) 
)

create table ESCUELA
(
	Cod_escuela char(10) 
			constraint PK_escuelaCodescuela primary key
			constraint Chek_escuelaCodescuela check( Cod_escuela like(
			'[0][1-9][-][P][U][-][0-9][0-9][0-9][0-9]')OR Cod_escuela like(
			'[1][0-3][-][P][U][-][0-9][0-9][0-9][0-9]')OR Cod_escuela like(
			'[0][1-9][-][P][R][-][0-9][0-9][0-9][0-9]')OR Cod_escuela like(
			'[1][0-3][-][P][R][-][0-9][0-9][0-9][0-9]') 
			),
	Nombre_escuela char(40)not null,
	Calle varchar(40)not null,
	Numero_calle char(10)not null,
	Corregimiento_perteneciente int not null,
			constraint FK_escuelaCorregimiento 
			foreign key(Corregimiento_perteneciente)
			references CORREGIMIENTO(Cod_corregimiento) ON delete CASCADE,
	Director_Escuela char(12) not null,
			constraint FK_escuelaDirectorEscuela
			foreign key (Director_Escuela)
			references DIRECTOR(DNI_Director)ON delete CASCADE ON UPDATE CASCADE
)



create table PROGRAMA
(
	Cod_Programa int identity(1000,1)
			constraint PK_programa_CodPrograma PRIMARY KEY,
	Programa_oficial char(15) not null,
			constraint CHEK_Programa_ProgramaOficial check(Programa_oficial in(
			'Pre escolar','Primaria','Pre media','Media','Nocturna','Penitenciria','Tele educacion'))
)

create table ESCUELAPROGRAMA
(
	cod_e char(10)
		constraint FK_ESCUELAPROGRAMA_cod_e
			foreign key (cod_e)
			references ESCUELA(Cod_escuela) on delete cascade on update cascade,
	cod_p int
		constraint FK_ESCUELAPROGRAMA_cod_p
			foreign key (cod_p)
			references PROGRAMA(Cod_Programa) on delete cascade on update cascade,

	matricula int not null,
		constraint CHECK_ESCUELAPROGRAMA_matricula 
			check(matricula >=0),
	Turno char(10) not null
		constraint CHECK_ESCUELAPROGRAMA_Turno
		check(Turno in('matutino','vespertino','nocturno')),
	constraint PK_ESCUELAPROGRAMA_cod_e_cod_p 
		primary key(cod_e,cod_p,Turno)
)



create table DOCENTE
(
	DNI_Docente char(12)
			constraint PK_Docente_DNIdocente PRIMARY KEY
			constraint CHEK_Docente_DNIdocente check(DNI_Docente like(
				'[0][1-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]')OR DNI_Docente like(
				'[1][0-3][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]')OR DNI_Docente like(
				'[P][E][-][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]')OR DNI_Docente like(
				'[E][-][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]')OR DNI_Docente like(
				'[E][E][-][0-9][0-9][0-9][-][0-9][0-9][0-9]')OR DNI_Docente like(
				'[N][-][0-9][0-9][0-9][-][0-9][0-9][0-9]')OR DNI_Docente like(
				'[1,4,5,8,9][-][0-9][0-9][0-9][-][0-9][0-9][0-9]')OR DNI_Docente like(
				'[3][5][B]')OR DNI_Docente like(
				'[1-9][A][W][-][0-9][0-9][0-9][-][0-9][0-9][0-9]')),
	Fecha_Nacimiento date,
				constraint CHEK_Docente_FechaNacimiento 
					check(DATEDIFF(YEAR,Fecha_Nacimiento,getdate())<=60 and DATEDIFF(YEAR,Fecha_Nacimiento,getdate())>=19),
	Telefono_Docente char(8) not null,
				constraint CHEK_Docente_TelefonoDocente 
					check(Telefono_Docente like('[6][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
	EMAIL_Docente char(40) not null,
	Primer_nombre char(20)not null,
	Apellido char(30)not null,
	Escuela_Trabajo char(10)
				constraint FK_Docente_EscuelaTrabajo
				foreign key(Escuela_Trabajo)
				references ESCUELA(Cod_escuela)ON DELETE CASCADE ON UPDATE CASCADE

)


create table ESPECIALIDADES
(
	Cod_especialidades char(4)
				constraint PK_Especialidades_CODespecialidades primary key
				constraint CHEK_Especialidades_CODespecialidades 
				check(Cod_especialidades like('[A-Z][A-Z][A-Z][A-Z]')),
	Nombre_especialidades char(80)not null
)


create table DOCEESPECIA
(
	DNI_Docente_DOCEESPECIA char(12)
				constraint FK_DOCEESPECIA_DNIDocenteDOCEESPECIA
				foreign key(DNI_Docente_DOCEESPECIA)
				references DOCENTE(DNI_Docente)on delete cascade on update cascade,
	Cod_Especialidad_DOCEESPECIA char(4)
				constraint   FK_DOCEESPECIA_CodEspecialidadDOCEESPECIA
				foreign key(Cod_Especialidad_DOCEESPECIA)
				references ESPECIALIDADES(Cod_especialidades)on update cascade on delete cascade,

	constraint PK_DOCEESPECIA_DNI_COD PRIMARY KEY(DNI_Docente_DOCEESPECIA,Cod_Especialidad_DOCEESPECIA)
)
				
create table MATERIA
(
	Cod_Materia char(3) 
				constraint PK_Materia_CodMateria PRIMARY KEY
				constraint CHEK_Materia_CodMateria 
					check(Cod_Materia like('[A-Z][A-Z][A-Z]')OR 
					Cod_Materia like('[S][O][C]')),
	Nombre_Materia char(17) not null
				constraint CHEK_Materia_Nombre_Materia
					check (Nombre_Materia in('ARTISTICA','BIOLOGIA','CIENCIAS','CIENCIAS SOCIALES','CIVICA','CONTABILIDAD','CHINO','EDUCACION FISICA','ESPAÑOL','FRANCES','GEOGRAFIA','HISTORIA','INFORMATICA','INGLES','MATEMÁTICAS','MUSICA','QUIMICA','RELIGION'))
)


create table DOCENTEMATERIA
(
	DNI_Docente char(12)
		constraint FK_DOCENTEMATERIA_DNI_Docente
			foreign key (DNI_Docente)
			references DOCENTE(DNI_Docente),
	Cod_Materia char(3) 
		constraint FK_DOCENTEMATERIA_Cod_Materia
			foreign key (Cod_Materia)
			references MATERIA(Cod_Materia),
	constraint PK_DOCENTEMATERIA_DNI_Docente_Cod_Materia primary key(DNI_Docente,Cod_Materia)
)


--INSERTS
insert into PROVINCIAS(Numero_provincia,Nombre_provincia)
		values('01','Bocas del toro')

insert into PROVINCIAS(Numero_provincia,Nombre_provincia)
		values('02','Coclé')
			,('03','Colón')
			,('04','Chiriquí')
			,('05','Darién')
			,('06','Herrera')
			,('07','Los Santos')
			,('08','Panamá')
			,('09','Veraguas')
			,('10','Panamá Oeste')
			,('11','Emberá-Wounaan')
			,('12','Ngabe-Buglé')
			,('13','Guna-Yala,Madugandí,Wargandí')

select * from PROVINCIAS

insert CORREGIMIENTO(Nombre_Corregimiento,Provincia_perteneciente)
		values('Ernesto Cordoba','08')
			,('Las Cumbres','08')
			,('Puerto Armuelles','04')
insert into CORREGIMIENTO(Nombre_Corregimiento,Provincia_perteneciente)
		values('Vigia','03')
insert into CORREGIMIENTO(Nombre_Corregimiento,Provincia_perteneciente)
		values('Vigia','03')

select * from CORREGIMIENTO


insert into DIRECTOR(DNI_Director,Nombre_Director,Apellido_Director,Fecha_Inicio)
		values('08-0210-2405','Norato','Gonzalez','2008/02/14')
			,('08-0405-2281','Obdulia','John J','2010/06/30')
			,('08-0902-2019','Kevin','Santamaria',getdate())

select * from DIRECTOR

insert into TELEFONO(Numero_telefonico,Telefono_director)
		values('68121424','08-0210-2405')
			,('65550120','08-0405-2281')
			,('63069163','08-0902-2019')
			,('62917176','08-0902-2019')
insert into TELEFONO(Numero_telefonico,Telefono_director)
		values('62917176','08-0902-2019')
select * from  TELEFONO

insert into EMAIL(Correo_eletronico,Correo_director)
		values('ngonzalez@gmail.com','08-0210-2405')
			,('obduliajohn@gmail.com','08-0405-2281')
insert into EMAIL(Correo_eletronico,Correo_director)
		values('melo.near.m@gmail.com','08-0902-2019')

select * from EMAIL

insert into ESCUELA(Cod_escuela,Nombre_escuela,Calle,Numero_calle,Corregimiento_perteneciente,Director_Escuela)
		values('08-PU-0835','CENT EVO MONS FCOBECKMANN','Carretera Transistmica','null',2,'08-0210-2405')
			,('08-PR-0875','Escuela Bilingüe Saint John','Calle el Peñon','null',2,'08-0405-2281')
insert into ESCUELA(Cod_escuela,Nombre_escuela,Calle,Numero_calle,Corregimiento_perteneciente,Director_Escuela)
		values('03-PU-0335','Centro educativo Gatuncillo','Carretera Transistmica','Primera'
		,(select Cod_corregimiento from CORREGIMIENTO where Provincia_perteneciente = '03'),'08-0210-2405')
select * from ESCUELA


--DESABILITE EL CHECK PARA PODER INSERTAR (CORREGIR PROBLEMA CON EL CHEK_Programa_ProgramaOficial)
insert PROGRAMA(Programa_oficial)  
		values('Pre escolar')
			,('Primaria')
			,('Pre media')
			,('Media')
			,('Nocturna')
			,('Penitenciria')
			,('Tele educacion')

select * from PROGRAMA


	-- CORREGIR, NO INSERTA DATOS
insert ESCUELAPROGRAMA(cod_e,cod_p,matricula,Turno)  
		values('03-PU-0335','1002','2068','matutino')
		,('08-PU-0835',(select Cod_programa from PROGRAMA where Programa_oficial='Pre media'),'2018','vespertino')
select * from ESCUELAPROGRAMA      



insert DOCENTE(DNI_Docente,Fecha_Nacimiento,Telefono_Docente,EMAIL_Docente,Primer_nombre,Apellido,Escuela_Trabajo)
		values('08-0250-1001','1965','60208945','adisguardia@gmail.com','Adis','Guardia','03-PU-0335')
			,('08-0350-0245','1964','67152281','zorayachanis@gmail.com','Zoraya','Chanis','03-PU-0335')
			,('07-0401-2182','1980','63201254','amendoza@gmail.com','Ana','Mendoza','03-PU-0335')

select * from DOCENTE

insert into ESPECIALIDADES(Cod_especialidades,Nombre_especialidades)
		values('PREE','Pre-escolar')
insert into ESPECIALIDADES(Cod_especialidades,Nombre_especialidades)
		values('EDMD','Educación Media')
insert into ESPECIALIDADES(Cod_especialidades,Nombre_especialidades)
		values('LESP','Licenciatura en Español')
insert into ESPECIALIDADES(Cod_especialidades,Nombre_especialidades)
		values('LMAT','Licenciatura en Matemáticas')
insert into ESPECIALIDADES(Cod_especialidades,Nombre_especialidades)
		values('LING','Licenciatura en Inglés')
insert into ESPECIALIDADES(Cod_especialidades,Nombre_especialidades)
		values('LART','Licenciatura en Arte')
insert into ESPECIALIDADES(Cod_especialidades,Nombre_especialidades)
		values('LEDF','Licenciatura en Educación Física')
insert into ESPECIALIDADES(Cod_especialidades,Nombre_especialidades)
		values('LINF','Licenciatura en Informática')

select * from ESPECIALIDADES
			

insert DOCEESPECIA(DNI_Docente_DOCEESPECIA,Cod_Especialidad_DOCEESPECIA)
		values('08-0250-1001','EDMD')
			,('08-0350-0245','PREE')
			,('07-0401-2182','LMAT')

select * from DOCEESPECIA

insert MATERIA(Cod_Materia,Nombre_Materia)
		values('ESP','ESPAÑOL')
			,('MAT','MATEMÁTICAS')
			,('QUI','QUIMICA')
			,('CIE','CIENCIAS')
			,('HIS','HISTORIA')
			,('GEO','GEOGRAFIA')
			,('CIV','CIVICA')
			,('REL','RELIGION')
			,('BIO','BIOLOGIA')
			,('CON','CONTABILIDAD')
			,('ART','ARTISTICA')
			,('INF','INFORMATICA')
			,('EDU','EDUCACION FISICA')
			,('MUS','MUSICA')
			,('SOC','CIENCIAS SOCIALES')
			,('ING','INGLES')
			,('FRA','FRANCES')
			,('CHI','CHINO')

select * from MATERIA


insert DOCENTEMATERIA(DNI_Docente,Cod_Materia)
		values('08-0250-1001','QUI')
			,('07-0401-2182','MAT')

select * from DOCENTEMATERIA



insert into CORREGIMIENTO (Nombre_Corregimiento,Provincia_perteneciente)
            values('24 de diciembre','08')

alter table 