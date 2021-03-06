USE [master]
GO
/****** Object:  Database [Toni_Biblioteca]    Script Date: 09/06/2022 10:24:28 ******/
CREATE DATABASE [Toni_Biblioteca]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Toni_Biblioteca', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Biblioteca.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Toni_Biblioteca_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Biblioteca_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Toni_Biblioteca] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Toni_Biblioteca].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Toni_Biblioteca] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET ARITHABORT OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Toni_Biblioteca] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Toni_Biblioteca] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Toni_Biblioteca] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Toni_Biblioteca] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET RECOVERY FULL 
GO
ALTER DATABASE [Toni_Biblioteca] SET  MULTI_USER 
GO
ALTER DATABASE [Toni_Biblioteca] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Toni_Biblioteca] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Toni_Biblioteca] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Toni_Biblioteca] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Toni_Biblioteca] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Toni_Biblioteca] SET QUERY_STORE = OFF
GO
USE [Toni_Biblioteca]
GO
/****** Object:  User [Toni]    Script Date: 09/06/2022 10:24:28 ******/
CREATE USER [Toni] FOR LOGIN [Toni] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Toni]
GO
/****** Object:  Table [dbo].[Alquiler]    Script Date: 09/06/2022 10:24:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alquiler](
	[IdAlquiler] [int] IDENTITY(1,1) NOT NULL,
	[Fecha_Inicio] [datetime] NULL,
	[Fecha_Devolucion] [datetime] NULL,
	[Fecha_final_lDevolucion] [datetime] NULL,
	[Demora] [int] NULL,
	[FK_Socio] [int] NULL,
 CONSTRAINT [PK_Alquiler] PRIMARY KEY CLUSTERED 
(
	[IdAlquiler] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Autor]    Script Date: 09/06/2022 10:24:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Autor](
	[ID_Autor] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Autor] [varchar](50) NULL,
	[Apellido_Autor] [varchar](50) NULL,
 CONSTRAINT [PK_Autor] PRIMARY KEY CLUSTERED 
(
	[ID_Autor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Autor@]    Script Date: 09/06/2022 10:24:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Autor@](
	[id_autor] [int] IDENTITY(1,1) NOT NULL,
	[nombre_autor] [varchar](50) NULL,
	[apellido_autor] [varbinary](50) NULL,
 CONSTRAINT [PK_Autor@] PRIMARY KEY CLUSTERED 
(
	[id_autor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estado]    Script Date: 09/06/2022 10:24:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estado](
	[ID_Estado] [int] IDENTITY(1,1) NOT NULL,
	[Tipo_Estado] [varchar](15) NULL,
 CONSTRAINT [PK_Estado] PRIMARY KEY CLUSTERED 
(
	[ID_Estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Libro]    Script Date: 09/06/2022 10:24:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Libro](
	[id_libro] [int] IDENTITY(1,1) NOT NULL,
	[código_isn] [int] NULL,
	[FK_Estado] [int] NULL,
	[FK_Obra] [int] NULL,
 CONSTRAINT [PK_Libro] PRIMARY KEY CLUSTERED 
(
	[id_libro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Obra]    Script Date: 09/06/2022 10:24:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Obra](
	[id_obra] [int] IDENTITY(1,1) NOT NULL,
	[Año_Edicion] [date] NULL,
	[Titulo] [varchar](50) NULL,
	[Editori] [varchar](50) NULL,
	[Año_Escrito] [date] NULL,
	[ISBN] [int] NULL,
 CONSTRAINT [PK_Obra] PRIMARY KEY CLUSTERED 
(
	[id_obra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Relation_Alquiler_Libro]    Script Date: 09/06/2022 10:24:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Relation_Alquiler_Libro](
	[FK_Alquiler] [int] NULL,
	[FK_Libro] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Relation_Autor_Obra]    Script Date: 09/06/2022 10:24:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Relation_Autor_Obra](
	[FK_ID_Autor] [int] NULL,
	[FK_ID_Obra] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Socio]    Script Date: 09/06/2022 10:24:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Socio](
	[id_socio] [int] IDENTITY(1,1) NOT NULL,
	[num_socio] [int] NULL,
	[Nombre_socio] [varchar](50) NULL,
	[DNI] [varchar](9) NULL,
	[Tlf] [bigint] NULL,
	[domicilo] [varchar](50) NULL,
 CONSTRAINT [PK_Socio] PRIMARY KEY CLUSTERED 
(
	[id_socio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Alquiler]  WITH CHECK ADD  CONSTRAINT [FK_Alquiler_Socio] FOREIGN KEY([FK_Socio])
REFERENCES [dbo].[Socio] ([id_socio])
GO
ALTER TABLE [dbo].[Alquiler] CHECK CONSTRAINT [FK_Alquiler_Socio]
GO
ALTER TABLE [dbo].[Libro]  WITH CHECK ADD  CONSTRAINT [FK_Libro_Estado] FOREIGN KEY([FK_Estado])
REFERENCES [dbo].[Estado] ([ID_Estado])
GO
ALTER TABLE [dbo].[Libro] CHECK CONSTRAINT [FK_Libro_Estado]
GO
ALTER TABLE [dbo].[Libro]  WITH CHECK ADD  CONSTRAINT [FK_Libro_Obra] FOREIGN KEY([FK_Obra])
REFERENCES [dbo].[Obra] ([id_obra])
GO
ALTER TABLE [dbo].[Libro] CHECK CONSTRAINT [FK_Libro_Obra]
GO
ALTER TABLE [dbo].[Relation_Alquiler_Libro]  WITH CHECK ADD  CONSTRAINT [FK_Relation_Alquiler_Libro_Alquiler] FOREIGN KEY([FK_Alquiler])
REFERENCES [dbo].[Alquiler] ([IdAlquiler])
GO
ALTER TABLE [dbo].[Relation_Alquiler_Libro] CHECK CONSTRAINT [FK_Relation_Alquiler_Libro_Alquiler]
GO
ALTER TABLE [dbo].[Relation_Alquiler_Libro]  WITH CHECK ADD  CONSTRAINT [FK_Relation_Alquiler_Libro_Libro] FOREIGN KEY([FK_Libro])
REFERENCES [dbo].[Libro] ([id_libro])
GO
ALTER TABLE [dbo].[Relation_Alquiler_Libro] CHECK CONSTRAINT [FK_Relation_Alquiler_Libro_Libro]
GO
ALTER TABLE [dbo].[Relation_Autor_Obra]  WITH CHECK ADD  CONSTRAINT [FK_Relation_Autor_Obra_Autor] FOREIGN KEY([FK_ID_Autor])
REFERENCES [dbo].[Autor] ([ID_Autor])
GO
ALTER TABLE [dbo].[Relation_Autor_Obra] CHECK CONSTRAINT [FK_Relation_Autor_Obra_Autor]
GO
ALTER TABLE [dbo].[Relation_Autor_Obra]  WITH CHECK ADD  CONSTRAINT [FK_Relation_Autor_Obra_Obra] FOREIGN KEY([FK_ID_Obra])
REFERENCES [dbo].[Obra] ([id_obra])
GO
ALTER TABLE [dbo].[Relation_Autor_Obra] CHECK CONSTRAINT [FK_Relation_Autor_Obra_Obra]
GO
USE [master]
GO
ALTER DATABASE [Toni_Biblioteca] SET  READ_WRITE 
GO
