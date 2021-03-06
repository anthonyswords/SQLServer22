USE [master]
GO
/****** Object:  Database [Toni_Cinema]    Script Date: 09/06/2022 10:29:48 ******/
CREATE DATABASE [Toni_Cinema]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Toni_Cinema', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Cinema.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Toni_Cinema_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Cinema_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Toni_Cinema] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Toni_Cinema].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Toni_Cinema] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Toni_Cinema] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Toni_Cinema] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Toni_Cinema] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Toni_Cinema] SET ARITHABORT OFF 
GO
ALTER DATABASE [Toni_Cinema] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Toni_Cinema] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Toni_Cinema] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Toni_Cinema] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Toni_Cinema] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Toni_Cinema] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Toni_Cinema] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Toni_Cinema] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Toni_Cinema] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Toni_Cinema] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Toni_Cinema] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Toni_Cinema] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Toni_Cinema] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Toni_Cinema] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Toni_Cinema] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Toni_Cinema] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Toni_Cinema] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Toni_Cinema] SET RECOVERY FULL 
GO
ALTER DATABASE [Toni_Cinema] SET  MULTI_USER 
GO
ALTER DATABASE [Toni_Cinema] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Toni_Cinema] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Toni_Cinema] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Toni_Cinema] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Toni_Cinema] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Toni_Cinema] SET QUERY_STORE = OFF
GO
USE [Toni_Cinema]
GO
/****** Object:  User [Toni]    Script Date: 09/06/2022 10:29:48 ******/
CREATE USER [Toni] FOR LOGIN [Toni] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Toni]
GO
/****** Object:  Table [dbo].[PELICULAS]    Script Date: 09/06/2022 10:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PELICULAS](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NULL,
	[CalificacionEdad] [int] NULL,
 CONSTRAINT [CodigoPeli_PK] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALAS]    Script Date: 09/06/2022 10:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALAS](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NULL,
	[Pelicula] [int] NULL,
 CONSTRAINT [Codigo_Salas_FK] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[PeliculaNumSala]    Script Date: 09/06/2022 10:29:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[PeliculaNumSala](@limit int)
RETURNS TABLE
AS
RETURN
(

	SELECT PELICULAS.Nombre as film, count(SALAS.Nombre) as cinema_room FROM SALAS
		RIGHT JOIN PELICULAS
		ON SALAS.Pelicula = PELICULAS.Codigo
		WHERE PELICULAS.CalificacionEdad=@limit
	GROUP BY PELICULAS.Nombre, PELICULAS.Codigo
);
GO
SET IDENTITY_INSERT [dbo].[PELICULAS] ON 

INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (1, N'Lobo de Wall Street', 16)
INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (2, N'El Bueno, el feo y el malo', 7)
INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (3, N'Y se armó la gorda', 7)
INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (4, N'Rambo', 16)
INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (5, N'Rambo II', 13)
INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (6, N'Rambo III', 16)
INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (7, N'Rocky I', 7)
INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (8, N'Rocky II', 7)
INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (9, N'Rocky III', 7)
INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (10, N'Rocky IV', 18)
INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (11, N'Rocky IV', 13)
INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (12, N'Rocky V', 0)
INSERT [dbo].[PELICULAS] ([Codigo], [Nombre], [CalificacionEdad]) VALUES (13, N'Uno, dos, tres', 7)
SET IDENTITY_INSERT [dbo].[PELICULAS] OFF
GO
SET IDENTITY_INSERT [dbo].[SALAS] ON 

INSERT [dbo].[SALAS] ([Codigo], [Nombre], [Pelicula]) VALUES (1, N'Yelmo Cast 1', 1)
INSERT [dbo].[SALAS] ([Codigo], [Nombre], [Pelicula]) VALUES (2, N'Yelmo Cast 2', 2)
INSERT [dbo].[SALAS] ([Codigo], [Nombre], [Pelicula]) VALUES (3, N'Yelmo Cast 3', 5)
INSERT [dbo].[SALAS] ([Codigo], [Nombre], [Pelicula]) VALUES (4, N'Yelmo Cast 4', 5)
INSERT [dbo].[SALAS] ([Codigo], [Nombre], [Pelicula]) VALUES (5, N'Yelmo Cast 5', 5)
INSERT [dbo].[SALAS] ([Codigo], [Nombre], [Pelicula]) VALUES (6, N'Yamagushi 1', 4)
INSERT [dbo].[SALAS] ([Codigo], [Nombre], [Pelicula]) VALUES (7, N'Yamagushi 2', 4)
INSERT [dbo].[SALAS] ([Codigo], [Nombre], [Pelicula]) VALUES (8, N'Yamagushi 3', 9)
INSERT [dbo].[SALAS] ([Codigo], [Nombre], [Pelicula]) VALUES (9, N'Yamagushi 4', 9)
INSERT [dbo].[SALAS] ([Codigo], [Nombre], [Pelicula]) VALUES (10, N'Yamagushi 5', 9)
INSERT [dbo].[SALAS] ([Codigo], [Nombre], [Pelicula]) VALUES (11, N'Yamagushi 6', 10)
INSERT [dbo].[SALAS] ([Codigo], [Nombre], [Pelicula]) VALUES (12, N'Yamagushi 7', NULL)
SET IDENTITY_INSERT [dbo].[SALAS] OFF
GO
ALTER TABLE [dbo].[SALAS]  WITH CHECK ADD  CONSTRAINT [CodigoPeli_FK] FOREIGN KEY([Pelicula])
REFERENCES [dbo].[PELICULAS] ([Codigo])
GO
ALTER TABLE [dbo].[SALAS] CHECK CONSTRAINT [CodigoPeli_FK]
GO
USE [master]
GO
ALTER DATABASE [Toni_Cinema] SET  READ_WRITE 
GO
