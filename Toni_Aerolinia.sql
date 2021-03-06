USE [master]
GO
/****** Object:  Database [Toni_Aerolinia]    Script Date: 09/06/2022 10:23:05 ******/
CREATE DATABASE [Toni_Aerolinia]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Toni_Aerolinia', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Aerolinia.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Toni_Aerolinia_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Aerolinia_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Toni_Aerolinia] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Toni_Aerolinia].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Toni_Aerolinia] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET ARITHABORT OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Toni_Aerolinia] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Toni_Aerolinia] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Toni_Aerolinia] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Toni_Aerolinia] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET RECOVERY FULL 
GO
ALTER DATABASE [Toni_Aerolinia] SET  MULTI_USER 
GO
ALTER DATABASE [Toni_Aerolinia] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Toni_Aerolinia] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Toni_Aerolinia] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Toni_Aerolinia] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Toni_Aerolinia] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Toni_Aerolinia] SET QUERY_STORE = OFF
GO
USE [Toni_Aerolinia]
GO
/****** Object:  User [Toni]    Script Date: 09/06/2022 10:23:05 ******/
CREATE USER [Toni] FOR LOGIN [Toni] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Toni]
GO
/****** Object:  UserDefinedFunction [dbo].[InformeCiaAerea]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[InformeCiaAerea] 
(

)
RETURNS 
@Informe TABLE 
(
	titulo varchar(50),
	resultado int
)
AS
BEGIN

	INSERT INTO @Informe
		VALUES('Num.Vuelos =', 
		(SELECT count(Vuelo.id_vuelo) FROM Vuelo))

	INSERT INTO @Informe
		VALUES('Num.Pilotos =',
		(SELECT count(Tripulante.nombre_tripulante)  FROM Tripulante))

	INSERT INTO @Informe
		VALUES('Precio medio billete =',
		(SELECT AVG(Relacion_Clase_Vuelo_Booking.precio) FROM Relacion_Clase_Vuelo_Booking))		

	INSERT INTO @Informe
		VALUES('Ranking Pilotos :', null)

	INSERT INTO @Informe (titulo, resultado)
		SELECT TOP 10000 Tripulante.nombre_tripulante,COUNT(id_vuelo) FROM Vuelo
		INNER JOIN Tripulante
			ON Vuelo.FK_id_tripulante = Tripulante.id_tripulante
		WHERE FK_id_rango_empleado = 1
		group by Tripulante.nombre_tripulante
		ORDER BY COUNT(id_vuelo) desc;

	RETURN 
END
GO
/****** Object:  Table [dbo].[Ruta]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ruta](
	[id_ruta] [int] IDENTITY(1,1) NOT NULL,
	[hora_llegada_ruta] [time](7) NOT NULL,
	[hora_salida_ruta] [time](7) NOT NULL,
	[duracion_min] [int] NOT NULL,
	[FK_origen_id_aeropuerto] [int] NOT NULL,
	[FK_destino_id_Aeropuerto] [int] NOT NULL,
 CONSTRAINT [PK_Ruta_1] PRIMARY KEY CLUSTERED 
(
	[id_ruta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aeropuerto]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aeropuerto](
	[id_aeropuerto] [int] IDENTITY(1,1) NOT NULL,
	[nombre_aeropuerto] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AEROPUERTO] PRIMARY KEY CLUSTERED 
(
	[id_aeropuerto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Aeropuertos_Sin_Vuelos]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function [dbo].[Aeropuertos_Sin_Vuelos](@aer varchar(50))
RETURNS TABLE
AS 
RETURN
(
SELECT nombre_aeropuerto FROM Aeropuerto
LEFT JOIN Ruta	
	ON id_aeropuerto=FK_destino_id_Aeropuerto
WHERE id_ruta IS NULL AND nombre_aeropuerto=@aer
);
GO
/****** Object:  Table [dbo].[Avion]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Avion](
	[id_avion] [int] IDENTITY(1,1) NOT NULL,
	[modelo] [varchar](50) NOT NULL,
	[capacidad] [int] NOT NULL,
	[año_construccion] [int] NOT NULL,
	[nombre_avion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Avion] PRIMARY KEY CLUSTERED 
(
	[id_avion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[id_reserva] [int] IDENTITY(1,1) NOT NULL,
	[nombre_pasajer] [varchar](50) NOT NULL,
	[apellido_pasajero] [varchar](50) NOT NULL,
	[DNI_pasajero] [varchar](50) NOT NULL,
	[FK_id_clase_vuelo_booking] [int] NOT NULL,
	[Passport_pasajero] [varchar](12) NOT NULL,
	[fecha_reserva] [date] NOT NULL,
	[fila_reserva] [smallint] NOT NULL,
	[letra_reserva] [varchar](4) NOT NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[id_reserva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clase]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clase](
	[id_clase] [int] IDENTITY(1,1) NOT NULL,
	[tipo_clase] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Clase] PRIMARY KEY CLUSTERED 
(
	[id_clase] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rango_Empleado]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rango_Empleado](
	[id_rango_empleado] [int] IDENTITY(1,1) NOT NULL,
	[rango_empleado] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Rango_Empleado] PRIMARY KEY CLUSTERED 
(
	[id_rango_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Relacion_Clase_Vuelo_Booking]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Relacion_Clase_Vuelo_Booking](
	[id_clase_vuelo_booking] [int] IDENTITY(1,1) NOT NULL,
	[precio] [money] NOT NULL,
	[fila_inicial] [smallint] NOT NULL,
	[fila_final] [smallint] NOT NULL,
	[FK_id_clase] [int] NOT NULL,
	[FK_id_vuelo] [int] NOT NULL,
 CONSTRAINT [PK_Relacion_Clase_Vuelo_Booking] PRIMARY KEY CLUSTERED 
(
	[id_clase_vuelo_booking] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Relacion_Copiloto]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Relacion_Copiloto](
	[id_copiloto] [int] IDENTITY(1,1) NOT NULL,
	[ES_COPILOTO] [bit] NOT NULL,
	[FK_id_tripulante] [int] NOT NULL,
 CONSTRAINT [PK_Copiloto] PRIMARY KEY CLUSTERED 
(
	[id_copiloto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Relacion_Piloto]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Relacion_Piloto](
	[id_piloto] [int] IDENTITY(1,1) NOT NULL,
	[ES_PILOTO] [bit] NOT NULL,
	[FK_id_tripulante] [int] NOT NULL,
 CONSTRAINT [PK_Piloto] PRIMARY KEY CLUSTERED 
(
	[id_piloto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tripulante]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tripulante](
	[id_tripulante] [int] IDENTITY(1,1) NOT NULL,
	[nombre_tripulante] [varchar](50) NOT NULL,
	[DNI] [varchar](12) NOT NULL,
	[fecha_antiguedad] [datetime] NOT NULL,
	[FK_id_rango_empleado] [int] NOT NULL,
	[ES_PILOTO_NACIONAL] [bit] NOT NULL,
	[ES_PILOTO_INTERN] [bit] NOT NULL,
	[ES_PILOTO_CONTI] [bit] NOT NULL,
 CONSTRAINT [PK_Tripulante] PRIMARY KEY CLUSTERED 
(
	[id_tripulante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vuelo]    Script Date: 09/06/2022 10:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vuelo](
	[id_vuelo] [int] IDENTITY(1,1) NOT NULL,
	[fecha_vuelo] [date] NOT NULL,
	[FK_id_ruta] [int] NULL,
	[FK_id_tripulante] [int] NULL,
	[FK_id_piloto] [int] NULL,
	[FK_id_copiloto] [int] NULL,
	[FK_id_avion] [int] NULL,
 CONSTRAINT [PK_Vuelo] PRIMARY KEY CLUSTERED 
(
	[id_vuelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Aeropuerto] ON 

INSERT [dbo].[Aeropuerto] ([id_aeropuerto], [nombre_aeropuerto]) VALUES (1, N'Barcelona')
INSERT [dbo].[Aeropuerto] ([id_aeropuerto], [nombre_aeropuerto]) VALUES (2, N'Madrid')
INSERT [dbo].[Aeropuerto] ([id_aeropuerto], [nombre_aeropuerto]) VALUES (3, N'Paris')
INSERT [dbo].[Aeropuerto] ([id_aeropuerto], [nombre_aeropuerto]) VALUES (4, N'Milan')
INSERT [dbo].[Aeropuerto] ([id_aeropuerto], [nombre_aeropuerto]) VALUES (5, N'Londres')
INSERT [dbo].[Aeropuerto] ([id_aeropuerto], [nombre_aeropuerto]) VALUES (6, N'Berlin')
INSERT [dbo].[Aeropuerto] ([id_aeropuerto], [nombre_aeropuerto]) VALUES (7, N'Praga')
SET IDENTITY_INSERT [dbo].[Aeropuerto] OFF
GO
SET IDENTITY_INSERT [dbo].[Avion] ON 

INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (1, N'Virgin Islands, United States', 53, 2008, N'Weiss')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (2, N'Morocco', 32, 2019, N'Joyner')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (3, N'Uzbekistan', 30, 2006, N'Emerson')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (4, N'Afghanistan', 15, 2012, N'Romero')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (5, N'Guam', 78, 2007, N'Barker')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (6, N'Nauru', 135, 2018, N'Whitaker')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (7, N'Wallis and Futuna', 29, 2017, N'Levy')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (8, N'Georgia', 36, 2013, N'Walton')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (9, N'Macao', 28, 2007, N'Austin')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (10, N'Malta', 123, 2016, N'Byers')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (11, N'Cyprus', 27, 2015, N'Morgan')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (12, N'Guatemala', 127, 2017, N'Haley')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (13, N'Liechtenstein', 16, 2008, N'Leach')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (14, N'Sao Tome and Principe', 63, 2009, N'Chavez')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (15, N'Japan', 105, 2009, N'Torres')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (16, N'Nicaragua', 61, 2017, N'Avila')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (17, N'Slovakia', 91, 2005, N'Bradford')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (18, N'Grenada', 96, 2011, N'Dennis')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (19, N'Croatia', 79, 2014, N'Nolan')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (20, N'Jersey', 136, 2014, N'Daugherty')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (21, N'Tanzania', 78, 2018, N'Rasmussen')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (22, N'Indonesia', 39, 2010, N'Pennington')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (23, N'Sri Lanka', 31, 2005, N'Matthews')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (24, N'United States', 84, 2017, N'Russo')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (25, N'Malaysia', 52, 2004, N'Perry')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (26, N'Niue', 22, 2009, N'Melton')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (27, N'Israel', 21, 2016, N'Page')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (28, N'Kazakhstan', 45, 2008, N'Kaufman')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (29, N'Senegal', 68, 2009, N'Kane')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (30, N'Greenland', 33, 2005, N'Lowery')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (31, N'Peru', 24, 2015, N'Gilmore')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (32, N'Botswana', 93, 2016, N'Fields')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (33, N'Panama', 104, 2006, N'Schneider')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (34, N'Guam', 123, 2008, N'Hebert')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (35, N'Qatar', 63, 2010, N'Noel')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (36, N'Suriname', 68, 2017, N'Finley')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (37, N'Algeria', 37, 2008, N'Mckinney')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (38, N'Swaziland', 39, 2012, N'Thompson')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (39, N'Cayman Islands', 27, 2007, N'Sherman')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (40, N'Palestine, State of', 86, 2011, N'Wilder')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (41, N'Jamaica', 24, 2007, N'Henry')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (42, N'Bouvet Island', 31, 2012, N'Nguyen')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (43, N'Romania', 73, 2007, N'Peterson')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (44, N'United Arab Emirates', 82, 2007, N'York')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (45, N'Benin', 2, 2007, N'Bush')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (46, N'Virgin Islands, United States', 68, 2010, N'Morrison')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (47, N'Mali', 98, 2016, N'Kennedy')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (48, N'Wallis and Futuna', 1, 2012, N'Abbott')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (49, N'Fiji', 70, 2014, N'Kinney')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (50, N'Congo, the Democratic Republic of the', 11, 2006, N'Talley')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (51, N'Andorra', 61, 2015, N'Blevins')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (52, N'Dominican Republic', 16, 2012, N'Ochoa')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (53, N'Cayman Islands', 142, 2018, N'Casey')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (54, N'Bhutan', 112, 2010, N'Moses')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (55, N'Singapore', 131, 2005, N'Jones')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (56, N'Fiji', 48, 2006, N'Ferguson')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (57, N'Chad', 30, 2017, N'Frazier')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (58, N'Luxembourg', 132, 2013, N'Duke')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (59, N'Serbia', 56, 2004, N'Koch')
INSERT [dbo].[Avion] ([id_avion], [modelo], [capacidad], [año_construccion], [nombre_avion]) VALUES (60, N'El Salvador', 98, 2019, N'Trevino')
SET IDENTITY_INSERT [dbo].[Avion] OFF
GO
SET IDENTITY_INSERT [dbo].[Booking] ON 

INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (1, N'Thaddeus', N'Buckley', N'ESS24QZK0NY', 5, N'RIJ4T7O', CAST(N'2019-04-26' AS Date), 117, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (2, N'Sara', N'Farrell', N'YGR88UMA5EK', 26, N'BFB5B6S', CAST(N'2019-04-26' AS Date), 135, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (3, N'Dominic', N'Mcfarland', N'AJB76CBE3OH', 23, N'YZI8C5M', CAST(N'2019-04-26' AS Date), 30, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (4, N'Evangeline', N'Ewing', N'IWS14MBD0RS', 27, N'WSH8E9Y', CAST(N'2019-04-26' AS Date), 119, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (5, N'Drake', N'Saunders', N'UFP56RRF1JT', 38, N'ICW5I0N', CAST(N'2019-04-26' AS Date), 77, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (6, N'Chandler', N'Fisher', N'VPG98HNP3JK', 16, N'BCE2V1P', CAST(N'2019-04-26' AS Date), 20, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (7, N'Yeo', N'Taylor', N'MTP96YSM7UD', 10, N'CSN2A2M', CAST(N'2019-04-26' AS Date), 114, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (8, N'Geoffrey', N'Powell', N'TPN08JYY7NI', 39, N'CUU5K4V', CAST(N'2019-04-26' AS Date), 25, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (9, N'Kay', N'Potter', N'HOD86EMX7VP', 33, N'YXT2H2B', CAST(N'2019-04-26' AS Date), 125, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (10, N'Sigourney', N'Summers', N'LHV44QTI5BS', 42, N'NVQ9P4B', CAST(N'2019-04-26' AS Date), 102, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (11, N'Olivia', N'Raymond', N'UXV88YES3WC', 7, N'GZW1G7R', CAST(N'2019-04-26' AS Date), 119, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (12, N'Clinton', N'Donaldson', N'OML88XRX3BD', 14, N'HTE5R8B', CAST(N'2019-04-26' AS Date), 85, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (13, N'Matthew', N'Bradley', N'JSP44NJS9CS', 48, N'QTU4W3T', CAST(N'2019-04-26' AS Date), 137, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (14, N'Sade', N'Cline', N'KUY50BHY3WH', 35, N'RVC4N5N', CAST(N'2019-04-26' AS Date), 129, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (15, N'Garth', N'Atkins', N'EPL35TXI2OC', 23, N'FPQ3H2X', CAST(N'2019-04-26' AS Date), 117, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (16, N'Zeus', N'Barnes', N'QQB37DNX4II', 55, N'HDK1R3W', CAST(N'2019-04-26' AS Date), 130, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (17, N'Axel', N'Holloway', N'AHD54MRX8BQ', 51, N'MRM2F2L', CAST(N'2019-04-26' AS Date), 87, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (18, N'Shafira', N'Hutchinson', N'RKV96CUL6NP', 20, N'AHK8L4T', CAST(N'2019-04-26' AS Date), 127, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (19, N'Knox', N'Livingston', N'QLT32VFJ4IR', 51, N'OHC1N5U', CAST(N'2019-04-26' AS Date), 49, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (20, N'Laura', N'Ballard', N'MWP14LQP4IW', 20, N'SVK6S2P', CAST(N'2019-04-26' AS Date), 8, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (21, N'Orla', N'Whitehead', N'ULU13WSA5PE', 41, N'VRO1Q0X', CAST(N'2019-04-26' AS Date), 63, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (22, N'Nora', N'Wilder', N'VUE45WNM3OJ', 50, N'MHN2H3W', CAST(N'2019-04-26' AS Date), 20, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (23, N'Carla', N'Fuentes', N'SOY35YRK8JV', 10, N'CTV3Y3C', CAST(N'2019-04-26' AS Date), 35, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (24, N'Chaim', N'Gentry', N'DTW46OWQ3YL', 27, N'KGO8X7E', CAST(N'2019-04-26' AS Date), 121, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (25, N'Basil', N'Morrow', N'TVU07SUQ5VX', 54, N'VKG5T3T', CAST(N'2019-04-26' AS Date), 102, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (26, N'Melodie', N'Koch', N'JNN43GWU4FT', 32, N'GNV6R6T', CAST(N'2019-04-26' AS Date), 68, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (27, N'Daria', N'Owens', N'VQO39PBX6MR', 42, N'WCG3N2B', CAST(N'2019-04-26' AS Date), 131, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (28, N'Gage', N'Douglas', N'HJX05PNW5NH', 13, N'WPP7K2I', CAST(N'2019-04-26' AS Date), 12, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (29, N'Donna', N'Moreno', N'QCH75GPU4MT', 36, N'DBB1C1T', CAST(N'2019-04-26' AS Date), 46, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (30, N'Lyle', N'Silva', N'GZQ68PJJ4EB', 59, N'HWC5I1P', CAST(N'2019-04-26' AS Date), 71, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (31, N'Hunter', N'Duffy', N'PBT72VJO3LK', 58, N'OIG3N3T', CAST(N'2019-04-26' AS Date), 134, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (32, N'Mark', N'Humphrey', N'IWI77VLK3SI', 54, N'CLI8H9M', CAST(N'2019-04-26' AS Date), 45, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (33, N'Neville', N'Houston', N'MII86XBS7QO', 30, N'BCB1R6S', CAST(N'2019-04-26' AS Date), 136, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (34, N'Sara', N'Ingram', N'IOO96XIG2VJ', 10, N'FIJ8Z5O', CAST(N'2019-04-26' AS Date), 119, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (35, N'Aileen', N'Barnes', N'SSB66DWV3WR', 32, N'NOR9H9P', CAST(N'2019-04-26' AS Date), 44, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (36, N'Charlotte', N'Nielsen', N'KDX78ACN5FR', 12, N'XYV8D3L', CAST(N'2019-04-26' AS Date), 89, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (37, N'Coby', N'Williams', N'WLX41YLJ7EW', 3, N'MWR2S5C', CAST(N'2019-04-26' AS Date), 21, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (38, N'Zachary', N'Parker', N'VOO56VQM6IV', 9, N'YPY3D2W', CAST(N'2019-04-26' AS Date), 114, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (39, N'Amir', N'Mccray', N'THN58HIX1RM', 24, N'DBZ5L9E', CAST(N'2019-04-26' AS Date), 37, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (40, N'Martin', N'Howe', N'ONA61DJY8ME', 17, N'CJP6G6M', CAST(N'2019-04-26' AS Date), 70, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (41, N'Angelica', N'Davidson', N'LSP68GVK1SN', 45, N'IRZ1Q1X', CAST(N'2019-04-26' AS Date), 18, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (42, N'Brian', N'Potter', N'YXW07SOQ8RQ', 9, N'PWP6M6D', CAST(N'2019-04-26' AS Date), 15, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (43, N'Shaeleigh', N'Petersen', N'TUH72MSU2NC', 2, N'CLB8N8U', CAST(N'2019-04-26' AS Date), 40, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (44, N'Teegan', N'Peck', N'QTB42KUJ1FQ', 58, N'BVE4G7X', CAST(N'2019-04-26' AS Date), 55, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (45, N'Kelsie', N'Pearson', N'AIT47EGC1UH', 53, N'MYS5U2C', CAST(N'2019-04-26' AS Date), 47, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (46, N'Eagan', N'Johnston', N'HVM22GME0FC', 40, N'CFQ5N5G', CAST(N'2019-04-26' AS Date), 73, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (47, N'Ralph', N'Cooley', N'CAH73PXV3BG', 53, N'XYL8I8C', CAST(N'2019-04-26' AS Date), 115, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (48, N'Ariana', N'Guzman', N'VEX72BEZ2KI', 33, N'EPO8S3I', CAST(N'2019-04-26' AS Date), 75, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (49, N'Dennis', N'Hill', N'WUX61FWX2SK', 33, N'NLK3M4K', CAST(N'2019-04-26' AS Date), 5, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (50, N'Wing', N'Lambert', N'VSH22CML7GW', 48, N'YRS4Y4K', CAST(N'2019-04-26' AS Date), 36, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (51, N'Sasha', N'Herring', N'GKF88IPQ4VW', 30, N'HHE5V7E', CAST(N'2019-04-26' AS Date), 93, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (52, N'Jessamine', N'Walters', N'VWV34VYE3RC', 40, N'GUJ5H9I', CAST(N'2019-04-26' AS Date), 47, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (53, N'Igor', N'Hunter', N'RVK83JCB5RQ', 30, N'RHL8H1R', CAST(N'2019-04-26' AS Date), 70, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (54, N'Griffin', N'Maldonado', N'ERH97GTH4GY', 14, N'KKJ1S3U', CAST(N'2019-04-26' AS Date), 99, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (55, N'Gillian', N'Adams', N'NED57WQZ1MJ', 16, N'KFL3R5B', CAST(N'2019-04-26' AS Date), 121, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (56, N'Devin', N'Welch', N'MIV55MIL4WQ', 50, N'PML1T5N', CAST(N'2019-04-26' AS Date), 20, N'D')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (57, N'Justine', N'Bryant', N'KPF23SRK5JU', 11, N'JKA7P7O', CAST(N'2019-04-26' AS Date), 54, N'A')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (58, N'McKenzie', N'Spears', N'NXC86NHK9PD', 37, N'RXM9M3O', CAST(N'2019-04-26' AS Date), 22, N'B')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (59, N'Leila', N'Bass', N'GOC53QEO3EU', 30, N'GTJ4F5C', CAST(N'2019-04-26' AS Date), 37, N'C')
INSERT [dbo].[Booking] ([id_reserva], [nombre_pasajer], [apellido_pasajero], [DNI_pasajero], [FK_id_clase_vuelo_booking], [Passport_pasajero], [fecha_reserva], [fila_reserva], [letra_reserva]) VALUES (60, N'Kessie', N'Ruiz', N'ESF74DIE8DI', 25, N'DXY8X1V', CAST(N'2019-04-26' AS Date), 116, N'D')
SET IDENTITY_INSERT [dbo].[Booking] OFF
GO
SET IDENTITY_INSERT [dbo].[Clase] ON 

INSERT [dbo].[Clase] ([id_clase], [tipo_clase]) VALUES (1, N'turista')
INSERT [dbo].[Clase] ([id_clase], [tipo_clase]) VALUES (2, N'ejecutiva')
INSERT [dbo].[Clase] ([id_clase], [tipo_clase]) VALUES (3, N'primera')
SET IDENTITY_INSERT [dbo].[Clase] OFF
GO
SET IDENTITY_INSERT [dbo].[Rango_Empleado] ON 

INSERT [dbo].[Rango_Empleado] ([id_rango_empleado], [rango_empleado]) VALUES (1, N'Piloto')
INSERT [dbo].[Rango_Empleado] ([id_rango_empleado], [rango_empleado]) VALUES (2, N'Copiloto')
INSERT [dbo].[Rango_Empleado] ([id_rango_empleado], [rango_empleado]) VALUES (3, N'Ingeniero de vuelo')
INSERT [dbo].[Rango_Empleado] ([id_rango_empleado], [rango_empleado]) VALUES (4, N'TCP')
SET IDENTITY_INSERT [dbo].[Rango_Empleado] OFF
GO
SET IDENTITY_INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ON 

INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (1, 428.0000, 25, 16, 1, 5)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (2, 993.0000, 4, 51, 1, 8)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (3, 826.0000, 89, 114, 1, 17)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (4, 856.0000, 36, 2, 1, 36)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (5, 121.0000, 24, 69, 1, 49)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (6, 600.0000, 16, 29, 1, 50)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (7, 441.0000, 114, 31, 1, 53)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (8, 296.0000, 58, 83, 2, 2)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (9, 470.0000, 128, 13, 2, 13)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (10, 416.0000, 61, 45, 2, 14)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (11, 561.0000, 127, 94, 2, 30)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (12, 199.0000, 45, 124, 2, 36)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (13, 420.0000, 32, 79, 2, 44)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (14, 43.0000, 38, 19, 2, 45)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (15, 286.0000, 124, 9, 2, 47)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (16, 368.0000, 132, 37, 2, 52)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (17, 228.0000, 127, 140, 2, 60)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (18, 757.0000, 22, 129, 3, 7)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (19, 382.0000, 20, 101, 3, 10)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (20, 28.0000, 89, 65, 3, 45)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (21, 704.0000, 130, 126, 2, 11)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (22, 550.0000, 38, 74, 2, 11)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (23, 981.0000, 89, 81, 2, 13)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (24, 409.0000, 11, 27, 3, 8)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (25, 365.0000, 111, 58, 2, 1)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (26, 391.0000, 12, 21, 3, 51)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (27, 808.0000, 86, 30, 1, 14)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (28, 499.0000, 90, 67, 1, 38)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (29, 235.0000, 80, 40, 3, 17)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (30, 163.0000, 23, 69, 1, 22)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (31, 757.0000, 22, 129, 3, 7)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (32, 28.0000, 89, 65, 3, 45)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (33, 420.0000, 32, 79, 2, 44)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (34, 199.0000, 45, 124, 2, 36)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (35, 43.0000, 38, 19, 2, 45)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (36, 296.0000, 58, 83, 2, 2)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (37, 600.0000, 16, 29, 1, 50)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (38, 826.0000, 89, 114, 1, 17)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (39, 368.0000, 132, 37, 2, 52)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (40, 428.0000, 25, 16, 1, 5)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (41, 416.0000, 61, 45, 2, 14)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (42, 441.0000, 114, 31, 1, 53)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (43, 121.0000, 24, 69, 1, 49)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (44, 561.0000, 127, 94, 2, 30)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (45, 382.0000, 20, 101, 3, 10)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (46, 470.0000, 128, 13, 2, 13)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (47, 286.0000, 124, 9, 2, 47)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (48, 993.0000, 4, 51, 1, 8)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (49, 856.0000, 36, 2, 1, 36)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (50, 228.0000, 127, 140, 2, 60)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (51, 443.0000, 88, 65, 1, 47)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (52, 532.0000, 74, 140, 2, 9)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (53, 515.0000, 45, 114, 2, 55)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (54, 107.0000, 87, 46, 2, 47)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (55, 296.0000, 136, 13, 2, 39)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (56, 569.0000, 113, 87, 3, 2)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (57, 648.0000, 113, 42, 3, 58)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (58, 76.0000, 128, 80, 1, 3)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (59, 209.0000, 9, 75, 2, 15)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (60, 37.0000, 59, 9, 3, 10)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (61, 196.0000, 47, 49, 1, 10)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (62, 990.0000, 36, 118, 2, 48)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (63, 326.0000, 84, 115, 3, 28)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (64, 870.0000, 130, 60, 1, 52)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (65, 634.0000, 89, 87, 1, 11)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (66, 824.0000, 54, 87, 1, 17)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (67, 894.0000, 74, 97, 1, 25)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (68, 619.0000, 67, 92, 1, 35)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (69, 54.0000, 50, 70, 3, 16)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (70, 310.0000, 79, 49, 1, 30)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (71, 674.0000, 141, 37, 2, 46)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (72, 921.0000, 99, 26, 2, 35)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (73, 473.0000, 61, 26, 1, 53)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (74, 122.0000, 135, 9, 1, 27)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (75, 968.0000, 34, 56, 2, 52)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (76, 130.0000, 137, 65, 3, 44)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (77, 617.0000, 68, 73, 2, 35)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (78, 800.0000, 19, 118, 3, 47)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (79, 728.0000, 57, 79, 3, 28)
INSERT [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking], [precio], [fila_inicial], [fila_final], [FK_id_clase], [FK_id_vuelo]) VALUES (80, 698.0000, 16, 70, 2, 25)
SET IDENTITY_INSERT [dbo].[Relacion_Clase_Vuelo_Booking] OFF
GO
SET IDENTITY_INSERT [dbo].[Relacion_Copiloto] ON 

INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (1, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (2, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (3, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (4, 1, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (5, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (6, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (7, 1, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (8, 1, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (9, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (10, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (11, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (12, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (13, 1, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (14, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (15, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (16, 1, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (17, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (18, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (19, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (20, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (21, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (22, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (23, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (24, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (25, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (26, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (27, 1, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (28, 1, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (29, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (30, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (31, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (32, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (33, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (34, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (35, 1, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (36, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (37, 1, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (38, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (39, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (40, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (41, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (42, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (43, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (44, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (45, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (46, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (47, 1, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (48, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (49, 1, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (50, 1, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (51, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (52, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (53, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (54, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (55, 0, 2)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (56, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (57, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (58, 0, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (59, 1, 1)
INSERT [dbo].[Relacion_Copiloto] ([id_copiloto], [ES_COPILOTO], [FK_id_tripulante]) VALUES (60, 1, 1)
SET IDENTITY_INSERT [dbo].[Relacion_Copiloto] OFF
GO
SET IDENTITY_INSERT [dbo].[Relacion_Piloto] ON 

INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (1, 1, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (2, 0, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (3, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (4, 0, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (5, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (6, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (7, 1, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (8, 1, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (9, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (10, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (11, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (12, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (13, 0, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (14, 1, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (15, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (16, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (17, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (18, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (19, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (20, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (21, 0, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (22, 1, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (23, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (24, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (25, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (26, 0, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (27, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (28, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (29, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (30, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (31, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (32, 0, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (33, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (34, 1, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (35, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (36, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (37, 1, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (38, 0, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (39, 1, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (40, 0, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (41, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (42, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (43, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (44, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (45, 1, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (46, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (47, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (48, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (49, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (50, 0, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (51, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (52, 1, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (53, 0, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (54, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (55, 1, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (56, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (57, 1, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (58, 0, 1)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (59, 0, 2)
INSERT [dbo].[Relacion_Piloto] ([id_piloto], [ES_PILOTO], [FK_id_tripulante]) VALUES (60, 1, 1)
SET IDENTITY_INSERT [dbo].[Relacion_Piloto] OFF
GO
SET IDENTITY_INSERT [dbo].[Ruta] ON 

INSERT [dbo].[Ruta] ([id_ruta], [hora_llegada_ruta], [hora_salida_ruta], [duracion_min], [FK_origen_id_aeropuerto], [FK_destino_id_Aeropuerto]) VALUES (84, CAST(N'14:46:10' AS Time), CAST(N'15:11:46' AS Time), 127, 5, 2)
INSERT [dbo].[Ruta] ([id_ruta], [hora_llegada_ruta], [hora_salida_ruta], [duracion_min], [FK_origen_id_aeropuerto], [FK_destino_id_Aeropuerto]) VALUES (85, CAST(N'03:11:37' AS Time), CAST(N'07:17:14' AS Time), 228, 3, 2)
INSERT [dbo].[Ruta] ([id_ruta], [hora_llegada_ruta], [hora_salida_ruta], [duracion_min], [FK_origen_id_aeropuerto], [FK_destino_id_Aeropuerto]) VALUES (86, CAST(N'07:05:57' AS Time), CAST(N'20:08:48' AS Time), 124, 3, 1)
INSERT [dbo].[Ruta] ([id_ruta], [hora_llegada_ruta], [hora_salida_ruta], [duracion_min], [FK_origen_id_aeropuerto], [FK_destino_id_Aeropuerto]) VALUES (87, CAST(N'04:05:11' AS Time), CAST(N'01:47:01' AS Time), 63, 5, 6)
INSERT [dbo].[Ruta] ([id_ruta], [hora_llegada_ruta], [hora_salida_ruta], [duracion_min], [FK_origen_id_aeropuerto], [FK_destino_id_Aeropuerto]) VALUES (88, CAST(N'14:35:45' AS Time), CAST(N'06:34:22' AS Time), 37, 1, 5)
INSERT [dbo].[Ruta] ([id_ruta], [hora_llegada_ruta], [hora_salida_ruta], [duracion_min], [FK_origen_id_aeropuerto], [FK_destino_id_Aeropuerto]) VALUES (89, CAST(N'02:33:11' AS Time), CAST(N'05:20:41' AS Time), 160, 6, 5)
INSERT [dbo].[Ruta] ([id_ruta], [hora_llegada_ruta], [hora_salida_ruta], [duracion_min], [FK_origen_id_aeropuerto], [FK_destino_id_Aeropuerto]) VALUES (90, CAST(N'03:52:31' AS Time), CAST(N'06:23:18' AS Time), 11, 6, 2)
INSERT [dbo].[Ruta] ([id_ruta], [hora_llegada_ruta], [hora_salida_ruta], [duracion_min], [FK_origen_id_aeropuerto], [FK_destino_id_Aeropuerto]) VALUES (91, CAST(N'15:12:04' AS Time), CAST(N'23:45:21' AS Time), 174, 5, 4)
INSERT [dbo].[Ruta] ([id_ruta], [hora_llegada_ruta], [hora_salida_ruta], [duracion_min], [FK_origen_id_aeropuerto], [FK_destino_id_Aeropuerto]) VALUES (92, CAST(N'19:53:52' AS Time), CAST(N'04:35:43' AS Time), 175, 2, 4)
INSERT [dbo].[Ruta] ([id_ruta], [hora_llegada_ruta], [hora_salida_ruta], [duracion_min], [FK_origen_id_aeropuerto], [FK_destino_id_Aeropuerto]) VALUES (93, CAST(N'07:21:55' AS Time), CAST(N'09:51:38' AS Time), 221, 6, 4)
INSERT [dbo].[Ruta] ([id_ruta], [hora_llegada_ruta], [hora_salida_ruta], [duracion_min], [FK_origen_id_aeropuerto], [FK_destino_id_Aeropuerto]) VALUES (94, CAST(N'22:09:17' AS Time), CAST(N'08:38:40' AS Time), 117, 1, 4)
SET IDENTITY_INSERT [dbo].[Ruta] OFF
GO
SET IDENTITY_INSERT [dbo].[Tripulante] ON 

INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (1, N'Ashley', N'WGC16EVN0LM', CAST(N'1972-01-06T00:00:00.000' AS DateTime), 3, 1, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (2, N'Peterson', N'OKB75EBN4BH', CAST(N'1981-03-20T00:00:00.000' AS DateTime), 2, 1, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (3, N'Chang', N'KOD70RNW3OQ', CAST(N'1977-04-03T00:00:00.000' AS DateTime), 2, 0, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (4, N'Gallegos', N'LPV53UER8PF', CAST(N'1999-08-23T00:00:00.000' AS DateTime), 2, 1, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (5, N'Wilkinson', N'GSR41LFW9SI', CAST(N'1960-04-25T00:00:00.000' AS DateTime), 3, 1, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (6, N'Newman', N'SEP16GBD6UZ', CAST(N'1985-12-06T00:00:00.000' AS DateTime), 3, 0, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (7, N'Brady', N'NRE84VEQ1JJ', CAST(N'1972-09-06T00:00:00.000' AS DateTime), 4, 1, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (8, N'Wagner', N'GBQ11PRU3GV', CAST(N'2020-09-01T00:00:00.000' AS DateTime), 2, 1, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (9, N'Mejia', N'XNV81CNI9WP', CAST(N'1969-02-22T00:00:00.000' AS DateTime), 3, 1, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (10, N'Turner', N'SOE21UFO7JR', CAST(N'2017-12-14T00:00:00.000' AS DateTime), 2, 0, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (11, N'Clements', N'DBE54FXU1UU', CAST(N'1993-11-24T00:00:00.000' AS DateTime), 3, 0, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (12, N'Mcguire', N'QYG33HTJ3HW', CAST(N'1981-12-20T00:00:00.000' AS DateTime), 2, 0, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (13, N'Horn', N'IMF71CHV1RU', CAST(N'2014-08-07T00:00:00.000' AS DateTime), 2, 1, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (14, N'Sweet', N'XXR76VRN3EF', CAST(N'2012-04-20T00:00:00.000' AS DateTime), 2, 0, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (15, N'Fischer', N'ILA38GON5LK', CAST(N'1983-01-17T00:00:00.000' AS DateTime), 2, 0, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (16, N'Hopkins', N'JJY62CYA5JG', CAST(N'2013-03-26T00:00:00.000' AS DateTime), 1, 1, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (17, N'Barton', N'NAK44LWD5VI', CAST(N'2014-06-13T00:00:00.000' AS DateTime), 3, 0, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (18, N'Bryan', N'LRE54LTO6KE', CAST(N'1995-01-18T00:00:00.000' AS DateTime), 1, 0, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (19, N'Mcpherson', N'JYD43CPP5VD', CAST(N'1972-02-04T00:00:00.000' AS DateTime), 1, 0, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (20, N'Rosario', N'CGO33TQO8HE', CAST(N'1983-11-07T00:00:00.000' AS DateTime), 2, 1, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (21, N'Rodgers', N'VRC04DOB3BW', CAST(N'1992-05-18T00:00:00.000' AS DateTime), 2, 0, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (22, N'Forbes', N'OIT14CGD7NJ', CAST(N'2000-08-22T00:00:00.000' AS DateTime), 1, 0, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (23, N'Boone', N'CDS81FQP4CF', CAST(N'1985-07-10T00:00:00.000' AS DateTime), 1, 1, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (24, N'Bruce', N'NQY86DTC2HR', CAST(N'1999-12-22T00:00:00.000' AS DateTime), 4, 0, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (25, N'Good', N'HSN60DCG7UU', CAST(N'1992-08-18T00:00:00.000' AS DateTime), 2, 1, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (26, N'Cantrell', N'MJJ93IBN3OC', CAST(N'2009-04-04T00:00:00.000' AS DateTime), 2, 0, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (27, N'Strickland', N'QYZ85TRJ3RO', CAST(N'2002-04-02T00:00:00.000' AS DateTime), 1, 0, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (28, N'Huffman', N'GWE01SWL1YI', CAST(N'2003-05-26T00:00:00.000' AS DateTime), 2, 0, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (29, N'Bowman', N'HOT79FSR9GB', CAST(N'1981-06-16T00:00:00.000' AS DateTime), 3, 0, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (30, N'Walter', N'CQU26HGE0NR', CAST(N'1974-03-12T00:00:00.000' AS DateTime), 2, 0, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (31, N'Petty', N'XBM40TSN5KF', CAST(N'2003-03-29T00:00:00.000' AS DateTime), 3, 0, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (32, N'Sandoval', N'QCU15TTK4MI', CAST(N'1995-08-07T00:00:00.000' AS DateTime), 4, 0, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (33, N'Miranda', N'UUJ52RUN1BO', CAST(N'1976-04-23T00:00:00.000' AS DateTime), 2, 0, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (34, N'Silva', N'OIV47SBR5NX', CAST(N'2008-03-08T00:00:00.000' AS DateTime), 2, 0, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (35, N'Torres', N'NMW85KNB4FJ', CAST(N'2004-10-28T00:00:00.000' AS DateTime), 2, 0, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (36, N'Santiago', N'MON78TIP4WK', CAST(N'1998-05-06T00:00:00.000' AS DateTime), 4, 1, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (37, N'Sullivan', N'NFC53RLV1ZO', CAST(N'1998-01-11T00:00:00.000' AS DateTime), 3, 1, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (38, N'Baird', N'XPH76NHF7VF', CAST(N'2016-04-24T00:00:00.000' AS DateTime), 3, 1, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (39, N'Alvarez', N'WSF86YFV4XI', CAST(N'1967-11-11T00:00:00.000' AS DateTime), 2, 0, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (40, N'Mcleod', N'MBK34QSU6OD', CAST(N'1991-04-21T00:00:00.000' AS DateTime), 3, 1, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (41, N'Gamble', N'DDE28WTF8WV', CAST(N'1960-12-25T00:00:00.000' AS DateTime), 1, 1, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (42, N'Curtis', N'DVX64TNT4BP', CAST(N'2009-02-12T00:00:00.000' AS DateTime), 3, 1, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (43, N'Carver', N'SUF31JYU5IF', CAST(N'2016-08-31T00:00:00.000' AS DateTime), 2, 1, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (44, N'Cleveland', N'GES35JHS1OB', CAST(N'1987-09-12T00:00:00.000' AS DateTime), 3, 0, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (45, N'Branch', N'FPE34ELM9CC', CAST(N'1991-05-22T00:00:00.000' AS DateTime), 2, 1, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (46, N'Snider', N'XGL24LLT0GC', CAST(N'2003-03-11T00:00:00.000' AS DateTime), 4, 0, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (47, N'Cross', N'UYW07RGW6PN', CAST(N'1983-07-01T00:00:00.000' AS DateTime), 2, 1, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (48, N'Suarez', N'KOQ42PJK7OY', CAST(N'1993-04-30T00:00:00.000' AS DateTime), 4, 0, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (49, N'Harmon', N'HMJ54HJW1JH', CAST(N'1966-11-05T00:00:00.000' AS DateTime), 1, 1, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (50, N'Pruitt', N'TBU68YCH7AN', CAST(N'1994-09-28T00:00:00.000' AS DateTime), 3, 0, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (51, N'Slater', N'SKP27PGG5VM', CAST(N'1999-04-10T00:00:00.000' AS DateTime), 2, 0, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (52, N'Johnson', N'NKH55SOB8CV', CAST(N'2007-07-09T00:00:00.000' AS DateTime), 3, 0, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (53, N'Flowers', N'SRF63BAO6MJ', CAST(N'1960-11-25T00:00:00.000' AS DateTime), 3, 0, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (54, N'Douglas', N'RQJ33LUF7WU', CAST(N'2018-02-23T00:00:00.000' AS DateTime), 1, 0, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (55, N'Taylor', N'PZT87JDD2XN', CAST(N'1977-02-24T00:00:00.000' AS DateTime), 3, 0, 0, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (56, N'Madden', N'BQK36LVM7HJ', CAST(N'2023-03-18T00:00:00.000' AS DateTime), 2, 0, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (57, N'Hays', N'IAH97JZW3HU', CAST(N'2022-01-07T00:00:00.000' AS DateTime), 1, 0, 1, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (58, N'Case', N'YGP54MNG5HS', CAST(N'1984-04-30T00:00:00.000' AS DateTime), 2, 1, 1, 1)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (59, N'Fischer', N'JKJ84CST6AL', CAST(N'1965-05-10T00:00:00.000' AS DateTime), 2, 0, 0, 0)
INSERT [dbo].[Tripulante] ([id_tripulante], [nombre_tripulante], [DNI], [fecha_antiguedad], [FK_id_rango_empleado], [ES_PILOTO_NACIONAL], [ES_PILOTO_INTERN], [ES_PILOTO_CONTI]) VALUES (60, N'Roberson', N'JNH11WFV7PI', CAST(N'1964-07-07T00:00:00.000' AS DateTime), 3, 0, 0, 1)
SET IDENTITY_INSERT [dbo].[Tripulante] OFF
GO
SET IDENTITY_INSERT [dbo].[Vuelo] ON 

INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (1, CAST(N'2022-12-16' AS Date), 88, 47, 49, 42, 44)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (2, CAST(N'2022-12-04' AS Date), 88, 49, 18, 42, 20)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (3, CAST(N'2021-11-12' AS Date), 88, 59, 49, 8, 53)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (4, CAST(N'2021-08-10' AS Date), 92, 22, 19, 37, 18)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (5, CAST(N'2022-08-18' AS Date), 86, 55, 33, 32, 46)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (6, CAST(N'2022-04-11' AS Date), 87, 42, 57, 43, 49)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (7, CAST(N'2021-04-28' AS Date), 90, 22, 4, 7, 42)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (8, CAST(N'2021-08-12' AS Date), 88, 20, 16, 57, 13)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (9, CAST(N'2022-06-29' AS Date), 86, 10, 48, 18, 27)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (10, CAST(N'2022-11-06' AS Date), 93, 43, 39, 21, 2)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (11, CAST(N'2022-03-03' AS Date), 91, 7, 42, 60, 35)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (12, CAST(N'2021-11-01' AS Date), 93, 53, 3, 56, 18)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (13, CAST(N'2022-08-24' AS Date), 88, 2, 2, 51, 21)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (14, CAST(N'2023-01-12' AS Date), 88, 53, 4, 12, 56)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (15, CAST(N'2022-06-29' AS Date), 90, 29, 56, 51, 36)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (16, CAST(N'2021-09-25' AS Date), 88, 38, 39, 12, 19)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (17, CAST(N'2022-02-05' AS Date), 91, 49, 12, 24, 13)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (18, CAST(N'2023-03-01' AS Date), 88, 50, 14, 43, 19)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (19, CAST(N'2023-03-14' AS Date), 92, 20, 14, 47, 51)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (20, CAST(N'2022-12-02' AS Date), 87, 2, 45, 51, 7)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (21, CAST(N'2021-08-04' AS Date), 91, 29, 4, 32, 58)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (22, CAST(N'2022-08-31' AS Date), 87, 36, 8, 21, 39)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (23, CAST(N'2022-01-24' AS Date), 89, 57, 9, 6, 51)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (24, CAST(N'2021-06-07' AS Date), 85, 57, 50, 34, 44)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (25, CAST(N'2021-07-24' AS Date), 84, 57, 32, 39, 58)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (26, CAST(N'2023-01-08' AS Date), 92, 2, 23, 23, 28)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (27, CAST(N'2022-09-19' AS Date), 92, 31, 24, 11, 18)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (28, CAST(N'2021-10-04' AS Date), 93, 26, 9, 42, 39)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (29, CAST(N'2022-08-01' AS Date), 86, 16, 55, 40, 58)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (30, CAST(N'2023-04-23' AS Date), 90, 20, 2, 45, 51)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (31, CAST(N'2021-10-24' AS Date), 89, 10, 4, 42, 31)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (32, CAST(N'2022-09-25' AS Date), 92, 11, 45, 2, 55)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (33, CAST(N'2022-08-14' AS Date), 85, 12, 42, 7, 53)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (34, CAST(N'2021-11-13' AS Date), 90, 23, 24, 23, 59)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (35, CAST(N'2022-04-08' AS Date), 93, 30, 35, 22, 35)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (36, CAST(N'2021-07-20' AS Date), 85, 17, 25, 59, 40)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (37, CAST(N'2022-02-17' AS Date), 86, 11, 57, 30, 11)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (38, CAST(N'2021-10-05' AS Date), 91, 33, 6, 48, 56)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (39, CAST(N'2023-01-13' AS Date), 85, 21, 27, 8, 44)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (40, CAST(N'2021-08-17' AS Date), 86, 3, 44, 13, 23)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (41, CAST(N'2022-06-10' AS Date), 86, 7, 59, 6, 47)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (42, CAST(N'2021-07-08' AS Date), 94, 17, 10, 5, 13)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (43, CAST(N'2021-09-24' AS Date), 92, 28, 24, 14, 15)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (44, CAST(N'2022-11-22' AS Date), 87, 7, 21, 49, 54)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (45, CAST(N'2023-03-24' AS Date), 85, 32, 4, 47, 18)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (46, CAST(N'2022-10-05' AS Date), 89, 26, 21, 37, 15)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (47, CAST(N'2022-01-30' AS Date), 92, 43, 25, 13, 15)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (48, CAST(N'2022-01-10' AS Date), 86, 14, 4, 42, 18)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (49, CAST(N'2021-07-20' AS Date), 86, 39, 2, 53, 51)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (50, CAST(N'2021-05-08' AS Date), 89, 16, 15, 29, 27)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (51, CAST(N'2021-05-03' AS Date), 88, 37, 24, 41, 39)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (52, CAST(N'2023-04-04' AS Date), 89, 28, 21, 8, 53)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (53, CAST(N'2022-03-14' AS Date), 90, 42, 4, 12, 34)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (54, CAST(N'2022-10-25' AS Date), 86, 12, 38, 54, 8)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (55, CAST(N'2022-12-31' AS Date), 92, 59, 27, 31, 3)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (56, CAST(N'2021-08-11' AS Date), 91, 14, 30, 33, 7)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (57, CAST(N'2022-08-22' AS Date), 87, 9, 31, 28, 13)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (58, CAST(N'2022-02-14' AS Date), 93, 4, 24, 53, 16)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (59, CAST(N'2023-02-24' AS Date), 90, 23, 46, 44, 15)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (60, CAST(N'2022-09-12' AS Date), 87, 47, 18, 22, 26)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (61, CAST(N'2021-04-27' AS Date), 93, 53, 1, 1, 44)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (62, CAST(N'2021-04-27' AS Date), 88, 57, 2, 1, 27)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (63, CAST(N'2021-04-27' AS Date), 93, 40, 2, 2, 49)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (64, CAST(N'2021-04-27' AS Date), 84, 7, 2, 1, 48)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (65, CAST(N'2021-04-27' AS Date), 86, 26, 1, 2, 4)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (66, CAST(N'2021-04-27' AS Date), 86, 28, 2, 2, 26)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (67, CAST(N'2021-04-27' AS Date), 84, 17, 1, 1, 59)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (68, CAST(N'2021-04-27' AS Date), 87, 28, 1, 1, 47)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (69, CAST(N'2021-04-27' AS Date), 84, 21, 2, 2, 11)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (70, CAST(N'2021-04-27' AS Date), 90, 60, 2, 2, 30)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (71, CAST(N'2021-04-27' AS Date), 85, 41, 2, 2, 15)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (72, CAST(N'2021-04-27' AS Date), 89, 35, 2, 1, 13)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (73, CAST(N'2021-04-27' AS Date), 90, 11, 2, 1, 18)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (74, CAST(N'2021-04-27' AS Date), 87, 58, 1, 1, 6)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (75, CAST(N'2021-04-27' AS Date), 85, 18, 2, 2, 15)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (76, CAST(N'2021-04-27' AS Date), 88, 38, 2, 2, 54)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (77, CAST(N'2021-04-27' AS Date), 85, 25, 2, 1, 28)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (78, CAST(N'2021-04-27' AS Date), 87, 52, 2, 1, 10)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (79, CAST(N'2021-04-27' AS Date), 91, 32, 2, 1, 23)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (80, CAST(N'2021-04-27' AS Date), 94, 7, 1, 1, 43)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (81, CAST(N'2021-04-27' AS Date), 89, 42, 2, 2, 25)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (82, CAST(N'2021-04-27' AS Date), 86, 39, 1, 1, 11)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (83, CAST(N'2021-04-27' AS Date), 94, 26, 2, 1, 52)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (84, CAST(N'2021-04-27' AS Date), 93, 22, 2, 1, 5)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (85, CAST(N'2021-04-27' AS Date), 92, 25, 2, 2, 28)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (86, CAST(N'2021-04-27' AS Date), 86, 21, 2, 1, 30)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (87, CAST(N'2021-04-27' AS Date), 86, 30, 1, 1, 38)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (88, CAST(N'2021-04-27' AS Date), 91, 26, 1, 2, 51)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (89, CAST(N'2021-04-27' AS Date), 85, 3, 2, 1, 4)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (90, CAST(N'2021-04-27' AS Date), 86, 17, 1, 2, 29)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (91, CAST(N'2021-04-27' AS Date), 92, 10, 1, 1, 21)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (92, CAST(N'2021-04-27' AS Date), 89, 42, 2, 2, 3)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (93, CAST(N'2021-04-27' AS Date), 85, 41, 1, 1, 19)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (94, CAST(N'2021-04-27' AS Date), 87, 31, 1, 2, 13)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (95, CAST(N'2021-04-27' AS Date), 89, 31, 1, 1, 14)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (96, CAST(N'2021-04-27' AS Date), 93, 5, 1, 2, 43)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (97, CAST(N'2021-04-27' AS Date), 91, 49, 2, 1, 49)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (98, CAST(N'2021-04-27' AS Date), 94, 26, 1, 1, 28)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (99, CAST(N'2021-04-27' AS Date), 89, 22, 1, 1, 19)
GO
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (100, CAST(N'2021-04-27' AS Date), 90, 46, 1, 2, 51)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (101, CAST(N'2021-04-27' AS Date), 92, 27, 2, 1, 9)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (102, CAST(N'2021-04-27' AS Date), 86, 9, 1, 1, 33)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (103, CAST(N'2021-04-27' AS Date), 86, 54, 2, 2, 25)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (104, CAST(N'2021-04-27' AS Date), 91, 45, 1, 1, 33)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (105, CAST(N'2021-04-27' AS Date), 92, 2, 2, 1, 39)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (106, CAST(N'2021-04-27' AS Date), 85, 22, 1, 2, 51)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (107, CAST(N'2021-04-27' AS Date), 92, 40, 2, 2, 36)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (108, CAST(N'2021-04-27' AS Date), 85, 56, 2, 2, 2)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (109, CAST(N'2021-04-27' AS Date), 85, 53, 1, 2, 54)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (110, CAST(N'2021-04-27' AS Date), 89, 10, 1, 2, 6)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (111, CAST(N'2021-04-27' AS Date), 87, 10, 1, 2, 55)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (112, CAST(N'2021-04-27' AS Date), 86, 50, 2, 2, 36)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (113, CAST(N'2021-04-27' AS Date), 87, 48, 1, 2, 3)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (114, CAST(N'2021-04-27' AS Date), 86, 47, 2, 2, 20)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (115, CAST(N'2021-04-27' AS Date), 88, 3, 1, 1, 8)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (116, CAST(N'2021-04-27' AS Date), 85, 59, 1, 1, 21)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (117, CAST(N'2021-04-27' AS Date), 92, 19, 1, 2, 7)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (118, CAST(N'2021-04-27' AS Date), 92, 19, 2, 2, 50)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (119, CAST(N'2021-04-27' AS Date), 85, 55, 1, 1, 31)
INSERT [dbo].[Vuelo] ([id_vuelo], [fecha_vuelo], [FK_id_ruta], [FK_id_tripulante], [FK_id_piloto], [FK_id_copiloto], [FK_id_avion]) VALUES (120, CAST(N'2021-04-27' AS Date), 91, 59, 2, 2, 35)
SET IDENTITY_INSERT [dbo].[Vuelo] OFF
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Relacion_Clase_Vuelo_Booking] FOREIGN KEY([FK_id_clase_vuelo_booking])
REFERENCES [dbo].[Relacion_Clase_Vuelo_Booking] ([id_clase_vuelo_booking])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Relacion_Clase_Vuelo_Booking]
GO
ALTER TABLE [dbo].[Relacion_Clase_Vuelo_Booking]  WITH CHECK ADD  CONSTRAINT [FK_Relacion_Clase_Vuelo_Reserva_Clase] FOREIGN KEY([FK_id_clase])
REFERENCES [dbo].[Clase] ([id_clase])
GO
ALTER TABLE [dbo].[Relacion_Clase_Vuelo_Booking] CHECK CONSTRAINT [FK_Relacion_Clase_Vuelo_Reserva_Clase]
GO
ALTER TABLE [dbo].[Relacion_Clase_Vuelo_Booking]  WITH CHECK ADD  CONSTRAINT [FK_Relacion_Clase_Vuelo_Reserva_Vuelo] FOREIGN KEY([FK_id_vuelo])
REFERENCES [dbo].[Vuelo] ([id_vuelo])
GO
ALTER TABLE [dbo].[Relacion_Clase_Vuelo_Booking] CHECK CONSTRAINT [FK_Relacion_Clase_Vuelo_Reserva_Vuelo]
GO
ALTER TABLE [dbo].[Relacion_Copiloto]  WITH CHECK ADD  CONSTRAINT [FK_Relacion_Copiloto_Tripulante] FOREIGN KEY([FK_id_tripulante])
REFERENCES [dbo].[Tripulante] ([id_tripulante])
GO
ALTER TABLE [dbo].[Relacion_Copiloto] CHECK CONSTRAINT [FK_Relacion_Copiloto_Tripulante]
GO
ALTER TABLE [dbo].[Relacion_Piloto]  WITH CHECK ADD  CONSTRAINT [FK_Relacion_Piloto_Tripulante] FOREIGN KEY([FK_id_tripulante])
REFERENCES [dbo].[Tripulante] ([id_tripulante])
GO
ALTER TABLE [dbo].[Relacion_Piloto] CHECK CONSTRAINT [FK_Relacion_Piloto_Tripulante]
GO
ALTER TABLE [dbo].[Ruta]  WITH CHECK ADD  CONSTRAINT [FK_Ruta_Aeropuerto] FOREIGN KEY([FK_origen_id_aeropuerto])
REFERENCES [dbo].[Aeropuerto] ([id_aeropuerto])
GO
ALTER TABLE [dbo].[Ruta] CHECK CONSTRAINT [FK_Ruta_Aeropuerto]
GO
ALTER TABLE [dbo].[Ruta]  WITH CHECK ADD  CONSTRAINT [FK_Ruta_Aeropuerto1] FOREIGN KEY([FK_destino_id_Aeropuerto])
REFERENCES [dbo].[Aeropuerto] ([id_aeropuerto])
GO
ALTER TABLE [dbo].[Ruta] CHECK CONSTRAINT [FK_Ruta_Aeropuerto1]
GO
ALTER TABLE [dbo].[Tripulante]  WITH CHECK ADD  CONSTRAINT [FK_Tripulante_Rango_Empleado] FOREIGN KEY([FK_id_rango_empleado])
REFERENCES [dbo].[Rango_Empleado] ([id_rango_empleado])
GO
ALTER TABLE [dbo].[Tripulante] CHECK CONSTRAINT [FK_Tripulante_Rango_Empleado]
GO
ALTER TABLE [dbo].[Vuelo]  WITH CHECK ADD  CONSTRAINT [FK_Vuelo_Avion] FOREIGN KEY([FK_id_avion])
REFERENCES [dbo].[Avion] ([id_avion])
GO
ALTER TABLE [dbo].[Vuelo] CHECK CONSTRAINT [FK_Vuelo_Avion]
GO
ALTER TABLE [dbo].[Vuelo]  WITH CHECK ADD  CONSTRAINT [FK_Vuelo_Relacion_Copiloto] FOREIGN KEY([FK_id_copiloto])
REFERENCES [dbo].[Relacion_Copiloto] ([id_copiloto])
GO
ALTER TABLE [dbo].[Vuelo] CHECK CONSTRAINT [FK_Vuelo_Relacion_Copiloto]
GO
ALTER TABLE [dbo].[Vuelo]  WITH CHECK ADD  CONSTRAINT [FK_Vuelo_Relacion_Piloto] FOREIGN KEY([FK_id_piloto])
REFERENCES [dbo].[Relacion_Piloto] ([id_piloto])
GO
ALTER TABLE [dbo].[Vuelo] CHECK CONSTRAINT [FK_Vuelo_Relacion_Piloto]
GO
ALTER TABLE [dbo].[Vuelo]  WITH CHECK ADD  CONSTRAINT [FK_Vuelo_Ruta] FOREIGN KEY([FK_id_ruta])
REFERENCES [dbo].[Ruta] ([id_ruta])
GO
ALTER TABLE [dbo].[Vuelo] CHECK CONSTRAINT [FK_Vuelo_Ruta]
GO
ALTER TABLE [dbo].[Vuelo]  WITH CHECK ADD  CONSTRAINT [FK_Vuelo_Tripulante] FOREIGN KEY([FK_id_tripulante])
REFERENCES [dbo].[Tripulante] ([id_tripulante])
GO
ALTER TABLE [dbo].[Vuelo] CHECK CONSTRAINT [FK_Vuelo_Tripulante]
GO
USE [master]
GO
ALTER DATABASE [Toni_Aerolinia] SET  READ_WRITE 
GO
