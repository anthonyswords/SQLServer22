USE [master]
GO
/****** Object:  Database [Toni_Empresa_Limpieza]    Script Date: 09/06/2022 10:36:21 ******/
CREATE DATABASE [Toni_Empresa_Limpieza]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Toni_Empresa_Limpieza', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Empresa_Limpieza.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Toni_Empresa_Limpieza_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Empresa_Limpieza_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Toni_Empresa_Limpieza].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET ARITHABORT OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET RECOVERY FULL 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET  MULTI_USER 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET QUERY_STORE = OFF
GO
USE [Toni_Empresa_Limpieza]
GO
/****** Object:  User [Toni]    Script Date: 09/06/2022 10:36:21 ******/
CREATE USER [Toni] FOR LOGIN [Toni] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Toni]
GO
/****** Object:  Table [dbo].[Catalogo_Servicio]    Script Date: 09/06/2022 10:36:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Catalogo_Servicio](
	[id_servicio] [int] NOT NULL,
	[nombre_servicio] [varchar](50) NULL,
	[precio_por_servicio] [float] NULL,
	[tipo_Servicio] [varchar](50) NULL,
 CONSTRAINT [PK_catálogo_servicio] PRIMARY KEY CLUSTERED 
(
	[id_servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 09/06/2022 10:36:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[ID_cliente] [int] NOT NULL,
	[NIF_cliente] [varchar](9) NOT NULL,
	[nombre_cliente] [varchar](50) NOT NULL,
	[apellido_cliente] [varchar](50) NOT NULL,
	[domicilio_cliente] [varchar](50) NOT NULL,
	[profesion_cliente] [varchar](50) NOT NULL,
	[telefono_cliente] [bigint] NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[ID_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 09/06/2022 10:36:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[nº_empleado] [int] NOT NULL,
	[NIF_empleado] [varchar](9) NOT NULL,
	[nombre_empleado] [varchar](50) NOT NULL,
	[apellido_empleado] [varchar](50) NOT NULL,
	[telefono_empleado] [bigint] NOT NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[nº_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Factura]    Script Date: 09/06/2022 10:36:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Factura](
	[ID_factura] [int] NOT NULL,
	[NumeroFactura] [int] NOT NULL,
	[FechaFactura] [date] NOT NULL,
	[FechaCobro] [date] NOT NULL,
	[Mes] [varchar](50) NOT NULL,
	[Importe] [float] NOT NULL,
	[FK_idCliente] [int] NOT NULL,
	[FK_IdSuscripcion] [int] NOT NULL,
	[Año] [int] NOT NULL,
 CONSTRAINT [PK_Factura] PRIMARY KEY CLUSTERED 
(
	[ID_factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suscripción]    Script Date: 09/06/2022 10:36:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suscripción](
	[ID_Suscripcion] [int] IDENTITY(1,1) NOT NULL,
	[Vigencia] [varchar](50) NOT NULL,
	[Periodo] [int] NOT NULL,
	[FK_IdCliente] [int] NOT NULL,
	[FK_idServicio] [int] NOT NULL,
 CONSTRAINT [PK_Suscripción] PRIMARY KEY CLUSTERED 
(
	[ID_Suscripcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Visita]    Script Date: 09/06/2022 10:36:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Visita](
	[ID_visitas] [int] IDENTITY(1,1) NOT NULL,
	[FechaVisita] [date] NOT NULL,
	[FK_ID_empleado] [int] NOT NULL,
	[FK_idSuscripcion] [int] NOT NULL,
 CONSTRAINT [PK_Visita] PRIMARY KEY CLUSTERED 
(
	[ID_visitas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_Cliente1] FOREIGN KEY([FK_idCliente])
REFERENCES [dbo].[Cliente] ([ID_cliente])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_Factura_Cliente1]
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_Suscripción] FOREIGN KEY([FK_IdSuscripcion])
REFERENCES [dbo].[Suscripción] ([ID_Suscripcion])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_Factura_Suscripción]
GO
ALTER TABLE [dbo].[Suscripción]  WITH CHECK ADD  CONSTRAINT [FK_Suscripción_Catalogo_Servicio] FOREIGN KEY([FK_idServicio])
REFERENCES [dbo].[Catalogo_Servicio] ([id_servicio])
GO
ALTER TABLE [dbo].[Suscripción] CHECK CONSTRAINT [FK_Suscripción_Catalogo_Servicio]
GO
ALTER TABLE [dbo].[Suscripción]  WITH CHECK ADD  CONSTRAINT [FK_Suscripción_Cliente] FOREIGN KEY([FK_IdCliente])
REFERENCES [dbo].[Cliente] ([ID_cliente])
GO
ALTER TABLE [dbo].[Suscripción] CHECK CONSTRAINT [FK_Suscripción_Cliente]
GO
ALTER TABLE [dbo].[Visita]  WITH CHECK ADD  CONSTRAINT [FK_Visita_Empleado] FOREIGN KEY([FK_ID_empleado])
REFERENCES [dbo].[Empleado] ([nº_empleado])
GO
ALTER TABLE [dbo].[Visita] CHECK CONSTRAINT [FK_Visita_Empleado]
GO
ALTER TABLE [dbo].[Visita]  WITH CHECK ADD  CONSTRAINT [FK_Visita_Suscripción] FOREIGN KEY([FK_idSuscripcion])
REFERENCES [dbo].[Suscripción] ([ID_Suscripcion])
GO
ALTER TABLE [dbo].[Visita] CHECK CONSTRAINT [FK_Visita_Suscripción]
GO
USE [master]
GO
ALTER DATABASE [Toni_Empresa_Limpieza] SET  READ_WRITE 
GO
