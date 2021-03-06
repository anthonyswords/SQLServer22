USE [master]
GO
/****** Object:  Database [ToniFutbol2]    Script Date: 09/06/2022 10:50:40 ******/
CREATE DATABASE [ToniFutbol2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ToniFutbol2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ToniFutbol2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ToniFutbol2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ToniFutbol2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ToniFutbol2] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ToniFutbol2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ToniFutbol2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ToniFutbol2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ToniFutbol2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ToniFutbol2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ToniFutbol2] SET ARITHABORT OFF 
GO
ALTER DATABASE [ToniFutbol2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ToniFutbol2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ToniFutbol2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ToniFutbol2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ToniFutbol2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ToniFutbol2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ToniFutbol2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ToniFutbol2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ToniFutbol2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ToniFutbol2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ToniFutbol2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ToniFutbol2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ToniFutbol2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ToniFutbol2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ToniFutbol2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ToniFutbol2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ToniFutbol2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ToniFutbol2] SET RECOVERY FULL 
GO
ALTER DATABASE [ToniFutbol2] SET  MULTI_USER 
GO
ALTER DATABASE [ToniFutbol2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ToniFutbol2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ToniFutbol2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ToniFutbol2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ToniFutbol2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ToniFutbol2] SET QUERY_STORE = OFF
GO
USE [ToniFutbol2]
GO
/****** Object:  User [Toni]    Script Date: 09/06/2022 10:50:41 ******/
CREATE USER [Toni] FOR LOGIN [Toni] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Toni]
GO
/****** Object:  Table [dbo].[Arbitro]    Script Date: 09/06/2022 10:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Arbitro](
	[Apellidos] [varchar](50) NULL,
	[Nombres] [varchar](50) NULL,
	[Funcion] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Arbitros]    Script Date: 09/06/2022 10:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Arbitros](
	[IdArbitros] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[NumeroDeArbitro] [varchar](12) NULL,
	[Tipo] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdArbitros] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipo]    Script Date: 09/06/2022 10:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipo](
	[Nombre] [varchar](50) NULL,
	[Estadio] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IncidenciaJugador]    Script Date: 09/06/2022 10:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncidenciaJugador](
	[IdIncidenciaJugador] [int] IDENTITY(1,1) NOT NULL,
	[NumTotalGoles] [int] NOT NULL,
	[NumTotalDeAmarillas] [int] NOT NULL,
	[NumTotalDeRojas] [int] NOT NULL,
	[NumTotalFaltas] [int] NOT NULL,
	[RidJugador] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdIncidenciaJugador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IncidenciaPartido]    Script Date: 09/06/2022 10:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncidenciaPartido](
	[IdIncidenciaPartido] [int] IDENTITY(1,1) NOT NULL,
	[Resultado] [int] NOT NULL,
	[Goles] [varchar](20) NOT NULL,
	[Tarjetas] [varchar](20) NOT NULL,
	[lesiones] [varchar](20) NOT NULL,
	[Faltas] [varchar](20) NULL,
	[RidPartido] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdIncidenciaPartido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jugador]    Script Date: 09/06/2022 10:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jugador](
	[IdJugador] [int] NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Edad] [varchar](50) NULL,
	[Nacionalidad] [varchar](50) NULL,
	[Overall] [varchar](50) NULL,
	[Potential] [varchar](50) NULL,
	[Position] [varchar](50) NULL,
	[RidEquipo] [nchar](10) NULL,
 CONSTRAINT [PK_Espanya] PRIMARY KEY CLUSTERED 
(
	[IdJugador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partido]    Script Date: 09/06/2022 10:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partido](
	[IdPartido] [int] IDENTITY(1,1) NOT NULL,
	[Jornada] [nchar](2) NOT NULL,
	[Fecha] [date] NOT NULL,
	[RidArbitroPrincipal] [int] NOT NULL,
	[RidArbitroAsistente1] [int] NOT NULL,
	[RidArbitroAsistente2] [int] NOT NULL,
	[RidArbitroAsistente4] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPartido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'ALBEROLA ROJAS', N'Javier', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'CORDERO VEGA  ', N'Adrian', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'CUADRA FERNANDEZ', N'Guillermo', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'DE BURGOS BENGOETXEA ', N'Ricardo', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'DEL CERRO GRANDE', N'Carlos', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'DIAZ DE MERA ESCUDEROS', N'Isidro', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'FIGUEROA VAZQUEZ', N'Jorge', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GIL MANZANO', N'Jesus', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GONZALEZ FUERTES', N'Pablo', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'HERNANDEZ HERNANDEZ', N'Alejandro', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'JAIME LATRE', N'Santiago', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'MARTINEZ MUNUERA', N'Juan', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'MATEU LAHOZ', N'Antonio Miguel', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'MELERO LOPEZ', N'Mario', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'MUNUERA MONTERO', N'Jose Luis', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'MUNIZ RUIZ', N'Alejandro', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'ORTIZ ARIAS', N'Miguel Angel', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'PIZARRO GOMEZ', N'Valentin', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'SANCHEZ MARTINEZ', N'Jose Maria', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'SOTO GRADO', N'Cesar', N'Principal')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'ARENCIBIA MEDINA', N'Francisco Jose', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'BERNAL MARTIN', N'David', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'BLANCO RODRIGUEZ', N'Fabian', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'BLAZQUEZ SANCHEZ', N'Rodrigo', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'BORDOY HOMAR', N'Josep ', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'CAMPO HERNANDEZ', N'Ruben', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'DIAZ GONZALEZ', N'Adrian', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'ESCUELA MELO', N'Jose Carlos ', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'ESTELA BRAVO', N'Fernando', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'FERNANDEZ GONZALEZ', N'Eliana', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GARCIA AGUILERA', N'Samuel', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GARCIA ANDREU', N'Christian ', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GARCIA LORENZO', N'Javier', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GARCIA LOZANO', N'Jose Francisco', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GARCIA SABUCO', N'Francisco Javier', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GARCIA URBANEJA', N'Unai ', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GARRIDO CONCHA', N'Javier', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GONZALEZ NARVAEZ', N'Alvaro', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GRANEL PEIRO', N'Alvaro', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'JARA CORDOBES', N'Victor', N'Asistente')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'AIS REIG', N'Saul', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'ARCEDIANO MONESCILLO', N'Damasco', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'AVALOS BARRERA', N'Ruben', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'CAPARROS HERNANDEZ', N'Ivan', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'DE LA FUENTE RAMOS', N'Oliver', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GALECH APEZTEGUIA', N'Iosu', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GALVEZ RASCON', N'David', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GARCIA VERDURA', N'Victor', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GONZALEZ ESTEBAN', N'Jon Ander', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GONZALEZ FRANCES', N'Raul Martin', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'GOROSTEGUI FERNANDEZ ORTEGA', N'Aitor', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'HERNANDEZ MAESO', N'Francisco', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'IGLESIAS VILLANUEVA', N'Javier', N'Cuarto')
INSERT [dbo].[Arbitro] ([Apellidos], [Nombres], [Funcion]) VALUES (N'LOPEZ TOCA', N'Jose Antonio', N'Cuarto')
GO
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Deportivo Alaves', N'Mendizorroza')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Athletic Club de Bilbao', N'San Mames')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Atletico Madrid', N'Estadio Metropolitano')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'FC Barcelona', N'Camp Nou')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Real Betis', N'Benito Villamarin')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Cadiz CF', N'Ramon de Carranza')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'RC Celta', N'Abanca-Balaidos')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Elche CF', N'Martinez Valero')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'RCD Espanyol', N'RCDE Stadium')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Getafe CF', N'Coliseum Alfonso Perez')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Granada CF', N'Nuevo Estadio de Los Carmenes')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Levante UD', N'Ciutat de Valencia')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'RCD Mallorca', N'Son Moix')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'CA Osasuna', N'El Sadar')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Rayo Vallecano', N'Estadio de Vallecas')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Real Madrid ', N'Santiago Bernabeu')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Real Sociedad ', N'Reale Arena')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Sevilla FC', N'Ramon Sanchez-Pizjuan')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Valencia CF', N'Mestalla')
INSERT [dbo].[Equipo] ([Nombre], [Estadio]) VALUES (N'Villarreal CF', N'Estadio de la Ceramica')
GO
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (45186, N'Joaquin', N'36', N'Spain', N'81', N'81', N'LS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (45595, N'D. Bonera', N'37', N'Italy', N'75', N'75', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (106231, N'Aduriz', N'37', N'Spain', N'82', N'82', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (110019, N'Dorado', N'35', N'Spain', N'71', N'71', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (110638, N'Cifuentes', N'39', N'Spain', N'73', N'73', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (110677, N'Moya', N'34', N'Spain', N'80', N'80', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (110680, N'Xisco Campos', N'36', N'Spain', N'66', N'66', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (110787, N'Borja Fernandez', N'37', N'Spain', N'70', N'70', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (113524, N'Nino', N'38', N'Spain', N'70', N'70', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (135697, N'Sergio Garcia', N'35', N'Spain', N'77', N'77', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (139597, N'Javi Guerra', N'36', N'Spain', N'70', N'70', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (142959, N'M. Barbosa', N'33', N'Argentina', N'76', N'76', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (145889, N'Tito', N'32', N'Spain', N'72', N'72', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (146111, N'Mikel Rico', N'33', N'Spain', N'75', N'75', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (146296, N'Andres Fernandez', N'31', N'Spain', N'76', N'76', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (146460, N'Javi Fuego', N'34', N'Spain', N'77', N'77', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (146536, N'Jesus Navas', N'32', N'Spain', N'80', N'80', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (146562, N'Santi Cazorla', N'33', N'Spain', N'80', N'80', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (146636, N'Jose Juan', N'39', N'Spain', N'68', N'68', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (146748, N'Diego Lopez', N'36', N'Spain', N'80', N'80', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (146760, N'Juanfran', N'33', N'Spain', N'80', N'80', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (146974, N'Miguel FlaÃ±o', N'33', N'Spain', N'67', N'67', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (146996, N'Ruben', N'34', N'Spain', N'68', N'68', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (152729, N'Pique', N'31', N'Spain', N'87', N'87', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (153164, N'A. Faurlin', N'31', N'Argentina', N'70', N'70', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (154472, N'Jorge Molina', N'36', N'Spain', N'77', N'77', N'RS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (155862, N'Sergio Ramos', N'32', N'Spain', N'91', N'91', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (155984, N'Markel Bergara', N'32', N'Spain', N'77', N'77', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (157168, N'Manu', N'34', N'Switzerland', N'66', N'66', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (157304, N'T. Vermaelen', N'32', N'Belgium', N'77', N'77', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (157479, N'Pedro Lopez', N'34', N'Spain', N'71', N'71', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (158023, N'L. Messi', N'31', N'Argentina', N'94', N'94', N'RF', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (158144, N'Salva Sevilla', N'34', N'Spain', N'72', N'72', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (161754, N'Javi Garcia', N'31', N'Spain', N'78', N'78', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (163806, N'Sergio', N'31', N'Spain', N'78', N'78', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (164169, N'Filipe Luis', N'32', N'Brazil', N'85', N'85', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (164471, N'Xisco', N'32', N'Spain', N'71', N'71', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (165153, N'K. Benzema', N'30', N'France', N'85', N'85', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (165536, N'G. Cabral', N'32', N'Argentina', N'76', N'76', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (166074, N'Bebe', N'27', N'Portugal', N'74', N'74', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (168651, N'I. Rakitic', N'30', N'Croatia', N'87', N'87', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (169426, N'Barragan', N'31', N'Spain', N'76', N'76', N'RWB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (170481, N'E. Garay', N'31', N'Argentina', N'82', N'82', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (170569, N'David Rodriguez', N'32', N'Spain', N'69', N'69', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (170941, N'Javi Moyano', N'32', N'Spain', N'71', N'71', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (171402, N'Javi Flores', N'32', N'Spain', N'67', N'67', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (171579, N'Raul Garcia', N'31', N'Spain', N'80', N'80', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (171897, N'A. Guardado', N'31', N'Mexico', N'82', N'82', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (172285, N'Elustondo', N'31', N'Spain', N'72', N'72', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (172287, N'Manu Garcia', N'32', N'Spain', N'78', N'78', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (172290, N'D. Zurutuza', N'31', N'France', N'76', N'76', N'LDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (172411, N'Servando', N'34', N'Spain', N'69', N'69', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (172522, N'D. Wass', N'29', N'Denmark', N'81', N'81', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (173030, N'O. Trejo', N'30', N'Argentina', N'77', N'77', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (173178, N'Manolo Reina', N'33', N'Spain', N'68', N'68', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (173731, N'G. Bale', N'28', N'Wales', N'88', N'88', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (174859, N'Fran Rico', N'30', N'Spain', N'75', N'75', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (176580, N'L. Suarez', N'31', N'Uruguay', N'91', N'91', N'RS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (176600, N'K. Gameiro', N'31', N'France', N'80', N'80', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (176619, N'A. Ramos', N'32', N'Colombia', N'73', N'73', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (176676, N'Marcelo', N'30', N'Brazil', N'88', N'88', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (176903, N'M. Iturra', N'34', N'Chile', N'73', N'73', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (177003, N'L. Modric', N'32', N'Croatia', N'91', N'91', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (177600, N'BeÃ±at', N'31', N'Spain', N'80', N'80', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (177633, N'Angel', N'31', N'Spain', N'79', N'79', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (177644, N'Kiko Casilla', N'31', N'Spain', N'79', N'79', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (178085, N'Granero', N'30', N'Spain', N'78', N'78', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (178086, N'Adan', N'31', N'Spain', N'83', N'83', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (178171, N'Sergio Sanchez', N'32', N'Spain', N'72', N'72', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (178322, N'M. Layun', N'30', N'Mexico', N'77', N'77', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (178424, N'Antunes', N'31', N'Portugal', N'80', N'80', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (178562, N'E. Banega', N'30', N'Argentina', N'84', N'84', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (178750, N'Sergio Asenjo', N'29', N'Spain', N'84', N'85', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (179528, N'Xavi Torres', N'31', N'Spain', N'71', N'71', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (179645, N'S. KjÃ¦r', N'29', N'Denmark', N'81', N'81', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (179844, N'Diego Costa', N'29', N'Spain', N'85', N'85', N'LS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (181872, N'A. Vidal', N'31', N'Chile', N'85', N'85', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (182002, N'Sidnei', N'28', N'Brazil', N'79', N'80', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (182493, N'D. Godin', N'32', N'Uruguay', N'90', N'90', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (182521, N'T. Kroos', N'28', N'Germany', N'90', N'90', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (182896, N'R. Rosales', N'29', N'Venezuela', N'74', N'74', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (183141, N'Oier', N'28', N'Spain', N'75', N'75', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (183353, N'Victor Diaz', N'30', N'Spain', N'71', N'71', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (183512, N'Yuri Berchiche', N'28', N'Spain', N'77', N'77', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (183520, N'Fran Merida', N'28', N'Spain', N'72', N'73', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (183666, N'Roberto', N'32', N'Spain', N'77', N'77', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (183892, N'G. Mercado', N'31', N'Argentina', N'79', N'79', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (183966, N'F. Roncaglia', N'31', N'Argentina', N'75', N'75', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (184120, N'Bruno', N'34', N'Spain', N'80', N'80', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (184990, N'AntoÃ±ito', N'30', N'Spain', N'71', N'71', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (185132, N'Mikel San Jose', N'29', N'Spain', N'77', N'77', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (185181, N'Yoel', N'29', N'Spain', N'76', N'76', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (185431, N'N. Kalinic', N'30', N'Croatia', N'79', N'79', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (186197, N'G. Kakuta', N'27', N'DR Congo', N'76', N'76', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (186681, N'Alberto', N'33', N'Spain', N'74', N'74', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (186682, N'Montoro', N'30', N'Spain', N'70', N'70', N'LDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (186684, N'Kiko Olivas', N'29', N'Spain', N'72', N'72', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (188103, N'Rochina', N'27', N'Spain', N'75', N'75', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (188337, N'M. Wakaso', N'27', N'Ghana', N'75', N'75', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (188388, N'R. Boudebouz', N'28', N'Algeria', N'80', N'80', N'CAM', NULL)
GO
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (189156, N'Daniel CarriÃ§o', N'29', N'Portugal', N'78', N'78', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (189242, N'Coutinho', N'26', N'Brazil', N'88', N'89', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (189271, N'F. Coquelin', N'27', N'France', N'79', N'80', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (189332, N'Jordi Alba', N'29', N'Spain', N'87', N'87', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (189354, N'Susaeta', N'30', N'Spain', N'80', N'80', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (189472, N'Aridane', N'29', N'Spain', N'70', N'71', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (189506, N'Victor Sanchez', N'30', N'Spain', N'77', N'77', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (189511, N'Sergio Busquets', N'29', N'Spain', N'89', N'89', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (189513, N'Parejo', N'29', N'Spain', N'85', N'85', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (189536, N'D. ÄŒop', N'28', N'Croatia', N'72', N'72', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (189553, N'Lillo', N'29', N'Spain', N'68', N'68', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (189575, N'Muniain', N'25', N'Spain', N'80', N'83', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (190149, N'De Marcos', N'29', N'Spain', N'79', N'79', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (190176, N'Marc Pedraza', N'31', N'Spain', N'68', N'68', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (190223, N'Balenziaga', N'30', N'Spain', N'75', N'75', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (190286, N'Canales', N'27', N'Spain', N'80', N'80', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (190432, N'Oier', N'32', N'Spain', N'71', N'71', N'RDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (190535, N'Michel', N'29', N'Spain', N'74', N'74', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (190584, N'Illarramendi', N'28', N'Spain', N'84', N'84', N'RDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (190982, N'Alberto Perea', N'27', N'Spain', N'68', N'68', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (191055, N'Didac VilÃ ', N'29', N'Spain', N'74', N'74', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (191135, N'L. Wakalible', N'27', N'Ivory Coast', N'68', N'68', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (191628, N'L. Chichizola', N'28', N'Argentina', N'77', N'78', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (192041, N'N. Araujo', N'26', N'Mexico', N'75', N'78', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (192119, N'T. Courtois', N'26', N'Belgium', N'89', N'90', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (192448, N'M. ter Stegen', N'26', N'Germany', N'89', N'92', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (192490, N'Juan Villar', N'30', N'Spain', N'73', N'73', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (192629, N'Iago Aspas', N'30', N'Spain', N'84', N'84', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (192674, N'Leandro', N'29', N'Spain', N'61', N'63', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (192679, N'Escudero', N'28', N'Spain', N'79', N'79', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (192789, N'Mario Gaspar', N'27', N'Spain', N'80', N'80', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (192816, N'L. Cabrera', N'26', N'Uruguay', N'72', N'75', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (193041, N'K. Navas', N'31', N'Costa Rica', N'87', N'87', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (193116, N'M. Gonalons', N'29', N'France', N'75', N'75', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (193171, N'Jaume Costa', N'30', N'Spain', N'79', N'79', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (193314, N'Aitor', N'27', N'Spain', N'72', N'75', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (193469, N'Victor Ruiz', N'29', N'Spain', N'82', N'83', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (193747, N'Koke', N'26', N'Spain', N'85', N'86', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (193757, N'Edu Ramos', N'26', N'Spain', N'69', N'73', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (193794, N'Villalibre', N'20', N'Spain', N'68', N'77', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (193844, N'Portillo', N'28', N'Spain', N'75', N'75', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (193887, N'H. Perez', N'29', N'Paraguay', N'77', N'77', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (194174, N'Keko', N'26', N'Spain', N'75', N'76', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (194222, N'Laguardia', N'28', N'Spain', N'77', N'78', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (194229, N'Hugo Mallo', N'27', N'Spain', N'80', N'81', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (194404, N'Neto', N'28', N'Brazil', N'83', N'84', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (194765, N'A. Griezmann', N'27', N'France', N'89', N'90', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (194996, N'Borja Baston', N'25', N'Spain', N'75', N'78', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (195093, N'Willian Jose', N'26', N'Brazil', N'82', N'83', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (195361, N'Javi Lopez', N'32', N'Spain', N'75', N'75', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (195668, N'Joel Robles', N'28', N'Spain', N'75', N'76', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (195698, N'C. Doukoure', N'25', N'Ivory Coast', N'73', N'78', N'RDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (196935, N'Ignasi Miquel', N'25', N'Spain', N'73', N'77', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (196942, N'IÃ±igo Perez', N'30', N'Spain', N'74', N'74', N'LDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (197681, N'G. Imbula', N'25', N'France', N'74', N'77', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (197781, N'Isco', N'26', N'Spain', N'88', N'91', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (197891, N'Juanmi', N'25', N'Spain', N'76', N'79', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (198023, N'Ximo Navarro', N'28', N'Spain', N'75', N'75', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (198141, N'Bartra', N'27', N'Spain', N'82', N'83', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (198198, N'Jordi Amat', N'26', N'Spain', N'76', N'80', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (198230, N'German', N'31', N'Spain', N'69', N'69', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (198329, N'Rodrigo', N'27', N'Spain', N'83', N'84', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (198368, N'Tomas Pina', N'30', N'Spain', N'77', N'77', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (198451, N'Dani Rodriguez', N'30', N'Spain', N'67', N'67', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (198614, N'Raul Navas', N'30', N'Spain', N'76', N'76', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (198631, N'Rodri', N'28', N'Spain', N'70', N'70', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (198715, N'Sergio Leon', N'29', N'Spain', N'79', N'79', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (198950, N'Pablo Sarabia', N'26', N'Spain', N'82', N'83', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199110, N'L. Muriel', N'27', N'Colombia', N'80', N'81', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199152, N'D. Lekic', N'33', N'Serbia', N'71', N'71', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199157, N'Luna', N'27', N'Spain', N'74', N'75', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199247, N'Alex Fernandez', N'25', N'Spain', N'72', N'77', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199416, N'Ibai Gomez', N'28', N'Spain', N'79', N'79', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199451, N'W. Ben Yedder', N'27', N'France', N'82', N'82', N'RS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199487, N'Galvez', N'29', N'Spain', N'75', N'76', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199561, N'Nolito', N'31', N'Spain', N'79', N'79', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199564, N'Sergi Roberto', N'26', N'Spain', N'83', N'86', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199575, N'Jordi Masip', N'29', N'Spain', N'77', N'77', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199577, N'Sergi Gomez', N'26', N'Spain', N'78', N'83', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199578, N'Benja', N'30', N'Spain', N'66', N'66', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199598, N'Jony Ã‘iguez', N'33', N'Spain', N'66', N'66', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199602, N'J. Guidetti', N'26', N'Sweden', N'78', N'81', N'LS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199638, N'Provencio', N'30', N'Spain', N'67', N'67', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199667, N'R. Funes Mori', N'27', N'Argentina', N'77', N'78', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199700, N'Aridai', N'29', N'Spain', N'66', N'66', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199715, N'Vitolo', N'28', N'Spain', N'81', N'81', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199823, N'CampaÃ±a', N'25', N'Spain', N'79', N'82', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (199987, N'J. Cillessen', N'29', N'Netherlands', N'82', N'84', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (200145, N'Casemiro', N'26', N'Brazil', N'88', N'90', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (200228, N'Bruno', N'28', N'Spain', N'77', N'78', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (200315, N'Cristian Tello', N'26', N'Spain', N'80', N'80', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (200389, N'J. Oblak', N'25', N'Slovenia', N'90', N'93', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (200724, N'Nacho Fernandez', N'28', N'Spain', N'83', N'85', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (201143, N'A. Mandi', N'26', N'Algeria', N'79', N'82', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (201305, N'Gabriel Paulista', N'27', N'Brazil', N'82', N'83', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (201377, N'J. Murillo', N'26', N'Colombia', N'80', N'84', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (201379, N'Samu Garcia', N'28', N'Spain', N'71', N'71', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (201400, N'Rafinha', N'25', N'Brazil', N'82', N'87', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (201455, N'G. Kondogbia', N'25', N'Central African Rep.', N'82', N'85', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (201505, N'David Lopez', N'28', N'Spain', N'79', N'79', N'RCB', NULL)
GO
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (201535, N'R. Varane', N'25', N'France', N'86', N'91', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (201858, N'N. Sansone', N'26', N'Italy', N'76', N'77', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (201939, N'C. Piccini', N'25', N'Italy', N'77', N'80', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (202054, N'Naldo', N'29', N'Brazil', N'75', N'75', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (202445, N'Rodrigo Ely', N'24', N'Brazil', N'76', N'80', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (202493, N'Aleix Vidal', N'28', N'Spain', N'77', N'77', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (202501, N'David JuncÃ ', N'24', N'Spain', N'76', N'81', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (202611, N'Manuel Sanchez', N'30', N'Spain', N'66', N'66', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (202646, N'Alex Martinez', N'27', N'Spain', N'71', N'71', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (202648, N'Sergi Darder', N'24', N'Spain', N'79', N'83', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (202716, N'Abdon', N'25', N'Spain', N'66', N'71', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (202935, N'Alvaro', N'28', N'Spain', N'78', N'79', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (203177, N'D. Foulquier', N'25', N'France', N'71', N'76', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (203528, N'A. Bangoura', N'26', N'Guinea', N'68', N'69', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (203843, N'D. Suarez', N'30', N'Uruguay', N'77', N'77', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204041, N'Bonilla', N'27', N'Spain', N'63', N'63', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204120, N'T. Vaclik', N'29', N'Czech Republic', N'80', N'81', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204259, N'S. Arias', N'26', N'Colombia', N'78', N'81', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204277, N'Roque Mesa', N'29', N'Spain', N'79', N'79', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204346, N'Fede Vico', N'23', N'Spain', N'70', N'76', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204523, N'Ruben Pardo', N'25', N'Spain', N'75', N'78', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204525, N'IÃ±igo Martinez', N'27', N'Spain', N'79', N'80', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204529, N'M. Batshuayi', N'24', N'Belgium', N'80', N'84', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204539, N'L. Advincula', N'28', N'Peru', N'74', N'74', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204639, N'S. Savic', N'27', N'Montenegro', N'83', N'86', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204737, N'Salvador Agra', N'26', N'Portugal', N'70', N'70', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204757, N'ToÃ±o Garcia', N'28', N'Spain', N'76', N'76', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204826, N'A. Ba', N'27', N'Senegal', N'73', N'75', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204830, N'Vadillo', N'23', N'Spain', N'71', N'77', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204863, N'Ivan Sanchez', N'25', N'Spain', N'69', N'70', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204876, N'Clerc', N'26', N'Spain', N'70', N'73', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (204963, N'Carvajal', N'26', N'Spain', N'84', N'87', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (205114, N'T. Inui', N'30', N'Japan', N'80', N'80', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (205192, N'Denis Suarez', N'24', N'Spain', N'79', N'86', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (205201, N'O. YokuÅŸlu', N'24', N'Turkey', N'77', N'83', N'LDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (205600, N'S. Umtiti', N'24', N'France', N'87', N'92', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (205676, N'Tekio', N'27', N'Spain', N'67', N'67', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (205705, N'Z. Feddal', N'28', N'Morocco', N'80', N'80', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (205976, N'Leo Baptistao', N'25', N'Brazil', N'78', N'79', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (206167, N'S. Prcic', N'24', N'Bosnia Herzegovina', N'74', N'78', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (206219, N'Juan Cruz', N'25', N'Spain', N'66', N'67', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (206225, N'D. Cheryshev', N'27', N'Russia', N'77', N'77', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (206545, N'Manu Trigueros', N'26', N'Spain', N'83', N'84', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (206651, N'Roberto Torres', N'29', N'Spain', N'72', N'72', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (207471, N'F. Vazquez', N'29', N'Argentina', N'82', N'82', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (207566, N'William Carvalho', N'26', N'Portugal', N'84', N'86', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (207664, N'C. Bacca', N'31', N'Colombia', N'81', N'81', N'LS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (207732, N'Roger', N'27', N'Spain', N'79', N'80', N'RS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (207876, N'A. Gonzalez', N'25', N'Venezuela', N'70', N'72', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (208088, N'Sergi Samper', N'23', N'Spain', N'73', N'80', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (208093, N'Gerard Moreno', N'26', N'Spain', N'83', N'85', N'LS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (208330, N'A. Januzaj', N'23', N'Belgium', N'78', N'84', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (208421, N'Saul', N'23', N'Spain', N'85', N'90', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (208618, N'Lucas Vazquez', N'27', N'Spain', N'83', N'83', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (208621, N'Oscar Plano', N'27', N'Spain', N'74', N'74', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (208622, N'Ruben Sobrino', N'26', N'Spain', N'76', N'78', N'RS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (208638, N'Rober Correa', N'25', N'Spain', N'66', N'69', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (208808, N'Q. Promes', N'26', N'Netherlands', N'83', N'84', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (209289, N'Kevin Rodrigues', N'24', N'Portugal', N'74', N'79', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (209937, N'Quini', N'28', N'Spain', N'67', N'67', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (209960, N'Pacheco', N'26', N'Spain', N'80', N'83', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (209989, N'T. Partey', N'25', N'Ghana', N'82', N'88', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (210214, N'Jozabed', N'27', N'Spain', N'75', N'76', N'LDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (210315, N'De Tomas', N'23', N'Spain', N'76', N'83', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (210385, N'Rui Silva', N'24', N'Portugal', N'69', N'75', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (210747, N'Salva Ruiz', N'23', N'Spain', N'65', N'70', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (210868, N'Jose Mari', N'30', N'Spain', N'69', N'69', N'LDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (211022, N'Ruben Garcia', N'24', N'Spain', N'72', N'77', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (211057, N'Pablo Valcarce', N'25', N'Spain', N'69', N'72', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (211101, N'Ruben Blanco', N'22', N'Spain', N'76', N'83', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (211348, N'S. Dimitrievski', N'24', N'FYR Macedonia', N'71', N'77', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (211381, N'S. Boufal', N'24', N'Morocco', N'77', N'80', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (211382, N'I. Amadou', N'25', N'France', N'75', N'80', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (211688, N'GayÃ ', N'23', N'Spain', N'80', N'85', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (212012, N'Borja', N'24', N'Spain', N'63', N'69', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (212183, N'Nacho', N'29', N'Spain', N'74', N'74', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (212196, N'P. Sisto', N'23', N'Denmark', N'78', N'84', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (212261, N'Brandon Thomas', N'23', N'Spain', N'72', N'79', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (212405, N'Alberto Martin', N'29', N'Spain', N'70', N'70', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (212476, N'Medran', N'24', N'Spain', N'75', N'81', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (212602, N'Diego Llorente', N'24', N'Spain', N'77', N'83', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (212623, N'Santi Mina', N'22', N'Spain', N'80', N'85', N'LS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (212772, N'O. Duarte', N'29', N'Costa Rica', N'75', N'75', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (213063, N'Rober', N'23', N'Spain', N'74', N'82', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (213565, N'T. Lemar', N'22', N'France', N'83', N'89', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (213577, N'Puertas', N'26', N'Spain', N'67', N'68', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (213709, N'Isi', N'22', N'Spain', N'63', N'72', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (213745, N'Robert Costa', N'24', N'Spain', N'63', N'72', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (213937, N'Aketxe', N'24', N'Spain', N'72', N'78', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (214332, N'D. Torres', N'28', N'Colombia', N'77', N'77', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (214639, N'Postigo', N'29', N'Spain', N'75', N'75', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (214997, N'A. Correa', N'23', N'Argentina', N'81', N'87', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (215060, N'N. Aguirre', N'27', N'Argentina', N'72', N'72', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (215316, N'G. Rulli', N'26', N'Argentina', N'80', N'85', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (215399, N'Ruben Vezo', N'24', N'Portugal', N'77', N'83', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (215477, N'I. Kecojevic', N'30', N'Montenegro', N'67', N'67', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (215569, N'Unai Garcia', N'25', N'Spain', N'68', N'73', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (215616, N'Jason', N'23', N'Spain', N'75', N'81', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (215644, N'Burgui', N'24', N'Spain', N'75', N'78', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (215725, N'Quinti', N'21', N'Spain', N'62', N'69', N'LB', NULL)
GO
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (216189, N'Capa', N'26', N'Spain', N'78', N'81', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (216194, N'Dani Garcia', N'28', N'Spain', N'82', N'83', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (216201, N'Williams', N'24', N'Spain', N'81', N'87', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (216237, N'K. Azamoum', N'28', N'France', N'67', N'67', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (216435, N'S. Lobotka', N'23', N'Slovakia', N'78', N'84', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (216447, N'Alvaro Garcia', N'25', N'Spain', N'74', N'75', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (216460, N'J. Gimenez', N'23', N'Uruguay', N'84', N'88', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (216475, N'Morales', N'30', N'Spain', N'81', N'81', N'LS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (216479, N'A. Sadiku', N'27', N'Albania', N'69', N'70', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (216568, N'Mario Barco', N'25', N'Spain', N'68', N'73', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (216820, N'M. Simon', N'22', N'Nigeria', N'76', N'82', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (217036, N'Alex Moreno', N'25', N'Spain', N'74', N'79', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (217731, N'Sandro', N'22', N'Spain', N'75', N'81', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (217845, N'A. Hjulsager', N'23', N'Denmark', N'69', N'78', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (217940, N'D. Djene', N'26', N'Togo', N'78', N'79', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (218746, N'Pozo', N'22', N'Spain', N'74', N'81', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (219145, N'G. Maripan', N'24', N'Chile', N'75', N'79', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (219455, N'J. Calleri', N'24', N'Argentina', N'77', N'82', N'LS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (219585, N'M. Valjent', N'22', N'Slovakia', N'64', N'70', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (219652, N'Rober IbaÃ±ez', N'25', N'Spain', N'72', N'75', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (219688, N'M. Lopez', N'27', N'Argentina', N'67', N'70', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (219712, N'S. Cristoforo', N'24', N'Uruguay', N'75', N'79', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (219777, N'Chema Rodriguez', N'26', N'Spain', N'75', N'78', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (219836, N'Ruben YaÃ±ez', N'24', N'Spain', N'67', N'72', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (219848, N'David Costas', N'23', N'Spain', N'70', N'75', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (219864, N'Cotan', N'22', N'Spain', N'70', N'78', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (219932, N'A. Sanabria', N'22', N'Paraguay', N'79', N'85', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (219953, N'Embarba', N'26', N'Spain', N'76', N'77', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (220132, N'Zaldua', N'26', N'Spain', N'75', N'78', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (220253, N'Munir', N'22', N'Spain', N'77', N'83', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (220337, N'J. Alonso', N'25', N'Paraguay', N'75', N'80', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (220355, N'Alex Alegria', N'25', N'Spain', N'71', N'74', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (220383, N'Aaron', N'22', N'Spain', N'62', N'68', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (220440, N'C. Lenglet', N'23', N'France', N'82', N'88', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (220604, N'Jaume', N'27', N'Spain', N'76', N'78', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (220637, N'Moi Delgado', N'24', N'Spain', N'64', N'71', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (220638, N'Luismi', N'26', N'Spain', N'72', N'77', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (220814, N'L. Hernandez', N'22', N'France', N'82', N'88', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (220834, N'Marco Asensio', N'22', N'Spain', N'85', N'92', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (221016, N'N. Vukcevic', N'26', N'Montenegro', N'76', N'79', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (221087, N'Pau Lopez', N'23', N'Spain', N'82', N'87', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (221095, N'Dani Romera', N'22', N'Spain', N'67', N'75', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (221397, N'Dani Molina', N'22', N'Spain', N'64', N'75', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (221539, N'Carrillo', N'24', N'Spain', N'68', N'75', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (221611, N'Juan Delgado', N'24', N'Spain', N'63', N'70', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (221639, N'Mariano', N'24', N'Dominican Republic', N'80', N'85', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (221653, N'Fran Serrano', N'23', N'Spain', N'62', N'70', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (221793, N'P. Twumasi', N'24', N'Ghana', N'65', N'71', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (221923, N'Vigaray', N'23', N'Spain', N'72', N'78', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (222390, N'Unai Lopez', N'22', N'Spain', N'75', N'82', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (222464, N'Sivera', N'21', N'Spain', N'71', N'78', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (222467, N'Ivi', N'24', N'Spain', N'75', N'81', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (222509, N'Dani Ceballos', N'21', N'Spain', N'81', N'88', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (222569, N'Pedrosa', N'21', N'Spain', N'56', N'64', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (222572, N'Ivan Villar', N'20', N'Spain', N'68', N'75', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (222737, N'Malcom', N'21', N'Brazil', N'82', N'89', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (222943, N'Jony', N'26', N'Spain', N'77', N'77', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (223197, N'E. Ãœnal', N'21', N'Turkey', N'77', N'83', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (223357, N'W. Kaptoum', N'21', N'Cameroon', N'66', N'77', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (223578, N'Mata', N'29', N'Spain', N'76', N'76', N'LS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (223610, N'David Concha', N'21', N'Spain', N'68', N'78', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (223654, N'Fede', N'21', N'Spain', N'70', N'79', N'RDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (223952, N'David Soria', N'25', N'Spain', N'78', N'80', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (224003, N'Sergio Herrera', N'25', N'Spain', N'71', N'73', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (224018, N'Ruben Mesa', N'26', N'Spain', N'62', N'65', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (224069, N'K. Toko-Ekambi', N'25', N'Cameroon', N'79', N'80', N'LS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (224164, N'Roger Riera', N'23', N'Spain', N'61', N'68', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (224179, N'Borja Iglesias', N'25', N'Spain', N'77', N'82', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (224411, N'GonÃ§alo Guedes', N'21', N'Portugal', N'82', N'86', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (224540, N'E. Boateng', N'22', N'Ghana', N'76', N'82', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (224566, N'Carlos Blanco', N'22', N'Spain', N'66', N'74', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (224584, N'Jairo', N'24', N'Spain', N'67', N'70', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (224921, N'Adrian Marin', N'21', N'Spain', N'72', N'81', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (224973, N'Arturo Molina', N'22', N'Spain', N'66', N'74', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225028, N'N. Radoja', N'25', N'Serbia', N'76', N'81', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225090, N'Sergio Buenacasa', N'22', N'Spain', N'63', N'69', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225105, N'Cristo Gonzalez', N'20', N'Spain', N'66', N'78', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225121, N'Castro', N'23', N'Spain', N'67', N'73', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225161, N'Vallejo', N'21', N'Spain', N'78', N'86', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225193, N'Merino', N'22', N'Spain', N'75', N'84', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225200, N'Kike Barja', N'21', N'Spain', N'68', N'75', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225299, N'E. Velazquez', N'24', N'Uruguay', N'74', N'80', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225341, N'David Garcia', N'24', N'Spain', N'68', N'73', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225395, N'Ezkieta', N'21', N'Spain', N'63', N'75', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225426, N'Arana', N'21', N'Brazil', N'74', N'82', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225523, N'Lekue', N'25', N'Spain', N'75', N'78', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225562, N'Merquelanz', N'23', N'Spain', N'68', N'75', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225591, N'L. Suarez', N'22', N'Argentina', N'72', N'80', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225699, N'Anuar', N'23', N'Morocco', N'70', N'77', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225738, N'Kuki Zalazar', N'20', N'Spain', N'64', N'80', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225755, N'Olavide', N'22', N'Spain', N'66', N'74', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225844, N'D. Verde', N'22', N'Italy', N'72', N'82', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (225868, N'David Gil', N'24', N'Spain', N'60', N'65', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (226103, N'Akieme', N'20', N'Spain', N'67', N'72', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (226161, N'Marcos Llorente', N'23', N'Spain', N'79', N'87', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (226221, N'Aritz Elustondo', N'24', N'Spain', N'76', N'80', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (226226, N'G. Lo Celso', N'22', N'Argentina', N'80', N'86', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (226456, N'Pablo Fornals', N'22', N'Spain', N'81', N'86', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (226637, N'Ruben Duarte', N'22', N'Spain', N'76', N'81', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (227055, N'Gelson Martins', N'23', N'Portugal', N'82', N'87', N'RM', NULL)
GO
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (227127, N'Alex Remiro', N'23', N'Spain', N'77', N'83', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (227329, N'Pastrana', N'21', N'Spain', N'65', N'75', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (227928, N'Nelson Semedo', N'24', N'Portugal', N'81', N'86', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (227936, N'R. MazaÅˆ', N'24', N'Slovakia', N'68', N'74', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (227950, N'Yeray', N'23', N'Spain', N'77', N'83', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (228302, N'Pedraza', N'22', N'Spain', N'75', N'80', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (228326, N'Brian Olivan', N'24', N'Spain', N'69', N'76', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (228456, N'Juan Perez', N'21', N'Spain', N'63', N'74', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (228635, N'Borja Mayoral', N'21', N'Spain', N'75', N'83', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (228707, N'Diego Alende', N'20', N'Spain', N'64', N'74', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (228716, N'Kevin', N'25', N'Spain', N'68', N'73', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (228805, N'Raillo', N'26', N'Spain', N'69', N'72', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (228941, N'Andre Silva', N'22', N'Portugal', N'79', N'87', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (228974, N'DamiÃ ', N'22', N'Spain', N'65', N'71', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (229517, N'Toni Villa', N'23', N'Spain', N'73', N'82', N'CF', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (229624, N'Sergi Guardiola', N'27', N'Spain', N'75', N'76', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (229667, N'Josan', N'28', N'Spain', N'67', N'67', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (229668, N'Mario Hermoso', N'23', N'Spain', N'76', N'84', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (229723, N'M. Jensen', N'22', N'Denmark', N'75', N'81', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (229764, N'Cordoba', N'21', N'Spain', N'75', N'83', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (229788, N'Ruben Alcaraz', N'27', N'Spain', N'73', N'74', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (229864, N'Borja Domingo', N'22', N'Spain', N'62', N'70', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (229865, N'Oscar Pinchi', N'22', N'Spain', N'66', N'77', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (229875, N'Ferran Giner', N'30', N'Spain', N'65', N'65', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (229892, N'Alex Lopez', N'24', N'Spain', N'66', N'71', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (230142, N'Oyarzabal', N'21', N'Spain', N'80', N'87', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (230578, N'M. Diakhaby', N'21', N'France', N'77', N'84', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (230658, N'Arthur', N'21', N'Brazil', N'82', N'90', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (230869, N'Unai Simon', N'21', N'Spain', N'72', N'82', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231071, N'Miquel Parera', N'22', N'Spain', N'61', N'68', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231123, N'Adri Castellano', N'24', N'Spain', N'65', N'72', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231184, N'Guruzeta', N'21', N'Spain', N'67', N'78', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231187, N'Oleaga', N'21', N'Spain', N'59', N'68', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231240, N'E. Mor', N'20', N'Turkey', N'74', N'83', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231262, N'Leja', N'23', N'Spain', N'60', N'69', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231280, N'Ivan Alejo', N'23', N'Spain', N'76', N'81', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231361, N'J. Gnagnon', N'21', N'France', N'76', N'83', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231443, N'O. Dembele', N'21', N'France', N'83', N'92', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231588, N'Joan Sastre', N'21', N'Spain', N'62', N'71', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231733, N'Curro Sanchez', N'22', N'Spain', N'67', N'74', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231749, N'Miguelon', N'22', N'Spain', N'66', N'75', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (231866, N'Rodri', N'22', N'Spain', N'82', N'87', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (232008, N'Lato', N'20', N'Spain', N'74', N'83', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (232132, N'Joaquin', N'22', N'Spain', N'68', N'72', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (232281, N'J. Victoria', N'22', N'Colombia', N'61', N'72', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (232656, N'T. Hernandez', N'20', N'France', N'77', N'85', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (232665, N'M. Arambarri', N'22', N'Uruguay', N'76', N'81', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (232883, N'G. Shibasaki', N'26', N'Japan', N'77', N'80', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (233075, N'Garrido', N'28', N'Spain', N'71', N'71', N'RDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (233113, N'AleÃ±a', N'20', N'Spain', N'72', N'85', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (233231, N'Jon Bautista', N'22', N'Spain', N'72', N'78', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (233486, N'R. Le Normand', N'21', N'France', N'67', N'79', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (233631, N'A. Ndiaye Diedhiou', N'21', N'Senegal', N'76', N'85', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (233738, N'Zubeldia', N'21', N'Spain', N'74', N'81', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (233911, N'Matos', N'23', N'Spain', N'68', N'75', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (234032, N'Lluis Lopez', N'21', N'Spain', N'67', N'77', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (234033, N'Borja Lasso', N'24', N'Spain', N'71', N'77', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (234035, N'Odriozola', N'22', N'Spain', N'80', N'88', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (234151, N'David Carmona', N'21', N'Spain', N'68', N'76', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (234152, N'Sito', N'21', N'Spain', N'63', N'69', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (234153, N'Carlos Soler', N'21', N'Spain', N'80', N'87', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (234772, N'Salvi Sanchez', N'27', N'Spain', N'73', N'73', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (234781, N'Martinez', N'25', N'Spain', N'64', N'68', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (234788, N'Eliseo Falcon', N'21', N'Spain', N'61', N'74', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (234790, N'Soriano', N'20', N'Spain', N'68', N'77', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (235398, N'Jean Carlos', N'22', N'Brazil', N'64', N'72', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (235507, N'Iban Salvador', N'22', N'Equatorial Guinea', N'67', N'75', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (235590, N'P. Sisniega', N'22', N'Mexico', N'66', N'73', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (235781, N'Santi ComesaÃ±a', N'21', N'Spain', N'70', N'76', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (235944, N'Brais Mendez', N'21', N'Spain', N'75', N'84', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (235945, N'Marc Roca', N'21', N'Spain', N'76', N'87', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (235970, N'Mario Gonzalez', N'22', N'Spain', N'63', N'71', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (235983, N'Alex Pozo', N'19', N'Spain', N'66', N'75', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (235997, N'Fran Beltran', N'19', N'Spain', N'74', N'82', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (235999, N'L. Garcia', N'20', N'Colombia', N'63', N'72', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236033, N'Dani Cardenas', N'21', N'Spain', N'63', N'73', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236221, N'D. Brasanac', N'26', N'Serbia', N'74', N'77', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236301, N'Koke Vegas', N'22', N'Spain', N'68', N'77', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236331, N'E. Cabaco', N'23', N'Uruguay', N'75', N'81', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236508, N'Adrian Dieguez', N'22', N'Spain', N'69', N'77', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236527, N'S. Caseres', N'21', N'Argentina', N'73', N'83', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236556, N'M. Hongla', N'20', N'Cameroon', N'62', N'70', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236573, N'Pablo Vazquez', N'23', N'Spain', N'64', N'72', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236679, N'Melendo', N'20', N'Spain', N'74', N'82', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236727, N'Jose Mena', N'20', N'Spain', N'64', N'76', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236760, N'Kike', N'21', N'Spain', N'62', N'68', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236882, N'Altamirano', N'21', N'Spain', N'57', N'71', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236940, N'Dario Poveda', N'21', N'Spain', N'61', N'71', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (236995, N'Ruben Sanchez', N'23', N'Spain', N'61', N'67', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (237032, N'Javi Jimenez', N'21', N'Spain', N'65', N'73', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (237146, N'Angel Sanchez', N'20', N'Spain', N'61', N'69', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (237156, N'M. Wague', N'19', N'Senegal', N'69', N'81', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (237170, N'Aitor Lorea', N'20', N'Spain', N'61', N'77', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (237239, N'E. Bardhi', N'22', N'FYR Macedonia', N'77', N'83', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (237522, N'Jorge Cuenca', N'18', N'Spain', N'65', N'78', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (237524, N'S. Kaba', N'23', N'Guinea', N'68', N'73', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (237688, N'S. Erimuya', N'20', N'Nigeria', N'61', N'70', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (237942, N'P. EstupiÃ±an', N'20', N'Ecuador', N'66', N'76', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (238126, N'Guridi', N'23', N'Spain', N'65', N'73', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (238305, N'Nacho Vidal', N'23', N'Spain', N'71', N'78', N'RB', NULL)
GO
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (238446, N'Tachi', N'20', N'Spain', N'63', N'78', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (238461, N'Luis Perea', N'20', N'Spain', N'62', N'75', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (238794, N'Vinicius Junior', N'17', N'Brazil', N'77', N'92', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (239053, N'F. Valverde', N'19', N'Uruguay', N'74', N'84', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (239116, N'C. Ganea', N'26', N'Romania', N'70', N'73', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (239120, N'F. Uzoho', N'19', N'Nigeria', N'68', N'82', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (239207, N'M. Gomez', N'21', N'Uruguay', N'80', N'85', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (239249, N'Oriol Busquets', N'19', N'Spain', N'67', N'82', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (239250, N'Abel Ruiz', N'18', N'Spain', N'67', N'83', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (239323, N'D. Eckert', N'21', N'Germany', N'64', N'76', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (239433, N'N. Maksimovic', N'23', N'Serbia', N'74', N'81', N'LCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (239614, N'Jesus Areso', N'18', N'Spain', N'64', N'79', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (239907, N'R. Dwamena', N'22', N'Ghana', N'70', N'79', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240289, N'Calero', N'22', N'Spain', N'73', N'82', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240311, N'L. Zidane', N'20', N'France', N'62', N'71', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240458, N'Ander Guevara', N'20', N'Spain', N'66', N'76', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240559, N'Obama', N'18', N'Spain', N'59', N'79', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240589, N'Miguel', N'18', N'Spain', N'64', N'78', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240719, N'Mario Sanchez', N'22', N'Spain', N'58', N'66', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240781, N'Edu Frias', N'19', N'Spain', N'64', N'78', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240846, N'E. Apeh', N'21', N'Nigeria', N'66', N'76', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240859, N'Berrocal', N'18', N'Spain', N'66', N'80', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240860, N'Jose Lara', N'18', N'Spain', N'66', N'81', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240873, N'Genaro', N'20', N'Spain', N'61', N'71', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240898, N'Francis', N'22', N'Spain', N'75', N'80', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240900, N'Unai NuÃ±ez', N'21', N'Spain', N'75', N'83', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240903, N'Javi Perez', N'22', N'Spain', N'60', N'68', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240915, N'Miranda', N'18', N'Spain', N'66', N'81', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (240997, N'Kike', N'18', N'Spain', N'62', N'72', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241049, N'Gorosabel', N'21', N'Spain', N'68', N'77', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241055, N'Diego Pampin', N'18', N'Spain', N'61', N'79', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241068, N'A. Davila', N'19', N'Uruguay', N'62', N'76', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241140, N'Fran Manzanara', N'21', N'Spain', N'65', N'75', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241179, N'Cristian Rivero', N'20', N'Spain', N'67', N'79', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241183, N'Sergio Tienza', N'21', N'Spain', N'60', N'70', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241184, N'Junior Firpo', N'21', N'Spain', N'76', N'81', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241461, N'Ferran Torres', N'18', N'Spain', N'73', N'86', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241463, N'Dani Raba', N'22', N'Spain', N'74', N'81', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241465, N'Chuca', N'21', N'Spain', N'66', N'75', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241467, N'F. Feuillassier', N'20', N'Argentina', N'65', N'80', N'LW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241470, N'Alex Centelles', N'18', N'Spain', N'64', N'77', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241488, N'Sillero', N'20', N'Spain', N'62', N'74', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241489, N'Nolaskoain', N'19', N'Spain', N'67', N'78', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241586, N'IÃ±igo MuÃ±oz', N'21', N'Spain', N'67', N'79', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241588, N'Toni Moya', N'20', N'Spain', N'63', N'79', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241682, N'Redru', N'21', N'Spain', N'63', N'74', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241686, N'Manu Vallejo', N'21', N'Spain', N'66', N'80', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241810, N'Chumi', N'19', N'Spain', N'65', N'82', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241827, N'Martin', N'22', N'Spain', N'75', N'80', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241855, N'Genis', N'21', N'Spain', N'64', N'71', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (241856, N'Manu Morlanes', N'19', N'Spain', N'71', N'83', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (242333, N'Jauregi', N'21', N'Spain', N'64', N'71', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (242348, N'Loren', N'24', N'Spain', N'78', N'83', N'RS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (242489, N'PejiÃ±o', N'21', N'Spain', N'68', N'77', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (242792, N'M. Ndockyt', N'19', N'Congo', N'66', N'76', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (242816, N'Riqui Puig', N'18', N'Spain', N'69', N'89', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243032, N'Hugo Duro', N'18', N'Spain', N'62', N'75', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243080, N'Carlos Isaac', N'20', N'Spain', N'63', N'76', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243155, N'Manu Hernando', N'19', N'Spain', N'64', N'76', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243201, N'Alex Dominguez', N'19', N'Spain', N'63', N'77', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243304, N'Zubiaurre', N'21', N'Spain', N'67', N'75', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243308, N'Alex Dos Santos', N'19', N'Brazil', N'61', N'75', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243315, N'Dani Gomez', N'19', N'Spain', N'63', N'77', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243397, N'Daniel Rebollo', N'18', N'Spain', N'60', N'74', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243429, N'Alberto Redondo', N'21', N'Spain', N'62', N'72', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243430, N'David Alba', N'19', N'Spain', N'63', N'74', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243431, N'Miguel Angel', N'20', N'Spain', N'62', N'72', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243432, N'P. Mbodji', N'20', N'Senegal', N'60', N'70', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243652, N'Borja Garces', N'18', N'Spain', N'64', N'83', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243756, N'Fran Gamez', N'26', N'Spain', N'65', N'66', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243780, N'Kangin Lee', N'17', N'Korea Republic', N'70', N'88', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243792, N'IÃ±igo Vicente', N'20', N'Spain', N'66', N'79', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243942, N'I. Zotko', N'21', N'Ukraine', N'65', N'75', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243943, N'Javi Lopez', N'17', N'Spain', N'58', N'71', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243944, N'N. Lozano', N'24', N'Colombia', N'67', N'72', N'LCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243945, N'Gonzalo Verdu', N'29', N'Spain', N'67', N'67', N'RCB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (243995, N'E. Lomotey', N'20', N'Ghana', N'64', N'76', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244005, N'Endika', N'21', N'Spain', N'63', N'70', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244106, N'Pascu', N'18', N'Spain', N'64', N'82', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244253, N'U. Racic', N'20', N'Serbia', N'74', N'83', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244393, N'Gonzalo Villar', N'20', N'Spain', N'68', N'80', N'RCM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244622, N'Puado', N'20', N'Spain', N'69', N'78', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244624, N'Alex Lopez', N'21', N'Spain', N'67', N'75', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244625, N'Pipa', N'20', N'Spain', N'67', N'75', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244675, N'Sancet', N'18', N'Spain', N'67', N'82', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244915, N'M. Salisu', N'19', N'Ghana', N'63', N'76', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244919, N'Martin', N'18', N'Spain', N'58', N'73', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244920, N'Javi Rubio', N'19', N'Spain', N'58', N'70', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244921, N'Sergio Moreno', N'19', N'Spain', N'60', N'73', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (244938, N'Montero', N'19', N'Spain', N'64', N'83', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245089, N'Samu Perez', N'21', N'Spain', N'59', N'68', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245156, N'F. Russo', N'23', N'Argentina', N'62', N'68', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245157, N'Stoichkov', N'24', N'Spain', N'63', N'66', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245219, N'Juan Hernandez', N'23', N'Spain', N'63', N'68', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245238, N'Javi Sanchez', N'21', N'Spain', N'67', N'79', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245279, N'Reguilon', N'21', N'Spain', N'68', N'80', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245287, N'Sergio Lopez', N'19', N'Spain', N'64', N'80', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245330, N'Adrian', N'22', N'Spain', N'60', N'68', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245419, N'Joan Monterde', N'20', N'Spain', N'63', N'73', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245520, N'Luca Sangalli', N'23', N'Spain', N'71', N'79', N'RM', NULL)
GO
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245577, N'Jose Gonzalez', N'22', N'Spain', N'64', N'73', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245598, N'I. Baba', N'22', N'Ghana', N'60', N'69', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245631, N'Perera', N'21', N'Spain', N'62', N'73', N'CDM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245632, N'Morro', N'17', N'Spain', N'57', N'74', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245714, N'Alex Blanco', N'19', N'Spain', N'62', N'75', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245764, N'Ricardo Campos', N'18', N'Portugal', N'63', N'79', N'RM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245894, N'Robert', N'17', N'Spain', N'61', N'81', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245895, N'Ivan', N'21', N'Spain', N'61', N'74', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245986, N'Cristian Rodriguez', N'22', N'Spain', N'60', N'70', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (245999, N'Mollejo', N'17', N'Spain', N'59', N'79', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246049, N'A. Lupu', N'20', N'Romania', N'61', N'73', N'ST', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246061, N'A. Solano', N'20', N'Colombia', N'62', N'72', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246097, N'Sergio Gonzalez', N'21', N'Spain', N'59', N'66', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246112, N'N. Djouahra', N'18', N'France', N'57', N'76', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246113, N'AdriÃ  Pedrosa', N'20', N'Spain', N'61', N'71', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246139, N'Inaki Pena', N'19', N'Spain', N'61', N'78', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246169, N'Roberto Lopez', N'18', N'Spain', N'64', N'84', N'CAM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246172, N'S. Chukwueze', N'19', N'Nigeria', N'65', N'81', N'RS', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246276, N'Joaquin', N'19', N'Spain', N'63', N'76', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246277, N'Meseguer', N'18', N'Spain', N'61', N'75', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246278, N'Manu Navarro', N'17', N'Spain', N'60', N'72', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246281, N'Emilio Bernad', N'18', N'Spain', N'62', N'76', N'GK', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246284, N'Oscar Gil', N'20', N'Spain', N'59', N'69', N'RB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246306, N'Carlos Doncel', N'21', N'Spain', N'63', N'71', N'LM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246352, N'Guillamon', N'18', N'Spain', N'61', N'81', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246455, N'Pablo Ramon', N'17', N'Spain', N'60', N'81', N'CB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246592, N'Algobia', N'19', N'Spain', N'60', N'77', N'CM', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246599, N'Guillem Jaime', N'19', N'Spain', N'64', N'80', N'RW', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246606, N'Fran Garcia', N'18', N'Spain', N'64', N'79', N'LB', NULL)
INSERT [dbo].[Jugador] ([IdJugador], [Nombre], [Edad], [Nacionalidad], [Overall], [Potential], [Position], [RidEquipo]) VALUES (246608, N'Fidalgo', N'21', N'Spain', N'65', N'75', N'CM', NULL)
GO
ALTER TABLE [dbo].[IncidenciaPartido]  WITH CHECK ADD  CONSTRAINT [FK_PartidoIncidenciaPartido] FOREIGN KEY([RidPartido])
REFERENCES [dbo].[Partido] ([IdPartido])
GO
ALTER TABLE [dbo].[IncidenciaPartido] CHECK CONSTRAINT [FK_PartidoIncidenciaPartido]
GO
ALTER TABLE [dbo].[Partido]  WITH CHECK ADD  CONSTRAINT [FK_PartidoArbitroAsistente1] FOREIGN KEY([RidArbitroAsistente1])
REFERENCES [dbo].[Arbitros] ([IdArbitros])
GO
ALTER TABLE [dbo].[Partido] CHECK CONSTRAINT [FK_PartidoArbitroAsistente1]
GO
ALTER TABLE [dbo].[Partido]  WITH CHECK ADD  CONSTRAINT [FK_PartidoArbitroAsistente2] FOREIGN KEY([RidArbitroAsistente2])
REFERENCES [dbo].[Arbitros] ([IdArbitros])
GO
ALTER TABLE [dbo].[Partido] CHECK CONSTRAINT [FK_PartidoArbitroAsistente2]
GO
ALTER TABLE [dbo].[Partido]  WITH CHECK ADD  CONSTRAINT [FK_PartidoArbitroAsistente4] FOREIGN KEY([RidArbitroAsistente4])
REFERENCES [dbo].[Arbitros] ([IdArbitros])
GO
ALTER TABLE [dbo].[Partido] CHECK CONSTRAINT [FK_PartidoArbitroAsistente4]
GO
ALTER TABLE [dbo].[Partido]  WITH CHECK ADD  CONSTRAINT [FK_PartidoArbitroPrincipal] FOREIGN KEY([RidArbitroPrincipal])
REFERENCES [dbo].[Arbitros] ([IdArbitros])
GO
ALTER TABLE [dbo].[Partido] CHECK CONSTRAINT [FK_PartidoArbitroPrincipal]
GO
USE [master]
GO
ALTER DATABASE [ToniFutbol2] SET  READ_WRITE 
GO
