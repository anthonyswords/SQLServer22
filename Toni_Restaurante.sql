USE [master]
GO
/****** Object:  Database [Toni_Restaurante]    Script Date: 09/06/2022 10:45:27 ******/
CREATE DATABASE [Toni_Restaurante]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Toni_Restaurante', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Restaurante.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Toni_Restaurante_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Restaurante_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Toni_Restaurante] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Toni_Restaurante].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Toni_Restaurante] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET ARITHABORT OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Toni_Restaurante] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Toni_Restaurante] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Toni_Restaurante] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Toni_Restaurante] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET RECOVERY FULL 
GO
ALTER DATABASE [Toni_Restaurante] SET  MULTI_USER 
GO
ALTER DATABASE [Toni_Restaurante] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Toni_Restaurante] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Toni_Restaurante] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Toni_Restaurante] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Toni_Restaurante] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Toni_Restaurante] SET QUERY_STORE = OFF
GO
USE [Toni_Restaurante]
GO
/****** Object:  User [Toni]    Script Date: 09/06/2022 10:45:27 ******/
CREATE USER [Toni] FOR LOGIN [Toni] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Toni]
GO
/****** Object:  Table [dbo].[Almacen]    Script Date: 09/06/2022 10:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Almacen](
	[id_almacen] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[nombre_almacen] [varchar](50) NOT NULL,
	[num_almacen] [int] NOT NULL,
 CONSTRAINT [PK_Almacen] PRIMARY KEY CLUSTERED 
(
	[id_almacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cocinero]    Script Date: 09/06/2022 10:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cocinero](
	[id_cocinero] [int] IDENTITY(1,1) NOT NULL,
	[AñoServicio] [date] NOT NULL,
 CONSTRAINT [PK_Cocinero] PRIMARY KEY CLUSTERED 
(
	[id_cocinero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 09/06/2022 10:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[Nombre] [varchar](50) NOT NULL,
	[Apellidos] [varchar](50) NOT NULL,
	[Num_ss] [varchar](50) NOT NULL,
	[tlf_fijo] [bigint] NULL,
	[tlf_movil] [bigint] NULL,
	[id_empleado] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[id_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpleadoPincheCocinero]    Script Date: 09/06/2022 10:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpleadoPincheCocinero](
	[id_empleado] [int] NOT NULL,
	[id_cocinero] [int] NOT NULL,
	[id_pinche] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estanteria]    Script Date: 09/06/2022 10:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estanteria](
	[id_estanteria] [int] IDENTITY(1,1) NOT NULL,
	[letra1] [varchar](1) NOT NULL,
	[letra2] [varchar](1) NOT NULL,
	[tamaño_cm] [float] NOT NULL,
	[id_almacen] [int] NOT NULL,
 CONSTRAINT [PK_Estanteria] PRIMARY KEY CLUSTERED 
(
	[id_estanteria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingrediente]    Script Date: 09/06/2022 10:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingrediente](
	[id_ingrediente] [int] IDENTITY(1,1) NOT NULL,
	[nombre_ingrediente] [varchar](50) NOT NULL,
	[cantidad_stock] [int] NOT NULL,
	[id_estanteria] [int] NOT NULL,
 CONSTRAINT [PK_Ingrediente] PRIMARY KEY CLUSTERED 
(
	[id_ingrediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pinche]    Script Date: 09/06/2022 10:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pinche](
	[id_pinche] [int] IDENTITY(1,1) NOT NULL,
	[Fecha_nacimiento] [date] NOT NULL,
	[id_cocinero] [int] NOT NULL,
 CONSTRAINT [PK_Pinche] PRIMARY KEY CLUSTERED 
(
	[id_pinche] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plato]    Script Date: 09/06/2022 10:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plato](
	[id_plato] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_plato] [varchar](50) NOT NULL,
	[Precio_plato] [varchar](50) NOT NULL,
	[id_tipoplato] [int] NOT NULL,
 CONSTRAINT [PK_Plato] PRIMARY KEY CLUSTERED 
(
	[id_plato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelacionCocineroPlato]    Script Date: 09/06/2022 10:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelacionCocineroPlato](
	[id_cocinero] [int] NULL,
	[id_plato] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelacionPlatoIngrediente]    Script Date: 09/06/2022 10:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelacionPlatoIngrediente](
	[id_plato] [int] NOT NULL,
	[id_ingrediente] [int] NOT NULL,
	[cantidad_ingrediente_plato] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipo_de_Plato]    Script Date: 09/06/2022 10:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_de_Plato](
	[id_tipoplato] [int] IDENTITY(1,1) NOT NULL,
	[tipo_plato] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Tipo_de_Plato] PRIMARY KEY CLUSTERED 
(
	[id_tipoplato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmpleadoPincheCocinero]  WITH CHECK ADD  CONSTRAINT [FK_EmpleadoPincheCocinero_Cocinero] FOREIGN KEY([id_cocinero])
REFERENCES [dbo].[Cocinero] ([id_cocinero])
GO
ALTER TABLE [dbo].[EmpleadoPincheCocinero] CHECK CONSTRAINT [FK_EmpleadoPincheCocinero_Cocinero]
GO
ALTER TABLE [dbo].[EmpleadoPincheCocinero]  WITH CHECK ADD  CONSTRAINT [FK_EmpleadoPincheCocinero_Empleado] FOREIGN KEY([id_empleado])
REFERENCES [dbo].[Empleado] ([id_empleado])
GO
ALTER TABLE [dbo].[EmpleadoPincheCocinero] CHECK CONSTRAINT [FK_EmpleadoPincheCocinero_Empleado]
GO
ALTER TABLE [dbo].[EmpleadoPincheCocinero]  WITH CHECK ADD  CONSTRAINT [FK_EmpleadoPincheCocinero_Pinche] FOREIGN KEY([id_cocinero])
REFERENCES [dbo].[Pinche] ([id_pinche])
GO
ALTER TABLE [dbo].[EmpleadoPincheCocinero] CHECK CONSTRAINT [FK_EmpleadoPincheCocinero_Pinche]
GO
ALTER TABLE [dbo].[Estanteria]  WITH CHECK ADD  CONSTRAINT [FK_Estanteria_Almacen] FOREIGN KEY([id_almacen])
REFERENCES [dbo].[Almacen] ([id_almacen])
GO
ALTER TABLE [dbo].[Estanteria] CHECK CONSTRAINT [FK_Estanteria_Almacen]
GO
ALTER TABLE [dbo].[Ingrediente]  WITH CHECK ADD  CONSTRAINT [FK_Ingrediente_Estanteria] FOREIGN KEY([id_estanteria])
REFERENCES [dbo].[Estanteria] ([id_estanteria])
GO
ALTER TABLE [dbo].[Ingrediente] CHECK CONSTRAINT [FK_Ingrediente_Estanteria]
GO
ALTER TABLE [dbo].[Pinche]  WITH CHECK ADD  CONSTRAINT [FK_Pinche_Cocinero] FOREIGN KEY([id_cocinero])
REFERENCES [dbo].[Cocinero] ([id_cocinero])
GO
ALTER TABLE [dbo].[Pinche] CHECK CONSTRAINT [FK_Pinche_Cocinero]
GO
ALTER TABLE [dbo].[Plato]  WITH CHECK ADD  CONSTRAINT [FK_Plato_Tipo_de_Plato] FOREIGN KEY([id_tipoplato])
REFERENCES [dbo].[Tipo_de_Plato] ([id_tipoplato])
GO
ALTER TABLE [dbo].[Plato] CHECK CONSTRAINT [FK_Plato_Tipo_de_Plato]
GO
ALTER TABLE [dbo].[RelacionCocineroPlato]  WITH CHECK ADD  CONSTRAINT [FK_RelacionCocineroPlato_Cocinero] FOREIGN KEY([id_cocinero])
REFERENCES [dbo].[Cocinero] ([id_cocinero])
GO
ALTER TABLE [dbo].[RelacionCocineroPlato] CHECK CONSTRAINT [FK_RelacionCocineroPlato_Cocinero]
GO
ALTER TABLE [dbo].[RelacionCocineroPlato]  WITH CHECK ADD  CONSTRAINT [FK_RelacionCocineroPlato_Plato] FOREIGN KEY([id_plato])
REFERENCES [dbo].[Plato] ([id_plato])
GO
ALTER TABLE [dbo].[RelacionCocineroPlato] CHECK CONSTRAINT [FK_RelacionCocineroPlato_Plato]
GO
ALTER TABLE [dbo].[RelacionPlatoIngrediente]  WITH CHECK ADD  CONSTRAINT [FK_RelacionPlatoIngrediente_Ingrediente] FOREIGN KEY([id_ingrediente])
REFERENCES [dbo].[Ingrediente] ([id_ingrediente])
GO
ALTER TABLE [dbo].[RelacionPlatoIngrediente] CHECK CONSTRAINT [FK_RelacionPlatoIngrediente_Ingrediente]
GO
ALTER TABLE [dbo].[RelacionPlatoIngrediente]  WITH CHECK ADD  CONSTRAINT [FK_RelacionPlatoIngrediente_Plato] FOREIGN KEY([id_plato])
REFERENCES [dbo].[Plato] ([id_plato])
GO
ALTER TABLE [dbo].[RelacionPlatoIngrediente] CHECK CONSTRAINT [FK_RelacionPlatoIngrediente_Plato]
GO
USE [master]
GO
ALTER DATABASE [Toni_Restaurante] SET  READ_WRITE 
GO
