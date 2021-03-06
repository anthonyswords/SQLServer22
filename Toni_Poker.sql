USE [master]
GO
/****** Object:  Database [Toni_Poker]    Script Date: 09/06/2022 10:42:41 ******/
CREATE DATABASE [Toni_Poker]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Toni_Poker', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Poker.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Toni_Poker_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Poker_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Toni_Poker] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Toni_Poker].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Toni_Poker] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Toni_Poker] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Toni_Poker] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Toni_Poker] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Toni_Poker] SET ARITHABORT OFF 
GO
ALTER DATABASE [Toni_Poker] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Toni_Poker] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Toni_Poker] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Toni_Poker] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Toni_Poker] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Toni_Poker] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Toni_Poker] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Toni_Poker] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Toni_Poker] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Toni_Poker] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Toni_Poker] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Toni_Poker] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Toni_Poker] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Toni_Poker] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Toni_Poker] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Toni_Poker] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Toni_Poker] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Toni_Poker] SET RECOVERY FULL 
GO
ALTER DATABASE [Toni_Poker] SET  MULTI_USER 
GO
ALTER DATABASE [Toni_Poker] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Toni_Poker] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Toni_Poker] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Toni_Poker] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Toni_Poker] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Toni_Poker] SET QUERY_STORE = OFF
GO
USE [Toni_Poker]
GO
/****** Object:  User [Toni]    Script Date: 09/06/2022 10:42:41 ******/
CREATE USER [Toni] FOR LOGIN [Toni] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Toni]
GO
/****** Object:  UserDefinedFunction [dbo].[PuntuacioHandRank]    Script Date: 09/06/2022 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[PuntuacioHandRank]
(
	@Hand_Rank_Description varchar(50)
)
RETURNS INT
AS
BEGIN
	DECLARE @puntuacioHandRank INT;

	SET @puntuacioHandRank = (SELECT Puntuacion FROM Hand_Rank_Level WHERE Rank_Hand_Descrption LIKE @Hand_Rank_Description)
	
	RETURN @puntuacioHandRank


END
GO
/****** Object:  UserDefinedFunction [dbo].[PuntuacioMano5Cartas]    Script Date: 09/06/2022 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[PuntuacioMano5Cartas] 
(
	@NumPlayer int
)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @puntuacion as varchar(50)

	IF (SELECT  COUNT(distinct FK_Numero_Carta) FROM MazoPlayer
		WHERE FK_IdPlayer = @NumPlayer
		GROUP BY FK_Numero_Carta
		HAVING COUNT(FK_Numero_Carta)=4)  = 1  
		BEGIN
		SET @puntuacion = 'POKER'
		END

	ELSE IF (SELECT  COUNT(distinct FK_Numero_Carta) FROM MazoPlayer WHERE FK_IdPlayer = @NumPlayer ) = 2
		BEGIN
		SET @puntuacion ='FULL'
		END

	ELSE IF (SELECT COUNT(distinct FK_Numero_Carta) FROM MazoPlayer WHERE FK_IdPlayer = @NumPlayer) = 3
		BEGIN
		SET @puntuacion ='TRIO'
		END

	ELSE IF (SELECT  COUNT(DISTINCT FK_Numero_Carta) FROM MazoPlayer
		WHERE FK_IdPlayer = @NumPlayer
		GROUP BY FK_Numero_Carta
		HAVING COUNT(FK_Numero_Carta)=2) = 2
		BEGIN
		SET @puntuacion ='PAREJA'
		END


	ELSE IF @puntuacion is null
		BEGIN
		SET @puntuacion = 'CARTA ALTA'
		END

	RETURN @puntuacion

END
GO
/****** Object:  UserDefinedFunction [dbo].[UsernameWinnerPrint]    Script Date: 09/06/2022 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[UsernameWinnerPrint] 
(

)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @NAME varchar(50);
	DECLARE @USERNAME varchar(50);
	SET @NAME = (SELECT NombreJugador FROM RowWinner())
	SET @USERNAME = (SELECT Username FROM RowWinner())

	RETURN ' The winner is: '+@NAME+','+@USERNAME+''

END
GO
/****** Object:  Table [dbo].[Player]    Script Date: 09/06/2022 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[IdPlayer] [int] IDENTITY(1,1) NOT NULL,
	[NombreJugador] [varchar](50) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Num_Victorias] [int] NULL,
	[FK_Last_FechaPartida] [datetime] NULL,
 CONSTRAINT [PK_Player] PRIMARY KEY CLUSTERED 
(
	[IdPlayer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clasificacion]    Script Date: 09/06/2022 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clasificacion](
	[IdResultado] [int] IDENTITY(1,1) NOT NULL,
	[FK_IdPlayer] [int] NULL,
	[FK_hand_level] [nchar](10) NULL,
	[Puntuacion] [int] NULL,
 CONSTRAINT [PK_Clasificacion] PRIMARY KEY CLUSTERED 
(
	[IdResultado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[RowWinner]    Script Date: 09/06/2022 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[RowWinner] 
(	
)
RETURNS TABLE 
AS
RETURN 
(

	SELECT TOP 1 FK_hand_level, Username, NombreJugador
	FROM Clasificacion
	INNER JOIN Player
		ON FK_IdPlayer = IdPlayer 
	ORDER BY Puntuacion DESC
)
GO
/****** Object:  Table [dbo].[Baraja]    Script Date: 09/06/2022 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Baraja](
	[IdCartas] [int] IDENTITY(1,1) NOT NULL,
	[Pal_Carta] [varchar](15) NULL,
	[Numero_Carta] [varchar](2) NULL,
	[DentroEnBaraja] [bit] NULL,
	[puntos] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCartas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hand_Rank_Level]    Script Date: 09/06/2022 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hand_Rank_Level](
	[Id_Rank_Hand] [int] NOT NULL,
	[Rank_Hand_Descrption] [varchar](20) NULL,
	[Puntuacion] [int] NULL,
 CONSTRAINT [PK_Hand_Rank_Level] PRIMARY KEY CLUSTERED 
(
	[Id_Rank_Hand] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JugadaXPlayer]    Script Date: 09/06/2022 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JugadaXPlayer](
	[IdJugada] [int] IDENTITY(1,1) NOT NULL,
	[FK_IdPartida] [int] NULL,
	[FK_IdPlayer] [int] NULL,
	[FK_player_hand_rank_id] [int] NULL,
	[Turno] [int] NULL,
	[FK_IdCarta] [int] NULL,
 CONSTRAINT [PK_Jugada_Player] PRIMARY KEY CLUSTERED 
(
	[IdJugada] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MazoPlayer]    Script Date: 09/06/2022 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MazoPlayer](
	[Id_MazoPlayer] [int] IDENTITY(1,1) NOT NULL,
	[FK_Pal_Carta] [nchar](10) NULL,
	[FK_Numero_Carta] [varchar](2) NULL,
	[FK_IdPlayer] [int] NULL,
 CONSTRAINT [PK_Hand_Rank] PRIMARY KEY CLUSTERED 
(
	[Id_MazoPlayer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mesa]    Script Date: 09/06/2022 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mesa](
	[IdMesa] [int] IDENTITY(1,1) NOT NULL,
	[FK_Carta_Mesa] [int] NULL,
	[Ronda] [int] NULL,
	[FK_idPartida] [int] NULL,
 CONSTRAINT [PK_Mesa] PRIMARY KEY CLUSTERED 
(
	[IdMesa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partida]    Script Date: 09/06/2022 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partida](
	[IdPartida] [int] IDENTITY(1,1) NOT NULL,
	[FechaPartida] [datetime] NULL,
	[FK_IdUsername_Ganador] [int] NULL,
	[FK_winning_hand_rank_id] [int] NULL,
	[Total_Players] [int] NULL,
 CONSTRAINT [PK_Partida] PRIMARY KEY CLUSTERED 
(
	[IdPartida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Baraja] ON 

INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (1, N'Diamantes', N'A', 1, 14)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (2, N'Diamantes', N'2', 1, 2)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (3, N'Diamantes', N'3', 1, 3)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (4, N'Diamantes', N'4', 1, 4)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (5, N'Diamantes', N'5', 1, 5)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (6, N'Diamantes', N'6', 1, 6)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (7, N'Diamantes', N'7', 1, 7)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (8, N'Diamantes', N'8', 1, 8)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (9, N'Diamantes', N'9', 1, 9)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (10, N'Diamantes', N'10', 1, 10)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (11, N'Diamantes', N'J', 1, 11)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (12, N'Diamantes', N'Q', 1, 12)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (13, N'Diamantes', N'K', 1, 13)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (14, N'Trébol', N'A', 1, 14)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (15, N'Trébol', N'2', 1, 2)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (16, N'Trébol', N'3', 1, 3)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (17, N'Trébol', N'4', 1, 4)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (18, N'Trébol', N'5', 1, 5)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (19, N'Trébol', N'6', 1, 6)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (20, N'Trébol', N'7', 1, 7)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (21, N'Trébol', N'8', 1, 8)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (22, N'Trébol', N'9', 1, 9)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (23, N'Diamantes', N'10', 1, 10)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (24, N'Trébol', N'J', 1, 11)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (25, N'Trébol', N'Q', 1, 12)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (26, N'Trébol', N'K', 1, 13)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (27, N'Corazones', N'A', 1, 14)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (28, N'Corazones', N'2', 1, 2)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (29, N'Corazones', N'3', 1, 3)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (30, N'Corazones', N'4', 1, 4)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (31, N'Corazones', N'5', 1, 5)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (32, N'Corazones', N'6', 1, 6)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (33, N'Corazones', N'7', 1, 7)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (34, N'Corazones', N'8', 1, 8)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (35, N'Corazones', N'9', 1, 9)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (36, N'Corazones', N'10', 1, 10)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (37, N'Diamantes', N'J', 1, 11)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (38, N'Corazones', N'Q', 1, 12)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (39, N'Corazones', N'K', 1, 13)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (40, N'Picas', N'A', 1, 14)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (41, N'Picas', N'2', 1, 2)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (42, N'Picas', N'3', 1, 3)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (43, N'Picas', N'4', 1, 4)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (44, N'Picas', N'5', 1, 5)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (45, N'Picas', N'6', 1, 6)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (46, N'Picas', N'7', 1, 7)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (47, N'Picas', N'8', 1, 8)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (48, N'Picas', N'9', 1, 9)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (49, N'Picas', N'10', 1, 10)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (50, N'Picas', N'J', 1, 11)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (51, N'Picas', N'Q', 1, 12)
INSERT [dbo].[Baraja] ([IdCartas], [Pal_Carta], [Numero_Carta], [DentroEnBaraja], [puntos]) VALUES (52, N'Picas', N'K', 1, 13)
SET IDENTITY_INSERT [dbo].[Baraja] OFF
GO
SET IDENTITY_INSERT [dbo].[Clasificacion] ON 

INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (32, 1, N'CARTA ALTA', 1)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (33, 2, N'CARTA ALTA', 1)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (34, 3, N'CARTA ALTA', 1)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (35, 1, N'CARTA ALTA', 1)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (36, 2, N'CARTA ALTA', 1)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (37, 3, N'CARTA ALTA', 1)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (38, 1, N'CARTA ALTA', 1)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (39, 2, N'CARTA ALTA', 1)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (40, 3, N'CARTA ALTA', 1)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (41, 1, N'TRIO      ', 4)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (42, 2, N'CARTA ALTA', 1)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (43, 3, N'CARTA ALTA', 1)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (44, 1, N'CARTA ALTA', 1)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (45, 2, N'TRIO      ', 4)
INSERT [dbo].[Clasificacion] ([IdResultado], [FK_IdPlayer], [FK_hand_level], [Puntuacion]) VALUES (46, 3, N'CARTA ALTA', 1)
SET IDENTITY_INSERT [dbo].[Clasificacion] OFF
GO
INSERT [dbo].[Hand_Rank_Level] ([Id_Rank_Hand], [Rank_Hand_Descrption], [Puntuacion]) VALUES (1, N'CARTA ALTA', 1)
INSERT [dbo].[Hand_Rank_Level] ([Id_Rank_Hand], [Rank_Hand_Descrption], [Puntuacion]) VALUES (2, N'PAREJA', 2)
INSERT [dbo].[Hand_Rank_Level] ([Id_Rank_Hand], [Rank_Hand_Descrption], [Puntuacion]) VALUES (3, N'DOBLE PAREJA', 3)
INSERT [dbo].[Hand_Rank_Level] ([Id_Rank_Hand], [Rank_Hand_Descrption], [Puntuacion]) VALUES (4, N'TRIO', 4)
INSERT [dbo].[Hand_Rank_Level] ([Id_Rank_Hand], [Rank_Hand_Descrption], [Puntuacion]) VALUES (5, N'ESCALERA', 5)
INSERT [dbo].[Hand_Rank_Level] ([Id_Rank_Hand], [Rank_Hand_Descrption], [Puntuacion]) VALUES (6, N'COLOR', 6)
INSERT [dbo].[Hand_Rank_Level] ([Id_Rank_Hand], [Rank_Hand_Descrption], [Puntuacion]) VALUES (7, N'FULL', 7)
INSERT [dbo].[Hand_Rank_Level] ([Id_Rank_Hand], [Rank_Hand_Descrption], [Puntuacion]) VALUES (8, N'POKER', 8)
INSERT [dbo].[Hand_Rank_Level] ([Id_Rank_Hand], [Rank_Hand_Descrption], [Puntuacion]) VALUES (9, N'ESCALERA COLOR', 9)
INSERT [dbo].[Hand_Rank_Level] ([Id_Rank_Hand], [Rank_Hand_Descrption], [Puntuacion]) VALUES (10, N'ESCALERA REAL', 10)
GO
SET IDENTITY_INSERT [dbo].[Partida] ON 

INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (1, CAST(N'2022-05-23T20:19:12.680' AS DateTime), NULL, NULL, 9)
INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (2, CAST(N'2022-05-23T21:13:22.197' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (3, CAST(N'2022-05-23T21:24:28.580' AS DateTime), NULL, NULL, 4)
INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (4, CAST(N'2022-05-23T21:24:30.737' AS DateTime), NULL, NULL, 10)
INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (5, CAST(N'2022-05-23T21:25:07.550' AS DateTime), NULL, NULL, 8)
INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (6, CAST(N'2022-05-23T21:26:21.300' AS DateTime), NULL, NULL, 5)
INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (7, CAST(N'2022-05-23T21:55:25.143' AS DateTime), NULL, NULL, 9)
INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (8, CAST(N'2022-05-23T21:55:55.470' AS DateTime), NULL, NULL, 8)
INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (9, CAST(N'2022-05-23T22:02:23.860' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (10, CAST(N'2022-05-23T22:02:25.623' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (11, CAST(N'2022-05-23T22:02:51.187' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (12, CAST(N'2022-05-23T22:02:57.297' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[Partida] ([IdPartida], [FechaPartida], [FK_IdUsername_Ganador], [FK_winning_hand_rank_id], [Total_Players]) VALUES (13, CAST(N'2022-05-23T22:03:12.060' AS DateTime), NULL, NULL, 5)
SET IDENTITY_INSERT [dbo].[Partida] OFF
GO
SET IDENTITY_INSERT [dbo].[Player] ON 

INSERT [dbo].[Player] ([IdPlayer], [NombreJugador], [Username], [Num_Victorias], [FK_Last_FechaPartida]) VALUES (1, N'Raul', N'TikPok', NULL, NULL)
INSERT [dbo].[Player] ([IdPlayer], [NombreJugador], [Username], [Num_Victorias], [FK_Last_FechaPartida]) VALUES (2, N'Fernando', N'Mosto', NULL, NULL)
INSERT [dbo].[Player] ([IdPlayer], [NombreJugador], [Username], [Num_Victorias], [FK_Last_FechaPartida]) VALUES (3, N'Leonardo', N'Caprio', NULL, NULL)
INSERT [dbo].[Player] ([IdPlayer], [NombreJugador], [Username], [Num_Victorias], [FK_Last_FechaPartida]) VALUES (4, N'Jesús', N'Tazam', NULL, NULL)
INSERT [dbo].[Player] ([IdPlayer], [NombreJugador], [Username], [Num_Victorias], [FK_Last_FechaPartida]) VALUES (5, N'Manuel', N'DeOoro', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Player] OFF
GO
ALTER TABLE [dbo].[Baraja] ADD  DEFAULT ((0)) FOR [DentroEnBaraja]
GO
ALTER TABLE [dbo].[JugadaXPlayer]  WITH CHECK ADD  CONSTRAINT [FK_JugadaXPlayer_Baraja] FOREIGN KEY([FK_IdCarta])
REFERENCES [dbo].[Baraja] ([IdCartas])
GO
ALTER TABLE [dbo].[JugadaXPlayer] CHECK CONSTRAINT [FK_JugadaXPlayer_Baraja]
GO
ALTER TABLE [dbo].[JugadaXPlayer]  WITH CHECK ADD  CONSTRAINT [FK_JugadaXPlayer_Hand_Rank] FOREIGN KEY([FK_player_hand_rank_id])
REFERENCES [dbo].[MazoPlayer] ([Id_MazoPlayer])
GO
ALTER TABLE [dbo].[JugadaXPlayer] CHECK CONSTRAINT [FK_JugadaXPlayer_Hand_Rank]
GO
ALTER TABLE [dbo].[JugadaXPlayer]  WITH CHECK ADD  CONSTRAINT [FK_JugadaXPlayer_Partida] FOREIGN KEY([FK_IdPartida])
REFERENCES [dbo].[Partida] ([IdPartida])
GO
ALTER TABLE [dbo].[JugadaXPlayer] CHECK CONSTRAINT [FK_JugadaXPlayer_Partida]
GO
ALTER TABLE [dbo].[JugadaXPlayer]  WITH CHECK ADD  CONSTRAINT [FK_JugadaXPlayer_Player] FOREIGN KEY([FK_IdPlayer])
REFERENCES [dbo].[Player] ([IdPlayer])
GO
ALTER TABLE [dbo].[JugadaXPlayer] CHECK CONSTRAINT [FK_JugadaXPlayer_Player]
GO
ALTER TABLE [dbo].[Mesa]  WITH CHECK ADD  CONSTRAINT [FK_Mesa_Baraja] FOREIGN KEY([FK_Carta_Mesa])
REFERENCES [dbo].[Baraja] ([IdCartas])
GO
ALTER TABLE [dbo].[Mesa] CHECK CONSTRAINT [FK_Mesa_Baraja]
GO
ALTER TABLE [dbo].[Mesa]  WITH CHECK ADD  CONSTRAINT [FK_Mesa_Partida1] FOREIGN KEY([FK_idPartida])
REFERENCES [dbo].[Partida] ([IdPartida])
GO
ALTER TABLE [dbo].[Mesa] CHECK CONSTRAINT [FK_Mesa_Partida1]
GO
ALTER TABLE [dbo].[Partida]  WITH CHECK ADD  CONSTRAINT [FK_Partida_Hand_Rank] FOREIGN KEY([FK_winning_hand_rank_id])
REFERENCES [dbo].[MazoPlayer] ([Id_MazoPlayer])
GO
ALTER TABLE [dbo].[Partida] CHECK CONSTRAINT [FK_Partida_Hand_Rank]
GO
ALTER TABLE [dbo].[Partida]  WITH CHECK ADD  CONSTRAINT [FK_Partida_Player] FOREIGN KEY([FK_IdUsername_Ganador])
REFERENCES [dbo].[Player] ([IdPlayer])
GO
ALTER TABLE [dbo].[Partida] CHECK CONSTRAINT [FK_Partida_Player]
GO
/****** Object:  StoredProcedure [dbo].[CartasRepartidasJugadores]    Script Date: 09/06/2022 10:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Repartim cartes a Jugadors
-- =============================================
CREATE PROCEDURE [dbo].[CartasRepartidasJugadores]
	@NumPlayersTotal INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @cartajugador1 INT,
			@cartajugador2 INT,
			@cartajugador3 INT,
			@Turno INT=1,
			@TurnoPlayer INT=1,
			@FK_IdPlayer INT=0


	WHILE @Turno <= @NumPlayersTotal
	BEGIN
	--	SET @FK_IdPlayer = (SELECT Cast(RAND()*(MAX(IdPlayer)-1)+1 as int) FROM Player)		
		SET @FK_IdPlayer = @FK_IdPlayer+1;
			
		EXEC SeleccionarCartaRandom @cartajugador1 OUTPUT;
		EXEC SeleccionarCartaRandom @cartajugador2 OUTPUT;
		EXEC SeleccionarCartaRandom @cartajugador3 OUTPUT;

		INSERT INTO JugadaXPlayer VALUES(null,@FK_IdPlayer,null,1, @cartajugador1 );		
		INSERT INTO JugadaXPlayer VALUES(null,@FK_IdPlayer,null,2, @cartajugador2 );		
		INSERT INTO JugadaXPlayer VALUES(null,@FK_IdPlayer,null,3, @cartajugador3 );		
		
		SET @Turno = @Turno + 1;
	END
	
	SELECT Username, NombreJugador, Turno, Pal_Carta, Numero_Carta
	FROM JugadaXPlayer 
	inner join Player
		on JugadaXPlayer.FK_IdPlayer = Player.IdPlayer
	INNER JOIN Baraja
		ON Baraja.IdCartas = JugadaXPlayer.FK_IdCarta
	ORDER BY Turno, NombreJugador;


	--DELETE from JugadaXPlayer;
END
GO
/****** Object:  StoredProcedure [dbo].[CartasRepartidasMesa]    Script Date: 09/06/2022 10:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Configuramos la partida, repartiment de cartes
-- =============================================
CREATE   PROCEDURE [dbo].[CartasRepartidasMesa]

AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @cartaMesa1 INT,
			@cartaMesa2 INT


	EXEC SeleccionarCartaRandom @cartaMesa1 OUTPUT;
	EXEC SeleccionarCartaRandom @cartaMesa2 OUTPUT;


	INSERT INTO Mesa(FK_Carta_Mesa,Ronda) VALUES(@cartaMesa1, 1)
	INSERT INTO Mesa(FK_Carta_Mesa,Ronda) VALUES(@cartaMesa2, 2)

	SELECT Ronda, FK_Carta_Mesa,  Pal_Carta , Numero_Carta
	FROM Mesa
	INNER JOIN Baraja
			ON FK_Carta_Mesa = IdCartas;
	--DELETE FROM Mesa;
END
GO
/****** Object:  StoredProcedure [dbo].[InicializarPartida]    Script Date: 09/06/2022 10:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[InicializarPartida]
	@NumPlayers INT
AS
BEGIN
	SET NOCOUNT ON;
	IF @NumPlayers BETWEEN 2 AND (SELECT CAST(count(IdPartida) as int) FROM Partida)
	BEGIN
		DECLARE @contador int = 1;
		DECLARE @HandRankDescripcio VARCHAR(50);
		DECLARE @puntuacio int;

		-- Tots contadors a zero
		EXEC ResetPartida;    
		
		-- Repartim cartes
		EXEC CartasRepartidasMesa;	
		EXEC CartasRepartidasJugadores @NumPlayers ;
		
		--Concatenem cartes jugadors i taula
		EXEC InsertMazoPlayer @NumPlayers;

		-- Mostrem què han obtingut en cada jugada de cada jugador
		WHILE @contador <= @NumPlayers
			BEGIN
				SET @HandRankDescripcio = (SELECT dbo.PuntuacioMano5Cartas(@contador))
				SET @puntuacio = (SELECT dbo.PuntuacioHandRank(@HandRankDescripcio))
				INSERT INTO Clasificacion(FK_IdPlayer, FK_hand_level, Puntuacion) VALUES( @contador, @HandRankDescripcio , @puntuacio)
				SET @contador = @contador + 1
			END
		
		SELECT * FROM Clasificacion
		SELECT * FROM RowWinner();
		SELECT dbo.UsernameWinnerPrint();
		
		DELETE from JugadaXPlayer;
		DELETE FROM Mesa;
		DELETE FROM MazoPlayer;
		DELETE FROM Clasificacion;

		EXEC ResetPartida; 

	END
	ELSE
	SELECT 'Numero de jugadores no valido mínimo 2 hasta'+(SELECT CAST(count(IdPartida) as int) FROM Partida)+'.'	
END

GO
/****** Object:  StoredProcedure [dbo].[InsertMazoPlayer]    Script Date: 09/06/2022 10:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[InsertMazoPlayer] 
	@NumPlayers int
AS
BEGIN
	DECLARE @contador INT = 1;
	WHILE @contador <= @NumPlayers
		BEGIN
		INSERT INTO MazoPlayer 
			SELECT Pal_Carta, Numero_Carta, @contador  
			FROM JugadaXPlayer 
			inner join Player
				ON JugadaXPlayer.FK_IdPlayer = Player.IdPlayer
			INNER JOIN Baraja
				ON Baraja.IdCartas = JugadaXPlayer.FK_IdCarta
			WHERE FK_IdPlayer = @contador 
			UNION
			SELECT Pal_Carta, Numero_Carta, @contador
			FROM Mesa
			INNER JOIN Baraja
				ON FK_Carta_Mesa = IdCartas
		SET @contador = @contador + 1
		END

		SELECT * FROM MazoPlayer
		
END
GO
/****** Object:  StoredProcedure [dbo].[InsertPlayer]    Script Date: 09/06/2022 10:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[InsertPlayer] 
	@NombreJugador varchar(50),
	@Username varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT * FROM Player WHERE Username = @Username)
	BEGIN 
		UPDATE Player
		SET NombreJugador = @NombreJugador 
		WHERE Username = @Username
	END
	ELSE 
	BEGIN
		INSERT INTO Player(NombreJugador, Username) SELECT @NombreJugador, @Username
		WHERE NOT EXISTS(SELECT * FROM Player WHERE Username = @Username);
	END
END
GO
/****** Object:  StoredProcedure [dbo].[ResetPartida]    Script Date: 09/06/2022 10:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Procedure para inicilizar una partida creando una nueva baraja
-- =============================================
CREATE   PROCEDURE [dbo].[ResetPartida] 
AS
BEGIN
	
	SET NOCOUNT ON;

	IF OBJECT_ID('Baraja', 'U') IS NULL
	BEGIN
		CREATE TABLE Baraja
		(
			IdCartas INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
			Pal_Carta VARCHAR(15),
			Numero_Carta VARCHAR(2),
			DentroEnBaraja BIT DEFAULT 1,
			puntos int NULL,
		)

		-- 
		-- Insertamos numero de carta en secuencia desde el 2 hasta el 10, luego...
		--	J = 11 , 
		--	Q = 12 , 
		--	K = 13
		-- As = 14, 


		INSERT INTO Baraja(Pal_Carta, Numero_Carta, puntos) VALUES 
			('Diamantes', 'A', 14),('Diamantes','2', 2),('Diamantes','3', 3),('Diamantes','4', 4),('Diamantes','5', 5),('Diamantes','6', 6),('Diamantes','7', 7),('Diamantes','8', 8),('Diamantes','9', 9),('Diamantes','10', 10),('Diamantes','J', 11),('Diamantes','Q', 12),('Diamantes','K', 13),
			('Trébol', 'A', 14),('Trébol','2', 2),('Trébol','3', 3),('Trébol','4', 4),('Trébol','5', 5),('Trébol','6', 6),('Trébol','7', 7),('Trébol','8', 8),('Trébol','9', 9),('Diamantes','10', 10),('Trébol','J', 11),('Trébol','Q', 12),('Trébol','K', 13),
			('Corazones', 'A', 14),('Corazones','2', 2),('Corazones','3', 3),('Corazones','4', 4),('Corazones','5', 5),('Corazones','6', 6),('Corazones','7', 7),('Corazones','8', 8),('Corazones','9', 9),('Corazones','10', 10),('Diamantes','J', 11),('Corazones','Q', 12),('Corazones','K', 13),
			('Picas', 'A', 14),('Picas','2', 2),('Picas','3', 3),('Picas','4', 4),('Picas','5', 5),('Picas','6', 6),('Picas','7', 7),('Picas','8', 8),('Picas','9', 9),('Picas','10', 10),('Picas','J', 11),('Picas','Q', 12),('Picas','K', 13)
		END
	ELSE
		BEGIN
			--Si las tablas ya estaban creadas, pues unicamente ponemos las cartas de nuevo a la baraja
			UPDATE Baraja SET DentroEnBaraja = 1 
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SeleccionarCartaRandom]    Script Date: 09/06/2022 10:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Escollir carta aleatoria
-- =============================================
CREATE PROCEDURE [dbo].[SeleccionarCartaRandom]
	@idCarta INT OUTPUT
AS
BEGIN
	declare @final bit=0,
			@numCartaRandom INT

	
	SET NOCOUNT ON;

	WHILE @final != 1
	BEGIN
		-- escollim carta al atzar
		SET @numCartaRandom = (SELECT CAST(RAND()*(52-1)+1 as int));

		-- Agafem la carta que no estigui ocupada
		
		IF (SELECT DentroEnBaraja FROM Baraja WHERE IdCartas = @numCartaRandom) = 1
		BEGIN
			
			SET @idCarta = @numCartaRandom

			-- Un cop agafada la carta lliure, seleccionem que aquesta ja està fora de la pila de cartes 
			UPDATE Baraja SET DentroEnBaraja = 0 
				WHERE IdCartas = @numCartaRandom
			--Tanquem el while true
			
			SET @final = 1
		END
	END
END
GO
USE [master]
GO
ALTER DATABASE [Toni_Poker] SET  READ_WRITE 
GO
