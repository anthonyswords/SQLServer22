USE [master]
GO
/****** Object:  Database [Toni_Contacto]    Script Date: 09/06/2022 10:33:25 ******/
CREATE DATABASE [Toni_Contacto]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Toni_Contacto', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Contacto.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Toni_Contacto_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Contacto_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Toni_Contacto] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Toni_Contacto].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Toni_Contacto] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Toni_Contacto] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Toni_Contacto] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Toni_Contacto] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Toni_Contacto] SET ARITHABORT OFF 
GO
ALTER DATABASE [Toni_Contacto] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Toni_Contacto] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Toni_Contacto] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Toni_Contacto] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Toni_Contacto] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Toni_Contacto] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Toni_Contacto] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Toni_Contacto] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Toni_Contacto] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Toni_Contacto] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Toni_Contacto] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Toni_Contacto] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Toni_Contacto] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Toni_Contacto] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Toni_Contacto] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Toni_Contacto] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Toni_Contacto] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Toni_Contacto] SET RECOVERY FULL 
GO
ALTER DATABASE [Toni_Contacto] SET  MULTI_USER 
GO
ALTER DATABASE [Toni_Contacto] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Toni_Contacto] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Toni_Contacto] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Toni_Contacto] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Toni_Contacto] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Toni_Contacto] SET QUERY_STORE = OFF
GO
USE [Toni_Contacto]
GO
/****** Object:  User [Toni]    Script Date: 09/06/2022 10:33:25 ******/
CREATE USER [Toni] FOR LOGIN [Toni] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Toni]
GO
/****** Object:  Table [dbo].[Tipo_Contacto]    Script Date: 09/06/2022 10:33:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Contacto](
	[IdTipoContacto] [int] IDENTITY(1,1) NOT NULL,
	[NombreTipo] [varchar](10) NULL,
 CONSTRAINT [PK_Tipo_Contacto] PRIMARY KEY CLUSTERED 
(
	[IdTipoContacto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacto]    Script Date: 09/06/2022 10:33:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacto](
	[ID_contacto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Telefono] [varchar](20) NOT NULL,
	[FK_TipoContacto] [int] NOT NULL,
 CONSTRAINT [PK_Contacto] PRIMARY KEY CLUSTERED 
(
	[ID_contacto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_otros]    Script Date: 09/06/2022 10:33:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_otros] AS
	SELECT Nombre, Telefono, NombreTipo FROM Contacto, Tipo_Contacto
	WHERE Contacto.FK_TipoContacto = Tipo_Contacto.IdTipoContacto AND Tipo_Contacto.NombreTipo = 'Otros';
GO
/****** Object:  View [dbo].[view_clientes]    Script Date: 09/06/2022 10:33:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_clientes] AS
	SELECT Nombre, Telefono FROM Contacto, Tipo_Contacto
	WHERE Contacto.FK_TipoContacto = Tipo_Contacto.IdTipoContacto AND Tipo_Contacto.NombreTipo = 'Cliente';
GO
/****** Object:  View [dbo].[view_proveedores]    Script Date: 09/06/2022 10:33:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_proveedores] AS
	SELECT Nombre, Telefono FROM Contacto, Tipo_Contacto
	WHERE Contacto.FK_TipoContacto = Tipo_Contacto.IdTipoContacto AND Tipo_Contacto.NombreTipo = 'Proveedor';
GO
/****** Object:  View [dbo].[view_empleados]    Script Date: 09/06/2022 10:33:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_empleados] AS
	SELECT Nombre, Telefono FROM Contacto, Tipo_Contacto
	WHERE Contacto.FK_TipoContacto = Tipo_Contacto.IdTipoContacto AND Tipo_Contacto.NombreTipo = 'Empleado';
GO
SET IDENTITY_INSERT [dbo].[Contacto] ON 

INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (1, N'Inez Hammond', N'+34 589 852 159', 1)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (2, N'Keefe Sargent', N'+34 848 239 383', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (3, N'Hop Conley', N'+34 155 613 228', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (4, N'Lewis Johnston', N'+34 717 168 798', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (5, N'Hermione Lewis', N'+34 101 491 152', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (6, N'Marah Michael', N'+34 060 946 633', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (7, N'Eaton Whitney', N'+34 205 361 397', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (8, N'Quamar Hoffman', N'+34 548 593 028', 1)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (9, N'Tyrone Carter', N'+34 904 331 571', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (10, N'Rina Kim', N'+34 259 011 213', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (11, N'Xaviera House', N'+34 988 692 307', 1)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (12, N'Mollie Dale', N'+34 153 296 448', 1)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (13, N'Urielle Burks', N'+34 923 658 704', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (14, N'Phillip Sawyer', N'+34 523 292 066', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (15, N'Charde Wilkinson', N'+34 710 260 022', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (16, N'Karen Ratliff', N'+34 509 257 184', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (17, N'Blake Ballard', N'+34 372 283 562', 1)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (18, N'Jane Castaneda', N'+34 466 418 418', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (19, N'Madaline Davenport', N'+34 746 286 287', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (20, N'Hashim James', N'+34 051 549 137', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (21, N'Jerry Velasquez', N'+34 176 275 219', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (22, N'Derek Hendricks', N'+34 211 345 132', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (23, N'Wanda Sweet', N'+34 289 260 360', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (24, N'Murphy Romero', N'+34 396 233 588', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (25, N'Rhoda Workman', N'+34 622 746 185', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (26, N'Ima Cochran', N'+34 461 264 657', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (27, N'Dale Koch', N'+34 795 328 806', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (28, N'Aladdin Shields', N'+34 243 762 183', 1)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (29, N'Dalton Whitley', N'+34 616 421 031', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (30, N'Cameron Caldwell', N'+34 247 346 238', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (31, N'Edward Hudson', N'+34 687 138 359', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (32, N'Daquan Dunlap', N'+34 319 442 498', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (33, N'Quentin Avila', N'+34 081 951 831', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (34, N'Lawrence Benton', N'+34 563 768 711', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (35, N'Heidi Farrell', N'+34 978 822 368', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (36, N'Reese Villarreal', N'+34 498 928 673', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (37, N'Eliana Saunders', N'+34 542 237 182', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (38, N'Cassady Gillespie', N'+34 128 346 861', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (39, N'Colorado Anthony', N'+34 776 988 396', 1)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (40, N'Timothy Lewis', N'+34 531 383 545', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (41, N'Cody Boone', N'+34 209 413 879', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (42, N'Rashad Johnston', N'+34 493 846 545', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (43, N'Len Weaver', N'+34 558 844 351', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (44, N'Jonas Morrow', N'+34 880 949 897', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (45, N'Cameran Wilder', N'+34 714 739 619', 1)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (46, N'Aimee Gonzalez', N'+34 657 878 320', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (47, N'Amir Mendoza', N'+34 162 577 319', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (48, N'Adena Dickerson', N'+34 749 277 784', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (49, N'Kadeem Barron', N'+34 781 234 501', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (50, N'Axel Stevenson', N'+34 153 127 771', 1)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (51, N'Odessa Lara', N'+34 235 585 062', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (52, N'Ivana Sparks', N'+34 888 496 678', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (53, N'Lee Banks', N'+34 924 841 603', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (54, N'Tanek Glover', N'+34 796 008 790', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (55, N'Jolene Byrd', N'+34 886 090 025', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (56, N'Linus Mcconnell', N'+34 705 285 374', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (57, N'Briar Mcpherson', N'+34 543 664 921', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (58, N'Kameko Morrow', N'+34 432 843 224', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (59, N'Donovan Nolan', N'+34 725 161 371', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (60, N'Alfonso Wall', N'+34 135 025 717', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (61, N'Jonas Durham', N'+34 155 328 813', 1)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (62, N'Eliana Cooley', N'+34 709 606 372', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (63, N'Pascale Yates', N'+34 665 682 188', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (64, N'Zenia Meyers', N'+34 673 396 313', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (65, N'Otto Osborne', N'+34 337 624 203', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (66, N'Mona Sullivan', N'+34 181 527 203', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (67, N'Levi Mcintosh', N'+34 742 327 364', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (68, N'Vielka Richards', N'+34 541 820 664', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (69, N'Ora Robinson', N'+34 685 771 168', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (70, N'Faith Dominguez', N'+34 625 404 463', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (71, N'Mohammad Curry', N'+34 433 587 735', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (72, N'Sonya Bean', N'+34 665 930 125', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (73, N'Madonna Holman', N'+34 361 484 705', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (74, N'Isaac Merritt', N'+34 670 822 588', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (75, N'Hoyt Vance', N'+34 263 224 551', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (76, N'Aurora Price', N'+34 851 820 569', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (77, N'Willow Hodge', N'+34 834 047 695', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (78, N'Griffin Pearson', N'+34 283 258 397', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (79, N'Sade Wall', N'+34 433 661 703', 1)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (80, N'Hasad Francis', N'+34 724 642 592', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (81, N'Jana Jackson', N'+34 874 992 205', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (82, N'Lester Dennis', N'+34 114 567 723', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (83, N'Moses Johns', N'+34 816 787 628', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (84, N'Chandler Blake', N'+34 133 822 433', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (85, N'Nash Burt', N'+34 830 072 126', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (86, N'Dacey Owen', N'+34 756 858 584', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (87, N'Keely Greer', N'+34 258 893 176', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (88, N'Lacy Stark', N'+34 204 516 667', 1)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (89, N'Bradley Garner', N'+34 072 952 724', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (90, N'Keaton Whitley', N'+34 678 806 473', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (91, N'Allen Medina', N'+34 323 087 953', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (92, N'Dane Robinson', N'+34 286 873 418', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (93, N'Gary Albert', N'+34 484 655 356', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (94, N'Kirestin Stout', N'+34 653 160 715', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (95, N'Rhea Love', N'+34 276 251 504', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (96, N'Liberty House', N'+34 205 514 584', 4)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (97, N'Risa Rodriquez', N'+34 368 575 674', 3)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (98, N'Bianca Adkins', N'+34 238 536 618', 2)
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (99, N'Mara Hopper', N'+34 070 332 304', 4)
GO
INSERT [dbo].[Contacto] ([ID_contacto], [Nombre], [Telefono], [FK_TipoContacto]) VALUES (100, N'Conan Hines', N'+34 635 650 035', 3)
SET IDENTITY_INSERT [dbo].[Contacto] OFF
GO
SET IDENTITY_INSERT [dbo].[Tipo_Contacto] ON 

INSERT [dbo].[Tipo_Contacto] ([IdTipoContacto], [NombreTipo]) VALUES (1, N'Cliente')
INSERT [dbo].[Tipo_Contacto] ([IdTipoContacto], [NombreTipo]) VALUES (2, N'Proveedor')
INSERT [dbo].[Tipo_Contacto] ([IdTipoContacto], [NombreTipo]) VALUES (3, N'Empleado')
INSERT [dbo].[Tipo_Contacto] ([IdTipoContacto], [NombreTipo]) VALUES (4, N'Otros')
SET IDENTITY_INSERT [dbo].[Tipo_Contacto] OFF
GO
ALTER TABLE [dbo].[Contacto]  WITH CHECK ADD  CONSTRAINT [FK_Contacto_Tipo_Contacto] FOREIGN KEY([FK_TipoContacto])
REFERENCES [dbo].[Tipo_Contacto] ([IdTipoContacto])
GO
ALTER TABLE [dbo].[Contacto] CHECK CONSTRAINT [FK_Contacto_Tipo_Contacto]
GO
USE [master]
GO
ALTER DATABASE [Toni_Contacto] SET  READ_WRITE 
GO
