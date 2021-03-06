USE [master]
GO
/****** Object:  Database [Toni_Employees]    Script Date: 09/06/2022 10:40:21 ******/
CREATE DATABASE [Toni_Employees]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Toni_Employees', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Employees.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Toni_Employees_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Toni_Employees_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Toni_Employees] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Toni_Employees].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Toni_Employees] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Toni_Employees] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Toni_Employees] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Toni_Employees] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Toni_Employees] SET ARITHABORT OFF 
GO
ALTER DATABASE [Toni_Employees] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Toni_Employees] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Toni_Employees] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Toni_Employees] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Toni_Employees] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Toni_Employees] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Toni_Employees] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Toni_Employees] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Toni_Employees] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Toni_Employees] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Toni_Employees] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Toni_Employees] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Toni_Employees] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Toni_Employees] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Toni_Employees] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Toni_Employees] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Toni_Employees] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Toni_Employees] SET RECOVERY FULL 
GO
ALTER DATABASE [Toni_Employees] SET  MULTI_USER 
GO
ALTER DATABASE [Toni_Employees] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Toni_Employees] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Toni_Employees] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Toni_Employees] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Toni_Employees] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Toni_Employees] SET QUERY_STORE = OFF
GO
USE [Toni_Employees]
GO
/****** Object:  User [Toni]    Script Date: 09/06/2022 10:40:21 ******/
CREATE USER [Toni] FOR LOGIN [Toni] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Toni]
GO
/****** Object:  UserDefinedFunction [dbo].[FechadeHoy]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FechadeHoy]
(
)
RETURNS date
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result date

	-- Add the T-SQL statements to compute the return value here
	SELECT @result = getdate()

	-- Return the result of the function
	RETURN @result

END
GO
/****** Object:  UserDefinedFunction [dbo].[FechaToday]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[FechaToday] 
(

)
RETURNS date
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result date

	-- Add the T-SQL statements to compute the return value here
	SELECT @result = getdate()

	-- Return the result of the function
	RETURN @result

END
GO
/****** Object:  UserDefinedFunction [dbo].[NumEmpleados]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NumEmpleados] 
(
	@RidDept int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result int

	-- Add the T-SQL statements to compute the return value here
	SELECT @result = count(*) from employees
		where FK_department=@RidDept

	-- Return the result of the function
	RETURN @result

END
GO
/****** Object:  UserDefinedFunction [dbo].[NumEmpsCiudad]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[NumEmpsCiudad](@ciudad varchar(50))

RETURNS varchar(50)
AS
BEGIN

	DECLARE @result int

	SELECT @result = count(*) from employees
	INNER JOIN departments
		ON departments.department_id = employees.FK_department
		INNER JOIN locations
			ON locations.location_id = departments.FK_location
			WHERE locations.city = @ciudad 

	RETURN @result

END;
GO
/****** Object:  UserDefinedFunction [dbo].[Numero_Empleados]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Numero_Empleados] 
(

)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result int

	-- Add the T-SQL statements to compute the return value here
	SELECT @result = COUNT(employees.employee_id)
	FROM employees

	-- Return the result of the function
	RETURN @result

END
GO
/****** Object:  UserDefinedFunction [dbo].[Numero_Empleados_Department]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Numero_Empleados_Department] 
(
@id int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result int

	-- Add the T-SQL statements to compute the return value here
	SELECT @result = COUNT(*)
	FROM employees WHERE FK_department = @id 

	-- Return the result of the function
	RETURN @result

END
GO
/****** Object:  UserDefinedFunction [dbo].[test]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[test]()
returns @lista table
(first_name varchar(20))
as
begin
	declare @sql nvarchar(200)
	set @sql = N'select first_name * from employees'

	return
end
GO
/****** Object:  Table [dbo].[departments]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[departments](
	[department_id] [int] IDENTITY(1,1) NOT NULL,
	[department_name] [varchar](30) NOT NULL,
	[FK_location] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employees]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employees](
	[employee_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](20) NULL,
	[last_name] [varchar](25) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[phone_number] [varchar](20) NULL,
	[hire_date] [date] NOT NULL,
	[FK_job] [int] NOT NULL,
	[salary] [decimal](8, 2) NOT NULL,
	[FK_manager] [int] NULL,
	[FK_department] [int] NULL,
	[Parentesco] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Llista_Articles_Toni]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Llista_Articles_Toni] AS
	SELECT 
		departments.department_name, 
		COUNT(employees.employee_id) as num_empl, 
		CASE 
			WHEN COUNT(employees.employee_id) = 0 THEN 'Ninguno'
			WHEN COUNT(employees.employee_id) < 3 THEN 'Pocos'
			WHEN COUNT(employees.employee_id) > 6 THEN 'Muchos'
			ELSE 'Algunos' END AS Indicador
	FROM departments
	LEFT JOIN employees
		ON employees.FK_department = departments.department_id
	GROUP BY departments.department_name;	
GO
/****** Object:  UserDefinedFunction [dbo].[ListaDeptsConNumEmps]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[ListaDeptsConNumEmps] 
(	
	@idDept int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT department_name, dbo.NumEmpleados(department_id) 'NumEmps'
	FROM departments
	WHERE @idDept IS NULL OR department_id = @idDept
)
GO
/****** Object:  Table [dbo].[back_up_employees]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[back_up_employees](
	[employee_id] [int] NOT NULL,
	[first_name] [varchar](20) NULL,
	[last_name] [varchar](25) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[phone_number] [varchar](20) NULL,
	[hire_date] [date] NOT NULL,
	[FK_job] [int] NOT NULL,
	[salary] [decimal](8, 2) NOT NULL,
	[FK_manager] [int] NULL,
	[FK_department] [int] NULL,
	[Parentesco] [varchar](50) NULL,
	[operacion] [varchar](50) NULL,
	[fechaModificacion] [date] NULL,
	[horaModificacion] [time](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[countries]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[countries](
	[country_id] [char](2) NOT NULL,
	[country_name] [varchar](40) NULL,
	[FK_region] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cuenta]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cuenta](
	[IdCuenta] [int] IDENTITY(1,1) NOT NULL,
	[NumCuenta] [nvarchar](50) NOT NULL,
	[Saldo] [money] NOT NULL,
 CONSTRAINT [PK_Cuenta] PRIMARY KEY CLUSTERED 
(
	[Saldo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dependents]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dependents](
	[dependent_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[relationship] [varchar](25) NOT NULL,
	[FK_employee] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[dependent_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jobs]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jobs](
	[job_id] [int] IDENTITY(1,1) NOT NULL,
	[job_title] [varchar](35) NULL,
	[min_salary] [decimal](8, 2) NULL,
	[max_salary] [decimal](8, 2) NULL,
	[Operacion] [varchar](50) NULL,
 CONSTRAINT [PK__jobs__6E32B6A50C8B88D2] PRIMARY KEY CLUSTERED 
(
	[job_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[locations]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[locations](
	[location_id] [int] IDENTITY(1,1) NOT NULL,
	[street_address] [varchar](40) NULL,
	[postal_code] [varchar](12) NULL,
	[city] [varchar](30) NOT NULL,
	[state_province] [varchar](25) NULL,
	[FK_country] [char](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[log_count]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log_count](
	[NumRowsInserted] [int] NULL,
	[NumRowsDeleted] [int] NULL,
	[NumRowsUpdated] [int] NULL,
	[ID_count] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[regions]    Script Date: 09/06/2022 10:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[regions](
	[region_id] [int] IDENTITY(1,1) NOT NULL,
	[region_name] [varchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[region_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[back_up_employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco], [operacion], [fechaModificacion], [horaModificacion]) VALUES (246, N'Sandra', N'Taylor', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito', N'Modificada', CAST(N'2022-05-18' AS Date), CAST(N'19:39:50.9033333' AS Time))
INSERT [dbo].[back_up_employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco], [operacion], [fechaModificacion], [horaModificacion]) VALUES (248, N'Jandro', N'Loco', N'marto@ven.es', N'02020202', CAST(N'2011-05-05' AS Date), 3, CAST(15155.00 AS Decimal(8, 2)), 101, 7, N'Hijito', N'Modificada', CAST(N'2022-05-18' AS Date), CAST(N'19:50:57.0400000' AS Time))
INSERT [dbo].[back_up_employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco], [operacion], [fechaModificacion], [horaModificacion]) VALUES (248, N'Jandro', N'Loco', N'marto@ven.es', N'02020202', CAST(N'2011-05-05' AS Date), 3, CAST(15155.00 AS Decimal(8, 2)), 101, 7, N'Hijito', N'Eliminada', CAST(N'2022-05-18' AS Date), CAST(N'19:51:32.3366667' AS Time))
GO
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'AR', N'Argentina', 2)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'AU', N'Australia', 3)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'BE', N'Belgium', 1)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'BR', N'Brazil', 2)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'CA', N'Canada', 2)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'CH', N'Switzerland', 1)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'CN', N'China', 3)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'DE', N'Germany', 1)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'DK', N'Denmark', 1)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'EG', N'Egypt', 4)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'FR', N'France', 1)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'HK', N'HongKong', 3)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'IL', N'Israel', 4)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'IN', N'India', 3)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'IT', N'Italy', 1)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'JP', N'Japan', 3)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'KW', N'Kuwait', 4)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'MX', N'Mexico', 2)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'NG', N'Nigeria', 4)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'NL', N'Netherlands', 1)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'SG', N'Singapore', 3)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'UK', N'United Kingdom', 1)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'US', N'United States of America', 2)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'ZM', N'Zambia', 4)
INSERT [dbo].[countries] ([country_id], [country_name], [FK_region]) VALUES (N'ZW', N'Zimbabwe', 4)
GO
SET IDENTITY_INSERT [dbo].[Cuenta] ON 

INSERT [dbo].[Cuenta] ([IdCuenta], [NumCuenta], [Saldo]) VALUES (1, N'ES0004454', -1500.0000)
INSERT [dbo].[Cuenta] ([IdCuenta], [NumCuenta], [Saldo]) VALUES (5, N'ES00041231', 300.0000)
INSERT [dbo].[Cuenta] ([IdCuenta], [NumCuenta], [Saldo]) VALUES (3, N'ES0004123', 3600.0000)
INSERT [dbo].[Cuenta] ([IdCuenta], [NumCuenta], [Saldo]) VALUES (2, N'ES0006576', 4000.0000)
INSERT [dbo].[Cuenta] ([IdCuenta], [NumCuenta], [Saldo]) VALUES (4, N'ES00041236', 66564.0000)
INSERT [dbo].[Cuenta] ([IdCuenta], [NumCuenta], [Saldo]) VALUES (8, N'ES0004124', 90909090.0000)
SET IDENTITY_INSERT [dbo].[Cuenta] OFF
GO
SET IDENTITY_INSERT [dbo].[departments] ON 

INSERT [dbo].[departments] ([department_id], [department_name], [FK_location]) VALUES (1, N'Administration', 1700)
INSERT [dbo].[departments] ([department_id], [department_name], [FK_location]) VALUES (2, N'Marketing', 1800)
INSERT [dbo].[departments] ([department_id], [department_name], [FK_location]) VALUES (3, N'Purchasing', 1700)
INSERT [dbo].[departments] ([department_id], [department_name], [FK_location]) VALUES (4, N'Human Resources', 2400)
INSERT [dbo].[departments] ([department_id], [department_name], [FK_location]) VALUES (5, N'Shipping', 1500)
INSERT [dbo].[departments] ([department_id], [department_name], [FK_location]) VALUES (6, N'IT', 1400)
INSERT [dbo].[departments] ([department_id], [department_name], [FK_location]) VALUES (7, N'Public Relations', 2700)
INSERT [dbo].[departments] ([department_id], [department_name], [FK_location]) VALUES (8, N'Sales', 2500)
INSERT [dbo].[departments] ([department_id], [department_name], [FK_location]) VALUES (9, N'Executive', 1700)
INSERT [dbo].[departments] ([department_id], [department_name], [FK_location]) VALUES (10, N'Finance', 1700)
INSERT [dbo].[departments] ([department_id], [department_name], [FK_location]) VALUES (11, N'Accounting', 1700)
SET IDENTITY_INSERT [dbo].[departments] OFF
GO
SET IDENTITY_INSERT [dbo].[dependents] ON 

INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (1, N'Penelope', N'Gietz', N'Child', 206)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (2, N'Nick', N'Higgins', N'Child', 205)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (3, N'Ed', N'Whalen', N'Child', 200)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (4, N'Jennifer', N'King', N'Child', 100)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (5, N'Johnny', N'Kochhar', N'Child', 101)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (6, N'Bette', N'De Haan', N'Child', 102)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (7, N'Grace', N'Faviet', N'Child', 109)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (8, N'Matthew', N'Chen', N'Child', 110)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (9, N'Joe', N'Sciarra', N'Child', 111)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (10, N'Christian', N'Urman', N'Child', 112)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (11, N'Zero', N'Popp', N'Child', 113)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (12, N'Karl', N'Greenberg', N'Child', 108)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (13, N'Uma', N'Mavris', N'Child', 203)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (14, N'Vivien', N'Hunold', N'Child', 103)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (15, N'Cuba', N'Ernst', N'Child', 104)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (16, N'Fred', N'Austin', N'Child', 105)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (17, N'Helen', N'Pataballa', N'Child', 106)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (18, N'Dan', N'Lorentz', N'Child', 107)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (21, N'Kirsten', N'Baer', N'Child', 204)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (22, N'Elvis', N'Khoo', N'Child', 115)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (23, N'Sandra', N'Baida', N'Child', 116)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (24, N'Cameron', N'Tobias', N'Child', 117)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (25, N'Kevin', N'Himuro', N'Child', 118)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (26, N'Rip', N'Colmenares', N'Child', 119)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (27, N'Julia', N'Raphaely', N'Child', 114)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (28, N'Woody', N'Russell', N'Child', 145)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (29, N'Alec', N'Partners', N'Child', 146)
INSERT [dbo].[dependents] ([dependent_id], [first_name], [last_name], [relationship], [FK_employee]) VALUES (30, N'Sandra', N'Taylor', N'Child', 176)
SET IDENTITY_INSERT [dbo].[dependents] OFF
GO
SET IDENTITY_INSERT [dbo].[employees] ON 

INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (100, N'Steven', N'King', N'steven.king@sqltutorial.org', N'515.123.4567', CAST(N'1987-06-17' AS Date), 4, CAST(29040.00 AS Decimal(8, 2)), NULL, 9, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (101, N'Neena', N'Kochhar', N'neena.kochhar@sqltutorial.org', N'515.123.4568', CAST(N'1989-09-21' AS Date), 5, CAST(20570.00 AS Decimal(8, 2)), 100, 9, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (102, N'Lex', N'De Haan', N'lex.de haan@sqltutorial.org', N'515.123.4569', CAST(N'1993-01-13' AS Date), 5, CAST(20570.00 AS Decimal(8, 2)), 100, 9, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (103, N'Alexander', N'Hunold', N'alexander.hunold@sqltutorial.org', N'590.423.4567', CAST(N'1990-01-03' AS Date), 9, CAST(10890.00 AS Decimal(8, 2)), 102, 6, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (104, N'Bruce', N'Ernst', N'bruce.ernst@sqltutorial.org', N'590.423.4568', CAST(N'1991-05-21' AS Date), 9, CAST(7260.00 AS Decimal(8, 2)), 103, 6, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (105, N'David', N'Austin', N'david.austin@sqltutorial.org', N'590.423.4569', CAST(N'1997-06-25' AS Date), 9, CAST(5808.00 AS Decimal(8, 2)), 103, 6, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (106, N'Valli', N'Pataballa', N'valli.pataballa@sqltutorial.org', N'590.423.4560', CAST(N'1998-02-05' AS Date), 9, CAST(5808.00 AS Decimal(8, 2)), 103, 6, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (107, N'Diana', N'Lorentz', N'diana.lorentz@sqltutorial.org', N'590.423.5567', CAST(N'1999-02-07' AS Date), 9, CAST(5082.00 AS Decimal(8, 2)), 103, 6, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (108, N'Nancy', N'Greenberg', N'nancy.greenberg@sqltutorial.org', N'515.124.4569', CAST(N'1994-08-17' AS Date), 7, CAST(14520.00 AS Decimal(8, 2)), 101, 10, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (109, N'Daniel', N'Faviet', N'daniel.faviet@sqltutorial.org', N'515.124.4169', CAST(N'1994-08-16' AS Date), 6, CAST(10890.00 AS Decimal(8, 2)), 108, 10, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (110, N'John', N'Chen', N'john.chen@sqltutorial.org', N'515.124.4269', CAST(N'1997-09-28' AS Date), 6, CAST(9922.00 AS Decimal(8, 2)), 108, 10, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (111, N'Ismael', N'Sciarra', N'ismael.sciarra@sqltutorial.org', N'515.124.4369', CAST(N'1997-09-30' AS Date), 6, CAST(9317.00 AS Decimal(8, 2)), 108, 10, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (112, N'Jose Manuel', N'Urman', N'jose manuel.urman@sqltutorial.org', N'515.124.4469', CAST(N'1998-03-07' AS Date), 6, CAST(9438.00 AS Decimal(8, 2)), 108, 10, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (113, N'Luis', N'Popp', N'luis.popp@sqltutorial.org', N'515.124.4567', CAST(N'1999-12-07' AS Date), 6, CAST(8349.00 AS Decimal(8, 2)), 108, 10, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (114, N'Den', N'Raphaely', N'den.raphaely@sqltutorial.org', N'515.127.4561', CAST(N'1994-12-07' AS Date), 14, CAST(13310.00 AS Decimal(8, 2)), 100, 3, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (115, N'Alexander', N'Khoo', N'alexander.khoo@sqltutorial.org', N'515.127.4562', CAST(N'1995-05-18' AS Date), 13, CAST(3751.00 AS Decimal(8, 2)), 114, 3, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (116, N'Shelli', N'Baida', N'shelli.baida@sqltutorial.org', N'515.127.4563', CAST(N'1997-12-24' AS Date), 13, CAST(3509.00 AS Decimal(8, 2)), 114, 3, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (117, N'Sigal', N'Tobias', N'sigal.tobias@sqltutorial.org', N'515.127.4564', CAST(N'1997-07-24' AS Date), 13, CAST(3388.00 AS Decimal(8, 2)), 114, 3, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (118, N'Guy', N'Himuro', N'guy.himuro@sqltutorial.org', N'515.127.4565', CAST(N'1998-11-15' AS Date), 13, CAST(3146.00 AS Decimal(8, 2)), 114, 3, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (119, N'Karen', N'Colmenares', N'karen.colmenares@sqltutorial.org', N'515.127.4566', CAST(N'1999-08-10' AS Date), 13, CAST(3025.00 AS Decimal(8, 2)), 114, 3, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (120, N'Matthew', N'Weiss', N'matthew.weiss@sqltutorial.org', N'650.123.1234', CAST(N'1996-07-18' AS Date), 19, CAST(9680.00 AS Decimal(8, 2)), 100, 5, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (121, N'Adam', N'Fripp', N'adam.fripp@sqltutorial.org', N'650.123.2234', CAST(N'1997-04-10' AS Date), 19, CAST(9922.00 AS Decimal(8, 2)), 100, 5, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (122, N'Payam', N'Kaufling', N'payam.kaufling@sqltutorial.org', N'650.123.3234', CAST(N'1995-05-01' AS Date), 19, CAST(9559.00 AS Decimal(8, 2)), 100, 5, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (123, N'Shanta', N'Vollman', N'shanta.vollman@sqltutorial.org', N'650.123.4234', CAST(N'1997-10-10' AS Date), 19, CAST(7865.00 AS Decimal(8, 2)), 100, 5, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (126, N'Irene', N'Mikkilineni', N'irene.mikkilineni@sqltutorial.org', N'650.124.1224', CAST(N'1998-09-28' AS Date), 18, CAST(3267.00 AS Decimal(8, 2)), 120, 5, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (145, N'John', N'Russell', N'john.russell@sqltutorial.org', NULL, CAST(N'1996-10-01' AS Date), 15, CAST(16940.00 AS Decimal(8, 2)), 100, 8, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (146, N'Karen', N'Partners', N'karen.partners@sqltutorial.org', NULL, CAST(N'1997-01-05' AS Date), 15, CAST(16335.00 AS Decimal(8, 2)), 100, 8, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (176, N'Jonathon', N'Taylor', N'jonathon.taylor@sqltutorial.org', NULL, CAST(N'1998-03-24' AS Date), 16, CAST(10406.00 AS Decimal(8, 2)), 100, 8, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (177, N'Jack', N'Livingston', N'jack.livingston@sqltutorial.org', NULL, CAST(N'1998-04-23' AS Date), 16, CAST(10164.00 AS Decimal(8, 2)), 100, 8, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (178, N'Kimberely', N'Grant', N'kimberely.grant@sqltutorial.org', NULL, CAST(N'1999-05-24' AS Date), 16, CAST(8470.00 AS Decimal(8, 2)), 100, 8, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (179, N'Charles', N'Johnson', N'charles.johnson@sqltutorial.org', NULL, CAST(N'2000-01-04' AS Date), 16, CAST(7502.00 AS Decimal(8, 2)), 100, 8, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (192, N'Sarah', N'Bell', N'sarah.bell@sqltutorial.org', N'650.501.1876', CAST(N'1996-02-04' AS Date), 17, CAST(4840.00 AS Decimal(8, 2)), 123, 5, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (193, N'Britney', N'Everett', N'britney.everett@sqltutorial.org', N'650.501.2876', CAST(N'1997-03-03' AS Date), 17, CAST(4719.00 AS Decimal(8, 2)), 123, 5, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (200, N'Jennifer', N'Whalen', N'jennifer.whalen@sqltutorial.org', N'515.123.4444', CAST(N'1987-09-17' AS Date), 3, CAST(5324.00 AS Decimal(8, 2)), 101, 1, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (203, N'Susan', N'Mavris', N'susan.mavris@sqltutorial.org', N'515.123.7777', CAST(N'1994-06-07' AS Date), 8, CAST(9438.00 AS Decimal(8, 2)), 101, 4, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (204, N'Hermann', N'Baer', N'hermann.baer@sqltutorial.org', N'515.123.8888', CAST(N'1994-06-07' AS Date), 12, CAST(12100.00 AS Decimal(8, 2)), 101, 7, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (205, N'Shelley', N'Higgins', N'shelley.higgins@sqltutorial.org', N'515.123.8080', CAST(N'1994-06-07' AS Date), 2, CAST(14520.00 AS Decimal(8, 2)), 101, 11, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (206, N'William', N'Gietz', N'william.gietz@sqltutorial.org', N'515.123.8181', CAST(N'1994-06-07' AS Date), 1, CAST(10043.00 AS Decimal(8, 2)), 205, 11, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (217, N'Penelope', N'Gietz', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (218, N'Nick', N'Higgins', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (219, N'Ed', N'Whalen', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (220, N'Jennifer', N'King', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (221, N'Johnny', N'Kochhar', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (222, N'Bette', N'De Haan', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (223, N'Grace', N'Faviet', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (224, N'Matthew', N'Chen', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (225, N'Joe', N'Sciarra', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (226, N'Christian', N'Urman', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (227, N'Zero', N'Popp', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (228, N'Karl', N'Greenberg', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (229, N'Uma', N'Mavris', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (230, N'Vivien', N'Hunold', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (231, N'Cuba', N'Ernst', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (232, N'Fred', N'Austin', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (233, N'Helen', N'Pataballa', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (234, N'Dan', N'Lorentz', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (235, N'Bob', N'Hartstein', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (236, N'Lucille', N'Fay', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (237, N'Kirsten', N'Baer', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (238, N'Elvis', N'Khoo', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (239, N'Sandra', N'Baida', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (240, N'Cameron', N'Tobias', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (241, N'Kevin', N'Himuro', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (242, N'Rip', N'Colmenares', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (243, N'Julia', N'Raphaely', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (244, N'Woody', N'Russell', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (245, N'Alec', N'Partners', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (246, N'Sandra', N'Taylor', N'trampas@gmail.com', NULL, CAST(N'1987-06-17' AS Date), 2, CAST(26620.00 AS Decimal(8, 2)), NULL, 3, N'Hijito')
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (247, N'Josep', N'Bartomeu', N'bartomeu@fcb.com', N'112', CAST(N'2022-01-01' AS Date), 2, CAST(14520.02 AS Decimal(8, 2)), NULL, 3, NULL)
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [email], [phone_number], [hire_date], [FK_job], [salary], [FK_manager], [FK_department], [Parentesco]) VALUES (248, N'Jandro', N'Loco', N'marto@ven.es', N'02020202', CAST(N'2011-05-05' AS Date), 3, CAST(15155.00 AS Decimal(8, 2)), 101, 7, N'Hijito')
SET IDENTITY_INSERT [dbo].[employees] OFF
GO
SET IDENTITY_INSERT [dbo].[jobs] ON 

INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (1, N'Public Accountant', CAST(4200.00 AS Decimal(8, 2)), CAST(9000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (2, N'Accounting Manager', CAST(8200.00 AS Decimal(8, 2)), CAST(16000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (3, N'Administration Assistant', CAST(3000.00 AS Decimal(8, 2)), CAST(6000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (4, N'President', CAST(20000.00 AS Decimal(8, 2)), CAST(40000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (5, N'Administration Vice President', CAST(15000.00 AS Decimal(8, 2)), CAST(30000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (6, N'Accountant', CAST(4200.00 AS Decimal(8, 2)), CAST(9000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (7, N'Finance Manager', CAST(8200.00 AS Decimal(8, 2)), CAST(16000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (8, N'Human Resources Representative', CAST(50.00 AS Decimal(8, 2)), CAST(9000.00 AS Decimal(8, 2)), N'Modificada')
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (9, N'Programmer', CAST(455.00 AS Decimal(8, 2)), CAST(10000.00 AS Decimal(8, 2)), N'Modificada')
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (10, N'Marketing Manager', CAST(9000.00 AS Decimal(8, 2)), CAST(15000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (11, N'Marketing Representative', CAST(4000.00 AS Decimal(8, 2)), CAST(9000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (12, N'Public Relations Representative', CAST(4500.00 AS Decimal(8, 2)), CAST(10500.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (13, N'Purchasing Clerk', CAST(2500.00 AS Decimal(8, 2)), CAST(5500.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (14, N'Purchasing Manager', CAST(8000.00 AS Decimal(8, 2)), CAST(15000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (15, N'Sales Manager', CAST(10000.00 AS Decimal(8, 2)), CAST(20000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (16, N'Sales Representative', CAST(6000.00 AS Decimal(8, 2)), CAST(12000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (17, N'Shipping Clerk', CAST(2500.00 AS Decimal(8, 2)), CAST(5500.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (18, N'Stock Clerk', CAST(2000.00 AS Decimal(8, 2)), CAST(5000.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (19, N'Stock Manager', CAST(5500.00 AS Decimal(8, 2)), CAST(8500.00 AS Decimal(8, 2)), NULL)
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (25, N'Stock Controller', CAST(52.00 AS Decimal(8, 2)), CAST(150.00 AS Decimal(8, 2)), N'Insertada')
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (27, N'Sales Assistant', CAST(3.00 AS Decimal(8, 2)), CAST(55.00 AS Decimal(8, 2)), N'Insertada')
INSERT [dbo].[jobs] ([job_id], [job_title], [min_salary], [max_salary], [Operacion]) VALUES (43, N'Market Controller', CAST(6600.00 AS Decimal(8, 2)), CAST(666600.00 AS Decimal(8, 2)), N'Modificada')
SET IDENTITY_INSERT [dbo].[jobs] OFF
GO
SET IDENTITY_INSERT [dbo].[locations] ON 

INSERT [dbo].[locations] ([location_id], [street_address], [postal_code], [city], [state_province], [FK_country]) VALUES (1400, N'2014 Jabberwocky Rd', N'26192', N'Southlake', N'Texas', N'US')
INSERT [dbo].[locations] ([location_id], [street_address], [postal_code], [city], [state_province], [FK_country]) VALUES (1500, N'2011 Interiors Blvd', N'99236', N'South San Francisco', N'California', N'US')
INSERT [dbo].[locations] ([location_id], [street_address], [postal_code], [city], [state_province], [FK_country]) VALUES (1700, N'2004 Charade Rd', N'98199', N'Seattle', N'Washington', N'US')
INSERT [dbo].[locations] ([location_id], [street_address], [postal_code], [city], [state_province], [FK_country]) VALUES (1800, N'147 Spadina Ave', N'M5V 2L7', N'Toronto', N'Ontario', N'CA')
INSERT [dbo].[locations] ([location_id], [street_address], [postal_code], [city], [state_province], [FK_country]) VALUES (2400, N'8204 Arthur St', NULL, N'London', NULL, N'UK')
INSERT [dbo].[locations] ([location_id], [street_address], [postal_code], [city], [state_province], [FK_country]) VALUES (2500, N'Magdalen Centre, The Oxford Science Park', N'OX9 9ZB', N'Oxford', N'Oxford', N'UK')
INSERT [dbo].[locations] ([location_id], [street_address], [postal_code], [city], [state_province], [FK_country]) VALUES (2700, N'Schwanthalerstr. 7031', N'80925', N'Munich', N'Bavaria', N'DE')
SET IDENTITY_INSERT [dbo].[locations] OFF
GO
INSERT [dbo].[log_count] ([NumRowsInserted], [NumRowsDeleted], [NumRowsUpdated], [ID_count]) VALUES (1, 8, 15, 1)
GO
SET IDENTITY_INSERT [dbo].[regions] ON 

INSERT [dbo].[regions] ([region_id], [region_name]) VALUES (1, N'Europe')
INSERT [dbo].[regions] ([region_id], [region_name]) VALUES (2, N'Americas')
INSERT [dbo].[regions] ([region_id], [region_name]) VALUES (3, N'Asia')
INSERT [dbo].[regions] ([region_id], [region_name]) VALUES (4, N'Middle East and Africa')
SET IDENTITY_INSERT [dbo].[regions] OFF
GO
ALTER TABLE [dbo].[countries] ADD  DEFAULT (NULL) FOR [country_name]
GO
ALTER TABLE [dbo].[departments] ADD  DEFAULT (NULL) FOR [FK_location]
GO
ALTER TABLE [dbo].[employees] ADD  DEFAULT (NULL) FOR [first_name]
GO
ALTER TABLE [dbo].[employees] ADD  DEFAULT (NULL) FOR [phone_number]
GO
ALTER TABLE [dbo].[employees] ADD  DEFAULT (NULL) FOR [FK_manager]
GO
ALTER TABLE [dbo].[employees] ADD  DEFAULT (NULL) FOR [FK_department]
GO
ALTER TABLE [dbo].[jobs] ADD  CONSTRAINT [DF__jobs__min_salary__440B1D61]  DEFAULT (NULL) FOR [min_salary]
GO
ALTER TABLE [dbo].[jobs] ADD  CONSTRAINT [DF__jobs__max_salary__44FF419A]  DEFAULT (NULL) FOR [max_salary]
GO
ALTER TABLE [dbo].[locations] ADD  DEFAULT (NULL) FOR [street_address]
GO
ALTER TABLE [dbo].[locations] ADD  DEFAULT (NULL) FOR [postal_code]
GO
ALTER TABLE [dbo].[locations] ADD  DEFAULT (NULL) FOR [state_province]
GO
ALTER TABLE [dbo].[regions] ADD  DEFAULT (NULL) FOR [region_name]
GO
ALTER TABLE [dbo].[countries]  WITH CHECK ADD FOREIGN KEY([FK_region])
REFERENCES [dbo].[regions] ([region_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[departments]  WITH CHECK ADD FOREIGN KEY([FK_location])
REFERENCES [dbo].[locations] ([location_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[dependents]  WITH CHECK ADD  CONSTRAINT [FK__dependent__emplo__5441852A] FOREIGN KEY([FK_employee])
REFERENCES [dbo].[employees] ([employee_id])
GO
ALTER TABLE [dbo].[dependents] CHECK CONSTRAINT [FK__dependent__emplo__5441852A]
GO
ALTER TABLE [dbo].[employees]  WITH CHECK ADD  CONSTRAINT [FK__employees__depar__5070F446] FOREIGN KEY([FK_department])
REFERENCES [dbo].[departments] ([department_id])
GO
ALTER TABLE [dbo].[employees] CHECK CONSTRAINT [FK__employees__depar__5070F446]
GO
ALTER TABLE [dbo].[employees]  WITH CHECK ADD  CONSTRAINT [FK__employees__job_i__4F7CD00D] FOREIGN KEY([FK_job])
REFERENCES [dbo].[jobs] ([job_id])
GO
ALTER TABLE [dbo].[employees] CHECK CONSTRAINT [FK__employees__job_i__4F7CD00D]
GO
ALTER TABLE [dbo].[employees]  WITH CHECK ADD FOREIGN KEY([FK_manager])
REFERENCES [dbo].[employees] ([employee_id])
GO
ALTER TABLE [dbo].[locations]  WITH CHECK ADD FOREIGN KEY([FK_country])
REFERENCES [dbo].[countries] ([country_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
/****** Object:  StoredProcedure [dbo].[AumentoSueldo]    Script Date: 09/06/2022 10:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[AumentoSueldo]
	@inc float,
	@idDpt int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE employees
	SET salary = salary * @inc
	WHERE @idDpt is null or FK_department=@idDpt
END
GO
/****** Object:  StoredProcedure [dbo].[contador_log]    Script Date: 09/06/2022 10:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[contador_log]
AS
BEGIN


	IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'log_count')
	BEGIN
		CREATE TABLE log_count(
			NumRowsInserted int,
			NumRowsDeleted int,
			NumRowsUpdated int,
			ID_count int PRIMARY KEY
		)
		INSERT INTO log_count(ID_count) VALUES(1)
	END

	
END
GO
/****** Object:  StoredProcedure [dbo].[table_backup]    Script Date: 09/06/2022 10:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[table_backup]
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'back_up_employees')
	CREATE TABLE [back_up_employees](
		[employee_id] [int] NOT NULL,
		[first_name] [varchar](20) NULL,
		[last_name] [varchar](25) NOT NULL,
		[email] [varchar](100) NOT NULL,
		[phone_number] [varchar](20) NULL,
		[hire_date] [date] NOT NULL,
		[FK_job] [int] NOT NULL,
		[salary] [decimal](8, 2) NOT NULL,
		[FK_manager] [int] NULL,
		[FK_department] [int] NULL,
		[Parentesco] [varchar](50) NULL,
		operacion [varchar](50) NULL,
		fechaModificacion date NULL,
		horaModificacion time null)

END
GO
/****** Object:  StoredProcedure [dbo].[testDinamic]    Script Date: 09/06/2022 10:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[testDinamic] @col varchar(50)
as
begin
	create table #table_tmp
		(
			first_name varchar(20)
		)
	declare @values nvarchar(200)
	declare @order varchar(60)

	set @values = N'insert into #table_tmp SELECT first_name from employees'
	set @order = N'select * from #table_tmp ORDER BY '+@col
	EXEC(@values)
	EXEC(@order)
END
GO
/****** Object:  StoredProcedure [dbo].[testDinamic_COUNT]    Script Date: 09/06/2022 10:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[testDinamic_COUNT] @col varchar(50)
as
begin
	set @col = N'SELECT COUNT(*) as NumFiles FROM '+@col 
	EXEC(@col)
END
GO
/****** Object:  Trigger [dbo].[TriggerInsteadOf_BackUp]    Script Date: 09/06/2022 10:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[TriggerInsteadOf_BackUp]
ON [dbo].[employees]
INSTEAD OF UPDATE, DELETE
AS
BEGIN
	SET NOCOUNT ON;
	EXEC table_backup	
	DECLARE @operation VARCHAR(100)
	SET @operation = 
		(CASE
			WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
				THEN 'Modificada'
			WHEN EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
				THEN 'Insertada'
			WHEN EXISTS(SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
				THEN 'Eliminada'
			ELSE NULL
		END)

	IF (@operation = 'Eliminada')
	BEGIN
		INSERT INTO back_up_employees
		SELECT e.*, @operation, GETDATE(), CONVERT (TIME, GETDATE()) FROM employees e
		inner join deleted d
			ON e.employee_id = d.employee_id
	END

	IF (@operation = 'Modificada')
	BEGIN
		INSERT INTO back_up_employees
		SELECT e.*, @operation, GETDATE(),CONVERT (TIME, GETDATE())  FROM employees e
		INNER JOIN inserted i
			ON e.employee_id = i.employee_id
		INNER JOIN deleted d
			ON i.employee_id=d.employee_id
	END
END
GO
ALTER TABLE [dbo].[employees] ENABLE TRIGGER [TriggerInsteadOf_BackUp]
GO
/****** Object:  Trigger [dbo].[Trigger4]    Script Date: 09/06/2022 10:40:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[Trigger4] 
ON [dbo].[jobs] 
AFTER UPDATE 
AS 
BEGIN
	DECLARE @count_ins INT
	SET @count_ins = (SELECT COUNT(*) FROM inserted)
	EXEC contador_log
	UPDATE log_count
		SET NumRowsUpdated = @count_ins+NumRowsUpdated
END
GO
ALTER TABLE [dbo].[jobs] ENABLE TRIGGER [Trigger4]
GO
/****** Object:  Trigger [dbo].[Trigger5]    Script Date: 09/06/2022 10:40:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[Trigger5]
ON [dbo].[jobs] 
AFTER INSERT
AS 
BEGIN
	DECLARE @count_ins INT
	SET @count_ins = (SELECT COUNT(*) FROM inserted)
	EXEC contador_log
	UPDATE log_count
		SET NumRowsUpdated = @count_ins+NumRowsUpdated
END
GO
ALTER TABLE [dbo].[jobs] ENABLE TRIGGER [Trigger5]
GO
/****** Object:  Trigger [dbo].[Trigger6]    Script Date: 09/06/2022 10:40:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[Trigger6] 
ON [dbo].[jobs] 
AFTER DELETE
AS 
BEGIN
	DECLARE @count_del INT
	SET @count_del = (SELECT COUNT(*) FROM deleted)
	EXEC contador_log
	UPDATE log_count
		SET NumRowsDeleted = @count_del+NumRowsDeleted
END
GO
ALTER TABLE [dbo].[jobs] ENABLE TRIGGER [Trigger6]
GO
/****** Object:  Trigger [dbo].[TriggerInsteadOfPlusUltra]    Script Date: 09/06/2022 10:40:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[TriggerInsteadOfPlusUltra] 
ON [dbo].[jobs]
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @operation VARCHAR(100)
	DECLARE @count_ins INT
	DECLARE @count_del INT
	SET @count_del = (SELECT COUNT(*) FROM deleted)
	SET @count_ins = (SELECT COUNT(*) FROM inserted)
	SET @operation = 
		(CASE
			WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
				THEN 'Modificada'
			WHEN EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
				THEN 'Insertada'
			WHEN EXISTS(SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
				THEN 'Eliminada'
			ELSE NULL
		END)
	IF (@operation = 'Insertada')
	INSERT INTO jobs(job_title, min_salary, max_salary)
	SELECT
        i.job_title, i.max_salary, i.min_salary
    FROM
        inserted i
    WHERE
        i.job_id NOT IN (
            SELECT 
                job_id
            FROM
                jobs
        );

	IF (@operation = 'Modificada')
	UPDATE jobs
	SET job_title = i.job_title, 
		min_salary = j.min_salary, --no se puede modificar
		max_salary = i.max_salary FROM jobs j
	INNER JOIN inserted i
		ON j.job_id = i.job_id
	INNER JOIN deleted d
		ON i.job_id=d.job_id

	
	IF (@operation = 'Eliminada')
	delete j from jobs j
	inner join deleted d
	ON j.job_id = d.job_id
END
GO
ALTER TABLE [dbo].[jobs] ENABLE TRIGGER [TriggerInsteadOfPlusUltra]
GO
/****** Object:  Trigger [dbo].[TriggerOperationColumn]    Script Date: 09/06/2022 10:40:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[TriggerOperationColumn] 
ON [dbo].[jobs]
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @operation VARCHAR(100)
	SET @operation = 
		(CASE
			WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
				THEN 'Modificada'
			WHEN EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
				THEN 'Insertada'
				ELSE NULL
		END)
 
	IF (@operation = 'Insertada')
		UPDATE k 
		SET k.Operacion = @operation FROM jobs k 
		where k.job_id IN (SELECT i.job_id FROM inserted i)
 
	IF (@operation = 'Modificada')
		UPDATE o 
		SET o.Operacion = @operation FROM jobs o 
		INNER JOIN deleted d 
			ON d.job_id = o.job_id
		INNER JOIN inserted i
			ON i.job_id = d.job_id

END
GO
ALTER TABLE [dbo].[jobs] ENABLE TRIGGER [TriggerOperationColumn]
GO
USE [master]
GO
ALTER DATABASE [Toni_Employees] SET  READ_WRITE 
GO
