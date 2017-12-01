USE [master]
GO
/****** Object:  Database [MSSQL_QLDN_MAIN_DEMO]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  User [qldn]    Script Date: 12/1/2017 4:44:41 PM ******/
CREATE USER [qldn] FOR LOGIN [qldn] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [qldn]
GO
/****** Object:  Table [dbo].[CauHinhForm]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  Table [dbo].[CauHinhFormCot]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  Table [dbo].[CauHinhHeThong]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  Table [dbo].[ChucNang]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  Table [dbo].[Client]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  Table [dbo].[QuyenTacVu]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  Table [dbo].[VaiTro]    Script Date: 12/1/2017 4:44:41 PM ******/
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
SET IDENTITY_INSERT [dbo].[CauHinhForm] ON 

INSERT [dbo].[CauHinhForm] ([CauHinhFormId], [MaForm], [TenForm], [ChoPhepInYN], [ChoPhepXuatPdfYN], [KhoGiayIn], [MoTa], [TieuDe], [ChoPhepSapXepYN], [TieuDeRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3, N'FM0001', N'danh sách nhân viên', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhForm] ([CauHinhFormId], [MaForm], [TenForm], [ChoPhepInYN], [ChoPhepXuatPdfYN], [KhoGiayIn], [MoTa], [TieuDe], [ChoPhepSapXepYN], [TieuDeRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4, N'FL0002', N'Nghỉ Phép', 1, 1, N'A4', N'Quản lý nghỉ phép', N'Quản lý nghỉ phép', 1, N'RX000001', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhForm] ([CauHinhFormId], [MaForm], [TenForm], [ChoPhepInYN], [ChoPhepXuatPdfYN], [KhoGiayIn], [MoTa], [TieuDe], [ChoPhepSapXepYN], [TieuDeRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1004, N'FL0004', N'Tăng Ca', 1, 1, N'A4', N'Quản lý tăng ca', N'Quản lý tăng ca', 1, N'RX000002', NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[CauHinhForm] OFF
SET IDENTITY_INSERT [dbo].[CauHinhFormCot] ON 

INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1182, N'FM0001', N'Ma', N'Mã nhân viên', N'Mã nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV.Ma', 2, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1183, N'FM0001', N'Ten', N'Tên nhân viên', N'Tên nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV.Ten', 4, NULL, NULL, NULL, NULL, NULL, 27)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1184, N'FM0001', N'Ho', N'Họ nhân viên', N'Họ nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV.Ho', 3, NULL, NULL, NULL, NULL, NULL, 27)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1185, N'FL0002', N'NghiPhepId', N'Mã nghỉ phép', N'Mã nghỉ phép', 0, 1, 0, NULL, NULL, NULL, NULL, N'NghiPhepId', 100, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1186, N'FL0002', N'Ma', N'Mã nhân viên', N'Mã nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV.Ma', 100, NULL, NULL, NULL, NULL, NULL, 16)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1187, N'FL0002', N'HoTenNV_Tao', N'Người tạo', N'Người tạo', 1, 1, 0, NULL, NULL, NULL, NULL, N'(NV_TAO.Ho +'' ''+ NV_TAO.Ten) AS [HoTenNV_Tao]', 100, NULL, NULL, NULL, NULL, NULL, 18)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1188, N'FL0002', N'HoTenNV_Duyet', N'Người duyệt', N'Người duyệt', 0, 1, 0, NULL, NULL, NULL, NULL, N'(NV_DUYET.Ho +'' ''+ NV_DUYET.Ten) AS [HoTenNV_Duyet] ', 7, NULL, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1189, N'FL0002', N'HoTenNV_BanGiao', N'Bàn giao cho', N'Bàn giao cho', 0, 1, 0, NULL, NULL, NULL, NULL, N'(NV_BANGIAO.Ho +'' ''+ NV_BANGIAO.Ten) AS [HoTenNV_BanGiao] ', 6, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1190, N'FL0002', N'TuNgay', N'Từ ngày', N'Từ ngày', 1, 1, 0, NULL, NULL, NULL, NULL, N'CONVERT(VARCHAR(10),NP.TuNgay,103) as TuNgay', 2, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1191, N'FL0002', N'DenNgay', N'Đến ngày', N'Đến ngày', 1, 1, 0, NULL, NULL, NULL, NULL, N'CONVERT(VARCHAR(10),NP.DenNgay,103) as DenNgay', 3, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1192, N'FL0002', N'SoNgay', N'Số ngày', N'Số ngày', 1, 1, 0, NULL, NULL, NULL, NULL, N'NP.SoNgay', 4, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1193, N'FL0002', N'TieuDe', N'Tiêu đề', N'Tiêu đề', 1, 1, 0, NULL, NULL, NULL, NULL, N'NP.TieuDe', 1, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1194, N'FL0002', N'LyDo', N'Lý do', N'Lý do', 0, 1, 0, NULL, NULL, NULL, NULL, N'NP.LyDo', 100, NULL, NULL, NULL, NULL, NULL, 17)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1195, N'FL0002', N'TenLoaiPhep', N'Loại phép', N'Tên loại phép', 1, 1, 0, NULL, NULL, NULL, NULL, N'LNP.TenLoaiPhep', 5, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1196, N'FL0002', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 1, 1, 0, NULL, NULL, NULL, NULL, N'CONVERT(VARCHAR(10),NP.NgayTao,103) as NgayTao', 100, NULL, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1197, N'FL0002', N'TrangThai', N'Trạng thái', N'Trạng thái', 1, 1, 0, NULL, NULL, NULL, NULL, N'TT.TrangThai', 8, NULL, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1198, N'FM0001', N'TenPhongBan', N'Phòng ban', N'Phòng ban', 1, 0, 0, NULL, NULL, NULL, NULL, N'PB.TenPhongBan', 6, NULL, NULL, NULL, NULL, NULL, 27)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1199, N'FM0001', N'NhanVienId', N'ID', N'Nhân viên ID', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV.NhanVienId', 100, NULL, NULL, NULL, NULL, NULL, 41)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1200, N'FM0001', N'NgayTuyenDung', N'Ngày tuyển', N'Ngày tuyển dụng', 1, 1, 0, NULL, NULL, NULL, NULL, N'NgayTuyenDung', 100, NULL, NULL, NULL, NULL, NULL, 34)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1201, N'FM0001', N'TenChucVu', N'Chức vụ', N'Chức vụ', 1, 1, 0, NULL, NULL, NULL, NULL, N'TenChucVu', 100, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1202, N'FM0001', N'MaTrangThai', N'Trạng thái', N'MaTrangThai', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV.MaTrangThai', 100, NULL, NULL, NULL, NULL, NULL, 41)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1203, N'FM0001', N'CtrVersion', N'CtrVersion', N'CtrVersion', 0, 1, 0, NULL, NULL, NULL, NULL, N'NV.CtrVersion', 100, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1204, N'FM0001', N'DienThoai', N'Điện thoại', N'DienThoai', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV.DienThoai', 100, NULL, NULL, NULL, NULL, NULL, 95)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1205, N'FL0003', N'MA', N'Mã KH', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'A.MA', 1, NULL, NULL, NULL, NULL, NULL, 28)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1206, N'FL0003', N'TEN', N'Tên khách hàng', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'A.TEN', 2, NULL, NULL, NULL, NULL, NULL, 28)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1207, N'FL0003', N'LOAI', N'Loại', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'case when A.LOAI =1 then ''KH NCC'' else ''Khách Hàng'' end as LOAI', 3, NULL, NULL, NULL, NULL, NULL, 28)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1208, N'FL0003', N'DIENTHOAI', N'Điện thoại', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'A.DIENTHOAI', 4, NULL, NULL, NULL, NULL, NULL, 30)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1209, N'FL0003', N'DIDONG', N'Di động', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'A.DIDONG', 5, NULL, NULL, NULL, NULL, NULL, 30)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1210, N'FL0003', N'EMAIL', N'Email', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'A.EMAIL', 6, NULL, NULL, NULL, NULL, NULL, 30)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1211, N'FL0003', N'TENTT', N'Tỉnh', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'B.TENTT', 7, NULL, NULL, NULL, NULL, NULL, 32)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1212, N'FL0003', N'TENQUANHUYEN', N'Huyện', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'C.TENQUANHUYEN', 8, NULL, NULL, NULL, NULL, NULL, 32)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1213, N'FL0003', N'TENPHUONGXA', N'Trạm', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'D.TENPHUONGXA', 9, NULL, NULL, NULL, NULL, NULL, 35)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1214, N'FL0003', N'DIACHI', N'Địa chỉ', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'A.DIACHI', 10, NULL, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1215, N'FL0003', N'ANYDESK', N'Any Desk', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'ANYDESK', 11, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1216, N'FL0004', N'NgayTao', N'Ngày Tạo', N'Ngày Tạo', 1, 1, 0, NULL, NULL, NULL, NULL, N'CONVERT(VARCHAR(10),TC.NgayTao,103) as NgayTao', 1, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1217, N'FL0004', N'TieuDe', N'Tiêu đề', N'Tiêu đề', 1, 1, 0, NULL, NULL, NULL, NULL, N'TC.TieuDe', 2, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1218, N'FL0004', N'LyDo', N'Lý Do', N'Lý Do', 1, 1, 0, NULL, NULL, NULL, NULL, N'TC.LyDo', 3, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1219, N'FL0004', N'Loai', N'Loại', N'Loại ', 1, 1, 0, NULL, NULL, NULL, NULL, N'TC.Loai', 4, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1220, N'FL0004', N'HoTenNV', N'Họ Tên Nhân Viên', N'Họ Tên Nhân Viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'(NV.Ho +'' ''+ NV.Ten) AS HoTenNV', 5, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1221, N'FL0004', N'SoGio', N'Số giờ', N'Số giờ', 1, 1, 0, NULL, NULL, NULL, NULL, N'TC.SoGio AS SoGio', 6, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1222, N'FL0004', N'HoTenNV_Tao', N'Nhân viên tạo', N'Người tạo', 1, 1, 0, NULL, NULL, NULL, NULL, N'(NV_TAO.Ho +'' ''+ NV_TAO.Ten) AS [HoTenNV_Tao]', 7, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1223, N'FL0004', N'HoTenNV_Duyet', N'Nhân Viên duyệt', N'Người duyệt', 0, 1, 0, NULL, NULL, NULL, NULL, N'(NV_DUYET.Ho +'' ''+ NV_DUYET.Ten) AS [HoTenNV_Duyet] ', 8, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1224, N'FL0004', N'NgayTangCa', N'Ngày tăng ca', N'Ngày tăng ca', 1, 1, 0, NULL, NULL, NULL, NULL, N'CONVERT(VARCHAR(10),TC.NgayTangCa,103) as NgayTangCa', 9, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1225, N'FL0004', N'TrangThai', N'Trạng Thái', N'Trạng Thái', 1, 1, 0, NULL, NULL, NULL, NULL, N'TT.TrangThai', 10, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1226, N'FL0005', N'NgayTao', N'Ngày tiếp nhận', N'Ngày tiếp nhận', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.NgayTao', 6, NULL, NULL, NULL, NULL, NULL, 69)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1227, N'FL0005', N'TieuDe', N'Tiêu đề', N'Tiêu đề', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.TieuDe', 20, NULL, NULL, NULL, NULL, NULL, 69)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1228, N'FL0005', N'LoaiIssue', N'Loại issue', N'Loại issue', 0, 1, 0, NULL, NULL, NULL, NULL, N'case when A.LoaiIssue =1 then N''Lỗi phần mềm'' else case when A.LoaiIssue =2 then N''Lỗi người dùng'' else N''Khác'' end end as LoaiIssue', 30, NULL, NULL, NULL, NULL, NULL, 69)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1229, N'FL0005', N'NguoiXuLy', N'Người xử lý', N'Người xử lý', 0, 1, 0, NULL, NULL, NULL, NULL, N'(c.Ho +'' ''+c.Ten) AS NguoiXuLy', 9, NULL, NULL, NULL, NULL, NULL, 69)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1230, N'FL0005', N'KhachHang', N'Khách hàng', N'Khách hàng', 1, 1, 0, NULL, NULL, NULL, NULL, N'(b.Ten) AS KhachHang', 5, NULL, NULL, NULL, NULL, NULL, 71)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1231, N'FL0005', N'MaTrangThai', N'Trạng thái', N'Trạng thái', 1, 1, 0, NULL, NULL, NULL, NULL, N'case when A.MaTrangThai =1 then N''Bắt đầu'' else case when A.MaTrangThai =2 then N''Đang xử lý'' else case when A.MaTrangThai =3 then N''Đã xử lý'' else case when A.MaTrangThai =4 then N''Chưa xử lý'' else N''Kết thúc'' end end end end as MaTrangThai', 80, NULL, NULL, NULL, NULL, NULL, 77)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1232, N'FL0005', N'NguoiLienHe', N'Người liên hệ', N'Người liên hệ', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.NguoiLienHe', 70, NULL, NULL, NULL, NULL, NULL, 66)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1233, N'FL0002', N'HoTenNV_YeuCau', N'Người yêu cầu', N'Người yêu cầu nghỉ phép', 1, 1, 0, NULL, NULL, NULL, NULL, N'(NV.Ho +'' ''+ NV.Ten) AS [HoTenNV_YeuCau]', 200, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1234, N'FL0006', N'TenBangLuong', N'Tên bảng lương', N'Tên bảng lương', 1, 1, 0, NULL, NULL, NULL, NULL, N'', 70, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1235, N'FL0006', N'ThangNam', N'Tháng năm', N'Tháng năm', 1, 1, 0, NULL, NULL, NULL, NULL, N'', 70, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1236, N'FL0006', N'ThoiGianPhatSinh', N'Thời gian phát sinh', N'Thời gian phát sinh', 1, 1, 0, NULL, NULL, NULL, NULL, N'', 70, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1237, N'FL0006', N'TongThuNhap', N'Tổng tiền', N'Tổng tiền', 1, 1, 0, NULL, NULL, NULL, NULL, N'', 70, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1238, N'FL0006', N'CacKhoanKhauTru', N'Giảm trừ', N'Giảm trừ', 1, 1, 0, NULL, NULL, NULL, NULL, N'', 70, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1239, N'FL0006', N'ThucLanh', N'Thực lãnh', N'Thực lãnh', 1, 1, 0, NULL, NULL, NULL, NULL, N'', 70, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1240, N'FL0006', N'TrangThai', N'Trạng thái', N'Trạng thái', 1, 1, 0, NULL, NULL, NULL, NULL, N'', 70, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1241, N'FL0007', N'TenDuAn', N'Tên dự án', N'Tên dự án', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.TenDuAn', 70, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1242, N'FL0007', N'MoTa', N'Mô tả', N'Mô tả', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.MoTa', 70, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1243, N'FL0007', N'TrangThai', N'Trạng thái', N'Trạng thái', 1, 1, 0, NULL, NULL, NULL, NULL, N'd.TrangThai', 70, NULL, NULL, NULL, NULL, NULL, 9)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1244, N'FL0007', N'TenPhongBan', N'Tên phòng ban', N'Tên phòng ban', 1, 1, 0, NULL, NULL, NULL, NULL, N'e.TenPhongBan', 70, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1245, N'FL0007', N'QuanLy', N'Quản lý', N'Quản lý', 1, 1, 0, NULL, NULL, NULL, NULL, N'c.Ho +'' ''+ c.Ten as QuanLy ', 70, NULL, NULL, NULL, NULL, NULL, 9)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1246, N'FL0007', N'NgayBatDau', N'Ngày bắt đầu', N'Ngày bắt đầu', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayBatDau,106),103) AS NgayBatDau', 70, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1247, N'FL0007', N'NgayThatSuBatDau', N'Ngày thật sự bắt đầu', N'Ngày thật sự bắt đầu', 0, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayThatSuBatDau,106),103) AS NgayThatSuBatDau', 70, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1248, N'FL0007', N'NgayKetThuc', N'Ngày kết thúc', N'Ngày kết thúc', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayKetThuc,106),103) AS NgayKetThuc', 70, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1249, N'FL0007', N'NgayThatSuKetThuc', N'Ngày thật sự kết thúc', N'Ngày thật sự kết thúc', 0, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayThatSuKetThuc,106),103) AS NgayThatSuKetThuc', 70, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1250, N'FL0008', N'TieuDe', N'Tiêu đề', N'Tiêu đề', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.TieuDe', 70, NULL, NULL, NULL, NULL, NULL, 28)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1251, N'FL0008', N'NhanVien', N'Nhân viên', N'Nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'c.Ho +'' ''+ c.Ten as NhanVien', 70, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1252, N'FL0008', N'NgayBatDau', N'Ngày bắt đầu', N'Ngày bắt đầu', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayBatDau,106),103) AS NgayBatDau', 70, NULL, NULL, NULL, NULL, NULL, 28)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1253, N'FL0008', N'NgayThatSuBatDau', N'Ngày thật sự bắt đầu', N'Ngày thật sự bắt đầu', 0, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayThatSuBatDau,106),103) AS NgayThatSuBatDau', 70, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1254, N'FL0008', N'NgayKetThuc', N'Ngày kết thúc', N'Ngày kết thúc', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayKetThuc,106),103) AS NgayKetThuc', 70, NULL, NULL, NULL, NULL, NULL, 28)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1255, N'FL0008', N'NgayThatSuKetThuc', N'Ngày thật sự kết thúc', N'Ngày thật sự kết thúc', 0, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayThatSuKetThuc,106),103) AS NgayThatSuKetThuc', 70, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1256, N'FL0008', N'SoNgay', N'Số ngày', N'Số ngày', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.SoNgay', 70, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1257, N'FL0008', N'TienDo', N'Tiến độ', N'Tiến độ', 1, 1, 0, NULL, NULL, NULL, NULL, N'CONVERT(VARCHAR(10), CAST(a.TienDo AS INT) ) + ''%'' AS TienDo', 70, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1258, N'FL0008', N'TenDuAn', N'Dự án', N'Dự án', 1, 1, 0, NULL, NULL, NULL, NULL, N'b.TenDuAn', 70, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1259, N'FL0008', N'TrangThai', N'Trạng thái', N'Trạng thái', 1, 1, 0, NULL, NULL, NULL, NULL, N'd.TrangThai', 70, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1260, N'FL0009', N'MaNguoiDung', N'Mã người dùng', N'Mã người dùng', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.MaNguoiDung', 70, NULL, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1261, N'FL0009', N'HoTen', N'Người dùng', N'Người dùng', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.HoTen', 70, NULL, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1262, N'FL0009', N'NhanVien', N'Nhân viên', N'Nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'b.Ho +'' ''+ b.Ten as NhanVien', 70, NULL, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1263, N'FL0009', N'Email', N'Email', N'Email', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.Email', 70, NULL, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1264, N'FL0009', N'DienThoai', N'Điện thoại', N'Điện thoại', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.DienThoai', 70, NULL, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1265, N'FL0009', N'TenVaiTro', N'Vai trò', N'Vai trò', 0, 1, 0, NULL, NULL, NULL, NULL, N'c.TenVaiTro', 70, NULL, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1266, N'FL0009', N'NgayTaoDT', N'Ngày tạo', N'Ngày tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayTaoDT,106),103) AS NgayTaoDT', 70, NULL, NULL, NULL, NULL, NULL, 35)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1267, N'FL0010', N'Ngay', N'Ngày', N'Ngày', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.GioLam,106),103) AS Ngay', 70, NULL, NULL, NULL, NULL, NULL, 51)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1268, N'FL0010', N'NhanVien', N'Nhân viên', N'Nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'b.Ho +'' ''+ b.Ten as NhanVien', 70, NULL, NULL, NULL, NULL, NULL, 51)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1269, N'FL0010', N'GioLam', N'Giờ làm', N'Giờ làm', 1, 1, 0, NULL, NULL, NULL, NULL, N'SUBSTRING( convert(varchar, a.Giolam,108),1,5) as GioLam', 70, NULL, NULL, NULL, NULL, NULL, 51)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1270, N'FL0010', N'GioVe', N'Giờ về', N'Giờ về', 1, 1, 0, NULL, NULL, NULL, NULL, N'SUBSTRING( convert(varchar, a.GioVe,108),1,5) as GioVe', 70, NULL, NULL, NULL, NULL, NULL, 51)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1271, N'FL0010', N'Thu', N'Thứ', N'Thứ', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.Thu', 70, NULL, NULL, NULL, NULL, NULL, 51)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1272, N'FL0005', N'NguoiTao', N'Người tạo', N'Người tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'd.Ho+'' ''+ d.Ten as NguoiTao', 70, NULL, NULL, NULL, NULL, NULL, 65)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1273, N'FL0010', N'TenPhongBan', N'Phòng ban', N'Phòng ban', 1, 1, 0, NULL, NULL, NULL, NULL, N'c.TenPhongBan', 70, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1274, N'FL0005', N'MaKhachHang', N'Mã khách hàng', N'Mã khách hàng', 1, 1, 0, NULL, NULL, NULL, NULL, N'b.Ma as MaKhachHang', 4, NULL, NULL, NULL, NULL, NULL, 66)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1275, N'FL0005', N'DienThoaiIssue', N'Điện thoai issue', N'Điện thoai issue', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.DiDong as DienThoaiIssue', 7, NULL, NULL, NULL, NULL, NULL, 64)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1276, N'FL0005', N'DienThoaiKH', N'Điện thoại khách hàng', N'Điện thoại khách hàng', 0, 1, 0, NULL, NULL, NULL, NULL, N'b.DienThoai as DienThoaiKH', 8, NULL, NULL, NULL, NULL, NULL, 62)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1277, N'FL0005', N'TenTT', N'Tỉnh', N'Tỉnh', 0, 1, 0, NULL, NULL, NULL, NULL, N'f.TenTT', 1, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1278, N'FL0005', N'TenQuanHuyen', N'Quận', N'Quận', 0, 1, 0, NULL, NULL, NULL, NULL, N'g.TenQuanHuyen', 2, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1279, N'FL0005', N'TenPhuongXa', N'Xã', N'Xã', 0, 1, 0, NULL, NULL, NULL, NULL, N'h.TenPhuongXa', 3, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1280, N'FL0005', N'NgayDeNghi', N'Ngày đề nghị', N'Ngày đề nghị', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayDeNghi,106),103)  as NgayDeNghi', 70, NULL, NULL, NULL, NULL, NULL, 60)
GO
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1281, N'FL0005', N'MoTa', N'Mô tả', N'Mô tả', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.MoTa', 70, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1282, N'FL0005', N'CachXuLy', N'Cách xử lý', N'Cách xử lý', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.CachXuLy', 70, NULL, NULL, NULL, NULL, NULL, 60)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1283, N'FM0011', N'Ma', N'Mã nhân viên', N'Mã nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV.Ma', 2, NULL, NULL, NULL, NULL, NULL, 44)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1284, N'FM0011', N'Ten', N'Tên nhân viên', N'Tên nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV.Ten', 4, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1285, N'FM0011', N'Ho', N'Họ nhân viên', N'Họ nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV.Ho', 3, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1286, N'FM0011', N'TenPhongBan', N'Phòng ban', N'Phòng ban', 1, 0, 0, NULL, NULL, NULL, NULL, N'PB.TenPhongBan', 6, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1287, N'FM0011', N'NgayTuyenDung', N'Ngày tuyển', N'Ngày tuyển dụng', 1, 1, 0, NULL, NULL, NULL, NULL, N'NgayTuyenDung', 100, NULL, NULL, NULL, NULL, NULL, 36)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1288, N'FL0008', N'NoiDungCongViec', N'Nội dung công việc', N'Nội dung công việc', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.NoiDungCongViec', 70, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1289, N'FL0008', N'ThuanLoiKhoKhan', N'Thuận Lợi  Khó Khăn', N'Thuận Lợi  Khó Khăn', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.ThuanLoiKhoKhan', 70, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1290, N'FL0008', N'GiaiPhapKienNghi', N'Giải pháp Kiến nghị', N'Giải pháp Kiến nghị', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.GiaiPhapKienNghi', 70, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1291, N'FM0012', N'MaHangHoa', N'Mã hàng hóa', N'Mã hàng hóa', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.MaHangHoa', 10, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1292, N'FM0012', N'TenHangHoa', N'Tên hàng hóa', N'Tên hàng hóa', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.TenHangHoa', 20, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1293, N'FM0012', N'TuKhoa', N'Từ khóa', N'Từ khóa', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.TuKhoa', 30, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1294, N'FM0012', N'DonViTinh', N'ĐVT', N'ĐVT', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.DonViTinh', 40, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1295, N'FM0012', N'GiaMua', N'Giá mua', N'Giá mua', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.GiaMua', 50, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1296, N'FM0012', N'GiaBan', N'Giá bán', N'Giá bán', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.GiaBan', 60, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1297, N'FM0012', N'TenNhom', N'Nhóm hàng hóa', N'Nhóm hàng hóa', 1, 1, 0, NULL, NULL, NULL, NULL, N'c.TenNhom', 70, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1298, N'FM0012', N'TenLoai', N'Loại hàng hóa', N'Loại hàng hóa', 1, 1, 0, NULL, NULL, NULL, NULL, N'd.TenLoai', 80, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1299, N'FM0012', N'Ten', N'Nhà cung cấp', N'Nhà cung cấp', 0, 1, 0, NULL, NULL, NULL, NULL, N'e.Ten', 90, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1300, N'FM0012', N'TenHangSanXuat', N'Hãng sản xuất', N'Hảng sản xuất', 1, 1, 0, NULL, NULL, NULL, NULL, N'f.TenHangSanXuat', 100, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1301, N'FM0012', N'TenNuoc', N'Nước sản xuất', N'Nước sản xuất', 1, 1, 0, NULL, NULL, NULL, NULL, N'h.TenNuoc', 110, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1302, N'FM0012', N'MoTa', N'Mô tả', N'Mô tả', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.MoTa', 120, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1303, N'FM0012', N'GhiChu', N'Ghi chú', N'Ghi chú', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.Ghichu', 130, NULL, NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1304, N'FM0013', N'SoPhieu', N'Số', N'Số', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.SoPhieu', 10, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1305, N'FM0013', N'LyDo', N'Lý do', N'Lý do', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.LyDo', 20, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1306, N'FM0013', N'NgayThu', N'Ngày thu', N'Ngày thu', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayThu,106),103) AS NgayThu', 30, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1307, N'FM0013', N'KhachHang', N'Đơn vị', N'Đơn vị', 1, 1, 0, NULL, NULL, NULL, NULL, N'e.Ten as KhachHang', 40, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1308, N'FM0013', N'NguoiNop', N'Người nộp', N'Người nộp', 1, 1, 0, NULL, NULL, NULL, NULL, N'f.Ho+'' ''+ f.Ten as NguoiNop', 50, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1309, N'FM0013', N'SoTien', N'Số tiền', N'Số tiền', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.SoTien', 60, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1310, N'FM0013', N'SoTienBangChu', N'Bằng chữ', N'Bằng chữ', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.SoTienBangChu', 70, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1311, N'FM0013', N'HinhThucThanhToan', N'Hình thức', N'Hình thức', 1, 1, 0, NULL, NULL, NULL, NULL, N'case when a.HinhThucThanhToan =''Y'' then N''Chuyển khoản'' else N''Tiền mặt'' end as HinhThucThanhToan', 80, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1312, N'FM0013', N'NganHang', N'Ngân hàng', N'Ngân Hàng', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.NganHang', 90, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1313, N'FM0013', N'TaiKhoanCo', N'Tài khoản có', N'Tài khoản có', 1, 1, 0, NULL, NULL, NULL, NULL, N'c.TenTaiKhoan as TaiKhoanCo', 100, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1314, N'FM0013', N'TaiKhoanNo', N'Tài khoản nợ', N'Tài khoản nợ', 1, 1, 0, NULL, NULL, NULL, NULL, N'd.TenTaiKhoan as TaiKhoanNo', 110, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1315, N'FM0013', N'GhiChu', N'Ghi chú', N'Ghi chú', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.GhiChu', 120, NULL, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1316, N'FM0014', N'SoPhieu', N'Số', N'Số', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.SoPhieu', 10, NULL, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1317, N'FM0014', N'LyDo', N'Lý do', N'Lý do', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.LyDo', 20, NULL, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1318, N'FM0014', N'NgayChi', N'Ngày chi', N'Ngày chi', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayChi,106),103) AS NgayChi', 30, NULL, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1319, N'FM0014', N'KhachHang', N'Đơn vị', N'Đơn vị', 1, 1, 0, NULL, NULL, NULL, NULL, N'e.Ten as KhachHang', 40, NULL, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1320, N'FM0014', N'NguoiNhan', N'Người nhận', N'Người nhận', 1, 1, 0, NULL, NULL, NULL, NULL, N'f.Ho+'' ''+ f.Ten as NguoiNhan', 50, NULL, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1321, N'FM0014', N'SoTien', N'Số tiền', N'Số tiền', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.SoTien', 60, NULL, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1322, N'FM0014', N'SoTienBangChu', N'Bằng chữ', N'Bằng chữ', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.SoTienBangChu', 70, NULL, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1323, N'FM0014', N'HinhThucThanhToan', N'Hình thức', N'Hình thức', 1, 1, 0, NULL, NULL, NULL, NULL, N'case when a.HinhThucThanhToan =''Y'' then N''Chuyển khoản'' else N''Tiền mặt'' end as HinhThucThanhToan', 80, NULL, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1324, N'FM0014', N'NganHang', N'Ngân hàng', N'Ngân Hàng', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.NganHang', 90, NULL, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1325, N'FM0014', N'TaiKhoanCo', N'Tài khoản có', N'Tài khoản có', 1, 1, 0, NULL, NULL, NULL, NULL, N'c.TenTaiKhoan as TaiKhoanCo', 100, NULL, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1326, N'FM0014', N'TaiKhoanNo', N'Tài khoản nợ', N'Tài khoản nợ', 1, 1, 0, NULL, NULL, NULL, NULL, N'd.TenTaiKhoan as TaiKhoanNo', 110, NULL, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1327, N'FM0014', N'GhiChu', N'Ghi chú', N'Ghi chú', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.GhiChu', 120, NULL, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1328, N'FM0015', N'SoPhieu', N'Số phiếu', N'Số phiếu', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPC.SoPhieu', 10, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1329, N'FM0015', N'NoiDung', N'Nội dung', N'Nội dung', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPC.NoiDung', 20, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1330, N'FM0015', N'TaiKhoanNhap', N'Tài khoản nhập', N'Tài khoản nhập', 1, 1, 0, NULL, NULL, NULL, NULL, N'TK.TenTaiKhoan as TaiKhoanNhap', 30, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1331, N'FM0015', N'TaiKhoanXuat', N'Tài khoản xuất', N'Tài khoản xuất', 1, 1, 0, NULL, NULL, NULL, NULL, N'TK2.TenTaiKhoan AS TaiKhoanXuat', 40, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1332, N'FM0015', N'KhoNhap', N'Kho nhập', N'Kho nhập', 1, 1, 0, NULL, NULL, NULL, NULL, N'Kho.TenKho as KhoNhap', 50, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1333, N'FM0015', N'KhoXuat', N'Kho xuất', N'Kho xuất', 1, 1, 0, NULL, NULL, NULL, NULL, N'Kho2.TenKho as KhoXuat', 60, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1334, N'FM0015', N'NgayNhap', N'Ngày nhập', N'Ngày nhập', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,KPC.NgayNhap,106),103) AS NgayNhap', 70, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1335, N'FM0015', N'NgayXuat', N'Ngày xuất', N'Ngày xuất', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,KPC.NgayXuat,106),103) AS NgayXuat', 80, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1336, N'FM0015', N'GhiChu', N'Ghi chú', N'Ghi chú', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPC.GhiChu', 90, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1337, N'FM0015', N'TrangThai', N'Trạng thái', N'Trạng thái', 1, 1, 0, NULL, NULL, NULL, NULL, N'TT.TrangThai', 100, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1338, N'FL0016', N'SoPhieu', N'Số phiếu', N'Số phiếu nhập', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPN.SoPhieu', 10, NULL, NULL, NULL, NULL, NULL, 31)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1339, N'FL0016', N'NoiDung', N'Nội dung', N'Nội dung', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPN.NoiDung', 20, NULL, NULL, NULL, NULL, NULL, 31)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1340, N'FL0016', N'NgayChungTu', N'Ngày CT', N'Ngày chứng từ', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPN.NgayChungTu', 30, NULL, NULL, NULL, NULL, NULL, 31)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1341, N'FL0016', N'TenKhachHang', N'Đơn vị', N'Khách hàng', 1, 1, 0, NULL, NULL, NULL, NULL, N'KH.Ten TenKhachHang', 40, NULL, NULL, NULL, NULL, NULL, 31)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1342, N'FL0016', N'TenKhoNhap', N'Kho hàng', N'Kho hàng', 1, 1, 0, NULL, NULL, NULL, NULL, N'KHO.TenKho TenKhoNhap', 50, NULL, NULL, NULL, NULL, NULL, 31)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1343, N'FL0016', N'TrangThai', N'Trạng thái', N'Trang thái', 1, 1, 0, NULL, NULL, NULL, NULL, N'TT.TrangThai', 100, NULL, NULL, NULL, NULL, NULL, 31)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1344, N'FL0016', N'SoHoaDon', N'Hóa đơn', N'Hóa đơn', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPN.SoHoaDon', 70, NULL, NULL, NULL, NULL, NULL, 31)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1345, N'FL0016', N'NgayThanhToan', N'Ngày thanh toán', N'Ngày thanh toán', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPN.NgayThanhToan', 80, NULL, NULL, NULL, NULL, NULL, 31)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1346, N'FM0015', N'TenNguoiGiaoHang', N'Người giao', N'Người giao', 0, 1, 0, NULL, NULL, NULL, NULL, N'nv2.Ho+'' ''+nv2.Ten as TenNguoiGiaoHang', 110, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1347, N'FM0015', N'TenNguoiNhanHang', N'Người nhận', N'Người nhận', 0, 1, 0, NULL, NULL, NULL, NULL, N'nv3.Ho+'' ''+nv3.Ten as TenNguoiNhanHang', 120, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1348, N'FM0015', N'TaiKhoanNhap', N'TK nhập', N'Mã tài khoản nhập', 0, 1, 0, NULL, NULL, NULL, NULL, N'KPC.TaiKhoanNhap', 130, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1349, N'FM0015', N'TaiKhoanXuat', N'TK xuất', N'Mã tài khoản xuất', 0, 1, 0, NULL, NULL, NULL, NULL, N'KPC.TaiKhoanXuat', 140, NULL, NULL, NULL, NULL, NULL, 58)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1350, N'FL0017', N'SoPhieu', N'Số phiếu', N'Số phiếu xuất', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPX.SoPhieu', 10, NULL, NULL, NULL, NULL, NULL, 30)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1351, N'FL0017', N'NoiDung', N'Nội dung', N'Nội dung', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPX.NoiDung', 20, NULL, NULL, NULL, NULL, NULL, 30)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1352, N'FL0017', N'NgayChungTu', N'Ngày CT', N'Ngày chứng từ', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPX.NgayChungTu', 30, NULL, NULL, NULL, NULL, NULL, 30)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1353, N'FL0017', N'TenKhachHang', N'Đơn vị', N'Khách hàng', 1, 1, 0, NULL, NULL, NULL, NULL, N'KH.Ten TenKhachHang', 40, NULL, NULL, NULL, NULL, NULL, 30)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1354, N'FL0017', N'TenKhoNhap', N'Kho hàng', N'Kho hàng', 1, 1, 0, NULL, NULL, NULL, NULL, N'KHO.TenKho TenKhoNhap', 50, NULL, NULL, NULL, NULL, NULL, 30)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1355, N'FL0017', N'TrangThai', N'Trạng thái', N'Trang thái', 1, 1, 0, NULL, NULL, NULL, NULL, N'TT.TrangThai', 90, NULL, NULL, NULL, NULL, NULL, 30)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1356, N'FL0017', N'SoHoaDon', N'Hóa đơn', N'Hóa đơn', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPX.SoHoaDon', 70, NULL, NULL, NULL, NULL, NULL, 30)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1357, N'FL0017', N'NgayThanhToan', N'Ngày thanh toán', N'Ngày thanh toán', 0, 1, 0, NULL, NULL, NULL, NULL, N'KPX.NgayThanhToan', 80, NULL, NULL, NULL, NULL, NULL, 30)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1358, N'FL0005', N'NgayKetThuc', N'Ngày kết thúc', N'Ngày kết thúc', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayKetThuc,106),103) AS NgayKetThuc', 71, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1361, N'FL0016', N'NgayNhap', N'Ngày nhập', N'Ngày nhập', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPN.NgayNhap', 90, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1362, N'FL0017', N'NgayXuat', N'Ngày xuất', N'Ngày xuất', 1, 1, 0, NULL, NULL, NULL, NULL, N'KPX.NgayXuat', 81, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1363, N'FM0016', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayTao,106),103) AS NgayTao', 110, NULL, NULL, NULL, NULL, NULL, 57)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1364, N'FM0016', N'TieuDe', N'Tiêu đề', N'Tiêu đề', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.TieuDe', 110, NULL, NULL, NULL, NULL, NULL, 57)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1365, N'FM0016', N'TenKho', N'Tên kho', N'Tên kho', 1, 1, 0, NULL, NULL, NULL, NULL, N'b.TenKho', 110, NULL, NULL, NULL, NULL, NULL, 57)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1366, N'FM0016', N'Hinh', N'Hình', N'Hình', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.Hinh', 110, NULL, NULL, NULL, NULL, NULL, 57)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1367, N'FM0016', N'TrangThai', N'Trạng thái', N'Trạng thái', 1, 1, 0, NULL, NULL, NULL, NULL, N'd.TrangThai', 110, NULL, NULL, NULL, NULL, NULL, 57)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1368, N'FL0018', N'SeriesNo', N'Số sê-ri', N'Số sê-ri', 1, 1, 0, NULL, NULL, NULL, 100, N'KPBH.SeriesNo', 1, NULL, NULL, NULL, NULL, NULL, 18)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1369, N'FL0018', N'TenKhachHang', N'Khách hàng', N'Khách hàng', 1, 1, 0, NULL, NULL, NULL, 100, N'KPBH.TenKhachHang', 2, NULL, NULL, NULL, NULL, NULL, 18)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1370, N'FL0018', N'DienThoai', N'Điện thoại', N'Điện thoại', 1, 1, 0, NULL, NULL, NULL, 100, N'KPBH.DienThoai', 3, NULL, NULL, NULL, NULL, NULL, 18)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1371, N'FL0018', N'TenThietBi', N'Thiết bị', N'Thiết bị', 1, 1, 0, NULL, NULL, NULL, 100, N'KPBH.TenThietBi', 4, NULL, NULL, NULL, NULL, NULL, 18)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1372, N'FL0018', N'NgayHen', N'Ngày hẹn', N'Ngày hẹn', 1, 1, 0, NULL, NULL, NULL, 100, N'KPBH.NgayHen', 5, NULL, NULL, NULL, NULL, NULL, 18)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1373, N'FL0018', N'TenTrangThaiTiepNhan', N'Trạng thái', N'Trạng thái', 1, 1, 0, NULL, NULL, NULL, 100, N'TT.TrangThai TenTrangThaiTiepNhan', 100, NULL, NULL, NULL, NULL, NULL, 18)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1374, N'FL0021', N'MA', N'Mã KH', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'A.MA', 1, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1375, N'FL0021', N'TEN', N'Tên khách hàng', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'A.TEN', 2, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1376, N'FL0021', N'LOAI', N'Loại', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'case when A.LOAI =1 then ''KH NCC'' else ''Khách Hàng'' end as LOAI', 3, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1377, N'FL0021', N'DIENTHOAI', N'Điện thoại', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'A.DIENTHOAI', 4, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1378, N'FL0021', N'DIDONG', N'Di động', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'A.DIDONG', 5, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1379, N'FL0021', N'EMAIL', N'Email', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'A.EMAIL', 6, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1380, N'FL0021', N'TENTT', N'Tỉnh', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'B.TENTT', 7, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1381, N'FL0021', N'TENQUANHUYEN', N'Huyện', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'C.TENQUANHUYEN', 8, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1382, N'FL0021', N'TENPHUONGXA', N'Trạm', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'D.TENPHUONGXA', 9, NULL, NULL, NULL, NULL, NULL, 11)
GO
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1383, N'FL0021', N'DIACHI', N'Địa chỉ', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'A.DIACHI', 10, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1384, N'FL0021', N'ANYDESK', N'Any Desk', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'ANYDESK', 11, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3368, N'FM0012', N'ThoiGianBaoHanh', N'TGBH', N'TGBH', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.ThoiGianBaoHanh', 140, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3369, N'FL0033', N'MA', N'Mã KH', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'A.MA', 1, NULL, NULL, NULL, NULL, NULL, 20)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3370, N'FL0033', N'TEN', N'Tên khách hàng', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'A.TEN', 2, NULL, NULL, NULL, NULL, NULL, 20)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3371, N'FL0033', N'LOAI', N'Loại', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, N'case when A.LOAI =1 then ''KH NCC'' else ''Khách Hàng'' end as LOAI', 3, NULL, NULL, NULL, NULL, NULL, 20)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3372, N'FL0033', N'DIENTHOAI', N'Điện thoại', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'A.DIENTHOAI', 4, NULL, NULL, NULL, NULL, NULL, 22)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3373, N'FL0033', N'DIDONG', N'Di động', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'A.DIDONG', 5, NULL, NULL, NULL, NULL, NULL, 22)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3374, N'FL0033', N'EMAIL', N'Email', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'A.EMAIL', 6, NULL, NULL, NULL, NULL, NULL, 22)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3375, N'FL0033', N'TENTT', N'Tỉnh', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'B.TENTT', 7, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3376, N'FL0033', N'TENQUANHUYEN', N'Huyện', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'C.TENQUANHUYEN', 8, NULL, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3377, N'FL0033', N'TENPHUONGXA', N'Trạm', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'D.TENPHUONGXA', 9, NULL, NULL, NULL, NULL, NULL, 27)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3378, N'FL0033', N'DIACHI', N'Địa chỉ', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'A.DIACHI', 10, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3379, N'FL0033', N'ANYDESK', N'Any Desk', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'ANYDESK', 11, NULL, NULL, NULL, NULL, NULL, 21)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3380, N'FL0033', N'MaSoThue', N'Mã số thuế', N'Mã số thuế', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.MaSoThue', 12, NULL, NULL, NULL, NULL, NULL, 17)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3381, N'FL0033', N'GhiChu', N'Ghi chú', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'A.GhiChu', 13, NULL, NULL, NULL, NULL, NULL, 15)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3382, N'FL0008', N'NguoiYeuCau', N'Người yêu cầu', N'Người yêu cầu', 1, 1, 0, NULL, NULL, NULL, NULL, N'nyc.Ho +'' ''+ nyc.Ten as NguoiYeuCau', 130, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3383, N'FL0008', N'NgayYeuCau', N'Ngày yêu cầu', N'Người yêu cầu', 0, 1, 0, NULL, NULL, NULL, NULL, N'CASE WHEN a.NgayTao IS NULL THEN CONVERT(VARCHAR(10),CONVERT(DATE, a.NgayBatDau,106),103) ELSE 
			CONVERT(VARCHAR(10),CONVERT(DATE,a.NgayTao,106),103) END AS NgayYeuCau', 140, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4368, N'FL0003', N'DonViSuDung', N'Đơn vị sử dụng', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'dvsd.DonViSuDung', 11, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4369, N'FL0003', N'TenPhanMem', N'Tên phần mềm', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, N'dvsd.TenPhanMem', 11, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4370, N'FD0001', N'MaKhachHang', N'Mã KH', N'Mã KH', 1, 1, 0, NULL, NULL, NULL, NULL, N'MaKhachHang', 1, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4372, N'FD0001', N'TenKhachHang', N'Tên KH', N'Tên KH', 1, 1, 0, NULL, NULL, NULL, NULL, N'TenKhachHang', 2, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4373, N'FD0001', N'NgaySinh', N'Ngày sinh', N'Ngày sinh', 1, 1, 0, NULL, NULL, NULL, NULL, N'NgaySinh', 3, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4374, N'FD0001', N'DienThoai', N'Điện thoại', N'Điện thoại', 1, 1, 0, NULL, NULL, NULL, NULL, N'DienThoai', 4, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4375, N'FD0001', N'TenGioiTinh', N'Giới tính', N'Giới tính', 1, 1, 0, NULL, NULL, NULL, NULL, N'TenGioiTinh', 5, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4376, N'FD0001', N'TenNhom', N'Nhóm KH', N'Nhóm KH', 1, 1, 0, NULL, NULL, NULL, NULL, N'TenNhom', 6, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4377, N'FD0001', N'TenTinh', N'Tỉnh/TP', N'Tỉnh/TP', 1, 1, 0, NULL, NULL, NULL, NULL, N'TenTinh', 7, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4378, N'FD0001', N'TenQuanHuyen', N'Quận/Huyện', N'Quận/Huyện', 0, 1, 0, NULL, NULL, NULL, NULL, N'TenQuanHuyen', 8, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4379, N'FD0001', N'TenPhuongXa', N'Phường/Xã', N'Phường/Xã', 0, 1, 0, NULL, NULL, NULL, NULL, N'TenPhuongXa', 9, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4380, N'FD0001', N'SoNha', N'Số nhà', N'Số nhà', 0, 1, 0, NULL, NULL, NULL, NULL, N'SoNha', 10, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4381, N'FD0001', N'FaceBook', N'FaceBook', N'FaceBook', 0, 1, 0, NULL, NULL, NULL, NULL, N'FaceBook', 11, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4383, N'FD0001', N'Email', N'Email', N'Email', 0, 1, 0, NULL, NULL, NULL, NULL, N'Email', 12, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4384, N'FD0001', N'NgheNghiep', N'Nghề nghiệp', N'Nghề nghiệp', 0, 1, 0, NULL, NULL, NULL, NULL, N'NgheNghiep', 13, N'1', NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4387, N'FD0001', N'CoQuan', N'Cơ quan', N'Cơ quan', 0, 1, 0, NULL, NULL, NULL, NULL, N'CoQuan', 14, N'1', NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4389, N'FD0001', N'MaSoThue', N'Mã số thuế', N'Mã số thuế', 0, 1, 0, NULL, NULL, NULL, NULL, N'MaSoThue', 15, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4390, N'FD0001', N'EmailCoQuan', N'Email cơ quan', N'Email cơ quan', 0, 1, 0, NULL, NULL, NULL, NULL, N'EmailCoQuan', 16, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4391, N'FD0001', N'Fax', N'Fax cơ quan', N'Fax cơ quan', 0, 1, 0, NULL, NULL, NULL, NULL, N'Fax', 17, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4393, N'FD0001', N'DiaChiCoQuan', N'Địa chỉ cơ quan', N'Địa chỉ cơ quan', 0, 1, 0, NULL, NULL, NULL, NULL, N'DiaChiCoQuan', 18, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4395, N'FD0001', N'TheoDoi', N'Theo dõi', N'Theo dõi', 0, 1, 0, NULL, NULL, NULL, NULL, N'TheoDoi', 19, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4396, N'FD0001', N'Khac', N'Khác', N'Khác', 0, 1, 0, NULL, NULL, NULL, NULL, N'Khac', 20, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4397, N'FD0001', N'TenNguoiTao', N'Người tạo', N'Người tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'NguoiTao', 21, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4398, N'FD0001', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'NgayTao', 22, NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4399, N'FL0022', N'SoHopDong', N'Số hợp đồng', NULL, 1, 1, 0, NULL, NULL, NULL, 100, N'HD.SoHopDong', 10, NULL, NULL, NULL, NULL, NULL, 36)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4400, N'FL0022', N'TenHopDong', N'Tên hợp đồng', NULL, 1, 1, 0, NULL, NULL, NULL, 100, N'HD.TenHopDong', 20, NULL, NULL, NULL, NULL, NULL, 36)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4401, N'FL0022', N'NgayHopDong', N'Ngày hợp đồng', NULL, 1, 1, 0, NULL, NULL, NULL, 100, N'HD.NgayHopDong', 30, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4402, N'FL0022', N'NgayThanhLy', N'Ngày thanh lý', NULL, 1, 1, 0, NULL, NULL, NULL, 100, N'HD.NgayThanhLy', 1000, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4403, N'FL0022', N'SoTien', N'Số tiền', NULL, 1, 1, 0, NULL, NULL, NULL, 100, N'HD.SoTien', 40, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4404, N'FL0022', N'SoHoaDon', N'Số hóa đơn', NULL, 0, 1, 0, NULL, NULL, NULL, 100, N'HD.SoHoaDon', 1000, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4405, N'FL0022', N'NgayHoaDon', N'Ngày hóa đơn', NULL, 1, 1, 0, NULL, NULL, NULL, 100, N'HD.NgayHoaDon', 1000, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4406, N'FL0022', N'ThanhToan', N'Thanh toán', NULL, 1, 1, 0, NULL, NULL, NULL, 100, N'HD.ThanhToan', 1000, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4407, N'FL0022', N'TyLe', N'Tỷ lệ', NULL, 1, 1, 0, NULL, NULL, NULL, 100, N'HD.TyLe', 50, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4408, N'FL0022', N'Chi', N'Chi', NULL, 1, 1, 0, NULL, NULL, NULL, 100, N'HD.Chi', 1000, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4409, N'FL0022', N'TenDuLieu', N'Dữ liệu', NULL, 1, 1, 0, NULL, NULL, NULL, 100, N'DL.TenDuLieu', 1000, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4410, N'FL0022', N'TenNhanVien', N'Tên NVKD', NULL, 0, 1, 0, NULL, NULL, NULL, 100, N'CONCAT(NV.Ho,'' '',NV.Ten)', 1000, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4411, N'FL0022', N'NgayTao', N'Ngày tạo', NULL, 0, 1, 0, NULL, NULL, NULL, 100, N'HD.NgayTao', 1000, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4412, N'FL0022', N'TenNguoiTao', N'Người tạo', NULL, 0, 1, 0, NULL, NULL, NULL, 100, N'CONCAT(NV_NT.Ho,'' '',NV_NT.Ten)', 1000, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4413, N'FL0022', N'TenKhachHang', N'Tên khách hàng', NULL, 1, 1, 0, NULL, NULL, NULL, 100, N'KH.TenKhachHang', 40, NULL, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4415, N'FD0002', N'SoPhieu', N'Số phiếu', NULL, 1, 1, 0, NULL, NULL, NULL, 20, NULL, 1, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4416, N'FD0002', N'TenDonHang', N'Tên đơn hàng', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4417, N'FD0002', N'NgayLap', N'Ngày lập', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4418, N'FD0002', N'TenKhachHang', N'Tên khách hàng', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4419, N'FD0002', N'SoHopDong', N'Số hợp đồng', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4420, N'FD0002', N'NgayDuyet', N'Ngày duyệt', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4421, N'FD0002', N'Duyet', N'Duyệt', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4422, N'FD0002', N'TenTrangThai', N'Trạng thái', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 18, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4424, N'FD0002', N'LyDo', N'Lý do', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4425, N'FD0002', N'TenHopDong', N'Tên hợp đồng', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4426, N'FD0002', N'MaNhanVienKD', N'Mã NVKD', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 21)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4427, N'FD0002', N'TenNhanVienKD', N'Tên NVKD', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4428, N'FD0002', N'BoPhanNhan', N'Bộ phận nhận', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4429, N'FD0002', N'NguoiNhan', N'Người nhận', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4430, N'FD0002', N'GhiChu', N'Ghi chú', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 14, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4431, N'FD0002', N'TenNguoiTao', N'Người tạo', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 15, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4432, N'FD0002', N'NgayTao', N'Ngày tạo', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4433, N'FL0005', N'NgaySinh', N'Ngày sinh', N'Ngày sinh', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,khp.NgaySinh,106),103)  as NgaySinh', 90, NULL, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4434, N'FL0003', N'NgaySinh', N'Ngày sinh', N'Ngày sinh', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,khp.NgaySinh,106),103)  as NgaySinh', 12, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4435, N'FL0003', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,A.NgayTao,106),103)  as NgayTao', 12, NULL, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4436, N'FD0003', N'SoPhieu', N'Số phiếu', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4437, N'FD0003', N'TenBaoGia', N'Tên báo giá', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4438, N'FD0003', N'NgayBaoGia', N'Ngày báo giá', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4439, N'FD0003', N'TenKhachHang', N'Tên khách hàng', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4441, N'FD0003', N'DienThoaiKH', N'Điện thoại', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4442, N'FD0003', N'MaKhachHang', N'Mã KH', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4443, N'FD0003', N'LyDo', N'Lý do', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4444, N'FD0003', N'TenDaNhan', N'Đã nhận', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4445, N'FD0003', N'MaNhanVienKD', N'Mã NVKD', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4446, N'FD0003', N'TenNhanVienKD', N'Người báo giá', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4447, N'FD0003', N'NguoiNhan', N'Người nhận', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4448, N'FD0003', N'DienThoai', N'SĐT người nhận', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4449, N'FD0003', N'GhiChu', N'Ghi chú', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4450, N'FD0003', N'TenNguoiTao', N'Người tạo', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 14, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4451, N'FD0003', N'NgayTao', N'Ngày tạo', NULL, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 15, NULL, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4452, N'FD0003', N'TenTrangThai', N'Trạng thái', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, 7)
SET IDENTITY_INSERT [dbo].[CauHinhFormCot] OFF
SET IDENTITY_INSERT [dbo].[ChucNang] ON 

INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2033, N'CN0001', N'Nhân viên', N'quản lý nhân viên', N'V,N,D,M,A,View All', NULL, N'/QLNDMAIN/NhanVien/', 1, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2034, N'CN0016', N'Phòng ban', N'Phòng ban', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/phongban/list', 2, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2035, N'CN0022', N'Chức vụ', N'Chức vụ', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/chucvu/list', 3, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2036, N'CN0008', N'Loại ngày phép', N'Loại ngày phép', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/loaingayphep/list', 4, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2037, N'CN0026', N'Ngày nghỉ', N'Ngày nghỉ', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/NgayNghi/list', 5, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2038, N'CN0007', N'Phiếu công tác', N'Quản lý phiếu công tác', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/phieucongtac/list', 6, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2039, N'CN0013', N'Tạm ứng lương', N'Tạm ứng', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/tamung/list', 7, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2040, N'CN0006', N'Phiếu nghỉ phép', N'Quản lý nghỉ phép', N'V,N,D,M,A,View All', NULL, N'/QLNDMAIN/NghỉPhep/list/', 8, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2041, N'CN0010', N'Phiếu tăng ca', N'Tăng ca', N'V,N,D,M,A,View All', NULL, NULL, 9, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2042, N'CN0027', N'Phê duyệt phiếu', N'Phê duyệt phiếu', N'V,N,D,M,A,View All', NULL, NULL, 10, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2043, N'CN0025', N'Tình hình chấm công', N'Chấm công', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/ChamCong/list', 11, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2044, N'CN0023', N'Improt chấm công', N'Import Excel', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/importexcel/list', 12, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2045, N'CN0014', N'Khen thưởng toàn công ty', N'Khen thưởng', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/khenthuong/list', 13, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2046, N'CN0015', N'Khen thưởng - Cộng tiền', N'Khen thưởng cá nhân', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/khenthuongcanhan/list', 14, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2047, N'CN0017', N'Kỷ luật - Trừ tiền', N'Kỷ luật', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/KyLuat/list', 15, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2048, N'CN0009', N'Khách hàng - Nhà cung cấp', N'khách hàng', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/khachhang/list', 16, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2049, N'CN0011', N'Phản hồi - Issue', N'Issue', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/issue/list', 17, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2050, N'CN0020', N'Dự án', N'Dự án', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/duan/list', 18, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2051, N'CN0021', N'Công việc', N'Công việc', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/congviec/list', 19, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2052, N'CN0012', N'Bảng lương', N'Bảng lương', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/bangluong/list', 20, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2053, N'CN0019', N'Bảng lương cá nhân', N'bảng lương cá nhân', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/bangluongcanhan/list', 21, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2054, N'CN0024', N'Danh sách người dùng', N'Người dùng', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/nguoidungl/list', 22, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2055, N'CN0005', N'Danh sách vai trò', N'Quan Ly Vai Tro', N'V,N,D,M,A,View All', NULL, N'/QLNDMAIN/Vaitro/list/', 23, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2056, N'CN0018', N'Phân quyền vai trò', N'Phân quyền tác vụ', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/PhanQuyen/list', 24, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2062, N'KHO0002', N'Hãng sản xuất', N'Hãng sản xuất', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoHangSanXuat/list', 145, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2063, N'KHO0003', N'Kho hàng', N'Kho hàng', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoKhoHang/list', 110, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2064, N'KHO0001', N'Loại hàng hóa', N'Loại hàng hóa', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoLoaiHangHoa/list', 130, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2065, N'KHO0004', N'Phiếu nhập', N'Danh sách phiếu nhập kho', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoPhieuNhapKho/list', 170, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2066, N'KHO0005', N'Hàng hóa', N'Hàng hóa', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoHangHoa/list', 120, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2067, N'KHO0006', N'Tài khoản', N'Tài khoản', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoTaiKhoan/list', 160, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2068, N'KHO0007', N'Phiếu thu', N'Phiếu thu', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/PhieuThu/list', 200, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2069, N'KHO0008', N'Phiếu chi', N'Phiếu chi', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/PhieuChi/list', 210, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2070, N'KHO0009', N'Số dư tồn kho', N'Số dư tồn kho', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoSoDuTonKho/list', 220, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2071, N'KHO0010', N'Phiếu chuyển', N'Phiếu chuyển kho', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/PhieuChuyenKho/list', 190, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2072, N'KHO0011', N'Nhóm hàng hóa', N'Phiếu chuyển kho', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoNhomHanHoa/list', 140, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2073, N'KHO0012', N'Nước sản xuất', N'Nước sản xuất', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoNuocSanXuat/list', 150, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2074, N'KHO0013', N'Phiếu xuất', N'Phiếu xuất kho', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoPhieuXuat/list', 180, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2075, N'KHO0014', N'Theo dõi hàng tồn kho', N'Thẻ kho', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoTheKho/list', 230, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2076, N'KHO0015', N'Tổng hợp xuất nhập tồn', N'Tổng hợp xuất nhập tồn', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoTongHopXuatNhapTon/list', 240, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2077, N'KHO0016', N'Công nợ NCC', N'Công nợ NCC', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoCongNoNCC/list', 250, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2078, N'KHO0017', N'Công nợ khách hàng', N'Công nợ khách hàng', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoCongNoKhachHang/list', 260, 0, NULL, CAST(N'2017-07-10 10:28:34.470' AS DateTime), CAST(N'2017-07-10 10:28:34.470' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2079, N'KHO0018', N'Duyệt phiếu lưu sổ cái', N'Duyệt phiếu lưu sổ cái', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoDuyetPhieu/list', 215, 0, NULL, CAST(N'2017-07-11 10:15:12.860' AS DateTime), CAST(N'2017-07-11 10:15:12.860' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2080, N'CN0028', N'Chi nhánh', N'Chi nhánh', N'V,N,D,M,A,L,View All', NULL, N'/QLDNMAIN/chinhanh/list', 2, 0, NULL, CAST(N'2017-07-18 17:43:13.873' AS DateTime), CAST(N'2017-07-18 17:43:13.873' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2081, N'KHO0019', N'Phiếu nhận bảo hành', N'Phiếu nhận bảo hành', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/KhoPhieuNhanBaoHanh/list', 200, 0, NULL, CAST(N'2017-07-22 08:19:53.120' AS DateTime), CAST(N'2017-07-22 08:19:53.120' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2082, N'KHO0020', N'Improt đầu kỳ', N'Import Excel', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/khoimportexceldauky/list', 200, 0, NULL, CAST(N'2017-07-22 08:24:29.270' AS DateTime), CAST(N'2017-07-22 08:24:29.270' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2083, N'CN0029', N'Phép năm', N'Phép năm', N'V,N,D,M,A,L,View All', NULL, N'/QLDNMAIN/PhepNam/list', 11, 0, NULL, CAST(N'2017-07-22 09:04:50.740' AS DateTime), CAST(N'2017-07-22 09:04:50.740' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2084, N'CN0030', N'Báo cáo công việc', N'Báo cáo công việc', N'V,N,D,M,A,L,View All', NULL, N'/QLDNMAIN/PhepNam/list', 11, 0, NULL, CAST(N'2017-07-22 09:04:50.740' AS DateTime), CAST(N'2017-07-22 09:04:50.740' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2085, N'KHO0021', N'khách hàng', N'khách hàng', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/khokhachhang/list', 115, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3084, N'KHO0022', N'Khai báo tồn đầu', N'Khai báo tồn đầu', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/khotonkho/list', 215, 0, NULL, CAST(N'2017-09-06 15:22:32.343' AS DateTime), CAST(N'2017-09-06 15:22:32.343' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3085, N'KHO0023', N'Kiểm kê', N'Kiểm kê', N'V,N,D,M,A,L,View All', NULL, N'/QLDNKHO/khokiemke/list', 265, 0, NULL, CAST(N'2017-09-06 15:24:01.383' AS DateTime), CAST(N'2017-09-06 15:24:01.383' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3089, N'CN0031', N'Ngân hàng câu hỏi', N'Ngân hàng câu hỏi', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/nganhangcauhoi/list', 16, 0, NULL, CAST(N'2017-11-10 08:47:37.257' AS DateTime), CAST(N'2017-11-10 08:47:37.257' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3090, N'CN0032', N'Phần mềm', N'Phần mềm', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/phanmem/list', 16, 0, NULL, CAST(N'2017-11-10 08:49:26.997' AS DateTime), CAST(N'2017-11-10 08:49:26.997' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3091, N'CN0033', N'Đơn vị sử dụng', N'Đơn vị sử dụng', N'V,N,D,M,A,View All', NULL, N'/QLDNMAIN/donvisudung/list', 16, 0, NULL, CAST(N'2017-11-10 08:50:34.223' AS DateTime), CAST(N'2017-11-10 08:50:34.223' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3092, N'KD0001', N'Nhóm khách hàng', N'Nhóm khách hàng', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/nhomchucnang/list', 1, 0, NULL, CAST(N'2017-11-13 08:59:51.290' AS DateTime), CAST(N'2017-11-13 08:59:51.290' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3093, N'KD0002', N'Khách hàng', N'Khách hàng', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/khachhang/list', 2, 0, NULL, CAST(N'2017-11-13 10:51:31.930' AS DateTime), CAST(N'2017-11-13 10:51:31.930' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3094, N'KD0003', N'Địa bàn', N'Địa bàn', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/diaban/list', 3, 0, NULL, CAST(N'2017-11-13 13:58:34.263' AS DateTime), CAST(N'2017-11-13 13:58:34.263' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3095, N'KD0004', N'Thuật ngữ', N'Thuật ngữ', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/ThuatNgu/list', 4, 0, NULL, CAST(N'2017-11-13 13:58:34.263' AS DateTime), CAST(N'2017-11-13 13:58:34.263' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3096, N'KD0005', N'Nhóm kinh doanh', N'Nhóm kinh doanh', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/NhomKinhDoanh/list', 5, 0, NULL, CAST(N'2017-11-13 13:58:34.263' AS DateTime), CAST(N'2017-11-13 13:58:34.263' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3097, N'KD0006', N'Loại hợp đồng', N'Loại hợp đồng', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/LoaiHopDong/list', 6, 0, NULL, CAST(N'2017-11-13 13:58:34.263' AS DateTime), CAST(N'2017-11-13 13:58:34.263' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3098, N'KD0007', N'Dữ liệu', N'Dữ liệu', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/dulieu/list', 7, 0, NULL, CAST(N'2017-11-13 13:58:34.263' AS DateTime), CAST(N'2017-11-13 13:58:34.263' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3099, N'KD0008', N'Nhân viên', N'Nhân viên', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/nhanvien/list', 8, 0, NULL, CAST(N'2017-11-13 13:58:34.263' AS DateTime), CAST(N'2017-11-13 13:58:34.263' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3100, N'KD0009', N'Kế hoạch kinh doanh', N'Kế hoạch kinh doanh', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/kehoach/list', 9, 0, NULL, CAST(N'2017-11-16 09:34:42.307' AS DateTime), CAST(N'2017-11-16 09:34:42.307' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3101, N'KD0010', N'Hợp đồng', N'Hợp đồng', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/hopdong/list', 10, 0, NULL, CAST(N'2017-11-16 09:34:42.307' AS DateTime), CAST(N'2017-11-16 09:34:42.307' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3102, N'KD0011', N'Đơn hàng', N'Đơn hàng', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/donhang/list', 11, 0, NULL, CAST(N'2017-11-20 13:47:48.163' AS DateTime), CAST(N'2017-11-20 13:47:48.163' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3103, N'KD0012', N'Báo giá', N'Báo giá', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/baogia/list', 12, 0, NULL, CAST(N'2017-11-23 08:23:47.417' AS DateTime), CAST(N'2017-11-23 08:23:47.417' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3104, N'KD0013', N'ChiTieu', N'Chỉ tiêu kinh doanh', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/kinhdoanh/list', 13, 0, NULL, CAST(N'2017-11-27 08:32:01.533' AS DateTime), CAST(N'2017-11-27 08:32:01.533' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3105, N'KD0014', N'FileHopDong', N'FileHopDong', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/FileHopDong/list', 14, 0, NULL, CAST(N'2017-11-27 08:32:01.533' AS DateTime), CAST(N'2017-11-27 08:32:01.533' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [ThuocNhom], [DuongDan], [ThuTu], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3106, N'KD0015', N'Báo cáo doanh thu', N'Báo cáo doanh thu', N'V,N,D,M,A,View All', NULL, N'/QLKDMAIN/#!/BaoCaoDoanhThu/list', 15, 0, NULL, CAST(N'2017-11-30 10:01:36.610' AS DateTime), CAST(N'2017-11-30 10:01:36.610' AS DateTime), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[ChucNang] OFF
INSERT [dbo].[Client] ([ClientId], [Base64Secret], [Name], [ApplicationType], [ActiveYN], [RefreshTokenLifeTime], [AllowedOrigin], [Description], [CtrVersion]) VALUES (N'33ecac27c905425eb81595dc0d54684d', N't9mT2uuQvXREm5KW42W_6mZVCUwjWBjWZyNtAqoDlJ4', N'web api', 1, 1, 60, N'*', N'abc', 1)
SET IDENTITY_INSERT [dbo].[NguoiDung] ON 

INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (7, N'ND0002', N'phuhoi@ehis.vn', 1, N'72ab994fa2eb426c051ef59cad617750bfe06d7cf6311285ff79c19c32afd236', N'123456', NULL, 0, 0, NULL, 0, 0, N'phuhoi', 1, N'Van Phu Hoi', 68, CAST(N'2017-04-18 08:28:29.033' AS DateTime), CAST(N'2017-04-18 08:28:29.033' AS DateTime), N'hoi', N'hoi', 11)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (9, N'ND0003', N'thanhbinh@ehis.vn', 1, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, NULL, 0, 0, N'binhnt', 1, N'Nguyễn Thanh Bình', 70, CAST(N'2017-05-04 10:28:53.830' AS DateTime), CAST(N'2017-05-04 10:28:53.830' AS DateTime), NULL, NULL, 4)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (10, N'ND0004', N'anhkiet@ehis.vn', 1, N'42c81b6158d8c006291793ab73147ce377cc976a616d3611a0ad5fd115671ca0', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:20:01.483' AS DateTime), 0, 0, N'anhkiet', 26, N'Nguyễn Hoàng Anh Kiệt', 75, CAST(N'2017-05-11 11:20:01.483' AS DateTime), CAST(N'2017-05-11 11:20:01.483' AS DateTime), N'Hung', N'Hung', 3)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (11, N'ND0005', N'dinhkhai@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.030' AS DateTime), 0, 0, N'dinhkhai', 20, N'Phạm Đình Khải', 52, CAST(N'2017-05-11 11:41:15.030' AS DateTime), CAST(N'2017-05-11 11:41:15.030' AS DateTime), N'Hung', N'Hung', 4)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (12, N'ND0006', N'congthuan@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.037' AS DateTime), 0, 0, N'congthuan', 4, N'congthuan', 0, CAST(N'2017-05-11 11:41:15.037' AS DateTime), CAST(N'2017-05-11 11:41:15.037' AS DateTime), N'Hung', N'Hung', 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (13, N'ND0007', N'congtrung@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.040' AS DateTime), 0, 0, N'congtrung', 21, N'congtrung', 59, CAST(N'2017-05-11 11:41:15.040' AS DateTime), CAST(N'2017-05-11 11:41:15.040' AS DateTime), N'Hung', N'Hung', 2)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (14, N'ND0008', N'duykhanh@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.043' AS DateTime), 0, 0, N'duykhanh', 28, N'duykhanh', 49, CAST(N'2017-05-11 11:41:15.043' AS DateTime), CAST(N'2017-05-11 11:41:15.043' AS DateTime), N'Hung', N'Hung', 5)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (15, N'ND0009', N'hoaivinh@ehis.vn', 0, N'56606b89f9d93f0cc67b5938ea92282c7e96707e2a11c2217226bc7a1df0664d', N'123456', N'P@ssla13', 0, 0, CAST(N'2017-05-11 11:41:15.053' AS DateTime), 0, 0, N'hoaivinh', 27, N'Trương Hoài Vinh', 55, CAST(N'2017-05-11 11:41:15.053' AS DateTime), CAST(N'2017-05-11 11:41:15.053' AS DateTime), N'Hung', N'Hung', 11)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (16, N'ND0010', N'hoangyen@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.057' AS DateTime), 0, 0, N'hoangyen', 32, N'hoangyen', 65, CAST(N'2017-05-11 11:41:15.057' AS DateTime), CAST(N'2017-05-11 11:41:15.057' AS DateTime), N'Hung', N'Hung', 4)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (17, N'ND0011', N'hongquan@ehis.vn', 0, N'9cddcf181983a456a2c3282e5b44835fea35f94562b18056c5d3cae53eb10115', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.060' AS DateTime), 0, 0, N'hongquan', 4, N'hongquan', 63, CAST(N'2017-05-11 11:41:15.060' AS DateTime), CAST(N'2017-05-11 11:41:15.060' AS DateTime), N'Hung', N'Hung', 3)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (18, N'ND0012', N'minhkieu@ehis.vn', 1, N'5da92533d007169a40e30c7263a42d09c7ea92ce873d4fcb51fb5b8520fdeddb', N'123456', N'0986674355', 0, 0, CAST(N'2017-05-11 11:41:15.063' AS DateTime), 0, 0, N'minhkieu', 31, N'minhkieu', 48, CAST(N'2017-05-11 11:41:15.063' AS DateTime), CAST(N'2017-05-11 11:41:15.063' AS DateTime), N'Hung', N'Hung', 6)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (19, N'ND0013', N'minhngoc@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.070' AS DateTime), 0, 0, N'minhngoc', 3, N'minhngoc', 51, CAST(N'2017-05-11 11:41:15.070' AS DateTime), CAST(N'2017-05-11 11:41:15.070' AS DateTime), N'Hung', N'Hung', 3)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (20, N'ND0014', N'minhquan@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.073' AS DateTime), 0, 0, N'minhquan', 4, N'minhquan', 0, CAST(N'2017-05-11 11:41:15.073' AS DateTime), CAST(N'2017-05-11 11:41:15.073' AS DateTime), N'Hung', N'Hung', 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (21, N'ND0015', N'mytien@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.077' AS DateTime), 0, 0, N'mytien', 4, N'Mỹ Tiên', 0, CAST(N'2017-05-11 11:41:15.077' AS DateTime), CAST(N'2017-05-11 11:41:15.077' AS DateTime), N'Hung', N'Hung', 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (22, N'ND0016', N'ngoctan@ehis.vn', 0, N'89aa1e580023722db67646e8149eb246c748e180e34a1cf679ab0b41a416d904', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.080' AS DateTime), 0, 0, N'ngoctan', 1, N'ngoctan', 53, CAST(N'2017-05-11 11:41:15.080' AS DateTime), CAST(N'2017-05-11 11:41:15.080' AS DateTime), N'Hung', N'Hung', 4)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (23, N'ND0017', N'phuongthanh@ehis.vn', 0, N'81b4406c495a94f839e950ddd982bcadb2e57e5fa1ef6f7dad025f984691e33b', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.083' AS DateTime), 0, 0, N'phuongthanh', 4, N'phuongthanh', 67, CAST(N'2017-05-11 11:41:15.083' AS DateTime), CAST(N'2017-05-11 11:41:15.083' AS DateTime), N'Hung', N'Hung', 3)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (24, N'ND0018', N'quocthinh@ehis.vn', 0, N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'123456', N'01699452452', 0, 0, CAST(N'2017-05-11 11:41:15.090' AS DateTime), 0, 0, N'quocthinh', 4, N'quocthinh', 56, CAST(N'2017-05-11 11:41:15.090' AS DateTime), CAST(N'2017-05-11 11:41:15.090' AS DateTime), N'Hung', N'Hung', 5)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (25, N'ND0020', N'thehung@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.093' AS DateTime), 0, 0, N'thehung', 4, N'thehung', 0, CAST(N'2017-05-11 11:41:15.093' AS DateTime), CAST(N'2017-05-11 11:41:15.093' AS DateTime), N'Hung', N'Hung', 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (26, N'ND0020', N'thynguyen@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.097' AS DateTime), 0, 0, N'thynguyen', 30, N'thynguyen', 62, CAST(N'2017-05-11 11:41:15.097' AS DateTime), CAST(N'2017-05-11 11:41:15.097' AS DateTime), N'Hung', N'Hung', 4)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (27, N'ND0021', N'trongnghia@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.100' AS DateTime), 0, 0, N'trongnghia', 4, N'trongnghia', 54, CAST(N'2017-05-11 11:41:15.100' AS DateTime), CAST(N'2017-05-11 11:41:15.100' AS DateTime), N'Hung', N'Hung', 2)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (28, N'ND0022', N'trungtin@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.103' AS DateTime), 0, 0, N'trungtin', 20, N'Nguyễn Thành Trung Tín', 72, CAST(N'2017-05-11 11:41:15.103' AS DateTime), CAST(N'2017-05-11 11:41:15.103' AS DateTime), N'Hung', N'Hung', 4)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (29, N'ND0023', N'vanthai@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.110' AS DateTime), 0, 0, N'vanthai', 4, N'vanthai', 0, CAST(N'2017-05-11 11:41:15.110' AS DateTime), CAST(N'2017-05-11 11:41:15.110' AS DateTime), N'Hung', N'Hung', 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (30, N'ND0024', N'vietanh@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456', NULL, 0, 0, CAST(N'2017-05-11 11:41:15.113' AS DateTime), 0, 0, N'vietanh', 20, N'Trần Việt Anh', 58, CAST(N'2017-05-11 11:41:15.113' AS DateTime), CAST(N'2017-05-11 11:41:15.113' AS DateTime), N'Hung', N'Hung', 3)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (31, N'ND0025', N'quocviet@ehis.vn', 0, N'e14f4de0b4649ae3e58d703d63c09a90cdbb71c41a367412578346bebe5c9a7e', NULL, N'01648555668', 0, 0, NULL, 0, 0, N'quocviet@ehis.vn', 5, N'Bùi Quốc Việt', 50, CAST(N'2017-06-10 10:42:45.793' AS DateTime), NULL, N'75', NULL, 5)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (32, N'ND0026', N'truongthi@ehis.vn', 0, N'553dc60bbd013bdde7e2a29854d527787f5b52d13a9c2fa69c85908ae918a7fb', NULL, N'0945942277', 0, 0, NULL, 0, 0, N'truongthi', 29, N'Trường Thi', 66, CAST(N'2017-06-12 08:48:53.243' AS DateTime), CAST(N'2017-06-12 08:48:53.243' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (33, N'test', N'hoivp@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, 0, 0, NULL, 0, 0, N'hoivp@ehis.vn', 1, N'hoivp', 0, CAST(N'2017-06-20 14:49:17.227' AS DateTime), NULL, N'68', NULL, 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (34, N'chaucuong', N'chicuong@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, N'0939976397', 0, 0, NULL, 0, 0, N'chicuong@ehis.vn', 3, N'Châu Chí Cường', 57, CAST(N'2017-06-24 08:40:00.093' AS DateTime), NULL, N'68', NULL, 4)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (35, N'ChiBinh', N'chibinh@ehis.vn', 0, N'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', NULL, NULL, 0, 0, NULL, 0, 0, N'chibinh@ehis.vn', 3, N'Chí Bình', NULL, CAST(N'2017-06-27 16:02:39.583' AS DateTime), NULL, N'68', NULL, 3)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1035, N'ND0027', N'phibang@ehis.vn', 0, N'c7133084ba4f182617510bdddc45995d6bf3b13399d99308bf494246bb460c48', NULL, N'Tamquocchien@bangle', 0, 0, NULL, 0, 0, N'phibang@ehis.vn', 4, N'Lê Hữu Phi Bằng', 77, CAST(N'2017-07-13 15:28:01.987' AS DateTime), NULL, N'68', NULL, 4)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1036, N'ND0028', N'tiendat@ehis.vn', 0, N'89aa1e580023722db67646e8149eb246c748e180e34a1cf679ab0b41a416d904', NULL, N'01674559848', 0, 0, NULL, 0, 0, N'tiendat@ehis.vn', 1, N'tiendat', 1083, CAST(N'2017-07-13 15:45:53.613' AS DateTime), NULL, N'68', NULL, 3)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1037, N'DieuPhuong', N'dieuphuong@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, 0, 0, NULL, 0, 0, N'dieuphuong@ehis.vn', 3, N'Vũ Thị DIệu Phương', 80, CAST(N'2017-07-15 10:37:14.653' AS DateTime), NULL, N'75', NULL, 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1038, N'VanHai', N'vanhai@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, 0, 0, NULL, 0, 0, N'vanhai@ehis.vn', 4, N'Hoàng Văn Hải', 81, CAST(N'2017-07-15 10:38:06.633' AS DateTime), NULL, N'75', NULL, 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2048, N'32132', N'31321', 0, N'2f7d1df3a1015f3e4d1dbe185e0ef4ff2530c5ce36199bfea500dc80b05aaab9', NULL, N'21321', 0, 0, NULL, 0, 0, N'31321', 1, N'321321', 6, CAST(N'2017-11-09 14:52:08.080' AS DateTime), CAST(N'2017-11-09 14:52:08.080' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2049, N'213', N'231', 0, N'3b8ffbc7f0dd515cb59e79e161632d4d17eaa9e94ebb16d488e953a3e705d5c5', NULL, N'321321', 0, 0, NULL, 0, 0, N'231', 1, N'21313', 6, CAST(N'2017-11-09 14:54:30.837' AS DateTime), CAST(N'2017-11-09 14:54:30.837' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2050, N'321', N'31231', 0, N'3b8ffbc7f0dd515cb59e79e161632d4d17eaa9e94ebb16d488e953a3e705d5c5', NULL, N'321', 0, 0, NULL, 0, 0, N'31231', 1, N'3213213', 6, CAST(N'2017-11-09 14:55:52.760' AS DateTime), CAST(N'2017-11-09 14:55:52.760' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2051, N'321', N'31231', 0, N'3b8ffbc7f0dd515cb59e79e161632d4d17eaa9e94ebb16d488e953a3e705d5c5', NULL, N'321', 0, 0, NULL, 0, 0, N'31231', 1, N'3213213', 6, CAST(N'2017-11-09 14:55:54.970' AS DateTime), CAST(N'2017-11-09 14:55:54.970' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2052, N'2132', N'32131', 0, N'fe6340be87fd5e43b7f0cac5741e76205dd69a68b2024fda16c696848a720f7a', NULL, N'21321', 0, 0, NULL, 0, 0, N'32131', 1, N'31321', 6, CAST(N'2017-11-09 14:57:07.357' AS DateTime), CAST(N'2017-11-09 14:57:07.357' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2053, N'321231', N'21321321', 0, N'701fd6f18a46f7c72397c91b9cb1a6353744b9cca3aa329af5e5e1124b6b8c5a', NULL, N'3213', 0, 0, NULL, 0, 0, N'21321321', 1, N'3213213213', 6, CAST(N'2017-11-09 14:58:11.890' AS DateTime), CAST(N'2017-11-09 14:58:11.890' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2054, N'32132', N'213213', 0, N'966ec83c308f36165d28b88a33f14af36f2ec44d6373bae55d2796644ea35e9d', NULL, N'21321', 0, 0, NULL, 0, 0, N'213213', 1, N'131313', 6, CAST(N'2017-11-09 14:59:06.187' AS DateTime), CAST(N'2017-11-09 14:59:06.187' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2055, N'3213213', N'1321321', 0, N'57c1676306aff0bc130ab3137ede570ce6b8331e66fb502c47b56b08c72fdb45', NULL, N'3213213', 0, 0, NULL, 0, 0, N'1321321', 1, N'13213213', 6, CAST(N'2017-11-09 15:00:30.900' AS DateTime), CAST(N'2017-11-09 15:00:30.900' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2056, N'23132', N'213213', 0, N'58cd21023f8c6de8c1b8400594f75e68d6a329451b1b0f34a6c846fc9c1927f3', NULL, N'21321321', 0, 0, NULL, 0, 0, N'213213', 1, N'132132132', 6, CAST(N'2017-11-09 15:01:08.177' AS DateTime), CAST(N'2017-11-09 15:01:08.177' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2057, N'323213', N'213213', 0, N'8cc7a4de25920211fb328c8b3e3f7ccadeff4a2073ba8a093ebf3a06ab828774', NULL, N'12321321', 0, 0, NULL, 0, 0, N'213213', 5, N'3132133', 84, CAST(N'2017-11-09 15:01:17.697' AS DateTime), CAST(N'2017-11-09 15:01:17.697' AS DateTime), NULL, NULL, 6)
SET IDENTITY_INSERT [dbo].[NguoiDung] OFF
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2033, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2034, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2035, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2036, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2037, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2038, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2039, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2040, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2041, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2042, N'V,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2043, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2044, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2045, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2046, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2047, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2048, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2049, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2050, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2051, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2052, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2053, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2054, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2055, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2056, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2062, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2063, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2064, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2065, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2066, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2067, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2068, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2069, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2070, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2071, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2072, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2073, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2074, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2075, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2076, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2077, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2078, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2079, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2080, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2081, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2082, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2083, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2084, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2085, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3084, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3085, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3089, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3090, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3091, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3092, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3093, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3094, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3095, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3096, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3097, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3098, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3099, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3100, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3101, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3102, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3103, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3104, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3105, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3106, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2, 2033, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2, 2034, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2033, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2034, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2035, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2036, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2037, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2038, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2039, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2040, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2041, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2043, N'V,N,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2045, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2046, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2047, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2048, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2049, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2050, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2051, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2053, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2062, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2063, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2064, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2065, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2066, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2067, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2068, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2069, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2070, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2071, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2072, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2073, N'V,N,D,M,View All')
GO
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2074, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2075, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2076, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2077, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2078, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (3, 2079, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2033, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2034, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2035, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2036, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2037, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2038, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2039, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2040, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2041, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2043, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2045, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2046, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2047, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2048, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2049, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2050, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2051, N'V,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (4, 2053, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2033, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2034, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2035, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2036, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2037, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2038, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2039, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2040, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2041, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2042, N'V,A')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2043, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2045, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2046, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2047, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2048, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2049, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2050, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2051, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2053, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2062, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2063, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2064, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2065, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2066, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2067, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2068, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2069, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2070, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2071, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2072, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2073, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2074, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2075, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2076, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2077, N'V,N,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2078, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (5, 2079, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2033, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2034, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2035, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2036, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2037, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2038, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2039, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2040, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2041, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2042, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2043, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2045, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2046, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2047, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2048, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2049, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2050, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2051, N'V,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (20, 2053, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2033, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2034, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2035, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2036, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2037, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2038, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2039, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2040, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2041, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2042, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2043, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2044, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2045, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2046, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2047, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2048, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2049, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2050, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2051, N'V,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (21, 2053, N'V')
GO
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2033, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2034, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2035, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2036, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2037, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2038, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2039, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2040, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2041, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2042, N'V,N,D,M,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2043, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2044, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2045, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2046, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2047, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2048, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2049, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2050, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2051, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2052, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2053, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2054, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2055, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (26, 2080, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2033, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2034, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2035, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2036, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2037, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2038, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2039, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2040, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2041, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2042, N'V,A')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2043, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2045, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2046, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2047, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2048, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2049, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2050, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2051, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2053, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (27, 2054, N'V,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2033, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2034, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2035, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2036, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2037, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2038, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2039, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2040, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2041, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2042, N'V,A')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2043, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2044, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2045, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2046, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2047, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2048, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2049, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2050, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2051, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (28, 2053, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2033, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2034, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2035, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2036, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2037, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2038, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2039, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2040, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2041, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2042, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2043, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2045, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2046, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2047, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2048, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2049, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2050, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2051, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (29, 2053, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2033, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2034, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2035, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2036, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2037, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2038, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2039, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2040, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2041, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2042, N'V,A,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2043, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2045, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2046, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2047, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2048, N'V,N,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2049, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2050, N'V,N,D,M')
GO
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2051, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2052, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2053, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2062, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2063, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2064, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2065, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2066, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2067, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2068, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2069, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2070, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2071, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2072, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2073, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2074, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2075, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2076, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2077, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2078, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (30, 2079, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2033, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2034, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2035, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2036, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2037, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2038, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2039, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2040, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2041, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2042, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2043, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2044, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2045, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2046, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2047, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2048, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2049, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2050, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2051, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2052, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2053, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2054, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2055, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2056, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2062, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2063, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2064, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2065, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2066, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2067, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2068, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2069, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2070, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2071, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2072, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2073, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2074, N'V,N,D,M,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2075, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2076, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2077, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2078, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (31, 2079, N'V,N,D,M,A,L,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2033, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2034, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2035, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2036, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2037, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2038, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2039, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2040, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2041, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2043, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2045, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2046, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2047, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2048, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2049, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2050, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2051, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (32, 2053, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2033, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2034, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2035, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2036, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2037, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2038, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2039, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2040, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2041, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2042, N'V,A')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2043, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2045, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2046, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2047, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2048, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2049, N'V,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2050, N'V,N,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2051, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (33, 2053, N'V')
GO
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1, N'AdminHeThong', N'Quản trị hệ thống', N'Quản trị hệ thống', 0, NULL, CAST(N'2017-01-01 00:00:00.000' AS DateTime), CAST(N'2017-10-25 10:14:03.003' AS DateTime), N'hung', N'hung', 3)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2, N'NhanSu', N'Nhân viên nhân sự', N'nhân viên phòng nhân sự', 0, NULL, CAST(N'2017-04-13 08:27:39.063' AS DateTime), CAST(N'2017-06-17 10:44:58.903' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3, N'KeToan', N'Nhân viên kế toán', N'Nhân viên kế toán thuộc phòng kế toán', 0, NULL, CAST(N'2017-04-13 08:37:04.540' AS DateTime), CAST(N'2017-06-17 10:44:05.947' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4, N'NhanVien', N'Nhân viên', N'Nhân viên trong công ty', 0, NULL, CAST(N'2017-04-13 08:41:18.500' AS DateTime), CAST(N'2017-06-17 10:44:43.690' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (5, N'TruongPhong', N'Trưởng phòng', N'Trưởng phòng', 0, NULL, CAST(N'2017-04-13 08:41:52.330' AS DateTime), CAST(N'2017-04-13 10:47:15.583' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (20, N'CSKH', N'Nhân viên chăm sóc khách hàng', N'Nhân viên thuộc phòng CSKH', 0, NULL, CAST(N'2017-04-17 16:59:49.213' AS DateTime), CAST(N'2017-06-14 09:47:01.320' AS DateTime), NULL, NULL, 5)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (21, N'TrienKhai', N'Nhân viên triển khai', N'Nhân viên phòng triển khai', 0, NULL, CAST(N'2017-04-19 09:14:21.927' AS DateTime), CAST(N'2017-06-14 09:47:12.770' AS DateTime), NULL, NULL, 4)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (26, N'AdminNhanSu', N'Quản trị nhân sự', N'Quản trị nhân sự', 0, NULL, CAST(N'2017-04-25 15:31:10.297' AS DateTime), CAST(N'2017-04-25 15:31:10.297' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (27, N'TPCSKH', N'Trưởng phòng CSKH', NULL, 0, NULL, CAST(N'2017-06-14 09:45:36.220' AS DateTime), CAST(N'2017-06-14 09:45:36.220' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (28, N'TPTK', N'Trưởng phòng triển khai', NULL, 0, NULL, CAST(N'2017-06-14 09:46:44.707' AS DateTime), CAST(N'2017-06-14 09:46:44.707' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (29, N'Marketing', N'Nhân viên marketing', N'Nhân viên phòng Marketing', 0, NULL, CAST(N'2017-06-14 09:48:27.370' AS DateTime), CAST(N'2017-06-17 10:45:32.553' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (30, N'KeToanTruong', N'Kế toán trưởng', NULL, 0, NULL, CAST(N'2017-06-15 17:12:59.027' AS DateTime), CAST(N'2017-06-15 17:12:59.027' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (31, N'GiamDoc', N'Giám đốc', NULL, 0, NULL, CAST(N'2017-06-16 09:26:39.803' AS DateTime), CAST(N'2017-06-16 09:26:39.803' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (32, N'KinhDoanh', N'Nhân viên kinh doanh', N'Nhân viên phòng kinh doanh', 0, NULL, CAST(N'2017-06-16 11:11:32.287' AS DateTime), CAST(N'2017-06-17 10:46:28.730' AS DateTime), NULL, NULL, 4)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (33, N'TPLT', N'Trưởng phòng lập trình', NULL, 0, NULL, CAST(N'2017-06-17 10:40:48.673' AS DateTime), CAST(N'2017-06-17 10:43:11.647' AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
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
/****** Object:  StoredProcedure [dbo].[csp_LayDanhSach_QuyenTacVuBangVaiTroId]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Helper_CreatePocoFromTableName]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_CauHinhFormCot_GetInfoByMaForm]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_CauHinhFormCot_GetListCauHinhFormCotByCriteria]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_KD_NguoiDung_cbxNguoiDungById]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_KD_PhanQuyen_GetListChucNang]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_KD_VaiTro_cbxVaiTroById]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_GetListNguoiDungByCriteria]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_GetListNguoiDungById]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_SelectAllByCriteria]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_PhanQuyen_GetListChucNang]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_PhanQuyen_GetListQuyenTacVuBangVaiTroId]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_PhanQuyen_GetQuyenTacVuByMaChucNangAndMaVaiTro]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_DeleteOne]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_InsertOne]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectAll]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectAllByCriteria]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectAllByCriteriaCount]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectAllByCriteriaProjection]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectAllCount]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectOne]    Script Date: 12/1/2017 4:44:41 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_UpdateOne]    Script Date: 12/1/2017 4:44:41 PM ******/
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
