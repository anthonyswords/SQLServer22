USE [master]
GO
/****** Object:  Database [Toni_Tres_Rayados]    Script Date: 09/06/2022 10:47:58 ******/
CREATE DATABASE [Toni_Tres_Rayados]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Toni_Tres_Rayados', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Tres_Rayados.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Toni_Tres_Rayados_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Tres_Rayados_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Toni_Tres_Rayados] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Toni_Tres_Rayados].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Toni_Tres_Rayados] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET ARITHABORT OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET RECOVERY FULL 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET  MULTI_USER 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Toni_Tres_Rayados] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Toni_Tres_Rayados] SET QUERY_STORE = OFF
GO
USE [Toni_Tres_Rayados]
GO
/****** Object:  User [Toni]    Script Date: 09/06/2022 10:47:59 ******/
CREATE USER [Toni] FOR LOGIN [Toni] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Toni]
GO
/****** Object:  UserDefinedFunction [dbo].[CheckWinner]    Script Date: 09/06/2022 10:47:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    FUNCTION [dbo].[CheckWinner]
(
	@jugador INT
)
RETURNS VARCHAR(23)
AS
BEGIN

	-- Declare the return variable here
	DECLARE 
		@result VARCHAR(23) = 'Jueguen'
			
														
	-- Comprueba en vertical.
	
	IF (SELECT C1 FROM TABLERO 
			GROUP BY C1
			HAVING COUNT(*) = 3 ) IN ('O','X')
	SET @result = CONCAT('El jugador ' , CAST(@jugador AS CHAR(1)) , ' ha ganado');

	IF (SELECT C2 FROM TABLERO 
			GROUP BY C2
			HAVING COUNT(*) = 3 ) IN ('O','X')
	SET @result = CONCAT('El jugador ' , CAST(@jugador AS CHAR(1)) , ' ha ganado');

	IF (SELECT C3 FROM TABLERO 
			GROUP BY C3
			HAVING COUNT(*) = 3 ) IN ('O','X')
	SET @result = CONCAT('El jugador ' , CAST(@jugador AS CHAR(1)) , ' ha ganado');
	
	
	-- Comprueba en horizontal

	IF  ((SELECT concat(C1, C2, C3) FROM Tablero WHERE F = 1) IN ('OOO','XXX'))
		SET @result = CONCAT('El jugador ' , CAST(@jugador AS CHAR(1)) , ' ha ganado');

	IF  ((SELECT concat(C1, C2, C3) FROM Tablero WHERE F = 2) IN ('OOO','XXX'))
		SET @result = CONCAT('El jugador ' , CAST(@jugador AS CHAR(1)) , ' ha ganado');

	IF  ((SELECT concat(C1, C2, C3) FROM Tablero WHERE F = 3) IN ('OOO','XXX'))
		SET @result = CONCAT('El jugador ' , CAST(@jugador AS CHAR(1)) , ' ha ganado');

	
	-- Comprueba diagonal


	IF ((SELECT DISTINCT CONCAT((SELECT C1 FROM Tablero WHERE F = 1),
				(SELECT C2 FROM Tablero WHERE F = 2),
				(SELECT C3 FROM Tablero WHERE F = 3)) FROM Tablero) IN ('OOO','XXX'))
		SET @result = CONCAT('El jugador ' , CAST(@jugador AS CHAR(1)) , ' ha ganado');
		

	IF ((SELECT DISTINCT CONCAT( (SELECT C3 FROM Tablero WHERE F = 1),
						(SELECT C2 FROM Tablero WHERE F = 2),
						(SELECT C1 FROM Tablero WHERE F = 3)) FROM Tablero) IN ('OOO','XXX'))
		SET @result = CONCAT('El jugador ' , CAST(@jugador AS CHAR(1)) , ' ha ganado');

		

	-- Return the result of the function
	RETURN @result;

END
GO
/****** Object:  Table [dbo].[Tablero]    Script Date: 09/06/2022 10:47:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tablero](
	[F] [nchar](2) NULL,
	[C1] [nchar](1) NULL,
	[C2] [nchar](1) NULL,
	[C3] [nchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[MuestraTablero]    Script Date: 09/06/2022 10:47:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[MuestraTablero]
(
)
RETURNS Table
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT C1,C2,C3 From Tablero
)
GO
INSERT [dbo].[Tablero] ([F], [C1], [C2], [C3]) VALUES (N'1 ', NULL, NULL, NULL)
INSERT [dbo].[Tablero] ([F], [C1], [C2], [C3]) VALUES (N'2 ', NULL, NULL, NULL)
INSERT [dbo].[Tablero] ([F], [C1], [C2], [C3]) VALUES (N'3 ', NULL, NULL, NULL)
GO
ALTER TABLE [dbo].[Tablero] ADD  DEFAULT ('') FOR [F]
GO
ALTER TABLE [dbo].[Tablero] ADD  DEFAULT ('') FOR [C1]
GO
ALTER TABLE [dbo].[Tablero] ADD  DEFAULT ('') FOR [C2]
GO
ALTER TABLE [dbo].[Tablero] ADD  DEFAULT ('') FOR [C3]
GO
/****** Object:  StoredProcedure [dbo].[PlayerMueveFicha]    Script Date: 09/06/2022 10:48:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[PlayerMueveFicha]

	@Fila int,
	@Columna int,
	@Jugador int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @FichaJugador1 CHAR(1) = 'X',
			@FichaJugador2 CHAR(1) = 'O',
			@FichaPlayer char(1)


	-- Elegimos el valor X o O según el jugador que sea			 
	SET @FichaPlayer = ( SELECT	CASE 
									WHEN @Jugador = 1 THEN @FichaJugador1
									WHEN @Jugador = 2 THEN @FichaJugador2
								END )

	
	IF @Columna = 1 UPDATE Tablero SET C1 = @FichaPlayer 
		WHERE @Fila = F 
		AND C1 IS NULL; 
		

	IF @Columna = 2 UPDATE Tablero SET C2 = @FichaPlayer 
		WHERE @Fila = F 
		AND   C2 IS NULL;

	IF @Columna = 3 UPDATE Tablero SET C3 = @FichaPlayer 
		WHERE @Fila = F 
		AND   C3 IS NULL;

END
GO
/****** Object:  StoredProcedure [dbo].[ResetTablero]    Script Date: 09/06/2022 10:48:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ResetTablero] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Tablero
		SET C1 = NULL, C2 = NULL, C3 = NULL
	WHERE F = 1;
	UPDATE Tablero
		SET C1 = NULL, C2 = NULL, C3 = NULL
	WHERE F = 2;
	UPDATE Tablero
		SET C1 = NULL, C2 = NULL, C3 = NULL
	WHERE F = 3;
END
GO
USE [master]
GO
ALTER DATABASE [Toni_Tres_Rayados] SET  READ_WRITE 
GO
