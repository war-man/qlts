USE [master]
GO
/****** Object:  Database [MSSQL_QLDN_MAIN_DEMO]    Script Date: 12/9/2017 9:43:03 AM ******/
CREATE DATABASE [MSSQL_QLDN_MAIN_DEMO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MSSQL_QLDN_MAIN', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MSSQL_QLDN_MAIN_DEMO.mdf' , SIZE = 20480KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MSSQL_QLDN_MAIN_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MSSQL_QLDN_MAIN_DEMO_log.ldf' , SIZE = 10240KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MSSQL_QLDN_MAIN_DEMO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET ARITHABORT OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET RECOVERY FULL 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET  MULTI_USER 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MSSQL_QLDN_MAIN_DEMO', N'ON'
GO
USE [MSSQL_QLDN_MAIN_DEMO]
GO
/****** Object:  User [qldn]    Script Date: 12/9/2017 9:43:03 AM ******/
CREATE USER [qldn] FOR LOGIN [qldn] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [qldn]
GO
/****** Object:  Table [dbo].[CauHinhForm]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CauHinhForm](
	[CauHinhFormId] [int] IDENTITY(1,1) NOT NULL,
	[MaForm] [nvarchar](64) NOT NULL,
	[TenForm] [nvarchar](128) NOT NULL,
	[ChoPhepInYN] [bit] NULL,
	[ChoPhepXuatPdfYN] [bit] NULL,
	[KhoGiayIn] [varchar](8) NULL,
	[MoTa] [nvarchar](256) NULL,
	[TieuDe] [nvarchar](128) NULL,
	[ChoPhepSapXepYN] [bit] NULL,
	[TieuDeRex] [nvarchar](16) NULL,
	[NgayTaoDT] [datetime] NULL,
	[NgaySuaDT] [datetime] NULL,
	[NguoiTao] [nvarchar](128) NULL,
	[NguoiSua] [nvarchar](128) NULL,
	[CtrVersion] [int] NOT NULL,
 CONSTRAINT [PK_CauHinhForm_1] PRIMARY KEY CLUSTERED 
(
	[CauHinhFormId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CauHinhFormCot]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CauHinhFormCot](
	[CauHinhFormCotId] [int] IDENTITY(1,1) NOT NULL,
	[MaForm] [nvarchar](64) NOT NULL,
	[MaCot] [nvarchar](64) NOT NULL,
	[TenCot] [nvarchar](128) NULL,
	[TenCotMacDinh] [nvarchar](128) NULL,
	[HienThiYN] [bit] NOT NULL,
	[MacDinhYN] [bit] NOT NULL,
	[LaCongThucYN] [bit] NOT NULL,
	[CongThuc] [nvarchar](1024) NULL,
	[CauSapXep] [nvarchar](64) NULL,
	[MoTa] [nvarchar](128) NULL,
	[DoRong] [int] NULL,
	[CauSelect] [nvarchar](256) NULL,
	[ThuTu] [smallint] NULL,
	[TenCotMacDinhRex] [nvarchar](16) NULL,
	[NgayTaoDT] [datetime] NULL,
	[NgaySuaDT] [datetime] NULL,
	[NguoiTao] [nvarchar](128) NULL,
	[NguoiSua] [nvarchar](128) NULL,
	[CtrVersion] [int] NOT NULL,
 CONSTRAINT [PK_CauHinhForm_Cot_1] PRIMARY KEY CLUSTERED 
(
	[CauHinhFormCotId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CauHinhHeThong]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CauHinhHeThong](
	[CauHinhHeThongId] [int] IDENTITY(1,1) NOT NULL,
	[MaCauHinhHeThong] [nvarchar](64) NOT NULL,
	[GiaTri] [nvarchar](256) NOT NULL,
	[MoTa] [nvarchar](256) NULL,
	[ThuocNhom] [nvarchar](64) NULL,
	[DSMaVaiTro] [nvarchar](1024) NULL,
	[ThuTu] [smallint] NULL,
	[NgayTaoDT] [datetime] NULL,
	[NgaySuaDT] [datetime] NULL,
	[NguoiTao] [nvarchar](128) NULL,
	[NguoiSua] [nvarchar](128) NULL,
	[CtrVersion] [int] NOT NULL,
 CONSTRAINT [PK_CauHinhHeThong_1] PRIMARY KEY CLUSTERED 
(
	[CauHinhHeThongId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChucNang]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucNang](
	[ChucNangId] [int] IDENTITY(1,1) NOT NULL,
	[MaChucNang] [nvarchar](64) NOT NULL,
	[TenChucNang] [nvarchar](128) NULL,
	[MoTa] [nvarchar](256) NULL,
	[DSQuyen] [nvarchar](128) NULL,
	[ThuocNhom] [nvarchar](64) NULL,
	[DuongDan] [nvarchar](128) NULL,
	[ThuTu] [smallint] NULL,
	[KhoaYN] [bit] NOT NULL CONSTRAINT [DF_ChucNang_Khoa]  DEFAULT ((0)),
	[TenChucNangRex] [nvarchar](16) NULL,
	[NgayTaoDT] [datetime] NULL CONSTRAINT [DF_ChucNang_NgayTao]  DEFAULT (getdate()),
	[NgaySuaDT] [datetime] NULL CONSTRAINT [DF_ChucNang_NgaySua]  DEFAULT (getdate()),
	[NguoiTao] [nvarchar](128) NULL,
	[NguoiSua] [nvarchar](128) NULL,
	[CtrVersion] [int] NOT NULL CONSTRAINT [DF__ChucNang__ctr_ve__3D2915A8]  DEFAULT ((0)),
 CONSTRAINT [PK_ChucNang_1] PRIMARY KEY CLUSTERED 
(
	[ChucNangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Client]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ClientId] [nvarchar](32) NOT NULL,
	[Base64Secret] [nvarchar](80) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ApplicationType] [int] NULL,
	[ActiveYN] [bit] NOT NULL CONSTRAINT [DF_Audience_BlockedYN]  DEFAULT ((1)),
	[RefreshTokenLifeTime] [int] NULL,
	[AllowedOrigin] [nvarchar](100) NULL,
	[Description] [nvarchar](256) NULL,
	[CtrVersion] [int] NOT NULL CONSTRAINT [DF_Audience_CtrVersion]  DEFAULT ((0)),
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[NguoiDungId] [int] IDENTITY(1,1) NOT NULL,
	[MaNguoiDung] [nvarchar](64) NOT NULL,
	[Email] [nvarchar](128) NOT NULL,
	[EmailDaXacNhanYN] [bit] NOT NULL CONSTRAINT [DF_NguoiDung_EmailDaXacNhan]  DEFAULT ((0)),
	[PasswordHash] [nvarchar](256) NULL,
	[SecurityStamp] [nvarchar](256) NULL,
	[DienThoai] [nvarchar](256) NULL,
	[DienThoaiDaXacNhanYN] [bit] NOT NULL CONSTRAINT [DF_NguoiDung_DienThoaiDaXacNhan]  DEFAULT ((0)),
	[BaoMatHaiLopYN] [bit] NOT NULL CONSTRAINT [DF_NguoiDung_BaoMatHaiLop]  DEFAULT ((0)),
	[KhoaDen] [datetime] NULL,
	[KhoaYN] [bit] NOT NULL CONSTRAINT [DF_NguoiDung_Khoa]  DEFAULT ((0)),
	[LanDangNhapSai] [int] NOT NULL CONSTRAINT [DF_NguoiDung_LanDangNhapSai]  DEFAULT ((0)),
	[UserName] [nvarchar](128) NOT NULL,
	[VaiTroId] [int] NOT NULL,
	[HoTen] [nvarchar](128) NULL,
	[NhanVienId] [int] NULL,
	[NgayTaoDT] [datetime] NULL CONSTRAINT [DF_NguoiDung_NgayTao]  DEFAULT (getdate()),
	[NgaySuaDT] [datetime] NULL CONSTRAINT [DF_NguoiDung_NgaySua]  DEFAULT (getdate()),
	[NguoiTao] [nvarchar](128) NULL,
	[NguoiSua] [nvarchar](128) NULL,
	[CtrVersion] [int] NOT NULL CONSTRAINT [DF__NguoiDung__ctr_v__46B27FE2]  DEFAULT ((0)),
 CONSTRAINT [PK_NguoiDung_1] PRIMARY KEY CLUSTERED 
(
	[NguoiDungId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuyenTacVu]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuyenTacVu](
	[VaiTroId] [int] NOT NULL,
	[ChucNangId] [int] NOT NULL,
	[DSQuyenTacVu] [nvarchar](128) NULL,
 CONSTRAINT [PK_QuyenTacVu] PRIMARY KEY CLUSTERED 
(
	[VaiTroId] ASC,
	[ChucNangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshToken](
	[RefreshTokenId] [nvarchar](32) NOT NULL,
	[Subject] [nvarchar](50) NOT NULL,
	[ClientId] [nvarchar](50) NOT NULL,
	[IssuedUtc] [datetime] NOT NULL,
	[ExpiresUtc] [datetime] NOT NULL,
	[ProtectedTicket] [nvarchar](100) NOT NULL,
	[CtrVersion] [int] NOT NULL,
 CONSTRAINT [PK_RefreshToken] PRIMARY KEY CLUSTERED 
(
	[RefreshTokenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VaiTro]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VaiTro](
	[VaiTroId] [int] IDENTITY(1,1) NOT NULL,
	[MaVaiTro] [nvarchar](64) NOT NULL,
	[TenVaiTro] [nvarchar](128) NOT NULL,
	[MoTa] [nvarchar](256) NULL,
	[KhoaYN] [bit] NOT NULL CONSTRAINT [DF_VaiTro_Khoa]  DEFAULT ((0)),
	[TenVaiTroRex] [nvarchar](16) NULL,
	[NgayTaoDT] [datetime] NULL CONSTRAINT [DF_Role_DateCreated]  DEFAULT (getdate()),
	[NgaySuaDT] [datetime] NULL CONSTRAINT [DF_Role_DateModified]  DEFAULT (getdate()),
	[NguoiTao] [nvarchar](128) NULL,
	[NguoiSua] [nvarchar](128) NULL,
	[CtrVersion] [int] NOT NULL CONSTRAINT [DF__VaiTro__ctr_vers__625A9A57]  DEFAULT ((0)),
 CONSTRAINT [PK_VaiTro_1] PRIMARY KEY CLUSTERED 
(
	[VaiTroId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[RefreshToken] ADD  CONSTRAINT [DF_RefreshToken_IssuedUtc]  DEFAULT (getdate()) FOR [IssuedUtc]
GO
ALTER TABLE [dbo].[RefreshToken] ADD  CONSTRAINT [DF_RefreshToken_ExpiresUtc]  DEFAULT (getdate()) FOR [ExpiresUtc]
GO
ALTER TABLE [dbo].[RefreshToken] ADD  CONSTRAINT [DF_RefreshToken_CtrVersion]  DEFAULT ((0)) FOR [CtrVersion]
GO
ALTER TABLE [dbo].[NguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_NguoiDung_VaiTro] FOREIGN KEY([VaiTroId])
REFERENCES [dbo].[VaiTro] ([VaiTroId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[NguoiDung] CHECK CONSTRAINT [FK_NguoiDung_VaiTro]
GO
ALTER TABLE [dbo].[QuyenTacVu]  WITH CHECK ADD  CONSTRAINT [FK_QuyenTacVu_ChucNang] FOREIGN KEY([ChucNangId])
REFERENCES [dbo].[ChucNang] ([ChucNangId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuyenTacVu] CHECK CONSTRAINT [FK_QuyenTacVu_ChucNang]
GO
ALTER TABLE [dbo].[QuyenTacVu]  WITH CHECK ADD  CONSTRAINT [FK_QuyenTacVu_VaiTro] FOREIGN KEY([VaiTroId])
REFERENCES [dbo].[VaiTro] ([VaiTroId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuyenTacVu] CHECK CONSTRAINT [FK_QuyenTacVu_VaiTro]
GO
/****** Object:  StoredProcedure [dbo].[csp_LayDanhSach_QuyenTacVuBangVaiTroId]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************
1. Create Date : 2017.03.30
2. Creator     : Tran Quoc Hung
3. Description : Lay Danh Sach Quyen Tac Vu voi VaiTroId
4. History     : 2017.03.30(Tran Quoc Hung) - Tao moi
*****************************************************************************/
CREATE PROCEDURE [dbo].[csp_LayDanhSach_QuyenTacVuBangVaiTroId]
@VaiTroId int
AS
-- selects all rows from the table
SELECT 
VT.VaiTroId
,[MaVaiTro]
,MaChucNang
,QTV.DSQuyenTacVu
FROM [dbo].[VaiTro] VT
inner join [dbo].[QuyenTacVu] QTV on VT.VaiTroId = QTV.VaiTroId
inner join [dbo].[ChucNang] CN on CN.ChucNangId = QTV.ChucNangId
WHERE 
VT.VaiTroId = @VaiTroId







GO
/****** Object:  StoredProcedure [dbo].[Helper_CreatePocoFromTableName]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC [dbo].[Helper_CreatePocoFromTableName] @tableName = 'NguoiDung'
*/

CREATE PROCEDURE [dbo].[Helper_CreatePocoFromTableName]    
    @tableName varchar(100)
AS
BEGIN
SET NOCOUNT ON
DECLARE @tbl as varchar(255)
SET @tbl = @tableName

DECLARE @flds as varchar(8000)
SET @flds=''

SELECT -1 as f0, 'public class ' + @tbl + ' {' as f1 into #tmp

INSERT #tmp
SELECT 
    ORDINAL_POSITION, 
    '    public ' + 
    CASE 
        WHEN DATA_TYPE = 'varchar' THEN 'string'
        WHEN DATA_TYPE = 'nvarchar' THEN 'string'
        WHEN DATA_TYPE = 'text' THEN 'string'
        WHEN DATA_TYPE = 'ntext' THEN 'string'
        WHEN DATA_TYPE = 'char' THEN 'string'
        WHEN DATA_TYPE = 'xml' THEN 'string'
        WHEN DATA_TYPE = 'datetime' AND IS_NULLABLE = 'NO' THEN 'DateTime'
        WHEN DATA_TYPE = 'datetime' AND IS_NULLABLE = 'YES' THEN 'DateTime?'
        WHEN DATA_TYPE = 'int' AND IS_NULLABLE = 'YES' THEN 'int?'
        WHEN DATA_TYPE = 'int' AND IS_NULLABLE = 'NO' THEN 'int'
        WHEN DATA_TYPE = 'smallint' AND IS_NULLABLE = 'NO' THEN 'Int16'
        WHEN DATA_TYPE = 'smallint' AND IS_NULLABLE = 'YES' THEN 'Int16?'
        WHEN DATA_TYPE = 'decimal' AND IS_NULLABLE = 'NO' THEN 'decimal'
        WHEN DATA_TYPE = 'decimal' AND IS_NULLABLE = 'YES' THEN 'decimal?'
        WHEN DATA_TYPE = 'numeric' AND IS_NULLABLE = 'NO' THEN 'decimal'
        WHEN DATA_TYPE = 'numeric' AND IS_NULLABLE = 'YES' THEN 'decimal?'
        WHEN DATA_TYPE = 'money' AND IS_NULLABLE = 'NO' THEN 'decimal'
        WHEN DATA_TYPE = 'money' AND IS_NULLABLE = 'YES' THEN 'decimal?'
        WHEN DATA_TYPE = 'bigint' AND IS_NULLABLE = 'NO' THEN 'long'
        WHEN DATA_TYPE = 'bigint' AND IS_NULLABLE = 'YES' THEN 'long?'
        WHEN DATA_TYPE = 'tinyint' AND IS_NULLABLE = 'NO' THEN 'byte'
        WHEN DATA_TYPE = 'tinyint' AND IS_NULLABLE = 'YES' THEN 'byte?'
        WHEN DATA_TYPE = 'timestamp' THEN 'byte[]'
        WHEN DATA_TYPE = 'varbinary' THEN 'byte[]'
        WHEN DATA_TYPE = 'bit' AND IS_NULLABLE = 'NO' THEN 'bool'
        WHEN DATA_TYPE = 'bit' AND IS_NULLABLE = 'YES' THEN 'bool?'
    END + ' ' + COLUMN_NAME + ' {get;set;}'
FROM INFORMATION_SCHEMA.COLUMNS 
        WHERE TABLE_NAME = @tbl

INSERT #tmp SELECT 999, '}'

SELECT @flds=@flds + f1 +'
' from #tmp order by f0

DROP TABLE #tmp

PRINT @flds
END







GO
/****** Object:  StoredProcedure [dbo].[sp_CauHinhFormCot_GetInfoByMaForm]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************  
1. Create Date	: 2017.04.18
2. Creator		: Tran Quoc Hung
3. Description	: Lấy CauSelect và CauSapXep theo MaForm
4. Function		: 
5. Example		: 
					Declare @MA_FORM VarChar(6) = 'FL0002';  
					Declare @FIELD VarChar(MAX) = '';  
					Declare @ORDER_CLAUSE VarChar(MAX) = '';  

					exec [MSSQL_QLDN_MAIN].dbo.[sp_CauHinhFormCot_GetInfoByMaForm]
					@MA_FORM = @MA_FORM,
					@FIELD = @FIELD OUTPUT,
					@ORDER_CLAUSE = @ORDER_CLAUSE OUTPUT;

					select @MA_FORM,@FIELD,@ORDER_CLAUSE ;	

6. Precaution	:
7. History		:
				  2017.04.18(Tran Quoc Hung) - Tạo mới
*************************************************************/
CREATE PROC [dbo].[sp_CauHinhFormCot_GetInfoByMaForm]
( 
	@MA_FORM			VarChar(6)					-- Mã Form
	, @FIELD			nvarchar(2000)	OUTPUT		-- Chuỗi các CauSelect trả về
	, @ORDER_CLAUSE		nvarchar(2000)	OUTPUT		-- Chuỗi các CauSapXep trả về

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến

	-- Chuẩn bị biến @FIELD
	SET @FIELD = ISNULL(@FIELD,'')

	-- Chuẩn bị biến @ORDER_CLAUSE
	SET @ORDER_CLAUSE = ISNULL(@ORDER_CLAUSE,'')
	----------
    
---- Xây dựng nội dung câu SQL  

select @FIELD = 
    case when @FIELD = ''
        then coalesce(CauSelect, '')
        else @FIELD + coalesce(',' + CauSelect, '')
    end
from CauHinhFormCot  WITH(NOLOCK, READUNCOMMITTED) 
where MaForm = @MA_FORM AND HienThiYN = 1;

select @ORDER_CLAUSE = 
    case when @ORDER_CLAUSE = ''
        then coalesce(CauSapXep, '')
        else @ORDER_CLAUSE + coalesce(',' + CauSapXep, '')
    end
from CauHinhFormCot  WITH(NOLOCK, READUNCOMMITTED) 
where MaForm = @MA_FORM;

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[sp_CauHinhFormCot_GetListCauHinhFormCotByCriteria]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************  
1. Create Date	: 2017.04.20
2. Creator		: Nguyen Thanh Binh
3. Description	: Lấy danh sách cột theo form
4. Function		: 
5. Example		: 
					EXEC	[dbo].[sp_CauHinhFormCot_GetListCauHinhFormCotByCriteria]
							@MA_FORM = N'FM0001',
							@SEARCH_STRING = N'',
							@FIELD = N'',
							@ORDER_CLAUSE = N'ThuTu asc',
							@SKIP = 0,
							@TAKE = 0
6. Precaution	:
7. History		:
				  2017.04.20(Nguyen Thanh Binh) - Tạo mới
				  2017.04.21(Nguyen Thanh Binh) - viết nội dung sp
*************************************************************/
CREATE PROC [dbo].[sp_CauHinhFormCot_GetListCauHinhFormCotByCriteria]
( 
	  @MA_FORM			varchar(10)			=	NULL		-- Mã Form
	, @SEARCH_STRING	nvarchar(2000)		=	NULL		-- Chuỗi tìm kiếm nhanh
	, @FIELD			nvarchar(2000)		=	NULL		-- danh sách column
	, @ORDER_CLAUSE		nvarchar(2000)		=	NULL		-- câu sắp xếp

	, @SKIP				int					=	NULL		-- Số dòng skip (để phân trang)
	, @TAKE				int					=	NULL		-- Số dòng take (để phân trang)

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
	DECLARE @V_SQL NVARCHAR(4000) 
	DECLARE @V_SEARCH_STRING NVARCHAR(4000)
	DECLARE @V_WHERE_CLAUSE NVARCHAR(4000) 

	SET @V_WHERE_CLAUSE = N' 1=1 ';

---- kiểm tra biến đầu vào
	SET @FIELD = ISNULL(@FIELD, '');
	IF (@FIELD = '')
	SET @FIELD = '*';

	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	

	-- Chuẩn bị biến @SKIP & @TAKE
	SET @SKIP = ISNULL(@SKIP, 0)

	SET @TAKE = ISNULL(@TAKE, 0)
	IF(@TAKE <= 0)
		SET @TAKE = 50

	-- Chuẩn bị biến @ORDER_CLAUSE
	SET @ORDER_CLAUSE = ISNULL(@ORDER_CLAUSE,'')

	IF (@ORDER_CLAUSE = '')
		SET @ORDER_CLAUSE = ' MAXCNT ';

---- Xây dựng nội dung câu SQL  
	SET @V_SQL = '
	SELECT COUNT(*) OVER () AS MAXCNT, ' + @FIELD + '
	FROM CauHinhFormCot FC WITH(NOLOCK, READUNCOMMITTED)
	'

---- Build Where clause
	-- Quick search
	IF @SEARCH_STRING <> ''
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' AND (MaForm LIKE ''' + @V_SEARCH_STRING + ''' OR MaCot LIKE N''' + @V_SEARCH_STRING + ''' OR TenCot LIKE N''' + @SEARCH_STRING + ''' OR TenCotMacDinh LIKE N''' + @SEARCH_STRING + ''') '
	END
	
	-- lọc theo mã form
		IF @MA_FORM <> ''
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' AND (MaForm = ''' + @MA_FORM + ''') '
	END

	IF @V_WHERE_CLAUSE > ''
	SET @V_SQL = @V_SQL + ' WHERE ' + @V_WHERE_CLAUSE

---- Build Order clause
	IF @ORDER_CLAUSE > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDER_CLAUSE

---- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

---- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)
---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[sp_KD_NguoiDung_cbxNguoiDungById]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_KD_NguoiDung_cbxNguoiDungById]
( 
	  @UserId		    nvarchar(500)	= NULL
    , @NhanVienId	    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @NguoiDungId		INT				= 0
	
)
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------  
	SET @NguoiDungId = ISNULL(@NguoiDungId,0)

	SELECT NguoiDungId, MaNguoiDung, HoTen TenNguoiDung
	FROM dbo.NguoiDung
	WHERE (@NguoiDungId = 0 OR VaiTroId = @NguoiDungId)

--------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KD_PhanQuyen_GetListChucNang]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KD_PhanQuyen_GetListChucNang]
( 
	@VAITROID			int					-- VaiTroId
	,@LOAI				int					-- Loai 1: QLNS, 2: QLKho
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước

 SET @LOAI = ISNULL(@LOAI,'1')
---- Thực thi câu SQL
	IF @LOAI='2'
	BEGIN
		SELECT 	a.ChucNangId,a.MaChucNang,a.TenChucNang,a.DSQuyen,Isnull(b.DSQuyenTacVu,'') as DSQuyenTacVu 
		FROM ChucNang a 
		LEFT JOIN QuyenTacVu b on a.ChucNangId=b.ChucNangId AND b.VaiTroId = @VAITROID
		LEFT JOIN VaiTro c on b.VaiTroId=c.VaiTroId
		where a.ThuTu>=100 OR a.MaChucNang='CN0024' OR a.MaChucNang='CN0005' OR a.MaChucNang='CN0018' AND a.MaChucNang LIKE 'KD%'
		ORDER BY a.ThuTu
	END
	ELSE
	BEGIN
		SELECT 	a.ChucNangId,a.MaChucNang,a.TenChucNang,a.DSQuyen,Isnull(b.DSQuyenTacVu,'') as DSQuyenTacVu 
		FROM ChucNang a 
		LEFT JOIN QuyenTacVu b on a.ChucNangId=b.ChucNangId AND b.VaiTroId = @VAITROID
		LEFT JOIN VaiTro c on b.VaiTroId=c.VaiTroId
		where a.ThuTu<100 AND a.MaChucNang LIKE 'KD%'
		ORDER BY a.ThuTu
	END
	

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END



GO
/****** Object:  StoredProcedure [dbo].[sp_KD_QuyenTacVu_CheckQuyenTacVuByChucNang]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************************************  
1. Create Date	: 2017.05.18
2. Creator		: Văn Phú Hội
3. Description	: kiểm tra quyền theo chức năng
4. Function		: 
5. Example		: 
					

6. Precaution	:
7. History		:
				  2017.05.18(Văn Phú Hội) - Tạo mới
*************************************************************/
CREATE PROC [dbo].[sp_KD_QuyenTacVu_CheckQuyenTacVuByChucNang]
( 
	@LOGIN_ID			VARCHAR(50)		
	, @CHUC_NANG		VARCHAR(20)	
	, @QUYEN_TAC_VU		VARCHAR(200)
	, @YES_NO			VARCHAR(20)='0' OUTPUT
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  


	SELECT @YES_NO= COUNT(*)  
	FROM [MSSQL_QLDN_MAIN_DEMO].DBO.QuyenTacVu q
	JOIN [MSSQL_QLDN_MAIN_DEMO].DBO.NguoiDung n ON n.VaiTroId=q.VaiTroId 
	JOIN [MSSQL_QLDN_MAIN_DEMO].DBO.ChucNang c ON q.ChucNangId=c.ChucNangId 
	WHERE n.NguoiDungId=@LOGIN_ID AND c.MaChucNang=@CHUC_NANG AND q.DSQuyenTacVu LIKE '%'+@QUYEN_TAC_VU+'%'


-----------------------------------------------------
SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[sp_KD_VaiTro_cbxVaiTroById]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_KD_VaiTro_cbxVaiTroById]
( 
	  @UserId		    nvarchar(500)	= NULL
    , @NhanVienId	    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @VaiTroId			INT				= 0
	
)
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------  
	SET @VaiTroId = ISNULL(@VaiTroId,0)

	SELECT VaiTroId, MaVaiTro, TenVaiTro
	FROM dbo.VaiTro
	WHERE (@VaiTroId = 0 OR VaiTroId = @VaiTroId)

--------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_GetListNguoiDungByCriteria]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************************************  
1. Create Date	: 
2. Creator		: 
3. Description	: Lấy danh sách Nghỉ phép theo điều kiện
4. Function		: QLDNMAIN/NguoiDung/List
5. Example		: 



6. Precaution	:
7. History		:
				  2017.04.15() - Tạo mới
*************************************************************/
CREATE PROC [dbo].[sp_NguoiDung_GetListNguoiDungByCriteria]
( 
	@MA_FORM			    varchar(6)		= 'FL0009'			-- Mã Form
	, @FIELD			    nvarchar(500)	= null			-- Danh sách các field cần lấy
	, @SEARCH_TUNGAY		nvarchar(500)	= null
	, @SEARCH_DENNGAY		nvarchar(500)	= null
	, @SEARCH_NHANVIEN		nvarchar(500)	= null
	, @SEARCH_VAITRO		nvarchar(500)	= null
	, @LOGIN_ID				nvarchar(500)	= null
	, @ORDER_CLAUSE		nvarchar(500)	= null			-- Mệnh đề order by (VD: NhanVienId ASC|DESC,HoTen ASC|DESC)

	, @SKIP				int				= null			-- Số dòng skip (để phân trang)
	, @TAKE				int				= null			-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 
	DECLARE @V_SEARCH_STRING NVARCHAR(4000) 
	DECLARE @V_WHERE_CLAUSE NVARCHAR(4000) = N' 1 = 1 ';
	DECLARE @V_FIELD NVARCHAR(4000) = ''
	DECLARE @V_ORDER_CLAUSE NVARCHAR(4000) = ''
	DECLARE @IS_VIEW_ALL varchar = '0'
	-- Chuẩn bị biến @MA_FORM
	SET @MA_FORM = ISNULL(@MA_FORM,'')
	----------

	-- Chuẩn bị biến @FIELD
	SET @FIELD = ISNULL(@FIELD,'*')

	IF (@FIELD = '')
		SET @FIELD = '*';
	----------


	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@ORDER_CLAUSE IS NULL)
		SET @ORDER_CLAUSE = ' MAXCNT ';

	IF (@ORDER_CLAUSE = '')
		SET @ORDER_CLAUSE = ' MAXCNT ';
	----------

	---- Gọi SP lấy thông tin Cấu Hình
	IF (@MA_FORM <> '')
	BEGIN
		exec MSSQL_QLDN_MAIN.dbo.[sp_CauHinhFormCot_GetInfoByMaForm]
		@MA_FORM = @MA_FORM,
		@FIELD = @V_FIELD OUTPUT,
		@ORDER_CLAUSE = @V_ORDER_CLAUSE OUTPUT;

		IF (@FIELD = '*' AND @V_FIELD <> '')
		BEGIN
			SET @FIELD = @V_FIELD;
		END

		IF (@ORDER_CLAUSE = ' MAXCNT ' AND @V_ORDER_CLAUSE <> '')
		BEGIN
			SET @ORDER_CLAUSE = @V_ORDER_CLAUSE;
		END
	END

    ----------
	exec MSSQL_QLDN_MAIN.dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
	@LOGIN_ID = @LOGIN_ID,
	@CHUC_NANG = 'CN0024',
	@QUYEN_TAC_VU = 'View All',
	@YES_NO=@IS_VIEW_ALL OUTPUT

		
	---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT,a.NguoiDungId,a.CtrVersion, '+@FIELD+'
	FROM NguoiDung a left join [MSSQL_QLDN_QLNS].[DBO].NhanVien b on a.NhanVienId = b.NhanVienId 
	left join VaiTro c on c.VaiTroId=a.VaiTroId ';

	IF( @SEARCH_TUNGAY <> '' AND @SEARCH_DENNGAY <> '')
	BEGIN 
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' and a.NgayTaoDT BETWEEN  ''' + @SEARCH_TUNGAY + ''' AND '''+ @SEARCH_DENNGAY + '  ''';
	END
	ELSE IF @SEARCH_TUNGAY <> ''
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + 'and  a.NgayTaoDT >=  ''' + @SEARCH_TUNGAY + '  ''';
	END
	ELSE IF @SEARCH_DENNGAY <>''
	BEGIN 
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' and a.NgayTaoDT <=  ''' + @SEARCH_DENNGAY + '  ''';
	END
		

	IF @SEARCH_NHANVIEN <> ''
	BEGIN
	    IF(@V_WHERE_CLAUSE!='')
			set @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + 'and'
		SET @V_WHERE_CLAUSE =  @V_WHERE_CLAUSE+' A.NhanVienId in(' + @SEARCH_NHANVIEN + ') ' ;
	END

	IF @SEARCH_VAITRO<> ''
	BEGIN
	    IF(@V_WHERE_CLAUSE!='')
			set @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + 'and'
		SET @V_WHERE_CLAUSE =  @V_WHERE_CLAUSE+' C.VaiTroId in(' + @SEARCH_VAITRO + ') ' ;
	END
	
	IF @IS_VIEW_ALL = '0' 
	BEGIN		
	 IF(@V_WHERE_CLAUSE!='')
			set @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + 'AND'
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + '  (a.NhanVienId =''' + @LOGIN_ID + ''' )';
		
	END
	-- Build Where clause	
	IF @V_WHERE_CLAUSE > ''
	SET @V_SQL = @V_SQL + ' WHERE ' + @V_WHERE_CLAUSE
					

	-- Build Order clause
	IF @ORDER_CLAUSE > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDER_CLAUSE;

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@SKIP AS nvarchar(20)) +' ROWS';

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@TAKE AS nvarchar(20)) +' ROWS ONLY';

---- Thực thi câu SQL
	
	EXEC(@V_SQL);

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END



GO
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_GetListNguoiDungById]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************************************  
1. Create Date	: 
2. Creator		: 
3. Description	: Lấy danh sách Nghỉ phép theo điều kiện
4. Function		: QLDNMAIN/NguoiDung/List
5. Example		: 



6. Precaution	:
7. History		:
				  2017.04.15() - Tạo mới
*************************************************************/
CREATE PROC [dbo].[sp_NguoiDung_GetListNguoiDungById]
( 

	 @SEARCH_NguoiDungID	nvarchar(500)	= null
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 
	DECLARE @V_WHERE_CLAUSE NVARCHAR(4000) 

	-- Chuẩn bị biến @MA_FORM

	----------


	-- Chuẩn bị biến @V_WHERE_CLAUSE
	SET @V_WHERE_CLAUSE = '';



---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT,a.MaNguoiDung,a.NguoiDungId,a.HoTen,a.NhanVienId,a.Email,a.DienThoai,a.VaiTroId,b.Ho,b.Ten,c.TenVaiTro,a.CtrVersion
	FROM NguoiDung a left join [MSSQL_QLDN_QLNS].[DBO].NhanVien b on a.NhanVienId = b.NhanVienId 
	left join VaiTro c on c.VaiTroId=a.VaiTroId ';

	IF @SEARCH_NguoiDungID<> ''
	BEGIN
	    IF(@V_WHERE_CLAUSE!='')
			set @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + 'and'
		SET @V_WHERE_CLAUSE =  @V_WHERE_CLAUSE+' A.NguoiDungId in(' + @SEARCH_NguoiDungID + ') ' ;
	END

	-- Build Where clause

	IF @V_WHERE_CLAUSE > ''
	SET @V_SQL = @V_SQL + ' WHERE ' + @V_WHERE_CLAUSE
					

---- Thực thi câu SQL
	print(@V_SQL)
	EXEC(@V_SQL);

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END



GO
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_SelectAllByCriteria]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_NguoiDung_SelectAllByCriteria]
@WhereClause varchar(500) = null
, @OrderClause varchar(500) = null
, @SkipClause varchar(50) = null
, @TakeClause varchar(50) = null
AS
-- selects all rows from the table according to search criteria
DECLARE @SQL VARCHAR(4000) 
SET @SQL = '
SELECT 
[NguoiDungId],
[MaNguoiDung],
[Email],
[EmailDaXacNhanYN],
[PasswordHash],
[SecurityStamp],
[DienThoai],
[DienThoaiDaXacNhanYN],
[BaoMatHaiLopYN],
[KhoaDen],
[KhoaYN],
[LanDangNhapSai],
[UserName],
[VaiTroId],
[HoTen],
[NgayTaoDT],
[NgaySuaDT],
[NguoiTao],
[NguoiSua],
[CtrVersion]
FROM [dbo].[NguoiDung]
'
IF @WhereClause > ''
SET @SQL = @SQL + ' WHERE ' + @WhereClause
IF @OrderClause > ''
SET @SQL = @SQL + ' ORDER BY ' + @OrderClause
IF @SkipClause > ''
SET @SQL = @SQL + ' ' + @SkipClause
IF @TakeClause > ''
SET @SQL = @SQL + ' ' + @TakeClause
EXEC(@SQL)








GO
/****** Object:  StoredProcedure [dbo].[sp_PhanQuyen_GetListChucNang]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*************************************************************  
1. Create Date	: 2017.03.30
2. Creator		: Nguyen Ngoc Tan
3. Description	: Lấy Quyền tác vụ theo MaChucNang và MaVaiTro
4. Function		: QLDNMAIN/NghiPhep/List
5. Example		: 
					exec [dbo].[sp_PhanQuyen_GetListChucNang]
					@VAITROID = 1, @LOAI=2
					
6. Precaution	:
7. History		:
				  2017.03.30(Nguyen Ngoc Tan) - Tạo mới
				  2017.07.08 (TAN) add more parameter @LOAI
*************************************************************/
CREATE PROC [dbo].[sp_PhanQuyen_GetListChucNang]
( 
	@VAITROID			int					-- VaiTroId
	,@LOAI				int					-- Loai 1: QLNS, 2: QLKho
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước

 SET @LOAI = ISNULL(@LOAI,'1')
---- Thực thi câu SQL
	IF @LOAI='2'
	BEGIN
		SELECT 	a.ChucNangId,a.MaChucNang,a.TenChucNang,a.DSQuyen,Isnull(b.DSQuyenTacVu,'') as DSQuyenTacVu 
		FROM ChucNang a 
		LEFT JOIN QuyenTacVu b on a.ChucNangId=b.ChucNangId AND b.VaiTroId = @VAITROID
		LEFT JOIN VaiTro c on b.VaiTroId=c.VaiTroId
		where a.ThuTu>=100 OR a.MaChucNang='CN0024' OR a.MaChucNang='CN0005' OR a.MaChucNang='CN0018'
		ORDER BY a.ThuTu
	END
	ELSE
	BEGIN
		SELECT 	a.ChucNangId,a.MaChucNang,a.TenChucNang,a.DSQuyen,Isnull(b.DSQuyenTacVu,'') as DSQuyenTacVu 
		FROM ChucNang a 
		LEFT JOIN QuyenTacVu b on a.ChucNangId=b.ChucNangId AND b.VaiTroId = @VAITROID
		LEFT JOIN VaiTro c on b.VaiTroId=c.VaiTroId
		where a.ThuTu<100
		ORDER BY a.ThuTu
	END
	

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END



GO
/****** Object:  StoredProcedure [dbo].[sp_PhanQuyen_GetListQuyenTacVuBangVaiTroId]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************  
1. Create Date	: 2017.03.30
2. Creator		: Tran Quoc Hung
3. Description	: Lấy Quyền tác vụ theo MaChucNang và MaVaiTro
4. Function		: QLDNMAIN/NghiPhep/List
5. Example		: 
					exec [dbo].[sp_PhanQuyen_GetListQuyenTacVuBangVaiTroId]
					@VAITROID = 1
					
6. Precaution	:
7. History		:
				  2017.03.30(Tran Quoc Hung) - Tạo mới
*************************************************************/
CREATE PROC [dbo].[sp_PhanQuyen_GetListQuyenTacVuBangVaiTroId]
( 
	@VAITROID			int					-- VaiTroId
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước

   
---- Thực thi câu SQL
	SELECT 
	VT.VaiTroId
	,[MaVaiTro]
	,MaChucNang
	,QTV.DSQuyenTacVu
	FROM [dbo].[VaiTro] VT
	inner join [dbo].[QuyenTacVu] QTV on VT.VaiTroId = QTV.VaiTroId
	inner join [dbo].[ChucNang] CN on CN.ChucNangId = QTV.ChucNangId
	WHERE 
	VT.VaiTroId = @VAITROID
	

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[sp_PhanQuyen_GetQuyenTacVuByMaChucNangAndMaVaiTro]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************  
1. Create Date	: 2017.04.27
2. Creator		: Tran Quoc Hung
3. Description	: Lấy Quyền tác vụ theo MaChucNang và MaVaiTro
4. Function		: QLDNMAIN/NghiPhep/List
5. Example		: 
					exec [dbo].[sp_QuyenTacVu_GetByMaChucNangAndMaVaiTro]
					@MACHUCNANG = 'CN0006'
					,@MAVAITRO = 'Admin'

6. Precaution	:
7. History		:
				  2017.04.27(Tran Quoc Hung) - Tạo mới
*************************************************************/
CREATE PROC [dbo].[sp_PhanQuyen_GetQuyenTacVuByMaChucNangAndMaVaiTro]
( 
	@MACHUCNANG			nvarchar(64)			-- Mã Chức Năng
	, @MAVAITRO			nvarchar(64)			-- Mã Vai trò

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước

	-- Chuẩn bị biến @MACHUCNANG
	SET @MACHUCNANG = ISNULL(@MACHUCNANG,'')

	-- Chuẩn bị biến @MAVAITRO
	SET @MAVAITRO = ISNULL(@MAVAITRO, '')

   
---- Thực thi câu SQL
	SELECT TOP 1
	VT.VaiTroId
	,[MaVaiTro]
	,MaChucNang
	,QTV.DSQuyenTacVu
	FROM [dbo].[VaiTro] VT WITH(NOLOCK, READUNCOMMITTED)
		inner join [dbo].[QuyenTacVu] QTV on VT.VaiTroId = QTV.VaiTroId
		inner join [dbo].[ChucNang] CN on CN.ChucNangId = QTV.ChucNangId
	WHERE 
	[MaVaiTro] = @MAVAITRO and MaChucNang = @MACHUCNANG
	

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************************************  
1. Create Date	: 2017.05.18
2. Creator		: Văn Phú Hội
3. Description	: kiểm tra quyền theo chức năng
4. Function		: 
5. Example		: 
					

6. Precaution	:
7. History		:
				  2017.05.18(Văn Phú Hội) - Tạo mới
*************************************************************/
CREATE PROC [dbo].[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
( 
	@LOGIN_ID			VARCHAR(50)		
	, @CHUC_NANG		VARCHAR(20)	
	, @QUYEN_TAC_VU		VARCHAR(200)
	, @YES_NO			VARCHAR(20)='0' OUTPUT
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  


	SELECT @YES_NO= COUNT(*)  
	FROM [MSSQL_QLDN_MAIN].DBO.QuyenTacVu q
	JOIN [MSSQL_QLDN_MAIN].DBO.NguoiDung n ON n.VaiTroId=q.VaiTroId 
	JOIN [MSSQL_QLDN_MAIN].DBO.ChucNang c ON q.ChucNangId=c.ChucNangId 
	WHERE n.NhanVienId=@LOGIN_ID AND c.MaChucNang=@CHUC_NANG AND q.DSQuyenTacVu LIKE '%'+@QUYEN_TAC_VU+'%'


-----------------------------------------------------
SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_DeleteOne]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
-- Stored procedure generated by CodeTrigger
-- This script was generated on 3/26/2017 9:09:15 PM
------------------------------------------------------------
CREATE PROCEDURE [dbo].[sp_VaiTro_DeleteOne]
@VaiTroId int
AS
-- delete all matching from the table
DELETE [dbo].[VaiTro]
WHERE 
[VaiTroId] = @VaiTroId







GO
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_InsertOne]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
-- Stored procedure generated by CodeTrigger
-- This script was generated on 3/26/2017 9:09:15 PM
------------------------------------------------------------
CREATE PROCEDURE [dbo].[sp_VaiTro_InsertOne]
@VaiTroId int OUTPUT
, @MaVaiTro nvarchar(64) OUTPUT
, @TenVaiTro nvarchar(128) OUTPUT
, @MoTa nvarchar(256) OUTPUT
, @KhoaYN bit OUTPUT
, @TenVaiTroRex nvarchar(16) OUTPUT
, @NgayTaoDT datetime OUTPUT
, @NgaySuaDT datetime OUTPUT
, @NguoiTao nvarchar(128) OUTPUT
, @NguoiSua nvarchar(128) OUTPUT
, @CtrVersion int OUTPUT
AS
-- inserts a new row into the table
INSERT [dbo].[VaiTro]
(
[MaVaiTro]
,[TenVaiTro]
,[MoTa]
,[KhoaYN]
,[TenVaiTroRex]
,[NgayTaoDT]
,[NgaySuaDT]
,[NguoiTao]
,[NguoiSua]
,[CtrVersion]
)
VALUES
(
@MaVaiTro
,@TenVaiTro
,@MoTa
,@KhoaYN
,@TenVaiTroRex
,@NgayTaoDT
,@NgaySuaDT
,@NguoiTao
,@NguoiSua
,@CtrVersion
)
SELECT 
@VaiTroId = [VaiTroId]
,@MaVaiTro = [MaVaiTro]
,@TenVaiTro = [TenVaiTro]
,@MoTa = [MoTa]
,@KhoaYN = [KhoaYN]
,@TenVaiTroRex = [TenVaiTroRex]
,@NgayTaoDT = [NgayTaoDT]
,@NgaySuaDT = [NgaySuaDT]
,@NguoiTao = [NguoiTao]
,@NguoiSua = [NguoiSua]
,@CtrVersion = [CtrVersion]
FROM [dbo].[VaiTro]
WHERE 
[VaiTroId] = SCOPE_IDENTITY()







GO
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectAll]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
-- Stored procedure generated by CodeTrigger
-- This script was generated on 3/26/2017 9:09:15 PM
------------------------------------------------------------
CREATE PROCEDURE [dbo].[sp_VaiTro_SelectAll]
AS
-- selects all rows from the table
SELECT 
[VaiTroId]
,[MaVaiTro]
,[TenVaiTro]
,[MoTa]
,[KhoaYN]
,[TenVaiTroRex]
,[NgayTaoDT]
,[NgaySuaDT]
,[NguoiTao]
,[NguoiSua]
,[CtrVersion]
FROM [dbo].[VaiTro]







GO
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectAllByCriteria]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
-- Stored procedure generated by CodeTrigger
-- This script was generated on 3/26/2017 9:09:15 PM
------------------------------------------------------------
CREATE PROCEDURE [dbo].[sp_VaiTro_SelectAllByCriteria]
@WhereClause varchar(500) = null
, @OrderClause varchar(500) = null
, @SkipClause varchar(50) = null
, @TakeClause varchar(50) = null
AS
-- selects all rows from the table according to search criteria
DECLARE @SQL VARCHAR(4000) 
SET @SQL = '
SELECT 
[VaiTroId],
[MaVaiTro],
[TenVaiTro],
[MoTa],
[KhoaYN],
[TenVaiTroRex],
[NgayTaoDT],
[NgaySuaDT],
[NguoiTao],
[NguoiSua],
[CtrVersion]
FROM [dbo].[VaiTro]
'
IF @WhereClause > ''
SET @SQL = @SQL + ' WHERE ' + @WhereClause
IF @OrderClause > ''
SET @SQL = @SQL + ' ORDER BY ' + @OrderClause
IF @SkipClause > ''
SET @SQL = @SQL + ' ' + @SkipClause
IF @TakeClause > ''
SET @SQL = @SQL + ' ' + @TakeClause
EXEC(@SQL)







GO
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectAllByCriteriaCount]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
-- Stored procedure generated by CodeTrigger
-- This script was generated on 3/26/2017 9:09:15 PM
------------------------------------------------------------
CREATE PROCEDURE [dbo].[sp_VaiTro_SelectAllByCriteriaCount]
@WhereClause varchar(500) = null
AS
-- selects count of all rows from the table according to search criteria
DECLARE @SQL VARCHAR(4000) 
SET @SQL = '
SELECT COUNT(*)
FROM [dbo].[VaiTro]
'
IF @WhereClause > ''
SET @SQL = @SQL + ' WHERE ' + @WhereClause
EXEC(@SQL)







GO
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectAllByCriteriaProjection]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
-- Stored procedure generated by CodeTrigger
-- This script was generated on 3/26/2017 9:09:15 PM
------------------------------------------------------------
CREATE PROCEDURE [dbo].[sp_VaiTro_SelectAllByCriteriaProjection]
@FieldsField nvarchar(500) = null
, @WhereClause nvarchar(500) = null
, @OrderClause nvarchar(500) = null
, @SkipClause nvarchar(50) = null
, @TakeClause nvarchar(50) = null
AS
-- selects all rows from the table according to search criteria
DECLARE @SQL NVARCHAR(4000) 

print(N'Thống')

print(@WhereClause)

SET @SQL = N'
SELECT ' + @FieldsField + N'
FROM [dbo].[VaiTro]'
IF @WhereClause > ''
SET @SQL = @SQL + ' WHERE ' + @WhereClause
IF @OrderClause > ''
SET @SQL = @SQL + ' ORDER BY ' + @OrderClause
IF @SkipClause > ''
SET @SQL = @SQL + ' ' + @SkipClause
IF @TakeClause > ''
SET @SQL = @SQL + ' ' + @TakeClause

print(@SQL)

EXEC(@SQL)







GO
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectAllCount]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
-- Stored procedure generated by CodeTrigger
-- This script was generated on 3/26/2017 9:09:15 PM
------------------------------------------------------------
CREATE PROCEDURE [dbo].[sp_VaiTro_SelectAllCount]
AS
-- selects count of all rows from the table
SELECT COUNT(*)
FROM [dbo].[VaiTro]







GO
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectOne]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
-- Stored procedure generated by CodeTrigger
-- This script was generated on 3/26/2017 9:09:15 PM
------------------------------------------------------------
CREATE PROCEDURE [dbo].[sp_VaiTro_SelectOne]
@VaiTroId int
AS
-- selects all rows from the table
SELECT 
[VaiTroId]
,[MaVaiTro]
,[TenVaiTro]
,[MoTa]
,[KhoaYN]
,[TenVaiTroRex]
,[NgayTaoDT]
,[NgaySuaDT]
,[NguoiTao]
,[NguoiSua]
,[CtrVersion]
FROM [dbo].[VaiTro]
WHERE 
[VaiTroId] = @VaiTroId







GO
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_UpdateOne]    Script Date: 12/9/2017 9:43:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
-- Stored procedure generated by CodeTrigger
-- This script was generated on 3/26/2017 9:09:15 PM
------------------------------------------------------------
CREATE PROCEDURE [dbo].[sp_VaiTro_UpdateOne]
@VaiTroId int OUTPUT
, @MaVaiTro nvarchar(64) OUTPUT
, @TenVaiTro nvarchar(128) OUTPUT
, @MoTa nvarchar(256) OUTPUT
, @KhoaYN bit OUTPUT
, @TenVaiTroRex nvarchar(16) OUTPUT
, @NgayTaoDT datetime OUTPUT
, @NgaySuaDT datetime OUTPUT
, @NguoiTao nvarchar(128) OUTPUT
, @NguoiSua nvarchar(128) OUTPUT
, @CtrVersion int OUTPUT
AS
-- updates a row in the table based on the primary key

UPDATE [dbo].[VaiTro]
SET
[MaVaiTro] = @MaVaiTro
,[TenVaiTro] = @TenVaiTro
,[MoTa] = @MoTa
,[KhoaYN] = @KhoaYN
,[TenVaiTroRex] = @TenVaiTroRex
,[NgayTaoDT] = @NgayTaoDT
,[NgaySuaDT] = @NgaySuaDT
,[NguoiTao] = @NguoiTao
,[NguoiSua] = @NguoiSua
,[CtrVersion] = @CtrVersion
WHERE 
[VaiTroId] = @VaiTroId
SELECT 
@VaiTroId = [VaiTroId]
,@MaVaiTro = [MaVaiTro]
,@TenVaiTro = [TenVaiTro]
,@MoTa = [MoTa]
,@KhoaYN = [KhoaYN]
,@TenVaiTroRex = [TenVaiTroRex]
,@NgayTaoDT = [NgayTaoDT]
,@NgaySuaDT = [NgaySuaDT]
,@NguoiTao = [NguoiTao]
,@NguoiSua = [NguoiSua]
,@CtrVersion = [CtrVersion]
FROM [dbo].[VaiTro]
WHERE 
[VaiTroId] = @VaiTroId







GO
USE [master]
GO
ALTER DATABASE [MSSQL_QLDN_MAIN_DEMO] SET  READ_WRITE 
GO
