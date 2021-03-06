USE [master]
GO
/****** Object:  Database [Toni_Fusball]    Script Date: 09/06/2022 10:38:19 ******/
CREATE DATABASE [Toni_Fusball]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Toni_Fusball', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Fusball.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Toni_Fusball_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Fusball_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Toni_Fusball] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Toni_Fusball].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Toni_Fusball] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Toni_Fusball] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Toni_Fusball] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Toni_Fusball] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Toni_Fusball] SET ARITHABORT OFF 
GO
ALTER DATABASE [Toni_Fusball] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Toni_Fusball] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Toni_Fusball] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Toni_Fusball] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Toni_Fusball] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Toni_Fusball] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Toni_Fusball] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Toni_Fusball] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Toni_Fusball] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Toni_Fusball] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Toni_Fusball] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Toni_Fusball] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Toni_Fusball] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Toni_Fusball] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Toni_Fusball] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Toni_Fusball] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Toni_Fusball] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Toni_Fusball] SET RECOVERY FULL 
GO
ALTER DATABASE [Toni_Fusball] SET  MULTI_USER 
GO
ALTER DATABASE [Toni_Fusball] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Toni_Fusball] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Toni_Fusball] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Toni_Fusball] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Toni_Fusball] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Toni_Fusball] SET QUERY_STORE = OFF
GO
USE [Toni_Fusball]
GO
/****** Object:  User [Toni]    Script Date: 09/06/2022 10:38:19 ******/
CREATE USER [Toni] FOR LOGIN [Toni] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Toni]
GO
/****** Object:  Table [dbo].[Arbitros]    Script Date: 09/06/2022 10:38:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Arbitros](
	[IdArbitros] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[NumeroDeArbitro] [varchar](12) NOT NULL,
	[Tipo] [varchar](10) NOT NULL,
	[RidArbitro] [int] NOT NULL,
	[RidArbitroLinea1] [int] NOT NULL,
	[RidArbitroLinea2] [int] NOT NULL,
	[RidCuartoArbitro] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdArbitros] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipo]    Script Date: 09/06/2022 10:38:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipo](
	[IdEquipo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Telefono1] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IncidenciaJugador]    Script Date: 09/06/2022 10:38:19 ******/
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
/****** Object:  Table [dbo].[IncidenciaPartido]    Script Date: 09/06/2022 10:38:19 ******/
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
/****** Object:  Table [dbo].[IncidendciaJugador]    Script Date: 09/06/2022 10:38:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncidendciaJugador](
	[IdIncidenciaJugador] [int] IDENTITY(1,1) NOT NULL,
	[NumTotalGoles] [int] NOT NULL,
	[NumTotalDeAmarillas] [int] NOT NULL,
	[NumTotalDeRojas] [int] NOT NULL,
	[NumTotalFaltas] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdIncidenciaJugador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jugador]    Script Date: 09/06/2022 10:38:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jugador](
	[IdJugador] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Edad] [int] NULL,
	[Nacionalidad] [varchar](30) NULL,
	[NumFicha] [char](10) NULL,
	[RidEquipo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdJugador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partido]    Script Date: 09/06/2022 10:38:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partido](
	[IdPartido] [int] IDENTITY(1,1) NOT NULL,
	[Jornada] [nchar](2) NOT NULL,
	[Fecha] [date] NOT NULL,
	[Estadio] [varchar](50) NOT NULL,
	[Ciudad] [varchar](50) NOT NULL,
	[RidEquipo] [int] NOT NULL,
 CONSTRAINT [PK__Partido__6ED660F9267BA16D] PRIMARY KEY CLUSTERED 
(
	[IdPartido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IncidenciaJugador]  WITH CHECK ADD  CONSTRAINT [FK_JugadorIncidenciaJugador] FOREIGN KEY([RidJugador])
REFERENCES [dbo].[Jugador] ([IdJugador])
GO
ALTER TABLE [dbo].[IncidenciaJugador] CHECK CONSTRAINT [FK_JugadorIncidenciaJugador]
GO
ALTER TABLE [dbo].[IncidenciaPartido]  WITH CHECK ADD  CONSTRAINT [FK_PartidoIncidenciaPartido] FOREIGN KEY([RidPartido])
REFERENCES [dbo].[Partido] ([IdPartido])
GO
ALTER TABLE [dbo].[IncidenciaPartido] CHECK CONSTRAINT [FK_PartidoIncidenciaPartido]
GO
ALTER TABLE [dbo].[Jugador]  WITH CHECK ADD  CONSTRAINT [FK_JugadorEquipo] FOREIGN KEY([RidEquipo])
REFERENCES [dbo].[Equipo] ([IdEquipo])
GO
ALTER TABLE [dbo].[Jugador] CHECK CONSTRAINT [FK_JugadorEquipo]
GO
ALTER TABLE [dbo].[Partido]  WITH CHECK ADD  CONSTRAINT [FK__Partido__RidEqui__4E53A1AA] FOREIGN KEY([RidEquipo])
REFERENCES [dbo].[Equipo] ([IdEquipo])
GO
ALTER TABLE [dbo].[Partido] CHECK CONSTRAINT [FK__Partido__RidEqui__4E53A1AA]
GO
USE [master]
GO
ALTER DATABASE [Toni_Fusball] SET  READ_WRITE 
GO
