USE [master]
GO
/****** Object:  Database [EStashWallet]    Script Date: 12/12/2024 2:53:00 pm ******/
CREATE DATABASE [EStashWallet]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EStashWallet', FILENAME = N'C:\DATA\MSSQL2019\EStashWallet.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EStashWallet_log', FILENAME = N'C:\DATA\MSSQL2019\EStashWallet_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EStashWallet].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EStashWallet] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EStashWallet] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EStashWallet] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EStashWallet] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EStashWallet] SET ARITHABORT OFF 
GO
ALTER DATABASE [EStashWallet] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EStashWallet] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EStashWallet] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EStashWallet] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EStashWallet] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EStashWallet] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EStashWallet] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EStashWallet] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EStashWallet] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EStashWallet] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EStashWallet] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EStashWallet] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EStashWallet] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EStashWallet] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EStashWallet] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EStashWallet] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EStashWallet] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EStashWallet] SET RECOVERY FULL 
GO
ALTER DATABASE [EStashWallet] SET  MULTI_USER 
GO
ALTER DATABASE [EStashWallet] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EStashWallet] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EStashWallet] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EStashWallet] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EStashWallet] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EStashWallet', N'ON'
GO
ALTER DATABASE [EStashWallet] SET QUERY_STORE = OFF
GO
USE [EStashWallet]
GO
/****** Object:  UserDefinedFunction [dbo].[fnMD5]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnMD5](@InputString VARCHAR(4000))
RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @PasswordHash VARCHAR(100)
DECLARE @HashThis nvarchar(4000);

SELECT @HashThis = CONVERT(nvarchar(4000),@InputString);
SET @PasswordHash = CONVERT(VARCHAR(32), HashBytes('MD5', @HashThis),2);

RETURN @PasswordHash;
END

GO
/****** Object:  Table [dbo].[tblAgent]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAgent](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NULL,
	[Code] [varchar](50) NULL,
	[EmailAddress] [varchar](100) NULL,
	[EmailAddress2] [varchar](100) NULL,
	[MobileNumber] [varchar](20) NULL,
	[MobileNumber2] [varchar](20) NULL,
	[CreationDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NULL,
	[Approved] [bit] NOT NULL,
	[ApprovedBy] [varchar](50) NULL,
	[ApprovedDate] [datetime] NULL,
	[Balance] [decimal](38, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblApplicationRole]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblApplicationRole](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[RoleName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCashOut]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCashOut](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[TerminalID] [int] NULL,
	[WalletID] [int] NULL,
	[SourceAccount] [varchar](20) NULL,
	[DestinationMobile] [varchar](20) NULL,
	[DestinationAccount] [varchar](20) NULL,
	[TransactionAmount] [decimal](38, 2) NULL,
	[VoucherNumber] [varchar](20) NULL,
	[OTP] [varchar](10) NULL,
	[Redeemed] [bit] NOT NULL,
	[RedeemedDate] [datetime] NULL,
	[OTPExpiryDate] [datetime] NULL,
	[ExpiryDate] [datetime] NULL,
	[Expired] [bit] NOT NULL,
	[Refunded] [bit] NOT NULL,
	[RefundedDate] [datetime] NULL,
	[RefundReference] [varchar](50) NULL,
	[RedemptionReference] [varchar](50) NULL,
	[OTPExpired] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTerminal]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTerminal](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AgentID] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[TerminalID] [varchar](50) NULL,
	[AccessKey] [varchar](50) NULL,
	[Balance] [decimal](38, 2) NULL,
	[MaximumTxnValue] [decimal](38, 2) NULL,
	[MinimumTxnValue] [decimal](38, 2) NULL,
	[Active] [bit] NOT NULL,
	[CreationDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[Approved] [bit] NOT NULL,
	[ApprovedBy] [varchar](50) NULL,
	[ApprovedDate] [datetime] NULL,
	[AllowJSON] [bit] NOT NULL,
	[AllowXML] [bit] NOT NULL,
	[AllowISO8583] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](50) NULL,
	[EmailAddress] [varchar](20) NULL,
	[Password] [varchar](50) NULL,
	[CreationDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NULL,
	[Approved] [bit] NOT NULL,
	[ApprovedBy] [varchar](50) NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblAgent] ON 

INSERT [dbo].[tblAgent] ([ID], [Name], [Code], [EmailAddress], [EmailAddress2], [MobileNumber], [MobileNumber2], [CreationDate], [CreatedBy], [Approved], [ApprovedBy], [ApprovedDate], [Balance]) VALUES (1, N'AMOL', N'AMOL', N'absapoc@absa.africa', N'', N'260972702708', N'', CAST(N'2024-12-12T04:25:27.210' AS DateTime), N'System', 0, NULL, NULL, CAST(0.00 AS Decimal(38, 2)))
SET IDENTITY_INSERT [dbo].[tblAgent] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCashOut] ON 

INSERT [dbo].[tblCashOut] ([ID], [CreationDate], [TerminalID], [WalletID], [SourceAccount], [DestinationMobile], [DestinationAccount], [TransactionAmount], [VoucherNumber], [OTP], [Redeemed], [RedeemedDate], [OTPExpiryDate], [ExpiryDate], [Expired], [Refunded], [RefundedDate], [RefundReference], [RedemptionReference], [OTPExpired]) VALUES (1, CAST(N'2024-12-12T02:50:45.587' AS DateTime), NULL, NULL, N'82934', N'260967234567', N'260973443223', CAST(3234.00 AS Decimal(38, 2)), N'943090280446', N'99029', 0, NULL, CAST(N'2024-12-12T02:55:45.587' AS DateTime), CAST(N'2024-12-12T03:50:45.587' AS DateTime), 1, 0, NULL, NULL, NULL, 0)
INSERT [dbo].[tblCashOut] ([ID], [CreationDate], [TerminalID], [WalletID], [SourceAccount], [DestinationMobile], [DestinationAccount], [TransactionAmount], [VoucherNumber], [OTP], [Redeemed], [RedeemedDate], [OTPExpiryDate], [ExpiryDate], [Expired], [Refunded], [RefundedDate], [RefundReference], [RedemptionReference], [OTPExpired]) VALUES (2, CAST(N'2024-12-12T07:07:29.930' AS DateTime), NULL, NULL, N'2234325', N'260967234567', N'260967234567', CAST(500.00 AS Decimal(38, 2)), N'414307030615', N'14344', 1, CAST(N'2024-12-12T07:17:17.177' AS DateTime), CAST(N'2024-12-12T07:12:29.923' AS DateTime), CAST(N'2024-12-12T08:07:29.923' AS DateTime), 0, 0, NULL, NULL, N'00122123111', 0)
INSERT [dbo].[tblCashOut] ([ID], [CreationDate], [TerminalID], [WalletID], [SourceAccount], [DestinationMobile], [DestinationAccount], [TransactionAmount], [VoucherNumber], [OTP], [Redeemed], [RedeemedDate], [OTPExpiryDate], [ExpiryDate], [Expired], [Refunded], [RefundedDate], [RefundReference], [RedemptionReference], [OTPExpired]) VALUES (3, CAST(N'2024-12-12T08:54:30.663' AS DateTime), NULL, NULL, N'2234325', N'260967234567', N'260967234567', CAST(500.00 AS Decimal(38, 2)), N'811146337690', N'68656', 1, CAST(N'2024-12-12T08:54:51.817' AS DateTime), CAST(N'2024-12-12T08:59:30.663' AS DateTime), CAST(N'2024-12-12T09:54:30.663' AS DateTime), 0, 0, NULL, NULL, N'00122123111', 0)
INSERT [dbo].[tblCashOut] ([ID], [CreationDate], [TerminalID], [WalletID], [SourceAccount], [DestinationMobile], [DestinationAccount], [TransactionAmount], [VoucherNumber], [OTP], [Redeemed], [RedeemedDate], [OTPExpiryDate], [ExpiryDate], [Expired], [Refunded], [RefundedDate], [RefundReference], [RedemptionReference], [OTPExpired]) VALUES (4, CAST(N'2024-12-12T11:38:14.613' AS DateTime), NULL, NULL, N'2234325', N'260967234567', N'260967234567', CAST(500.00 AS Decimal(38, 2)), N'321863543142', N'49438', 1, CAST(N'2024-12-12T11:39:23.253' AS DateTime), CAST(N'2024-12-12T11:43:14.613' AS DateTime), CAST(N'2024-12-12T12:38:14.613' AS DateTime), 0, 0, NULL, NULL, N'00122123111', 0)
INSERT [dbo].[tblCashOut] ([ID], [CreationDate], [TerminalID], [WalletID], [SourceAccount], [DestinationMobile], [DestinationAccount], [TransactionAmount], [VoucherNumber], [OTP], [Redeemed], [RedeemedDate], [OTPExpiryDate], [ExpiryDate], [Expired], [Refunded], [RefundedDate], [RefundReference], [RedemptionReference], [OTPExpired]) VALUES (5, CAST(N'2024-12-12T11:40:47.357' AS DateTime), NULL, NULL, N'2234325', N'260967234567', N'260967234567', CAST(400.00 AS Decimal(38, 2)), N'457428005906', N'55180', 1, CAST(N'2024-12-12T11:41:26.910' AS DateTime), CAST(N'2024-12-12T11:45:47.357' AS DateTime), CAST(N'2024-12-12T12:40:47.357' AS DateTime), 0, 0, NULL, NULL, N'00122123111', 0)
INSERT [dbo].[tblCashOut] ([ID], [CreationDate], [TerminalID], [WalletID], [SourceAccount], [DestinationMobile], [DestinationAccount], [TransactionAmount], [VoucherNumber], [OTP], [Redeemed], [RedeemedDate], [OTPExpiryDate], [ExpiryDate], [Expired], [Refunded], [RefundedDate], [RefundReference], [RedemptionReference], [OTPExpired]) VALUES (6, CAST(N'2024-12-12T12:07:59.947' AS DateTime), NULL, NULL, N'2234325', N'260967234567', N'260967234567', CAST(400.00 AS Decimal(38, 2)), N'904939512356', N'55242', 0, NULL, CAST(N'2024-12-12T12:12:59.947' AS DateTime), CAST(N'2024-12-12T13:07:59.947' AS DateTime), 0, 0, NULL, NULL, NULL, 0)
INSERT [dbo].[tblCashOut] ([ID], [CreationDate], [TerminalID], [WalletID], [SourceAccount], [DestinationMobile], [DestinationAccount], [TransactionAmount], [VoucherNumber], [OTP], [Redeemed], [RedeemedDate], [OTPExpiryDate], [ExpiryDate], [Expired], [Refunded], [RefundedDate], [RefundReference], [RedemptionReference], [OTPExpired]) VALUES (7, CAST(N'2024-12-12T14:39:47.060' AS DateTime), NULL, NULL, N'2234325', N'260967234567', N'260967234567', CAST(400.00 AS Decimal(38, 2)), N'515822575259', N'20907', 0, NULL, CAST(N'2024-12-12T14:44:47.060' AS DateTime), CAST(N'2024-12-12T15:39:47.060' AS DateTime), 0, 0, NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[tblCashOut] OFF
GO
SET IDENTITY_INSERT [dbo].[tblTerminal] ON 

INSERT [dbo].[tblTerminal] ([ID], [AgentID], [Name], [TerminalID], [AccessKey], [Balance], [MaximumTxnValue], [MinimumTxnValue], [Active], [CreationDate], [CreatedBy], [Approved], [ApprovedBy], [ApprovedDate], [AllowJSON], [AllowXML], [AllowISO8583]) VALUES (1, 1, N'CELLULANT', N'CELLULANT', N'3E2BC7D2C8AE3D6CE2DC0B62C6FF25EB', CAST(0.00 AS Decimal(38, 2)), CAST(4000.00 AS Decimal(38, 2)), CAST(50.00 AS Decimal(38, 2)), 1, CAST(N'2024-12-12T08:11:59.057' AS DateTime), N'System', 1, N'System', CAST(N'2024-12-12T08:52:25.327' AS DateTime), 1, 1, 1)
INSERT [dbo].[tblTerminal] ([ID], [AgentID], [Name], [TerminalID], [AccessKey], [Balance], [MaximumTxnValue], [MinimumTxnValue], [Active], [CreationDate], [CreatedBy], [Approved], [ApprovedBy], [ApprovedDate], [AllowJSON], [AllowXML], [AllowISO8583]) VALUES (2, 1, N'ABSACHANNEL', N'ABSACHANNEL', N'941F326DFEBF364030A86D205298C638', CAST(0.00 AS Decimal(38, 2)), CAST(4000.00 AS Decimal(38, 2)), CAST(50.00 AS Decimal(38, 2)), 1, CAST(N'2024-12-12T08:12:21.547' AS DateTime), N'System', 1, N'System', CAST(N'2024-12-12T08:52:25.327' AS DateTime), 1, 1, 1)
INSERT [dbo].[tblTerminal] ([ID], [AgentID], [Name], [TerminalID], [AccessKey], [Balance], [MaximumTxnValue], [MinimumTxnValue], [Active], [CreationDate], [CreatedBy], [Approved], [ApprovedBy], [ApprovedDate], [AllowJSON], [AllowXML], [AllowISO8583]) VALUES (3, 1, N'ZAMSWITCH', N'ZAMSWITCH', N'B96938A0E51DCFEF57B1FBACB82EE8CA', CAST(0.00 AS Decimal(38, 2)), CAST(4000.00 AS Decimal(38, 2)), CAST(50.00 AS Decimal(38, 2)), 1, CAST(N'2024-12-12T08:12:49.800' AS DateTime), N'System', 1, N'System', CAST(N'2024-12-12T08:52:25.327' AS DateTime), 1, 1, 1)
SET IDENTITY_INSERT [dbo].[tblTerminal] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [inxAgentCode]    Script Date: 12/12/2024 2:53:00 pm ******/
CREATE NONCLUSTERED INDEX [inxAgentCode] ON [dbo].[tblAgent]
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [inxTerminalAgent]    Script Date: 12/12/2024 2:53:00 pm ******/
CREATE NONCLUSTERED INDEX [inxTerminalAgent] ON [dbo].[tblTerminal]
(
	[AgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [inxTerminalID]    Script Date: 12/12/2024 2:53:00 pm ******/
CREATE NONCLUSTERED INDEX [inxTerminalID] ON [dbo].[tblTerminal]
(
	[ID] ASC
)
INCLUDE([Balance]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAgent] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[tblAgent] ADD  DEFAULT ((0)) FOR [Approved]
GO
ALTER TABLE [dbo].[tblCashOut] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[tblCashOut] ADD  DEFAULT ((0)) FOR [Redeemed]
GO
ALTER TABLE [dbo].[tblCashOut] ADD  DEFAULT ((0)) FOR [Expired]
GO
ALTER TABLE [dbo].[tblCashOut] ADD  DEFAULT ((0)) FOR [Refunded]
GO
ALTER TABLE [dbo].[tblCashOut] ADD  DEFAULT ((0)) FOR [OTPExpired]
GO
ALTER TABLE [dbo].[tblTerminal] ADD  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[tblTerminal] ADD  DEFAULT ((0)) FOR [Approved]
GO
ALTER TABLE [dbo].[tblTerminal] ADD  DEFAULT ((0)) FOR [AllowJSON]
GO
ALTER TABLE [dbo].[tblTerminal] ADD  DEFAULT ((0)) FOR [AllowXML]
GO
ALTER TABLE [dbo].[tblTerminal] ADD  DEFAULT ((0)) FOR [AllowISO8583]
GO
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT ((0)) FOR [Approved]
GO
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT ((0)) FOR [Active]
GO
/****** Object:  StoredProcedure [dbo].[sp$CSClass_FromTableName]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp$CSClass_FromTableName]
@TableName SYSNAME,
@ClassName VARCHAR(50)
AS
BEGIN
--declare @TableName sysname = 'tblBusinessOwner'
DECLARE @Result VARCHAR(MAX) = 'public class ' + @ClassName + '
        {';

SELECT @Result = @Result + '
			public ' + ColumnType + ' ' + ColumnName  + ' { get; set;}'
FROM
(
    SELECT 
        REPLACE(col.name, ' ', '_') ColumnName,
        column_id ColumnId,
        CASE typ.name 
            WHEN 'bigint' THEN 'int'
            WHEN 'binary' THEN 'byte[]'
            WHEN 'bit' THEN 'bool'
            WHEN 'char' THEN 'string'
            WHEN 'date' THEN 'DateTime'
            WHEN 'datetime' THEN 'DateTime'
            WHEN 'datetime2' THEN 'DateTime'
            WHEN 'datetimeoffset' THEN 'DateTimeOffset'
            WHEN 'decimal' THEN 'double'
            WHEN 'float' THEN 'double'
            WHEN 'image' THEN 'byte[]'
            WHEN 'int' THEN 'int'
            WHEN 'money' THEN 'decimal'
            WHEN 'nchar' THEN 'string'
            WHEN 'ntext' THEN 'string'
            WHEN 'numeric' THEN 'decimal'
            WHEN 'nvarchar' THEN 'string'
            WHEN 'real' THEN 'float'
            WHEN 'smalldatetime' THEN 'DateTime'
            WHEN 'smallint' THEN 'short'
            WHEN 'smallmoney' THEN 'decimal'
            WHEN 'text' THEN 'string'
            WHEN 'time' THEN 'TimeSpan'
            WHEN 'timestamp' THEN 'long'
            WHEN 'tinyint' THEN 'byte'
            WHEN 'uniqueidentifier' THEN 'Guid'
            WHEN 'varbinary' THEN 'byte[]'
            WHEN 'varchar' THEN 'string'
            ELSE 'UNKNOWN_' + typ.name
        END ColumnType,
        CASE 
            WHEN col.is_nullable = 1 AND typ.name IN ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier') 
            THEN '?' 
            ELSE '' 
        END NullableSign
    FROM sys.columns col
        JOIN sys.types typ ON
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    WHERE object_id = OBJECT_ID(@TableName)
) t
ORDER BY ColumnId

SET @Result = @Result  + '
}'

PRINT @Result;

END

GO
/****** Object:  StoredProcedure [dbo].[sp$CSParseRow_FromTableName]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp$CSParseRow_FromTableName]
@TableName SYSNAME,
@ClassName VARCHAR(50),
@ClassVariableName VARCHAR(50)
AS
BEGIN
--declare @TableName sysname = 'tblBusinessOwner'
DECLARE @Result VARCHAR(MAX) = 'public ' + @ClassName + ' ParseDataRow(DataRow row)
{
		' + @ClassName + ' ' + @ClassVariableName + ' = new ' + @ClassName + '();'

SELECT @Result = @Result + '
			' + @ClassVariableName + '.' + ColumnName + 
			CASE WHEN t.ColumnType = 'decimal' THEN ' = Double.Parse(row["' + ColumnName + '"].ToString());'
			ELSE ' = (' + ColumnType  + ')row["' + ColumnName + '"];'
			END
FROM
(
    SELECT 
        REPLACE(col.name, ' ', '_') ColumnName,
        column_id ColumnId,
        CASE typ.name 
            WHEN 'bigint' THEN 'long'
            WHEN 'binary' THEN 'byte[]'
            WHEN 'bit' THEN 'bool'
            WHEN 'char' THEN 'string'
            WHEN 'date' THEN 'DateTime'
            WHEN 'datetime' THEN 'DateTime'
            WHEN 'datetime2' THEN 'DateTime'
            WHEN 'datetimeoffset' THEN 'DateTimeOffset'
            WHEN 'decimal' THEN 'decimal'
            WHEN 'float' THEN 'double'
            WHEN 'image' THEN 'byte[]'
            WHEN 'int' THEN 'int'
            WHEN 'money' THEN 'decimal'
            WHEN 'nchar' THEN 'string'
            WHEN 'ntext' THEN 'string'
            WHEN 'numeric' THEN 'decimal'
            WHEN 'nvarchar' THEN 'string'
            WHEN 'real' THEN 'float'
            WHEN 'smalldatetime' THEN 'DateTime'
            WHEN 'smallint' THEN 'short'
            WHEN 'smallmoney' THEN 'decimal'
            WHEN 'text' THEN 'string'
            WHEN 'time' THEN 'TimeSpan'
            WHEN 'timestamp' THEN 'long'
            WHEN 'tinyint' THEN 'byte'
            WHEN 'uniqueidentifier' THEN 'Guid'
            WHEN 'varbinary' THEN 'byte[]'
            WHEN 'varchar' THEN 'string'
            ELSE 'UNKNOWN_' + typ.name
        END ColumnType,
        CASE 
            WHEN col.is_nullable = 1 AND typ.name IN ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier') 
            THEN '?' 
            ELSE '' 
        END NullableSign
    FROM sys.columns col
        JOIN sys.types typ ON
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    WHERE object_id = OBJECT_ID(@TableName)
) t
ORDER BY ColumnId

SET @Result = @Result  + '
		return ' + @ClassVariableName + ';
}'

PRINT @Result;

END
GO
/****** Object:  StoredProcedure [dbo].[sp$tableInsert]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp$tableInsert]
@ProcedureName VARCHAR(100),
@TableName VARCHAR(100)
AS

--Cursor Vairables
DECLARE @ColName VARCHAR(100);
DECLARE @TypeName VARCHAR(100);
DECLARE @ColLength INT;
DECLARE @Precision INT;
DECLARE @Scale INT;

--Working Variables
DECLARE @FirstPart VARCHAR(1000);
DECLARE @SecondPart VARCHAR(1000);
DECLARE @ThirdPart VARCHAR(1000);
DECLARE @ParameterPart VARCHAR(1000);
DECLARE @FullQuery VARCHAR(4000);
DECLARE @TypeSignature VARCHAR(120);
DECLARE @NumRows INT;
DECLARE @CurrentRow INT;

--Getting the number of columns in the table
SELECT @NumRows = Count(*)
FROM sys.columns col
INNER JOIN sys.objects obj ON col.[object_id] = obj.[object_id] 
AND obj.[Name] = @TableName;

DECLARE ColList CURSOR FOR

SELECT col.[Name] AS ColName, types.name AS TypeName, col.max_length AS ColLength, Col.[precision], col.Scale
FROM sys.columns col
INNER JOIN sys.objects obj ON col.[object_id] = obj.[object_id] 
INNER JOIN sys.types types ON col.system_type_id = types.system_type_id
AND obj.[Name] = @TableName
ORDER BY column_id

SET @ParameterPart = 'CREATE PROCEDURE ' + @ProcedureName + Char(10);
SET @FirstPart = 'IF @NewRecord = 1 ' + CHAR(10) + '  BEGIN' + CHAR(10) + '  INSERT INTO ' + @TableName + '(';
SET @SecondPart = '  VALUES('
SET @ThirdPart = ' IF @NewRecord = 0' + CHAR(10) + '  BEGIN' + CHAR(10) + '  UPDATE ' + @TableName +  ' SET ' + CHAR(10);

OPEN ColList;
FETCH NEXT FROM ColList INTO @ColName, @TypeName, @ColLength, @Precision, @Scale
SET @CurrentRow = 1;

WHILE @@FETCH_STATUS = 0
  BEGIN
	--Setting the type signature for this column
	IF @TypeName IN('char','varchar') SET @TypeSignature = @TypeName + '(' + CAST(@ColLength AS VARCHAR(5)) + ')'
	ELSE IF @TypeName = 'decimal' SET @TypeSignature = @TypeName + '(' + CAST(@Precision AS VARCHAR(5)) + ',' + CAST(@Scale AS VARCHAR(5))+ ')'
	ELSE SET @TypeSignature = @TypeName;

	SET @ParameterPart = @ParameterPart + '@' + @ColName + ' ' + @TypeSignature;
	IF @CurrentRow <> 1 
    BEGIN
		SET @FirstPart = @FirstPart + '[' + @ColName + ']';
		SET @SecondPart = @SecondPart + '@' + @ColName;
		SET @ThirdPart = @ThirdPart + '      [' + @ColName + '] = ' + ' @' + @ColName
	END

	IF @CurrentRow < @NumRows
    BEGIN
	   SET @ParameterPart = @ParameterPart + ',' + CHAR(10);

	   IF @CurrentRow <> 1 
		BEGIN
		   SET @FirstPart = @FirstPart + ',';
		   SET @SecondPart = @SecondPart + ',';
		   SET @ThirdPart = @ThirdPart + ',' + CHAR(10);
		END
	END;

	IF @CurrentRow = @NumRows
    BEGIN
	   SET @ParameterPart = @ParameterPart + ',' + CHAR(10) + '@NewRecord BIT' + CHAR(10) + 'AS' +CHAR(10);
	   SET @FirstPart = @FirstPart + ')';
	   SET @SecondPart = @SecondPart + ')' + CHAR(10) + '  END' + CHAR(10);
	   SET @ThirdPart = @ThirdPart + CHAR(10) + '   WHERE [ID] = @ID ' + CHAR(10) + '   END';
	END;

	FETCH NEXT FROM ColList INTO @ColName, @TypeName, @ColLength, @Precision, @Scale
	SET @CurrentRow = @CurrentRow + 1;

  END -- end while @@FETCH_STATUS

SET @FullQuery = @ParameterPart + CHAR(10) + @FirstPart + CHAR(10) + @SecondPart + CHAR(10) + @ThirdPart;

CLOSE ColList;
DEALLOCATE ColList;
PRINT @FullQuery;
EXEC(@FullQuery);

GO
/****** Object:  StoredProcedure [dbo].[spCreateAgent]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spCreateAgent]
@ID int,
@Name varchar(200),
@Code varchar(50),
@EmailAddress varchar(100),
@EmailAddress2 varchar(100),
@MobileNumber varchar(20),
@MobileNumber2 varchar(20),
@CreatedBy varchar(50),
@NewRecord BIT
AS

IF @NewRecord = 1 
  BEGIN
  INSERT INTO tblAgent([Name],[Code],[EmailAddress],[EmailAddress2],[MobileNumber],[MobileNumber2],[CreationDate],[CreatedBy],[Balance])
  VALUES(@Name,@Code,@EmailAddress,@EmailAddress2,@MobileNumber,@MobileNumber2, GETDATE(),@CreatedBy,0)
  END

 IF @NewRecord = 0
  BEGIN
  UPDATE tblAgent SET 
      [Name] =  @Name,
      [Code] =  @Code,
      [EmailAddress] =  @EmailAddress,
      [EmailAddress2] =  @EmailAddress2,
      [MobileNumber] =  @MobileNumber,
      [MobileNumber2] =  @MobileNumber2
   WHERE [ID] = @ID 
   END

GO
/****** Object:  StoredProcedure [dbo].[spCreateCashOut]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCreateCashOut]
@SourceAccount VARCHAR(20),
@DestinationAccount VARCHAR(20),
@DestinationMobile VARCHAR(20),
@TransactionAmount DECIMAL(38,2)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @OTP VARCHAR(10);
	DECLARE @CashoutID INT;
	DECLARE @ExpiryDate DATETIME;
	DECLARE @VoucherNumber VARCHAR(20);
	DECLARE @OTPExpiryDate DATETIME;
	DECLARE @SMSMessage NVARCHAR(160);
	DECLARE @SMSURL NVARCHAR(255);
	DECLARE @SMSAPIKey NVARCHAR(100);
	DECLARE @CustomerMobile NVARCHAR(20);

	SET @ExpiryDate = DATEADD(HOUR,1,GETDATE())
	SET @OTPExpiryDate = DATEADD(MINUTE,5,GETDATE())
	SET @OTP = floor(10000 + rand() * 89999); 
	SET @VoucherNumber = CAST(convert(numeric(12,0),rand() * 899999999999) + 100000000000 AS VARCHAR);

	IF EXISTS(SELECT * FROM tblCashOut
			  WHERE [DestinationAccount] = @DestinationAccount AND [DestinationMobile] = @DestinationMobile
			  AND [TransactionAmount] = @TransactionAmount AND [Redeemed] = 0 AND [Expired] = 0
			  AND DATEDIFF(SECOND,GETDATE(),[ExpiryDate]) > 0)
    BEGIN
		SELECT @CashoutID = [ID]
		FROM tblCashOut
		WHERE [DestinationAccount] = @DestinationAccount AND [DestinationMobile] = @DestinationMobile
		AND [TransactionAmount] = @TransactionAmount AND [Redeemed] = 0 AND [Expired] = 0
		AND DATEDIFF(SECOND,GETDATE(),[ExpiryDate]) > 0
	END
	ELSE BEGIN
		INSERT INTO tblCashOut([SourceAccount],[DestinationAccount],[DestinationMobile],[TransactionAmount],[VoucherNumber],[OTP],[OTPExpiryDate],[ExpiryDate])
		VALUES(@SourceAccount, @DestinationAccount, @DestinationMobile, @TransactionAmount, @VoucherNumber, @OTP, @OTPExpiryDate,@ExpiryDate);

		SET @CashOutID = SCOPE_IDENTITY();
	END

	SELECT * FROM tblCashOut WHERE [ID] = @CashOutID;

END
GO
/****** Object:  StoredProcedure [dbo].[spCreateTerminal]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCreateTerminal]
@ID int,
@AgentID int,
@Name varchar(100),
@TerminalID varchar(50),
@MaximumTxnValue decimal(38,2),
@MinimumTxnValue decimal(38,2),
@CreatedBy varchar(50),
@AllowJSON bit,
@AllowXML bit,
@AllowISO8583 bit,
@NewRecord BIT
AS
BEGIN
DECLARE @AccessKey VARCHAR(50);
DECLARE @HashSeed VARCHAR(50);
SET @HashSeed = @TerminalID + 'EStash';
SET @AccessKey = dbo.fnMD5(@HashSeed); 

IF @NewRecord = 1 
  BEGIN
  INSERT INTO tblTerminal([AgentID],[Name],[TerminalID],[AccessKey],[Balance],[MaximumTxnValue],[MinimumTxnValue],[Active],[CreationDate],[CreatedBy],[AllowJSON],[AllowXML],[AllowISO8583])
  VALUES(@AgentID,@Name,@TerminalID,@AccessKey,0,@MaximumTxnValue,@MinimumTxnValue,1, GETDATE(),@CreatedBy,@AllowJSON,@AllowXML,@AllowISO8583)
  END

 IF @NewRecord = 0
  BEGIN
  UPDATE tblTerminal SET 
      [MaximumTxnValue] =  @MaximumTxnValue,
      [MinimumTxnValue] =  @MinimumTxnValue,
      [AllowJSON] =  @AllowJSON,
      [AllowXML] =  @AllowXML,
      [AllowISO8583] =  @AllowISO8583
   WHERE [ID] = @ID 
   END

END

GO
/****** Object:  StoredProcedure [dbo].[spGetCashOut]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetCashOut]
@DestinationMobile VARCHAR(20),
@TransactionAmount VARCHAR(20),
@OTP VARCHAR(10)
AS
BEGIN
	IF EXISTS(
		SELECT *
		FROM tblCashOut
		WHERE [DestinationMobile] = @DestinationMobile
		AND [TransactionAmount] = @TransactionAmount
		AND [OTP] = @OTP
		AND [Redeemed] = 0
		AND [Expired] = 0)
	BEGIN
		SELECT TOP 1 *
		FROM tblCashOut
		WHERE [DestinationMobile] = @DestinationMobile
		AND [TransactionAmount] = @TransactionAmount
		AND [OTP] = @OTP
		AND [Redeemed] = 0
		AND [Expired] = 0;
	END
	ELSE
	SELECT * FROM  tblCashOut WHERE [ID] = 0

END
GO
/****** Object:  StoredProcedure [dbo].[spGetCashOutByID]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetCashOutByID]
@CashOutID INT
AS
BEGIN
	SELECT * FROM tblCashOut 
	WHERE [ID] = @CashOutID;

END
GO
/****** Object:  StoredProcedure [dbo].[spGetPendingCashoutRefunds]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetPendingCashoutRefunds]
AS
BEGIN
	EXEC spUpdateCashOutExpiryStatus;
	SELECT * from tblCashOut WHERE [Expired] = 1 AND [Refunded] = 0

END
GO
/****** Object:  StoredProcedure [dbo].[spReissueCashOutOTP]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spReissueCashOutOTP]
@SourceAccount VARCHAR(20),
@DestinationAccount VARCHAR(20),
@DestinationMobile VARCHAR(20),
@TransactionAmount DECIMAL(38,2),
@VoucherNumber VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @OTP VARCHAR(10);
	DECLARE @CashoutID INT;
	DECLARE @ExpiryDate DATETIME;
	DECLARE @OTPExpiryDate DATETIME;
	DECLARE @SMSMessage NVARCHAR(160);
	DECLARE @SMSURL NVARCHAR(255);
	DECLARE @SMSAPIKey NVARCHAR(100);
	DECLARE @CustomerMobile NVARCHAR(20);
	DECLARE @Expired BIT = 0;

	EXEC spUpdateCashOutExpiryStatus;

	SET @OTPExpiryDate = DATEADD(MINUTE,5,GETDATE())
	SET @OTP = floor(10000 + rand() * 89999); 
	IF EXISTS(SELECT * FROM tblCashOut WHERE [VoucherNumber] = @VoucherNumber AND TransactionAmount = @TransactionAmount
	    AND [DestinationMobile] = @DestinationMobile AND [Redeemed] = 0 AND [Expired] = 0)
	BEGIN
		SELECT TOP 1 @CashoutID = [ID], @Expired = [Expired]
		FROM tblCashOut WHERE [VoucherNumber] = @VoucherNumber AND TransactionAmount = @TransactionAmount
	    AND [DestinationMobile] = @DestinationMobile  AND [Redeemed] = 0 AND [Expired] = 0;

		IF @Expired = 0
		UPDATE tblCashOut SET OTPExpiryDate = @OTPExpiryDate WHERE [ID] = @CashOutID; 
	END
	ELSE BEGIN
	  SET @Expired = 1;
	  SET @CashOutID = 0;
	END

	SELECT * FROM tblCashOut WHERE [ID] = @CashOutID;

END
GO
/****** Object:  StoredProcedure [dbo].[spSetCashOutRedeemed]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spSetCashOutRedeemed]
@CashOutID INT,
@RedemptionReference VARCHAR(50)
AS

UPDATE tblCashOut SET [Redeemed] = 1, [RedeemedDate] = GETDATE(),
	[RedemptionReference] = @RedemptionReference
WHERE [ID] = @CashOutID;

GO
/****** Object:  StoredProcedure [dbo].[spSetCashOutRefunded]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSetCashOutRefunded]
@CashOutID INT,
@RefundReference VARCHAR(50)
AS

UPDATE tblCashOut SET [Refunded] = 1, [RefundedDate] = GETDATE(),
	[RefundReference] = @RefundReference
WHERE [ID] = @CashOutID;

GO
/****** Object:  StoredProcedure [dbo].[spTerminalLogin]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTerminalLogin]
@TerminalID VARCHAR(50),
@AccessKey VARCHAR(50)
AS
BEGIN
  SELECT * FROM tblTerminal WHERE [TerminalID] = @TerminalID AND [AccessKey] = @AccessKey;
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCashOutExpiryStatus]    Script Date: 12/12/2024 2:53:00 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spUpdateCashOutExpiryStatus]
AS
BEGIN
	UPDATE tblCashOut SET [Expired] = 1	WHERE [Redeemed] = 0 AND [Expired] = 0 AND DATEDIFF(SECOND, ExpiryDate, GETDATE()) > 0;
	UPDATE tblCashOut SET [OTPExpired] = 1	WHERE [Redeemed] = 0 AND [Expired] = 0 AND DATEDIFF(SECOND, OTPExpiryDate, GETDATE()) > 0;
END
GO
USE [master]
GO
ALTER DATABASE [EStashWallet] SET  READ_WRITE 
GO
