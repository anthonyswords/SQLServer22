USE [master]
GO
/****** Object:  Database [Toni_Videoclub]    Script Date: 09/06/2022 10:49:12 ******/
CREATE DATABASE [Toni_Videoclub]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Toni_videoclub', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_videoclub.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Toni_videoclub_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_videoclub_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Toni_Videoclub] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Toni_Videoclub].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Toni_Videoclub] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET ARITHABORT OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Toni_Videoclub] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Toni_Videoclub] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Toni_Videoclub] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Toni_Videoclub] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET RECOVERY FULL 
GO
ALTER DATABASE [Toni_Videoclub] SET  MULTI_USER 
GO
ALTER DATABASE [Toni_Videoclub] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Toni_Videoclub] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Toni_Videoclub] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Toni_Videoclub] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Toni_Videoclub] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Toni_Videoclub] SET QUERY_STORE = OFF
GO
USE [Toni_Videoclub]
GO
/****** Object:  User [Toni]    Script Date: 09/06/2022 10:49:13 ******/
CREATE USER [Toni] FOR LOGIN [Toni] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Toni]
GO
/****** Object:  Table [dbo].[Actor]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actor](
	[id_actor] [int] IDENTITY(1,1) NOT NULL,
	[nombre_actor] [varchar](50) NULL,
	[apellido_actor] [varchar](50) NULL,
	[pais_origen] [varchar](50) NULL,
	[fecha_nacimiento] [date] NULL,
 CONSTRAINT [PK_Actor] PRIMARY KEY CLUSTERED 
(
	[id_actor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Alquiler]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alquiler](
	[id_alquiler] [int] IDENTITY(1,1) NOT NULL,
	[fecha_devolucion] [date] NULL,
	[fecha_alquiler] [date] NULL,
	[precio_total] [decimal](18, 0) NULL,
	[fecha_limite] [date] NULL,
	[recargo] [decimal](18, 0) NULL,
	[FK_id_cliente] [int] NOT NULL,
	[FK_id_empleado] [int] NOT NULL,
 CONSTRAINT [PK_Alquiler] PRIMARY KEY CLUSTERED 
(
	[id_alquiler] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[alquiler_disco]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[alquiler_disco](
	[FK_n_serie] [int] NOT NULL,
	[FK_id_alquiler] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[idCliente] [int] IDENTITY(1,1) NOT NULL,
	[NombreCliente] [varchar](50) NOT NULL,
	[ApellidoCliente] [varchar](50) NULL,
	[DNI] [char](9) NOT NULL,
	[Telefono] [varchar](10) NOT NULL,
	[Direccion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Director]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Director](
	[id_director] [int] IDENTITY(1,1) NOT NULL,
	[nombre_director] [varchar](50) NULL,
	[pais_origen] [varchar](50) NULL,
	[apellido_director] [varchar](50) NULL,
	[fecha_nacimiento] [date] NULL,
 CONSTRAINT [PK_Director] PRIMARY KEY CLUSTERED 
(
	[id_director] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Disco]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Disco](
	[n_serie] [int] IDENTITY(1,1) NOT NULL,
	[numeros_disco] [int] NULL,
 CONSTRAINT [PK_Disco] PRIMARY KEY CLUSTERED 
(
	[n_serie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[disco_formato]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[disco_formato](
	[FK_n_serie] [int] NOT NULL,
	[FK_id_formato] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[id_empleado] [int] IDENTITY(1,1) NOT NULL,
	[NombreEmpleado] [varchar](50) NOT NULL,
	[ApellidoEmpleado] [varchar](50) NULL,
	[Contrato] [varchar](50) NOT NULL,
	[Fecha_ingreso] [date] NOT NULL,
	[Fecha_finalizacion] [date] NULL,
	[DNI] [char](9) NOT NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[id_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Formato]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Formato](
	[id_formato] [int] NOT NULL,
	[formato_disco] [varchar](50) NULL,
 CONSTRAINT [PK_Formato] PRIMARY KEY CLUSTERED 
(
	[id_formato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genero]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genero](
	[genero] [varchar](50) NULL,
	[id_genero] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Genero] PRIMARY KEY CLUSTERED 
(
	[id_genero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Idioma]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idioma](
	[idioma] [varchar](50) NULL,
	[id_idioma] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Idioma] PRIMARY KEY CLUSTERED 
(
	[id_idioma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Novedad]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Novedad](
	[id_novedad] [int] NOT NULL,
	[fecha_estreno] [date] NULL,
 CONSTRAINT [PK_Novedad] PRIMARY KEY CLUSTERED 
(
	[id_novedad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Obra]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Obra](
	[id_pelicula] [int] IDENTITY(1,1) NOT NULL,
	[nombre_pelicula] [varchar](50) NOT NULL,
	[FK_id_director] [int] NULL,
 CONSTRAINT [PK_Obra_1] PRIMARY KEY CLUSTERED 
(
	[id_pelicula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[obra_actor]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obra_actor](
	[FK_id_actor] [int] NULL,
	[FK_id_pelicula] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[obra_genero]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obra_genero](
	[FK_id_genero] [int] NULL,
	[FK_id_pelicula] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[obra_idioma]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obra_idioma](
	[FK_id_idioma] [int] NOT NULL,
	[FK_id_pelicula] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[obra_novedad]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obra_novedad](
	[FK_id_novedad] [int] NOT NULL,
	[FK_id_pelicula] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tarifa]    Script Date: 09/06/2022 10:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tarifa](
	[FK_id_formato] [int] NOT NULL,
	[FK_id_novedad] [int] NOT NULL,
	[precio] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Actor] ON 

INSERT [dbo].[Actor] ([id_actor], [nombre_actor], [apellido_actor], [pais_origen], [fecha_nacimiento]) VALUES (1, N'Leonardo', N'DiCaprio', N'Reino Unido', CAST(N'1974-11-11' AS Date))
SET IDENTITY_INSERT [dbo].[Actor] OFF
GO
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([idCliente], [NombreCliente], [ApellidoCliente], [DNI], [Telefono], [Direccion]) VALUES (1, N'Marc', NULL, N'12345678A', N'111222333', N'Carrer dels horts')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
GO
SET IDENTITY_INSERT [dbo].[Director] ON 

INSERT [dbo].[Director] ([id_director], [nombre_director], [pais_origen], [apellido_director], [fecha_nacimiento]) VALUES (1, N'NUChristopher', N'Reino Unido', N'Nolan', NULL)
SET IDENTITY_INSERT [dbo].[Director] OFF
GO
SET IDENTITY_INSERT [dbo].[Disco] ON 

INSERT [dbo].[Disco] ([n_serie], [numeros_disco]) VALUES (1, 120)
INSERT [dbo].[Disco] ([n_serie], [numeros_disco]) VALUES (2, 50)
INSERT [dbo].[Disco] ([n_serie], [numeros_disco]) VALUES (3, 35)
INSERT [dbo].[Disco] ([n_serie], [numeros_disco]) VALUES (4, 2)
INSERT [dbo].[Disco] ([n_serie], [numeros_disco]) VALUES (5, 15)
SET IDENTITY_INSERT [dbo].[Disco] OFF
GO
INSERT [dbo].[Formato] ([id_formato], [formato_disco]) VALUES (1, N'DVD')
INSERT [dbo].[Formato] ([id_formato], [formato_disco]) VALUES (2, N'VHS')
INSERT [dbo].[Formato] ([id_formato], [formato_disco]) VALUES (3, N'Blueray')
GO
ALTER TABLE [dbo].[Alquiler]  WITH CHECK ADD  CONSTRAINT [FK_Alquiler_Cliente] FOREIGN KEY([FK_id_cliente])
REFERENCES [dbo].[Cliente] ([idCliente])
GO
ALTER TABLE [dbo].[Alquiler] CHECK CONSTRAINT [FK_Alquiler_Cliente]
GO
ALTER TABLE [dbo].[Alquiler]  WITH CHECK ADD  CONSTRAINT [FK_Alquiler_Empleado] FOREIGN KEY([FK_id_empleado])
REFERENCES [dbo].[Empleado] ([id_empleado])
GO
ALTER TABLE [dbo].[Alquiler] CHECK CONSTRAINT [FK_Alquiler_Empleado]
GO
ALTER TABLE [dbo].[alquiler_disco]  WITH CHECK ADD  CONSTRAINT [FK_alquiler_disco_Alquiler] FOREIGN KEY([FK_id_alquiler])
REFERENCES [dbo].[Alquiler] ([id_alquiler])
GO
ALTER TABLE [dbo].[alquiler_disco] CHECK CONSTRAINT [FK_alquiler_disco_Alquiler]
GO
ALTER TABLE [dbo].[alquiler_disco]  WITH CHECK ADD  CONSTRAINT [FK_alquiler_disco_Disco] FOREIGN KEY([FK_n_serie])
REFERENCES [dbo].[Disco] ([n_serie])
GO
ALTER TABLE [dbo].[alquiler_disco] CHECK CONSTRAINT [FK_alquiler_disco_Disco]
GO
ALTER TABLE [dbo].[disco_formato]  WITH CHECK ADD  CONSTRAINT [FK_disco_formato_Disco] FOREIGN KEY([FK_n_serie])
REFERENCES [dbo].[Disco] ([n_serie])
GO
ALTER TABLE [dbo].[disco_formato] CHECK CONSTRAINT [FK_disco_formato_Disco]
GO
ALTER TABLE [dbo].[disco_formato]  WITH CHECK ADD  CONSTRAINT [FK_disco_formato_Formato] FOREIGN KEY([FK_id_formato])
REFERENCES [dbo].[Formato] ([id_formato])
GO
ALTER TABLE [dbo].[disco_formato] CHECK CONSTRAINT [FK_disco_formato_Formato]
GO
ALTER TABLE [dbo].[Obra]  WITH CHECK ADD  CONSTRAINT [FK_Obra_Director] FOREIGN KEY([FK_id_director])
REFERENCES [dbo].[Director] ([id_director])
GO
ALTER TABLE [dbo].[Obra] CHECK CONSTRAINT [FK_Obra_Director]
GO
ALTER TABLE [dbo].[obra_actor]  WITH CHECK ADD  CONSTRAINT [FK_obra_actor_Actor] FOREIGN KEY([FK_id_actor])
REFERENCES [dbo].[Actor] ([id_actor])
GO
ALTER TABLE [dbo].[obra_actor] CHECK CONSTRAINT [FK_obra_actor_Actor]
GO
ALTER TABLE [dbo].[obra_actor]  WITH CHECK ADD  CONSTRAINT [FK_obra_actor_Obra] FOREIGN KEY([FK_id_pelicula])
REFERENCES [dbo].[Obra] ([id_pelicula])
GO
ALTER TABLE [dbo].[obra_actor] CHECK CONSTRAINT [FK_obra_actor_Obra]
GO
ALTER TABLE [dbo].[obra_genero]  WITH CHECK ADD  CONSTRAINT [FK_obra_genero_Genero] FOREIGN KEY([FK_id_genero])
REFERENCES [dbo].[Genero] ([id_genero])
GO
ALTER TABLE [dbo].[obra_genero] CHECK CONSTRAINT [FK_obra_genero_Genero]
GO
ALTER TABLE [dbo].[obra_genero]  WITH CHECK ADD  CONSTRAINT [FK_obra_genero_Obra] FOREIGN KEY([FK_id_pelicula])
REFERENCES [dbo].[Obra] ([id_pelicula])
GO
ALTER TABLE [dbo].[obra_genero] CHECK CONSTRAINT [FK_obra_genero_Obra]
GO
ALTER TABLE [dbo].[obra_idioma]  WITH CHECK ADD  CONSTRAINT [FK_obra_idioma_Idioma] FOREIGN KEY([FK_id_idioma])
REFERENCES [dbo].[Idioma] ([id_idioma])
GO
ALTER TABLE [dbo].[obra_idioma] CHECK CONSTRAINT [FK_obra_idioma_Idioma]
GO
ALTER TABLE [dbo].[obra_idioma]  WITH CHECK ADD  CONSTRAINT [FK_obra_idioma_Obra] FOREIGN KEY([FK_id_pelicula])
REFERENCES [dbo].[Obra] ([id_pelicula])
GO
ALTER TABLE [dbo].[obra_idioma] CHECK CONSTRAINT [FK_obra_idioma_Obra]
GO
ALTER TABLE [dbo].[obra_novedad]  WITH CHECK ADD  CONSTRAINT [FK_obra_novedad_Novedad] FOREIGN KEY([FK_id_novedad])
REFERENCES [dbo].[Novedad] ([id_novedad])
GO
ALTER TABLE [dbo].[obra_novedad] CHECK CONSTRAINT [FK_obra_novedad_Novedad]
GO
ALTER TABLE [dbo].[obra_novedad]  WITH CHECK ADD  CONSTRAINT [FK_obra_novedad_Obra] FOREIGN KEY([FK_id_pelicula])
REFERENCES [dbo].[Obra] ([id_pelicula])
GO
ALTER TABLE [dbo].[obra_novedad] CHECK CONSTRAINT [FK_obra_novedad_Obra]
GO
ALTER TABLE [dbo].[tarifa]  WITH CHECK ADD  CONSTRAINT [FK_tarifa_Formato] FOREIGN KEY([FK_id_formato])
REFERENCES [dbo].[Formato] ([id_formato])
GO
ALTER TABLE [dbo].[tarifa] CHECK CONSTRAINT [FK_tarifa_Formato]
GO
ALTER TABLE [dbo].[tarifa]  WITH CHECK ADD  CONSTRAINT [FK_tarifa_Novedad] FOREIGN KEY([FK_id_novedad])
REFERENCES [dbo].[Novedad] ([id_novedad])
GO
ALTER TABLE [dbo].[tarifa] CHECK CONSTRAINT [FK_tarifa_Novedad]
GO
USE [master]
GO
ALTER DATABASE [Toni_Videoclub] SET  READ_WRITE 
GO
