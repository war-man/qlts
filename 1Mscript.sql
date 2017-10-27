USE [master]
GO
/****** Object:  Database [QLTS_MAIN]    Script Date: 10/27/2017 3:01:14 PM ******/
CREATE DATABASE [QLTS_MAIN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLTS_MAIN', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QLTS_MAIN.mdf' , SIZE = 20480KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QLTS_MAIN_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QLTS_MAIN_log.ldf' , SIZE = 10240KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QLTS_MAIN] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLTS_MAIN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLTS_MAIN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLTS_MAIN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLTS_MAIN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLTS_MAIN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLTS_MAIN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET RECOVERY FULL 
GO
ALTER DATABASE [QLTS_MAIN] SET  MULTI_USER 
GO
ALTER DATABASE [QLTS_MAIN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLTS_MAIN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLTS_MAIN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLTS_MAIN] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QLTS_MAIN] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLTS_MAIN', N'ON'
GO
USE [QLTS_MAIN]
GO
/****** Object:  Table [dbo].[CauHinhForm]    Script Date: 10/27/2017 3:01:14 PM ******/
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
/****** Object:  Table [dbo].[CauHinhFormCot]    Script Date: 10/27/2017 3:01:15 PM ******/
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
/****** Object:  Table [dbo].[CauHinhHeThong]    Script Date: 10/27/2017 3:01:15 PM ******/
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
/****** Object:  Table [dbo].[ChucNang]    Script Date: 10/27/2017 3:01:15 PM ******/
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
	[DuongDan] [nvarchar](128) NULL,
	[ThuTu] [smallint] NULL,
	[SuperLevel] [int] NULL,
	[MidLevel] [nchar](10) NULL,
	[Icon] [nvarchar](64) NULL,
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
/****** Object:  Table [dbo].[Client]    Script Date: 10/27/2017 3:01:15 PM ******/
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
/****** Object:  Table [dbo].[FormCotTheoNguoiDung]    Script Date: 10/27/2017 3:01:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormCotTheoNguoiDung](
	[NguoiDungId] [int] NOT NULL,
	[CauHinhFormCotId] [int] NOT NULL,
	[HienThiYN] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 10/27/2017 3:01:15 PM ******/
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
	[CoSoId] [int] NULL,
	[NguoiTao] [nvarchar](128) NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NOT NULL CONSTRAINT [DF__NguoiDung__ctr_v__46B27FE2]  DEFAULT ((0)),
 CONSTRAINT [PK_NguoiDung_1] PRIMARY KEY CLUSTERED 
(
	[NguoiDungId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuyenTacVu]    Script Date: 10/27/2017 3:01:15 PM ******/
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
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 10/27/2017 3:01:15 PM ******/
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
/****** Object:  Table [dbo].[VaiTro]    Script Date: 10/27/2017 3:01:15 PM ******/
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
	[CoSoId] [int] NOT NULL,
	[NguoiTao] [nvarchar](128) NULL,
	[NguoiSua] [nvarchar](128) NULL,
	[CtrVersion] [int] NOT NULL CONSTRAINT [DF__VaiTro__ctr_vers__625A9A57]  DEFAULT ((0)),
 CONSTRAINT [PK_VaiTro_1] PRIMARY KEY CLUSTERED 
(
	[VaiTroId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[CauHinhFormCot] ON 

INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1, N'FL0009', N'MaNguoiDung', N'Mã người dùng', N'Mã người dùng', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.MaNguoiDung', 70, NULL, NULL, NULL, NULL, NULL, 17)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2, N'FL0009', N'HoTen', N'Người dùng', N'Người dùng', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.HoTen', 70, NULL, NULL, NULL, NULL, NULL, 17)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3, N'FL0009', N'TenNhanVien', N'Nhân viên', N'Nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'b.TenNhanVien', 70, NULL, NULL, NULL, NULL, NULL, 17)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4, N'FL0009', N'Email', N'Email', N'Email', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.Email', 70, NULL, NULL, NULL, NULL, NULL, 17)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (5, N'FL0009', N'DienThoai', N'Điện thoại', N'Điện thoại', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.DienThoai', 70, NULL, NULL, NULL, NULL, NULL, 17)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (6, N'FL0009', N'TenVaiTro', N'Vai trò', N'Vai trò', 1, 1, 0, NULL, NULL, NULL, NULL, N'c.TenVaiTro', 70, NULL, NULL, NULL, NULL, NULL, 17)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (7, N'FL0009', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 1, 1, 0, NULL, NULL, NULL, NULL, N'Convert(varchar(10),CONVERT(date,a.NgayTao,106),103) AS NgayTao', 70, NULL, NULL, NULL, NULL, NULL, 15)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (9, N'FL0018', N'SoPhieu', N'Số phiếu', N'Số phiếu', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.SoPhieu', 1, NULL, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (10, N'FL0018', N'Ngay', N'Ngày lập', N'Ngày lập', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayTao', 2, NULL, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (11, N'FL0018', N'TenPhongBan', N'Bộ phận đề nghị', N'Bộ phận đề nghị', 1, 1, 0, NULL, NULL, NULL, NULL, N'PB.TenPhongBan', 3, NULL, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (12, N'FL0018', N'NoiDung', N'Nội dung đề nghị', N'Nội dung', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.NoiDung', 4, NULL, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (14, N'FL0018', N'TenPhanLoai', N'Phân loại', N'Phân loại', 0, 1, 0, NULL, NULL, NULL, NULL, N'PL.TenPhanLoai', 5, NULL, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (15, N'FL0018', N'TenNhanVien', N'Người tạo', N'Người tạo', 1, 1, 0, NULL, NULL, NULL, NULL, N'nv.TenNhanVien', 6, NULL, NULL, NULL, NULL, NULL, 17)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (16, N'FL0018', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayTao', 7, NULL, NULL, NULL, NULL, NULL, 17)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1003, N'FL0019', N'SoChungTu', N'Số chứng từ', N'Số chứng từ', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.SoChungTu', 1, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1005, N'FL0019', N'NgayChungTu', N'Ngày chứng từ', N'Ngày chứng từ', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayChungTu', 2, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1006, N'FL0019', N'NgayGhiTang', N'Ngày ghi tăng', N'Ngày ghi tăng', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayGhiTang', 3, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1007, N'FL0019', N'NoiDung', N'Nội dung', N'Nội dung', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.NoiDung', 4, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1008, N'FL0019', N'TongNguyenGia', N'Tổng nguyên giá', N'Tổng nguyên giá', 1, 1, 0, NULL, NULL, NULL, NULL, N'TongNguyenGia', 5, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1009, N'FL0019', N'TenNguoiTao', N'Người tạo', N'Người tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'H.TenNguoiTao', 6, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1010, N'FL0019', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayTao', 7, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1012, N'FL0019', N'TenNguoiDuyet', N'Người duyệt', N'Người duyệt', 0, 1, 0, NULL, NULL, NULL, NULL, N'H.TenNguoiDuyet', 8, NULL, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1013, N'FL0020', N'SoChungTu', N'Số chứng từ', N'Số chứng từ', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.SoChungTu', 1, NULL, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1014, N'FL0020', N'Ngay', N'Ngày thay đổi', N'Ngày thay đổi', 1, 1, 0, NULL, NULL, NULL, NULL, N'TTTD.Ngay', 2, NULL, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1015, N'FL0020', N'NgayGhiGiam', N'Ngày ghi giảm', N'Ngày ghi giảm', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.NgayGhiGiam', 3, NULL, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1016, N'FL0020', N'TenPhongBan', N'Bộ phận đề nghị', N'Bộ phận đề nghị', 1, 1, 0, NULL, NULL, NULL, NULL, N'b.TenPhongBan', 4, NULL, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1017, N'FL0020', N'NoiDung', N'Nội dung', N'Nội dung', 1, 1, 0, NULL, NULL, NULL, NULL, N'a.NoiDung', 4, NULL, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1018, N'FL0020', N'TongNguyenGia', N'Tổng nguyên giá', N'Tổng nguyên giá', 1, 1, 0, NULL, NULL, NULL, NULL, N'TongNguyenGia', 5, NULL, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1019, N'FL0020', N'TenNguoiTao', N'Người tạo', N'Người tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.TenNguoiTao', 6, NULL, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1020, N'FL0020', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.NgayTao', 7, NULL, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1021, N'FL0020', N'TenNguoiDuyet', N'Người duyệt', N'Người duyệt', 0, 1, 0, NULL, NULL, NULL, NULL, N'a.TenNguoiDuyet', 8, NULL, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1022, N'FL0021', N'SoChungTu', N'Số chứng từ', N'Số chứng từ', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.SoChungTu', 1, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1023, N'FL0021', N'NgayDieuChuyen', N'Ngày điều chuyển', N'Ngày điều chuyển', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayDieuChuyen', 3, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1024, N'FL0021', N'NgayChungTu', N'Ngày chứng từ', N'Ngày chứng từ', 1, 1, 0, NULL, NULL, NULL, NULL, N'NgayChungTu', 2, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1026, N'FL0021', N'GhiChu', N'Ghi chú', N'Ghi chú', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.GhiChu', 4, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1027, N'FL0021', N'TenNguoiTao', N'Người tạo', N'Người tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'TenNguoiTao', 5, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1028, N'FL0021', N'TenNguoiDuyet', N'Người duyệt', N'Người duyệt', 0, 1, 0, NULL, NULL, NULL, NULL, N'TenNguoiDuyet', 6, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1029, N'FL0021', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayTao', 7, NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1030, N'FL0022', N'MaTaiSan', N'Mã tài sản', N'Mã tài sản', 1, 1, 0, NULL, NULL, NULL, 100, N'td.MaTaiSan', 1, NULL, NULL, NULL, NULL, NULL, 45)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1032, N'FL0022', N'TenTaiSan', N'Tên tài sản', N'Tên tài sản', 1, 1, 0, NULL, NULL, NULL, 100, N'ts.TenTaiSan', 2, NULL, NULL, NULL, NULL, NULL, 45)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1033, N'FL0022', N'NgayGhiTang', N'Ngày ghi tăng', N'Ngày ghi tăng', 1, 1, 0, NULL, NULL, NULL, 100, N'td.NgayGhiTang', 3, NULL, NULL, NULL, NULL, NULL, 45)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1034, N'FL0022', N'NgayTrangCap', N'Ngày trang cấp', N'Ngày trang cấp', 1, 1, 0, NULL, NULL, NULL, 100, N'td.NgayTrangCap', 4, NULL, NULL, NULL, NULL, NULL, 45)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1035, N'FL0022', N'NgayBatDauSuDung', N'Ngày BĐ sử dụng', N'Ngày BĐ sử dụng', 1, 1, 0, NULL, NULL, NULL, 100, N'td.NgayBatDauSuDung', 5, NULL, NULL, NULL, NULL, NULL, 45)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1036, N'FL0022', N'TenPhongBan', N'Bộ phận', N'Bộ phận', 1, 1, 0, NULL, NULL, NULL, 100, N'pb.TenPhongBan', 6, NULL, NULL, NULL, NULL, NULL, 45)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1037, N'FL0022', N'TenNhanVien', N'Cán bộ', N'Cán bộ', 1, 1, 0, NULL, NULL, NULL, 100, N'nv.TenNhanVien', 7, NULL, NULL, NULL, NULL, NULL, 45)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1038, N'FL0022', N'SLTon', N'Số lượng tồn', N'Số lượng tồn', 0, 1, 0, NULL, NULL, NULL, 100, N'td.SLTon', 8, NULL, NULL, NULL, NULL, NULL, 45)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1039, N'FL0022', N'SLTang', N'Số lượng tăng', N'Số lượng tăng', 0, 1, 0, NULL, NULL, NULL, 100, N'td.SLTang', 9, NULL, NULL, NULL, NULL, NULL, 45)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1040, N'FL0022', N'SLGiam', N'Số lượng giảm', N'Số lượng giảm', 0, 1, 0, NULL, NULL, NULL, 100, N'td.SLGiam', 10, NULL, NULL, NULL, NULL, NULL, 45)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1041, N'FL0022', N'SoLuong', N'Số lượng', N'Số lượng', 1, 1, 0, NULL, NULL, NULL, 100, N'SoLuong', 11, NULL, NULL, NULL, NULL, NULL, 36)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1042, N'FL0022', N'NguyenGia', N'Nguyên giá', N'Nguyên giá', 1, 1, 0, NULL, NULL, NULL, 100, N'NguyenGia', 12, NULL, NULL, NULL, NULL, NULL, 36)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1043, N'FL0022', N'ThanhTien', N'Thành tiền', N'Thành tiền', 1, 1, 0, NULL, NULL, NULL, 100, N'ThanhTien', 13, NULL, NULL, NULL, NULL, NULL, 36)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1044, N'FL0023', N'TenTaiSan', N'Tên tài sản', N'Tên tài sản', 1, 1, 0, NULL, NULL, NULL, NULL, N'ts.TenTaiSan', 1, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1045, N'FL0023', N'NgayBaoDuong', N'Ngày bảo dưỡng', N'Ngày bảo dưỡng', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayBaoDuong', 2, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1046, N'FL0023', N'NgayDuKien', N'Ngày dự kiến', N'Ngày dự kiến', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayDuKien', 3, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1047, N'FL0023', N'DuToan', N'Dự toán', N'Dự toán', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.DuToan', 4, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1048, N'FL0023', N'MoTa', N'Mô tả', N'Mô tả', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.MoTa', 7, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1049, N'FL0023', N'TenNguoiDuyet', N'Người duyệt', N'Người duyệt', 0, 1, 0, NULL, NULL, NULL, NULL, N'TenNguoiDuyet', 8, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1050, N'FL0023', N'TenNguoiTao', N'Người tạo', N'Người tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'TenNguoiTao', 9, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1051, N'FL0023', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayTao', 10, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1052, N'FL0023', N'MaTaiSan', N'Mã tài sản', N'Mã tài sản', 1, 1, 0, NULL, NULL, NULL, NULL, N'ts.MaTaiSan', 0, NULL, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1053, N'FL0024', N'SoChungTu', N'Số chứng từ', N'Số chứng từ', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.SoChungTu', 1, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1055, N'FL0024', N'NgayChungTu', N'Ngày chứng từ', N'Ngày chứng từ', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayChungTu', 2, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1056, N'FL0024', N'NgayKiemKe', N'Ngày kiểm kê', N'Ngày kiểm kê', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayKiemKe', 3, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1057, N'FL0024', N'TenPhongBan', N'Bộ phận', N'Bộ phận', 0, 1, 0, NULL, NULL, NULL, NULL, N'PB.TenPhongBan', 4, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1058, N'FL0024', N'GhiChu', N'Ghi chú', N'Ghi chú', 1, 1, 0, NULL, NULL, NULL, NULL, N'H.GhiChu', 5, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1059, N'FL0024', N'TenNguoiTao', N'Người tạo', N'Người tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'TenNguoiTao', 6, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1060, N'FL0024', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'H.NgayTao', 7, NULL, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1062, N'FL0023', N'TenPhongBan', N'Bộ phận', N'Bộ phận', 0, 1, 0, NULL, NULL, NULL, NULL, N'TenPhongBan', 5, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1063, N'FL0023', N'TenNhanVien', N'Cán bộ', N'Cán bộ', 0, 1, 0, NULL, NULL, NULL, NULL, N'TenNhanVien', 6, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2046, N'FL0025', N'TenNguoiTao', N'Người tạo', N'Người tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'TenNguoiTao', 1, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2048, N'FL0025', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'NgayTao', 2, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2049, N'FL0026', N'TenKyLap', N'Kỳ lập', N'Kỳ lập', 1, 1, 0, NULL, NULL, NULL, NULL, N'KyLap', 1, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2050, N'FL0026', N'Nam', N'Năm', N'Năm', 1, 1, 0, NULL, NULL, NULL, NULL, N'Nam', 2, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2051, N'FL0026', N'NoiDung', N'Nội dung', N'Nội dung', 1, 1, 0, NULL, NULL, NULL, NULL, N'NoiDung', 3, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2052, N'FL0026', N'TenNguoiTao', N'Người tạo', N'Người tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'TenNguoiTao', 4, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2053, N'FL0026', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'NgayTao', 5, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2055, N'FL0022', N'Nam', N'Năm', N'Năm', 0, 1, 0, NULL, NULL, NULL, NULL, N'Nam', 14, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2056, N'FL0027', N'MaTaiSan', N'Mã tài sản', N'Mã tài sản', 1, 1, 0, NULL, NULL, NULL, NULL, N'TS.MaTaiSan', 10, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2057, N'FL0027', N'TenTaiSan', N'Tên tài sản', N'Tên tài sản', 1, 1, 0, NULL, NULL, NULL, NULL, N'TS.TenTaiSan', 20, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2058, N'FL0027', N'TenNguoiTao', N'Người tạo', N'Người tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'NV.TenNhanVien TenNguoiTao', 100, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2059, N'FL0027', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'TS.NgayTao', 101, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2060, N'FL0027', N'NguyenGia', N'Nguyên giá', N'Nguyên giá', 1, 1, 0, NULL, NULL, NULL, NULL, N'ISNULL(NG.NguyenGia,0) NguyenGia', 30, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2061, N'FL0027', N'TenLoai', N'Tên loại', N'Tên loại', 1, 1, 0, NULL, NULL, NULL, NULL, N'l.TenLoai', 40, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2062, N'FL0027', N'TenHangSanXuat', N'Tên hãng sản xuất', N'Tên hãng sản xuất', 0, 1, 0, NULL, NULL, NULL, NULL, N'H.TenHangSanXuat', 50, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2063, N'FL0027', N'TenNhom', N'Tên nhóm', N'Tên nhóm', 0, 1, 0, NULL, NULL, NULL, NULL, N'N.TenNhom', 60, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2064, N'FL0027', N'TenNuocSanXuat', N'Tên nước sản xuất', N'Tên nướcsản xuất', 0, 1, 0, NULL, NULL, NULL, NULL, N'NC.TenNuocSanXuat', 70, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2065, N'FL0028', N'Ngay', N'Ngày thay đổi', N'Ngày thay đổi', 1, 1, 0, NULL, NULL, NULL, NULL, N'TTTD.Ngay', 1, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2066, N'FL0028', N'MaTaiSan', N'Mã tài sản', N'Mã tài sản', 1, 1, 0, NULL, NULL, NULL, NULL, N'TS.MaTaiSan', 1, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2067, N'FL0028', N'TenTaiSan', N'Tên tài sản', N'Tên tài sản', 1, 1, 0, NULL, NULL, NULL, NULL, N'TS.TenTaiSan', 1, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2068, N'FL0028', N'TenNguoiDuyet', N'Tên người duyệt', N'Tên người duyệt', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV_ND.TenNhanVien TenNguoiDuyet', 1, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2069, N'FL0028', N'LyDo', N'Lý do', N'Lý do', 1, 1, 0, NULL, NULL, NULL, NULL, N'TTTD.LyDo', 1, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2070, N'FL0029', N'SoChungTu', N'Số chứng từ', N'Số chứng từ', 1, 1, 0, NULL, NULL, NULL, NULL, N'DG.SoChungTu', 10, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2071, N'FL0029', N'NgayDanhGia', N'Ngày đánh giá', N'Ngày đánh giá', 1, 1, 0, NULL, NULL, NULL, NULL, N'DG.NgayDanhGia', 20, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2072, N'FL0029', N'NgayChungTu', N'Ngày chứng từ', N'Ngày chứng từ', 1, 1, 0, NULL, NULL, NULL, NULL, N'DG.NgayChungTu', 30, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2073, N'FL0029', N'TenNguoiTao', N'Người tạo', N'Người tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'NV_NT.TenNhanVien TenNguoiTao', 70, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2074, N'FL0029', N'TenNhanVien', N'Nhân viên', N'Nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV.TenNhanVien', 60, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2075, N'FL0029', N'TenPhongBan', N'Phòng ban', N'Phòng ban', 1, 1, 0, NULL, NULL, NULL, NULL, N'PB.TenPhongBan', 50, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2076, N'FL0029', N'TenTaiSan', N'Tài sản', N'Tài sản', 1, 1, 0, NULL, NULL, NULL, NULL, N'TS.TenTaiSan', 40, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3054, N'FL0029', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 1, 1, 0, NULL, NULL, NULL, NULL, N'DG.NgayTao', 80, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3056, N'FL0030', N'MaTaiSan', N'Mã tài sản', N'Mã tài sản', 1, 1, 0, NULL, NULL, NULL, NULL, N'TS.MaTaiSan', 10, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3057, N'FL0030', N'TenTaiSan', N'Tên tài sản', N'Tên tài sản', 1, 1, 0, NULL, NULL, NULL, NULL, N'TS.TenTaiSan', 20, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3058, N'FL0030', N'TenPhongBan', N'Phòng ban', N'Phòng ban', 1, 1, 0, NULL, NULL, NULL, NULL, N'PB.TenPhongBan', 30, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3059, N'FL0030', N'TenNhanVien', N'Nhân viên', N'Nhân viên', 1, 1, 0, NULL, NULL, NULL, NULL, N'NV.TenNhanVien', 40, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3060, N'FL0030', N'SoLuong', N'Số lượng', N'Số lượng', 1, 1, 0, NULL, NULL, NULL, NULL, N'', 60, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3061, N'FL0030', N'Nam', N'Năm', N'Năm', 1, 1, 0, NULL, NULL, NULL, NULL, N'TD.Nam', 90, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3062, N'FL0030', N'TenCoSo', N'Tên cơ sở', N'Tên cơ sở', 1, 1, 0, NULL, NULL, NULL, NULL, N'CS.TenCoSo', 50, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3063, N'FL0030', N'LoaiKeKhai', N'Loại kê khai', N'Loại kê khai', 1, 1, 0, NULL, NULL, NULL, NULL, N'TS.LoaiKeKhai', 50, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3064, N'FL0030', N'NguyenGia', N'Nguyên giá', N'Nguyên giá', 0, 0, 0, NULL, NULL, NULL, NULL, N'', 70, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3065, N'FL0030', N'ThanhTien', N'Thành tiền', N'Thành tiền', 0, 0, 0, NULL, NULL, NULL, NULL, N'', 80, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3066, N'FL0031', N'SoChungTu', N'Số chứng từ', N'Số chứng từ', 1, 1, 0, NULL, NULL, NULL, NULL, N'SoChungTu', 1, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3067, N'FL0031', N'Ngay', N'Ngày', N'Ngày', 1, 1, 0, NULL, NULL, NULL, NULL, N'Ngay', 2, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3068, N'FL0031', N'TenPhongBan', N'Bộ phận', N'Bộ phận', 1, 1, 0, NULL, NULL, NULL, NULL, N'TenPhongBan', 3, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3069, N'FL0031', N'NoiDung', N'Nội dung', N'Nội dung', 1, 1, 0, NULL, NULL, NULL, NULL, N'NoiDung', 4, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3070, N'FL0031', N'TenNhanVien', N'Người tạo', N'Người tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'TenNhanVien', 5, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3072, N'FL0031', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 0, 1, 0, NULL, NULL, NULL, NULL, N'NgayTao', 6, NULL, NULL, NULL, NULL, N'null', 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3073, N'FL0032', N'SoPhieu', N'Số phiếu', N'Số phiếu', 1, 0, 1, NULL, NULL, NULL, NULL, N'SoPhieu', 1, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3074, N'FL0032', N'NoiDung', N'Nội dung', N'Nội dung', 1, 0, 1, NULL, NULL, NULL, NULL, N'NoiDung', 2, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3075, N'FL0032', N'TenNhaCungCap', N'Nhà cung cấp', N'Nhà cung cấp', 1, 0, 1, NULL, NULL, NULL, NULL, N'TenNhaCungCap', 3, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3076, N'FL0032', N'TenKhoTaiSan', N'Kho tài sản', N'Kho tài sản', 1, 0, 1, NULL, NULL, NULL, NULL, N'TenKhoTaiSan', 4, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3077, N'FL0032', N'SoHoaDon', N'Số HĐ', N'Số HĐ', 1, 0, 1, NULL, NULL, NULL, NULL, N'SoHoaDon', 5, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3078, N'FL0032', N'NgayNhap', N'Ngày nhập', N'Ngày nhập', 1, 0, 1, NULL, NULL, NULL, NULL, N'NgayNhap', 6, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3079, N'FL0032', N'TenNguonNganSach', N'Ngân sách', N'Ngân sách', 0, 0, 1, NULL, NULL, NULL, NULL, N'NganSach', 7, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3080, N'FL0032', N'Seri', N'Seri', N'Seri', 0, 0, 1, NULL, NULL, NULL, NULL, N'Seri', 8, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3081, N'FL0032', N'NgayHD', N'Ngày HĐ', N'Ngày HĐ', 0, 1, 1, NULL, NULL, NULL, NULL, N'NgayHD', 9, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3082, N'FL0032', N'BBKiem', N'BB kiểm số', N'BB kiểm số', 0, 1, 1, NULL, NULL, NULL, NULL, N'BBKiem', 10, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3083, N'FL0032', N'ChietKhau', N'Chiết khấu', N'Chiết khấu', 0, 1, 1, NULL, NULL, NULL, NULL, N'ChietKhau', 11, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3084, N'FL0032', N'NguoiGiao', N'Người giao', N'Người giao', 0, 1, 1, NULL, NULL, NULL, NULL, N'NguoiGiao', 12, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3085, N'FL0032', N'TenLoai', N'Loại', N'Loại', 0, 1, 1, NULL, NULL, NULL, NULL, N'Loai', 13, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3086, N'FL0032', N'TaiKhoanNo', N'Tài khoản nợ', N'Tài khoản nợ', 0, 1, 1, NULL, NULL, NULL, NULL, N'TaiKhoanNo', 14, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3087, N'FL0032', N'TaiKhoanCo', N'Tài khoản có', N'Tài khoản có', 0, 1, 1, NULL, NULL, NULL, NULL, N'TaiKhoanCo', 15, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3088, N'FL0032', N'TenNguoiTao', N'Người tạo', N'Người tạo', 0, 1, 1, NULL, NULL, NULL, NULL, N'TenNguoiTao', 16, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3089, N'FL0032', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 0, 1, 1, NULL, NULL, NULL, NULL, N'NgayTao', 17, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3090, N'FL0033', N'SoPhieu', N'Số phiếu', N'Số phiếu', 1, 1, 1, NULL, NULL, NULL, NULL, N'', 10, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3091, N'FL0033', N'NgayXuat', N'Ngày xuất', N'Ngày xuất', 1, 1, 1, NULL, NULL, NULL, NULL, N'', 20, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3092, N'FL0033', N'NguoiNhanHang', N'Người nhận', N'Người nhận', 1, 1, 1, NULL, NULL, NULL, NULL, N'', 30, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3093, N'FL0033', N'LyDo', N'Lý do', N'Lý do', 1, 1, 1, NULL, NULL, NULL, NULL, N'', 40, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3094, N'FL0033', N'TenNguoiTao', N'Người tạo', N'Người tạo', 1, 1, 1, NULL, NULL, NULL, NULL, N'', 50, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CauHinhFormCot] ([CauHinhFormCotId], [MaForm], [MaCot], [TenCot], [TenCotMacDinh], [HienThiYN], [MacDinhYN], [LaCongThucYN], [CongThuc], [CauSapXep], [MoTa], [DoRong], [CauSelect], [ThuTu], [TenCotMacDinhRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3095, N'FL0033', N'NgayTao', N'Ngày tạo', N'Ngày tạo', 1, 1, 1, NULL, NULL, NULL, NULL, N'', 60, NULL, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[CauHinhFormCot] OFF
SET IDENTITY_INSERT [dbo].[ChucNang] ON 

INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1, N'CN0001', N'Quản trị hệ thống', N'Quản trị hệ thống', N'V,N,D,M,VR,VB,VA', N'', 6, 1, NULL, N'fa fa-user-secret', 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2, N'CN0002', N'Người dùng', N'Người dùng', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/nguoidung/list', 1, NULL, N'1         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3, N'CN0003', N'Vai trò', N'Quan Ly Vai Tro', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/vaitro/list', 2, NULL, N'1         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4, N'CN0004', N'Phòng ban', N'Danh sách phòng ban', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/phongban/list', 7, NULL, N'2         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (5, N'CN0005', N'Nhân viên', N'Danh sách nhân viên', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/nhanvien/list', 6, NULL, N'2         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1004, N'CN0006', N'Nhóm tài sản', N'Danh sách nhóm tài sản', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/nhomtaisan/list', 2, NULL, N'2         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1005, N'CN0007', N'Loại tài sản', N'Danh sách loại tài sản', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/loaitaisan/list', 3, NULL, N'2         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1006, N'CN0008', N'Nước sản xuất', N'Danh sách nước sản xuất', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/nuocsanxuat/list', 4, NULL, N'2         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1007, N'CN0009', N'Hãng sản xuất', N'Danh sách hãng sản xuất', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/hangsanxuat/list', 5, NULL, N'2         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1008, N'CN0010', N'Khách hàng', N'Danh sách Khách hàng', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/khachhang/list', 8, NULL, N'2         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1009, N'CN0011', N'Nguồn ngân sách', N'Danh sách Nguồn ngân sách', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/nguonngansach/list', 9, NULL, N'2         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1010, N'CN0012', N'Nhà cung cấp', N'Danh sách Nhà cung cấp', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/nhacungcap/list', 10, NULL, N'2         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1011, N'CN0013', N'Kho tài sản', N'Danh sách Kho tài sản', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/khotaisan/list', 1, NULL, N'3         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1012, N'CN0014', N'Dự án', N'Danh sách Dự án', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/duan/list', 14, NULL, N'2         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1013, N'CN0015', N'Cơ sở', N'Danh sách Cơ sở', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/coso/list', 15, NULL, N'2         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1014, N'CN0016', N'Khai báo danh mục', N'Khai báo danh mục', N'V,N,D,M,VR,VB,VA', N'', 1, 2, NULL, N'fa fa-list', 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1015, N'CN0017', N'Tài sản lâu bền', N'Tài sản lâu bền', N'V,N,D,M,VR,VB,VA', N'', 3, 3, NULL, N'fa fa-cubes', 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1017, N'CN0018', N'Phân quyền', N'Phân quyền', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/phanquyen/list', 3, NULL, N'1         ', NULL, 0, NULL, CAST(N'2017-06-13 15:53:22.817' AS DateTime), CAST(N'2017-06-13 15:53:22.817' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1018, N'CN0019', N'Đề nghị trang cấp', N'Đề nghị trang cấp', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/denghitrangcap/list', 2, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-08-29 08:09:31.550' AS DateTime), CAST(N'2017-08-29 08:09:31.550' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1019, N'CN0020', N'Tài sản cố định', N'Tài sản cố định', N'V,N,D,M,VR,VB,VA', NULL, 2, 4, NULL, N'fa fa-hospital-o', 0, NULL, CAST(N'2017-08-29 08:09:31.550' AS DateTime), CAST(N'2017-08-29 08:09:31.550' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1020, N'CN0021', N'Kê hoạch mua sắm', N'Kê hoạch mua sắm', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/kehoachmuasam/list', 1, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-08-29 08:09:31.550' AS DateTime), CAST(N'2017-08-29 08:09:31.550' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1021, N'CN0022', N'Danh mục tài sản', N'Danh mục tài sản', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/taisan/list', 1, NULL, N'2         ', NULL, 0, NULL, CAST(N'2017-08-29 08:09:31.550' AS DateTime), CAST(N'2017-08-29 08:09:31.550' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2004, N'CN0023', N'Ghi giảm', N'Ghi giảm', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/ghigiam/list', 5, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-08-29 08:09:31.550' AS DateTime), CAST(N'2017-08-29 08:09:31.550' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2005, N'CN0024', N'Ghi tăng', N'Ghi tăng', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/ghitang/list', 3, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-09-05 11:41:44.427' AS DateTime), CAST(N'2017-09-05 11:41:44.427' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2006, N'CN0025', N'Điều chuyển', N'Điều chuyển nội bộ', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/dieuchuyen/list', 4, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-09-07 08:11:02.590' AS DateTime), CAST(N'2017-09-07 08:11:02.590' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2007, N'CN0026', N'Nhập khẩu tài sản', N'Nhập khẩu tài sản', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/theodoi/list', 15, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-09-11 13:45:02.597' AS DateTime), CAST(N'2017-09-11 13:45:02.597' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2008, N'CN0027', N'Thay đổi thông tin kê khai', N'Thay đổi thông tin kê khai', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/ThayDoiThongTinKeKhai/list', 7, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-09-11 16:15:36.973' AS DateTime), CAST(N'2017-09-11 16:15:36.973' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2009, N'CN0028', N'Bảo dưỡng - Sửa chữa', N'Bảo dưỡng', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/baoduong/list', 9, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-09-13 10:47:40.643' AS DateTime), CAST(N'2017-09-13 10:47:40.643' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2010, N'CN0029', N'Duyệt trang cấp', N'Duyệt trang cấp', N'V,A,VR,VB,VA', N'/QLTSMAIN/duyetcap/list', 2, NULL, N'5         ', NULL, 0, NULL, CAST(N'2017-09-13 10:47:40.643' AS DateTime), CAST(N'2017-09-13 10:47:40.643' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2011, N'CN0030', N'Duyệt mua sắm', N'Duyệt mua sắm', N'V,A,VR,VB,VA', N'/QLTSMAIN/duyetmua/list', 1, NULL, N'5         ', NULL, 0, NULL, CAST(N'2017-09-13 10:47:40.643' AS DateTime), CAST(N'2017-09-13 10:47:40.643' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2012, N'CN0031', N'Biên bản kiểm kê', N'Biên bản kiểm kê', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/bienbankiemke/list', 4, NULL, N'6         ', NULL, 0, NULL, CAST(N'2017-09-15 09:40:09.310' AS DateTime), CAST(N'2017-09-15 09:40:09.310' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2013, N'CN0032', N'Phê duyệt', N'Phê duyệt', N'V,N,D,M,VR,VB,VA', NULL, 4, 5, NULL, N'fa fa-pencil-square-o', 0, NULL, CAST(N'2017-08-29 08:09:31.550' AS DateTime), CAST(N'2017-08-29 08:09:31.550' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2014, N'CN0033', N'Đánh giá lại tài sản', N'Đánh giá lại tài sản', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/danhgiataisan/list', 6, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-08-29 08:09:31.550' AS DateTime), CAST(N'2017-08-29 08:09:31.550' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3009, N'CN0034', N'Khai thác', N'Khai thác', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/khaithac/list', 16, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-09-25 09:01:36.820' AS DateTime), CAST(N'2017-09-25 09:01:36.820' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3010, N'CN0035', N'Sử dụng', N'Sử dụng', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/sudung/list', 17, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-09-26 14:32:35.180' AS DateTime), CAST(N'2017-09-26 14:32:35.180' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3011, N'CN0036', N'Báo cáo tổng hợp', N'Báo cáo tổng hợp', N'V,VR,VB,VA', N'/QLTSMAIN/baocaotonghop/list', 2, NULL, N'6         ', N'fa fa-pie-chart', 0, NULL, CAST(N'2017-10-02 08:19:47.873' AS DateTime), CAST(N'2017-10-02 08:19:47.873' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3012, N'CN0037', N'Tra cứu tài sản', N'Tra cứu tài sản', N'V,VR,VB,VA', N'/QLTSMAIN/tracuutaisan/list', 1, NULL, N'6         ', NULL, 0, NULL, CAST(N'2017-08-29 08:09:31.550' AS DateTime), CAST(N'2017-08-29 08:09:31.550' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3015, N'CN0038', N'Lập báo cáo', N'Lập báo cáo', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/lapbaocao/list', 5, NULL, N'6         ', NULL, 0, NULL, CAST(N'2017-08-29 08:09:31.550' AS DateTime), CAST(N'2017-08-29 08:09:31.550' AS DateTime), NULL, NULL, 7)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3016, N'CN0039', N'Báo cáo - Thống kê', N'Báo cáo - Thống kê', N'V,N,D,M,VR,VB,VA', NULL, 5, 6, NULL, N'fa fa-pie-chart', 0, NULL, CAST(N'2017-08-29 08:09:31.550' AS DateTime), CAST(N'2017-08-29 08:09:31.550' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3017, N'CN0040', N'Chốt số liệu năm', N'Chốt số liệu năm', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/chotsolieunam/list', 19, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-10-10 11:45:22.710' AS DateTime), CAST(N'2017-10-10 11:45:22.710' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3018, N'CN0041', N'Duyệt báo cáo', N'Duyệt báo cáo', N'V,A,VR,VB,VA', N'/QLTSMAIN/duyetbaocao/list', 3, NULL, N'5         ', NULL, 0, NULL, CAST(N'2017-09-13 10:47:40.643' AS DateTime), CAST(N'2017-09-13 10:47:40.643' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (3019, N'CN0042', N'Báo cáo kê khai', N'Báo cáo kê khai', N'V,VR,VB,VA', N'/QLTSMAIN/baocaokekhai/', 3, NULL, N'6         ', NULL, 0, NULL, CAST(N'2017-09-13 10:47:40.643' AS DateTime), CAST(N'2017-09-13 10:47:40.643' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4016, N'CN0043', N'Giấy báo hỏng', N'Giấy báo hỏng', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/giaybaohong/list', 8, NULL, N'4         ', NULL, 0, NULL, CAST(N'2017-10-18 09:18:13.940' AS DateTime), CAST(N'2017-10-18 09:18:13.940' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4017, N'CN0044', N'Phiếu nhập kho', N'Phiếu nhập kho', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/khophieunhap/list', 2, NULL, N'3         ', NULL, 0, NULL, CAST(N'2017-10-19 11:19:09.920' AS DateTime), CAST(N'2017-10-19 11:19:09.920' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4018, N'CN0045', N'Khai báo tồn đầu', N'Khai báo tồn đầu', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/khotonkho/list', 3, NULL, N'3         ', NULL, 0, NULL, CAST(N'2017-10-19 11:19:09.920' AS DateTime), CAST(N'2017-10-19 11:19:09.920' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4019, N'CN0046', N'Phiêu xuất kho', N'Phiêu xuất kho', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/khophieuxuat/list', 3, NULL, N'3         ', NULL, 0, NULL, CAST(N'2017-10-19 11:19:09.920' AS DateTime), CAST(N'2017-10-19 11:19:09.920' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (4020, N'CN0047', N'Báo cáo nhập xuất tồn', N'Báo cáo nhập xuất tồn', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/baocaonhapxuatton/list', 6, NULL, N'6         ', NULL, 0, NULL, CAST(N'2017-10-24 08:39:11.877' AS DateTime), CAST(N'2017-10-24 08:39:11.877' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[ChucNang] ([ChucNangId], [MaChucNang], [TenChucNang], [MoTa], [DSQuyen], [DuongDan], [ThuTu], [SuperLevel], [MidLevel], [Icon], [KhoaYN], [TenChucNangRex], [NgayTaoDT], [NgaySuaDT], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (5016, N'CN0048', N'Chốt số liệu tháng', N'Chốt số liệu tháng', N'V,N,D,M,VR,VB,VA', N'/QLTSMAIN/chotsolieuthang/list', 5, NULL, N'3         ', NULL, 0, NULL, CAST(N'2017-10-27 14:49:35.793' AS DateTime), CAST(N'2017-10-27 14:49:35.793' AS DateTime), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[ChucNang] OFF
INSERT [dbo].[Client] ([ClientId], [Base64Secret], [Name], [ApplicationType], [ActiveYN], [RefreshTokenLifeTime], [AllowedOrigin], [Description], [CtrVersion]) VALUES (N'33ecac27c905425eb81595dc0d54684d', N't9mT2uuQvXREm5KW42W_6mZVCUwjWBjWZyNtAqoDlJ4', N'web api', 1, 1, 60, N'*', N'abc', 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1003, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1005, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1006, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1007, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1008, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1009, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1010, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1012, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1003, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1005, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1006, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1007, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1008, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1009, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1010, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1012, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 2, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 3, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 4, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 5, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 6, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 7, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1003, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1005, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1006, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1007, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1008, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1009, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1010, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1012, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2056, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2057, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2058, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2059, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2056, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2057, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2058, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2059, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2060, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2061, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2062, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2062, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2063, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2064, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2065, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2066, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2067, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2068, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2069, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2070, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2071, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2072, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2073, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2076, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2075, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 2074, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2070, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2071, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2072, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2076, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2075, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2074, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2073, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 2056, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 2057, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 2058, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 2059, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 2060, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 2061, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 2062, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 2063, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 2064, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3054, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1030, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1032, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1033, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1034, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1035, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1036, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1037, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1038, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1039, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1040, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1041, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1042, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 1043, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2006, 2055, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1030, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1032, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3073, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3074, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3075, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3076, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3077, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3078, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3079, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3080, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3081, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3082, 0)
GO
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3083, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3084, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3085, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3086, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3087, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3088, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3089, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3090, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3091, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3092, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3093, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3094, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3095, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 1003, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 1005, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 1006, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 1007, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 1008, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 1009, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 1010, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2004, 1012, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2060, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2061, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1030, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1032, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1033, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1034, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1035, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1036, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1037, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1038, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1039, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1040, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1041, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1042, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 1043, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 2055, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1033, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1034, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1035, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1036, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1037, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1038, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1039, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1040, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1041, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1042, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 1043, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 2055, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3056, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3057, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3060, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3058, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3059, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3062, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3063, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3064, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3065, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (11, 3061, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3066, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3067, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3068, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3069, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3070, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 3072, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1030, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1032, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1033, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1034, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1035, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1036, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1037, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1038, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1039, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1040, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1041, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1042, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 1043, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (3, 2055, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 2056, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 2057, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 2060, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 2061, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 2062, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 2063, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 2064, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 2058, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (2005, 2059, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1030, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1032, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1033, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1034, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1035, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1036, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1037, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1038, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1039, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1040, 0)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1041, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1042, 1)
GO
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 1043, 1)
INSERT [dbo].[FormCotTheoNguoiDung] ([NguoiDungId], [CauHinhFormCotId], [HienThiYN]) VALUES (10, 2055, 0)
SET IDENTITY_INSERT [dbo].[NguoiDung] ON 

INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3, N'ND0016', N'ngoctan@ehis.vn', 0, N'89aa1e580023722db67646e8149eb246c748e180e34a1cf679ab0b41a416d904', N'123456', N'2', 0, 0, CAST(N'2017-05-11 11:41:15.080' AS DateTime), 0, 0, N'Tân Nguyễn', 1, N'Tân Nguyễn', 3, 1, N'Hung', NULL, 9)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (9, N'songan', N'songan@ehis.vn', 0, N'89aa1e580023722db67646e8149eb246c748e180e34a1cf679ab0b41a416d904', NULL, NULL, 0, 0, NULL, 0, 0, N'songan@ehis.vn', 7, N'songan', 4, 1, N'3', CAST(N'2017-08-23 15:50:26.830' AS DateTime), 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (10, N'ND0018', N'tiendat@ehis.vn', 0, N'f6e0a1e2ac41945a9aa7ff8a8aaa0cebc12a3bcc981a929ad5cf810a090e11ae', NULL, NULL, 0, 0, NULL, 0, 0, N'tiendat@ehis.vn', 1, N'Nguyễn Tiến Đạt', 7, 1, N'3', CAST(N'2017-08-28 09:53:07.573' AS DateTime), 2)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (11, N'ND001', N'thanhbinh@ehis.vn', 0, N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, 0, 0, NULL, 0, 0, N'thanhbinh@ehis.vn', 1, N'Nguyễn Thanh Bình', 6, 1, N'3', CAST(N'2017-08-28 09:52:08.823' AS DateTime), 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1004, N'KHTH', N'huythanh@ehis.vn', 0, N'89aa1e580023722db67646e8149eb246c748e180e34a1cf679ab0b41a416d904', NULL, NULL, 0, 0, NULL, 0, 0, N'huythanh@ehis.vn', 1002, N'Phòng kế hoạc tỏng hợp', 5, 1, N'3', CAST(N'2017-09-16 10:57:28.927' AS DateTime), 1)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2004, N'ND001', N'syt@dienbien.vn', 0, N'89aa1e580023722db67646e8149eb246c748e180e34a1cf679ab0b41a416d904', N'123456', N'2', 0, 0, CAST(N'2017-05-11 11:41:15.080' AS DateTime), 0, 0, N'Sở Y tế', 2002, N'Sở Y tế', 10, 16, N'Hung', NULL, 13)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2005, N'ND002', N'dienbienphu@dienbien.vn', 0, N'89aa1e580023722db67646e8149eb246c748e180e34a1cf679ab0b41a416d904', NULL, NULL, 0, 0, NULL, 0, 0, N'dienbienphu@dienbien.vn', 2003, N'BV Điện Biên Phủ', 8, 17, N'3', CAST(N'2017-09-29 08:49:41.613' AS DateTime), 2)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2006, N'NV001', N'quoctoan@dienbien.vn', 0, N'89aa1e580023722db67646e8149eb246c748e180e34a1cf679ab0b41a416d904', NULL, NULL, 0, 0, NULL, 0, 0, N'quoctoan@dienbien.vn', 2004, N'Phan Quốc Toản', 8, 17, N'3', CAST(N'2017-09-29 09:20:48.323' AS DateTime), 2)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2007, N'NV002', N'hoanghuyen@dienbien.vn', 0, N'89aa1e580023722db67646e8149eb246c748e180e34a1cf679ab0b41a416d904', NULL, NULL, 0, 0, NULL, 0, 0, N'hoanghuyen@dienbien.vn', 2004, N'Hoàng huyền', 9, 17, N'3', CAST(N'2017-09-29 09:29:47.190' AS DateTime), 3)
INSERT [dbo].[NguoiDung] ([NguoiDungId], [MaNguoiDung], [Email], [EmailDaXacNhanYN], [PasswordHash], [SecurityStamp], [DienThoai], [DienThoaiDaXacNhanYN], [BaoMatHaiLopYN], [KhoaDen], [KhoaYN], [LanDangNhapSai], [UserName], [VaiTroId], [HoTen], [NhanVienId], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2008, N'ND003', N'tuangiao@dienbien.vn', 0, N'89aa1e580023722db67646e8149eb246c748e180e34a1cf679ab0b41a416d904', NULL, NULL, 0, 0, NULL, 0, 0, N'tuangiao@dienbien.vn', 2003, N'BV Tuần Giáo', 3, 18, N'3', CAST(N'2017-09-29 08:49:41.613' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[NguoiDung] OFF
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 4, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 5, N'V,N,D,M,VR,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1004, N'V,N,D,M,VR,VB,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1005, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1006, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1007, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1008, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1009, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1010, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1011, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1012, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1013, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1014, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1015, N'V,N,D,M,View All')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1017, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1018, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1020, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 1021, N'V,N,D,M,VR,VB,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2004, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2005, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2006, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2007, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2008, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2009, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2010, N'V,A,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2011, N'V,A,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2012, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 2014, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3009, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3010, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3011, N'V,N,D,M,VR,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3012, N'V,N,D,M,VR,VB,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3015, N'V,N,D,M,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3017, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3018, N'V,A,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 3019, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 4016, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 4017, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 4018, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 4019, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 4020, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1, 5016, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (7, 2, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (7, 1004, N'V')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (7, 1007, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (7, 1013, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (7, 1017, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1002, 1018, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1002, 1020, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1002, 1021, N'N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1002, 2005, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (1002, 2007, N'V,N,D,M')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 2, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 3, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 4, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 5, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1004, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1005, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1006, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1007, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1008, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1009, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1010, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1012, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1013, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1017, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1018, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1020, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 1021, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 2004, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 2005, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 2006, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 2007, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 2008, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 2009, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 2010, N'V,A,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 2011, N'V,A,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 2012, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 2014, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 3009, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 3010, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 3011, N'V,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 3012, N'V,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 3015, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 3017, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 3018, N'V,A,VA')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2002, 3019, N'V,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 2, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 3, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 4, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 5, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1004, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1005, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1006, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1007, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1008, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1009, N'V,N,D,M,VB')
GO
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1010, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1011, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1012, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1013, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1017, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1018, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1020, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 1021, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 2004, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 2005, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 2006, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 2007, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 2008, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 2009, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 2010, N'V,A,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 2011, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 2012, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 2014, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 3009, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 3010, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 3011, N'V,VR,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 3012, N'V,VR,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 3015, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 3017, N'V,N,D,M,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 3018, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2003, 3019, N'V,VR,VB')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 1018, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 1020, NULL)
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 2004, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 2005, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 2006, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 2007, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 2008, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 2009, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 2012, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 2014, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 3009, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 3010, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 3012, N'V,N,D,M,VR')
INSERT [dbo].[QuyenTacVu] ([VaiTroId], [ChucNangId], [DSQuyenTacVu]) VALUES (2004, 3015, N'V,N,D,M,VR')
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [CoSoId], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1, N'AdminHeThong', N'Quản trị hệ thống', N'Quản trị hệ thống', 0, NULL, CAST(N'2017-01-01 00:00:00.000' AS DateTime), CAST(N'2017-06-17 10:47:29.027' AS DateTime), 16, N'hung', N'hung', 2)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [CoSoId], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (7, N'Admin', N'Admin', N'Quản trị', 0, NULL, CAST(N'2017-08-23 15:44:15.820' AS DateTime), CAST(N'2017-08-23 15:44:15.820' AS DateTime), 16, NULL, NULL, 0)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [CoSoId], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (1002, N'KHTH', N'Kê hoach tog hợp', NULL, 0, NULL, CAST(N'2017-09-16 10:56:50.310' AS DateTime), CAST(N'2017-09-16 10:56:50.310' AS DateTime), 16, NULL, NULL, 0)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [CoSoId], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2002, N'SOYT', N'Sở y tế', NULL, 0, NULL, CAST(N'2017-09-29 08:36:10.247' AS DateTime), CAST(N'2017-09-29 08:36:10.247' AS DateTime), 16, NULL, NULL, 0)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [CoSoId], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2003, N'BV01', N'BV Điện Biên Phủ', NULL, 0, NULL, CAST(N'2017-09-29 08:48:22.913' AS DateTime), CAST(N'2017-09-29 08:48:22.913' AS DateTime), 16, NULL, NULL, 0)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [CoSoId], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2004, N'KHOA1', N'Khoa Phòng', NULL, 0, NULL, CAST(N'2017-09-29 09:08:49.593' AS DateTime), CAST(N'2017-09-29 09:31:02.523' AS DateTime), 16, NULL, NULL, 1)
INSERT [dbo].[VaiTro] ([VaiTroId], [MaVaiTro], [TenVaiTro], [MoTa], [KhoaYN], [TenVaiTroRex], [NgayTaoDT], [NgaySuaDT], [CoSoId], [NguoiTao], [NguoiSua], [CtrVersion]) VALUES (2005, N'PKTHANHTRUONG', N'ADMIN THANH TRƯỜNG', NULL, 0, NULL, CAST(N'2017-10-18 14:47:16.707' AS DateTime), CAST(N'2017-10-18 14:47:16.717' AS DateTime), 19, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
ALTER TABLE [dbo].[RefreshToken] ADD  CONSTRAINT [DF_RefreshToken_IssuedUtc]  DEFAULT (getdate()) FOR [IssuedUtc]
GO
ALTER TABLE [dbo].[RefreshToken] ADD  CONSTRAINT [DF_RefreshToken_ExpiresUtc]  DEFAULT (getdate()) FOR [ExpiresUtc]
GO
ALTER TABLE [dbo].[RefreshToken] ADD  CONSTRAINT [DF_RefreshToken_CtrVersion]  DEFAULT ((0)) FOR [CtrVersion]
GO
ALTER TABLE [dbo].[FormCotTheoNguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_FormCotTheoNguoiDung_CauHinhFormCot] FOREIGN KEY([CauHinhFormCotId])
REFERENCES [dbo].[CauHinhFormCot] ([CauHinhFormCotId])
GO
ALTER TABLE [dbo].[FormCotTheoNguoiDung] CHECK CONSTRAINT [FK_FormCotTheoNguoiDung_CauHinhFormCot]
GO
ALTER TABLE [dbo].[FormCotTheoNguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_FormCotTheoNguoiDung_NguoiDung] FOREIGN KEY([NguoiDungId])
REFERENCES [dbo].[NguoiDung] ([NguoiDungId])
GO
ALTER TABLE [dbo].[FormCotTheoNguoiDung] CHECK CONSTRAINT [FK_FormCotTheoNguoiDung_NguoiDung]
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
/****** Object:  StoredProcedure [dbo].[csp_LayDanhSach_QuyenTacVuBangVaiTroId]    Script Date: 10/27/2017 3:01:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Helper_CreatePocoFromTableName]    Script Date: 10/27/2017 3:01:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_CauHinhFormCot_GetInfoByMaForm]    Script Date: 10/27/2017 3:01:15 PM ******/
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

					exec [QLTS_MAIN].dbo.[sp_CauHinhFormCot_GetInfoByMaForm]
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
/****** Object:  StoredProcedure [dbo].[sp_CauHinhFormCot_GetListCauHinhFormCotByCriteria]    Script Date: 10/27/2017 3:01:15 PM ******/
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
	, @USER_ID			varchar(10)			=	NULL		-- Mã Form
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
--
--SELECT COUNT(*) OVER () AS MAXCNT, ' + @FIELD + '

	SET @V_SQL = '
	SELECT COUNT(*) OVER () AS MAXCNT, 
		ISNULL(FND.CauHinhFormCotId, FC.CauHinhFormCotId) CauHinhFormCotId,
		ISNULL(FND.HienThiYN, FC.HienThiYN)	HienThiYN, 
		MaForm, MaCot, TenCot, TenCotMacDinh, ThuTu, CtrVersion
	FROM CauHinhFormCot FC WITH(NOLOCK, READUNCOMMITTED)
	LEFT JOIN dbo.FormCotTheoNguoiDung FND ON FND.CauHinhFormCotId = FC.CauHinhFormCotId AND FND.NguoiDungId = ''' +  + @USER_ID + ''''

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
/****** Object:  StoredProcedure [dbo].[sp_FormCotTheoNguoiDung_UpdateCauHinhFormCot]    Script Date: 10/27/2017 3:01:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************  

*************************************************************/

CREATE PROC [dbo].[sp_FormCotTheoNguoiDung_UpdateCauHinhFormCot]
( 
	@UserId INT,
	@HienThiYN BIT,
	@CauHinhFormCotId INT
)
AS  
BEGIN
------------------------------------------------  

	IF EXISTS(SELECT 1 FROM dbo.FormCotTheoNguoiDung WHERE NguoiDungId = @UserId AND CauHinhFormCotId = @CauHinhFormCotId)
	BEGIN
		UPDATE dbo.FormCotTheoNguoiDung 
		SET HienThiYN = @HienThiYN 
		WHERE NguoiDungId = @UserId AND CauHinhFormCotId = @CauHinhFormCotId
	END
	ELSE
	BEGIN
		INSERT dbo.FormCotTheoNguoiDung( NguoiDungId ,CauHinhFormCotId ,HienThiYN)
		SELECT @UserId, @CauHinhFormCotId, @HienThiYN
	END

	SELECT @@ROWCOUNT ID

-----------------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Menu_GetListMenu]    Script Date: 10/27/2017 3:01:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Menu_GetListMenu]
( 
	@UserId			VarChar(6)					-- Level
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT	TenChucNang,DuongDan,ThuTu,Icon,SuperLevel,MidLevel FROM ChucNang
where ChucNangId in (
select a.ChucNangId from QuyenTacVu a inner join NguoiDung b on a.VaiTroId=b.VaiTroId 
where b.NguoiDungId= @UserId and a.DSQuyenTacVu like 'V%'
union 
select ChucNangId from ChucNang where SuperLevel in (select c.MidLevel from QuyenTacVu a inner join NguoiDung b on a.VaiTroId=b.VaiTroId inner join ChucNang c on a.ChucNangId=c.ChucNangId
where b.NguoiDungId= @UserId and a.DSQuyenTacVu like 'V%')
)
order by ThuTu,SuperLevel 

SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_GetListNguoiDungByCriteria]    Script Date: 10/27/2017 3:01:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************************************  
1. Create Date	: 
2. Creator		: 
3. Description	: Lấy danh sách Nghỉ phép theo điều kiện
4. Function		: QLTSMAIN/NguoiDung/List
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
	, @CoSoId				nvarchar(500)	= null
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
		exec QLTS_MAIN.dbo.[sp_CauHinhFormCot_GetInfoByMaForm]
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
  DECLARE @IS_VIEW varchar(10) = '0'
  	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = '',
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0002',
		@QUYEN=@IS_VIEW OUTPUT

		print(@IS_VIEW)
	---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT,a.NguoiDungId,a.CtrVersion, a.MaNguoiDung, a.Email, a.DienThoai,a.HoTen,b.TenNhanVien,c.TenVaiTro,Convert(varchar(10),CONVERT(date,a.NgayTao,106),103) AS NgayTao
	FROM NguoiDung a left join [QLTS].[DBO].NhanVien b on a.NhanVienId = b.NhanVienId 
	left join VaiTro c on c.VaiTroId=a.VaiTroId ';

	IF( @SEARCH_TUNGAY <> '' AND @SEARCH_DENNGAY <> '')
	BEGIN 
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' and a.NgayTao BETWEEN  ''' + @SEARCH_TUNGAY + ''' AND '''+ @SEARCH_DENNGAY + '  ''';
	END
	ELSE IF @SEARCH_TUNGAY <> ''
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + 'and  a.NgayTao >=  ''' + @SEARCH_TUNGAY + '  ''';
	END
	ELSE IF @SEARCH_DENNGAY <>''
	BEGIN 
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' and a.NgayTao <=  ''' + @SEARCH_DENNGAY + '  ''';
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
	


	-- Build Where clause	
	IF @V_WHERE_CLAUSE > ''
	SET @V_SQL = @V_SQL + ' WHERE ' + @V_WHERE_CLAUSE
					
	IF @IS_VIEW != 'VA' 
 BEGIN    
   SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';   
 END
	-- Build Order clause
	IF @ORDER_CLAUSE > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDER_CLAUSE;

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@SKIP AS nvarchar(20)) +' ROWS';

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@TAKE AS nvarchar(20)) +' ROWS ONLY';

---- Thực thi câu SQL
	print (@V_SQL)
	EXEC(@V_SQL);

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_GetListNguoiDungById]    Script Date: 10/27/2017 3:01:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************************************  
1. Create Date	: 
2. Creator		: 
3. Description	: Lấy danh sách Nghỉ phép theo điều kiện
4. Function		: QLTSMAIN/NguoiDung/List
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
	SELECT COUNT(*) OVER () AS MAXCNT,a.MaNguoiDung,a.NguoiDungId,a.HoTen,a.NhanVienId,a.Email,a.DienThoai,a.VaiTroId,b.TenNhanVien,b.MaNhanVien,c.TenVaiTro,a.CtrVersion
	FROM NguoiDung a left join [QLTS].[DBO].NhanVien b on a.NhanVienId = b.NhanVienId 
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
/****** Object:  StoredProcedure [dbo].[sp_PhanQuyen_GetListChucNang]    Script Date: 10/27/2017 3:01:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*************************************************************  
1. Create Date	: 2017.03.30
2. Creator		: Nguyen Ngoc Tan
3. Description	: Lấy Quyền tác vụ theo MaChucNang và MaVaiTro
4. Function		: QLTSMAIN/NghiPhep/List
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
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước



		SELECT 	a.ChucNangId,a.MaChucNang,a.TenChucNang,a.DSQuyen,Isnull(b.DSQuyenTacVu,'') as DSQuyenTacVu,a.SuperLevel,a.MidLevel,a.Icon 
		FROM ChucNang a 
		LEFT JOIN QuyenTacVu b on a.ChucNangId=b.ChucNangId AND b.VaiTroId = @VAITROID
		LEFT JOIN VaiTro c on b.VaiTroId=c.VaiTroId
		ORDER BY a.ThuTu


---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[sp_PhanQuyen_GetListQuyenTacVuBangVaiTroId]    Script Date: 10/27/2017 3:01:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************  
1. Create Date	: 2017.03.30
2. Creator		: Tran Quoc Hung
3. Description	: Lấy Quyền tác vụ theo MaChucNang và MaVaiTro
4. Function		: QLTSMAIN/NghiPhep/List
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
/****** Object:  StoredProcedure [dbo].[sp_PhanQuyen_GetQuyenTacVuByMaChucNangAndMaVaiTro]    Script Date: 10/27/2017 3:01:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************  
1. Create Date	: 2017.04.27
2. Creator		: Tran Quoc Hung
3. Description	: Lấy Quyền tác vụ theo MaChucNang và MaVaiTro
4. Function		: QLTSMAIN/NghiPhep/List
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
/****** Object:  StoredProcedure [dbo].[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]    Script Date: 10/27/2017 3:01:15 PM ******/
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
	  @NHAN_VIEN_ID			VARCHAR(50)	
	, @CO_SO_ID			VARCHAR(50)	
	, @CHUC_NANG		VARCHAR(20)	
	, @QUYEN			VARCHAR(20)='' OUTPUT
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------    
	declare @VA INT = (SELECT COUNT(*)  
	FROM [QLTS_MAIN].DBO.QuyenTacVu q
	JOIN [QLTS_MAIN].DBO.NguoiDung n ON n.VaiTroId=q.VaiTroId 
	JOIN [QLTS_MAIN].DBO.ChucNang c ON q.ChucNangId=c.ChucNangId 
	WHERE n.CoSoId=@CO_SO_ID AND n.NhanVienId= @NHAN_VIEN_ID  AND c.MaChucNang=@CHUC_NANG AND q.DSQuyenTacVu LIKE '%VA%')  
	IF(@VA > 0)
	BEGIN 
	SET @QUYEN = 'VA';
	END 
	ELSE 
	BEGIN 
	declare @VB INT = (SELECT COUNT(*)  
	FROM [QLTS_MAIN].DBO.QuyenTacVu q
	JOIN [QLTS_MAIN].DBO.NguoiDung n ON n.VaiTroId=q.VaiTroId 
	JOIN [QLTS_MAIN].DBO.ChucNang c ON q.ChucNangId=c.ChucNangId 
	WHERE n.CoSoId=@CO_SO_ID AND n.NhanVienId= @NHAN_VIEN_ID  AND c.MaChucNang=@CHUC_NANG AND q.DSQuyenTacVu LIKE '%VB%')  
	IF(@VB > 0)
	BEGIN
	SET @QUYEN = 'VB';
	END 
	ELSE 
	BEGIN
	 declare @VR INT = (SELECT COUNT(*)  
	FROM [QLTS_MAIN].DBO.QuyenTacVu q
	JOIN [QLTS_MAIN].DBO.NguoiDung n ON n.VaiTroId=q.VaiTroId 
	JOIN [QLTS_MAIN].DBO.ChucNang c ON q.ChucNangId=c.ChucNangId 
	WHERE n.CoSoId=@CO_SO_ID AND n.NhanVienId= @NHAN_VIEN_ID  AND c.MaChucNang=@CHUC_NANG AND q.DSQuyenTacVu LIKE '%VR%')  
	IF(@VR > 0)
	BEGIN
	SET @QUYEN = 'VR';
	END 
	ELSE
	BEGIN
	SET @QUYEN = 'VE';
	END
	END
	END
-----------------------------------------------------
SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_GetListVaiTroByCriteria]    Script Date: 10/27/2017 3:01:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.18
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_VaiTro_GetListVaiTroByCriteria]
						 @VAITROIDS			=	''
						,@MAVAITRO			=	''
						,@COSOIDS			=	''
						,@SEARCH			=	''
						,@ORDERCLAUSE		=	''
						,@NHANVIEN_ID		=	10
						,@COSO_ID			=	16
						,@SKIP				=	0
						,@TAKE				=	10
6. Precaution	:
7. History		:
				  2017.10.18 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_VaiTro_GetListVaiTroByCriteria]
		 @VAITROIDS			VARCHAR(MAX)	=	NULL
		,@MAVAITRO			VARCHAR(MAX)	=	NULL
		,@COSOIDS			VARCHAR(MAX)	=	NULL
		,@SEARCH			NVARCHAR(MAX)	=	NULL
		,@ORDERCLAUSE		VARCHAR(MAX)	=	NULL
		,@NHANVIEN_ID		INT				=	NULL
		,@COSO_ID			INT				=	NULL
		,@SKIP				INT				=	NULL
		,@TAKE				INT				=	NULL
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
---------- BIẾN NỘI BỘ
DECLARE  @V_SQL			NVARCHAR(MAX)	=	N''
		,@V_DELIMITER	VARCHAR(10)		=	'|'
		,@V_ISVIEW		VARCHAR(MAX)	=	'VB'
		,@V_VAITROID	INT				=	NULL
		,@V_SEARCH		NVARCHAR(MAX)	=	NULL
---------- SET DEFAULT
SET @COSO_ID = ISNULL(@COSO_ID, 0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID, 0)

SET @VAITROIDS = ISNULL(@VAITROIDS, '')
SET @MAVAITRO = ISNULL(@MAVAITRO, '')
SET @COSOIDS = ISNULL(@COSOIDS, '')
SET @SEARCH = ISNULL(@SEARCH, '')
SET @V_SEARCH = '%' + @SEARCH + '%'
SET @SKIP = ISNULL(@SKIP, 0)
SET @TAKE = ISNULL(@TAKE, 0)

SET @ORDERCLAUSE = ISNULL(@ORDERCLAUSE,'')
IF (@ORDERCLAUSE = '')
	SET @ORDERCLAUSE = ' MAXCNT ';

SELECT TOP 1 @V_VAITROID = VaiTroId FROM NguoiDung WHERE NhanVienId = @NHANVIEN_ID
SET @V_VAITROID = ISNULL(@V_VAITROID,0)

---------- BUILD QUERY
SET @V_SQL = N' 
	SELECT		 COUNT(VT.VaiTroId) OVER () AS MAXCNT
				,VT.*
	FROM		VaiTro VT
	WHERE		1=1
			AND (
				@V_VAITROID = 1
				OR	@V_ISVIEW IN (''VA'')
				OR (@V_ISVIEW IN (''VB'',''VR'') AND VT.CoSoId = @COSO_ID)
				OR (@V_ISVIEW IN (''VE'') AND VT.NguoiTao = @NHANVIEN_ID AND VT.CoSoId = @COSO_ID)
			)
			AND (@VAITROIDS = '''' OR CHARINDEX(@V_DELIMITER+CAST(VT.VaiTroId AS VARCHAR(10))+@V_DELIMITER,@V_DELIMITER+@VAITROIDS+@V_DELIMITER) > 0)
			AND (@COSOIDS = '''' OR CHARINDEX(@V_DELIMITER+CAST(VT.CoSoId AS VARCHAR(10))+@V_DELIMITER,@V_DELIMITER+@COSOIDS+@V_DELIMITER) > 0)
			AND (@MAVAITRO = '''' OR VT.MaVaiTro = @MAVAITRO)
			AND (
				@SEARCH = '''' OR VT.MaVaiTro LIKE @V_SEARCH
				OR @SEARCH = '''' OR VT.TenVaiTro LIKE @V_SEARCH
				OR @SEARCH = '''' OR VT.MoTa LIKE @V_SEARCH
			)
'
	IF @ORDERCLAUSE <> ''
		SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDERCLAUSE

	IF @ORDERCLAUSE <> '' AND @TAKE > 0
		SET @V_SQL = @V_SQL + ' OFFSET ' + CAST(@SKIP AS nvarchar(20)) + ' ROWS FETCH NEXT ' + CAST(@TAKE AS nvarchar(20)) + ' ROWS ONLY '

	print @V_SQL
	exec sp_executesql @V_SQL
		,N'
		 @VAITROIDS			VARCHAR(MAX)
		,@MAVAITRO			VARCHAR(MAX)
		,@COSOIDS			VARCHAR(MAX)
		,@V_ISVIEW			VARCHAR(MAX)
		,@SEARCH			NVARCHAR(MAX)
		,@NHANVIEN_ID		INT
		,@COSO_ID			INT
		,@V_VAITROID		INT
		,@V_SEARCH			NVARCHAR(MAX)
		,@V_DELIMITER		VARCHAR(MAX)
		'
		,@VAITROIDS			=	@VAITROIDS
		,@MAVAITRO			=	@MAVAITRO
		,@COSOIDS			=	@COSOIDS
		,@SEARCH			=	@SEARCH
		,@NHANVIEN_ID		=	@NHANVIEN_ID
		,@COSO_ID			=	@COSO_ID
		,@V_VAITROID		=	@V_VAITROID
		,@V_SEARCH			=	@V_SEARCH
		,@V_ISVIEW			=	@V_ISVIEW
		,@V_DELIMITER		=	@V_DELIMITER
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectAllByCriteria]    Script Date: 10/27/2017 3:01:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_VaiTro_SelectAllByCriteria]
@WhereClause varchar(500) = null
, @OrderClause varchar(500) = null
, @SkipClause varchar(50) = null
, @TakeClause varchar(50) = null
AS
-- selects all rows from the table according to search criteria
DECLARE @SQL VARCHAR(4000) 
SET @SQL = '
SELECT *
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
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectAllByCriteria_171018]    Script Date: 10/27/2017 3:01:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
-- Stored procedure generated by CodeTrigger
-- This script was generated on 3/26/2017 9:09:15 PM
------------------------------------------------------------
CREATE PROCEDURE [dbo].[sp_VaiTro_SelectAllByCriteria_171018]
@WhereClause varchar(500) = null
, @OrderClause varchar(500) = null
, @SkipClause varchar(50) = null
, @TakeClause varchar(50) = null
AS
-- selects all rows from the table according to search criteria
DECLARE @SQL VARCHAR(4000) 
SET @SQL = '
SELECT *
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
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_SelectOne]    Script Date: 10/27/2017 3:01:15 PM ******/
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
SELECT *
FROM [dbo].[VaiTro]
WHERE 
[VaiTroId] = @VaiTroId







GO
USE [master]
GO
ALTER DATABASE [QLTS_MAIN] SET  READ_WRITE 
GO
