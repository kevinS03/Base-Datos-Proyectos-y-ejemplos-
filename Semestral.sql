--------------------------------creacion de base de datos---------------------------------------------
create database Semestral 
use Semestral
----------------------------------Creacion de tablas--------------------------------------------------
create table Cliente 
(
  CL_codcliente int identity 
		CONSTRAINT PK_cliente_cod_cliente PRIMARY KEY,
  CL_nombre varchar (30),
  CL_apellido varchar(30),
  CL_identificacion varchar(13) 
		constraint  CL_identificacion  Unique (CL_identificacion),
  CL_numerodetarjeta varchar(30)
		constraint Cl_numerodetarjeta
				check(CL_numerodetarjeta like '[0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'), 
  CL_tipodetarjeta char (2)
		constraint CL_tipodetarjeta 
				check (CL_tipodetarjeta in('DR','CR'))
  )
--********************************************************************************************
--********************************************************************************************
  create table T_Plan 
  (
   P_codigo char
			constraint CK_P_codigo 
					check (P_codigo like '[1-3]'),
			constraint PK_P_codigo primary key(P_codigo),
   P_tipo varchar(8) 
			constraint P_tipo
					--check (P_tipo = 'Básico' or P_tipo='Estandar' or P_tipo='Ultra'),
					check (P_tipo in('Básico','Estandar','Ultra')),
   P_montoapagar money 
   ) 
--********************************************************************************************
--********************************************************************************************
   create table Contrato 
   (
    C_cod_cliente int
			constraint FK_C_cod_cliente foreign key (C_cod_cliente) references Cliente(CL_codcliente) on delete cascade,
	C_cod_plan char 
			constraint FK_C_cod_plan 
					foreign key (C_cod_plan) 
					references T_plan(P_codigo) on delete cascade,
			constraint CK_C_codigo 
					check (C_cod_plan like '[1-3]'),
			constraint PK_C_c_cod_plan_c_cod_cliente primary key (c_cod_plan, c_cod_cliente),
	C_No_contrato int identity(60000000,1),
	C_fecha date 
			constraint ck_c_fecha 
					check(C_fecha >= cast('1997/08/29' as date) and C_fecha<=getdate())
	)
--********************************************************************************************
--********************************************************************************************
	Create table Pago 
	(
	 Pa_cod_cliente int
			constraint FK_pa_cod_cliente foreign key (Pa_cod_cliente) references Cliente(CL_codcliente) on delete cascade,
	 Pa_cod_plan char
			constraint FK_C_cod_pla 
					foreign key (Pa_cod_plan) 
					references T_plan(P_codigo) on delete cascade,
			constraint CK_C_codig 
				check (Pa_cod_plan like '[1-3]'),
			constraint PK_Pago_cod_cliente_cod_plan primary key(Pa_cod_cliente,Pa_cod_plan),
	 Pa_monto money,
	 Pa_Fecha date
 )
--********************************************************************************************
--********************************************************************************************
	 create table genero
	 (
	  ge_codigo char(2)
			constraint pk_generocodigo primary key,
	  ge_nombre varchar(30)
	  )

--********************************************************************************************
--********************************************************************************************
	 Create table Programa 
	 (
	  Pr_cod_programa int identity (1000,1)
			constraint Pk_pr_cod_programa primary key,
	  Pr_nombre varchar(50),
	  Pr_edad_rec int,
			constraint ck_pr_edad_rec 
					check(Pr_edad_rec<=10 or Pr_edad_rec between 11 and 17 or Pr_edad_rec>=18),
	  Pr_t_genero char(2)
			constraint fk_genero 
					foreign key(Pr_t_genero) 
					references genero(ge_codigo) on delete cascade,
	  Pr_duracion int 
			constraint ck_durac 
					check (Pr_duracion between 30 and 300),
	  pr_descripcion varchar(90),

	 )
--********************************************************************************************
--********************************************************************************************
	  create table capitulos 
	 (
	  cap_codigo int
			  constraint ck_cap_codigo 
					check (cap_codigo like '[1-9][1-9][1-9][1-9]-[1-9]' or cap_codigo like '[1-9][1-9][1-9][1-9]-[1-9][0-9]')
			  constraint pk_cap_codigo primary key(cap_codigo),
	  cap_duracion int 
			constraint ck_duracion 
					check(cap_duracion between 15 and 90),
	  cap_codigo_pr int
			constraint Fk_cap_codigo_pr 
					foreign key (Cap_codigo_pr) 
					references Programa(Pr_cod_programa),
	  cap_descripcion varchar(90)
	
     )
--********************************************************************************************
--********************************************************************************************
	 create table protagonista 
	  (
	   pro_cod int identity
			constraint pk_pro_cod primary key,
	   pro_cod_programa int
			constraint Fk_pro_cod_programa 
					foreign key (pro_cod_programa) 
					references Programa(Pr_cod_programa)on delete cascade,
	   pro_nombre varchar(30),
	   pro_descripcion varchar(90)
      )
--********************************************************************************************
--********************************************************************************************
	 create table visualizaciones 
	 (
	  vi_cod_cliente int
			constraint fk_vi_cod_cliente foreign key (vi_cod_cliente) references Cliente(CL_codcliente),
	  vi_cod_program int
			constraint fk_vi_cod_programa 
					foreign key (vi_cod_program) 
					references Programa(Pr_cod_programa),
	  constraint PK_visualizaciones_cod_cliente_cod_program primary key (vi_cod_cliente,vi_cod_program),
	  vi_tiempo int  
	 )
--********************************************************************************************
--********************************************************************************************


