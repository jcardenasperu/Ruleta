use master;
DECLARE @validarDB int=0;
select @validarDB = count(name) from sys.databases where name = 'Juego';
print @validarDB
if @validarDB=1
	begin
		drop database Juego;
		create database Juego;
	end
else
	begin
		create database Juego;
	end

go
USE [Juego]
GO
/****** Object:  StoredProcedure [dbo].[usp_RuletaPrincial_Listado]    Script Date: 24/04/2021 14:11:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_RuletaPrincial_Listado]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_RuletaPrincial_Listado]
GO
/****** Object:  StoredProcedure [dbo].[usp_RuletaPrincial_Crear]    Script Date: 24/04/2021 14:11:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_RuletaPrincial_Crear]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_RuletaPrincial_Crear]
GO
/****** Object:  StoredProcedure [dbo].[usp_RuletaPrincial_Cerrar]    Script Date: 24/04/2021 14:11:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_RuletaPrincial_Cerrar]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_RuletaPrincial_Cerrar]
GO
/****** Object:  StoredProcedure [dbo].[usp_RuletaPrincial_Abrir]    Script Date: 24/04/2021 14:11:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_RuletaPrincial_Abrir]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_RuletaPrincial_Abrir]
GO
/****** Object:  StoredProcedure [dbo].[usp_RuletaParticpante_Validar]    Script Date: 24/04/2021 14:11:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_RuletaParticpante_Validar]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_RuletaParticpante_Validar]
GO
/****** Object:  StoredProcedure [dbo].[usp_RuletaParticipante_Apostar]    Script Date: 24/04/2021 14:11:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_RuletaParticipante_Apostar]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_RuletaParticipante_Apostar]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_RULETA_PARTICIPANTES_FecRegistro]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[RULETA_PARTICIPANTES] DROP CONSTRAINT [DF_RULETA_PARTICIPANTES_FecRegistro]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_RULETA_FecRegistro]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[RULETA] DROP CONSTRAINT [DF_RULETA_FecRegistro]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_RULETA_Estado]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[RULETA] DROP CONSTRAINT [DF_RULETA_Estado]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PARTICIPANTES_FecRegistro]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PARTICIPANTES] DROP CONSTRAINT [DF_PARTICIPANTES_FecRegistro]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ESTADOS_FecRegistro]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ESTADOS] DROP CONSTRAINT [DF_ESTADOS_FecRegistro]
END
GO
/****** Object:  Table [dbo].[RULETA_PARTICIPANTES]    Script Date: 24/04/2021 14:11:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RULETA_PARTICIPANTES]') AND type in (N'U'))
DROP TABLE [dbo].[RULETA_PARTICIPANTES]
GO
/****** Object:  Table [dbo].[RULETA]    Script Date: 24/04/2021 14:11:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RULETA]') AND type in (N'U'))
DROP TABLE [dbo].[RULETA]
GO
/****** Object:  Table [dbo].[PARTICIPANTES]    Script Date: 24/04/2021 14:11:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PARTICIPANTES]') AND type in (N'U'))
DROP TABLE [dbo].[PARTICIPANTES]
GO
/****** Object:  Table [dbo].[ESTADOS]    Script Date: 24/04/2021 14:11:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTADOS]') AND type in (N'U'))
DROP TABLE [dbo].[ESTADOS]
GO
USE [master]
GO
/****** Object:  Database [Juego]    Script Date: 24/04/2021 14:11:48 ******/
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'Juego')
DROP DATABASE [Juego]
GO
/****** Object:  Database [Juego]    Script Date: 24/04/2021 14:11:48 ******/
CREATE DATABASE [Juego] ON  PRIMARY 
( NAME = N'Juego', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Juego.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Juego_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Juego_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Juego].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Juego] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Juego] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Juego] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Juego] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Juego] SET ARITHABORT OFF 
GO
ALTER DATABASE [Juego] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Juego] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Juego] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Juego] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Juego] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Juego] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Juego] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Juego] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Juego] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Juego] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Juego] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Juego] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Juego] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Juego] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Juego] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Juego] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Juego] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Juego] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Juego] SET  MULTI_USER 
GO
ALTER DATABASE [Juego] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Juego] SET DB_CHAINING OFF 
GO
USE [Juego]
GO
/****** Object:  Table [dbo].[ESTADOS]    Script Date: 24/04/2021 14:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESTADOS](
	[IdEstado] [char](1) NOT NULL,
	[NomEstado] [varchar](100) NOT NULL,
	[Origen] [varchar](30) NOT NULL,
	[IdeUsuarioReg] [int] NULL,
	[FecRegistro] [datetime] NULL,
	[IdeUsuarioAct] [int] NULL,
	[FecActualizado] [datetime] NULL,
 CONSTRAINT [PK_ESTADOS] PRIMARY KEY CLUSTERED 
(
	[IdEstado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PARTICIPANTES]    Script Date: 24/04/2021 14:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PARTICIPANTES](
	[IdParticipante] [int] IDENTITY(1,1) NOT NULL,
	[NomParticipante] [nvarchar](50) NOT NULL,
	[NumCredito] [decimal](20, 2) NOT NULL,
	[IdeUsuarioReg] [int] NULL,
	[FecRegistro] [datetime] NULL,
	[IdeUsuarioAct] [int] NULL,
	[FecActualizado] [datetime] NULL,
 CONSTRAINT [PK_CLIENTE] PRIMARY KEY CLUSTERED 
(
	[IdParticipante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RULETA]    Script Date: 24/04/2021 14:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RULETA](
	[IdRuleta] [int] IDENTITY(1,1) NOT NULL,
	[Estado] [char](1) NOT NULL,
	[IdeUsuarioReg] [int] NULL,
	[FecRegistro] [datetime] NULL,
	[IdeUsuarioAct] [int] NULL,
	[FecActualizado] [datetime] NULL,
 CONSTRAINT [PK_RULETA] PRIMARY KEY CLUSTERED 
(
	[IdRuleta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RULETA_PARTICIPANTES]    Script Date: 24/04/2021 14:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RULETA_PARTICIPANTES](
	[IdDetRuleta] [int] IDENTITY(1,1) NOT NULL,
	[IdRuleta] [int] NOT NULL,
	[IdParticipante] [int] NOT NULL,
	[NumCreditoApostado] [decimal](20, 2) NOT NULL,
	[ValorApostado] [varchar](10) NOT NULL,
	[NumCreditoGanado] [decimal](20, 2) NOT NULL,
	[MotivoGanador] [varchar](40) NOT NULL,
	[Estado] [char](1) NOT NULL,
	[IdeUsuarioReg] [int] NULL,
	[FecRegistro] [datetime] NULL,
	[IdeUsuarioAct] [int] NULL,
	[FecActualizado] [datetime] NULL,
 CONSTRAINT [PK_RULETA_PARTICIPANTES] PRIMARY KEY CLUSTERED 
(
	[IdDetRuleta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ESTADOS] ([IdEstado], [NomEstado], [Origen], [IdeUsuarioReg], [FecRegistro], [IdeUsuarioAct], [FecActualizado]) VALUES (N'A', N'Abierta', N'RULETA', 1, CAST(N'2021-04-22T13:28:05.020' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[ESTADOS] ([IdEstado], [NomEstado], [Origen], [IdeUsuarioReg], [FecRegistro], [IdeUsuarioAct], [FecActualizado]) VALUES (N'C', N'Cerrada', N'RULETA', 1, CAST(N'2021-04-22T13:28:05.020' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[ESTADOS] ([IdEstado], [NomEstado], [Origen], [IdeUsuarioReg], [FecRegistro], [IdeUsuarioAct], [FecActualizado]) VALUES (N'G', N'Gano', N'RULETAPARTICIPANTE', 1, CAST(N'2021-04-22T13:30:32.387' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[ESTADOS] ([IdEstado], [NomEstado], [Origen], [IdeUsuarioReg], [FecRegistro], [IdeUsuarioAct], [FecActualizado]) VALUES (N'O', N'Registrado', N'RULETAPARTICIPANTE', 1, CAST(N'2021-04-22T13:30:32.387' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[ESTADOS] ([IdEstado], [NomEstado], [Origen], [IdeUsuarioReg], [FecRegistro], [IdeUsuarioAct], [FecActualizado]) VALUES (N'P', N'Perdió', N'RULETAPARTICIPANTE', 1, CAST(N'2021-04-22T13:30:32.387' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[ESTADOS] ([IdEstado], [NomEstado], [Origen], [IdeUsuarioReg], [FecRegistro], [IdeUsuarioAct], [FecActualizado]) VALUES (N'R', N'Registrada', N'RULETA', 1, CAST(N'2021-04-22T13:28:05.020' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[PARTICIPANTES] ON 
GO
INSERT [dbo].[PARTICIPANTES] ([IdParticipante], [NomParticipante], [NumCredito], [IdeUsuarioReg], [FecRegistro], [IdeUsuarioAct], [FecActualizado]) VALUES (1, N'JORGE', CAST(48200.00 AS Decimal(20, 2)), 1, CAST(N'2021-04-22T15:59:33.127' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[PARTICIPANTES] ([IdParticipante], [NomParticipante], [NumCredito], [IdeUsuarioReg], [FecRegistro], [IdeUsuarioAct], [FecActualizado]) VALUES (2, N'LUIS', CAST(5000.00 AS Decimal(20, 2)), 1, CAST(N'2021-04-22T16:01:06.140' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[PARTICIPANTES] ([IdParticipante], [NomParticipante], [NumCredito], [IdeUsuarioReg], [FecRegistro], [IdeUsuarioAct], [FecActualizado]) VALUES (3, N'KEVIN', CAST(15000.00 AS Decimal(20, 2)), 1, CAST(N'2021-04-22T16:01:13.123' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[PARTICIPANTES] ([IdParticipante], [NomParticipante], [NumCredito], [IdeUsuarioReg], [FecRegistro], [IdeUsuarioAct], [FecActualizado]) VALUES (4, N'WILFREDO', CAST(10.00 AS Decimal(20, 2)), 1, CAST(N'2021-04-22T16:01:23.897' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[PARTICIPANTES] OFF
GO
ALTER TABLE [dbo].[ESTADOS] ADD  CONSTRAINT [DF_ESTADOS_FecRegistro]  DEFAULT (getdate()) FOR [FecRegistro]
GO
ALTER TABLE [dbo].[PARTICIPANTES] ADD  CONSTRAINT [DF_PARTICIPANTES_FecRegistro]  DEFAULT (getdate()) FOR [FecRegistro]
GO
ALTER TABLE [dbo].[RULETA] ADD  CONSTRAINT [DF_RULETA_Estado]  DEFAULT ('1') FOR [Estado]
GO
ALTER TABLE [dbo].[RULETA] ADD  CONSTRAINT [DF_RULETA_FecRegistro]  DEFAULT (getdate()) FOR [FecRegistro]
GO
ALTER TABLE [dbo].[RULETA_PARTICIPANTES] ADD  CONSTRAINT [DF_RULETA_PARTICIPANTES_FecRegistro]  DEFAULT (getdate()) FOR [FecRegistro]
GO
/****** Object:  StoredProcedure [dbo].[usp_RuletaParticipante_Apostar]    Script Date: 24/04/2021 14:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
DECLARE @mensaje VARCHAR(255);
exec usp_RuletaParticipante_Apostar 2,1,'2',1,1,@mensaje OUTPUT
SELECT @mensaje
*/
CREATE procedure [dbo].[usp_RuletaParticipante_Apostar]
(
@pIdRuleta int,
@pIdParticipante int,
@pValorApostar varchar(10),
@pCreditoApostar decimal(20,2),
@oMensajeError VARCHAR(255) OUTPUT
)
AS
/*************************************** 
*Descripcion: Registrar participante para apostar en una ruleta
*Fecha Creación: 24/04/2021
*Autor: Jorge Cardenas  
***************************************/
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @vIdRuleta INT;
DECLARE @vEstado VARCHAR(30);
DECLARE @vValidarRegistro INT;
DECLARE @vValidarParticipante INT;
DECLARE @vValidarCreditoTotal decimal(20,2);
DECLARE @vValidarEstado CHAR(1);
BEGIN TRY

	SELECT @vValidarRegistro = count(IdRuleta) FROM [RULETA] WHERE IdRuleta=@pIdRuleta;
	IF @vValidarRegistro=0
		BEGIN
			SET @oMensajeError='-1|El Id de la ruta no existe.';
			RAISERROR(@oMensajeError,16,1);
		END
	SELECT @vValidarEstado = Estado FROM [RULETA] WHERE IdRuleta=@pIdRuleta;
	IF @vValidarEstado='C'
		BEGIN
			SET @oMensajeError='-2|La ruleta se encuentra cerrada.';
			RAISERROR(@oMensajeError,16,1);
		END
	ELSE IF @vValidarEstado='R'
		BEGIN
			SET @oMensajeError='-3|La ruleta aun no está abierta.';
			RAISERROR(@oMensajeError,16,1);
		END
	SELECT @vValidarCreditoTotal = sum([NumCreditoApostado]) FROM [RULETA_PARTICIPANTES] WHERE IdRuleta=@pIdRuleta;
	IF @vValidarCreditoTotal>=10000
		BEGIN
			SET @oMensajeError='-4|La ruleta excedió del límite dinero permitido.';
			RAISERROR(@oMensajeError,16,1);
		END

	SELECT @vValidarParticipante = count(IdParticipante) FROM [PARTICIPANTES] WHERE IdParticipante=@pIdParticipante;
	IF @vValidarParticipante=0
		BEGIN
			SET @oMensajeError='-5|El participante no existe.';
			RAISERROR(@oMensajeError,16,1);
		END
	IF @pCreditoApostar=0
		BEGIN
			SET @oMensajeError='-6|El crédito debe ser mayor a 0.';
			RAISERROR(@oMensajeError,16,1);
		END
	IF @pValorApostar=''
		BEGIN
			SET @oMensajeError='-7|Debe ingresar un numero de 0 al 36 o ingresar el color Rojo o Negro.';
			RAISERROR(@oMensajeError,16,1);
		END
	ELSE
		IF ISNUMERIC(@pValorApostar)=1
			BEGIN
				DECLARE @vValorNumApos INT = cast(@pValorApostar as int);
				PRINT @vValorNumApos
				if @vValorNumApos<0 OR @vValorNumApos>36
					BEGIN
						SET @oMensajeError='-8|Debe ingresar un numero de 0 al 36';
						RAISERROR(@oMensajeError,16,1);
					END
					
			END
		ELSE
			BEGIN
				if upper(@pValorApostar)<>'ROJO' AND upper(@pValorApostar)<>'NEGRO'
					BEGIN
						SET @oMensajeError='-9|Debe ingresar el color Rojo o Negro.';
						RAISERROR(@oMensajeError,16,1);
					END
			END
		

		INSERT INTO [dbo].[RULETA_PARTICIPANTES]
						([IdRuleta]
						,[IdParticipante]
						,[NumCreditoApostado]
						,[ValorApostado]
						,[NumCreditoGanado]
						,[MotivoGanador]
						,[Estado]
						,[IdeUsuarioReg]
						,[IdeUsuarioAct]
						,[FecActualizado])
					VALUES
						(@pIdRuleta
						,@pIdParticipante
						,@pCreditoApostar
						,@pValorApostar
						,0
						,''
						,'R'
						,1
						,null
						,null)

    update [PARTICIPANTES] set NumCredito = NumCredito-@pCreditoApostar where IdParticipante=@pIdParticipante;

	SET @oMensajeError = '0|Registrado';

END TRY
BEGIN CATCH
DECLARE @ErrorMessage NVARCHAR(4000);
DECLARE @ErrorSeverity INT;
DECLARE @ErrorState INT;
DECLARE @codError NVARCHAR(255);
DECLARE @desError NVARCHAR(255);
DECLARE @pos INT;
SELECT 
@ErrorMessage = ERROR_MESSAGE(),
@ErrorSeverity = ERROR_SEVERITY(),
@ErrorState = ERROR_STATE();
SELECT @pos  = CHARINDEX('|', @ErrorMessage)  
SELECT @codError = SUBSTRING(@ErrorMessage, 1, @pos-1)
SELECT @desError = SUBSTRING(@ErrorMessage, @pos+1, len(@ErrorMessage)-1)
IF @pos>0
	BEGIN
		SELECT @oMensajeError = 'Error en el Proceso: '+ ERROR_PROCEDURE()+ ', Mensaje: '+@desError+', Error código: '+convert(varchar(20),@codError)
	END
ELSE
	BEGIN
		SELECT @oMensajeError = 'Error en el Procedimiento: '+ ERROR_PROCEDURE()+ ', Mensaje: '+@ErrorMessage+', En la linea: '+convert(varchar(20),ERROR_LINE())
	END
END CATCH;
END  
GO
/****** Object:  StoredProcedure [dbo].[usp_RuletaParticpante_Validar]    Script Date: 24/04/2021 14:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
DECLARE @mensaje VARCHAR(255);
exec usp_RuletaParticpante_Validar 4,0,@mensaje OUTPUT
SELECT @mensaje
*/
CREATE procedure [dbo].[usp_RuletaParticpante_Validar]
(
@pIdParticipante int,
@pCreditoApostar decimal(20,2),
@oMensajeError VARCHAR(255) OUTPUT
)
AS
/*************************************** 
*Descripcion: Validar credito del participante
*Fecha Creación: 24/04/2021
*Autor: Jorge Cardenas  
***************************************/
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @vValidarRegistro INT;
DECLARE @vValidarCredito decimal(20,2);
BEGIN TRY

	SELECT @vValidarRegistro = count(IdParticipante) FROM [PARTICIPANTES] WHERE IdParticipante=@pIdParticipante;
	IF @vValidarRegistro=0
		BEGIN
			SET @oMensajeError='-1|El participante no existe.';
			RAISERROR(@oMensajeError,16,1);
		END
	ELSE
		BEGIN
			SELECT @vValidarCredito = [NumCredito] FROM [PARTICIPANTES] WHERE IdParticipante=@pIdParticipante;
			IF @pCreditoApostar=0
				BEGIN
					SET @oMensajeError='-2|Su apuesta debe ser mayor a 0.';
					RAISERROR(@oMensajeError,16,1);
				END
			IF @vValidarCredito < @pCreditoApostar
				BEGIN
					SET @oMensajeError='-3|No cuenta con crédito para poder apostar.';
					RAISERROR(@oMensajeError,16,1);
				END
		END
	
	SET @oMensajeError = '0|Aprobado';

END TRY
BEGIN CATCH
DECLARE @ErrorMessage NVARCHAR(4000);
DECLARE @ErrorSeverity INT;
DECLARE @ErrorState INT;
DECLARE @codError NVARCHAR(255);
DECLARE @desError NVARCHAR(255);
DECLARE @pos INT;
SELECT 
@ErrorMessage = ERROR_MESSAGE(),
@ErrorSeverity = ERROR_SEVERITY(),
@ErrorState = ERROR_STATE();
SELECT @pos  = CHARINDEX('|', @ErrorMessage)  
SELECT @codError = SUBSTRING(@ErrorMessage, 1, @pos-1)
SELECT @desError = SUBSTRING(@ErrorMessage, @pos+1, len(@ErrorMessage)-1)
print @pos
IF @pos>0
	BEGIN
		SELECT @oMensajeError = 'Error en el Proceso: '+ ERROR_PROCEDURE()+ ', Mensaje: '+@desError+', Error código: '+convert(varchar(20),@pos)
	END
ELSE
	BEGIN
		SELECT @oMensajeError = 'Error en el Procedimiento: '+ ERROR_PROCEDURE()+ ', Mensaje: '+@ErrorMessage+', En la línea: '+convert(varchar(20),ERROR_LINE())
	END
END CATCH;
END  
GO
/****** Object:  StoredProcedure [dbo].[usp_RuletaPrincial_Abrir]    Script Date: 24/04/2021 14:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
DECLARE @mensaje VARCHAR(255);
exec usp_RuletaPrincial_RegistrarAbrir 2,1,@mensaje OUTPUT
SELECT @mensaje
*/
CREATE procedure [dbo].[usp_RuletaPrincial_Abrir]
(
@pIdRuleta int,
@oMensajeError VARCHAR(255) OUTPUT
)
AS
/*************************************** 
*Descripcion: Registrar y/o Abrir una ruleta
*Fecha Creación: 24/04/2021
*Autor: Jorge Cardenas  
***************************************/
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @vIdRuleta INT;
DECLARE @vEstado VARCHAR(30);
DECLARE @vValidarRegistro INT;
DECLARE @vValidarEstado CHAR(1);
BEGIN TRY

	SELECT @vValidarRegistro = count(IdRuleta) FROM [RULETA] WHERE IdRuleta=@pIdRuleta;
	IF @vValidarRegistro=0
		BEGIN
			SET @oMensajeError='-1|El Id de la ruta no existe.';
			RAISERROR(@oMensajeError,16,1);
		END
	ELSE
		BEGIN
			SELECT @vValidarEstado = Estado FROM [RULETA] WHERE IdRuleta=@pIdRuleta;
			IF @vValidarEstado='C'
			BEGIN
				SET @oMensajeError='-2|La ruleta se encuentra cerrada.';
				RAISERROR(@oMensajeError,16,1);
			END
			ELSE IF @vValidarEstado='A'
			BEGIN
				SET @oMensajeError='-3|La ruleta ya se encuentra abierta.';
				RAISERROR(@oMensajeError,16,1);
			END
		END
	set @vEstado ='Abierto';
	UPDATE [RULETA]
	SET  [Estado] = 'A'
		,[IdeUsuarioAct] = 1
		,[FecActualizado] = getdate()
	WHERE IdRuleta = @pIdRuleta
	SET @vIdRuleta= @pIdRuleta;
		
	
	SET @oMensajeError = 'OK|' + CAST(@vIdRuleta AS VARCHAR(50));

END TRY
BEGIN CATCH
DECLARE @ErrorMessage NVARCHAR(4000);
DECLARE @ErrorSeverity INT;
DECLARE @ErrorState INT;
DECLARE @codError NVARCHAR(255);
DECLARE @desError NVARCHAR(255);
DECLARE @pos INT;
SELECT 
@ErrorMessage = ERROR_MESSAGE(),
@ErrorSeverity = ERROR_SEVERITY(),
@ErrorState = ERROR_STATE();
SELECT @pos  = CHARINDEX('|', @ErrorMessage)  
SELECT @codError = SUBSTRING(@ErrorMessage, 1, @pos-1)
SELECT @desError = SUBSTRING(@ErrorMessage, @pos+1, len(@ErrorMessage)-1)
print @pos
IF @pos>0
	BEGIN
		SELECT @oMensajeError = 'Error en el Proceso: '+ ERROR_PROCEDURE()+ ', Mensaje: '+@desError+', Error código: '+convert(varchar(20),@codError)
	END
ELSE
	BEGIN
		SELECT @oMensajeError = 'Error en el Procedimiento: '+ ERROR_PROCEDURE()+ ', Mensaje: '+@ErrorMessage+', En la linea: '+convert(varchar(20),ERROR_LINE())
	END
END CATCH;
END  
GO
/****** Object:  StoredProcedure [dbo].[usp_RuletaPrincial_Cerrar]    Script Date: 24/04/2021 14:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

exec usp_RuletaPrincial_Cerrar 2,'4|ROJO'

*/
CREATE procedure [dbo].[usp_RuletaPrincial_Cerrar]
(
@pIdRuleta int,
@pValorGanador varchar(10)
)
AS
/*************************************** 
*Descripcion: Cerrar una ruleta
*Fecha Creación: 24/04/2021
*Autor: Jorge Cardenas  
***************************************/
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @vIdRuleta INT;
DECLARE @vEstado VARCHAR(30);
DECLARE @vValidarRegistro INT;
DECLARE @vValidarEstado CHAR(1);
DECLARE @oMensajeError VARCHAR(255);
BEGIN TRY
	
	SELECT @vValidarRegistro = count(IdRuleta) FROM [RULETA] WHERE IdRuleta=@pIdRuleta;
	IF @vValidarRegistro=0
		BEGIN
			SET @oMensajeError='-1|El Id de la ruta no existe.';
			RAISERROR(@oMensajeError,16,1);
		END
	SELECT @vValidarEstado = Estado FROM [RULETA] WHERE IdRuleta=@pIdRuleta;
	IF @vValidarEstado='C'
	BEGIN
		SET @oMensajeError='-2|La ruleta se encuentra cerrada.';
		RAISERROR(@oMensajeError,16,1);
	END
	ELSE IF @vValidarEstado='R'
	BEGIN
		SET @oMensajeError='-3|La ruleta aun no está abierta.';
		RAISERROR(@oMensajeError,16,1);
	END

	update [RULETA_PARTICIPANTES] set [Estado]='P', [MotivoGanador]='', [NumCreditoGanado]=[NumCreditoApostado] *-1 where IdRuleta=@pIdRuleta;
	
	DECLARE @valorNumGanador NVARCHAR(255);
	DECLARE @valorColorGanador NVARCHAR(255);
	DECLARE @posValor INT;
	
	SET @posValor  = CHARINDEX('|', @pValorGanador)  
	
	IF @posValor=0
		BEGIN
			SET @oMensajeError='-4|Información del ganador incorrecta.';
			RAISERROR(@oMensajeError,16,1);
		END
	
	SET @valorNumGanador = SUBSTRING(@pValorGanador, 1, @posValor-1)
	SET @valorColorGanador = SUBSTRING(@pValorGanador, @posValor+1, len(@pValorGanador)-1)
	
	DECLARE @vcuIdDetRuleta INT, @vcuIdParticipante INT, @vcuNumCreditoApostado DECIMAL(20,2), @vcuValorApostado VARCHAR(10)
	
	DECLARE ganador_cursor CURSOR FOR   
	SELECT [IdDetRuleta], [IdParticipante]
			,[NumCreditoApostado]
			,[ValorApostado]
	FROM [RULETA_PARTICIPANTES] WHERE IdRuleta=@pIdRuleta;
  
	OPEN ganador_cursor  
  
	FETCH NEXT FROM ganador_cursor   
	INTO @vcuIdDetRuleta, @vcuIdParticipante, @vcuNumCreditoApostado, @vcuValorApostado
  
	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		if @vcuValorApostado=@valorNumGanador
			begin
				update [RULETA_PARTICIPANTES] set [Estado]='G',[MotivoGanador]='Ganador por numero', [NumCreditoGanado]=@vcuNumCreditoApostado*5,[IdeUsuarioAct]=1, [FecActualizado]=GETDATE()  where IdDetRuleta=@vcuIdDetRuleta;
				update [PARTICIPANTES] set NumCredito = NumCredito+(@vcuNumCreditoApostado*5) where IdParticipante=@vcuIdParticipante;
			end
		if @vcuValorApostado=@valorColorGanador
			begin
				update [RULETA_PARTICIPANTES] set [Estado]='G',[MotivoGanador]='Ganador por color', [NumCreditoGanado]=@vcuNumCreditoApostado*1.80,[IdeUsuarioAct]=1, [FecActualizado]=GETDATE()  where IdDetRuleta=@vcuIdDetRuleta;
				update [PARTICIPANTES] set NumCredito = NumCredito+(@vcuNumCreditoApostado*1.80) where IdParticipante=@vcuIdParticipante;
			end
		FETCH NEXT FROM ganador_cursor   
		INTO @vcuIdDetRuleta, @vcuIdParticipante, @vcuNumCreditoApostado, @vcuValorApostado
	END   
	CLOSE ganador_cursor;  
	DEALLOCATE ganador_cursor;  
		
	SELECT rp.[IdParticipante]
		,(select p.NomParticipante from [PARTICIPANTES] p where p.IdParticipante=rp.IdParticipante) DesParticipante
      ,rp.[NumCreditoApostado]
      ,rp.[ValorApostado]
      ,rp.[NumCreditoGanado]
      ,rp.[MotivoGanador]
      ,rp.[Estado]
	  ,(select e.NomEstado from [ESTADOS] e where e.IdEstado=rp.Estado and e.Origen='RULETAPARTICIPANTE') DesNomEstado
  FROM [RULETA_PARTICIPANTES] rp
  where rp.IdRuleta=@pIdRuleta;

  update [RULETA] set [Estado]='C',[IdeUsuarioAct]=1, [FecActualizado]=GETDATE()  where IdRuleta=@pIdRuleta;

END TRY
BEGIN CATCH
DECLARE @ErrorMessage NVARCHAR(4000);
DECLARE @ErrorSeverity INT;
DECLARE @ErrorState INT;
DECLARE @codError NVARCHAR(255);
DECLARE @desError NVARCHAR(255);
DECLARE @pos INT;
SELECT 
@ErrorMessage = ERROR_MESSAGE(),
@ErrorSeverity = ERROR_SEVERITY(),
@ErrorState = ERROR_STATE();
SELECT @pos  = CHARINDEX('|', @ErrorMessage)  
SELECT @codError = SUBSTRING(@ErrorMessage, 1, @pos-1)
SELECT @desError = SUBSTRING(@ErrorMessage, @pos+1, len(@ErrorMessage)-1)

IF @pos>0
	BEGIN
		SELECT 'Error en el Proceso: '+ ERROR_PROCEDURE()+ ', Mensaje: '+@desError+', Error código: '+convert(varchar(20),@pos)
	END
ELSE
	BEGIN
		SELECT 'Error en el Procedimiento: '+ ERROR_PROCEDURE()+ ', Mensaje: '+@ErrorMessage+', En la linea: '+convert(varchar(20),ERROR_LINE())
	END
END CATCH;
END  
GO
/****** Object:  StoredProcedure [dbo].[usp_RuletaPrincial_Crear]    Script Date: 24/04/2021 14:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
DECLARE @mensaje VARCHAR(255);
exec usp_RuletaPrincial_RegistrarAbrir 2,1,@mensaje OUTPUT
SELECT @mensaje
*/
CREATE procedure [dbo].[usp_RuletaPrincial_Crear]
(
@oMensajeError VARCHAR(255) OUTPUT
)
AS
/*************************************** 
*Descripcion: Registrar y/o Abrir una ruleta
*Fecha Creación: 24/04/2021
*Autor: Jorge Cardenas  
***************************************/
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @vIdRuleta INT;
DECLARE @vEstado VARCHAR(30);
DECLARE @vValidarRegistro INT;
DECLARE @vValidarEstado CHAR(1);
BEGIN TRY

	set @vEstado ='Registrado';
	INSERT INTO [RULETA]
				([Estado]
				,[IdeUsuarioReg]
				,[IdeUsuarioAct]
				,[FecActualizado])
			VALUES
				('R'
				,1
				,null
				,null)
	SET @vIdRuleta= @@IDENTITY;
	
	SET @oMensajeError = 'OK|' + CAST(@vIdRuleta AS VARCHAR(50));
END TRY
BEGIN CATCH
DECLARE @ErrorMessage NVARCHAR(4000);
DECLARE @ErrorSeverity INT;
DECLARE @ErrorState INT;
DECLARE @codError NVARCHAR(255);
DECLARE @desError NVARCHAR(255);
DECLARE @pos INT;
SELECT 
@ErrorMessage = ERROR_MESSAGE(),
@ErrorSeverity = ERROR_SEVERITY(),
@ErrorState = ERROR_STATE();
SELECT @pos  = CHARINDEX('|', @ErrorMessage)  
SELECT @codError = SUBSTRING(@ErrorMessage, 1, @pos-1)
SELECT @desError = SUBSTRING(@ErrorMessage, @pos+1, len(@ErrorMessage)-1)
print @pos
IF @pos>0
	BEGIN
		SELECT @oMensajeError = 'Error en el Proceso: '+ ERROR_PROCEDURE()+ ', Mensaje: '+@desError+', Error código: '+convert(varchar(20),@codError)
	END
ELSE
	BEGIN
		SELECT @oMensajeError = 'Error en el Procedimiento: '+ ERROR_PROCEDURE()+ ', Mensaje: '+@ErrorMessage+', En la linea: '+convert(varchar(20),ERROR_LINE())
	END
END CATCH;
END  
GO
/****** Object:  StoredProcedure [dbo].[usp_RuletaPrincial_Listado]    Script Date: 24/04/2021 14:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

exec usp_RuletaPrincial_Listado 

*/
CREATE procedure [dbo].[usp_RuletaPrincial_Listado]

AS
/*************************************** 
*Descripcion: Listar ruleta
*Fecha Creación: 24/04/2021
*Autor: Jorge Cardenas  
***************************************/
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @vValidarRegistro INT;
DECLARE @oMensajeError VARCHAR(255);
BEGIN TRY
	
		
	SELECT r.[IdRuleta]
      ,r.[Estado]
	  ,(select e.NomEstado from [ESTADOS] e where e.IdEstado=r.Estado and e.Origen='RULETA') DesNomEstado
  FROM [RULETA] r

  

END TRY
BEGIN CATCH
DECLARE @ErrorMessage NVARCHAR(4000);
DECLARE @ErrorSeverity INT;
DECLARE @ErrorState INT;
DECLARE @codError NVARCHAR(255);
DECLARE @desError NVARCHAR(255);
DECLARE @pos INT;
SELECT 
@ErrorMessage = ERROR_MESSAGE(),
@ErrorSeverity = ERROR_SEVERITY(),
@ErrorState = ERROR_STATE();
SELECT @pos  = CHARINDEX('|', @ErrorMessage)  
SELECT @codError = SUBSTRING(@ErrorMessage, 1, @pos-1)
SELECT @desError = SUBSTRING(@ErrorMessage, @pos+1, len(@ErrorMessage)-1)

IF @pos>0
	BEGIN
		SELECT 'Error en el Proceso: '+ ERROR_PROCEDURE()+ ', Mensaje: '+@desError+', Error código: '+convert(varchar(20),@pos)
	END
ELSE
	BEGIN
		SELECT 'Error en el Procedimiento: '+ ERROR_PROCEDURE()+ ', Mensaje: '+@ErrorMessage+', En la linea: '+convert(varchar(20),ERROR_LINE())
	END
END CATCH;
END  
GO
USE [master]
GO
ALTER DATABASE [Juego] SET  READ_WRITE 
GO
	