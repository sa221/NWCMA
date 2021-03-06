USE [master]
GO
/****** Object:  Database [NWCMADB]    Script Date: 12/24/2015 1:10:39 AM ******/
CREATE DATABASE [NWCMADB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NWCMADB', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\NWCMADB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NWCMADB_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\NWCMADB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NWCMADB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NWCMADB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NWCMADB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NWCMADB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NWCMADB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NWCMADB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NWCMADB] SET ARITHABORT OFF 
GO
ALTER DATABASE [NWCMADB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NWCMADB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [NWCMADB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NWCMADB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NWCMADB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NWCMADB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NWCMADB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NWCMADB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NWCMADB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NWCMADB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NWCMADB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NWCMADB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NWCMADB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NWCMADB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NWCMADB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NWCMADB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NWCMADB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NWCMADB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NWCMADB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NWCMADB] SET  MULTI_USER 
GO
ALTER DATABASE [NWCMADB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NWCMADB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NWCMADB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NWCMADB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [NWCMADB]
GO
/****** Object:  StoredProcedure [dbo].[SpGetAllPatientHistoryByVoterId]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SpGetAllPatientHistoryByVoterId]
@voterId int
as
begin
    select tblPatient.name ,tblPatient.address , tblCenter.name as center_Name, tblPatientHistory.serviceDate , 
        tblDoctor.name as doctor_Name , tblPatientHistory.observation, tblDisease.name as disease_Name ,
		 tblMedicine.name as medicine_Name, tblDose.dose, tblTreatment.quantity , tblTreatment.note	
		       from  tblPatient join tblPatientHistory on  tblPatient.id = tblPatientHistory.patientId 
		                        join tblCenter on tblPatientHistory.centerId = tblCenter.id
		                        join tblDoctor on tblDoctor.id = tblPatientHistory.doctorId
								join tblTreatment on tblTreatment.treatmentHistoryId = tblPatientHistory.id
								join tblDisease on tblDisease.id = tblTreatment.diseaseId
								join tblMedicine on tblMedicine.id = tblTreatment.medicineId
								join tblDose on tblDose.id = tblTreatment.doseId								
	where tblPatient.voterId=@voterId
	
end

GO
/****** Object:  StoredProcedure [dbo].[SpGetMedicineNameAndQuantityByCenterId]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SpGetMedicineNameAndQuantityByCenterId] 
@centerId int
as
begin
		select tblMedicine.name , tblProvidedMedicine.quantity
		from tblMedicine join tblProvidedMedicine on tblMedicine.id=tblProvidedMedicine.medicineId
		where tblProvidedMedicine.centerId=@centerId
end


GO
/****** Object:  Table [dbo].[tblAdmin]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblAdmin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](max) NOT NULL,
	[password] [varchar](max) NOT NULL,
	[type] [int] NOT NULL,
	[name] [varchar](50) NULL,
 CONSTRAINT [PK_tblAdmin] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCenter]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCenter](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](200) NOT NULL,
	[code] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[tId] [int] NOT NULL,
	[dId] [int] NOT NULL,
	[type] [int] NOT NULL,
 CONSTRAINT [PK_tblCenter] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDisease]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDisease](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](200) NOT NULL,
	[description] [varchar](max) NOT NULL,
	[treatmentProcedure] [varchar](max) NOT NULL,
 CONSTRAINT [PK_tblDisease] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDistrict]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDistrict](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](200) NOT NULL,
	[population] [int] NOT NULL,
 CONSTRAINT [PK_tblDistrict] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDoctor]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDoctor](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](200) NOT NULL,
	[degree] [varchar](200) NOT NULL,
	[specialization] [varchar](200) NOT NULL,
	[centerId] [int] NOT NULL,
 CONSTRAINT [PK_tblDoctor] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDose]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDose](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dose] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblDose] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblMedicine]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblMedicine](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](200) NOT NULL,
 CONSTRAINT [PK_tblMedicine] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPatient]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPatient](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[voterId] [int] NOT NULL,
	[name] [varchar](max) NOT NULL,
	[address] [varchar](max) NOT NULL,
	[age] [int] NOT NULL,
 CONSTRAINT [PK_tblPatient] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPatientHistory]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPatientHistory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[serviceDate] [date] NOT NULL,
	[doctorId] [int] NOT NULL,
	[centerId] [int] NOT NULL,
	[observation] [varchar](max) NOT NULL,
	[patientId] [int] NOT NULL,
 CONSTRAINT [PK_tblPatientHistory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblProvidedMedicine]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProvidedMedicine](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[medicineId] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[centerId] [int] NOT NULL,
	[tId] [int] NOT NULL,
	[dId] [int] NOT NULL,
 CONSTRAINT [PK_tblProvidedMedicine] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThana]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblThana](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](200) NOT NULL,
	[dId] [int] NOT NULL,
 CONSTRAINT [PK_tblThana] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTreatment]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTreatment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[diseaseId] [int] NOT NULL,
	[medicineId] [int] NOT NULL,
	[doseId] [int] NOT NULL,
	[indicationId] [int] NOT NULL,
	[quantity] [int] NULL,
	[note] [varchar](max) NULL,
	[treatmentHistoryId] [int] NOT NULL,
	[patientId] [int] NOT NULL,
 CONSTRAINT [PK_tblTreatment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[tblLogin]    Script Date: 12/24/2015 1:10:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[tblLogin] as
select id ,code,password,type,name from tblAdmin
union all
select id, code,password,type,name from tblCenter



GO
SET IDENTITY_INSERT [dbo].[tblAdmin] ON 

INSERT [dbo].[tblAdmin] ([id], [code], [password], [type], [name]) VALUES (5, N'nwcma', N'12345', 1, N'Head Office')
SET IDENTITY_INSERT [dbo].[tblAdmin] OFF
SET IDENTITY_INSERT [dbo].[tblCenter] ON 

INSERT [dbo].[tblCenter] ([id], [name], [code], [password], [tId], [dId], [type]) VALUES (1, N'Center 1', N'1115', N'HU2anJN3', 6, 1, 2)
INSERT [dbo].[tblCenter] ([id], [name], [code], [password], [tId], [dId], [type]) VALUES (7, N'Balagonj Shastho Complex1', N'1882', N'2MYxPSyC', 3, 1, 2)
INSERT [dbo].[tblCenter] ([id], [name], [code], [password], [tId], [dId], [type]) VALUES (8, N'Balagonj Shastho Complex1', N'1150', N'JgWK9jk8', 4, 1, 2)
INSERT [dbo].[tblCenter] ([id], [name], [code], [password], [tId], [dId], [type]) VALUES (9, N'Balagonj Shastho Complex11', N'1156', N'J0JV8fG5', 3, 1, 2)
INSERT [dbo].[tblCenter] ([id], [name], [code], [password], [tId], [dId], [type]) VALUES (10, N'Balagonj Shastho Complex12', N'1327', N'Uvxt30Jx', 8, 6, 2)
INSERT [dbo].[tblCenter] ([id], [name], [code], [password], [tId], [dId], [type]) VALUES (11, N'Dhamrai Shastho Complex', N'1598', N'lW97QJpb', 8, 6, 2)
INSERT [dbo].[tblCenter] ([id], [name], [code], [password], [tId], [dId], [type]) VALUES (12, N'myCenter', N'1176', N'KNlTQKzM', 7, 1, 2)
INSERT [dbo].[tblCenter] ([id], [name], [code], [password], [tId], [dId], [type]) VALUES (13, N'test1', N'1702', N'rLnOVL9a', 3, 1, 2)
SET IDENTITY_INSERT [dbo].[tblCenter] OFF
SET IDENTITY_INSERT [dbo].[tblDisease] ON 

INSERT [dbo].[tblDisease] ([id], [name], [description], [treatmentProcedure]) VALUES (1, N'arrhythmias', N'Heart disease is often called a “silent killer”. Your doctor may not diagnose the disease until you show signs of a heart attack or heart failure. Symptoms of heart disease vary depending on the specific condition. For example, if you have a heart arrhythmia, symptoms may include:', N'eating a healthy diet rich in fiber, omega-3 fatty acids, fruits, and vegetables. Choose foods that are low in fat, sodium, and cholesterol to help control your blood pressure.
increasing physical activity to maintain a healthy weight, reduce your risk of diabetes, and improve cholesterol levels. Aim for at least 60 minutes of activity per week')
INSERT [dbo].[tblDisease] ([id], [name], [description], [treatmentProcedure]) VALUES (2, N'Parasites - Amebiasis', N'Amebiasis is a disease caused by the parasite Entamoeba histolytica. It can affect anyone, although it is more common in people who live in tropical areas with poor sanitary conditions. Diagnosis can be difficult because other parasites can look very similar to E. histolytica when seen under a microscope. ', N'Infected people do not always become sick. If your doctor determines that you are infected and need treatment, medication is available.')
INSERT [dbo].[tblDisease] ([id], [name], [description], [treatmentProcedure]) VALUES (3, N'Anemia', N'Anemia is a medical condition in which the red blood cell count or hemoglobin is less than normal.', N'Anemia can be detected by a simple blood test called a complete blood cell count (CBC).
The treatment of the anemia varies greatly and very much depends on the particular cause')
INSERT [dbo].[tblDisease] ([id], [name], [description], [treatmentProcedure]) VALUES (4, N'Low Blood Pressure ', N'Low blood pressure, also called hypotension, is blood pressure low enough that the flow of blood to the organs of the body is inadequate and symptoms and/or signs of low blood flow develop shock.', N'Treatment of low blood pressure is determined by the cause of the low pressure.')
INSERT [dbo].[tblDisease] ([id], [name], [description], [treatmentProcedure]) VALUES (5, N'Liver Blood Tests', N'The liver is located in the right upper portion of the abdominal cavity just beneath the rib cage. The liver has many functions that are vital to life. Briefly, some of the important functions of the human liver are:

Detoxification of blood
Production of important clotting factors, albumin, and many other important proteins', N'Among the most sensitive and widely used liver enzymes are the aminotransferases. They include aspartate aminotransferase (AST or SGOT) and alanine aminotransferase (ALT or SGPT). ')
INSERT [dbo].[tblDisease] ([id], [name], [description], [treatmentProcedure]) VALUES (6, N'Knee Pain', N'Knee pain is a common problem with many causes, from acute injuries to medical conditions.
Knee pain can be localized or diffuse throughout the knee.', N'Knee pain is a common problem that can originate in any of the bony structures compromising the knee joint (femur, tibia, fibula), the kneecap (patella),')
INSERT [dbo].[tblDisease] ([id], [name], [description], [treatmentProcedure]) VALUES (7, N'', N'', N'')
SET IDENTITY_INSERT [dbo].[tblDisease] OFF
SET IDENTITY_INSERT [dbo].[tblDistrict] ON 

INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (1, N'Sylhet', 3404000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (2, N'Sunamganj ', 2443000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (3, N'Moulvibazar ', 1902000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (5, N'Habiganj', 2059000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (6, N'Dhaka', 11875000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (7, N'Faridpur', 1867000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (8, N'Gazipur ', 3333000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (9, N'Gopalganj', 1149000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (10, N'Jamalpur', 2265000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (11, N'Kishoreganj ', 2853000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (12, N'Madaripur', 1149000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (13, N'Manikganj ', 1379000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (14, N'Munshiganj ', 1420000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (15, N'Mymensingh ', 5042000)
INSERT [dbo].[tblDistrict] ([id], [name], [population]) VALUES (16, N'Narayanganj ', 2897000)
SET IDENTITY_INSERT [dbo].[tblDistrict] OFF
SET IDENTITY_INSERT [dbo].[tblDoctor] ON 

INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (1, N'mhg', N'fbf', N'fgb', 1)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (2, N'Mamun', N'MBBS', N'Medicine', 0)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (3, N'Mamun', N'MBBS', N'Medicine', 0)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (4, N'Mamun', N'MBBS', N'Medicine', 0)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (5, N'Mamun', N'MBBS', N'Medicine', 0)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (6, N'Mamun', N'MBBS', N'Medicine', 0)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (7, N'Mamun', N'MBBS', N'Medicine', 0)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (8, N'Mamun', N'MBBS', N'Medicine', 0)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (9, N'Mamun', N'MBBS', N'Medicine', 0)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (10, N'Mamun', N'MBBS', N'Medicine', 1)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (11, N'Mamun', N'MBBS', N'Medicine', 1)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (12, N'Mamun Ahmed', N'MBBS', N'Medicine', 1)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (1002, N'New Dr', N'hfdhfd', N'reteyt', 0)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (1003, N'sgcvsa', N'sdcs', N'Medicine', 0)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (1004, N'Jamal', N'MBBS', N'e ufye', 12)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (1005, N'XYZ', N'FCPS', N'222', 1)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (1006, N'XYZ', N'FCPS', N'222', 7)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (1007, N'ABCD', N'FCPS', N'222', 7)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (1008, N'DEF', N'MBBS', N'EYE', 7)
INSERT [dbo].[tblDoctor] ([id], [name], [degree], [specialization], [centerId]) VALUES (1009, N'', N'', N'', 7)
SET IDENTITY_INSERT [dbo].[tblDoctor] OFF
SET IDENTITY_INSERT [dbo].[tblDose] ON 

INSERT [dbo].[tblDose] ([id], [dose]) VALUES (1, N'0+0+1')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (2, N'0+1+0')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (3, N'0+1+1')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (4, N'1+0+0')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (5, N'1+0+1')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (6, N'1+1+0')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (7, N'1+1+1')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (8, N'0+0+0')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (10, N'1/2+1/2+1/2')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (11, N'1/2+1+1/2')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (12, N'1/2+0+1/2')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (13, N'1+1/2+1/2')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (14, N'1+1/2+1')
INSERT [dbo].[tblDose] ([id], [dose]) VALUES (15, N'1/2+0+1/2')
SET IDENTITY_INSERT [dbo].[tblDose] OFF
SET IDENTITY_INSERT [dbo].[tblMedicine] ON 

INSERT [dbo].[tblMedicine] ([id], [name]) VALUES (22, N'Georaicen 100mg')
INSERT [dbo].[tblMedicine] ([id], [name]) VALUES (23, N'Napa 500mg')
INSERT [dbo].[tblMedicine] ([id], [name]) VALUES (21, N'NomgName 200')
INSERT [dbo].[tblMedicine] ([id], [name]) VALUES (24, N'Sedno 5mg')
SET IDENTITY_INSERT [dbo].[tblMedicine] OFF
SET IDENTITY_INSERT [dbo].[tblPatient] ON 

INSERT [dbo].[tblPatient] ([id], [voterId], [name], [address], [age]) VALUES (1, 1234, N'Mahmud', N'Sylhet', 26)
INSERT [dbo].[tblPatient] ([id], [voterId], [name], [address], [age]) VALUES (2, 10001, N'Hamid', N'Dhaka', 26)
INSERT [dbo].[tblPatient] ([id], [voterId], [name], [address], [age]) VALUES (3, 10002, N'Pavel', N'Dhaka', 27)
INSERT [dbo].[tblPatient] ([id], [voterId], [name], [address], [age]) VALUES (4, 4321, N'ahmed', N'dhaka', 25)
INSERT [dbo].[tblPatient] ([id], [voterId], [name], [address], [age]) VALUES (5, 7218, N'Yeasin', N'Dhaka', 25)
SET IDENTITY_INSERT [dbo].[tblPatient] OFF
SET IDENTITY_INSERT [dbo].[tblPatientHistory] ON 

INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (3, CAST(0xCE370B00 AS Date), 10, 10, N'Good', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (4, CAST(0xB4360B00 AS Date), 11, 11, N'Very good', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (5, CAST(0x9D380B00 AS Date), 11, 11, N'Good', 3)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (6, CAST(0xDC380B00 AS Date), 10, 10, N'Good', 3)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (7, CAST(0x8E3A0B00 AS Date), 1006, 7, N'Fever', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (8, CAST(0xAF3A0B00 AS Date), 10, 1, N'ghdfhb', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (9, CAST(0xB13A0B00 AS Date), 10, 1, N'sfew', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (10, CAST(0xA73A0B00 AS Date), 10, 1, N'good', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (11, CAST(0x9F3A0B00 AS Date), 1005, 1, N'good', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (12, CAST(0xAD3A0B00 AS Date), 1005, 1, N'good', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (13, CAST(0xA13A0B00 AS Date), 10, 1, N'dfg', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (14, CAST(0xA63A0B00 AS Date), 11, 1, N'good', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (15, CAST(0xA63A0B00 AS Date), 11, 1, N'good', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (16, CAST(0xB13A0B00 AS Date), 1, 1, N'bb', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (17, CAST(0xB53A0B00 AS Date), 11, 1, N'xbvx', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (18, CAST(0xB53A0B00 AS Date), 11, 1, N'xbvx', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (19, CAST(0xB43A0B00 AS Date), 1005, 1, N'vsvs', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (20, CAST(0xBD3A0B00 AS Date), 12, 1, N'dfd', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (21, CAST(0xC13A0B00 AS Date), 1007, 7, N'good', 5)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (22, CAST(0xC23A0B00 AS Date), 1007, 7, N'bad', 5)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (23, CAST(0xC73A0B00 AS Date), 1007, 7, N'good', 5)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (24, CAST(0xC73A0B00 AS Date), 1007, 7, N'good', 5)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (25, CAST(0xBC3A0B00 AS Date), 1006, 7, N'g', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (26, CAST(0xBC3A0B00 AS Date), 1007, 7, N'f', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (27, CAST(0xC23A0B00 AS Date), 1007, 7, N'good', 5)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (28, CAST(0xBC3A0B00 AS Date), 1007, 7, N'f', 5)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (29, CAST(0xBC3A0B00 AS Date), 1007, 7, N'f', 5)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (30, CAST(0xC03A0B00 AS Date), 1007, 7, N'as', 5)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (31, CAST(0xC13A0B00 AS Date), 1006, 7, N'd', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (32, CAST(0xC13A0B00 AS Date), 1006, 7, N'd', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (33, CAST(0xC13A0B00 AS Date), 1006, 7, N'd', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (34, CAST(0xC13A0B00 AS Date), 1006, 7, N'h', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (35, CAST(0xC13A0B00 AS Date), 1006, 7, N'h', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (36, CAST(0xC13A0B00 AS Date), 1006, 7, N'h', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (37, CAST(0xC33A0B00 AS Date), 1006, 7, N'ghghh', 2)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (38, CAST(0xC13A0B00 AS Date), 1006, 7, N'gh', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (39, CAST(0xC13A0B00 AS Date), 1006, 7, N'gh', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (40, CAST(0xC13A0B00 AS Date), 1006, 7, N'kj', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (41, CAST(0xC13A0B00 AS Date), 1006, 7, N'kj', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (42, CAST(0xC13A0B00 AS Date), 1006, 7, N'kj', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (43, CAST(0xC13A0B00 AS Date), 1006, 7, N'kj', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (44, CAST(0xC13A0B00 AS Date), 1006, 7, N'kj', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (45, CAST(0xC13A0B00 AS Date), 1006, 7, N'kj', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (46, CAST(0xC13A0B00 AS Date), 1006, 7, N'kj', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (47, CAST(0xD83A0B00 AS Date), 1006, 7, N'jfgjh', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (48, CAST(0xC13A0B00 AS Date), 1006, 7, N'a', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (49, CAST(0xC13A0B00 AS Date), 1006, 7, N'a', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (50, CAST(0xC13A0B00 AS Date), 1006, 7, N'a', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (51, CAST(0xC13A0B00 AS Date), 1006, 7, N'a', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (52, CAST(0xC13A0B00 AS Date), 1006, 7, N'hj', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (53, CAST(0xC13A0B00 AS Date), 1006, 7, N'hj', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (54, CAST(0xC13A0B00 AS Date), 1006, 7, N'hj', 1)
INSERT [dbo].[tblPatientHistory] ([id], [serviceDate], [doctorId], [centerId], [observation], [patientId]) VALUES (55, CAST(0xC13A0B00 AS Date), 1006, 7, N'j', 1)
SET IDENTITY_INSERT [dbo].[tblPatientHistory] OFF
SET IDENTITY_INSERT [dbo].[tblProvidedMedicine] ON 

INSERT [dbo].[tblProvidedMedicine] ([id], [medicineId], [quantity], [centerId], [tId], [dId]) VALUES (2, 22, 1034, 8, 4, 1)
INSERT [dbo].[tblProvidedMedicine] ([id], [medicineId], [quantity], [centerId], [tId], [dId]) VALUES (3, 22, 0, 7, 3, 1)
INSERT [dbo].[tblProvidedMedicine] ([id], [medicineId], [quantity], [centerId], [tId], [dId]) VALUES (4, 21, 34, 8, 4, 1)
INSERT [dbo].[tblProvidedMedicine] ([id], [medicineId], [quantity], [centerId], [tId], [dId]) VALUES (5, 22, 34, 1, 6, 1)
INSERT [dbo].[tblProvidedMedicine] ([id], [medicineId], [quantity], [centerId], [tId], [dId]) VALUES (6, 21, 20, 1, 6, 1)
INSERT [dbo].[tblProvidedMedicine] ([id], [medicineId], [quantity], [centerId], [tId], [dId]) VALUES (7, 21, 165, 7, 3, 1)
INSERT [dbo].[tblProvidedMedicine] ([id], [medicineId], [quantity], [centerId], [tId], [dId]) VALUES (8, 21, 6900, 9, 3, 1)
INSERT [dbo].[tblProvidedMedicine] ([id], [medicineId], [quantity], [centerId], [tId], [dId]) VALUES (9, 22, 92, 10, 8, 6)
INSERT [dbo].[tblProvidedMedicine] ([id], [medicineId], [quantity], [centerId], [tId], [dId]) VALUES (10, 21, 46, 10, 8, 6)
INSERT [dbo].[tblProvidedMedicine] ([id], [medicineId], [quantity], [centerId], [tId], [dId]) VALUES (11, 23, 1971, 7, 3, 1)
SET IDENTITY_INSERT [dbo].[tblProvidedMedicine] OFF
SET IDENTITY_INSERT [dbo].[tblThana] ON 

INSERT [dbo].[tblThana] ([id], [name], [dId]) VALUES (3, N'Balaganj', 1)
INSERT [dbo].[tblThana] ([id], [name], [dId]) VALUES (4, N'Beanibazar ', 1)
INSERT [dbo].[tblThana] ([id], [name], [dId]) VALUES (5, N'Bishwanath ', 1)
INSERT [dbo].[tblThana] ([id], [name], [dId]) VALUES (6, N'Companigonj ', 1)
INSERT [dbo].[tblThana] ([id], [name], [dId]) VALUES (7, N'Fenchuganj ', 1)
INSERT [dbo].[tblThana] ([id], [name], [dId]) VALUES (8, N'Dhamrai', 6)
INSERT [dbo].[tblThana] ([id], [name], [dId]) VALUES (9, N'Dohar ', 6)
INSERT [dbo].[tblThana] ([id], [name], [dId]) VALUES (10, N'Keraniganj', 6)
INSERT [dbo].[tblThana] ([id], [name], [dId]) VALUES (11, N'Nawabganj', 6)
INSERT [dbo].[tblThana] ([id], [name], [dId]) VALUES (12, N'Savar', 6)
SET IDENTITY_INSERT [dbo].[tblThana] OFF
SET IDENTITY_INSERT [dbo].[tblTreatment] ON 

INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (8, 2, 22, 2, 2, 20, N'fdgb gf', 3, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (9, 2, 21, 3, 2, 22, N'fvy ty', 4, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (10, 2, 21, 2, 1, 10, N'yv sd', 3, 2)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (11, 1, 22, 1, 2, 30, N'gsb asyg', 4, 2)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (12, 2, 22, 2, 2, 20, N'fhh  f', 4, 2)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (15, 2, 22, 2, 2, 20, N'ghjgfh', 5, 2)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (16, 3, 23, 5, 2, 10, N'come after 5 days', 7, 3)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (17, 6, 23, 13, 2, 10, N'come after 5 days', 8, 3)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (18, 4, 22, 13, 2, 10, N'come after 5 days', 9, 3)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (19, 6, 22, 11, 2, 0, N'', 14, 3)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (20, 6, 23, 15, 2, 2, N'good', 17, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (21, 1, 21, 5, 2, 10, N'good', 20, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (22, 5, 22, 12, 2, 20, N'come after 5 days', 21, 5)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (23, 1, 22, 11, 2, 10, N'come after 5 days', 26, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (24, 1, 22, 1, 2, 20, N'come after 5 days', 27, 5)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (25, 1, 22, 14, 2, 2, N'come after 5 days', 28, 5)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (26, 1, 22, 14, 2, 2, N'come after 5 days', 29, 5)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (27, 1, 22, 13, 2, 2, N'good', 30, 5)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (28, 1, 22, 1, 2, 2, N'', 31, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (29, 1, 22, 1, 2, 2, N'', 32, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (30, 1, 23, 1, 2, 2, N'', 32, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (31, 1, 22, 1, 2, 2, N'', 33, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (32, 1, 23, 1, 2, 2, N'', 33, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (33, 1, 22, 1, 1, 2, N'come after 5 days', 34, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (34, 1, 23, 1, 1, 2, N'come after 5 days', 34, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (35, 1, 22, 1, 1, 2, N'come after 5 days', 35, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (36, 1, 23, 1, 1, 2, N'come after 5 days', 35, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (37, 1, 22, 1, 1, 2, N'come after 5 days', 36, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (38, 1, 23, 1, 1, 2, N'come after 5 days', 36, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (39, 2, 22, 13, 2, 20, N'come after 5 days', 37, 2)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (40, 2, 21, 13, 2, 20, N'come after 5 days', 37, 2)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (41, 2, 22, 13, 2, 2, N'good', 38, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (42, 2, 21, 13, 2, 2, N'good', 38, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (43, 1, 21, 7, 2, 2, N'good', 38, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (44, 2, 22, 13, 2, 2, N'good', 39, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (45, 2, 21, 13, 2, 2, N'good', 39, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (46, 1, 21, 7, 2, 2, N'good', 39, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (47, 1, 22, 1, 2, 2, N'come after 5 days', 40, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (48, 1, 21, 1, 2, 20, N'come after 5 days', 40, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (49, 1, 22, 1, 2, 2, N'come after 5 days', 41, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (50, 1, 21, 1, 2, 20, N'come after 5 days', 41, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (51, 1, 22, 1, 2, 2, N'come after 5 days', 42, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (52, 1, 21, 1, 2, 20, N'come after 5 days', 42, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (53, 1, 22, 1, 2, 2, N'come after 5 days', 43, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (54, 1, 21, 1, 2, 20, N'come after 5 days', 43, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (55, 1, 22, 1, 2, 2, N'come after 5 days', 44, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (56, 1, 21, 1, 2, 20, N'come after 5 days', 44, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (57, 1, 22, 1, 2, 2, N'come after 5 days', 45, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (58, 1, 21, 1, 2, 20, N'come after 5 days', 45, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (59, 1, 22, 1, 2, 2, N'come after 5 days', 46, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (60, 1, 21, 1, 2, 20, N'come after 5 days', 46, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (61, 3, 22, 4, 2, 20, N'come after 5 days', 47, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (62, 1, 22, 1, 2, 5, N'come after 5 days', 48, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (63, 1, 22, 1, 2, 5, N'come after 5 days', 49, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (64, 1, 22, 1, 2, 5, N'come after 5 days', 49, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (65, 1, 21, 1, 2, 5, N'come after 5 days', 50, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (66, 1, 22, 1, 2, 5, N'come after 5 days', 50, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (67, 1, 23, 1, 2, 5, N'come after 5 days', 51, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (68, 1, 23, 1, 1, 10, N'&nbsp;', 54, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (69, 1, 21, 1, 2, 10, N'&nbsp;', 55, 1)
INSERT [dbo].[tblTreatment] ([id], [diseaseId], [medicineId], [doseId], [indicationId], [quantity], [note], [treatmentHistoryId], [patientId]) VALUES (70, 1, 23, 1, 2, 10, N'&nbsp;', 55, 1)
SET IDENTITY_INSERT [dbo].[tblTreatment] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tblDistrict]    Script Date: 12/24/2015 1:10:39 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblDistrict] ON [dbo].[tblDistrict]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tblMedicine]    Script Date: 12/24/2015 1:10:39 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblMedicine] ON [dbo].[tblMedicine]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tblThana]    Script Date: 12/24/2015 1:10:39 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblThana] ON [dbo].[tblThana]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblCenter]  WITH CHECK ADD  CONSTRAINT [FK_tblCenter_PK_tblDistrict] FOREIGN KEY([dId])
REFERENCES [dbo].[tblDistrict] ([id])
GO
ALTER TABLE [dbo].[tblCenter] CHECK CONSTRAINT [FK_tblCenter_PK_tblDistrict]
GO
ALTER TABLE [dbo].[tblCenter]  WITH CHECK ADD  CONSTRAINT [FK_tblCenter_tblThana] FOREIGN KEY([tId])
REFERENCES [dbo].[tblThana] ([id])
GO
ALTER TABLE [dbo].[tblCenter] CHECK CONSTRAINT [FK_tblCenter_tblThana]
GO
ALTER TABLE [dbo].[tblDoctor]  WITH CHECK ADD  CONSTRAINT [FK_tblDoctor_tblDoctor] FOREIGN KEY([id])
REFERENCES [dbo].[tblDoctor] ([id])
GO
ALTER TABLE [dbo].[tblDoctor] CHECK CONSTRAINT [FK_tblDoctor_tblDoctor]
GO
ALTER TABLE [dbo].[tblPatientHistory]  WITH CHECK ADD  CONSTRAINT [FK_tblPatientHistory_PK_tblCenter] FOREIGN KEY([centerId])
REFERENCES [dbo].[tblCenter] ([id])
GO
ALTER TABLE [dbo].[tblPatientHistory] CHECK CONSTRAINT [FK_tblPatientHistory_PK_tblCenter]
GO
ALTER TABLE [dbo].[tblPatientHistory]  WITH CHECK ADD  CONSTRAINT [FK_tblPatientHistory_PK_tblDoctor] FOREIGN KEY([doctorId])
REFERENCES [dbo].[tblDoctor] ([id])
GO
ALTER TABLE [dbo].[tblPatientHistory] CHECK CONSTRAINT [FK_tblPatientHistory_PK_tblDoctor]
GO
ALTER TABLE [dbo].[tblPatientHistory]  WITH CHECK ADD  CONSTRAINT [FK_tblPatientHistory_PK_tblPatient] FOREIGN KEY([patientId])
REFERENCES [dbo].[tblPatient] ([id])
GO
ALTER TABLE [dbo].[tblPatientHistory] CHECK CONSTRAINT [FK_tblPatientHistory_PK_tblPatient]
GO
ALTER TABLE [dbo].[tblProvidedMedicine]  WITH CHECK ADD  CONSTRAINT [FK_tblProvidedMedicine_tblCenter] FOREIGN KEY([centerId])
REFERENCES [dbo].[tblCenter] ([id])
GO
ALTER TABLE [dbo].[tblProvidedMedicine] CHECK CONSTRAINT [FK_tblProvidedMedicine_tblCenter]
GO
ALTER TABLE [dbo].[tblProvidedMedicine]  WITH CHECK ADD  CONSTRAINT [FK_tblProvidedMedicine_tblDistrict] FOREIGN KEY([dId])
REFERENCES [dbo].[tblDistrict] ([id])
GO
ALTER TABLE [dbo].[tblProvidedMedicine] CHECK CONSTRAINT [FK_tblProvidedMedicine_tblDistrict]
GO
ALTER TABLE [dbo].[tblProvidedMedicine]  WITH CHECK ADD  CONSTRAINT [FK_tblProvidedMedicine_tblMedicine] FOREIGN KEY([medicineId])
REFERENCES [dbo].[tblMedicine] ([id])
GO
ALTER TABLE [dbo].[tblProvidedMedicine] CHECK CONSTRAINT [FK_tblProvidedMedicine_tblMedicine]
GO
ALTER TABLE [dbo].[tblProvidedMedicine]  WITH CHECK ADD  CONSTRAINT [FK_tblProvidedMedicine_tblThana] FOREIGN KEY([tId])
REFERENCES [dbo].[tblThana] ([id])
GO
ALTER TABLE [dbo].[tblProvidedMedicine] CHECK CONSTRAINT [FK_tblProvidedMedicine_tblThana]
GO
ALTER TABLE [dbo].[tblThana]  WITH CHECK ADD  CONSTRAINT [FK_tblThana_PK_tblThana] FOREIGN KEY([dId])
REFERENCES [dbo].[tblDistrict] ([id])
GO
ALTER TABLE [dbo].[tblThana] CHECK CONSTRAINT [FK_tblThana_PK_tblThana]
GO
ALTER TABLE [dbo].[tblTreatment]  WITH CHECK ADD  CONSTRAINT [FK_tblTreatment_PK_tblDisease] FOREIGN KEY([diseaseId])
REFERENCES [dbo].[tblDisease] ([id])
GO
ALTER TABLE [dbo].[tblTreatment] CHECK CONSTRAINT [FK_tblTreatment_PK_tblDisease]
GO
ALTER TABLE [dbo].[tblTreatment]  WITH CHECK ADD  CONSTRAINT [FK_tblTreatment_PK_tblDose] FOREIGN KEY([doseId])
REFERENCES [dbo].[tblDose] ([id])
GO
ALTER TABLE [dbo].[tblTreatment] CHECK CONSTRAINT [FK_tblTreatment_PK_tblDose]
GO
ALTER TABLE [dbo].[tblTreatment]  WITH CHECK ADD  CONSTRAINT [FK_tblTreatment_PK_tblMedicine] FOREIGN KEY([medicineId])
REFERENCES [dbo].[tblMedicine] ([id])
GO
ALTER TABLE [dbo].[tblTreatment] CHECK CONSTRAINT [FK_tblTreatment_PK_tblMedicine]
GO
ALTER TABLE [dbo].[tblTreatment]  WITH CHECK ADD  CONSTRAINT [FK_tblTreatment_PK_tblPatientHistory] FOREIGN KEY([treatmentHistoryId])
REFERENCES [dbo].[tblPatientHistory] ([id])
GO
ALTER TABLE [dbo].[tblTreatment] CHECK CONSTRAINT [FK_tblTreatment_PK_tblPatientHistory]
GO
ALTER TABLE [dbo].[tblTreatment]  WITH CHECK ADD  CONSTRAINT [FK_tblTreatment_tblPatient] FOREIGN KEY([patientId])
REFERENCES [dbo].[tblPatient] ([id])
GO
ALTER TABLE [dbo].[tblTreatment] CHECK CONSTRAINT [FK_tblTreatment_tblPatient]
GO
USE [master]
GO
ALTER DATABASE [NWCMADB] SET  READ_WRITE 
GO
