USE [master]
GO
/****** Object:  Database [QLTS]    Script Date: 11/3/2017 3:35:51 PM ******/
CREATE DATABASE [QLTS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLTS', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QLTS.mdf' , SIZE = 9216KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QLTS_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QLTS_log.ldf' , SIZE = 92864KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QLTS] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLTS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLTS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLTS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLTS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLTS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLTS] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLTS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLTS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLTS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLTS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLTS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLTS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLTS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLTS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLTS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLTS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLTS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLTS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLTS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLTS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLTS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLTS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLTS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLTS] SET RECOVERY FULL 
GO
ALTER DATABASE [QLTS] SET  MULTI_USER 
GO
ALTER DATABASE [QLTS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLTS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLTS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLTS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QLTS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLTS', N'ON'
GO
USE [QLTS]
GO
/****** Object:  UserDefinedTableType [dbo].[KhoPhieuXuatChiTietTableType]    Script Date: 11/3/2017 3:35:51 PM ******/
CREATE TYPE [dbo].[KhoPhieuXuatChiTietTableType] AS TABLE(
	[KhoPhieuXuatChiTietId] [int] NULL,
	[KhoPhieuXuatId] [int] NULL,
	[TaiSanId] [int] NULL,
	[SoLuong] [numeric](18, 4) NULL,
	[DonGia] [numeric](18, 4) NULL,
	[GiaMua] [numeric](18, 4) NULL,
	[GiaBan] [numeric](18, 4) NULL,
	[NguonNganSachId] [int] NULL,
	[NhaCungCapId] [int] NULL,
	[HanDung] [varchar](10) NULL,
	[LoSanXuat] [varchar](10) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[MyTableType_BanKiemKe]    Script Date: 11/3/2017 3:35:52 PM ******/
CREATE TYPE [dbo].[MyTableType_BanKiemKe] AS TABLE(
	[BienBanKiemKeId] [int] NULL,
	[NguoiKiemKe] [nvarchar](100) NULL,
	[ChucVu] [nvarchar](100) NULL,
	[DaiDien] [nvarchar](100) NULL,
	[VaiTro] [nvarchar](100) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[MyTableType_BienBanKiemKeChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
CREATE TYPE [dbo].[MyTableType_BienBanKiemKeChiTiet] AS TABLE(
	[BienBanKiemKeId] [int] NULL,
	[TaiSanId] [int] NULL,
	[SoLuong] [numeric](18, 0) NULL,
	[SoLuongKiemKe] [numeric](18, 0) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[MyTableType_KhoPhieuNhapChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
CREATE TYPE [dbo].[MyTableType_KhoPhieuNhapChiTiet] AS TABLE(
	[KhoPhieuNhapId] [int] NULL,
	[TaiSanId] [int] NULL,
	[SoLuong] [numeric](18, 4) NULL,
	[DonGia] [numeric](18, 4) NULL,
	[GiaMua] [numeric](18, 4) NULL,
	[GiaBan] [numeric](18, 4) NULL,
	[VAT] [numeric](4, 2) NULL,
	[HanDung] [varchar](10) NULL,
	[LoSanXuat] [varchar](10) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[NguyenGiaType]    Script Date: 11/3/2017 3:35:52 PM ******/
CREATE TYPE [dbo].[NguyenGiaType] AS TABLE(
	[TaiSanId] [int] NULL,
	[NguonNganSachId] [int] NULL,
	[GiaTri] [numeric](18, 4) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[abc]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[abc](@StartHour tinyint, @DaysBack int = 0, @TS datetime)
returns datetime as
   begin
      declare @tijdstip datetime

      set @ts = coalesce(@ts, CURRENT_TIMESTAMP)

      if @StartHour > datepart(hour, @ts)
         select @tijdstip = dateadd(day, @DaysBack -1 , dateadd(hour, @StartHour , dateadd(day, 0, datediff(day, 0, @ts))))
      else
         select @tijdstip = dateadd(day, @DaysBack , dateadd(hour, @StartHour , dateadd(day, 0, datediff(day, 0, @ts))))

      return (@tijdstip)
   end

GO
/****** Object:  UserDefinedFunction [dbo].[abc2]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[abc2](@StartHour time, @DaysBack int = 0, @TS datetime)
returns datetime as
   begin
      declare @tijdstip datetime

      set @ts = coalesce(@ts, CURRENT_TIMESTAMP)

      if @StartHour > cast(@ts as time)
         select @tijdstip = dateadd(day, @DaysBack -1 , dateadd(minute, datepart(minute, @StartHour), dateadd(hour, datepart(hour, @StartHour) , dateadd(day, 0, datediff(day, 0, @ts)))))
      else
         select @tijdstip = dateadd(day, @DaysBack, dateadd(minute, datepart(minute, @StartHour), dateadd(hour, datepart(hour, @StartHour) , dateadd(day, 0, datediff(day, 0, @ts)))))

      return (@tijdstip)
   end

GO
/****** Object:  UserDefinedFunction [dbo].[Num2Text]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Num2Text](@Number int)
RETURNS nvarchar(4000) AS
BEGIN
 
	DECLARE @sNumber nvarchar(4000)
	DECLARE @Return nvarchar(4000)
	DECLARE @mLen int
	DECLARE @i int
 
	DECLARE @mDigit int
	DECLARE @mGroup int
	DECLARE @mTemp nvarchar(4000)
	DECLARE @mNumText nvarchar(4000)
 
	SELECT @sNumber=LTRIM(STR(@Number))
	SELECT @mLen = Len(@sNumber)
 
	SELECT @i=1
	SELECT @mTemp=''
 
	WHILE @i <= @mLen
	BEGIN
 
		SELECT @mDigit=SUBSTRING(@sNumber, @i, 1)
 
		IF @mDigit=0 SELECT @mNumText=N'không'
		ELSE
		BEGIN
			IF @mDigit=1 SELECT @mNumText=N'một'
			ELSE
			IF @mDigit=2 SELECT @mNumText=N'hai'
			ELSE
			IF @mDigit=3 SELECT @mNumText=N'ba'
			ELSE
			IF @mDigit=4 SELECT @mNumText=N'bốn'
			ELSE
			IF @mDigit=5 SELECT @mNumText=N'năm'
			ELSE
			IF @mDigit=6 SELECT @mNumText=N'sáu'
			ELSE
			IF @mDigit=7 SELECT @mNumText=N'bảy'
			ELSE
			IF @mDigit=8 SELECT @mNumText=N'tám'
			ELSE
			IF @mDigit=9 SELECT @mNumText=N'chín'
		END
 
		SELECT @mTemp = @mTemp + ' ' + @mNumText
 
		IF (@mLen = @i) BREAK
 
		Select @mGroup=(@mLen - @i) % 9
 
		IF @mGroup=0
		BEGIN
			SELECT @mTemp = @mTemp + N' tỷ'
 
			If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
			SELECT @i = @i + 3
 
			If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
			SELECT @i = @i + 3
 
			If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
			SELECT @i = @i + 3
		END
		ELSE
		IF @mGroup=6
		BEGIN
			SELECT @mTemp = @mTemp + N' triệu'
 
			If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
			SELECT @i = @i + 3
 
			If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
			SELECT @i = @i + 3
		END
		ELSE
		IF @mGroup=3
		BEGIN
			SELECT @mTemp = @mTemp + N' nghìn'
 
			If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
			SELECT @i = @i + 3
 
		END
		ELSE
		BEGIN
 
			Select @mGroup=(@mLen - @i) % 3
 
			IF @mGroup=2    
			SELECT @mTemp = @mTemp + N' trăm'
			ELSE
			IF @mGroup=1
			SELECT @mTemp = @mTemp + N' mươi'  
		END
 
 
		SELECT @i=@i+1
	END
 
	--'Loại bỏ trường hợp x00
 
	SELECT @mTemp = Replace(@mTemp, N'không mươi không', '')
 
	--'Loại bỏ trường hợp 00x
 
	SELECT @mTemp = Replace(@mTemp, N'không mươi ', N'linh ')
 
	--'Loại bỏ trường hợp x0, x>=2
 
	SELECT @mTemp = Replace(@mTemp, N'mươi không', N'mươi')
 
	--'Fix trường hợp 10
 
	SELECT @mTemp = Replace(@mTemp, N'một mươi', N'mười')
 
	--'Fix trường hợp x4, x>=2
 
	SELECT @mTemp = Replace(@mTemp, N'mươi bốn', N'mươi tư')
 
	--'Fix trường hợp x04 
 
	SELECT @mTemp = Replace(@mTemp, N'linh bốn', N'linh tư')
 
	--'Fix trường hợp x5, x>=2
 
	SELECT @mTemp = Replace(@mTemp, N'mươi năm', N'mươi nhăm')
 
	--'Fix trường hợp x1, x>=2
 
	SELECT @mTemp = Replace(@mTemp, N'mươi một', N'mươi mốt')
 
	--'Fix trường hợp x15
 
	SELECT @mTemp = Replace(@mTemp, N'mười năm', N'mười lăm')
 
	--'Bỏ ký tự space
 
	SELECT @mTemp = LTrim(@mTemp)
 
	--'Ucase ký tự đầu tiên
 
	SELECT @Return=UPPER(Left(@mTemp, 1)) + SUBSTRING(@mTemp,2, 4000)
 
	RETURN @Return
END
GO
/****** Object:  Table [dbo].[BanKiemKe]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BanKiemKe](
	[BanKiemKeId] [int] IDENTITY(1,1) NOT NULL,
	[BienBanKiemKeId] [int] NOT NULL,
	[NguoiKiemKe] [nvarchar](100) NULL,
	[ChucVu] [nvarchar](100) NULL,
	[DaiDien] [nvarchar](100) NULL,
	[VaiTro] [nvarchar](100) NULL,
 CONSTRAINT [PK_BanKiemKe] PRIMARY KEY CLUSTERED 
(
	[BanKiemKeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BaoCao]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaoCao](
	[BaoCaoId] [int] NOT NULL,
	[TenBaoCao] [nvarchar](500) NOT NULL,
	[Report] [nvarchar](100) NULL,
	[CoSoId] [int] NULL,
 CONSTRAINT [PK_BaoCao] PRIMARY KEY CLUSTERED 
(
	[BaoCaoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BaoDuong]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaoDuong](
	[BaoDuongId] [int] IDENTITY(1,1) NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[PhongBanId] [int] NULL,
	[NhanVienId] [int] NULL,
	[NgayBaoDuong] [datetime] NULL,
	[NgayDuKien] [datetime] NOT NULL,
	[DuToan] [numeric](18, 4) NOT NULL,
	[LoaiBaoDuongId] [int] NOT NULL,
	[MoTa] [nvarchar](500) NULL,
	[DuyetId] [int] NULL,
	[NguoiDuyet] [int] NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_BaoDuong] PRIMARY KEY CLUSTERED 
(
	[BaoDuongId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BienBanKiemKe]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BienBanKiemKe](
	[BienBanKiemKeId] [int] IDENTITY(1,1) NOT NULL,
	[SoChungTu] [nchar](20) NOT NULL,
	[NgayChungTu] [datetime] NOT NULL,
	[NgayKiemKe] [datetime] NOT NULL,
	[PhongBanId] [int] NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_BienBanKiemKe] PRIMARY KEY CLUSTERED 
(
	[BienBanKiemKeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BienBanKiemKeChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BienBanKiemKeChiTiet](
	[BienBanKiemKeChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[BienBanKiemKeId] [int] NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[SoLuong] [numeric](18, 0) NOT NULL,
	[SoLuongKiemKe] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_BienBanKiemKeChiTiet] PRIMARY KEY CLUSTERED 
(
	[BienBanKiemKeChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BoTriSuDung]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BoTriSuDung](
	[BoTriSuDungId] [int] NOT NULL,
	[NoiDung] [nvarchar](50) NULL,
 CONSTRAINT [PK_SuDung] PRIMARY KEY CLUSTERED 
(
	[BoTriSuDungId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CoSo]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CoSo](
	[CoSoId] [int] IDENTITY(1,1) NOT NULL,
	[MaCoSo] [varchar](50) NOT NULL,
	[LoaiCoSoId] [int] NOT NULL,
	[TrucThuoc] [int] NULL,
	[TenCoSo] [nvarchar](200) NOT NULL,
	[DienThoai] [varchar](15) NULL,
	[DiaChi] [nvarchar](500) NULL,
	[GhiChu] [nvarchar](500) NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_CoSo] PRIMARY KEY CLUSTERED 
(
	[CoSoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DanhGia]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhGia](
	[DanhGiaId] [int] IDENTITY(1,1) NOT NULL,
	[SoChungTu] [nchar](20) NOT NULL,
	[NgayChungTu] [datetime] NOT NULL,
	[NgayDanhGia] [datetime] NOT NULL,
	[NoiDung] [nvarchar](500) NULL,
	[TaiSanId] [int] NOT NULL,
	[PhongBanId] [int] NOT NULL,
	[NhanVienId] [int] NOT NULL,
	[HaoMonLuyKeCu] [numeric](18, 4) NULL,
	[SoNamSuDungCu] [int] NULL,
	[TyLeHaoMonCu] [numeric](5, 2) NULL,
	[SLTonCu] [numeric](18, 4) NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
 CONSTRAINT [PK_DanhGia] PRIMARY KEY CLUSTERED 
(
	[DanhGiaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DanhGia_NguyenGia]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhGia_NguyenGia](
	[DanhGiaId] [int] NOT NULL,
	[NguonNganSachId] [int] NOT NULL,
	[GiaTriCu] [numeric](18, 4) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeNghiTrangCap]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeNghiTrangCap](
	[DeNghiId] [int] IDENTITY(1,1) NOT NULL,
	[Ngay] [datetime] NOT NULL,
	[SoPhieu] [nchar](20) NOT NULL,
	[PhanLoaiId] [int] NULL,
	[PhongBanId] [int] NULL,
	[NoiDung] [nvarchar](500) NULL,
	[CoSoId] [int] NULL,
	[DuyetId] [int] NULL,
	[GuiCapTren] [int] NULL,
	[NgayDuyet] [datetime] NULL,
	[NoiDungDuyet] [nvarchar](500) NULL,
	[NguoiDuyet] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_DeNghiTrangCap] PRIMARY KEY CLUSTERED 
(
	[DeNghiId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeNghiTrangCapChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeNghiTrangCapChiTiet](
	[DeNghiChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[DeNghiId] [int] NOT NULL,
	[TenTaiSan] [nvarchar](200) NOT NULL,
	[MoTa] [nvarchar](500) NULL,
	[LoaiId] [int] NOT NULL,
	[SoLuong] [numeric](4, 0) NOT NULL,
	[DonViTinh] [nvarchar](50) NOT NULL,
	[PhuongThucId] [int] NOT NULL,
	[NgayDeNghi] [datetime] NOT NULL,
	[DuToan] [numeric](18, 4) NULL,
	[DuToanDuocDuyet] [numeric](18, 4) NULL,
	[GhiChu] [nvarchar](500) NULL,
	[DuyetId] [int] NULL,
 CONSTRAINT [PK_DeNghiTrangCapChiTiet] PRIMARY KEY CLUSTERED 
(
	[DeNghiChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DieuChuyen]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DieuChuyen](
	[DieuChuyenId] [int] IDENTITY(1,1) NOT NULL,
	[SoChungTu] [varchar](50) NOT NULL,
	[NgayChungTu] [datetime] NOT NULL,
	[NgayDieuChuyen] [datetime] NOT NULL,
	[GhiChu] [nvarchar](1000) NULL,
	[DuyetId] [int] NULL,
	[NguoiDuyet] [int] NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_DieuChuyen] PRIMARY KEY CLUSTERED 
(
	[DieuChuyenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DieuChuyenChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DieuChuyenChiTiet](
	[DieuChuyenChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[DieuChuyenId] [int] NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[PhongBanSuDung] [int] NOT NULL,
	[NhanVienSuDung] [int] NOT NULL,
	[PhongBanChuyenDen] [int] NOT NULL,
	[NhanVienTiepNhan] [int] NOT NULL,
	[SoLuong] [numeric](18, 4) NOT NULL,
	[LyDo] [nvarchar](500) NULL,
 CONSTRAINT [PK_DieuChuyenChiTiet] PRIMARY KEY CLUSTERED 
(
	[DieuChuyenChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DuAn]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DuAn](
	[DuAnId] [int] IDENTITY(1,1) NOT NULL,
	[MaDuAn] [varchar](10) NOT NULL,
	[TenDuAn] [nvarchar](200) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[NgungTheoDoi] [int] NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_DuAn] PRIMARY KEY CLUSTERED 
(
	[DuAnId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Duyet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Duyet](
	[DuyetId] [int] NOT NULL,
	[TrangThai] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Duyet] PRIMARY KEY CLUSTERED 
(
	[DuyetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GhiGiam]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GhiGiam](
	[GhiGiamId] [int] IDENTITY(1,1) NOT NULL,
	[SoChungTu] [varchar](20) NOT NULL,
	[NgayChungTu] [datetime] NOT NULL,
	[NgayGhiGiam] [datetime] NOT NULL,
	[PhongBanId] [int] NOT NULL,
	[NoiDung] [nvarchar](500) NULL,
	[DuyetId] [int] NULL,
	[NguoiDuyet] [int] NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_GhiGiam] PRIMARY KEY CLUSTERED 
(
	[GhiGiamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GhiGiamChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GhiGiamChiTiet](
	[GhiGiamChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[GhiGiamId] [int] NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[PhongBanId] [int] NOT NULL,
	[NhanVienId] [int] NOT NULL,
	[XuLyId] [int] NOT NULL,
	[SoLuong] [numeric](18, 4) NOT NULL,
 CONSTRAINT [PK_GhiGiamChiTiet] PRIMARY KEY CLUSTERED 
(
	[GhiGiamChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GhiTang]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GhiTang](
	[GhiTangId] [int] IDENTITY(1,1) NOT NULL,
	[SoChungTu] [varchar](20) NOT NULL,
	[NgayChungTu] [datetime] NOT NULL,
	[NgayGhiTang] [datetime] NOT NULL,
	[NoiDung] [nvarchar](500) NULL,
	[DuyetId] [int] NULL,
	[NguoiDuyet] [int] NULL,
	[CoSoId] [int] NOT NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_GhiTang] PRIMARY KEY CLUSTERED 
(
	[GhiTangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GhiTangChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GhiTangChiTiet](
	[GhiTangChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[GhiTangId] [int] NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[NgayBatDauSuDung] [datetime] NOT NULL,
	[PhongBanId] [int] NOT NULL,
	[NhanVienId] [int] NOT NULL,
	[SoLuong] [numeric](18, 4) NOT NULL,
	[HopDongId] [int] NULL,
 CONSTRAINT [PK_GhiTangChiTiet] PRIMARY KEY CLUSTERED 
(
	[GhiTangChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GiayBaoHong]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GiayBaoHong](
	[GiayBaoHongId] [int] IDENTITY(1,1) NOT NULL,
	[SoChungTu] [varchar](50) NOT NULL,
	[Ngay] [datetime] NOT NULL,
	[PhongBanId] [int] NOT NULL,
	[NoiDung] [nvarchar](500) NULL,
	[CoSoId] [int] NOT NULL,
	[NguoiTao] [nchar](10) NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_GiayBaoHong] PRIMARY KEY CLUSTERED 
(
	[GiayBaoHongId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GiayBaoHongChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiayBaoHongChiTiet](
	[GiayBaoHongChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[GiayBaoHongId] [int] NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[PhongBanId] [int] NOT NULL,
	[NhanVienId] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[LyDo] [nvarchar](500) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
 CONSTRAINT [PK_GiayBaoHongChiTiet] PRIMARY KEY CLUSTERED 
(
	[GiayBaoHongChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HangSanXuat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HangSanXuat](
	[HangSanXuatId] [int] IDENTITY(1,1) NOT NULL,
	[MaHangSanXuat] [varchar](50) NOT NULL,
	[TenHangSanXuat] [nvarchar](100) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_HangSanXuat] PRIMARY KEY CLUSTERED 
(
	[HangSanXuatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HaoMon]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HaoMon](
	[HaoMonId] [int] IDENTITY(1,1) NOT NULL,
	[KyTinh] [nchar](10) NOT NULL,
	[SoChungTu] [nchar](20) NOT NULL,
	[NgayChungTu] [datetime] NOT NULL,
	[NgayHaoMon] [datetime] NOT NULL,
	[NoiDung] [nvarchar](500) NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_HaoMon] PRIMARY KEY CLUSTERED 
(
	[HaoMonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HaoMonChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HaoMonChiTiet](
	[HaoMonChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[HaoMonId] [int] NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[TyLeHaoMonCu] [numeric](2, 2) NOT NULL,
 CONSTRAINT [PK_HaoMonChiTiet] PRIMARY KEY CLUSTERED 
(
	[HaoMonChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HienTrangSuDung]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HienTrangSuDung](
	[HienTrangSuDungId] [int] NOT NULL,
	[NoiDung] [nvarchar](500) NULL,
 CONSTRAINT [PK_HienTrangSuDung] PRIMARY KEY CLUSTERED 
(
	[HienTrangSuDungId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HinhThuc]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HinhThuc](
	[HinhThucId] [int] NOT NULL,
	[TenHinhThuc] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_HinhThuc] PRIMARY KEY CLUSTERED 
(
	[HinhThucId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HopDong]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HopDong](
	[HopDongId] [int] IDENTITY(1,1) NOT NULL,
	[SoHopDong] [nvarchar](100) NOT NULL,
	[NgayHopDong] [datetime] NOT NULL,
	[TenNhaThau] [nvarchar](200) NULL,
	[DaiDien] [nvarchar](200) NULL,
	[GiaTriHopDong] [numeric](18, 4) NULL,
	[NoiDung] [nvarchar](1000) NULL,
	[FileDinhKem] [nvarchar](500) NULL,
	[CoSoId] [int] NOT NULL,
	[NgayTao] [datetime] NULL,
	[NguoiTao] [nvarchar](100) NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_HopDong] PRIMARY KEY CLUSTERED 
(
	[HopDongId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KeHoachMuaSam]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KeHoachMuaSam](
	[MuaSamId] [int] IDENTITY(1,1) NOT NULL,
	[Nam] [numeric](4, 0) NOT NULL,
	[NoiDung] [nvarchar](500) NULL,
	[DuyetId] [int] NULL,
	[NgayDuyet] [datetime] NULL,
	[NoiDungDuyet] [nvarchar](500) NULL,
	[NguoiDuyet] [int] NULL,
	[CoSoId] [int] NOT NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_KeHoachMuaSam] PRIMARY KEY CLUSTERED 
(
	[MuaSamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KeHoachMuaSamChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KeHoachMuaSamChiTiet](
	[MuaSamChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[MuaSamId] [int] NOT NULL,
	[TenTaiSan] [nvarchar](500) NOT NULL,
	[LoaiId] [int] NOT NULL,
	[PhuongThucId] [int] NOT NULL,
	[DonViTinh] [nvarchar](10) NOT NULL,
	[MoTa] [nvarchar](200) NULL,
	[Ngay] [datetime] NOT NULL,
	[SoLuong] [numeric](4, 0) NOT NULL,
	[DonGia] [numeric](18, 4) NOT NULL,
	[HinhThucId] [int] NOT NULL,
	[DuToan] [numeric](18, 4) NULL,
	[GhiChu] [nvarchar](500) NULL,
	[DuyetId] [int] NULL CONSTRAINT [DF_KeHoachMuaSamChiTiet_DuyetId]  DEFAULT ((0)),
 CONSTRAINT [PK_KeHoachMuaSamChiTiet] PRIMARY KEY CLUSTERED 
(
	[MuaSamChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhachHang](
	[KhachHangId] [int] IDENTITY(1,1) NOT NULL,
	[MaKhachHang] [varchar](10) NOT NULL,
	[TenKhachHang] [nvarchar](200) NOT NULL,
	[DienThoai] [varchar](15) NULL,
	[DiDong] [varchar](15) NULL,
	[MaSoThue] [varchar](25) NULL,
	[TKNganHang] [varchar](25) NULL,
	[TenNganHang] [nvarchar](200) NULL,
	[DiaChi] [nvarchar](500) NULL,
	[GhiChu] [nvarchar](500) NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_KhachHangNCC] PRIMARY KEY CLUSTERED 
(
	[KhachHangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhaiThac]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhaiThac](
	[KhaiThacId] [int] IDENTITY(1,1) NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[PhongBanId] [int] NULL,
	[NhanVienId] [int] NULL,
	[KhachHangNCCId] [int] NOT NULL,
	[SoChungTu] [varchar](50) NOT NULL,
	[SoLuongKhaiThac] [numeric](18, 0) NOT NULL,
	[DonGiaKhaiThac] [numeric](18, 4) NOT NULL,
	[ThoiGianBatDau] [datetime] NOT NULL,
	[ThoiGianKetThuc] [datetime] NOT NULL,
	[TienThu] [numeric](18, 4) NULL,
	[NopNganSach] [numeric](18, 4) NULL,
	[DonVi] [numeric](18, 4) NULL,
	[GhiChu] [nchar](10) NULL,
	[HopDongId] [int] NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_KhaiThac] PRIMARY KEY CLUSTERED 
(
	[KhaiThacId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhoaSoLieu]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhoaSoLieu](
	[KhoaSoLieuId] [int] IDENTITY(1,1) NOT NULL,
	[Nam] [nchar](4) NOT NULL,
	[TrangThai] [nchar](1) NOT NULL,
	[CoSoId] [int] NULL,
 CONSTRAINT [PK_KhoaSoLieu] PRIMARY KEY CLUSTERED 
(
	[KhoaSoLieuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhoaSoLieuThang]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhoaSoLieuThang](
	[KhoaSoLieuThangId] [int] IDENTITY(1,1) NOT NULL,
	[ThangNam] [int] NULL,
	[TrangThai] [int] NULL,
	[CoSoId] [int] NULL,
 CONSTRAINT [PK_KhoaSoLieuThang] PRIMARY KEY CLUSTERED 
(
	[KhoaSoLieuThangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhoPhieuNhap]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhoPhieuNhap](
	[KhoPhieuNhapId] [int] IDENTITY(1,1) NOT NULL,
	[KhoTaiSanId] [int] NOT NULL,
	[NguonNganSachId] [int] NOT NULL,
	[NhaCungCapId] [int] NOT NULL,
	[NgayNhap] [datetime] NOT NULL,
	[SoPhieu] [varchar](50) NOT NULL,
	[Seri] [varchar](50) NULL,
	[SoHoaDon] [varchar](50) NULL,
	[NgayHD] [datetime] NULL,
	[BBKiem] [varchar](50) NULL,
	[ChietKhau] [int] NULL,
	[NguoiGiao] [nvarchar](100) NULL,
	[Loai] [varchar](10) NULL,
	[TaiKhoanNo] [varchar](20) NULL,
	[TaiKhoanCo] [varchar](20) NULL,
	[NoiDung] [nvarchar](500) NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_KhoNhapKho] PRIMARY KEY CLUSTERED 
(
	[KhoPhieuNhapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhoPhieuNhapChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhoPhieuNhapChiTiet](
	[KhoPhieuNhapChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[KhoPhieuNhapId] [int] NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[SoLuong] [numeric](18, 4) NOT NULL,
	[DonGia] [numeric](18, 4) NOT NULL,
	[GiaMua] [numeric](18, 4) NULL,
	[GiaBan] [numeric](18, 4) NULL,
	[VAT] [numeric](4, 2) NULL,
	[HanDung] [varchar](10) NULL,
	[LoSanXuat] [varchar](10) NULL,
 CONSTRAINT [PK_KhoNhapKhoChiTiet] PRIMARY KEY CLUSTERED 
(
	[KhoPhieuNhapChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhoPhieuXuat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhoPhieuXuat](
	[KhoPhieuXuatId] [int] IDENTITY(1,1) NOT NULL,
	[SoPhieu] [varchar](20) NOT NULL,
	[NgayXuat] [datetime] NOT NULL,
	[Loai] [varchar](10) NOT NULL,
	[KhoXuatId] [int] NOT NULL,
	[KhoNhanId] [int] NULL,
	[NguoiNhanHang] [nvarchar](100) NULL,
	[LyDo] [nvarchar](500) NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_KhoPhieuXuat] PRIMARY KEY CLUSTERED 
(
	[KhoPhieuXuatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhoPhieuXuatChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhoPhieuXuatChiTiet](
	[KhoPhieuXuatChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[KhoPhieuXuatId] [int] NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[SoLuong] [numeric](18, 4) NULL,
	[DonGia] [numeric](18, 4) NULL,
	[GiaMua] [numeric](18, 4) NULL,
	[GiaBan] [numeric](18, 4) NULL,
	[NguonNganSachId] [int] NULL,
	[NhaCungCapId] [int] NULL,
	[HanDung] [varchar](10) NULL,
	[LoSanXuat] [varchar](10) NULL,
 CONSTRAINT [PK_KhoPhieuXuatChiTiet] PRIMARY KEY CLUSTERED 
(
	[KhoPhieuXuatChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhoTaiSan]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhoTaiSan](
	[KhoTaiSanId] [int] IDENTITY(1,1) NOT NULL,
	[CoSoId] [int] NOT NULL,
	[MaKhoTaiSan] [varchar](50) NOT NULL,
	[TenKhoTaiSan] [nvarchar](200) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_KhoTaiSan] PRIMARY KEY CLUSTERED 
(
	[KhoTaiSanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhoTonKho]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhoTonKho](
	[KhoTonKhoId] [int] IDENTITY(1,1) NOT NULL,
	[KhoTaiSanId] [int] NOT NULL,
	[CoSoId] [int] NOT NULL,
	[ThangNam] [varchar](4) NOT NULL,
	[TrangThai] [int] NOT NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_KhoTonKho] PRIMARY KEY CLUSTERED 
(
	[KhoTonKhoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhoTonKhoChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhoTonKhoChiTiet](
	[KhoTonKhoChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[KhoTonKhoId] [int] NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[DonGia] [numeric](18, 4) NOT NULL,
	[GiaMua] [numeric](18, 4) NULL,
	[GiaBan] [numeric](18, 4) NULL,
	[TonDau] [numeric](18, 4) NULL,
	[SLNhap] [numeric](18, 4) NULL,
	[SLXuat] [numeric](18, 4) NULL,
	[NguonNganSachId] [int] NULL,
	[NhaCungCapId] [int] NULL,
	[HanDung] [varchar](10) NULL,
	[LoSanXuat] [varchar](10) NULL,
 CONSTRAINT [PK_KhoTonKhoChiTiet] PRIMARY KEY CLUSTERED 
(
	[KhoTonKhoChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LapBaoCao]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LapBaoCao](
	[LapBaoCaoId] [int] IDENTITY(1,1) NOT NULL,
	[KyBaoCao] [varchar](50) NULL,
	[TuNgay] [datetime] NULL,
	[DenNgay] [datetime] NULL,
	[DienGiai] [nvarchar](1000) NULL,
	[CoSoId] [int] NULL,
	[DuyetId] [int] NULL,
	[GuiCapTren] [int] NULL,
	[NgayGui] [datetime] NULL,
	[NgayDuyet] [datetime] NULL,
	[NoiDungDuyet] [nvarchar](1000) NULL,
	[NguoiDuyet] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_LapBaoCao] PRIMARY KEY CLUSTERED 
(
	[LapBaoCaoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LapBaoCaoChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LapBaoCaoChiTiet](
	[LapBaoCaoChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[LapBaoCaoId] [int] NOT NULL,
	[BaoCaoId] [int] NOT NULL,
	[DuyetId] [int] NULL,
	[NgayDuyet] [datetime] NULL,
	[NoiDungDuyet] [nvarchar](1000) NULL,
 CONSTRAINT [PK_LapBaoCaoChiTiet] PRIMARY KEY CLUSTERED 
(
	[LapBaoCaoChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoaiCoSo]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiCoSo](
	[LoaiCoSoId] [int] IDENTITY(1,1) NOT NULL,
	[MaLoaiCoSo] [nchar](10) NOT NULL,
	[TenLoaiCoSo] [nvarchar](100) NOT NULL,
	[QuanHe] [nchar](100) NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_LoaiCoSo] PRIMARY KEY CLUSTERED 
(
	[LoaiCoSoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoaiTaiSan]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoaiTaiSan](
	[LoaiId] [int] IDENTITY(1,1) NOT NULL,
	[NhomId] [int] NOT NULL,
	[MaLoai] [varchar](50) NOT NULL,
	[TenLoai] [nvarchar](200) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_LoaiTaiSan] PRIMARY KEY CLUSTERED 
(
	[LoaiId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiXe]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiXe](
	[LoaiXeId] [int] NOT NULL,
	[NoiDung] [nvarchar](500) NULL,
 CONSTRAINT [PK_LoaiXe] PRIMARY KEY CLUSTERED 
(
	[LoaiXeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LogData]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogData](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[Ngay] [datetime] NULL,
	[MaChucNang] [varchar](50) NULL,
	[DoiTuongId] [int] NULL,
	[SuKien] [nvarchar](50) NULL,
	[NoiDung] [nvarchar](500) NULL,
	[NguoiTao] [int] NULL,
 CONSTRAINT [PK_Lock] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NguonNganSach]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NguonNganSach](
	[NguonNganSachId] [int] IDENTITY(1,1) NOT NULL,
	[MaNguonNganSach] [varchar](50) NOT NULL,
	[TenNguonNganSach] [nvarchar](200) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_NguonNganSach] PRIMARY KEY CLUSTERED 
(
	[NguonNganSachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NguyenGia]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguyenGia](
	[TaiSanId] [int] NOT NULL,
	[NguonNganSachId] [int] NOT NULL,
	[GiaTri] [numeric](18, 4) NULL,
 CONSTRAINT [PK_NguyenGia] PRIMARY KEY CLUSTERED 
(
	[TaiSanId] ASC,
	[NguonNganSachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[NhaCungCapId] [int] IDENTITY(1,1) NOT NULL,
	[MaNhaCungCap] [varchar](50) NOT NULL,
	[TenNhaCungCap] [nvarchar](200) NOT NULL,
	[Nhom] [varchar](3) NULL,
	[DienThoai] [varchar](15) NULL,
	[DiDong] [varchar](15) NULL,
	[MaSoThue] [varchar](25) NULL,
	[TKNganHang] [varchar](25) NULL,
	[TenNganHang] [nvarchar](100) NULL,
	[DaiDien] [nvarchar](100) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[GhiChu] [nvarchar](500) NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_NhaCungCap] PRIMARY KEY CLUSTERED 
(
	[NhaCungCapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NhanVien](
	[NhanVienId] [int] IDENTITY(1,1) NOT NULL,
	[MaNhanVien] [varchar](50) NOT NULL,
	[TenNhanVien] [nvarchar](200) NOT NULL,
	[ChucDanh] [nvarchar](200) NULL,
	[DienThoai] [varchar](15) NULL,
	[Email] [varchar](100) NULL,
	[DiaChi] [nvarchar](500) NULL,
	[GhiChu] [nvarchar](500) NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[NhanVienId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NhomTaiSan]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NhomTaiSan](
	[NhomId] [int] IDENTITY(1,1) NOT NULL,
	[MaNhom] [varchar](50) NOT NULL,
	[TenNhom] [nvarchar](200) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_NhomTaiSan] PRIMARY KEY CLUSTERED 
(
	[NhomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NuocSanXuat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NuocSanXuat](
	[NuocSanXuatId] [int] IDENTITY(1,1) NOT NULL,
	[MaNuocSanXuat] [varchar](50) NOT NULL,
	[TenNuocSanXuat] [nvarchar](200) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_NuocSanXuat] PRIMARY KEY CLUSTERED 
(
	[NuocSanXuatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PhanLoai]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhanLoai](
	[PhanLoaiId] [int] IDENTITY(1,1) NOT NULL,
	[TenPhanLoai] [nvarchar](50) NULL,
 CONSTRAINT [PK_PhanLoai] PRIMARY KEY CLUSTERED 
(
	[PhanLoaiId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhongBan]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PhongBan](
	[PhongBanId] [int] IDENTITY(1,1) NOT NULL,
	[CoSoId] [int] NOT NULL,
	[MaPhongBan] [varchar](50) NOT NULL,
	[TenPhongBan] [nvarchar](200) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_PhongBan] PRIMARY KEY CLUSTERED 
(
	[PhongBanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PhongBanNhanVien]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongBanNhanVien](
	[PhongBanId] [int] NOT NULL,
	[NhanVienId] [int] NOT NULL,
	[CoSoId] [int] NOT NULL,
 CONSTRAINT [PK_PhongBanNhanVien] PRIMARY KEY CLUSTERED 
(
	[PhongBanId] ASC,
	[NhanVienId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhuongThuc]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhuongThuc](
	[PhuongThucId] [int] NOT NULL,
	[TenPhuongThuc] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_PhuongThuc] PRIMARY KEY CLUSTERED 
(
	[PhuongThucId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SuaChua]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SuaChua](
	[SuaChuaId] [int] IDENTITY(1,1) NOT NULL,
	[BaoDuongId] [int] NOT NULL,
	[TenBoPhan] [nvarchar](100) NULL,
	[NgayBatDau] [datetime] NULL,
	[NgayKetThuc] [datetime] NULL,
	[ChiPhi] [numeric](18, 4) NULL,
	[NoiDung] [nvarchar](500) NULL,
	[NoiSua] [nvarchar](500) NULL,
	[KetQua] [nvarchar](500) NULL,
 CONSTRAINT [PK_SuaChua] PRIMARY KEY CLUSTERED 
(
	[SuaChuaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SuDung]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SuDung](
	[SuDungId] [int] IDENTITY(1,1) NOT NULL,
	[KyLap] [int] NOT NULL,
	[Nam] [numeric](4, 0) NOT NULL,
	[NoiDung] [nvarchar](500) NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_SuDung_1] PRIMARY KEY CLUSTERED 
(
	[SuDungId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SuDungChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SuDungChiTiet](
	[SuDungChiTietId] [int] IDENTITY(1,1) NOT NULL,
	[SuDungId] [int] NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[PhongBanId] [int] NULL,
	[NhanVienId] [int] NULL,
	[SoSanPhamPhucVu] [numeric](18, 4) NULL,
	[DonViTinhSanPham] [nvarchar](50) NULL,
	[SoNguyenLieuSuDung] [numeric](18, 4) NULL,
	[DonViTinhNguyenLieu] [nvarchar](50) NULL,
	[GhiChu] [nvarchar](500) NULL,
 CONSTRAINT [PK_SuDungChiTiet] PRIMARY KEY CLUSTERED 
(
	[SuDungChiTietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaiSan]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaiSan](
	[TaiSanId] [int] IDENTITY(1,1) NOT NULL,
	[MaTaiSan] [varchar](20) NOT NULL,
	[TenTaiSan] [nvarchar](200) NOT NULL,
	[DonViTinh] [nvarchar](100) NULL,
	[LoaiId] [int] NOT NULL,
	[PhuongThucId] [int] NULL,
	[NamSanXuat] [numeric](4, 0) NULL,
	[NuocSanXuatId] [int] NOT NULL,
	[HangSanXuatId] [int] NULL,
	[SoQDTC] [varchar](50) NULL,
	[NhanHieu] [nvarchar](100) NULL,
	[DuAnId] [int] NULL,
	[NgayMua] [datetime] NOT NULL,
	[NgayBDHaoMon] [datetime] NULL,
	[SoNamSuDung] [int] NULL,
	[TyLeHaoMon] [numeric](5, 2) NULL,
	[HaoMonLuyKe] [numeric](18, 4) NULL,
	[NgayBDKhauHao] [datetime] NULL,
	[KyTinhKhauHao] [nvarchar](10) NULL,
	[GiaTriKhauHao] [numeric](18, 4) NULL,
	[SoKyKhauHao] [numeric](5, 0) NULL,
	[TyLeKhauHao] [numeric](5, 2) NULL,
	[KhauHaoLuyKe] [numeric](18, 4) NULL,
	[LoaiKeKhai] [int] NOT NULL,
	[CoSoId] [int] NOT NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_TaiSan] PRIMARY KEY CLUSTERED 
(
	[TaiSanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ThayDoiThongTin]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiThongTin](
	[ThayDoiThongTinId] [int] IDENTITY(1,1) NOT NULL,
	[TaiSanId] [int] NOT NULL,
	[Ngay] [datetime] NOT NULL,
	[TenTaiSanCu] [nvarchar](200) NULL,
	[LyDo] [nvarchar](500) NULL,
	[DuyetId] [int] NULL,
	[NguoiDuyet] [int] NULL,
	[CoSoId] [int] NULL,
	[NguoiTao] [int] NULL,
	[NgayTao] [datetime] NULL,
	[CtrVersion] [int] NULL,
 CONSTRAINT [PK_ThayDoiThongTin] PRIMARY KEY CLUSTERED 
(
	[ThayDoiThongTinId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThayDoiThongTin_Dat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiThongTin_Dat](
	[ThayDoiThongTinId] [int] NOT NULL,
	[DiaChiCu] [nvarchar](500) NULL,
	[GiayToCu] [nvarchar](500) NULL,
	[DienTichCu] [numeric](18, 4) NULL,
	[LamTruSoCu] [numeric](18, 4) NULL,
	[CoSoHDSuNghiepCu] [numeric](18, 4) NULL,
	[NhaOCu] [numeric](18, 4) NULL,
	[ChoThueCu] [numeric](18, 4) NULL,
	[BoTrongCu] [numeric](18, 4) NULL,
	[BiLanChiemCu] [numeric](18, 4) NULL,
	[SuDungKhacCu] [numeric](18, 4) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThayDoiThongTin_Nha]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiThongTin_Nha](
	[ThayDoiThongTinId] [int] NOT NULL,
	[DiaChiCu] [nvarchar](500) NULL,
	[GiayToCu] [nvarchar](500) NULL,
	[CapHangCu] [int] NULL,
	[SoTangCu] [int] NULL,
	[NamSuDungCu] [numeric](4, 0) NULL,
	[DienTichCu] [numeric](18, 4) NULL,
	[TongDienTichSanCu] [numeric](18, 4) NULL,
	[LamTruSoCu] [numeric](18, 4) NULL,
	[CoSoHDSuNghiepCu] [numeric](18, 4) NULL,
	[NhaOCu] [numeric](18, 4) NULL,
	[ChoThueCu] [numeric](18, 4) NULL,
	[BoTrongCu] [numeric](18, 4) NULL,
	[BiLanChiemCu] [numeric](18, 4) NULL,
	[SuDungKhacCu] [numeric](18, 4) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThayDoiThongTin_Oto]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiThongTin_Oto](
	[ThayDoiThongTinId] [int] NOT NULL,
	[NhanHieuCu] [nvarchar](500) NULL,
	[BienKiemSoatCu] [nvarchar](20) NULL,
	[CongSuatXeCu] [numeric](8, 0) NULL,
	[TrongTaiCu] [numeric](8, 0) NULL,
	[ChucDanhCu] [nvarchar](100) NULL,
	[NguonGocXeCu] [nvarchar](500) NULL,
	[LoaiXeCu] [int] NULL,
	[HienTrangSuDungCu] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThayDoiThongTin_Tren500]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThayDoiThongTin_Tren500](
	[ThayDoiThongTinId] [int] NOT NULL,
	[KyHieuCu] [nvarchar](500) NULL,
	[HienTrangSuDungCu] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TheoDoi]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheoDoi](
	[TaiSanId] [int] NOT NULL,
	[NgayGhiTang] [datetime] NULL,
	[NgayTrangCap] [datetime] NULL,
	[NgayBatDauSuDung] [datetime] NULL,
	[PhongBanId] [int] NOT NULL,
	[NhanVienId] [int] NOT NULL,
	[SLTon] [numeric](18, 4) NULL,
	[SLTang] [numeric](18, 4) NULL,
	[SLGiam] [numeric](18, 4) NULL,
	[Nam] [numeric](4, 0) NOT NULL,
	[HopDongId] [int] NULL,
 CONSTRAINT [PK_TheoDoi] PRIMARY KEY CLUSTERED 
(
	[TaiSanId] ASC,
	[PhongBanId] ASC,
	[NhanVienId] ASC,
	[Nam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThongBao]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongBao](
	[ThongBaoId] [int] IDENTITY(1,1) NOT NULL,
	[TenThongBao] [nvarchar](500) NULL,
	[NgayTao] [datetime] NULL,
	[TrangThai] [int] NULL,
	[CoSoId] [int] NULL,
 CONSTRAINT [PK_ThongBao] PRIMARY KEY CLUSTERED 
(
	[ThongBaoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThongSo]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ThongSo](
	[ThongSoId] [int] NOT NULL,
	[Loai] [varchar](100) NOT NULL,
	[Ten] [nvarchar](500) NULL,
	[TaiSan] [varchar](2) NULL,
 CONSTRAINT [PK_ThongSo] PRIMARY KEY CLUSTERED 
(
	[ThongSoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ThongSoUser]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongSoUser](
	[ThongSoId] [int] NOT NULL,
	[NhanVienId] [int] NOT NULL,
	[Loai] [nvarchar](500) NULL,
	[Ten] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThongTinCongKhai]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTinCongKhai](
	[TaiSanId] [int] NOT NULL,
	[MoTa] [nvarchar](1000) NULL,
	[MucDich] [nvarchar](1000) NULL,
	[HienTrangSuDungId] [int] NULL,
	[DonGia] [numeric](18, 4) NULL,
	[NopNganSach] [numeric](18, 4) NULL,
	[DeLaiDonVi] [numeric](18, 4) NULL,
	[HHCK] [numeric](18, 4) NULL,
	[NhaCungCapId] [int] NULL,
 CONSTRAINT [PK_ThongTinCongKhai] PRIMARY KEY CLUSTERED 
(
	[TaiSanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThongTinKeKhai_Dat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTinKeKhai_Dat](
	[TaiSanId] [int] NOT NULL,
	[DiaChi] [nvarchar](500) NOT NULL,
	[GiayTo] [nvarchar](500) NULL,
	[DienTich] [numeric](18, 4) NOT NULL,
	[LamTruSo] [numeric](18, 4) NOT NULL,
	[CoSoHDSuNghiep] [numeric](18, 4) NOT NULL,
	[NhaO] [numeric](18, 4) NOT NULL,
	[ChoThue] [numeric](18, 4) NOT NULL,
	[BoTrong] [numeric](18, 4) NOT NULL,
	[BiLanChiem] [numeric](18, 4) NOT NULL,
	[SuDungKhac] [numeric](18, 4) NOT NULL,
 CONSTRAINT [PK_ThongTinKeKhai_Dat] PRIMARY KEY CLUSTERED 
(
	[TaiSanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThongTinKeKhai_Nha]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTinKeKhai_Nha](
	[TaiSanId] [int] NOT NULL,
	[ThuocDat] [int] NULL,
	[DiaChi] [nvarchar](500) NOT NULL,
	[GiayTo] [nvarchar](500) NULL,
	[CapHang] [int] NOT NULL,
	[SoTang] [int] NOT NULL,
	[NamSuDung] [numeric](4, 0) NOT NULL,
	[DienTich] [numeric](18, 4) NOT NULL,
	[TongDienTichSan] [numeric](18, 4) NOT NULL,
	[LamTruSo] [numeric](18, 4) NOT NULL,
	[CoSoHDSuNghiep] [numeric](18, 4) NOT NULL,
	[NhaO] [numeric](18, 4) NOT NULL,
	[ChoThue] [numeric](18, 4) NOT NULL,
	[BoTrong] [numeric](18, 4) NOT NULL,
	[BiLanChiem] [numeric](18, 4) NOT NULL,
	[SuDungKhac] [numeric](18, 4) NOT NULL,
 CONSTRAINT [PK_ThongTinKeKhai_Nha] PRIMARY KEY CLUSTERED 
(
	[TaiSanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThongTinKeKhai_Oto]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTinKeKhai_Oto](
	[TaiSanId] [int] NOT NULL,
	[NhanHieu] [nvarchar](500) NOT NULL,
	[BienKiemSoat] [nvarchar](20) NOT NULL,
	[CongSuatXe] [numeric](8, 0) NOT NULL,
	[TrongTai] [numeric](8, 0) NOT NULL,
	[ChucDanh] [nvarchar](100) NULL,
	[NguonGocXe] [nvarchar](500) NULL,
	[LoaiXe] [int] NOT NULL,
	[HienTrangSuDung] [int] NOT NULL,
 CONSTRAINT [PK_ThongTinKeKhai_Oto] PRIMARY KEY CLUSTERED 
(
	[TaiSanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThongTinKeKhai_Tren500]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTinKeKhai_Tren500](
	[TaiSanId] [int] NOT NULL,
	[KyHieu] [nvarchar](500) NOT NULL,
	[HienTrangSuDung] [int] NOT NULL,
 CONSTRAINT [PK_ThongTinKeKhai_Tren500] PRIMARY KEY CLUSTERED 
(
	[TaiSanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[XuLy]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[XuLy](
	[XuLyId] [int] NOT NULL,
	[TenXuLy] [nvarchar](500) NULL,
 CONSTRAINT [PK_XuLy] PRIMARY KEY CLUSTERED 
(
	[XuLyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[DelimitedSplit8K]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[DelimitedSplit8K]
--===== Define I/O parameters
        (@pString VARCHAR(8000), @pDelimiter CHAR(1))
--WARNING!!! DO NOT USE MAX DATA-TYPES HERE!  IT WILL KILL PERFORMANCE!
RETURNS TABLE WITH SCHEMABINDING AS
 RETURN
--===== "Inline" CTE Driven "Tally Table" produces values from 1 up to 10,000...
     -- enough to cover VARCHAR(8000)
  WITH E1(N) AS (
                 SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL
                 SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL
                 SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
                ),                          --10E+1 or 10 rows
       E2(N) AS (SELECT 1 FROM E1 a, E1 b), --10E+2 or 100 rows
       E4(N) AS (SELECT 1 FROM E2 a, E2 b), --10E+4 or 10,000 rows max
 cteTally(N) AS (--==== This provides the "base" CTE and limits the number of rows right up front
                     -- for both a performance gain and prevention of accidental "overruns"
                 SELECT TOP (ISNULL(DATALENGTH(@pString),0)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM E4
                ),
cteStart(N1) AS (--==== This returns N+1 (starting position of each "element" just once for each delimiter)
                 SELECT 1 UNION ALL
                 SELECT t.N+1 FROM cteTally t WHERE SUBSTRING(@pString,t.N,1) = @pDelimiter
                ),
cteLen(N1,L1) AS(--==== Return start and length (for use in substring)
                 SELECT s.N1,
                        ISNULL(NULLIF(CHARINDEX(@pDelimiter,@pString,s.N1),0)-s.N1,8000)
                   FROM cteStart s
                )
--===== Do the actual split. The ISNULL/NULLIF combo handles the length for the final element when no delimiter is found.
 SELECT ItemNumber = ROW_NUMBER() OVER(ORDER BY l.N1),
        Item       = SUBSTRING(@pString, l.N1, l.L1)
   FROM cteLen l


GO
SET IDENTITY_INSERT [dbo].[BanKiemKe] ON 

INSERT [dbo].[BanKiemKe] ([BanKiemKeId], [BienBanKiemKeId], [NguoiKiemKe], [ChucVu], [DaiDien], [VaiTro]) VALUES (1017, 3, N'tôm', N'dev1', N'tép', N'Trưởng ban')
INSERT [dbo].[BanKiemKe] ([BanKiemKeId], [BienBanKiemKeId], [NguoiKiemKe], [ChucVu], [DaiDien], [VaiTro]) VALUES (1018, 3, N'Nguyen Van Tep', N'dev', N'Ban phòng chống', N'Ủy viên')
INSERT [dbo].[BanKiemKe] ([BanKiemKeId], [BienBanKiemKeId], [NguoiKiemKe], [ChucVu], [DaiDien], [VaiTro]) VALUES (1019, 3, N'Nguyen Van Cua', N'dev', N'Phòng hành chính', N'Ủy viên')
INSERT [dbo].[BanKiemKe] ([BanKiemKeId], [BienBanKiemKeId], [NguoiKiemKe], [ChucVu], [DaiDien], [VaiTro]) VALUES (1022, 1004, N'Tôm', N'Phong lap trinh', N'phong ban', N'Thành viên')
INSERT [dbo].[BanKiemKe] ([BanKiemKeId], [BienBanKiemKeId], [NguoiKiemKe], [ChucVu], [DaiDien], [VaiTro]) VALUES (1023, 1004, N'Tép', N'Phong giam doc', N'lap trinh', N'Giám đốc')
INSERT [dbo].[BanKiemKe] ([BanKiemKeId], [BienBanKiemKeId], [NguoiKiemKe], [ChucVu], [DaiDien], [VaiTro]) VALUES (1024, 1005, N'123123', N'123', N'123', N'23')
INSERT [dbo].[BanKiemKe] ([BanKiemKeId], [BienBanKiemKeId], [NguoiKiemKe], [ChucVu], [DaiDien], [VaiTro]) VALUES (2024, 2, N'Tép', N'DEV', N'Bộ phận nhà tép', N'Trưởng ban')
INSERT [dbo].[BanKiemKe] ([BanKiemKeId], [BienBanKiemKeId], [NguoiKiemKe], [ChucVu], [DaiDien], [VaiTro]) VALUES (2025, 2, N'Tôm', N'Giám đốc', N'Bộ phận nhà tôm', N'Thành viên')
INSERT [dbo].[BanKiemKe] ([BanKiemKeId], [BienBanKiemKeId], [NguoiKiemKe], [ChucVu], [DaiDien], [VaiTro]) VALUES (2026, 2005, N'minh kiều', N'Giám đốc', N'lãnh đạo', N'Trưởng ban')
INSERT [dbo].[BanKiemKe] ([BanKiemKeId], [BienBanKiemKeId], [NguoiKiemKe], [ChucVu], [DaiDien], [VaiTro]) VALUES (2027, 2005, N'minh ngọc', N'Trưởng phòng kế toán', N'Phòng hành chính', N'Thành viên')
INSERT [dbo].[BanKiemKe] ([BanKiemKeId], [BienBanKiemKeId], [NguoiKiemKe], [ChucVu], [DaiDien], [VaiTro]) VALUES (2028, 2006, N'Tép', N'Giam doc', N'hanh chinh', N'GIam doc')
INSERT [dbo].[BanKiemKe] ([BanKiemKeId], [BienBanKiemKeId], [NguoiKiemKe], [ChucVu], [DaiDien], [VaiTro]) VALUES (2029, 2006, N'Tom', N'Hang chinh', N'Nhan su', N'Thanh vien')
SET IDENTITY_INSERT [dbo].[BanKiemKe] OFF
INSERT [dbo].[BaoCao] ([BaoCaoId], [TenBaoCao], [Report], [CoSoId]) VALUES (1, N'Báo cáo tăng, giảm tài sản cố định', N'rptTongHopTangGiamTSCD', NULL)
INSERT [dbo].[BaoCao] ([BaoCaoId], [TenBaoCao], [Report], [CoSoId]) VALUES (2, N'Sổ ghi tăng tài sản cố định', N'rptTongHopGhiTang', NULL)
INSERT [dbo].[BaoCao] ([BaoCaoId], [TenBaoCao], [Report], [CoSoId]) VALUES (3, N'Sổ ghi giảm tài sản cố định', N'rptTongHopGhiGiam', NULL)
INSERT [dbo].[BaoCao] ([BaoCaoId], [TenBaoCao], [Report], [CoSoId]) VALUES (4, N'Báo cáo tổng hợp', N'rptTongHopTaiSanCoDinh', NULL)
SET IDENTITY_INSERT [dbo].[BaoDuong] ON 

INSERT [dbo].[BaoDuong] ([BaoDuongId], [TaiSanId], [PhongBanId], [NhanVienId], [NgayBaoDuong], [NgayDuKien], [DuToan], [LoaiBaoDuongId], [MoTa], [DuyetId], [NguoiDuyet], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2015, 27, 5, 3, CAST(N'2017-11-03 00:00:00.000' AS DateTime), CAST(N'2017-11-03 00:00:00.000' AS DateTime), CAST(20.0000 AS Numeric(18, 4)), 1, N'2', 0, 0, 1, 3, CAST(N'2017-11-03 14:07:58.050' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[BaoDuong] OFF
SET IDENTITY_INSERT [dbo].[BienBanKiemKe] ON 

INSERT [dbo].[BienBanKiemKe] ([BienBanKiemKeId], [SoChungTu], [NgayChungTu], [NgayKiemKe], [PhongBanId], [GhiChu], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2, N'KK000001            ', CAST(N'2017-09-09 00:00:00.000' AS DateTime), CAST(N'2017-09-09 00:00:00.000' AS DateTime), 5, N'abc', 1, 4, CAST(N'2017-09-09 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[BienBanKiemKe] ([BienBanKiemKeId], [SoChungTu], [NgayChungTu], [NgayKiemKe], [PhongBanId], [GhiChu], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3, N'KK000002            ', CAST(N'2017-09-18 00:00:00.000' AS DateTime), CAST(N'2017-09-18 00:00:00.000' AS DateTime), 7, N'', 1, 7, CAST(N'2017-09-18 16:13:40.623' AS DateTime), 1)
INSERT [dbo].[BienBanKiemKe] ([BienBanKiemKeId], [SoChungTu], [NgayChungTu], [NgayKiemKe], [PhongBanId], [GhiChu], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1004, N'KT0003              ', CAST(N'2017-09-29 00:00:00.000' AS DateTime), CAST(N'2017-09-29 00:00:00.000' AS DateTime), 5, N'test', 1, 7, CAST(N'2017-09-29 14:11:30.697' AS DateTime), 1)
INSERT [dbo].[BienBanKiemKe] ([BienBanKiemKeId], [SoChungTu], [NgayChungTu], [NgayKiemKe], [PhongBanId], [GhiChu], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1005, N'4323                ', CAST(N'2017-10-13 00:00:00.000' AS DateTime), CAST(N'2017-10-13 00:00:00.000' AS DateTime), 5, N'213123', 1, 3, CAST(N'2017-10-13 14:27:58.633' AS DateTime), 1)
INSERT [dbo].[BienBanKiemKe] ([BienBanKiemKeId], [SoChungTu], [NgayChungTu], [NgayKiemKe], [PhongBanId], [GhiChu], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2005, N'212121              ', CAST(N'2017-10-27 00:00:00.000' AS DateTime), CAST(N'2017-10-27 00:00:00.000' AS DateTime), 10, N'fgfsgsg', 17, 8, CAST(N'2017-10-27 14:30:27.690' AS DateTime), 1)
INSERT [dbo].[BienBanKiemKe] ([BienBanKiemKeId], [SoChungTu], [NgayChungTu], [NgayKiemKe], [PhongBanId], [GhiChu], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2006, N'KK00018             ', CAST(N'2017-10-31 00:00:00.000' AS DateTime), CAST(N'2017-10-31 00:00:00.000' AS DateTime), 5, NULL, 1, 7, CAST(N'2017-10-31 13:41:35.647' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[BienBanKiemKe] OFF
SET IDENTITY_INSERT [dbo].[BienBanKiemKeChiTiet] ON 

INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1040, 3, 27, CAST(7 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1041, 3, 1061, CAST(5 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1042, 3, 1064, CAST(10 AS Numeric(18, 0)), CAST(10 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1043, 3, 1065, CAST(60 AS Numeric(18, 0)), CAST(57 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1049, 1004, 27, CAST(5 AS Numeric(18, 0)), CAST(5 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1050, 1004, 1061, CAST(18 AS Numeric(18, 0)), CAST(18 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1051, 1004, 1064, CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1052, 1004, 1068, CAST(11 AS Numeric(18, 0)), CAST(9 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1053, 1004, 1069, CAST(3 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1054, 1005, 27, CAST(10 AS Numeric(18, 0)), CAST(10 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1055, 1005, 1061, CAST(36 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1056, 1005, 1064, CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1057, 1005, 1068, CAST(11 AS Numeric(18, 0)), CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (1058, 1005, 1069, CAST(3 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (2054, 2, 27, CAST(5 AS Numeric(18, 0)), CAST(5 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (2055, 2, 1061, CAST(10 AS Numeric(18, 0)), CAST(10 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (2056, 2, 1064, CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (2057, 2, 1068, CAST(11 AS Numeric(18, 0)), CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (2058, 2, 1069, CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (2059, 2005, 2076, CAST(3 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (2060, 2005, 2079, CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (2061, 2005, 2081, CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (2062, 2005, 2082, CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (2063, 2005, 2083, CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (2064, 2006, 1061, CAST(11 AS Numeric(18, 0)), CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[BienBanKiemKeChiTiet] ([BienBanKiemKeChiTietId], [BienBanKiemKeId], [TaiSanId], [SoLuong], [SoLuongKiemKe]) VALUES (2065, 2006, 1065, CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)))
SET IDENTITY_INSERT [dbo].[BienBanKiemKeChiTiet] OFF
SET IDENTITY_INSERT [dbo].[CoSo] ON 

INSERT [dbo].[CoSo] ([CoSoId], [MaCoSo], [LoaiCoSoId], [TrucThuoc], [TenCoSo], [DienThoai], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1, N'CS01', 2, 0, N'Sở tài chính Quảng Ninh', N'0985401027', N'38/40 Quang Trung, phường 10, quận Gò Vấp, Tp.HCM', N'Ghi chú', 53, CAST(N'2017-08-09 00:00:00.000' AS DateTime), 6)
INSERT [dbo].[CoSo] ([CoSoId], [MaCoSo], [LoaiCoSoId], [TrucThuoc], [TenCoSo], [DienThoai], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (15, N'CS02', 4, 1, N'Bệnh viện lai châu', N'0985401027', N'38/40 Quang Trung, phường 10, quận Gò Vấp, Tp.HCM', N'Ghi chú', 53, CAST(N'2017-08-09 00:00:00.000' AS DateTime), 7)
INSERT [dbo].[CoSo] ([CoSoId], [MaCoSo], [LoaiCoSoId], [TrucThuoc], [TenCoSo], [DienThoai], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (16, N'DB001', 2, 0, N'Sở y tế Điện Biên', N'0985401027', NULL, NULL, 3, CAST(N'2017-09-29 08:28:41.340' AS DateTime), 1)
INSERT [dbo].[CoSo] ([CoSoId], [MaCoSo], [LoaiCoSoId], [TrucThuoc], [TenCoSo], [DienThoai], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (17, N'DB002', 4, 16, N'BV Điện Biên Phủ', NULL, NULL, NULL, 3, CAST(N'2017-09-29 08:30:07.043' AS DateTime), 1)
INSERT [dbo].[CoSo] ([CoSoId], [MaCoSo], [LoaiCoSoId], [TrucThuoc], [TenCoSo], [DienThoai], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (18, N'DB003', 4, 16, N'BV Tuần Giáo', NULL, NULL, NULL, 3, CAST(N'2017-09-29 08:31:15.177' AS DateTime), 1)
INSERT [dbo].[CoSo] ([CoSoId], [MaCoSo], [LoaiCoSoId], [TrucThuoc], [TenCoSo], [DienThoai], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (19, N'CS001', 5, 16, N'PK Thanh Trường', N'123', N'23', N'12', 8, CAST(N'2017-10-14 09:19:45.460' AS DateTime), 1)
INSERT [dbo].[CoSo] ([CoSoId], [MaCoSo], [LoaiCoSoId], [TrucThuoc], [TenCoSo], [DienThoai], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (20, N'2', 3, 16, N'2', N'2', N'2', N'2', 8, CAST(N'2017-10-14 09:34:40.333' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[CoSo] OFF
SET IDENTITY_INSERT [dbo].[DuAn] ON 

INSERT [dbo].[DuAn] ([DuAnId], [MaDuAn], [TenDuAn], [GhiChu], [NgungTheoDoi], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1, N'DA01', N'Dự án 1', N'222', 0, 1, 53, CAST(N'2017-08-21 10:47:06.073' AS DateTime), 11)
INSERT [dbo].[DuAn] ([DuAnId], [MaDuAn], [TenDuAn], [GhiChu], [NgungTheoDoi], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3, N'DA02', N'Dự án 2', NULL, 0, 1, 3, CAST(N'2017-09-15 13:44:58.607' AS DateTime), 1)
INSERT [dbo].[DuAn] ([DuAnId], [MaDuAn], [TenDuAn], [GhiChu], [NgungTheoDoi], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1003, N'DA001', N'Ehis', NULL, 0, 17, 8, CAST(N'2017-10-14 09:18:45.570' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[DuAn] OFF
INSERT [dbo].[Duyet] ([DuyetId], [TrangThai]) VALUES (0, N'Chờ duyệt')
INSERT [dbo].[Duyet] ([DuyetId], [TrangThai]) VALUES (1, N'Đồng ý')
INSERT [dbo].[Duyet] ([DuyetId], [TrangThai]) VALUES (2, N'Từ chối')
SET IDENTITY_INSERT [dbo].[GhiTang] ON 

INSERT [dbo].[GhiTang] ([GhiTangId], [SoChungTu], [NgayChungTu], [NgayGhiTang], [NoiDung], [DuyetId], [NguoiDuyet], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3020, N'GT00001', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-11-01 00:00:00.000' AS DateTime), N'abc', 0, 0, 1, 7, CAST(N'2017-11-01 14:20:52.950' AS DateTime), 1)
INSERT [dbo].[GhiTang] ([GhiTangId], [SoChungTu], [NgayChungTu], [NgayGhiTang], [NoiDung], [DuyetId], [NguoiDuyet], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3021, N'test', CAST(N'2017-11-02 00:00:00.000' AS DateTime), CAST(N'2017-11-02 00:00:00.000' AS DateTime), N'test', 0, 0, 16, 10, CAST(N'2017-11-02 11:36:02.140' AS DateTime), 1)
INSERT [dbo].[GhiTang] ([GhiTangId], [SoChungTu], [NgayChungTu], [NgayGhiTang], [NoiDung], [DuyetId], [NguoiDuyet], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3022, N'test', CAST(N'2017-11-02 00:00:00.000' AS DateTime), CAST(N'2017-11-02 00:00:00.000' AS DateTime), N'test', 0, 0, 16, 10, CAST(N'2017-11-02 11:36:46.877' AS DateTime), 1)
INSERT [dbo].[GhiTang] ([GhiTangId], [SoChungTu], [NgayChungTu], [NgayGhiTang], [NoiDung], [DuyetId], [NguoiDuyet], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3023, N'GT000002', CAST(N'2017-11-02 00:00:00.000' AS DateTime), CAST(N'2017-11-02 00:00:00.000' AS DateTime), NULL, 0, 0, 1, 7, CAST(N'2017-11-02 15:12:22.210' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[GhiTang] OFF
SET IDENTITY_INSERT [dbo].[GhiTangChiTiet] ON 

INSERT [dbo].[GhiTangChiTiet] ([GhiTangChiTietId], [GhiTangId], [TaiSanId], [NgayBatDauSuDung], [PhongBanId], [NhanVienId], [SoLuong], [HopDongId]) VALUES (4216, 3020, 27, CAST(N'2017-11-01 00:00:00.000' AS DateTime), 5, 3, CAST(100.0000 AS Numeric(18, 4)), 1)
INSERT [dbo].[GhiTangChiTiet] ([GhiTangChiTietId], [GhiTangId], [TaiSanId], [NgayBatDauSuDung], [PhongBanId], [NhanVienId], [SoLuong], [HopDongId]) VALUES (4217, 3023, 1065, CAST(N'2017-11-02 00:00:00.000' AS DateTime), 5, 3, CAST(90.0000 AS Numeric(18, 4)), 1)
INSERT [dbo].[GhiTangChiTiet] ([GhiTangChiTietId], [GhiTangId], [TaiSanId], [NgayBatDauSuDung], [PhongBanId], [NhanVienId], [SoLuong], [HopDongId]) VALUES (4218, 3023, 1069, CAST(N'2017-11-02 00:00:00.000' AS DateTime), 5, 3, CAST(20.0000 AS Numeric(18, 4)), 1)
SET IDENTITY_INSERT [dbo].[GhiTangChiTiet] OFF
SET IDENTITY_INSERT [dbo].[HangSanXuat] ON 

INSERT [dbo].[HangSanXuat] ([HangSanXuatId], [MaHangSanXuat], [TenHangSanXuat], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2, N'Hang01', N'SamSum', NULL, 53, CAST(N'2017-08-15 17:03:46.083' AS DateTime), 1)
INSERT [dbo].[HangSanXuat] ([HangSanXuatId], [MaHangSanXuat], [TenHangSanXuat], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3, N'Hang01', N'Dell', N'123', 8, CAST(N'2017-10-14 09:15:41.270' AS DateTime), 1)
INSERT [dbo].[HangSanXuat] ([HangSanXuatId], [MaHangSanXuat], [TenHangSanXuat], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1003, N'Hang02', N'accer', NULL, 8, CAST(N'2017-10-16 08:53:03.143' AS DateTime), 2)
INSERT [dbo].[HangSanXuat] ([HangSanXuatId], [MaHangSanXuat], [TenHangSanXuat], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1004, N'HANG03', N'TOSHIBA', NULL, 6, CAST(N'2017-10-17 08:49:19.483' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[HangSanXuat] OFF
INSERT [dbo].[HienTrangSuDung] ([HienTrangSuDungId], [NoiDung]) VALUES (1, N'Phục vụ chức danh có tiêu chuẩn')
INSERT [dbo].[HienTrangSuDung] ([HienTrangSuDungId], [NoiDung]) VALUES (2, N'Phục vụ công tác chung')
INSERT [dbo].[HienTrangSuDung] ([HienTrangSuDungId], [NoiDung]) VALUES (3, N'Phục vụ HĐ đặc thù')
INSERT [dbo].[HienTrangSuDung] ([HienTrangSuDungId], [NoiDung]) VALUES (4, N'Sử dụng khác')
INSERT [dbo].[HinhThuc] ([HinhThucId], [TenHinhThuc]) VALUES (1, N'Đấu thầu')
INSERT [dbo].[HinhThuc] ([HinhThucId], [TenHinhThuc]) VALUES (2, N'Chỉ định thầu')
INSERT [dbo].[HinhThuc] ([HinhThucId], [TenHinhThuc]) VALUES (3, N'Chào hàng cạnh tranh')
INSERT [dbo].[HinhThuc] ([HinhThucId], [TenHinhThuc]) VALUES (4, N'Mua sắm trực tiếp')
SET IDENTITY_INSERT [dbo].[HopDong] ON 

INSERT [dbo].[HopDong] ([HopDongId], [SoHopDong], [NgayHopDong], [TenNhaThau], [DaiDien], [GiaTriHopDong], [NoiDung], [FileDinhKem], [CoSoId], [NgayTao], [NguoiTao], [CtrVersion]) VALUES (1, N'HD00001', CAST(N'2017-11-01 00:00:00.000' AS DateTime), N'ABC', N'DEF', CAST(10000000.0000 AS Numeric(18, 4)), N'Mua máy', N'20171102082433131.jpg', 1, CAST(N'2017-11-01 00:00:00.000' AS DateTime), N'7', 5)
INSERT [dbo].[HopDong] ([HopDongId], [SoHopDong], [NgayHopDong], [TenNhaThau], [DaiDien], [GiaTriHopDong], [NoiDung], [FileDinhKem], [CoSoId], [NgayTao], [NguoiTao], [CtrVersion]) VALUES (12, N'HD0002', CAST(N'2017-11-02 00:00:00.000' AS DateTime), N'CEF', N'FGH', CAST(200000000.0000 AS Numeric(18, 4)), N'1', N'20171101040830646.pptx', 1, CAST(N'2017-11-01 16:08:30.650' AS DateTime), N'7', 4)
SET IDENTITY_INSERT [dbo].[HopDong] OFF
SET IDENTITY_INSERT [dbo].[KeHoachMuaSam] ON 

INSERT [dbo].[KeHoachMuaSam] ([MuaSamId], [Nam], [NoiDung], [DuyetId], [NgayDuyet], [NoiDungDuyet], [NguoiDuyet], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3068, CAST(2017 AS Numeric(4, 0)), N'as', 0, NULL, NULL, NULL, 1, 7, CAST(N'2017-11-03 14:07:25.483' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[KeHoachMuaSam] OFF
SET IDENTITY_INSERT [dbo].[KeHoachMuaSamChiTiet] ON 

INSERT [dbo].[KeHoachMuaSamChiTiet] ([MuaSamChiTietId], [MuaSamId], [TenTaiSan], [LoaiId], [PhuongThucId], [DonViTinh], [MoTa], [Ngay], [SoLuong], [DonGia], [HinhThucId], [DuToan], [GhiChu], [DuyetId]) VALUES (3081, 3068, N'test report', 1, 1, N'abc', N'dai dai dai dai', CAST(N'2017-11-03 00:00:00.000' AS DateTime), CAST(1 AS Numeric(4, 0)), CAST(3000000.0000 AS Numeric(18, 4)), 1, CAST(200000000.0000 AS Numeric(18, 4)), N'ghi chú', 0)
SET IDENTITY_INSERT [dbo].[KeHoachMuaSamChiTiet] OFF
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([KhachHangId], [MaKhachHang], [TenKhachHang], [DienThoai], [DiDong], [MaSoThue], [TKNganHang], [TenNganHang], [DiaChi], [GhiChu], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1, N'KH001', N'Công ty TNHH TM&DV Song Ân', N'1234562', N'123456', N'123456', N'123456', N'Ngân hàng ACB', N'38/40 Quang Trung, phường 10, quận Gò Vấp, Tp.HCM', NULL, 1, 53, CAST(N'2017-08-14 09:58:02.023' AS DateTime), 5)
INSERT [dbo].[KhachHang] ([KhachHangId], [MaKhachHang], [TenKhachHang], [DienThoai], [DiDong], [MaSoThue], [TKNganHang], [TenNganHang], [DiaChi], [GhiChu], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (5, N'213', N'123123123', N'23', N'123', N'23', N'2', NULL, NULL, NULL, 17, 8, CAST(N'2017-10-13 15:20:29.220' AS DateTime), 1)
INSERT [dbo].[KhachHang] ([KhachHangId], [MaKhachHang], [TenKhachHang], [DienThoai], [DiDong], [MaSoThue], [TKNganHang], [TenNganHang], [DiaChi], [GhiChu], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1005, N'KH002', N'Nguyễn kim', N'0985401057', N'201474512', N'123456789', N'123456798', N'ACB bank', N'phường 10, quang trung quan gò vâp tp hcm', NULL, 17, 8, CAST(N'2017-10-16 08:56:18.240' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
SET IDENTITY_INSERT [dbo].[KhaiThac] ON 

INSERT [dbo].[KhaiThac] ([KhaiThacId], [TaiSanId], [PhongBanId], [NhanVienId], [KhachHangNCCId], [SoChungTu], [SoLuongKhaiThac], [DonGiaKhaiThac], [ThoiGianBatDau], [ThoiGianKetThuc], [TienThu], [NopNganSach], [DonVi], [GhiChu], [HopDongId], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1014, 1061, 5, 3, 1, N'KT00001', CAST(1 AS Numeric(18, 0)), CAST(10000.0000 AS Numeric(18, 4)), CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(10000.0000 AS Numeric(18, 4)), CAST(1.0000 AS Numeric(18, 4)), CAST(2.0000 AS Numeric(18, 4)), NULL, 1, 1, 7, CAST(N'2017-11-01 15:22:31.903' AS DateTime), 3)
INSERT [dbo].[KhaiThac] ([KhaiThacId], [TaiSanId], [PhongBanId], [NhanVienId], [KhachHangNCCId], [SoChungTu], [SoLuongKhaiThac], [DonGiaKhaiThac], [ThoiGianBatDau], [ThoiGianKetThuc], [TienThu], [NopNganSach], [DonVi], [GhiChu], [HopDongId], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1015, 27, 5, 3, 1, N'KT0002', CAST(100 AS Numeric(18, 0)), CAST(3000000.0000 AS Numeric(18, 4)), CAST(N'2017-11-02 00:00:00.000' AS DateTime), CAST(N'2017-11-02 00:00:00.000' AS DateTime), CAST(300000000.0000 AS Numeric(18, 4)), CAST(100000000.0000 AS Numeric(18, 4)), CAST(200000000.0000 AS Numeric(18, 4)), N'thuê      ', 1, 1, 7, CAST(N'2017-11-02 10:25:41.103' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[KhaiThac] OFF
SET IDENTITY_INSERT [dbo].[KhoaSoLieu] ON 

INSERT [dbo].[KhoaSoLieu] ([KhoaSoLieuId], [Nam], [TrangThai], [CoSoId]) VALUES (14, N'2016', N'0', 1)
INSERT [dbo].[KhoaSoLieu] ([KhoaSoLieuId], [Nam], [TrangThai], [CoSoId]) VALUES (19, N'2017', N'1', 1)
INSERT [dbo].[KhoaSoLieu] ([KhoaSoLieuId], [Nam], [TrangThai], [CoSoId]) VALUES (20, N'2015', N'0', 1)
SET IDENTITY_INSERT [dbo].[KhoaSoLieu] OFF
SET IDENTITY_INSERT [dbo].[KhoaSoLieuThang] ON 

INSERT [dbo].[KhoaSoLieuThang] ([KhoaSoLieuThangId], [ThangNam], [TrangThai], [CoSoId]) VALUES (1, 1117, 1, 18)
SET IDENTITY_INSERT [dbo].[KhoaSoLieuThang] OFF
SET IDENTITY_INSERT [dbo].[KhoPhieuNhap] ON 

INSERT [dbo].[KhoPhieuNhap] ([KhoPhieuNhapId], [KhoTaiSanId], [NguonNganSachId], [NhaCungCapId], [NgayNhap], [SoPhieu], [Seri], [SoHoaDon], [NgayHD], [BBKiem], [ChietKhau], [NguoiGiao], [Loai], [TaiKhoanNo], [TaiKhoanCo], [NoiDung], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1016, 6, 1, 1003, CAST(N'2017-11-01 00:00:00.000' AS DateTime), N'PN001', N'123', N'HD001', CAST(N'2017-11-01 00:00:00.000' AS DateTime), N'123', 10, N'Tân Nguyễn', N'1', N'123', N'123', N'Nhập mới', 18, 3, CAST(N'2017-11-01 15:40:32.780' AS DateTime), 1)
INSERT [dbo].[KhoPhieuNhap] ([KhoPhieuNhapId], [KhoTaiSanId], [NguonNganSachId], [NhaCungCapId], [NgayNhap], [SoPhieu], [Seri], [SoHoaDon], [NgayHD], [BBKiem], [ChietKhau], [NguoiGiao], [Loai], [TaiKhoanNo], [TaiKhoanCo], [NoiDung], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1017, 6, 1, 1003, CAST(N'2017-11-01 00:00:00.000' AS DateTime), N'PN002', N'123', N'123', CAST(N'2017-11-01 00:00:00.000' AS DateTime), N'123', 10, N'', N'1', N'123', N'123', N'', 18, 3, CAST(N'2017-11-01 15:42:20.407' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[KhoPhieuNhap] OFF
SET IDENTITY_INSERT [dbo].[KhoPhieuNhapChiTiet] ON 

INSERT [dbo].[KhoPhieuNhapChiTiet] ([KhoPhieuNhapChiTietId], [KhoPhieuNhapId], [TaiSanId], [SoLuong], [DonGia], [GiaMua], [GiaBan], [VAT], [HanDung], [LoSanXuat]) VALUES (1038, 1016, 3081, CAST(42.0000 AS Numeric(18, 4)), CAST(40000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.00 AS Numeric(4, 2)), N'0117', N'1017')
INSERT [dbo].[KhoPhieuNhapChiTiet] ([KhoPhieuNhapChiTietId], [KhoPhieuNhapId], [TaiSanId], [SoLuong], [DonGia], [GiaMua], [GiaBan], [VAT], [HanDung], [LoSanXuat]) VALUES (1042, 1017, 3082, CAST(50.0000 AS Numeric(18, 4)), CAST(80000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.00 AS Numeric(4, 2)), N'', N'')
INSERT [dbo].[KhoPhieuNhapChiTiet] ([KhoPhieuNhapChiTietId], [KhoPhieuNhapId], [TaiSanId], [SoLuong], [DonGia], [GiaMua], [GiaBan], [VAT], [HanDung], [LoSanXuat]) VALUES (1043, 1017, 3083, CAST(10.0000 AS Numeric(18, 4)), CAST(99000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.00 AS Numeric(4, 2)), N'', N'')
INSERT [dbo].[KhoPhieuNhapChiTiet] ([KhoPhieuNhapChiTietId], [KhoPhieuNhapId], [TaiSanId], [SoLuong], [DonGia], [GiaMua], [GiaBan], [VAT], [HanDung], [LoSanXuat]) VALUES (1044, 1017, 3081, CAST(4.0000 AS Numeric(18, 4)), CAST(5000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.00 AS Numeric(4, 2)), N'', N'')
SET IDENTITY_INSERT [dbo].[KhoPhieuNhapChiTiet] OFF
SET IDENTITY_INSERT [dbo].[KhoPhieuXuat] ON 

INSERT [dbo].[KhoPhieuXuat] ([KhoPhieuXuatId], [SoPhieu], [NgayXuat], [Loai], [KhoXuatId], [KhoNhanId], [NguoiNhanHang], [LyDo], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (68, N'CK001', CAST(N'2017-11-01 00:00:00.000' AS DateTime), N'CK', 6, 7, N'1231321', N'31232122', 18, 3, CAST(N'2017-11-02 02:38:20.733' AS DateTime), 0)
INSERT [dbo].[KhoPhieuXuat] ([KhoPhieuXuatId], [SoPhieu], [NgayXuat], [Loai], [KhoXuatId], [KhoNhanId], [NguoiNhanHang], [LyDo], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (69, N'CK002', CAST(N'2017-11-01 00:00:00.000' AS DateTime), N'CK', 6, 7, N'Tân', NULL, 18, 3, CAST(N'2017-11-01 09:16:24.873' AS DateTime), 0)
INSERT [dbo].[KhoPhieuXuat] ([KhoPhieuXuatId], [SoPhieu], [NgayXuat], [Loai], [KhoXuatId], [KhoNhanId], [NguoiNhanHang], [LyDo], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (79, N'XK001', CAST(N'2017-11-02 00:00:00.000' AS DateTime), N'XK', 6, NULL, N'Tân', N'', 18, 3, CAST(N'2017-11-02 02:50:20.173' AS DateTime), 0)
INSERT [dbo].[KhoPhieuXuat] ([KhoPhieuXuatId], [SoPhieu], [NgayXuat], [Loai], [KhoXuatId], [KhoNhanId], [NguoiNhanHang], [LyDo], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (80, N'XK002', CAST(N'2017-11-02 00:00:00.000' AS DateTime), N'XK', 7, NULL, N'tân', NULL, 18, 3, CAST(N'2017-11-02 02:52:56.293' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[KhoPhieuXuat] OFF
SET IDENTITY_INSERT [dbo].[KhoPhieuXuatChiTiet] ON 

INSERT [dbo].[KhoPhieuXuatChiTiet] ([KhoPhieuXuatChiTietId], [KhoPhieuXuatId], [TaiSanId], [SoLuong], [DonGia], [GiaMua], [GiaBan], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1117, 69, 3082, CAST(2.0000 AS Numeric(18, 4)), CAST(80000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, NULL, NULL, NULL)
INSERT [dbo].[KhoPhieuXuatChiTiet] ([KhoPhieuXuatChiTietId], [KhoPhieuXuatId], [TaiSanId], [SoLuong], [DonGia], [GiaMua], [GiaBan], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1121, 68, 3082, CAST(5.0000 AS Numeric(18, 4)), CAST(90000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, NULL, NULL, NULL)
INSERT [dbo].[KhoPhieuXuatChiTiet] ([KhoPhieuXuatChiTietId], [KhoPhieuXuatId], [TaiSanId], [SoLuong], [DonGia], [GiaMua], [GiaBan], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1124, 79, 3081, CAST(4.0000 AS Numeric(18, 4)), CAST(5000000.0000 AS Numeric(18, 4)), CAST(5000000.0000 AS Numeric(18, 4)), CAST(5000000.0000 AS Numeric(18, 4)), 2, NULL, NULL, NULL)
INSERT [dbo].[KhoPhieuXuatChiTiet] ([KhoPhieuXuatChiTietId], [KhoPhieuXuatId], [TaiSanId], [SoLuong], [DonGia], [GiaMua], [GiaBan], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1125, 79, 3082, CAST(8.0000 AS Numeric(18, 4)), CAST(80000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, NULL, NULL, NULL)
INSERT [dbo].[KhoPhieuXuatChiTiet] ([KhoPhieuXuatChiTietId], [KhoPhieuXuatId], [TaiSanId], [SoLuong], [DonGia], [GiaMua], [GiaBan], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1127, 80, 3082, CAST(2.0000 AS Numeric(18, 4)), CAST(80000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, NULL, N'', N'')
SET IDENTITY_INSERT [dbo].[KhoPhieuXuatChiTiet] OFF
SET IDENTITY_INSERT [dbo].[KhoTaiSan] ON 

INSERT [dbo].[KhoTaiSan] ([KhoTaiSanId], [CoSoId], [MaKhoTaiSan], [TenKhoTaiSan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1, 1, N'KHO01', N'Kho chính', NULL, 53, CAST(N'2017-08-17 10:49:51.017' AS DateTime), 2)
INSERT [dbo].[KhoTaiSan] ([KhoTaiSanId], [CoSoId], [MaKhoTaiSan], [TenKhoTaiSan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (4, 1, N'KHO02', N'Kho phụ', NULL, 53, NULL, 1)
INSERT [dbo].[KhoTaiSan] ([KhoTaiSanId], [CoSoId], [MaKhoTaiSan], [TenKhoTaiSan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (6, 18, N'KHO001', N'Kho Chính', NULL, 3, CAST(N'2017-11-01 14:53:01.437' AS DateTime), 1)
INSERT [dbo].[KhoTaiSan] ([KhoTaiSanId], [CoSoId], [MaKhoTaiSan], [TenKhoTaiSan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (7, 18, N'Kho002', N'Kho Phụ', NULL, 3, CAST(N'2017-11-01 14:53:26.453' AS DateTime), 1)
INSERT [dbo].[KhoTaiSan] ([KhoTaiSanId], [CoSoId], [MaKhoTaiSan], [TenKhoTaiSan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (8, 17, N'KH001', N'Kho Chính', NULL, 21, CAST(N'2017-11-01 14:53:42.513' AS DateTime), 1)
INSERT [dbo].[KhoTaiSan] ([KhoTaiSanId], [CoSoId], [MaKhoTaiSan], [TenKhoTaiSan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (9, 17, N'KH001', N'Kho 2', NULL, 21, CAST(N'2017-11-01 14:54:46.430' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[KhoTaiSan] OFF
SET IDENTITY_INSERT [dbo].[KhoTonKho] ON 

INSERT [dbo].[KhoTonKho] ([KhoTonKhoId], [KhoTaiSanId], [CoSoId], [ThangNam], [TrangThai], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1018, 6, 18, N'1117', 1, 3, CAST(N'2017-11-01 15:23:18.637' AS DateTime), 1)
INSERT [dbo].[KhoTonKho] ([KhoTonKhoId], [KhoTaiSanId], [CoSoId], [ThangNam], [TrangThai], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1019, 7, 18, N'1117', 1, 3, CAST(N'2017-11-01 09:06:03.720' AS DateTime), 1)
INSERT [dbo].[KhoTonKho] ([KhoTonKhoId], [KhoTaiSanId], [CoSoId], [ThangNam], [TrangThai], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1020, 6, 18, N'1217', 0, 3, CAST(N'2017-11-02 14:55:09.880' AS DateTime), 1)
INSERT [dbo].[KhoTonKho] ([KhoTonKhoId], [KhoTaiSanId], [CoSoId], [ThangNam], [TrangThai], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1021, 7, 18, N'1217', 0, 3, CAST(N'2017-11-02 14:55:09.937' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[KhoTonKho] OFF
SET IDENTITY_INSERT [dbo].[KhoTonKhoChiTiet] ON 

INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1068, 1018, 3081, CAST(5000000.0000 AS Numeric(18, 4)), CAST(5000000.0000 AS Numeric(18, 4)), CAST(5000000.0000 AS Numeric(18, 4)), CAST(20.0000 AS Numeric(18, 4)), CAST(4.0000 AS Numeric(18, 4)), CAST(4.0000 AS Numeric(18, 4)), 2, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1069, 1018, 3082, CAST(80000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(20.0000 AS Numeric(18, 4)), CAST(50.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), 2, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1070, 1018, 3083, CAST(100000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(20.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1071, 1018, 3081, CAST(7000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 1, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1072, 1018, 3082, CAST(90000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(5.0000 AS Numeric(18, 4)), 2, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1073, 1018, 3083, CAST(99000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 5, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1074, 1018, 3082, CAST(100000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1075, 1018, 3081, CAST(40000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(42.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 1, 1003, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1076, 1019, 3082, CAST(80000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(2.0000 AS Numeric(18, 4)), CAST(2.0000 AS Numeric(18, 4)), 2, NULL, N'', N'')
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1077, 1019, 3082, CAST(90000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(5.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, NULL, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1078, 1020, 3081, CAST(5000000.0000 AS Numeric(18, 4)), CAST(5000000.0000 AS Numeric(18, 4)), CAST(5000000.0000 AS Numeric(18, 4)), CAST(20.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1079, 1020, 3082, CAST(80000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(60.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1080, 1020, 3083, CAST(100000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(20.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1081, 1020, 3081, CAST(7000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 1, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1082, 1020, 3082, CAST(90000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(5.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1083, 1020, 3083, CAST(99000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(20.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 5, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1084, 1020, 3082, CAST(100000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, 0, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1085, 1020, 3081, CAST(40000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(42.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 1, 1003, NULL, NULL)
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1086, 1021, 3082, CAST(80000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, NULL, N'', N'')
INSERT [dbo].[KhoTonKhoChiTiet] ([KhoTonKhoChiTietId], [KhoTonKhoId], [TaiSanId], [DonGia], [GiaMua], [GiaBan], [TonDau], [SLNhap], [SLXuat], [NguonNganSachId], [NhaCungCapId], [HanDung], [LoSanXuat]) VALUES (1087, 1021, 3082, CAST(90000000.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(5.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 2, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[KhoTonKhoChiTiet] OFF
SET IDENTITY_INSERT [dbo].[LapBaoCao] ON 

INSERT [dbo].[LapBaoCao] ([LapBaoCaoId], [KyBaoCao], [TuNgay], [DenNgay], [DienGiai], [CoSoId], [DuyetId], [GuiCapTren], [NgayGui], [NgayDuyet], [NoiDungDuyet], [NguoiDuyet], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (15, N'4', CAST(N'2017-09-10 00:00:00.000' AS DateTime), CAST(N'2017-12-31 00:00:00.000' AS DateTime), N'báo cáo 2', 1, 2, 1, CAST(N'2017-10-10 14:25:17.950' AS DateTime), CAST(N'2017-10-11 00:00:00.000' AS DateTime), N'Chua đúng mẫu', 3, 3, CAST(N'2017-10-10 13:40:21.590' AS DateTime), 1)
INSERT [dbo].[LapBaoCao] ([LapBaoCaoId], [KyBaoCao], [TuNgay], [DenNgay], [DienGiai], [CoSoId], [DuyetId], [GuiCapTren], [NgayGui], [NgayDuyet], [NoiDungDuyet], [NguoiDuyet], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (16, N'1', CAST(N'2017-01-01 00:00:00.000' AS DateTime), CAST(N'2017-12-31 00:00:00.000' AS DateTime), NULL, 1, 0, 0, NULL, NULL, NULL, 0, 3, CAST(N'2017-10-13 14:28:32.357' AS DateTime), 1)
INSERT [dbo].[LapBaoCao] ([LapBaoCaoId], [KyBaoCao], [TuNgay], [DenNgay], [DienGiai], [CoSoId], [DuyetId], [GuiCapTren], [NgayGui], [NgayDuyet], [NoiDungDuyet], [NguoiDuyet], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (17, N'1', CAST(N'2017-01-01 00:00:00.000' AS DateTime), CAST(N'2017-12-31 00:00:00.000' AS DateTime), NULL, 16, 0, 0, NULL, NULL, NULL, 0, 10, CAST(N'2017-10-13 15:12:05.453' AS DateTime), 1)
INSERT [dbo].[LapBaoCao] ([LapBaoCaoId], [KyBaoCao], [TuNgay], [DenNgay], [DienGiai], [CoSoId], [DuyetId], [GuiCapTren], [NgayGui], [NgayDuyet], [NoiDungDuyet], [NguoiDuyet], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1016, N'2', CAST(N'2017-01-01 00:00:00.000' AS DateTime), CAST(N'2017-03-31 00:00:00.000' AS DateTime), NULL, 16, 0, 0, NULL, NULL, NULL, 0, 10, CAST(N'2017-10-17 14:31:24.767' AS DateTime), 1)
INSERT [dbo].[LapBaoCao] ([LapBaoCaoId], [KyBaoCao], [TuNgay], [DenNgay], [DienGiai], [CoSoId], [DuyetId], [GuiCapTren], [NgayGui], [NgayDuyet], [NoiDungDuyet], [NguoiDuyet], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1017, N'1', CAST(N'2017-01-01 00:00:00.000' AS DateTime), CAST(N'2017-12-31 00:00:00.000' AS DateTime), N'iu', 17, 0, 1, CAST(N'2017-10-27 18:14:16.177' AS DateTime), NULL, NULL, 0, 8, CAST(N'2017-10-27 18:13:56.600' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[LapBaoCao] OFF
SET IDENTITY_INSERT [dbo].[LapBaoCaoChiTiet] ON 

INSERT [dbo].[LapBaoCaoChiTiet] ([LapBaoCaoChiTietId], [LapBaoCaoId], [BaoCaoId], [DuyetId], [NgayDuyet], [NoiDungDuyet]) VALUES (40, 15, 1, 2, CAST(N'2017-10-11 00:00:00.000' AS DateTime), N'Từ chối')
INSERT [dbo].[LapBaoCaoChiTiet] ([LapBaoCaoChiTietId], [LapBaoCaoId], [BaoCaoId], [DuyetId], [NgayDuyet], [NoiDungDuyet]) VALUES (41, 15, 2, 2, CAST(N'2017-10-11 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[LapBaoCaoChiTiet] ([LapBaoCaoChiTietId], [LapBaoCaoId], [BaoCaoId], [DuyetId], [NgayDuyet], [NoiDungDuyet]) VALUES (42, 15, 3, 2, CAST(N'2017-10-11 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[LapBaoCaoChiTiet] ([LapBaoCaoChiTietId], [LapBaoCaoId], [BaoCaoId], [DuyetId], [NgayDuyet], [NoiDungDuyet]) VALUES (43, 16, 1, 0, NULL, NULL)
INSERT [dbo].[LapBaoCaoChiTiet] ([LapBaoCaoChiTietId], [LapBaoCaoId], [BaoCaoId], [DuyetId], [NgayDuyet], [NoiDungDuyet]) VALUES (44, 16, 2, 0, NULL, NULL)
INSERT [dbo].[LapBaoCaoChiTiet] ([LapBaoCaoChiTietId], [LapBaoCaoId], [BaoCaoId], [DuyetId], [NgayDuyet], [NoiDungDuyet]) VALUES (45, 16, 3, 0, NULL, NULL)
INSERT [dbo].[LapBaoCaoChiTiet] ([LapBaoCaoChiTietId], [LapBaoCaoId], [BaoCaoId], [DuyetId], [NgayDuyet], [NoiDungDuyet]) VALUES (46, 16, 4, 0, NULL, NULL)
INSERT [dbo].[LapBaoCaoChiTiet] ([LapBaoCaoChiTietId], [LapBaoCaoId], [BaoCaoId], [DuyetId], [NgayDuyet], [NoiDungDuyet]) VALUES (48, 17, 2, 0, NULL, NULL)
INSERT [dbo].[LapBaoCaoChiTiet] ([LapBaoCaoChiTietId], [LapBaoCaoId], [BaoCaoId], [DuyetId], [NgayDuyet], [NoiDungDuyet]) VALUES (1043, 1016, 1, 0, NULL, NULL)
INSERT [dbo].[LapBaoCaoChiTiet] ([LapBaoCaoChiTietId], [LapBaoCaoId], [BaoCaoId], [DuyetId], [NgayDuyet], [NoiDungDuyet]) VALUES (1044, 1016, 2, 0, NULL, NULL)
INSERT [dbo].[LapBaoCaoChiTiet] ([LapBaoCaoChiTietId], [LapBaoCaoId], [BaoCaoId], [DuyetId], [NgayDuyet], [NoiDungDuyet]) VALUES (1045, 1016, 3, 0, NULL, NULL)
INSERT [dbo].[LapBaoCaoChiTiet] ([LapBaoCaoChiTietId], [LapBaoCaoId], [BaoCaoId], [DuyetId], [NgayDuyet], [NoiDungDuyet]) VALUES (1046, 1017, 1, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[LapBaoCaoChiTiet] OFF
SET IDENTITY_INSERT [dbo].[LoaiCoSo] ON 

INSERT [dbo].[LoaiCoSo] ([LoaiCoSoId], [MaLoaiCoSo], [TenLoaiCoSo], [QuanHe], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1, N'L001      ', N'Sở tài chính', N'L002,L003,L004,L005                                                                                 ', 2, NULL, 1)
INSERT [dbo].[LoaiCoSo] ([LoaiCoSoId], [MaLoaiCoSo], [TenLoaiCoSo], [QuanHe], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2, N'L002      ', N'Sở Y Tế', N'L003,L004,L005                                                                                      ', 2, NULL, 1)
INSERT [dbo].[LoaiCoSo] ([LoaiCoSoId], [MaLoaiCoSo], [TenLoaiCoSo], [QuanHe], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3, N'L003      ', N'Bệnh viện tỉnh', N'L004,L005                                                                                           ', 2, NULL, 1)
INSERT [dbo].[LoaiCoSo] ([LoaiCoSoId], [MaLoaiCoSo], [TenLoaiCoSo], [QuanHe], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (4, N'L004      ', N'Bệnh viện huyện', N'L005                                                                                                ', 2, NULL, 1)
INSERT [dbo].[LoaiCoSo] ([LoaiCoSoId], [MaLoaiCoSo], [TenLoaiCoSo], [QuanHe], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (5, N'L005      ', N'Bệnh viện xã', NULL, 2, NULL, 1)
SET IDENTITY_INSERT [dbo].[LoaiCoSo] OFF
SET IDENTITY_INSERT [dbo].[LoaiTaiSan] ON 

INSERT [dbo].[LoaiTaiSan] ([LoaiId], [NhomId], [MaLoai], [TenLoai], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1, 1, N'I', N'Máy móc TB  chuyên dùng', NULL, 0, CAST(N'2017-08-10 15:03:47.957' AS DateTime), 2)
INSERT [dbo].[LoaiTaiSan] ([LoaiId], [NhomId], [MaLoai], [TenLoai], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2, 1, N'II', N'Máy móc đo lường thí nghiệm', NULL, 0, CAST(N'2017-08-10 16:57:37.807' AS DateTime), 3)
INSERT [dbo].[LoaiTaiSan] ([LoaiId], [NhomId], [MaLoai], [TenLoai], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (6, 1, N'mvt', N'Máy vi tính để bàn', NULL, 0, CAST(N'2017-10-25 15:10:36.850' AS DateTime), 1)
INSERT [dbo].[LoaiTaiSan] ([LoaiId], [NhomId], [MaLoai], [TenLoai], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (7, 1, N'ptvt', N'Phương tiện vận tải đường bộ', NULL, 0, CAST(N'2017-10-25 16:46:30.977' AS DateTime), 1)
INSERT [dbo].[LoaiTaiSan] ([LoaiId], [NhomId], [MaLoai], [TenLoai], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (8, 1, N'bgtk', N'Bộ bàn ghế tiếp khách', NULL, 0, CAST(N'2017-10-26 09:09:53.917' AS DateTime), 1)
INSERT [dbo].[LoaiTaiSan] ([LoaiId], [NhomId], [MaLoai], [TenLoai], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (9, 1, N'dt', N'Thiết bị điện và điện tử', NULL, 0, CAST(N'2017-10-26 09:35:18.720' AS DateTime), 4)
SET IDENTITY_INSERT [dbo].[LoaiTaiSan] OFF
INSERT [dbo].[LoaiXe] ([LoaiXeId], [NoiDung]) VALUES (1, N'Xe subcompact hay xe mini ')
INSERT [dbo].[LoaiXe] ([LoaiXeId], [NoiDung]) VALUES (2, N'Xe hạng nhỏ')
INSERT [dbo].[LoaiXe] ([LoaiXeId], [NoiDung]) VALUES (3, N'Xe hạng trung')
INSERT [dbo].[LoaiXe] ([LoaiXeId], [NoiDung]) VALUES (4, N'Xe hạng lớn')
SET IDENTITY_INSERT [dbo].[NguonNganSach] ON 

INSERT [dbo].[NguonNganSach] ([NguonNganSachId], [MaNguonNganSach], [TenNguonNganSach], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1, N'NS01                ', N'Nguồn bảo hiểm', NULL, 53, CAST(N'2017-08-15 08:22:58.557' AS DateTime), 4)
INSERT [dbo].[NguonNganSach] ([NguonNganSachId], [MaNguonNganSach], [TenNguonNganSach], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2, N'NS02', N'Nguồn ngân sách', NULL, 6, CAST(N'2017-09-01 14:19:39.790' AS DateTime), 3)
INSERT [dbo].[NguonNganSach] ([NguonNganSachId], [MaNguonNganSach], [TenNguonNganSach], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3, N'NS03', N'Nguồn chi không thường xuyên', NULL, 6, CAST(N'2017-09-01 14:19:55.360' AS DateTime), 4)
INSERT [dbo].[NguonNganSach] ([NguonNganSachId], [MaNguonNganSach], [TenNguonNganSach], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (4, N'NS04', N'Nguồn ngân sách viện trợ, tài trợ', NULL, 8, CAST(N'2017-10-16 08:57:35.743' AS DateTime), 3)
INSERT [dbo].[NguonNganSach] ([NguonNganSachId], [MaNguonNganSach], [TenNguonNganSach], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (5, N'NS05', N'Nguồn khác', NULL, 8, CAST(N'2017-10-25 16:06:46.270' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[NguonNganSach] OFF
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (1065, 1, CAST(9000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (1065, 2, CAST(4000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (1065, 3, CAST(6000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (1069, 1, CAST(9000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (1069, 2, CAST(5000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (1069, 3, CAST(2000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (1073, 1, CAST(100000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (1073, 2, CAST(350000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (1073, 3, CAST(2000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (2074, 2, CAST(460000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (2076, 2, CAST(12000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (2079, 2, CAST(1000000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (2081, 1, CAST(5000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (2082, 1, CAST(5000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (2082, 2, CAST(2000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (2083, 2, CAST(600000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (3081, 2, CAST(5000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (3082, 2, CAST(80000000.0000 AS Numeric(18, 4)))
INSERT [dbo].[NguyenGia] ([TaiSanId], [NguonNganSachId], [GiaTri]) VALUES (3083, 3, CAST(98000000.0000 AS Numeric(18, 4)))
SET IDENTITY_INSERT [dbo].[NhaCungCap] ON 

INSERT [dbo].[NhaCungCap] ([NhaCungCapId], [MaNhaCungCap], [TenNhaCungCap], [Nhom], [DienThoai], [DiDong], [MaSoThue], [TKNganHang], [TenNganHang], [DaiDien], [DiaChi], [GhiChu], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1, N'NCC01', N'Nguyễn Kim', N'TN', N'2', N'2', N'2', N'2', N'2', N'Nguyễn Ngọc Tân', N'2', N'2', 1, 53, CAST(N'2017-08-17 09:59:55.260' AS DateTime), 3)
INSERT [dbo].[NhaCungCap] ([NhaCungCapId], [MaNhaCungCap], [TenNhaCungCap], [Nhom], [DienThoai], [DiDong], [MaSoThue], [TKNganHang], [TenNganHang], [DaiDien], [DiaChi], [GhiChu], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3, N'NCC1', N'Thế giới di động', N'TN', N'213123', N'23123', N'23123', N'123', N'123', N'Vs', N'123', N'312', 17, 8, CAST(N'2017-10-14 09:18:29.237' AS DateTime), 1)
INSERT [dbo].[NhaCungCap] ([NhaCungCapId], [MaNhaCungCap], [TenNhaCungCap], [Nhom], [DienThoai], [DiDong], [MaSoThue], [TKNganHang], [TenNganHang], [DaiDien], [DiaChi], [GhiChu], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1003, N'Nha001', N'Nguyễn Kim', N'TN', N'123', N'123', N'123', N'123', N'acb', N'Khanh Nguyễn', NULL, NULL, 18, 3, CAST(N'2017-11-01 15:39:03.203' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[NhaCungCap] OFF
SET IDENTITY_INSERT [dbo].[NhanVien] ON 

INSERT [dbo].[NhanVien] ([NhanVienId], [MaNhanVien], [TenNhanVien], [ChucDanh], [DienThoai], [Email], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3, N'NV001', N'Nguyễn Ngọc Tân', NULL, N'0985401027', NULL, NULL, N'5', 53, CAST(N'2017-08-10 10:50:37.877' AS DateTime), 6)
INSERT [dbo].[NhanVien] ([NhanVienId], [MaNhanVien], [TenNhanVien], [ChucDanh], [DienThoai], [Email], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (4, N'NV002', N'Nguyễn Văn B', NULL, NULL, NULL, NULL, N'abc2', 53, CAST(N'2017-08-10 11:16:45.523' AS DateTime), 6)
INSERT [dbo].[NhanVien] ([NhanVienId], [MaNhanVien], [TenNhanVien], [ChucDanh], [DienThoai], [Email], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (5, N'NV003', N'Nguyễn Huy Thành', N'Nhân viên', N'0985401023', N'huythanh@ehis.vn', N'Biên hòa', NULL, 53, CAST(N'2017-08-14 08:51:23.580' AS DateTime), 1)
INSERT [dbo].[NhanVien] ([NhanVienId], [MaNhanVien], [TenNhanVien], [ChucDanh], [DienThoai], [Email], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (6, N'NV004', N'Nguyễn Thanh Bình', NULL, NULL, NULL, NULL, NULL, 3, CAST(N'2017-08-28 09:50:56.180' AS DateTime), 1)
INSERT [dbo].[NhanVien] ([NhanVienId], [MaNhanVien], [TenNhanVien], [ChucDanh], [DienThoai], [Email], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (7, N'NV005', N'Nguyễn Tiến Đạt', N'', N'', N'', N'', N'', 3, CAST(N'2017-08-28 09:52:02.620' AS DateTime), 2)
INSERT [dbo].[NhanVien] ([NhanVienId], [MaNhanVien], [TenNhanVien], [ChucDanh], [DienThoai], [Email], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (8, N'NV001', N'Phan Quốc Toản', N'Phó hành chính', NULL, N'QuocToan@dienbien.vn', NULL, NULL, 3, CAST(N'2017-09-29 09:13:19.127' AS DateTime), 1)
INSERT [dbo].[NhanVien] ([NhanVienId], [MaNhanVien], [TenNhanVien], [ChucDanh], [DienThoai], [Email], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (10, N'NV001', N'Thanh Bình', N'Giám đốc', NULL, NULL, NULL, NULL, 3, CAST(N'2017-10-10 11:47:55.843' AS DateTime), 1)
INSERT [dbo].[NhanVien] ([NhanVienId], [MaNhanVien], [TenNhanVien], [ChucDanh], [DienThoai], [Email], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (17, N'NV002', N'Phan Quốc Toản', N'Phó hành chính', N'0985401027', N'', N'38/40 Quang Trung, phường 10, quận Gò Vấp, Tp.HCM', N'', 7, CAST(N'2017-10-31 10:04:56.980' AS DateTime), 4)
INSERT [dbo].[NhanVien] ([NhanVienId], [MaNhanVien], [TenNhanVien], [ChucDanh], [DienThoai], [Email], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (20, N'NV001', N'Hoàng Huyền', N'Trưởng phòng It', N'09841023', N'hoanghuyen@dienbien.vn', N'', N'', 7, CAST(N'2017-11-01 14:31:52.660' AS DateTime), 2)
INSERT [dbo].[NhanVien] ([NhanVienId], [MaNhanVien], [TenNhanVien], [ChucDanh], [DienThoai], [Email], [DiaChi], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (21, N'NV003', N'Nguyễn Ngọc Tân', N'Nhân viên', N'0985401027', N'', N'', N'', 7, CAST(N'2017-11-01 14:32:27.213' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
SET IDENTITY_INSERT [dbo].[NhomTaiSan] ON 

INSERT [dbo].[NhomTaiSan] ([NhomId], [MaNhom], [TenNhom], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1, N'A', N'Tài sản cố định', NULL, 53, CAST(N'2017-08-10 14:26:13.847' AS DateTime), 4)
INSERT [dbo].[NhomTaiSan] ([NhomId], [MaNhom], [TenNhom], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2, N'B', N'Tài sản lâu bền', NULL, 53, CAST(N'2017-08-10 14:30:06.250' AS DateTime), 4)
SET IDENTITY_INSERT [dbo].[NhomTaiSan] OFF
SET IDENTITY_INSERT [dbo].[NuocSanXuat] ON 

INSERT [dbo].[NuocSanXuat] ([NuocSanXuatId], [MaNuocSanXuat], [TenNuocSanXuat], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1, N'NUOC01', N'Việt Nam', N'Việt nam', 53, CAST(N'2017-08-15 17:04:07.530' AS DateTime), 2)
INSERT [dbo].[NuocSanXuat] ([NuocSanXuatId], [MaNuocSanXuat], [TenNuocSanXuat], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2, N'NUOC02', N'Nhật', N'Nhật', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[NuocSanXuat] OFF
SET IDENTITY_INSERT [dbo].[PhanLoai] ON 

INSERT [dbo].[PhanLoai] ([PhanLoaiId], [TenPhanLoai]) VALUES (1, N'Đề nghị')
INSERT [dbo].[PhanLoai] ([PhanLoaiId], [TenPhanLoai]) VALUES (2, N'Quyết định')
INSERT [dbo].[PhanLoai] ([PhanLoaiId], [TenPhanLoai]) VALUES (3, N'Khác')
SET IDENTITY_INSERT [dbo].[PhanLoai] OFF
SET IDENTITY_INSERT [dbo].[PhongBan] ON 

INSERT [dbo].[PhongBan] ([PhongBanId], [CoSoId], [MaPhongBan], [TenPhongBan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (5, 1, N'P001', N'Phòng số 1', NULL, 53, CAST(N'2017-08-09 09:39:36.480' AS DateTime), 15)
INSERT [dbo].[PhongBan] ([PhongBanId], [CoSoId], [MaPhongBan], [TenPhongBan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (6, 1, N'P002', N'Phòng số 2', NULL, 53, CAST(N'2017-08-09 09:39:36.480' AS DateTime), 21)
INSERT [dbo].[PhongBan] ([PhongBanId], [CoSoId], [MaPhongBan], [TenPhongBan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (7, 1, N'P003', N'Phòng số 3', NULL, 53, CAST(N'2017-08-09 09:39:36.480' AS DateTime), 15)
INSERT [dbo].[PhongBan] ([PhongBanId], [CoSoId], [MaPhongBan], [TenPhongBan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (8, 1, N'P004', N'Phòng số 4', NULL, 53, CAST(N'2017-08-09 09:39:36.480' AS DateTime), 12)
INSERT [dbo].[PhongBan] ([PhongBanId], [CoSoId], [MaPhongBan], [TenPhongBan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (10, 17, N'KHOA01', N'Khoa Nội', NULL, 3, CAST(N'2017-09-29 09:10:38.967' AS DateTime), 1)
INSERT [dbo].[PhongBan] ([PhongBanId], [CoSoId], [MaPhongBan], [TenPhongBan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (11, 17, N'KHOA002', N'Khoa Ngoại', NULL, 3, CAST(N'2017-09-29 09:21:58.880' AS DateTime), 1)
INSERT [dbo].[PhongBan] ([PhongBanId], [CoSoId], [MaPhongBan], [TenPhongBan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (13, 15, N'P001', N'Phòng Số 1', NULL, 6, NULL, NULL)
INSERT [dbo].[PhongBan] ([PhongBanId], [CoSoId], [MaPhongBan], [TenPhongBan], [GhiChu], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (14, 16, N'P001', N'Phòng Hành Chính', NULL, 3, CAST(N'2017-10-10 11:47:34.870' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[PhongBan] OFF
INSERT [dbo].[PhongBanNhanVien] ([PhongBanId], [NhanVienId], [CoSoId]) VALUES (5, 3, 1)
INSERT [dbo].[PhongBanNhanVien] ([PhongBanId], [NhanVienId], [CoSoId]) VALUES (5, 6, 1)
INSERT [dbo].[PhongBanNhanVien] ([PhongBanId], [NhanVienId], [CoSoId]) VALUES (5, 7, 1)
INSERT [dbo].[PhongBanNhanVien] ([PhongBanId], [NhanVienId], [CoSoId]) VALUES (6, 4, 1)
INSERT [dbo].[PhongBanNhanVien] ([PhongBanId], [NhanVienId], [CoSoId]) VALUES (6, 7, 1)
INSERT [dbo].[PhongBanNhanVien] ([PhongBanId], [NhanVienId], [CoSoId]) VALUES (10, 17, 17)
INSERT [dbo].[PhongBanNhanVien] ([PhongBanId], [NhanVienId], [CoSoId]) VALUES (10, 21, 17)
INSERT [dbo].[PhongBanNhanVien] ([PhongBanId], [NhanVienId], [CoSoId]) VALUES (11, 20, 17)
INSERT [dbo].[PhongBanNhanVien] ([PhongBanId], [NhanVienId], [CoSoId]) VALUES (11, 21, 17)
INSERT [dbo].[PhuongThuc] ([PhuongThucId], [TenPhuongThuc]) VALUES (1, N'Mua sắm')
INSERT [dbo].[PhuongThuc] ([PhuongThucId], [TenPhuongThuc]) VALUES (2, N'Nhận bằng hiện vật')
INSERT [dbo].[PhuongThuc] ([PhuongThucId], [TenPhuongThuc]) VALUES (3, N'Xây mới')
SET IDENTITY_INSERT [dbo].[SuaChua] ON 

INSERT [dbo].[SuaChua] ([SuaChuaId], [BaoDuongId], [TenBoPhan], [NgayBatDau], [NgayKetThuc], [ChiPhi], [NoiDung], [NoiSua], [KetQua]) VALUES (2129, 2015, N'2', CAST(N'2017-11-03 00:00:00.000' AS DateTime), CAST(N'2017-11-03 00:00:00.000' AS DateTime), CAST(2.0000 AS Numeric(18, 4)), N'2', N'2', N'2')
SET IDENTITY_INSERT [dbo].[SuaChua] OFF
SET IDENTITY_INSERT [dbo].[TaiSan] ON 

INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (27, N'Ghe001', N'ww2222', N'Cái', 1, 1, CAST(1 AS Numeric(4, 0)), 1, 2, N'1                                                 ', N'1', 1, CAST(N'2017-08-22 00:00:00.000' AS DateTime), CAST(N'2017-08-22 00:00:00.000' AS DateTime), 1, CAST(10.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), CAST(N'2017-08-22 00:00:00.000' AS DateTime), N'Tháng', NULL, CAST(1 AS Numeric(5, 0)), CAST(1.00 AS Numeric(5, 2)), CAST(20030.0000 AS Numeric(18, 4)), 1, 1, NULL, NULL, NULL)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1061, N'May001', N'Máy hút dịch chạy điện', N'Cái', 1, 1, CAST(1 AS Numeric(4, 0)), 1, 2, N'1                                                 ', N'1', 1, CAST(N'2017-08-22 00:00:00.000' AS DateTime), CAST(N'2017-08-22 00:00:00.000' AS DateTime), 1, CAST(100.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), NULL, N'1', NULL, NULL, CAST(1.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), 2, 1, NULL, NULL, NULL)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1064, N'May002', N'Máy trợ thở OXY', N'Cái', 1, 1, CAST(1 AS Numeric(4, 0)), 1, 2, N'1                                                 ', N'1', 1, CAST(N'2017-08-22 00:00:00.000' AS DateTime), CAST(N'2017-08-22 00:00:00.000' AS DateTime), 1, CAST(100.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), CAST(N'2017-08-22 00:00:00.000' AS DateTime), N'Tháng', NULL, CAST(1 AS Numeric(5, 0)), CAST(1.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), 3, 1, NULL, NULL, NULL)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1065, N'Bon001', N'Bơm tiêm điện Terumo', N'Cái', 1, 1, CAST(1 AS Numeric(4, 0)), 1, 2, N'1                                                 ', N'1', 1, CAST(N'2014-08-22 00:00:00.000' AS DateTime), CAST(N'2014-09-11 00:00:00.000' AS DateTime), 5, CAST(5.00 AS Numeric(5, 2)), CAST(2850000.0000 AS Numeric(18, 4)), CAST(N'2014-09-11 00:00:00.000' AS DateTime), N'Tháng', NULL, CAST(10 AS Numeric(5, 0)), CAST(1.00 AS Numeric(5, 2)), CAST(1900000.0000 AS Numeric(18, 4)), 4, 1, NULL, NULL, NULL)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1068, N'Kinh001', N'Kính hiển vi mới', N'Cái', 2, 1, CAST(1 AS Numeric(4, 0)), 1, 2, N'1', N'1', 1, CAST(N'2017-09-21 00:00:00.000' AS DateTime), CAST(N'2017-09-21 00:00:00.000' AS DateTime), 5, CAST(20.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), CAST(N'2017-09-21 00:00:00.000' AS DateTime), N'Tháng', NULL, CAST(1 AS Numeric(5, 0)), CAST(1.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), 1, 1, NULL, NULL, NULL)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1069, N'XN001', N'Máy xét nghiệm sinh hoá', N'Cái', 1, 1, CAST(2012 AS Numeric(4, 0)), 1, 2, N'QDTC1', N'SamSum', 1, CAST(N'2017-09-15 00:00:00.000' AS DateTime), CAST(N'2017-09-15 00:00:00.000' AS DateTime), 5, CAST(20.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), CAST(N'2017-08-15 00:00:00.000' AS DateTime), N'Tháng', NULL, CAST(10 AS Numeric(5, 0)), CAST(10.00 AS Numeric(5, 2)), CAST(1600000.0000 AS Numeric(18, 4)), 2, 1, 3, CAST(N'2017-09-15 13:51:35.493' AS DateTime), 3)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (1073, N'MAY004', N'Máy Tính Dell', N'Cái', 2, 2, CAST(2013 AS Numeric(4, 0)), 1, 2, N'2', N'VI', 1, CAST(N'2017-10-14 00:00:00.000' AS DateTime), CAST(N'2017-10-14 00:00:00.000' AS DateTime), 1, CAST(10.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), CAST(N'2017-10-14 00:00:00.000' AS DateTime), N'Tháng', NULL, CAST(1 AS Numeric(5, 0)), CAST(10.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), 2, 1, 8, CAST(N'2017-10-14 09:12:49.103' AS DateTime), 4)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2074, N'SX2001', N'Máy XQ TOSIBA', NULL, 2, 1, CAST(2003 AS Numeric(4, 0)), 2, 1004, NULL, NULL, 1003, CAST(N'2017-10-17 00:00:00.000' AS DateTime), CAST(N'2017-10-17 00:00:00.000' AS DateTime), 1, CAST(12.50 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), CAST(N'2017-10-17 00:00:00.000' AS DateTime), N'Năm', NULL, CAST(1 AS Numeric(5, 0)), CAST(12.50 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), 0, 1, 6, CAST(N'2017-10-17 08:56:40.653' AS DateTime), 3)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2076, N'mvt', N'Máy vi tính để bàn HP.', N'Cái', 6, 1, CAST(2016 AS Numeric(4, 0)), 2, 2, NULL, N'Hp', 1, CAST(N'2016-01-01 00:00:00.000' AS DateTime), CAST(N'2016-01-01 00:00:00.000' AS DateTime), 5, CAST(20.00 AS Numeric(5, 2)), CAST(2400000.0000 AS Numeric(18, 4)), CAST(N'2016-01-01 00:00:00.000' AS DateTime), N'Năm', NULL, CAST(5 AS Numeric(5, 0)), CAST(20.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), 0, 17, 8, CAST(N'2017-10-25 16:26:25.343' AS DateTime), 6)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2079, N'oto', N'Xe Toyota 4 chỗ', N'Chiếc', 7, 1, CAST(2015 AS Numeric(4, 0)), 2, 1004, NULL, N'Toyota', 1, CAST(N'2015-01-01 00:00:00.000' AS DateTime), CAST(N'2015-01-01 00:00:00.000' AS DateTime), 10, CAST(7.00 AS Numeric(5, 2)), CAST(140000000.0000 AS Numeric(18, 4)), CAST(N'2015-01-01 00:00:00.000' AS DateTime), N'Năm', NULL, CAST(15 AS Numeric(5, 0)), CAST(6.67 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), 3, 17, 8, CAST(N'2017-10-26 08:45:23.793' AS DateTime), 3)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2081, N'bgtp', N'bàn salong', N'Bộ', 8, 1, CAST(2017 AS Numeric(4, 0)), 1, 3, NULL, N'Dell', 1, CAST(N'2017-08-01 00:00:00.000' AS DateTime), CAST(N'2017-08-01 00:00:00.000' AS DateTime), 8, CAST(12.50 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), CAST(N'2017-08-01 00:00:00.000' AS DateTime), N'Năm', NULL, CAST(8 AS Numeric(5, 0)), CAST(12.50 AS Numeric(5, 2)), CAST(625000.0000 AS Numeric(18, 4)), 0, 17, 8, CAST(N'2017-10-26 09:23:29.253' AS DateTime), 1)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2082, N'tivi1', N'Tivi LCD 42 ich', N'Cái', 9, 1, CAST(2016 AS Numeric(4, 0)), 2, 1004, NULL, N'Toshiba', 3, CAST(N'2017-07-01 00:00:00.000' AS DateTime), CAST(N'2017-07-01 00:00:00.000' AS DateTime), 5, CAST(20.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), CAST(N'2017-07-01 00:00:00.000' AS DateTime), N'Năm', NULL, CAST(5 AS Numeric(5, 0)), CAST(20.00 AS Numeric(5, 2)), CAST(1400000.0000 AS Numeric(18, 4)), 0, 17, 8, CAST(N'2017-10-26 09:38:15.913' AS DateTime), 1)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (2083, N'citi', N'Máy Citi', N'Cái', 1, 1, CAST(2016 AS Numeric(4, 0)), 2, 1004, NULL, N'to9ishiba', 3, CAST(N'2016-08-15 00:00:00.000' AS DateTime), CAST(N'2016-09-01 00:00:00.000' AS DateTime), 7, CAST(12.50 AS Numeric(5, 2)), CAST(75000000.0000 AS Numeric(18, 4)), CAST(N'2016-09-01 00:00:00.000' AS DateTime), N'Năm', NULL, CAST(8 AS Numeric(5, 0)), CAST(12.50 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), 4, 17, 8, CAST(N'2017-10-26 14:31:31.327' AS DateTime), 2)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3081, N'G001', N'Giường đón trẻ sơ sinh đa năng', N'Chiếc', 1, 1, CAST(2009 AS Numeric(4, 0)), 1, NULL, N'123', NULL, 1003, CAST(N'2009-01-01 00:00:00.000' AS DateTime), CAST(N'2009-01-01 00:00:00.000' AS DateTime), 10, CAST(10.00 AS Numeric(5, 2)), CAST(4000000.0000 AS Numeric(18, 4)), CAST(N'2017-11-01 00:00:00.000' AS DateTime), N'Tháng', NULL, CAST(1 AS Numeric(5, 0)), CAST(10.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), 0, 18, 3, CAST(N'2017-11-01 15:14:20.517' AS DateTime), 1)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3082, N'May001', N'Máy soi đáy mắt cầm tay RI-scope L', N'Cái', 2, 1, CAST(2010 AS Numeric(4, 0)), 1, NULL, N'321', NULL, NULL, CAST(N'2010-01-01 00:00:00.000' AS DateTime), CAST(N'2010-01-01 00:00:00.000' AS DateTime), 10, CAST(10.00 AS Numeric(5, 2)), CAST(56000000.0000 AS Numeric(18, 4)), CAST(N'2017-11-01 00:00:00.000' AS DateTime), N'Tháng', NULL, CAST(1 AS Numeric(5, 0)), CAST(10.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), 0, 18, 3, CAST(N'2017-11-01 15:18:30.290' AS DateTime), 1)
INSERT [dbo].[TaiSan] ([TaiSanId], [MaTaiSan], [TenTaiSan], [DonViTinh], [LoaiId], [PhuongThucId], [NamSanXuat], [NuocSanXuatId], [HangSanXuatId], [SoQDTC], [NhanHieu], [DuAnId], [NgayMua], [NgayBDHaoMon], [SoNamSuDung], [TyLeHaoMon], [HaoMonLuyKe], [NgayBDKhauHao], [KyTinhKhauHao], [GiaTriKhauHao], [SoKyKhauHao], [TyLeKhauHao], [KhauHaoLuyKe], [LoaiKeKhai], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (3083, N'MayXN', N'Máy XN sinh hoá', N'Cái', 6, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2012-01-01 00:00:00.000' AS DateTime), CAST(N'2012-01-01 00:00:00.000' AS DateTime), 25, CAST(10.00 AS Numeric(5, 2)), CAST(49000000.0000 AS Numeric(18, 4)), CAST(N'2017-11-01 00:00:00.000' AS DateTime), N'Tháng', NULL, CAST(1 AS Numeric(5, 0)), CAST(10.00 AS Numeric(5, 2)), CAST(0.0000 AS Numeric(18, 4)), 0, 18, 3, CAST(N'2017-11-01 15:20:29.783' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TaiSan] OFF
SET IDENTITY_INSERT [dbo].[ThayDoiThongTin] ON 

INSERT [dbo].[ThayDoiThongTin] ([ThayDoiThongTinId], [TaiSanId], [Ngay], [TenTaiSanCu], [LyDo], [DuyetId], [NguoiDuyet], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (80, 1061, CAST(N'2017-09-14 00:00:00.000' AS DateTime), NULL, N'', NULL, 3, 1, 3, CAST(N'2017-09-23 09:20:28.427' AS DateTime), 11)
INSERT [dbo].[ThayDoiThongTin] ([ThayDoiThongTinId], [TaiSanId], [Ngay], [TenTaiSanCu], [LyDo], [DuyetId], [NguoiDuyet], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (81, 27, CAST(N'2017-09-28 00:00:00.000' AS DateTime), N'Ghế răng Diplomat 3', N'123', NULL, 6, 1, 6, CAST(N'2017-09-28 11:40:03.170' AS DateTime), 3)
INSERT [dbo].[ThayDoiThongTin] ([ThayDoiThongTinId], [TaiSanId], [Ngay], [TenTaiSanCu], [LyDo], [DuyetId], [NguoiDuyet], [CoSoId], [NguoiTao], [NgayTao], [CtrVersion]) VALUES (83, 1065, CAST(N'2017-09-28 00:00:00.000' AS DateTime), N'Bơm tiêm điện Terumo 1', N'trên 500', NULL, 6, 1, 6, CAST(N'2017-09-28 15:39:01.293' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[ThayDoiThongTin] OFF
INSERT [dbo].[ThayDoiThongTin_Dat] ([ThayDoiThongTinId], [DiaChiCu], [GiayToCu], [DienTichCu], [LamTruSoCu], [CoSoHDSuNghiepCu], [NhaOCu], [ChoThueCu], [BoTrongCu], [BiLanChiemCu], [SuDungKhacCu]) VALUES (81, N'22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ThayDoiThongTin_Nha] ([ThayDoiThongTinId], [DiaChiCu], [GiayToCu], [CapHangCu], [SoTangCu], [NamSuDungCu], [DienTichCu], [TongDienTichSanCu], [LamTruSoCu], [CoSoHDSuNghiepCu], [NhaOCu], [ChoThueCu], [BoTrongCu], [BiLanChiemCu], [SuDungKhacCu]) VALUES (80, N'2121', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(22.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThayDoiThongTin_Tren500] ([ThayDoiThongTinId], [KyHieuCu], [HienTrangSuDungCu]) VALUES (83, N'Skin LOL 1', NULL)
INSERT [dbo].[TheoDoi] ([TaiSanId], [NgayGhiTang], [NgayTrangCap], [NgayBatDauSuDung], [PhongBanId], [NhanVienId], [SLTon], [SLTang], [SLGiam], [Nam], [HopDongId]) VALUES (27, CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-11-01 00:00:00.000' AS DateTime), 5, 3, CAST(0.0000 AS Numeric(18, 4)), CAST(100.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(2017 AS Numeric(4, 0)), 1)
INSERT [dbo].[TheoDoi] ([TaiSanId], [NgayGhiTang], [NgayTrangCap], [NgayBatDauSuDung], [PhongBanId], [NhanVienId], [SLTon], [SLTang], [SLGiam], [Nam], [HopDongId]) VALUES (27, CAST(N'2017-11-03 00:00:00.000' AS DateTime), CAST(N'2017-11-03 00:00:00.000' AS DateTime), CAST(N'2017-11-03 00:00:00.000' AS DateTime), 6, 7, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(2017 AS Numeric(4, 0)), NULL)
INSERT [dbo].[TheoDoi] ([TaiSanId], [NgayGhiTang], [NgayTrangCap], [NgayBatDauSuDung], [PhongBanId], [NhanVienId], [SLTon], [SLTang], [SLGiam], [Nam], [HopDongId]) VALUES (1061, CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-11-01 00:00:00.000' AS DateTime), 5, 3, CAST(1.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(2017 AS Numeric(4, 0)), 1)
INSERT [dbo].[TheoDoi] ([TaiSanId], [NgayGhiTang], [NgayTrangCap], [NgayBatDauSuDung], [PhongBanId], [NhanVienId], [SLTon], [SLTang], [SLGiam], [Nam], [HopDongId]) VALUES (1061, CAST(N'2017-11-03 00:00:00.000' AS DateTime), CAST(N'2017-11-03 00:00:00.000' AS DateTime), CAST(N'2017-11-03 00:00:00.000' AS DateTime), 6, 7, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(2017 AS Numeric(4, 0)), 1)
INSERT [dbo].[TheoDoi] ([TaiSanId], [NgayGhiTang], [NgayTrangCap], [NgayBatDauSuDung], [PhongBanId], [NhanVienId], [SLTon], [SLTang], [SLGiam], [Nam], [HopDongId]) VALUES (1065, CAST(N'2017-11-02 00:00:00.000' AS DateTime), CAST(N'2017-11-02 00:00:00.000' AS DateTime), CAST(N'2017-11-02 00:00:00.000' AS DateTime), 5, 3, CAST(0.0000 AS Numeric(18, 4)), CAST(90.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(2017 AS Numeric(4, 0)), 1)
INSERT [dbo].[TheoDoi] ([TaiSanId], [NgayGhiTang], [NgayTrangCap], [NgayBatDauSuDung], [PhongBanId], [NhanVienId], [SLTon], [SLTang], [SLGiam], [Nam], [HopDongId]) VALUES (1069, CAST(N'2017-11-02 00:00:00.000' AS DateTime), CAST(N'2017-11-02 00:00:00.000' AS DateTime), CAST(N'2017-11-02 00:00:00.000' AS DateTime), 5, 3, CAST(0.0000 AS Numeric(18, 4)), CAST(20.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(2017 AS Numeric(4, 0)), 1)
SET IDENTITY_INSERT [dbo].[ThongBao] ON 

INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (6, N'Duyệt đề nghị trang cấp', CAST(N'2017-10-13 10:31:55.983' AS DateTime), 1, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (7, N'Duyệt đề nghị trang cấp', CAST(N'2017-10-13 13:48:06.980' AS DateTime), 1, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (8, N'Duyệt đề nghị trang cấp', CAST(N'2017-10-13 11:48:06.980' AS DateTime), 1, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (9, N'Duyệt đề nghị trang cấp', CAST(N'2017-10-12 11:50:06.980' AS DateTime), 1, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (10, N'Duyệt đề nghị trang cấp', CAST(N'2017-10-13 13:30:06.980' AS DateTime), 1, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (11, N'Duyệt đề nghị trang cấp', CAST(N'2017-10-13 14:00:06.980' AS DateTime), 1, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (12, N'Duyệt báo cáo', CAST(N'2017-10-13 14:28:32.413' AS DateTime), 1, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (13, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 14:40:35.387' AS DateTime), 1, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (14, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 14:40:35.387' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (15, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 14:42:36.357' AS DateTime), 1, 17)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (16, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 14:42:36.357' AS DateTime), 0, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (17, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 14:42:43.827' AS DateTime), 0, 17)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (18, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 14:42:43.827' AS DateTime), 0, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (19, N'Duyệt đề nghị trang cấp', CAST(N'2017-10-13 14:52:14.387' AS DateTime), 1, 17)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (20, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 14:52:47.890' AS DateTime), 1, 17)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (21, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 14:52:47.890' AS DateTime), 1, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (22, N'Duyệt đề nghị trang cấp', CAST(N'2017-10-13 16:00:24.513' AS DateTime), 1, 17)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (23, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 16:07:59.140' AS DateTime), 1, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (24, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 15:07:59.140' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (25, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 15:09:05.247' AS DateTime), 1, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (26, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 15:09:05.247' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (27, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 15:10:10.033' AS DateTime), 1, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (28, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 15:10:10.033' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (29, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 15:10:13.267' AS DateTime), 1, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (30, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 15:10:13.267' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (31, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 15:10:18.940' AS DateTime), 1, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (32, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-13 15:10:18.940' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (33, N'Duyệt báo cáo', CAST(N'2017-10-13 15:12:05.460' AS DateTime), 0, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (1002, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-16 09:14:49.120' AS DateTime), 0, 17)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (1003, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-16 09:14:49.120' AS DateTime), 1, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (1004, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-17 08:22:08.560' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (1005, N'Duyệt báo cáo', CAST(N'2017-10-17 14:31:24.827' AS DateTime), 1, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (1006, N'Duyệt đề nghị trang cấp', CAST(N'2017-10-27 08:50:39.407' AS DateTime), 1, 17)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (1007, N'Duyệt đề nghị trang cấp', CAST(N'2017-10-27 09:11:28.570' AS DateTime), 1, 17)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2006, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-27 14:14:03.077' AS DateTime), 1, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2007, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-27 14:16:37.537' AS DateTime), 0, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2008, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-27 14:18:04.580' AS DateTime), 0, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2009, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-27 14:18:08.537' AS DateTime), 0, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2010, N'Duyệt báo cáo', CAST(N'2017-10-27 18:13:56.627' AS DateTime), 0, 17)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2011, N'Duyệt báo cáo', CAST(N'2017-10-27 18:14:16.203' AS DateTime), 1, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2012, N'Duyệt kế hoạch mua sắm', CAST(N'2017-10-28 09:00:58.700' AS DateTime), 0, 16)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2013, N'Duyệt kế hoạch mua sắm', CAST(N'2017-11-02 15:25:40.667' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2014, N'Duyệt kế hoạch mua sắm', CAST(N'2017-11-03 08:32:02.220' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2015, N'Duyệt kế hoạch mua sắm', CAST(N'2017-11-03 08:43:46.457' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2016, N'Duyệt kế hoạch mua sắm', CAST(N'2017-11-03 08:44:10.210' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2017, N'Duyệt kế hoạch mua sắm', CAST(N'2017-11-03 08:47:07.257' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2018, N'Duyệt kế hoạch mua sắm', CAST(N'2017-11-03 08:47:56.603' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2019, N'Duyệt kế hoạch mua sắm', CAST(N'2017-11-03 08:50:57.030' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2020, N'Duyệt kế hoạch mua sắm', CAST(N'2017-11-03 08:55:48.497' AS DateTime), 0, 0)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2021, N'Duyệt đề nghị trang cấp', CAST(N'2017-11-03 09:28:30.733' AS DateTime), 0, 1)
INSERT [dbo].[ThongBao] ([ThongBaoId], [TenThongBao], [NgayTao], [TrangThai], [CoSoId]) VALUES (2022, N'Duyệt kế hoạch mua sắm', CAST(N'2017-11-03 14:07:27.520' AS DateTime), 0, 0)
SET IDENTITY_INSERT [dbo].[ThongBao] OFF
INSERT [dbo].[ThongSo] ([ThongSoId], [Loai], [Ten], [TaiSan]) VALUES (1, N'SoLieuThangNam', N'1217', N'LB')
INSERT [dbo].[ThongSo] ([ThongSoId], [Loai], [Ten], [TaiSan]) VALUES (2, N'SoLieuNam', N'2017', N'CD')
INSERT [dbo].[ThongSoUser] ([ThongSoId], [NhanVienId], [Loai], [Ten]) VALUES (1, 3, N'SoLieuThangNam', N'1217')
INSERT [dbo].[ThongSoUser] ([ThongSoId], [NhanVienId], [Loai], [Ten]) VALUES (2, 3, N'SoLieuNam', N'2017')
INSERT [dbo].[ThongSoUser] ([ThongSoId], [NhanVienId], [Loai], [Ten]) VALUES (1, 8, N'SoLieuThangNam', N'1117')
INSERT [dbo].[ThongSoUser] ([ThongSoId], [NhanVienId], [Loai], [Ten]) VALUES (2, 8, N'SoLieuNam', N'2016')
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (27, N'12', N'', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (1061, N'1111', N'', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (1064, N'Mazda', N'', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (1065, N'abc', N'', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (1068, N'12', N'', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (1069, N'aaaaa', N'', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (1073, N'Máy tính dell', N'Chơi game', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (2074, N'Model:DS-TA_5A, SN:D1612575', N'', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 1)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (2076, N'Bộ xử lý Công nghệ CPU Intel Celeron Loại CPU	N3350 Tốc độ CPU	1.10 GHz Tốc độ tối đa	Burst Frequency 2.4 GHz Tốc độ Bus	2400 MHz', N'Sử dụng làm việc', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), 3)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (2079, N'Xe Toyota 4 chỗ  màu đen', N'Phục vụ giám đốc', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (2081, N'bàn salong 4 chỗ', N'tiếp khách', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (2082, N'Tivi LCD 42 ich hiệu toshiba', N'Phục vụ bệnh nhân', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (2083, N'Máy citi bệnh nhân', N'khám chữa bệnh', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (3081, N'Giường bệnh nhân', N'', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (3082, N'Máy', N'', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinCongKhai] ([TaiSanId], [MoTa], [MucDich], [HienTrangSuDungId], [DonGia], [NopNganSach], [DeLaiDonVi], [HHCK], [NhaCungCapId]) VALUES (3083, N'máy xet nghiệm', N'', NULL, CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), CAST(0.0000 AS Numeric(18, 4)), NULL)
INSERT [dbo].[ThongTinKeKhai_Dat] ([TaiSanId], [DiaChi], [GiayTo], [DienTich], [LamTruSo], [CoSoHDSuNghiep], [NhaO], [ChoThue], [BoTrong], [BiLanChiem], [SuDungKhac]) VALUES (27, N'GÒ VẤP', N'- sổ hồng
- bảng vẽ', CAST(165.0000 AS Numeric(18, 4)), CAST(33.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)))
INSERT [dbo].[ThongTinKeKhai_Dat] ([TaiSanId], [DiaChi], [GiayTo], [DienTich], [LamTruSo], [CoSoHDSuNghiep], [NhaO], [ChoThue], [BoTrong], [BiLanChiem], [SuDungKhac]) VALUES (1068, N'123', N'21313
hi
hello', CAST(84.0000 AS Numeric(18, 4)), CAST(12.0000 AS Numeric(18, 4)), CAST(12.0000 AS Numeric(18, 4)), CAST(12.0000 AS Numeric(18, 4)), CAST(12.0000 AS Numeric(18, 4)), CAST(12.0000 AS Numeric(18, 4)), CAST(12.0000 AS Numeric(18, 4)), CAST(12.0000 AS Numeric(18, 4)))
INSERT [dbo].[ThongTinKeKhai_Nha] ([TaiSanId], [ThuocDat], [DiaChi], [GiayTo], [CapHang], [SoTang], [NamSuDung], [DienTich], [TongDienTichSan], [LamTruSo], [CoSoHDSuNghiep], [NhaO], [ChoThue], [BoTrong], [BiLanChiem], [SuDungKhac]) VALUES (1061, 27, N'quang trung', N'1212', 1, 1, CAST(1 AS Numeric(4, 0)), CAST(22.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(44.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)))
INSERT [dbo].[ThongTinKeKhai_Nha] ([TaiSanId], [ThuocDat], [DiaChi], [GiayTo], [CapHang], [SoTang], [NamSuDung], [DienTich], [TongDienTichSan], [LamTruSo], [CoSoHDSuNghiep], [NhaO], [ChoThue], [BoTrong], [BiLanChiem], [SuDungKhac]) VALUES (1069, 1068, N'tét report', N'', 2, 2, CAST(2 AS Numeric(4, 0)), CAST(2.0000 AS Numeric(18, 4)), CAST(2.0000 AS Numeric(18, 4)), CAST(2.0000 AS Numeric(18, 4)), CAST(2.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(2.0000 AS Numeric(18, 4)), CAST(2.0000 AS Numeric(18, 4)), CAST(22.0000 AS Numeric(18, 4)), CAST(2.0000 AS Numeric(18, 4)))
INSERT [dbo].[ThongTinKeKhai_Nha] ([TaiSanId], [ThuocDat], [DiaChi], [GiayTo], [CapHang], [SoTang], [NamSuDung], [DienTich], [TongDienTichSan], [LamTruSo], [CoSoHDSuNghiep], [NhaO], [ChoThue], [BoTrong], [BiLanChiem], [SuDungKhac]) VALUES (1073, 27, N'TEST REPORT', N'', 1, 10, CAST(10 AS Numeric(4, 0)), CAST(10.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)), CAST(10.0000 AS Numeric(18, 4)))
INSERT [dbo].[ThongTinKeKhai_Oto] ([TaiSanId], [NhanHieu], [BienKiemSoat], [CongSuatXe], [TrongTai], [ChucDanh], [NguonGocXe], [LoaiXe], [HienTrangSuDung]) VALUES (1064, N'Garen', N'123456', CAST(1000 AS Numeric(8, 0)), CAST(1000 AS Numeric(8, 0)), N'đấu sĩ', N'demacia', 3, 3)
INSERT [dbo].[ThongTinKeKhai_Oto] ([TaiSanId], [NhanHieu], [BienKiemSoat], [CongSuatXe], [TrongTai], [ChucDanh], [NguonGocXe], [LoaiXe], [HienTrangSuDung]) VALUES (2079, N'2', N'2', CAST(2 AS Numeric(8, 0)), CAST(2 AS Numeric(8, 0)), N'', N'', 2, 4)
INSERT [dbo].[ThongTinKeKhai_Tren500] ([TaiSanId], [KyHieu], [HienTrangSuDung]) VALUES (1065, N'Skin LOL', 4)
INSERT [dbo].[ThongTinKeKhai_Tren500] ([TaiSanId], [KyHieu], [HienTrangSuDung]) VALUES (2083, N'sdsds', 3)
INSERT [dbo].[XuLy] ([XuLyId], [TenXuLy]) VALUES (1, N'Điều chuyển')
INSERT [dbo].[XuLy] ([XuLyId], [TenXuLy]) VALUES (2, N'Bán đấu giá')
INSERT [dbo].[XuLy] ([XuLyId], [TenXuLy]) VALUES (3, N'Chỉ định')
INSERT [dbo].[XuLy] ([XuLyId], [TenXuLy]) VALUES (4, N'Chuyển nhượng')
INSERT [dbo].[XuLy] ([XuLyId], [TenXuLy]) VALUES (5, N'Thanh lý -  Tiêu hủy')
INSERT [dbo].[XuLy] ([XuLyId], [TenXuLy]) VALUES (6, N'Hình thức khác')
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ThongSo]    Script Date: 11/3/2017 3:35:52 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ThongSo] ON [dbo].[ThongSo]
(
	[Loai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DeNghiTrangCap] ADD  CONSTRAINT [DF_DeNghiTrangCap_GuiCapTren]  DEFAULT ((0)) FOR [GuiCapTren]
GO
ALTER TABLE [dbo].[DeNghiTrangCapChiTiet] ADD  CONSTRAINT [DF_DeNghiTrangCapChiTiet_DuyetId]  DEFAULT ((0)) FOR [DuyetId]
GO
ALTER TABLE [dbo].[BanKiemKe]  WITH CHECK ADD  CONSTRAINT [FK_BanKiemKe_BienBanKiemKe] FOREIGN KEY([BienBanKiemKeId])
REFERENCES [dbo].[BienBanKiemKe] ([BienBanKiemKeId])
GO
ALTER TABLE [dbo].[BanKiemKe] CHECK CONSTRAINT [FK_BanKiemKe_BienBanKiemKe]
GO
ALTER TABLE [dbo].[BaoDuong]  WITH CHECK ADD  CONSTRAINT [FK_BaoDuong_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[BaoDuong] CHECK CONSTRAINT [FK_BaoDuong_CoSo]
GO
ALTER TABLE [dbo].[BaoDuong]  WITH CHECK ADD  CONSTRAINT [FK_BaoDuong_NhanVien] FOREIGN KEY([NhanVienId])
REFERENCES [dbo].[NhanVien] ([NhanVienId])
GO
ALTER TABLE [dbo].[BaoDuong] CHECK CONSTRAINT [FK_BaoDuong_NhanVien]
GO
ALTER TABLE [dbo].[BaoDuong]  WITH CHECK ADD  CONSTRAINT [FK_BaoDuong_PhongBan] FOREIGN KEY([PhongBanId])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[BaoDuong] CHECK CONSTRAINT [FK_BaoDuong_PhongBan]
GO
ALTER TABLE [dbo].[BaoDuong]  WITH CHECK ADD  CONSTRAINT [FK_BaoDuong_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[BaoDuong] CHECK CONSTRAINT [FK_BaoDuong_TaiSan]
GO
ALTER TABLE [dbo].[BienBanKiemKe]  WITH CHECK ADD  CONSTRAINT [FK_BienBanKiemKe_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[BienBanKiemKe] CHECK CONSTRAINT [FK_BienBanKiemKe_CoSo]
GO
ALTER TABLE [dbo].[BienBanKiemKe]  WITH CHECK ADD  CONSTRAINT [FK_BienBanKiemKe_PhongBan] FOREIGN KEY([PhongBanId])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[BienBanKiemKe] CHECK CONSTRAINT [FK_BienBanKiemKe_PhongBan]
GO
ALTER TABLE [dbo].[BienBanKiemKeChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_BienBanKiemKeChiTiet_BienBanKiemKe] FOREIGN KEY([BienBanKiemKeId])
REFERENCES [dbo].[BienBanKiemKe] ([BienBanKiemKeId])
GO
ALTER TABLE [dbo].[BienBanKiemKeChiTiet] CHECK CONSTRAINT [FK_BienBanKiemKeChiTiet_BienBanKiemKe]
GO
ALTER TABLE [dbo].[BienBanKiemKeChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_BienBanKiemKeChiTiet_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[BienBanKiemKeChiTiet] CHECK CONSTRAINT [FK_BienBanKiemKeChiTiet_TaiSan]
GO
ALTER TABLE [dbo].[CoSo]  WITH CHECK ADD  CONSTRAINT [FK_CoSo_LoaiCoSo] FOREIGN KEY([LoaiCoSoId])
REFERENCES [dbo].[LoaiCoSo] ([LoaiCoSoId])
GO
ALTER TABLE [dbo].[CoSo] CHECK CONSTRAINT [FK_CoSo_LoaiCoSo]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[DanhGia] CHECK CONSTRAINT [FK_DanhGia_CoSo]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_NhanVien] FOREIGN KEY([NhanVienId])
REFERENCES [dbo].[NhanVien] ([NhanVienId])
GO
ALTER TABLE [dbo].[DanhGia] CHECK CONSTRAINT [FK_DanhGia_NhanVien]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_PhongBan] FOREIGN KEY([PhongBanId])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[DanhGia] CHECK CONSTRAINT [FK_DanhGia_PhongBan]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[DanhGia] CHECK CONSTRAINT [FK_DanhGia_TaiSan]
GO
ALTER TABLE [dbo].[DanhGia_NguyenGia]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_NguyenGia_DanhGia] FOREIGN KEY([DanhGiaId])
REFERENCES [dbo].[DanhGia] ([DanhGiaId])
GO
ALTER TABLE [dbo].[DanhGia_NguyenGia] CHECK CONSTRAINT [FK_DanhGia_NguyenGia_DanhGia]
GO
ALTER TABLE [dbo].[DanhGia_NguyenGia]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_NguyenGia_NguonNganSach] FOREIGN KEY([NguonNganSachId])
REFERENCES [dbo].[NguonNganSach] ([NguonNganSachId])
GO
ALTER TABLE [dbo].[DanhGia_NguyenGia] CHECK CONSTRAINT [FK_DanhGia_NguyenGia_NguonNganSach]
GO
ALTER TABLE [dbo].[DeNghiTrangCap]  WITH CHECK ADD  CONSTRAINT [FK_DeNghiTrangCap_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[DeNghiTrangCap] CHECK CONSTRAINT [FK_DeNghiTrangCap_CoSo]
GO
ALTER TABLE [dbo].[DeNghiTrangCap]  WITH CHECK ADD  CONSTRAINT [FK_DeNghiTrangCap_PhanLoai] FOREIGN KEY([PhanLoaiId])
REFERENCES [dbo].[PhanLoai] ([PhanLoaiId])
GO
ALTER TABLE [dbo].[DeNghiTrangCap] CHECK CONSTRAINT [FK_DeNghiTrangCap_PhanLoai]
GO
ALTER TABLE [dbo].[DeNghiTrangCap]  WITH CHECK ADD  CONSTRAINT [FK_DeNghiTrangCap_PhongBan] FOREIGN KEY([PhongBanId])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[DeNghiTrangCap] CHECK CONSTRAINT [FK_DeNghiTrangCap_PhongBan]
GO
ALTER TABLE [dbo].[DeNghiTrangCapChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_DeNghiTrangCapChiTiet_DeNghiTrangCap] FOREIGN KEY([DeNghiId])
REFERENCES [dbo].[DeNghiTrangCap] ([DeNghiId])
GO
ALTER TABLE [dbo].[DeNghiTrangCapChiTiet] CHECK CONSTRAINT [FK_DeNghiTrangCapChiTiet_DeNghiTrangCap]
GO
ALTER TABLE [dbo].[DeNghiTrangCapChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_DeNghiTrangCapChiTiet_LoaiTaiSan] FOREIGN KEY([LoaiId])
REFERENCES [dbo].[LoaiTaiSan] ([LoaiId])
GO
ALTER TABLE [dbo].[DeNghiTrangCapChiTiet] CHECK CONSTRAINT [FK_DeNghiTrangCapChiTiet_LoaiTaiSan]
GO
ALTER TABLE [dbo].[DeNghiTrangCapChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_DeNghiTrangCapChiTiet_PhuongThuc] FOREIGN KEY([PhuongThucId])
REFERENCES [dbo].[PhuongThuc] ([PhuongThucId])
GO
ALTER TABLE [dbo].[DeNghiTrangCapChiTiet] CHECK CONSTRAINT [FK_DeNghiTrangCapChiTiet_PhuongThuc]
GO
ALTER TABLE [dbo].[DieuChuyen]  WITH CHECK ADD  CONSTRAINT [FK_DieuChuyen_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[DieuChuyen] CHECK CONSTRAINT [FK_DieuChuyen_CoSo]
GO
ALTER TABLE [dbo].[DieuChuyenChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_DieuChuyenChiTiet_DieuChuyen] FOREIGN KEY([DieuChuyenId])
REFERENCES [dbo].[DieuChuyen] ([DieuChuyenId])
GO
ALTER TABLE [dbo].[DieuChuyenChiTiet] CHECK CONSTRAINT [FK_DieuChuyenChiTiet_DieuChuyen]
GO
ALTER TABLE [dbo].[DieuChuyenChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_DieuChuyenChiTiet_NhanVien] FOREIGN KEY([NhanVienSuDung])
REFERENCES [dbo].[NhanVien] ([NhanVienId])
GO
ALTER TABLE [dbo].[DieuChuyenChiTiet] CHECK CONSTRAINT [FK_DieuChuyenChiTiet_NhanVien]
GO
ALTER TABLE [dbo].[DieuChuyenChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_DieuChuyenChiTiet_NhanVien1] FOREIGN KEY([NhanVienTiepNhan])
REFERENCES [dbo].[NhanVien] ([NhanVienId])
GO
ALTER TABLE [dbo].[DieuChuyenChiTiet] CHECK CONSTRAINT [FK_DieuChuyenChiTiet_NhanVien1]
GO
ALTER TABLE [dbo].[DieuChuyenChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_DieuChuyenChiTiet_PhongBan] FOREIGN KEY([PhongBanSuDung])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[DieuChuyenChiTiet] CHECK CONSTRAINT [FK_DieuChuyenChiTiet_PhongBan]
GO
ALTER TABLE [dbo].[DieuChuyenChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_DieuChuyenChiTiet_PhongBan1] FOREIGN KEY([PhongBanChuyenDen])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[DieuChuyenChiTiet] CHECK CONSTRAINT [FK_DieuChuyenChiTiet_PhongBan1]
GO
ALTER TABLE [dbo].[DieuChuyenChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_DieuChuyenChiTiet_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[DieuChuyenChiTiet] CHECK CONSTRAINT [FK_DieuChuyenChiTiet_TaiSan]
GO
ALTER TABLE [dbo].[GhiGiam]  WITH CHECK ADD  CONSTRAINT [FK_GhiGiam_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[GhiGiam] CHECK CONSTRAINT [FK_GhiGiam_CoSo]
GO
ALTER TABLE [dbo].[GhiGiam]  WITH CHECK ADD  CONSTRAINT [FK_GhiGiam_PhongBan] FOREIGN KEY([PhongBanId])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[GhiGiam] CHECK CONSTRAINT [FK_GhiGiam_PhongBan]
GO
ALTER TABLE [dbo].[GhiGiamChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GhiGiamChiTiet_GhiGiam] FOREIGN KEY([GhiGiamId])
REFERENCES [dbo].[GhiGiam] ([GhiGiamId])
GO
ALTER TABLE [dbo].[GhiGiamChiTiet] CHECK CONSTRAINT [FK_GhiGiamChiTiet_GhiGiam]
GO
ALTER TABLE [dbo].[GhiGiamChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GhiGiamChiTiet_NhanVien] FOREIGN KEY([NhanVienId])
REFERENCES [dbo].[NhanVien] ([NhanVienId])
GO
ALTER TABLE [dbo].[GhiGiamChiTiet] CHECK CONSTRAINT [FK_GhiGiamChiTiet_NhanVien]
GO
ALTER TABLE [dbo].[GhiGiamChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GhiGiamChiTiet_PhongBan] FOREIGN KEY([PhongBanId])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[GhiGiamChiTiet] CHECK CONSTRAINT [FK_GhiGiamChiTiet_PhongBan]
GO
ALTER TABLE [dbo].[GhiGiamChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GhiGiamChiTiet_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[GhiGiamChiTiet] CHECK CONSTRAINT [FK_GhiGiamChiTiet_TaiSan]
GO
ALTER TABLE [dbo].[GhiGiamChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GhiGiamChiTiet_XuLy] FOREIGN KEY([XuLyId])
REFERENCES [dbo].[XuLy] ([XuLyId])
GO
ALTER TABLE [dbo].[GhiGiamChiTiet] CHECK CONSTRAINT [FK_GhiGiamChiTiet_XuLy]
GO
ALTER TABLE [dbo].[GhiTang]  WITH CHECK ADD  CONSTRAINT [FK_GhiTang_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[GhiTang] CHECK CONSTRAINT [FK_GhiTang_CoSo]
GO
ALTER TABLE [dbo].[GhiTangChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GhiTangChiTiet_GhiTang] FOREIGN KEY([HopDongId])
REFERENCES [dbo].[HopDong] ([HopDongId])
GO
ALTER TABLE [dbo].[GhiTangChiTiet] CHECK CONSTRAINT [FK_GhiTangChiTiet_GhiTang]
GO
ALTER TABLE [dbo].[GhiTangChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GhiTangChiTiet_GhiTangChiTiet] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[GhiTangChiTiet] CHECK CONSTRAINT [FK_GhiTangChiTiet_GhiTangChiTiet]
GO
ALTER TABLE [dbo].[GhiTangChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GhiTangChiTiet_GhiTangChiTiet1] FOREIGN KEY([GhiTangChiTietId])
REFERENCES [dbo].[GhiTangChiTiet] ([GhiTangChiTietId])
GO
ALTER TABLE [dbo].[GhiTangChiTiet] CHECK CONSTRAINT [FK_GhiTangChiTiet_GhiTangChiTiet1]
GO
ALTER TABLE [dbo].[GhiTangChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GhiTangChiTiet_NhanVien] FOREIGN KEY([NhanVienId])
REFERENCES [dbo].[NhanVien] ([NhanVienId])
GO
ALTER TABLE [dbo].[GhiTangChiTiet] CHECK CONSTRAINT [FK_GhiTangChiTiet_NhanVien]
GO
ALTER TABLE [dbo].[GhiTangChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GhiTangChiTiet_PhongBan] FOREIGN KEY([PhongBanId])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[GhiTangChiTiet] CHECK CONSTRAINT [FK_GhiTangChiTiet_PhongBan]
GO
ALTER TABLE [dbo].[GiayBaoHong]  WITH CHECK ADD  CONSTRAINT [FK_GiayBaoHong_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[GiayBaoHong] CHECK CONSTRAINT [FK_GiayBaoHong_CoSo]
GO
ALTER TABLE [dbo].[GiayBaoHong]  WITH CHECK ADD  CONSTRAINT [FK_GiayBaoHong_PhongBan] FOREIGN KEY([PhongBanId])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[GiayBaoHong] CHECK CONSTRAINT [FK_GiayBaoHong_PhongBan]
GO
ALTER TABLE [dbo].[GiayBaoHongChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GiayBaoHongChiTiet_GiayBaoHong] FOREIGN KEY([GiayBaoHongId])
REFERENCES [dbo].[GiayBaoHong] ([GiayBaoHongId])
GO
ALTER TABLE [dbo].[GiayBaoHongChiTiet] CHECK CONSTRAINT [FK_GiayBaoHongChiTiet_GiayBaoHong]
GO
ALTER TABLE [dbo].[GiayBaoHongChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GiayBaoHongChiTiet_NhanVien] FOREIGN KEY([NhanVienId])
REFERENCES [dbo].[NhanVien] ([NhanVienId])
GO
ALTER TABLE [dbo].[GiayBaoHongChiTiet] CHECK CONSTRAINT [FK_GiayBaoHongChiTiet_NhanVien]
GO
ALTER TABLE [dbo].[GiayBaoHongChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GiayBaoHongChiTiet_PhongBan] FOREIGN KEY([PhongBanId])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[GiayBaoHongChiTiet] CHECK CONSTRAINT [FK_GiayBaoHongChiTiet_PhongBan]
GO
ALTER TABLE [dbo].[GiayBaoHongChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GiayBaoHongChiTiet_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[GiayBaoHongChiTiet] CHECK CONSTRAINT [FK_GiayBaoHongChiTiet_TaiSan]
GO
ALTER TABLE [dbo].[HaoMon]  WITH CHECK ADD  CONSTRAINT [FK_HaoMon_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[HaoMon] CHECK CONSTRAINT [FK_HaoMon_CoSo]
GO
ALTER TABLE [dbo].[HaoMonChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_HaoMonChiTiet_HaoMon] FOREIGN KEY([HaoMonId])
REFERENCES [dbo].[HaoMon] ([HaoMonId])
GO
ALTER TABLE [dbo].[HaoMonChiTiet] CHECK CONSTRAINT [FK_HaoMonChiTiet_HaoMon]
GO
ALTER TABLE [dbo].[HaoMonChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_HaoMonChiTiet_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[HaoMonChiTiet] CHECK CONSTRAINT [FK_HaoMonChiTiet_TaiSan]
GO
ALTER TABLE [dbo].[HopDong]  WITH CHECK ADD  CONSTRAINT [FK_HopDong_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[HopDong] CHECK CONSTRAINT [FK_HopDong_CoSo]
GO
ALTER TABLE [dbo].[KeHoachMuaSam]  WITH CHECK ADD  CONSTRAINT [FK_KeHoachMuaSam_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[KeHoachMuaSam] CHECK CONSTRAINT [FK_KeHoachMuaSam_CoSo]
GO
ALTER TABLE [dbo].[KeHoachMuaSamChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KeHoachMuaSamChiTiet_HinhThuc] FOREIGN KEY([HinhThucId])
REFERENCES [dbo].[HinhThuc] ([HinhThucId])
GO
ALTER TABLE [dbo].[KeHoachMuaSamChiTiet] CHECK CONSTRAINT [FK_KeHoachMuaSamChiTiet_HinhThuc]
GO
ALTER TABLE [dbo].[KeHoachMuaSamChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KeHoachMuaSamChiTiet_KeHoachMuaSam] FOREIGN KEY([MuaSamId])
REFERENCES [dbo].[KeHoachMuaSam] ([MuaSamId])
GO
ALTER TABLE [dbo].[KeHoachMuaSamChiTiet] CHECK CONSTRAINT [FK_KeHoachMuaSamChiTiet_KeHoachMuaSam]
GO
ALTER TABLE [dbo].[KeHoachMuaSamChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KeHoachMuaSamChiTiet_LoaiTaiSan] FOREIGN KEY([LoaiId])
REFERENCES [dbo].[LoaiTaiSan] ([LoaiId])
GO
ALTER TABLE [dbo].[KeHoachMuaSamChiTiet] CHECK CONSTRAINT [FK_KeHoachMuaSamChiTiet_LoaiTaiSan]
GO
ALTER TABLE [dbo].[KeHoachMuaSamChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KeHoachMuaSamChiTiet_PhuongThuc] FOREIGN KEY([PhuongThucId])
REFERENCES [dbo].[PhuongThuc] ([PhuongThucId])
GO
ALTER TABLE [dbo].[KeHoachMuaSamChiTiet] CHECK CONSTRAINT [FK_KeHoachMuaSamChiTiet_PhuongThuc]
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD  CONSTRAINT [FK_KhachHangNCC_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[KhachHang] CHECK CONSTRAINT [FK_KhachHangNCC_CoSo]
GO
ALTER TABLE [dbo].[KhaiThac]  WITH CHECK ADD  CONSTRAINT [FK_KhaiThac_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[KhaiThac] CHECK CONSTRAINT [FK_KhaiThac_CoSo]
GO
ALTER TABLE [dbo].[KhaiThac]  WITH CHECK ADD  CONSTRAINT [FK_KhaiThac_HopDong] FOREIGN KEY([HopDongId])
REFERENCES [dbo].[HopDong] ([HopDongId])
GO
ALTER TABLE [dbo].[KhaiThac] CHECK CONSTRAINT [FK_KhaiThac_HopDong]
GO
ALTER TABLE [dbo].[KhaiThac]  WITH CHECK ADD  CONSTRAINT [FK_KhaiThac_KhachHangNCC] FOREIGN KEY([KhachHangNCCId])
REFERENCES [dbo].[KhachHang] ([KhachHangId])
GO
ALTER TABLE [dbo].[KhaiThac] CHECK CONSTRAINT [FK_KhaiThac_KhachHangNCC]
GO
ALTER TABLE [dbo].[KhaiThac]  WITH CHECK ADD  CONSTRAINT [FK_KhaiThac_NhanVien] FOREIGN KEY([NhanVienId])
REFERENCES [dbo].[NhanVien] ([NhanVienId])
GO
ALTER TABLE [dbo].[KhaiThac] CHECK CONSTRAINT [FK_KhaiThac_NhanVien]
GO
ALTER TABLE [dbo].[KhaiThac]  WITH CHECK ADD  CONSTRAINT [FK_KhaiThac_PhongBan] FOREIGN KEY([PhongBanId])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[KhaiThac] CHECK CONSTRAINT [FK_KhaiThac_PhongBan]
GO
ALTER TABLE [dbo].[KhaiThac]  WITH CHECK ADD  CONSTRAINT [FK_KhaiThac_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[KhaiThac] CHECK CONSTRAINT [FK_KhaiThac_TaiSan]
GO
ALTER TABLE [dbo].[KhoPhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_KhoNhapKho_KhoTaiSan] FOREIGN KEY([KhoTaiSanId])
REFERENCES [dbo].[KhoTaiSan] ([KhoTaiSanId])
GO
ALTER TABLE [dbo].[KhoPhieuNhap] CHECK CONSTRAINT [FK_KhoNhapKho_KhoTaiSan]
GO
ALTER TABLE [dbo].[KhoPhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_KhoNhapKho_NguonNganSach] FOREIGN KEY([NguonNganSachId])
REFERENCES [dbo].[NguonNganSach] ([NguonNganSachId])
GO
ALTER TABLE [dbo].[KhoPhieuNhap] CHECK CONSTRAINT [FK_KhoNhapKho_NguonNganSach]
GO
ALTER TABLE [dbo].[KhoPhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_KhoNhapKho_NhaCungCap] FOREIGN KEY([NhaCungCapId])
REFERENCES [dbo].[NhaCungCap] ([NhaCungCapId])
GO
ALTER TABLE [dbo].[KhoPhieuNhap] CHECK CONSTRAINT [FK_KhoNhapKho_NhaCungCap]
GO
ALTER TABLE [dbo].[KhoPhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_KhoPhieuNhap_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[KhoPhieuNhap] CHECK CONSTRAINT [FK_KhoPhieuNhap_CoSo]
GO
ALTER TABLE [dbo].[KhoPhieuNhapChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KhoNhapKhoChiTiet_KhoNhapKho] FOREIGN KEY([KhoPhieuNhapId])
REFERENCES [dbo].[KhoPhieuNhap] ([KhoPhieuNhapId])
GO
ALTER TABLE [dbo].[KhoPhieuNhapChiTiet] CHECK CONSTRAINT [FK_KhoNhapKhoChiTiet_KhoNhapKho]
GO
ALTER TABLE [dbo].[KhoPhieuNhapChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KhoNhapKhoChiTiet_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[KhoPhieuNhapChiTiet] CHECK CONSTRAINT [FK_KhoNhapKhoChiTiet_TaiSan]
GO
ALTER TABLE [dbo].[KhoPhieuXuat]  WITH CHECK ADD  CONSTRAINT [FK_KhoPhieuXuat_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[KhoPhieuXuat] CHECK CONSTRAINT [FK_KhoPhieuXuat_CoSo]
GO
ALTER TABLE [dbo].[KhoPhieuXuat]  WITH CHECK ADD  CONSTRAINT [FK_KhoPhieuXuat_KhoTaiSanNhan] FOREIGN KEY([KhoNhanId])
REFERENCES [dbo].[KhoTaiSan] ([KhoTaiSanId])
GO
ALTER TABLE [dbo].[KhoPhieuXuat] CHECK CONSTRAINT [FK_KhoPhieuXuat_KhoTaiSanNhan]
GO
ALTER TABLE [dbo].[KhoPhieuXuat]  WITH CHECK ADD  CONSTRAINT [FK_KhoPhieuXuat_KhoTaiSanXuat] FOREIGN KEY([KhoXuatId])
REFERENCES [dbo].[KhoTaiSan] ([KhoTaiSanId])
GO
ALTER TABLE [dbo].[KhoPhieuXuat] CHECK CONSTRAINT [FK_KhoPhieuXuat_KhoTaiSanXuat]
GO
ALTER TABLE [dbo].[KhoPhieuXuatChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KhoPhieuXuatChiTiet_KhoPhieuXuat] FOREIGN KEY([KhoPhieuXuatId])
REFERENCES [dbo].[KhoPhieuXuat] ([KhoPhieuXuatId])
GO
ALTER TABLE [dbo].[KhoPhieuXuatChiTiet] CHECK CONSTRAINT [FK_KhoPhieuXuatChiTiet_KhoPhieuXuat]
GO
ALTER TABLE [dbo].[KhoPhieuXuatChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KhoPhieuXuatChiTiet_NguonNganSach] FOREIGN KEY([NguonNganSachId])
REFERENCES [dbo].[NguonNganSach] ([NguonNganSachId])
GO
ALTER TABLE [dbo].[KhoPhieuXuatChiTiet] CHECK CONSTRAINT [FK_KhoPhieuXuatChiTiet_NguonNganSach]
GO
ALTER TABLE [dbo].[KhoPhieuXuatChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KhoPhieuXuatChiTiet_NhaCungCap] FOREIGN KEY([NhaCungCapId])
REFERENCES [dbo].[NhaCungCap] ([NhaCungCapId])
GO
ALTER TABLE [dbo].[KhoPhieuXuatChiTiet] CHECK CONSTRAINT [FK_KhoPhieuXuatChiTiet_NhaCungCap]
GO
ALTER TABLE [dbo].[KhoPhieuXuatChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KhoPhieuXuatChiTiet_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[KhoPhieuXuatChiTiet] CHECK CONSTRAINT [FK_KhoPhieuXuatChiTiet_TaiSan]
GO
ALTER TABLE [dbo].[KhoTaiSan]  WITH CHECK ADD  CONSTRAINT [FK_KhoTaiSan_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[KhoTaiSan] CHECK CONSTRAINT [FK_KhoTaiSan_CoSo]
GO
ALTER TABLE [dbo].[KhoTonKho]  WITH CHECK ADD  CONSTRAINT [FK_KhoTonKho_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[KhoTonKho] CHECK CONSTRAINT [FK_KhoTonKho_CoSo]
GO
ALTER TABLE [dbo].[KhoTonKho]  WITH CHECK ADD  CONSTRAINT [FK_KhoTonKho_KhoTaiSan] FOREIGN KEY([KhoTaiSanId])
REFERENCES [dbo].[KhoTaiSan] ([KhoTaiSanId])
GO
ALTER TABLE [dbo].[KhoTonKho] CHECK CONSTRAINT [FK_KhoTonKho_KhoTaiSan]
GO
ALTER TABLE [dbo].[KhoTonKhoChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KhoTonKhoChiTiet_KhoTonKho] FOREIGN KEY([KhoTonKhoId])
REFERENCES [dbo].[KhoTonKho] ([KhoTonKhoId])
GO
ALTER TABLE [dbo].[KhoTonKhoChiTiet] CHECK CONSTRAINT [FK_KhoTonKhoChiTiet_KhoTonKho]
GO
ALTER TABLE [dbo].[KhoTonKhoChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KhoTonKhoChiTiet_NguonNganSach] FOREIGN KEY([NguonNganSachId])
REFERENCES [dbo].[NguonNganSach] ([NguonNganSachId])
GO
ALTER TABLE [dbo].[KhoTonKhoChiTiet] CHECK CONSTRAINT [FK_KhoTonKhoChiTiet_NguonNganSach]
GO
ALTER TABLE [dbo].[KhoTonKhoChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_KhoTonKhoChiTiet_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[KhoTonKhoChiTiet] CHECK CONSTRAINT [FK_KhoTonKhoChiTiet_TaiSan]
GO
ALTER TABLE [dbo].[LapBaoCaoChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_LapBaoCao_LapBaoCaoChiTiet] FOREIGN KEY([LapBaoCaoId])
REFERENCES [dbo].[LapBaoCao] ([LapBaoCaoId])
GO
ALTER TABLE [dbo].[LapBaoCaoChiTiet] CHECK CONSTRAINT [FK_LapBaoCao_LapBaoCaoChiTiet]
GO
ALTER TABLE [dbo].[LapBaoCaoChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_LapBaoCaoChiTiet_BaoCao] FOREIGN KEY([BaoCaoId])
REFERENCES [dbo].[BaoCao] ([BaoCaoId])
GO
ALTER TABLE [dbo].[LapBaoCaoChiTiet] CHECK CONSTRAINT [FK_LapBaoCaoChiTiet_BaoCao]
GO
ALTER TABLE [dbo].[LoaiTaiSan]  WITH CHECK ADD  CONSTRAINT [FK_LoaiTaiSan_NhomTaiSan] FOREIGN KEY([NhomId])
REFERENCES [dbo].[NhomTaiSan] ([NhomId])
GO
ALTER TABLE [dbo].[LoaiTaiSan] CHECK CONSTRAINT [FK_LoaiTaiSan_NhomTaiSan]
GO
ALTER TABLE [dbo].[NguyenGia]  WITH CHECK ADD  CONSTRAINT [FK_NguyenGia_NguonNganSach] FOREIGN KEY([NguonNganSachId])
REFERENCES [dbo].[NguonNganSach] ([NguonNganSachId])
GO
ALTER TABLE [dbo].[NguyenGia] CHECK CONSTRAINT [FK_NguyenGia_NguonNganSach]
GO
ALTER TABLE [dbo].[NguyenGia]  WITH CHECK ADD  CONSTRAINT [FK_NguyenGia_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[NguyenGia] CHECK CONSTRAINT [FK_NguyenGia_TaiSan]
GO
ALTER TABLE [dbo].[PhongBan]  WITH CHECK ADD  CONSTRAINT [FK_PhongBan_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[PhongBan] CHECK CONSTRAINT [FK_PhongBan_CoSo]
GO
ALTER TABLE [dbo].[PhongBanNhanVien]  WITH CHECK ADD  CONSTRAINT [FK_PhongBanNhanVien_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[PhongBanNhanVien] CHECK CONSTRAINT [FK_PhongBanNhanVien_CoSo]
GO
ALTER TABLE [dbo].[PhongBanNhanVien]  WITH CHECK ADD  CONSTRAINT [FK_PhongBanNhanVien_NhanVien] FOREIGN KEY([NhanVienId])
REFERENCES [dbo].[NhanVien] ([NhanVienId])
GO
ALTER TABLE [dbo].[PhongBanNhanVien] CHECK CONSTRAINT [FK_PhongBanNhanVien_NhanVien]
GO
ALTER TABLE [dbo].[PhongBanNhanVien]  WITH CHECK ADD  CONSTRAINT [FK_PhongBanNhanVien_PhongBan] FOREIGN KEY([PhongBanId])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[PhongBanNhanVien] CHECK CONSTRAINT [FK_PhongBanNhanVien_PhongBan]
GO
ALTER TABLE [dbo].[SuaChua]  WITH CHECK ADD  CONSTRAINT [FK_SuaChua_BaoDuong] FOREIGN KEY([BaoDuongId])
REFERENCES [dbo].[BaoDuong] ([BaoDuongId])
GO
ALTER TABLE [dbo].[SuaChua] CHECK CONSTRAINT [FK_SuaChua_BaoDuong]
GO
ALTER TABLE [dbo].[SuDung]  WITH CHECK ADD  CONSTRAINT [FK_SuDung_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[SuDung] CHECK CONSTRAINT [FK_SuDung_CoSo]
GO
ALTER TABLE [dbo].[SuDungChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_SuDungChiTiet_SuDung] FOREIGN KEY([SuDungId])
REFERENCES [dbo].[SuDung] ([SuDungId])
GO
ALTER TABLE [dbo].[SuDungChiTiet] CHECK CONSTRAINT [FK_SuDungChiTiet_SuDung]
GO
ALTER TABLE [dbo].[SuDungChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_SuDungChiTiet_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[SuDungChiTiet] CHECK CONSTRAINT [FK_SuDungChiTiet_TaiSan]
GO
ALTER TABLE [dbo].[TaiSan]  WITH CHECK ADD  CONSTRAINT [FK_TaiSan_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[TaiSan] CHECK CONSTRAINT [FK_TaiSan_CoSo]
GO
ALTER TABLE [dbo].[TaiSan]  WITH CHECK ADD  CONSTRAINT [FK_TaiSan_DuAn] FOREIGN KEY([DuAnId])
REFERENCES [dbo].[DuAn] ([DuAnId])
GO
ALTER TABLE [dbo].[TaiSan] CHECK CONSTRAINT [FK_TaiSan_DuAn]
GO
ALTER TABLE [dbo].[TaiSan]  WITH CHECK ADD  CONSTRAINT [FK_TaiSan_HangSanXuat] FOREIGN KEY([HangSanXuatId])
REFERENCES [dbo].[HangSanXuat] ([HangSanXuatId])
GO
ALTER TABLE [dbo].[TaiSan] CHECK CONSTRAINT [FK_TaiSan_HangSanXuat]
GO
ALTER TABLE [dbo].[TaiSan]  WITH CHECK ADD  CONSTRAINT [FK_TaiSan_LoaiTaiSan] FOREIGN KEY([LoaiId])
REFERENCES [dbo].[LoaiTaiSan] ([LoaiId])
GO
ALTER TABLE [dbo].[TaiSan] CHECK CONSTRAINT [FK_TaiSan_LoaiTaiSan]
GO
ALTER TABLE [dbo].[TaiSan]  WITH CHECK ADD  CONSTRAINT [FK_TaiSan_NuocSanXuat] FOREIGN KEY([NuocSanXuatId])
REFERENCES [dbo].[NuocSanXuat] ([NuocSanXuatId])
GO
ALTER TABLE [dbo].[TaiSan] CHECK CONSTRAINT [FK_TaiSan_NuocSanXuat]
GO
ALTER TABLE [dbo].[TaiSan]  WITH CHECK ADD  CONSTRAINT [FK_TaiSan_PhuongThuc] FOREIGN KEY([PhuongThucId])
REFERENCES [dbo].[PhuongThuc] ([PhuongThucId])
GO
ALTER TABLE [dbo].[TaiSan] CHECK CONSTRAINT [FK_TaiSan_PhuongThuc]
GO
ALTER TABLE [dbo].[ThayDoiThongTin]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiThongTin_CoSo] FOREIGN KEY([CoSoId])
REFERENCES [dbo].[CoSo] ([CoSoId])
GO
ALTER TABLE [dbo].[ThayDoiThongTin] CHECK CONSTRAINT [FK_ThayDoiThongTin_CoSo]
GO
ALTER TABLE [dbo].[ThayDoiThongTin]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiThongTin_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[ThayDoiThongTin] CHECK CONSTRAINT [FK_ThayDoiThongTin_TaiSan]
GO
ALTER TABLE [dbo].[ThayDoiThongTin_Dat]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiThongTin_Dat_ThayDoiThongTin] FOREIGN KEY([ThayDoiThongTinId])
REFERENCES [dbo].[ThayDoiThongTin] ([ThayDoiThongTinId])
GO
ALTER TABLE [dbo].[ThayDoiThongTin_Dat] CHECK CONSTRAINT [FK_ThayDoiThongTin_Dat_ThayDoiThongTin]
GO
ALTER TABLE [dbo].[ThayDoiThongTin_Nha]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiThongTin_Nha_ThayDoiThongTin] FOREIGN KEY([ThayDoiThongTinId])
REFERENCES [dbo].[ThayDoiThongTin] ([ThayDoiThongTinId])
GO
ALTER TABLE [dbo].[ThayDoiThongTin_Nha] CHECK CONSTRAINT [FK_ThayDoiThongTin_Nha_ThayDoiThongTin]
GO
ALTER TABLE [dbo].[ThayDoiThongTin_Oto]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiThongTin_Oto_ThayDoiThongTin] FOREIGN KEY([ThayDoiThongTinId])
REFERENCES [dbo].[ThayDoiThongTin] ([ThayDoiThongTinId])
GO
ALTER TABLE [dbo].[ThayDoiThongTin_Oto] CHECK CONSTRAINT [FK_ThayDoiThongTin_Oto_ThayDoiThongTin]
GO
ALTER TABLE [dbo].[ThayDoiThongTin_Tren500]  WITH CHECK ADD  CONSTRAINT [FK_ThayDoiThongTin_Tren500_ThayDoiThongTin] FOREIGN KEY([ThayDoiThongTinId])
REFERENCES [dbo].[ThayDoiThongTin] ([ThayDoiThongTinId])
GO
ALTER TABLE [dbo].[ThayDoiThongTin_Tren500] CHECK CONSTRAINT [FK_ThayDoiThongTin_Tren500_ThayDoiThongTin]
GO
ALTER TABLE [dbo].[TheoDoi]  WITH CHECK ADD  CONSTRAINT [FK_TheoDoi_HopDong] FOREIGN KEY([HopDongId])
REFERENCES [dbo].[HopDong] ([HopDongId])
GO
ALTER TABLE [dbo].[TheoDoi] CHECK CONSTRAINT [FK_TheoDoi_HopDong]
GO
ALTER TABLE [dbo].[TheoDoi]  WITH CHECK ADD  CONSTRAINT [FK_TheoDoi_NhanVien] FOREIGN KEY([NhanVienId])
REFERENCES [dbo].[NhanVien] ([NhanVienId])
GO
ALTER TABLE [dbo].[TheoDoi] CHECK CONSTRAINT [FK_TheoDoi_NhanVien]
GO
ALTER TABLE [dbo].[TheoDoi]  WITH CHECK ADD  CONSTRAINT [FK_TheoDoi_PhongBan] FOREIGN KEY([PhongBanId])
REFERENCES [dbo].[PhongBan] ([PhongBanId])
GO
ALTER TABLE [dbo].[TheoDoi] CHECK CONSTRAINT [FK_TheoDoi_PhongBan]
GO
ALTER TABLE [dbo].[TheoDoi]  WITH CHECK ADD  CONSTRAINT [FK_TheoDoi_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[TheoDoi] CHECK CONSTRAINT [FK_TheoDoi_TaiSan]
GO
ALTER TABLE [dbo].[ThongTinCongKhai]  WITH CHECK ADD  CONSTRAINT [FK_ThongTinCongKhai_HienTrangSuDung] FOREIGN KEY([HienTrangSuDungId])
REFERENCES [dbo].[HienTrangSuDung] ([HienTrangSuDungId])
GO
ALTER TABLE [dbo].[ThongTinCongKhai] CHECK CONSTRAINT [FK_ThongTinCongKhai_HienTrangSuDung]
GO
ALTER TABLE [dbo].[ThongTinCongKhai]  WITH CHECK ADD  CONSTRAINT [FK_ThongTinCongKhai_KhachHangNCC] FOREIGN KEY([NhaCungCapId])
REFERENCES [dbo].[NhaCungCap] ([NhaCungCapId])
GO
ALTER TABLE [dbo].[ThongTinCongKhai] CHECK CONSTRAINT [FK_ThongTinCongKhai_KhachHangNCC]
GO
ALTER TABLE [dbo].[ThongTinCongKhai]  WITH CHECK ADD  CONSTRAINT [FK_ThongTinCongKhai_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[ThongTinCongKhai] CHECK CONSTRAINT [FK_ThongTinCongKhai_TaiSan]
GO
ALTER TABLE [dbo].[ThongTinKeKhai_Dat]  WITH CHECK ADD  CONSTRAINT [FK_ThongTinKeKhai_Dat_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[ThongTinKeKhai_Dat] CHECK CONSTRAINT [FK_ThongTinKeKhai_Dat_TaiSan]
GO
ALTER TABLE [dbo].[ThongTinKeKhai_Nha]  WITH CHECK ADD  CONSTRAINT [FK_ThongTinKeKhai_Nha_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[ThongTinKeKhai_Nha] CHECK CONSTRAINT [FK_ThongTinKeKhai_Nha_TaiSan]
GO
ALTER TABLE [dbo].[ThongTinKeKhai_Nha]  WITH CHECK ADD  CONSTRAINT [FK_ThongTinKeKhai_Nha_TaiSan1] FOREIGN KEY([ThuocDat])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[ThongTinKeKhai_Nha] CHECK CONSTRAINT [FK_ThongTinKeKhai_Nha_TaiSan1]
GO
ALTER TABLE [dbo].[ThongTinKeKhai_Oto]  WITH CHECK ADD  CONSTRAINT [FK_ThongTinKeKhai_Oto_LoaiXe] FOREIGN KEY([LoaiXe])
REFERENCES [dbo].[LoaiXe] ([LoaiXeId])
GO
ALTER TABLE [dbo].[ThongTinKeKhai_Oto] CHECK CONSTRAINT [FK_ThongTinKeKhai_Oto_LoaiXe]
GO
ALTER TABLE [dbo].[ThongTinKeKhai_Oto]  WITH CHECK ADD  CONSTRAINT [FK_ThongTinKeKhai_Oto_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[ThongTinKeKhai_Oto] CHECK CONSTRAINT [FK_ThongTinKeKhai_Oto_TaiSan]
GO
ALTER TABLE [dbo].[ThongTinKeKhai_Tren500]  WITH CHECK ADD  CONSTRAINT [FK_ThongTinKeKhai_Tren500_TaiSan] FOREIGN KEY([TaiSanId])
REFERENCES [dbo].[TaiSan] ([TaiSanId])
GO
ALTER TABLE [dbo].[ThongTinKeKhai_Tren500] CHECK CONSTRAINT [FK_ThongTinKeKhai_Tren500_TaiSan]
GO
/****** Object:  StoredProcedure [dbo].[sp_BanKiemKe_GetListBanKiemKeByKiemKeId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_BanKiemKe_GetListBanKiemKeByKiemKeId]
( 
	@BienBanKiemKeId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT BanKiemKeId,
			BienBanKiemKeId,
			NguoiKiemKe,
			ChucVu,
			DaiDien,
			VaiTro
	FROM dbo.BanKiemKe 
	WHERE BienBanKiemKeId = @BienBanKiemKeId	

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_BaoCaoCongKhaiChoThueTSNNBieu05]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC [dbo].[sp_BaoCao_BaoCaoCongKhaiChoThueTSNNBieu05] @TuNgay = '2017-10-05 02:12:35', -- datetime
    @DenNgay = '2017-10-05 02:12:35', -- datetime
    @NhanVienId = N'1', -- nvarchar(10)
    @CoSoId = N'1' -- nvarchar(10)
*/

CREATE PROC [dbo].[sp_BaoCao_BaoCaoCongKhaiChoThueTSNNBieu05]
( 
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NhanVienId NVARCHAR(10),
	@CoSoId NVARCHAR(10)
)
AS  
BEGIN

------------------------------------------------  
	SELECT @TuNgay TuNgay, @DenNgay DenNgay, CS.MaCoSo, CS.TenCoSo,
			LTS.TenLoai, NTS.TenNhom, TS.TenTaiSan, 
			KT.SoChungTu, KHNCC.TenKhachHang TenKHNCC, KT.SoLuongKhaiThac, TS.DonViTinh, 
			KT.DonGiaKhaiThac, KT.ThoiGianBatDau, KT.ThoiGianKetThuc, KT.TienThu, KT.NopNganSach, KT.DonVi, KT.GhiChu
	FROM dbo.KhaiThac KT
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = KT.TaiSanId
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = TS.LoaiId
	LEFT JOIN dbo.NhomTaiSan NTS ON NTS.NhomId = LTS.NhomId
	LEFT JOIN dbo.KhachHang KHNCC ON KHNCC.KhachHangId = KT.KhachHangNCCId
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = KT.CoSoId
	WHERE 
	(
		CAST(KT.ThoiGianBatDau AS DATE) BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE) OR
		CAST(KT.ThoiGianKetThuc AS DATE) BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE)
	)
	AND KT.CoSoId = @CoSoId
-----------------------------------------------------
END


GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_BaoCaoCongKhaiKeHoachMuaSamTSNNBieu01]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC [dbo].[sp_BaoCao_BaoCaoCongKhaiKeHoachMuaSamTSNNBieu01] @TuNgay = '2017-10-05 02:12:35', -- datetime
    @DenNgay = '2017-10-05 02:12:35', -- datetime
    @NhanVienId = N'1', -- nvarchar(10)
    @CoSoId = N'1' -- nvarchar(10)
*/

CREATE PROC [dbo].[sp_BaoCao_BaoCaoCongKhaiKeHoachMuaSamTSNNBieu01]
( 
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NhanVienId NVARCHAR(10),
	@CoSoId NVARCHAR(10)
)
AS  
BEGIN
------------------------------------------------  

	SELECT CS.MaCoSo, CS.TenCoSo, LTS.TenLoai, NTS.TenNhom, @TuNgay TuNgay, @DenNgay DenNgay,
			L.TenTaiSan, L.DonViTinh, L.SoLuong, L.DonGia, HT.TenHinhThuc, L.DuToan, L.Ngay, L.GhiChu,L.MoTa
	FROM dbo.KeHoachMuaSam H
	JOIN dbo.KeHoachMuaSamChiTiet L ON L.MuaSamId = H.MuaSamId
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = L.LoaiId
	LEFT JOIN dbo.NhomTaiSan NTS ON NTS.NhomId = LTS.NhomId
	LEFT JOIN dbo.HinhThuc HT ON HT.HinhThucId = L.HinhThucId
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
	WHERE H.CoSoId = @CoSoId
	AND H.Nam = YEAR(@TuNgay)
	
-----------------------------------------------------
END


GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_BaoCaoCongKhaiKetQuaMuaSamTSNNBieu02]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC [dbo].[sp_BaoCao_BaoCaoCongKhaiKetQuaMuaSamTSNNBieu02] @TuNgay = '2017-10-05 02:12:35', -- datetime
    @DenNgay = '2017-10-05 02:12:35', -- datetime
    @NhanVienId = N'1', -- nvarchar(10)
    @CoSoId = N'1' -- nvarchar(10)
*/

CREATE PROC [dbo].[sp_BaoCao_BaoCaoCongKhaiKetQuaMuaSamTSNNBieu02]
( 
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NhanVienId NVARCHAR(10),
	@CoSoId NVARCHAR(10)
)
AS  
BEGIN

------------------------------------------------  

	SELECT '-.-'
	
-----------------------------------------------------
END


GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_BaoCaoCongKhaiTinhHinhXuLyTSBieu06]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC [dbo].[sp_BaoCao_BaoCaoCongKhaiTinhHinhXuLyTSBieu06] @TuNgay = '2017-10-05 02:12:35', -- datetime
    @DenNgay = '2017-11-05 02:12:35', -- datetime
    @NhanVienId = N'1', -- nvarchar(10)
    @CoSoId = N'1' -- nvarchar(10)
*/

CREATE PROC [dbo].[sp_BaoCao_BaoCaoCongKhaiTinhHinhXuLyTSBieu06]
( 
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NhanVienId NVARCHAR(10),
	@CoSoId NVARCHAR(10)
)
AS  
BEGIN
------------------------------------------------------------------------------------------------------------------------------------------------
	DECLARE @tb_NganSach TABLE
	(
		_MaNganSach NVARCHAR(50),
		_TenNganSach NVARCHAR(500)
	)
	DECLARE @tb_NganSachTaiSan TABLE
	(
		TaiSanId INT,
		MaNguonNganSach NVARCHAR(50),
		TenNguonNganSach NVARCHAR(500),
		GiaTri NUMERIC(18,4)
	)
	INSERT @tb_NganSach SELECT MaNguonNganSach,TenNguonNganSach FROM dbo.NguonNganSach

	INSERT @tb_NganSachTaiSan( TaiSanId ,MaNguonNganSach ,TenNguonNganSach ,GiaTri)
	SELECT NG.TaiSanId, NNS.MaNguonNganSach, NNS.TenNguonNganSach, ISNULL(NG.GiaTri,0)
	FROM dbo.NguonNganSach NNS
	LEFT JOIN dbo.NguyenGia NG ON NG.NguonNganSachId = NNS.NguonNganSachId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = NG.TaiSanId
	WHERE TS.CoSoId = @CoSoId

	DECLARE @tb_Result TABLE
	(
		RowId INT IDENTITY(1,1),
		CoSoId INT,
		TaiSanId INT,
		NgayGhiGiam DATETIME,
		TenXuLy NVARCHAR(500),
		SoLuong NUMERIC(18,4),
		NguonBaoHiem NUMERIC(18,4) DEFAULT 0,
		NguonNganSach NUMERIC(18,4) DEFAULT 0,
		NguonVienTro NUMERIC(18,4) DEFAULT 0,
		NguonKhac NUMERIC(18,4) DEFAULT 0
	)

	INSERT @tb_Result( CoSoId, TaiSanId, NgayGhiGiam ,TenXuLy ,SoLuong)
	SELECT H.CoSoId, L.TaiSanId, H.NgayGhiGiam, XL.TenXuLy, L.SoLuong
	FROM dbo.GhiGiam H
	JOIN dbo.GhiGiamChiTiet  L ON L.GhiGiamId = H.GhiGiamId
	LEFT JOIN dbo.XuLy XL ON XL.XuLyId = L.XuLyId
	WHERE CAST(H.NgayGhiGiam AS DATE) BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE)
	AND H.CoSoId = @CoSoId
	
	DECLARE @V_MaNganSach NVARCHAR(50), @V_TenNganSach NVARCHAR(500)
	WHILE EXISTS(SELECT 1 FROM @tb_NganSach)
	BEGIN
		SELECT TOP 1 @V_MaNganSach = [_MaNganSach], @V_TenNganSach= [_TenNganSach] FROM @tb_NganSach
		IF (CHARINDEX(N'bảo hiểm', LOWER(@V_TenNganSach)) > 0)
		BEGIN
			UPDATE RS
			SET RS.NguonBaoHiem = NSTS.GiaTri
			FROM @tb_Result RS 
			LEFT JOIN @tb_NganSachTaiSan NSTS ON NSTS.TaiSanId = RS.TaiSanId
			WHERE NSTS.MaNguonNganSach = @V_MaNganSach
		END
		ELSE IF (CHARINDEX(N'ngân sách viện trợ', LOWER(@V_TenNganSach)) > 0)
		BEGIN
			UPDATE RS
			SET RS.NguonVienTro = NSTS.GiaTri
			FROM @tb_Result RS 
			LEFT JOIN @tb_NganSachTaiSan NSTS ON NSTS.TaiSanId = RS.TaiSanId
			WHERE NSTS.MaNguonNganSach = @V_MaNganSach
		END
		ELSE IF (CHARINDEX(N'nguồn ngân sách', LOWER(@V_TenNganSach)) > 0)
		BEGIN
			UPDATE RS
			SET RS.NguonNganSach = NSTS.GiaTri
			FROM @tb_Result RS 
			LEFT JOIN @tb_NganSachTaiSan NSTS ON NSTS.TaiSanId = RS.TaiSanId
			WHERE NSTS.MaNguonNganSach = @V_MaNganSach
		END
		ELSE
        BEGIN
			UPDATE RS
			SET RS.NguonKhac = RS.NguonKhac + NSTS.GiaTri
			FROM @tb_Result RS 
			LEFT JOIN @tb_NganSachTaiSan NSTS ON NSTS.TaiSanId = RS.TaiSanId
			WHERE NSTS.MaNguonNganSach = @V_MaNganSach
		END
		

		DELETE @tb_NganSach WHERE [_MaNganSach] = @V_MaNganSach
		SELECT @V_MaNganSach = NULL, @V_TenNganSach =NULL
	END

	SELECT CS.MaCoSo, CS.TenCoSo, @TuNgay TuNgay, @DenNgay DenNgay,
			ts.TenTaiSan, NTS.TenNhom, LTS.TenLoai, rs.TenXuLy,
			CASE WHEN CHARINDEX(N'ĐIỀU CHUYỂN', UPPER(rs.TenXuLy)) > 0 THEN 'X' ELSE '' END HTXLDieuChuyen,
			CASE WHEN CHARINDEX(N'CHUYỂN NHƯỢNG', UPPER(rs.TenXuLy)) > 0 OR 
					  CHARINDEX(N'BÁN ĐẤU GIÁ', UPPER(rs.TenXuLy)) > 0 THEN 'X' ELSE '' END HTXLChuyenNhuong,
			CASE WHEN CHARINDEX(N'ĐIỀU CHUYỂN', UPPER(rs.TenXuLy)) <= 0 AND 
					  CHARINDEX(N'CHUYỂN NHƯỢNG', UPPER(rs.TenXuLy)) <= 0 AND
					  CHARINDEX(N'BÁN ĐẤU GIÁ', UPPER(rs.TenXuLy)) <=0 THEN 'X' ELSE '' END HTXLKhac,
			rs.NguonNganSach NguonNganSach,
			(rs.NguonBaoHiem + rs.NguonVienTro + rs.NguonKhac) NguonKhac,
			(
					(rs.NguonBaoHiem + rs.NguonVienTro + rs.NguonKhac + rs.NguonNganSach) - (
																								DATEDIFF(YEAR, TS.NgayBDHaoMon, rs.NgayGhiGiam) * 
																								((rs.NguonBaoHiem + rs.NguonVienTro + rs.NguonKhac + rs.NguonNganSach) * TS.TyLeHaoMon / 100)
																								)
			) GiaTriConLai
	FROM @tb_Result rs
	LEFT JOIN dbo.TaiSan ts ON ts.TaiSanId = rs.TaiSanId
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = ts.LoaiId
	LEFT JOIN dbo.NhomTaiSan NTS ON NTS.NhomId = LTS.NhomId
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = rs.CoSoId

	--DECLARE @V_TableName NVARCHAR(50), @cols AS NVARCHAR(MAX), @query  AS NVARCHAR(MAX)

	--SET @V_TableName = 'TEMPORARY' + @NhanVienId + @CoSoId;

	--IF OBJECT_ID('tempdb..##' + @V_TableName) IS NOT NULL
	--BEGIN
	--	EXEC ('DROP TABLE [##' + @V_TableName + ']')
	--END
	--IF OBJECT_ID('tempdb..#abcd1') IS NOT NULL
	--BEGIN
	--	DROP TABLE #abcd1
	--END
	--CREATE TABLE #abcd1
	--(
	--	id INT
	--)
	--select @cols = STUFF((SELECT ',' + QUOTENAME(TenNguonNganSach) 
 --                   from dbo.NguonNganSach 
 --                   group by TenNguonNganSach
 --                   order by TenNguonNganSach
 --           FOR XML PATH(''), TYPE
 --           ).value('.', 'NVARCHAR(MAX)') 
 --       ,1,1,'')

	--set @query = '
			
	--		SELECT * INTO ##' + @V_TableName +' from (
	--		SELECT TaiSanId,' + @cols + ' from 
 --           (
 --               SELECT NG.TaiSanId, NNS.MaNguonNganSach, NNS.TenNguonNganSach, NG.GiaTri
	--			FROM dbo.NguonNganSach NNS
	--			LEFT JOIN dbo.NguyenGia NG ON NG.NguonNganSachId = NNS.NguonNganSachId
	--			LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = NG.TaiSanId
	--			WHERE TS.CoSoId = ' + @CoSoId + '
 --           ) x
 --           pivot 
 --           (
 --               sum(GiaTri)
 --               for TenNguonNganSach in (' + @cols + ')
 --           ) p ) AS B
	--		SELECT * from ##' + @V_TableName +' 
	--		 '
	--PRINT @query

	--EXECUTE(@query)

	
-----------------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_BaoCaoNhapXuatTon]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC [dbo].[sp_BaoCao_BaoCaoNhapXuatTon] @TuNgay = '2017-10-01 02:17:04', -- datetime
    @DenNgay = '2017-10-31 02:17:04', -- datetime
    @NhanVienId = N'1', -- nvarchar(10)
    @CoSoId = N'1', -- nvarchar(10)
	@KhoTaiSanId = N'1' -- nvarchar(10)
*/

CREATE PROC [dbo].[sp_BaoCao_BaoCaoNhapXuatTon]
( 
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NhanVienId NVARCHAR(10),
	@CoSoId NVARCHAR(10),
	@KhoTaiSanId NVARCHAR(100)
)
AS  
BEGIN
------------------------------------------------  
	SET DATEFORMAT YMD
    /*
	SELECT * FROM dbo.KhoTonKho
	SELECT * FROM dbo.KhoTonKhoChiTiet
	*/
	DECLARE @TenKho NVARCHAR(150), @ThangNamMin DATE
	IF (@KhoTaiSanId = '0')	SET @TenKho = N'Tất cả kho'
	ELSE 
	BEGIN
		SELECT TOP 1 @TenKho = TenKhoTaiSan FROM dbo.KhoTaiSan WHERE CoSoId = @CoSoId AND KhoTaiSanId = @KhoTaiSanId
	END

	-- giả vụ data có từ tháng 10. mà xem từ tháng 01 -> 11. lấy thang năm có tồn đầu đầu tiên
	SELECT @ThangNamMin = MIN(CONVERT(date,right(H.ThangNam,2) +'-'+left(H.ThangNam,2) + '-01')) FROM dbo.KhoTonKho H 
	WHERE H.CoSoId = @CoSoId 
	AND CONVERT(date,right(H.ThangNam,2) +'-'+left(H.ThangNam,2) + '-01') BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE)
	AND (H.KhoTaiSanId = @KhoTaiSanId OR @KhoTaiSanId = '0')

	SELECT MaCoSo, TenCoSo, @TuNgay TuNgay, @DenNgay DenNgay, @TenKho TenKho,
			--KhoTaiSanId, 
			TaiSanId, MaTaiSan, TenTaiSan, DonViTinh, TenLoai, TenNhom, DonGia,
			sum(TonDau)TonDau,				SUM(TTDauKi) TTDauKi,			
			sum(SLNhap)SLNhap,				SUM(TTNhap) TTNhap,
			sum(SLNhapChuyen)SLNhapChuyen,	sum(TTNhapChuyen) TTNhapChuyen,
			sum(SLXuat)SLXuat,				SUM(TTXuat)TTXuat,
			sum(SLXuatChuyen)SLXuatChuyen,	sum(TTXuatChuyen) TTXuatChuyen
	FROM
	(
		SELECT  ISNULL(TonDau.MaCoSo, Nhap.MaCoSo) MaCoSo, ISNULL(TonDau.TenCoSo, Nhap.TenCoSo) TenCoSo,
				ISNULL(TonDau.KhoTaiSanId, Nhap.KhoTaiSanId) KhoTaiSanId,
				ISNULL(TonDau.TaiSanId, nhap.TaiSanId) TaiSanId, TS.MaTaiSan, TS.TenTaiSan, TS.DonViTinh, LTS.TenLoai, NTS.TenNhom,
				ISNULL(TonDau, 0) TonDau,					ISNULL(TonDau.DonGia * TonDau,0) TTDauKi,
				ISNULL(TonDau.DonGia, Nhap.DonGia) DonGia,
				ISNULL(Nhap.SoLuong,0) SLNhap,				ISNULL(TonDau.DonGia, Nhap.DonGia) * ISNULL(Nhap.SoLuong,0) TTNhap,
				ISNULL(NhapChuyen.SoLuong,0) SLNhapChuyen,	ISNULL(TonDau.DonGia, Nhap.DonGia) * ISNULL(NhapChuyen.SoLuong,0) TTNhapChuyen,
				ISNULL(Xuat.SoLuong,0) SLXuat,				ISNULL(TonDau.DonGia, Nhap.DonGia) * ISNULL(Xuat.SoLuong,0) TTXuat,
				ISNULL(XuatChuyen.SoLuong,0) SLXuatChuyen,	ISNULL(TonDau.DonGia, Nhap.DonGia) * ISNULL(XuatChuyen.SoLuong,0) TTXuatChuyen
		FROM
		(
			SELECT H.KhoTaiSanId, L.TaiSanId, L.TonDau, L.DonGia, Description = N'1-Tồn đầu', CS.MaCoSo, CS.TenCoSo
			FROM dbo.KhoTonKho H
			JOIN dbo.KhoTonKhoChiTiet L ON L.KhoTonKhoId = H.KhoTonKhoId
			LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
			WHERE H.CoSoId = @CoSoId 
			AND CONVERT(date,right(H.ThangNam,2) +'-'+left(H.ThangNam,2) + '-01') = @ThangNamMin
			AND (H.KhoTaiSanId = @KhoTaiSanId OR @KhoTaiSanId = '0')
		
		) AS TonDau
		FULL OUTER JOIN
		(
			SELECT H.KhoTaiSanId, L.TaiSanId, SUM(L.SoLuong)SoLuong, L.DonGia, Description = N'2-Nhập', CS.MaCoSo, CS.TenCoSo
			FROM dbo.KhoPhieuNhap H
			JOIN dbo.KhoPhieuNhapChiTiet L ON L.KhoPhieuNhapId = H.KhoPhieuNhapId
			LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
			WHERE H.CoSoId = @CoSoId 
			AND CAST(H.NgayNhap AS DATE) BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE)
			AND (H.KhoTaiSanId = @KhoTaiSanId OR @KhoTaiSanId = '0')
			GROUP BY H.KhoTaiSanId, L.TaiSanId, L.DonGia, CS.MaCoSo, CS.TenCoSo
		) AS Nhap ON Nhap.KhoTaiSanId = TonDau.KhoTaiSanId AND Nhap.TaiSanId = TonDau.TaiSanId AND Nhap.DonGia = TonDau.DonGia
		FULL OUTER JOIN
		(
			SELECT H.KhoNhanId, L.TaiSanId, SUM(L.SoLuong)SoLuong, L.DonGia, Description = N'3-Nhập chuyển'
			FROM dbo.KhoPhieuXuat H
			JOIN dbo.KhoPhieuXuatChiTiet L ON L.KhoPhieuXuatId = H.KhoPhieuXuatId
			WHERE H.CoSoId = @CoSoId 
			AND CAST(H.NgayXuat AS DATE)  BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE) 
			AND H.Loai = 'CK'
			AND (H.KhoNhanId = @KhoTaiSanId OR @KhoTaiSanId = '0')
			GROUP BY H.KhoNhanId, L.TaiSanId, L.DonGia
		) AS NhapChuyen ON TonDau.KhoTaiSanId = NhapChuyen.KhoNhanId AND NhapChuyen.TaiSanId = TonDau.TaiSanId AND NhapChuyen.DonGia = TonDau.DonGia
		FULL OUTER JOIN
		(
			SELECT H.KhoXuatId, L.TaiSanId, SUM(L.SoLuong)SoLuong, L.DonGia, Description = N'4-Xuất'
			FROM dbo.KhoPhieuXuat H
			JOIN dbo.KhoPhieuXuatChiTiet L ON L.KhoPhieuXuatId = H.KhoPhieuXuatId
			WHERE H.CoSoId = @CoSoId 
			AND CAST(H.NgayXuat AS DATE)  BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE) 
			AND H.Loai = 'XK'
			AND (H.KhoXuatId = @KhoTaiSanId OR @KhoTaiSanId = '0')
			GROUP BY H.KhoXuatId, L.TaiSanId, L.DonGia
		) AS Xuat ON Xuat.KhoXuatId = TonDau.KhoTaiSanId AND Xuat.TaiSanId = TonDau.TaiSanId AND Xuat.DonGia = TonDau.DonGia
		FULL OUTER JOIN
		(
			SELECT H.KhoXuatId, L.TaiSanId, SUM(L.SoLuong)SoLuong, L.DonGia, Description = N'5-Xuất chuyển'
			FROM dbo.KhoPhieuXuat H
			JOIN dbo.KhoPhieuXuatChiTiet L ON L.KhoPhieuXuatId = H.KhoPhieuXuatId
			WHERE H.CoSoId = @CoSoId 
			AND CAST(H.NgayXuat AS DATE)  BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE) 
			AND H.Loai = 'CK'
			AND (H.KhoXuatId = @KhoTaiSanId OR @KhoTaiSanId = '0')
			GROUP BY H.KhoXuatId, L.TaiSanId, L.DonGia
		) AS XuatChuyen ON XuatChuyen.KhoXuatId = TonDau.KhoTaiSanId AND XuatChuyen.TaiSanId = TonDau.TaiSanId AND XuatChuyen.DonGia = TonDau.DonGia
		LEFT JOIN dbo.TaiSan TS ON (TS.TaiSanId = TonDau.TaiSanId OR TS.TaiSanId = Nhap.TaiSanId)
		LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = TS.LoaiId
		LEFT JOIN dbo.NhomTaiSan NTS ON NTS.NhomId = LTS.NhomId
	) AS KQ
	GROUP BY MaCoSo, TenCoSo, TaiSanId, MaTaiSan, TenTaiSan, DonViTinh, TenLoai, TenNhom, DonGia
-----------------------------------------------------
END


GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_BaoCaoNhapXuatTon_311017]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC [dbo].[sp_BaoCao_BaoCaoNhapXuatTon] @TuNgay = '2017-10-01 02:17:04', -- datetime
    @DenNgay = '2017-10-31 02:17:04', -- datetime
    @NhanVienId = N'1', -- nvarchar(10)
    @CoSoId = N'1', -- nvarchar(10)
	@KhoTaiSanId = N'1' -- nvarchar(10)
*/

CREATE PROC [dbo].[sp_BaoCao_BaoCaoNhapXuatTon_311017]
( 
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NhanVienId NVARCHAR(10),
	@CoSoId NVARCHAR(10),
	@KhoTaiSanId NVARCHAR(100)
)
AS  
BEGIN
------------------------------------------------  
	SET DATEFORMAT YMD
    /*
	SELECT * FROM dbo.KhoTonKho
	SELECT * FROM dbo.KhoTonKhoChiTiet
	*/
	DECLARE @TenKho NVARCHAR(150)
	IF (@KhoTaiSanId = '0')	SET @TenKho = N'Tất cả kho'
	ELSE 
	BEGIN
		SELECT TOP 1 @TenKho = TenKhoTaiSan FROM dbo.KhoTaiSan WHERE CoSoId = @CoSoId AND KhoTaiSanId = @KhoTaiSanId
	END

	SELECT  TonDau.MaCoSo, TonDau.TenCoSo, @TuNgay TuNgay, @DenNgay DenNgay, @TenKho TenKho,
			TonDau.KhoTaiSanId,
			TonDau.TaiSanId, TS.MaTaiSan, TS.TenTaiSan, TS.DonViTinh, LTS.TenLoai, NTS.TenNhom,
			TonDau,								TonDau.DonGia * TonDau TTDauKi,
			TonDau.DonGia,
			ISNULL(Nhap.SoLuong,0) SLNhap,				TonDau.DonGia * ISNULL(Nhap.SoLuong,0) TTNhap,
			ISNULL(NhapChuyen.SoLuong,0) SLNhapChuyen,	TonDau.DonGia * ISNULL(NhapChuyen.SoLuong,0) TTNhapChuyen,
			ISNULL(Xuat.SoLuong,0) SLXuat,				TonDau.DonGia * ISNULL(Xuat.SoLuong,0) TTXuat,
			ISNULL(XuatChuyen.SoLuong,0) SLXuatChuyen,	TonDau.DonGia * ISNULL(XuatChuyen.SoLuong,0) TTXuatChuyen
	FROM
	(
		SELECT H.KhoTaiSanId, L.TaiSanId, L.TonDau, L.DonGia, Description = N'1-Tồn đầu', CS.MaCoSo, CS.TenCoSo
		FROM dbo.KhoTonKho H
		JOIN dbo.KhoTonKhoChiTiet L ON L.KhoTonKhoId = H.KhoTonKhoId
		LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
		WHERE H.CoSoId = @CoSoId 
		AND CONVERT(date,right(H.ThangNam,2) +'-'+left(H.ThangNam,2) + '-01') = CAST(@TuNgay AS DATE)
		AND (H.KhoTaiSanId = @KhoTaiSanId OR @KhoTaiSanId = '0')
		
	) AS TonDau
	LEFT JOIN
	(
		SELECT H.KhoTaiSanId, L.TaiSanId, SUM(L.SoLuong)SoLuong, L.DonGia, Description = N'2-Nhập'
		FROM dbo.KhoPhieuNhap H
		JOIN dbo.KhoPhieuNhapChiTiet L ON L.KhoPhieuNhapId = H.KhoPhieuNhapId
		WHERE H.CoSoId = @CoSoId 
		AND CAST(H.NgayNhap AS DATE) BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE)
		AND (H.KhoTaiSanId = @KhoTaiSanId OR @KhoTaiSanId = '0')
		GROUP BY H.KhoTaiSanId, L.TaiSanId, L.DonGia
	) AS Nhap ON Nhap.KhoTaiSanId = TonDau.KhoTaiSanId AND Nhap.TaiSanId = TonDau.TaiSanId AND Nhap.DonGia = TonDau.DonGia
	LEFT JOIN
	(
		SELECT H.KhoNhanId, L.TaiSanId, SUM(L.SoLuong)SoLuong, L.DonGia, Description = N'3-Nhập chuyển'
		FROM dbo.KhoPhieuXuat H
		JOIN dbo.KhoPhieuXuatChiTiet L ON L.KhoPhieuXuatId = H.KhoPhieuXuatId
		WHERE H.CoSoId = @CoSoId 
		AND CAST(H.NgayXuat AS DATE)  BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE) 
		AND H.Loai = 'CK'
		AND (H.KhoNhanId = @KhoTaiSanId OR @KhoTaiSanId = '0')
		GROUP BY H.KhoNhanId, L.TaiSanId, L.DonGia
	) AS NhapChuyen ON TonDau.KhoTaiSanId = NhapChuyen.KhoNhanId AND NhapChuyen.TaiSanId = TonDau.TaiSanId AND NhapChuyen.DonGia = TonDau.DonGia
	LEFT JOIN
	(
		SELECT H.KhoXuatId, L.TaiSanId, SUM(L.SoLuong)SoLuong, L.DonGia, Description = N'4-Xuất'
		FROM dbo.KhoPhieuXuat H
		JOIN dbo.KhoPhieuXuatChiTiet L ON L.KhoPhieuXuatId = H.KhoPhieuXuatId
		WHERE H.CoSoId = @CoSoId 
		AND CAST(H.NgayXuat AS DATE)  BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE) 
		AND H.Loai = 'XK'
		AND (H.KhoXuatId = @KhoTaiSanId OR @KhoTaiSanId = '0')
		GROUP BY H.KhoXuatId, L.TaiSanId, L.DonGia
	) AS Xuat ON Xuat.KhoXuatId = TonDau.KhoTaiSanId AND Xuat.TaiSanId = TonDau.TaiSanId AND Xuat.DonGia = TonDau.DonGia
	LEFT JOIN
	(
		SELECT H.KhoXuatId, L.TaiSanId, SUM(L.SoLuong)SoLuong, L.DonGia, Description = N'5-Xuất chuyển'
		FROM dbo.KhoPhieuXuat H
		JOIN dbo.KhoPhieuXuatChiTiet L ON L.KhoPhieuXuatId = H.KhoPhieuXuatId
		WHERE H.CoSoId = @CoSoId 
		AND CAST(H.NgayXuat AS DATE)  BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE) 
		AND H.Loai = 'CK'
		AND (H.KhoXuatId = @KhoTaiSanId OR @KhoTaiSanId = '0')
		GROUP BY H.KhoXuatId, L.TaiSanId, L.DonGia
	) AS XuatChuyen ON XuatChuyen.KhoXuatId = TonDau.KhoTaiSanId AND XuatChuyen.TaiSanId = TonDau.TaiSanId AND XuatChuyen.DonGia = TonDau.DonGia
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = TonDau.TaiSanId
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = TS.LoaiId
	LEFT JOIN dbo.NhomTaiSan NTS ON NTS.NhomId = LTS.NhomId

-----------------------------------------------------
END


GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_BaoCaoTongHopGhiGiam]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC [dbo].[sp_BaoCao_BaoCaoTongHopGhiGiam] @TuNgay = '2017-10-05 02:17:04', -- datetime
    @DenNgay = '2017-10-05 02:17:04', -- datetime
    @NhanVienId = N'1', -- nvarchar(10)
    @CoSoId = N'1' -- nvarchar(10)
*/


CREATE PROC [dbo].[sp_BaoCao_BaoCaoTongHopGhiGiam]
( 
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NhanVienId NVARCHAR(10),
	@CoSoId NVARCHAR(10)
)
AS  
BEGIN
------------------------------------------------  
	SELECT	CS.MaCoSo, CS.TenCoSo,
			H.SoChungTu,
			H.NgayChungTu,
			H.NgayGhiGiam,
			H.NoiDung,
			-----------------------------------------------line
			TS.TenTaiSan, LTS.TenLoai LoaiTaiSan, TS.NamSanXuat, NSX.TenNuocSanXuat, TS.SoQDTC, PB.TenPhongBan, L.SoLuong,
			TD.NgayBatDauSuDung, @TuNgay TuNgay, @DenNgay DenNgay

	FROM dbo.GhiGiam H
	JOIN dbo.GhiGiamChiTiet L ON l.GhiGiamId = H.GhiGiamId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = L.TaiSanId
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = TS.LoaiId
	LEFT JOIN dbo.NuocSanXuat NSX ON NSX.NuocSanXuatId = TS.NuocSanXuatId
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = L.PhongBanId
	LEFT JOIN TheoDoi TD ON l.TaiSanId = TD.TaiSanId and l.PhongBanId=TD.PhongBanId and l.NhanVienId=TD.NhanVienId AND TD.Nam = YEAR(@TuNgay)
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
	WHERE CAST(H.NgayGhiGiam AS DATE) BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE)
	AND CS.CoSoId= @CoSoId
	ORDER BY H.NgayChungTu, H.SoChungTu
-----------------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_BaoCaoTongHopGhiTang]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC [dbo].[sp_BaoCao_BaoCaoTongHopGhiTang] @TuNgay = '2017-10-05 02:12:35', -- datetime
    @DenNgay = '2017-10-05 02:12:35', -- datetime
    @NhanVienId = N'1', -- nvarchar(10)
    @CoSoId = N'1' -- nvarchar(10)
*/

CREATE PROC [dbo].[sp_BaoCao_BaoCaoTongHopGhiTang]
( 
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NhanVienId NVARCHAR(10),
	@CoSoId NVARCHAR(10)
)
AS  
BEGIN
------------------------------------------------  
	SELECT	CS.MaCoSo, CS.TenCoSo,
			H.SoChungTu,
			H.NgayChungTu,
			H.NgayGhiTang,
			H.NoiDung,
			-----------------------------------------------line
			TS.TenTaiSan, LTS.TenLoai LoaiTaiSan, TS.NamSanXuat, NSX.TenNuocSanXuat, TS.SoQDTC, PB.TenPhongBan, NV.TenNhanVien, L.SoLuong,
			L.NgayBatDauSuDung, @TuNgay TuNgay, @DenNgay DenNgay

	FROM dbo.GhiTang H
	JOIN dbo.GhiTangChiTiet L ON L.GhiTangId = H.GhiTangId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = L.TaiSanId
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = TS.LoaiId
	LEFT JOIN dbo.NuocSanXuat NSX ON NSX.NuocSanXuatId = TS.NuocSanXuatId
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = L.PhongBanId
	LEFT JOIN dbo.NhanVien NV ON NV.NhanVienId = L.NhanVienId
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
	WHERE CAST(H.NgayGhiTang AS DATE) BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE)
	AND CS.CoSoId= @CoSoId
	ORDER BY H.NgayChungTu, H.SoChungTu
-----------------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_BaoCaoTongHopSoTaiSanCoDinhBieuS21]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC [dbo].[sp_BaoCao_BaoCaoTongHopSoTaiSanCoDinhBieuS21] @TuNgay = '2017-09-02 08:07:29', -- datetime
    @DenNgay = '2017-10-02 08:07:29', -- datetime
    @NhanVienId = N'1', -- nvarchar(10)
    @CoSoId = N'1' -- nvarchar(10)
*/

CREATE PROC [dbo].[sp_BaoCao_BaoCaoTongHopSoTaiSanCoDinhBieuS21]
( 
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NhanVienId NVARCHAR(10),
	@CoSoId NVARCHAR(10)
)
AS  
BEGIN
------------------------------------------------  
	DECLARE @TenCoSo NVARCHAR(250), @DiaChi NVARCHAR(500)
	SELECT @TenCoSo = TenCoSo, @DiaChi = DiaChi FROM dbo.CoSo WHERE CoSoId = @CoSoId

	SELECT H.SoChungTu SoChungTu_T, @TenCoSo TenCoSo, @DiaChi DiaChi, @TuNgay TuNgay,
		   H.NgayGhiTang NgayGhiTang, 
		   TS.TenTaiSan TenTaiSan_T, 
		   NSX.TenNuocSanXuat TenNuocSanXuat_T, 
		   L.NgayBatDauSuDung NamSuDung_T, 
		   TS.SoQDTC SoHieu_T, 
		   LTS.TenLoai TenLoai,
		   SUM(ISNULL(NG.GiaTri,0)) NguyenGia_T, 
		   TS.TyLeKhauHao TyLeKhauHao,
		   SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeKhauHao / 100 GiaTriKhauHao,
		   '' SoChungTu_G, NULL NgayGhiGiam, '' LyDoGiam,
		   NULL KhauHaoLuyke
	FROM dbo.GhiTang H
	JOIN dbo.GhiTangChiTiet L ON L.GhiTangId = H.GhiTangId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = l.TaiSanId
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = TS.LoaiId
	LEFT JOIN dbo.NuocSanXuat NSX ON NSX.NuocSanXuatId = TS.NuocSanXuatId
	LEFT JOIN dbo.NguyenGia NG ON NG.TaiSanId = TS.TaiSanId
	WHERE CAST(H.NgayGhiTang AS DATE) BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE)
	AND H.CoSoId = @CoSoId
	GROUP BY H.SoChungTu, H.NgayGhiTang, TS.TenTaiSan, NSX.TenNuocSanXuat, L.NgayBatDauSuDung, TS.SoQDTC, LTS.TenLoai, TS.TyLeKhauHao

	UNION ALL

	SELECT '' SoChungTu_T, @TenCoSo TenCoSo, @DiaChi DiaChi, @TuNgay TuNgay,
		   NULL NgayGhiTang, 
		   '' TenTaiSan_T, 
		   '' TenNuocSanXuat_T, 
		   NULL NamSuDung_T, 
		   '' SoHieu_T, 
		   LTS.TenLoai TenLoai,
		   NULL NguyenGia_T, 
		   TS.TyLeKhauHao TyLeKhauHao,
		   SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeKhauHao / 100 GiaTriKhauHao,
		   H.SoChungTu SoChungTu_G, H.NgayGhiGiam NgayGhiGiam, XL.TenXuLy LyDoGiam,
		   ISNULL
			(
				(SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeKhauHao / 100) * 
				(
					--so ky khau hao
					TS.SoKyKhauHao - 
					--so ky con lai
					(   CASE WHEN 
								(
									CASE WHEN KyTinhKhauHao = N'Tháng' THEN 1 
										 WHEN KyTinhKhauHao = N'Quý' THEN 3
										 WHEN KyTinhKhauHao = N'Năm' THEN 12 
										 ELSE 0 END
									* TS.SoKyKhauHao - DATEDIFF(MONTH, TS.NgayBDKhauHao, H.NgayGhiGiam)
								) > 0 THEN FLOOR(
													(
														CASE WHEN KyTinhKhauHao = N'Tháng' THEN 1 
															 WHEN KyTinhKhauHao = N'Quý' THEN 3
															 WHEN KyTinhKhauHao = N'Năm' THEN 12 
															 ELSE 0 END
														* TS.SoKyKhauHao - DATEDIFF(MONTH, TS.NgayBDKhauHao, H.NgayGhiGiam)
													) / 
													(
														CASE WHEN KyTinhKhauHao = N'Tháng' THEN 1 
															 WHEN KyTinhKhauHao = N'Quý' THEN 3
															 WHEN KyTinhKhauHao = N'Năm' THEN 12 
															 ELSE 1 END
													)
												)
										ELSE 0 END
					)
				) 
			, 0)KhauHaoLuyKe
	FROM dbo.GhiGiam H
	JOIN dbo.GhiGiamChiTiet L ON l.GhiGiamId = H.GhiGiamId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = l.TaiSanId
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = TS.LoaiId
	LEFT JOIN dbo.NuocSanXuat NSX ON NSX.NuocSanXuatId = TS.NuocSanXuatId
	LEFT JOIN dbo.TheoDoi TD ON TD.TaiSanId = L.TaiSanId AND TD.NhanVienId = L.NhanVienId AND TD.PhongBanId = L.PhongBanId AND YEAR(H.NgayGhiGiam) = TD.Nam
	LEFT JOIN dbo.NguyenGia NG ON NG.TaiSanId = TS.TaiSanId
	LEFT JOIN dbo.XuLy XL ON XL.XuLyId = L.XuLyId
	WHERE CAST(H.NgayGhiGiam AS DATE) BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE)
	AND H.CoSoId = @CoSoId
	GROUP BY LTS.TenLoai, TS.TyLeKhauHao, H.SoChungTu, H.NgayGhiGiam, XL.TenXuLy, TS.SoKyKhauHao, KyTinhKhauHao,TS.NgayBDKhauHao
-----------------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_BaoCaoTongHopTaiSanCoDinh]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC [dbo].[sp_BaoCao_BaoCaoTongHopTaiSanCoDinh_v1_test] @TuNgay = '2017-09-02 08:07:29', -- datetime
    @DenNgay = '2017-11-05 08:07:29', -- datetime
    @NhanVienId = N'1', -- nvarchar(10)
    @CoSoId = N'1' -- nvarchar(10)
*/

CREATE PROC [dbo].[sp_BaoCao_BaoCaoTongHopTaiSanCoDinh]
( 
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NhanVienId NVARCHAR(10),
	@CoSoId NVARCHAR(10)
)
AS  
BEGIN
------------------------------------------------  
	DECLARE @tb_NganSachTaiSan TABLE
	(
		TaiSanId INT,
		MaNguonNganSach NVARCHAR(50),
		TenNguonNganSach NVARCHAR(500),
		GiaTri NUMERIC(18,4)
	)
	DECLARE @tb_Result TABLE
	(
		RowId INT IDENTITY(1,1),
		TaiSanId INT,
		CoSoId INT,
		NhanVienId INT,
		PhongBanId INT,
		SoLuong NUMERIC(18,4),
		NgayBatDauSuDung DATETIME,
		NguonBaoHiem NUMERIC(18,4) DEFAULT 0,
		NguonNganSach NUMERIC(18,4) DEFAULT 0,
		NguonVienTro NUMERIC(18,4) DEFAULT 0, -- tinh luon + nguon khác o day
		NguonKhac NUMERIC(18,4) DEFAULT 0
	)

	INSERT @tb_NganSachTaiSan( TaiSanId ,MaNguonNganSach ,TenNguonNganSach ,GiaTri)
	SELECT NG.TaiSanId, NNS.MaNguonNganSach, NNS.TenNguonNganSach, ISNULL(NG.GiaTri,0)
	FROM dbo.NguonNganSach NNS
	LEFT JOIN dbo.NguyenGia NG ON NG.NguonNganSachId = NNS.NguonNganSachId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = NG.TaiSanId
	WHERE TS.CoSoId = @CoSoId

	INSERT @tb_Result( TaiSanId , CoSoId, NhanVienId, PhongBanId, SoLuong, NgayBatDauSuDung)
	SELECT TS.TaiSanId, TS.CoSoId, TD.NhanVienId, TD.PhongBanId, (TD.SLTon + TD.SLTang - TD.SLGiam), TD.NgayBatDauSuDung
	FROM dbo.TaiSan TS
	LEFT JOIN dbo.TheoDoi TD ON TD.TaiSanId = TS.TaiSanId AND TD.Nam = YEAR(@TuNgay)
	WHERE TS.CoSoId = @CoSoId

	UPDATE RS
	SET RS.NguonBaoHiem = ISNULL(NS.GiaTri,0)
	FROM @tb_Result RS 
	LEFT JOIN 
	(
		SELECT NSTS.TaiSanId, SUM(NSTS.GiaTri) GiaTri
		FROM @tb_NganSachTaiSan NSTS WHERE LOWER(NSTS.TenNguonNganSach) LIKE N'%nguồn bảo hiểm%' GROUP BY NSTS.TaiSanId
	) as NS ON NS.TaiSanId = RS.TaiSanId

	UPDATE RS
	SET RS.NguonNganSach = ISNULL(NS.GiaTri,0)
	FROM @tb_Result RS 
	LEFT JOIN 
	(
		SELECT NSTS.TaiSanId, SUM(NSTS.GiaTri) GiaTri
		FROM @tb_NganSachTaiSan NSTS WHERE LOWER(NSTS.TenNguonNganSach) LIKE N'%nguồn ngân sách' GROUP BY NSTS.TaiSanId
	) as NS ON NS.TaiSanId = RS.TaiSanId

	UPDATE RS
	SET RS.NguonVienTro = ISNULL(NS.GiaTri,0)
	FROM @tb_Result RS 
	LEFT JOIN 
	(
		SELECT NSTS.TaiSanId, SUM(NSTS.GiaTri) GiaTri
		FROM @tb_NganSachTaiSan NSTS WHERE LOWER(NSTS.TenNguonNganSach) LIKE N'%viện trợ%' GROUP BY NSTS.TaiSanId
	) as NS ON NS.TaiSanId = RS.TaiSanId

	UPDATE RS
	SET RS.NguonKhac = ISNULL(NS.GiaTri,0)
	FROM @tb_Result RS 
	LEFT JOIN 
	(
		SELECT NSTS.TaiSanId, SUM(NSTS.GiaTri) GiaTri
		FROM @tb_NganSachTaiSan NSTS WHERE LOWER(NSTS.TenNguonNganSach) NOT LIKE N'%viện trợ%' AND
										   LOWER(NSTS.TenNguonNganSach) not LIKE N'%nguồn ngân sách' AND 
										   LOWER(NSTS.TenNguonNganSach) NOT LIKE N'%nguồn bảo hiểm%' GROUP BY NSTS.TaiSanId
	) as NS ON NS.TaiSanId = RS.TaiSanId

	SELECT YEAR(@TuNgay) Nam, YEAR(@TuNgay) - 1 NamRoi,
		   CS.MaCoSo, CS.TenCoSo, LTS.TenLoai, NTS.TenNhom,
		   TS.TenTaiSan, NSX.TenNuocSanXuat, HSX.TenHangSanXuat, 
		   NV.TenNhanVien, PB.TenPhongBan, YEAR(RS.NgayBatDauSuDung) NamSuDung,
		   CASE WHEN rs.NguonNganSach > 0 THEN N'Ngân sách mua' ELSE '' END + 
		   CASE WHEN rs.NguonBaoHiem > 0 THEN N', Nguồn bảo hiểm' ELSE '' END + 
		   CASE WHEN rs.NguonVienTro > 0 THEN N', Nguồn viện trợ' ELSE '' END
		   NguonNganSach,
		   RS.SoLuong,
		   FLOOR((RS.NguonNganSach + rs.NguonBaoHiem + RS.NguonVienTro)/1000) DonGia,
		   TS.TyLeKhauHao,
		   100 - ((YEAR(@DenNgay) - YEAR(RS.NgayBatDauSuDung)) * TS.TyLeKhauHao) TyLeChatLuongConLai,
		   (RS.NguonNganSach + rs.NguonBaoHiem + RS.NguonVienTro) NguyenGia,
		   rs.NguonNganSach NguonNganSach1,
		   RS.NguonBaoHiem,
		   RS.NguonVienTro,
		   (RS.NguonNganSach + rs.NguonBaoHiem + RS.NguonVienTro) * TS.TyLeKhauHao / 100 GiaTriKhauHao,
		   (RS.NguonNganSach + rs.NguonBaoHiem + RS.NguonVienTro) - (
																		DATEDIFF(YEAR, TS.NgayBDHaoMon, @DenNgay) * ((RS.NguonNganSach + rs.NguonBaoHiem + RS.NguonVienTro) * TS.TyLeHaoMon / 100)
																	  ) GiaTriConLai,
		   
		  -- khấu hao lũy kế
		  /*
				ThangTheoKy = KyTinhKhauHao == 'Tháng' ? 1
							: KyTinhKhauHao == 'Quý' ? 3
							: KyTinhKhauHao == 'Năm' ? 12
							: 0
				SoThangSD = currDate.diff(NgayBDKhauHao, 'months');
				SoThangConLai = SoKyKhauHao * ThangTheoKy - SoThangSD;
				SoKyConLai = SoThangConLai > 0 ? Math.floor(SoThangConLai / ThangTheoKy) : 0;
				KhauHaoKy (gia tri khau hao) = NguyenGia * TyLeKhauHao / 100;
				KhauHaoLuyKe = KhauHaoKy * (SoKyKhauHao - SoKyConLai);	
		  */
		  ISNULL
		  (
			  ((RS.NguonNganSach + rs.NguonBaoHiem + RS.NguonVienTro) * TS.TyLeKhauHao / 100) * 
			  (
					--so ky khau hao
					TS.SoKyKhauHao - 
					--so ky con lai
					(   CASE WHEN 
								(
									CASE WHEN KyTinhKhauHao = N'Tháng' THEN 1 
										 WHEN KyTinhKhauHao = N'Quý' THEN 3
										 WHEN KyTinhKhauHao = N'Năm' THEN 12 
										 ELSE 0 END
									* TS.SoKyKhauHao - DATEDIFF(MONTH, TS.NgayBDKhauHao, @DenNgay)
								) > 0 THEN FLOOR(
													(
														CASE WHEN KyTinhKhauHao = N'Tháng' THEN 1 
															 WHEN KyTinhKhauHao = N'Quý' THEN 3
															 WHEN KyTinhKhauHao = N'Năm' THEN 12 
															 ELSE 0 END
														* TS.SoKyKhauHao - DATEDIFF(MONTH, TS.NgayBDKhauHao, @DenNgay)
													) / 
													(
														CASE WHEN KyTinhKhauHao = N'Tháng' THEN 1 
															 WHEN KyTinhKhauHao = N'Quý' THEN 3
															 WHEN KyTinhKhauHao = N'Năm' THEN 12 
															 ELSE 1 END
													)
												)
										ELSE 0 END
					)
			  ) 
		  , 0)KhauHaoLuyKe--,TS.KyTinhKhauHao,TS.SoKyKhauHao,TS.TyLeKhauHao
	FROM dbo.TaiSan TS
	LEFT JOIN dbo.HangSanXuat HSX ON HSX.HangSanXuatId = TS.HangSanXuatId
	LEFT JOIN dbo.NuocSanXuat NSX ON NSX.NuocSanXuatId = TS.NuocSanXuatId
	LEFT JOIN @tb_Result RS ON RS.TaiSanId = TS.TaiSanId
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = TS.LoaiId
	LEFT JOIN dbo.NhomTaiSan NTS ON NTS.NhomId = LTS.NhomId
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = rs.PhongBanId
	LEFT JOIN dbo.NhanVien NV ON NV.NhanVienId = rs.NhanVienId
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = TS.CoSoId

	WHERE RS.SoLuong > 0
	AND CS.CoSoId = @CoSoId
	GROUP BY 
			 TS.MaTaiSan, TS.TenTaiSan
			 ,PB.TenPhongBan
			 ,rs.NgayBatDauSuDung
			 ,RS.SoLuong
			 ,RS.NguonNganSach, RS.NguonBaoHiem, RS.NguonVienTro
			 ,TS.TyLeKhauHao
			 ,TS.NgayBDKhauHao
			 ,TS.TyLeHaoMon
			 ,TS.SoKyKhauHao
			 ,TS.KyTinhKhauHao
			 ,TS.NgayBDHaoMon
			 ,CS.MaCoSo
			 ,CS.TenCoSo
			 ,LTS.TenLoai
			 ,NTS.TenNhom
			 ,NSX.TenNuocSanXuat
			 ,HSX.TenHangSanXuat
			 ,NV.TenNhanVien




	--SELECT YEAR(@TuNgay) Nam, YEAR(@TuNgay) - 1 NamRoi,
	--	   CS.MaCoSo, CS.TenCoSo, LTS.TenLoai, NTS.TenNhom,
	--	   TS.TenTaiSan, NSX.TenNuocSanXuat, HSX.TenHangSanXuat, 
	--	   NV.TenNhanVien, PB.TenPhongBan, YEAR(TD.NgayBatDauSuDung) NamSuDung,
	--	   N'Ngân sách mua' NguonNganSach,
	--	   (TD.SLTon + TD.SLTang - TD.SLGiam) SoLuong,
	--	   FLOOR(SUM(ISNULL(NG.GiaTri,0))/1000) DonGia,
	--	   TS.TyLeKhauHao,
	--	   100 - ((YEAR(@DenNgay) - YEAR(TD.NgayBatDauSuDung)) * TS.TyLeKhauHao) TyLeChatLuongConLai,
	--	   SUM(ISNULL(NG.GiaTri,0)) NguyenGia,
	--	   SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeKhauHao / 100 GiaTriKhauHao,
	--	   SUM(ISNULL(NG.GiaTri,0)) - (
	--									DATEDIFF(YEAR, TS.NgayBDHaoMon, @DenNgay) * (SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeHaoMon / 100)
	--								  ) GiaTriConLai,
		   
	--	  -- khấu hao lũy kế
	--	  /*
	--			ThangTheoKy = KyTinhKhauHao == 'Tháng' ? 1
	--						: KyTinhKhauHao == 'Quý' ? 3
	--						: KyTinhKhauHao == 'Năm' ? 12
	--						: 0
	--			SoThangSD = currDate.diff(NgayBDKhauHao, 'months');
	--			SoThangConLai = SoKyKhauHao * ThangTheoKy - SoThangSD;
	--			SoKyConLai = SoThangConLai > 0 ? Math.floor(SoThangConLai / ThangTheoKy) : 0;
	--			KhauHaoKy (gia tri khau hao) = NguyenGia * TyLeKhauHao / 100;
	--			KhauHaoLuyKe = KhauHaoKy * (SoKyKhauHao - SoKyConLai);	
	--	  */
	--	  ISNULL
	--	  (
	--		  (SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeKhauHao / 100) * 
	--		  (
	--				--so ky khau hao
	--				TS.SoKyKhauHao - 
	--				--so ky con lai
	--				(   CASE WHEN 
	--							(
	--								CASE WHEN KyTinhKhauHao = N'Tháng' THEN 1 
	--									 WHEN KyTinhKhauHao = N'Quý' THEN 3
	--									 WHEN KyTinhKhauHao = N'Năm' THEN 12 
	--									 ELSE 0 END
	--								* TS.SoKyKhauHao - DATEDIFF(MONTH, TS.NgayBDKhauHao, @DenNgay)
	--							) > 0 THEN FLOOR(
	--												(
	--													CASE WHEN KyTinhKhauHao = N'Tháng' THEN 1 
	--														 WHEN KyTinhKhauHao = N'Quý' THEN 3
	--														 WHEN KyTinhKhauHao = N'Năm' THEN 12 
	--														 ELSE 0 END
	--													* TS.SoKyKhauHao - DATEDIFF(MONTH, TS.NgayBDKhauHao, @DenNgay)
	--												) / 
	--												(
	--													CASE WHEN KyTinhKhauHao = N'Tháng' THEN 1 
	--														 WHEN KyTinhKhauHao = N'Quý' THEN 3
	--														 WHEN KyTinhKhauHao = N'Năm' THEN 12 
	--														 ELSE 1 END
	--												)
	--											)
	--									ELSE 0 END
	--				)
	--		  ) 
	--	  , 0)KhauHaoLuyKe--,TS.KyTinhKhauHao,TS.SoKyKhauHao,TS.TyLeKhauHao
	--FROM dbo.TaiSan TS
	--LEFT JOIN dbo.HangSanXuat HSX ON HSX.HangSanXuatId = TS.HangSanXuatId
	--LEFT JOIN dbo.NuocSanXuat NSX ON NSX.NuocSanXuatId = TS.NuocSanXuatId
	--LEFT JOIN dbo.TheoDoi TD ON TD.TaiSanId = TS.TaiSanId AND TD.Nam = YEAR(@TuNgay)
	--LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = TS.LoaiId
	--LEFT JOIN dbo.NhomTaiSan NTS ON NTS.NhomId = LTS.NhomId
	--LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = TD.PhongBanId
	--LEFT JOIN dbo.NhanVien NV ON NV.NhanVienId = TD.NhanVienId
	--LEFT JOIN dbo.NguyenGia NG ON NG.TaiSanId = TS.TaiSanId
	--LEFT JOIN dbo.CoSo CS ON CS.CoSoId = TS.CoSoId

	--WHERE (TD.SLTon + TD.SLTang - TD.SLGiam) > 0
	--AND CS.CoSoId = @CoSoId
	--GROUP BY 
	--		 TS.MaTaiSan, TS.TenTaiSan
	--		 ,PB.TenPhongBan
	--		 ,TD.NgayBatDauSuDung
	--		 ,TD.SLTon
	--		 ,TD.SLTang
	--		 ,TD.SLGiam
	--		 ,TS.TyLeKhauHao
	--		 ,TS.NgayBDKhauHao
	--		 ,TS.TyLeHaoMon
	--		 ,TS.SoKyKhauHao
	--		 ,TS.KyTinhKhauHao
	--		 ,TS.NgayBDHaoMon
	--		 ,CS.MaCoSo
	--		 ,CS.TenCoSo
	--		 ,LTS.TenLoai
	--		 ,NTS.TenNhom
	--		 ,NSX.TenNuocSanXuat
	--		 ,HSX.TenHangSanXuat
	--		 ,NV.TenNhanVien
-----------------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_BaoCaoTongHopTaiSanCoDinh_031117]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC [dbo].[sp_BaoCao_BaoCaoTongHopTaiSanCoDinh] @TuNgay = '2017-09-02 08:07:29', -- datetime
    @DenNgay = '2017-10-02 08:07:29', -- datetime
    @NhanVienId = N'1', -- nvarchar(10)
    @CoSoId = N'1' -- nvarchar(10)
*/

CREATE PROC [dbo].[sp_BaoCao_BaoCaoTongHopTaiSanCoDinh_031117]
( 
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NhanVienId NVARCHAR(10),
	@CoSoId NVARCHAR(10)
)
AS  
BEGIN
------------------------------------------------  
	
	SELECT YEAR(@TuNgay) Nam, YEAR(@TuNgay) - 1 NamRoi,
		   CS.MaCoSo, CS.TenCoSo, LTS.TenLoai, NTS.TenNhom,
		   TS.TenTaiSan, NSX.TenNuocSanXuat, HSX.TenHangSanXuat, 
		   NV.TenNhanVien, PB.TenPhongBan, YEAR(TD.NgayBatDauSuDung) NamSuDung,
		   N'Ngân sách mua' NguonNganSach,
		   (TD.SLTon + TD.SLTang - TD.SLGiam) SoLuong,
		   FLOOR(SUM(ISNULL(NG.GiaTri,0))/1000) DonGia,
		   TS.TyLeKhauHao,
		   100 - ((YEAR(@DenNgay) - YEAR(TD.NgayBatDauSuDung)) * TS.TyLeKhauHao) TyLeChatLuongConLai,
		   SUM(ISNULL(NG.GiaTri,0)) NguyenGia,
		   SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeKhauHao / 100 GiaTriKhauHao,
		   SUM(ISNULL(NG.GiaTri,0)) - (
										DATEDIFF(YEAR, TS.NgayBDHaoMon, @DenNgay) * (SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeHaoMon / 100)
									  ) GiaTriConLai,
		   
		  -- khấu hao lũy kế
		  /*
				ThangTheoKy = KyTinhKhauHao == 'Tháng' ? 1
							: KyTinhKhauHao == 'Quý' ? 3
							: KyTinhKhauHao == 'Năm' ? 12
							: 0
				SoThangSD = currDate.diff(NgayBDKhauHao, 'months');
				SoThangConLai = SoKyKhauHao * ThangTheoKy - SoThangSD;
				SoKyConLai = SoThangConLai > 0 ? Math.floor(SoThangConLai / ThangTheoKy) : 0;
				KhauHaoKy (gia tri khau hao) = NguyenGia * TyLeKhauHao / 100;
				KhauHaoLuyKe = KhauHaoKy * (SoKyKhauHao - SoKyConLai);	
		  */
		  ISNULL
		  (
			  (SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeKhauHao / 100) * 
			  (
					--so ky khau hao
					TS.SoKyKhauHao - 
					--so ky con lai
					(   CASE WHEN 
								(
									CASE WHEN KyTinhKhauHao = N'Tháng' THEN 1 
										 WHEN KyTinhKhauHao = N'Quý' THEN 3
										 WHEN KyTinhKhauHao = N'Năm' THEN 12 
										 ELSE 0 END
									* TS.SoKyKhauHao - DATEDIFF(MONTH, TS.NgayBDKhauHao, @DenNgay)
								) > 0 THEN FLOOR(
													(
														CASE WHEN KyTinhKhauHao = N'Tháng' THEN 1 
															 WHEN KyTinhKhauHao = N'Quý' THEN 3
															 WHEN KyTinhKhauHao = N'Năm' THEN 12 
															 ELSE 0 END
														* TS.SoKyKhauHao - DATEDIFF(MONTH, TS.NgayBDKhauHao, @DenNgay)
													) / 
													(
														CASE WHEN KyTinhKhauHao = N'Tháng' THEN 1 
															 WHEN KyTinhKhauHao = N'Quý' THEN 3
															 WHEN KyTinhKhauHao = N'Năm' THEN 12 
															 ELSE 1 END
													)
												)
										ELSE 0 END
					)
			  ) 
		  , 0)KhauHaoLuyKe--,TS.KyTinhKhauHao,TS.SoKyKhauHao,TS.TyLeKhauHao
	FROM dbo.TaiSan TS
	LEFT JOIN dbo.HangSanXuat HSX ON HSX.HangSanXuatId = TS.HangSanXuatId
	LEFT JOIN dbo.NuocSanXuat NSX ON NSX.NuocSanXuatId = TS.NuocSanXuatId
	LEFT JOIN dbo.TheoDoi TD ON TD.TaiSanId = TS.TaiSanId AND TD.Nam = YEAR(@TuNgay)
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = TS.LoaiId
	LEFT JOIN dbo.NhomTaiSan NTS ON NTS.NhomId = LTS.NhomId
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = TD.PhongBanId
	LEFT JOIN dbo.NhanVien NV ON NV.NhanVienId = TD.NhanVienId
	LEFT JOIN dbo.NguyenGia NG ON NG.TaiSanId = TS.TaiSanId
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = TS.CoSoId

	WHERE (TD.SLTon + TD.SLTang - TD.SLGiam) > 0
	AND CS.CoSoId = @CoSoId
	GROUP BY 
			 TS.MaTaiSan, TS.TenTaiSan
			 ,PB.TenPhongBan
			 ,TD.NgayBatDauSuDung
			 ,TD.SLTon
			 ,TD.SLTang
			 ,TD.SLGiam
			 ,TS.TyLeKhauHao
			 ,TS.NgayBDKhauHao
			 ,TS.TyLeHaoMon
			 ,TS.SoKyKhauHao
			 ,TS.KyTinhKhauHao
			 ,TS.NgayBDHaoMon
			 ,CS.MaCoSo
			 ,CS.TenCoSo
			 ,LTS.TenLoai
			 ,NTS.TenNhom
			 ,NSX.TenNuocSanXuat
			 ,HSX.TenHangSanXuat
			 ,NV.TenNhanVien
-----------------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_BaoCaoTongHopTinhHinhTangGiamTSCD]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

EXEC [dbo].[sp_BaoCao_BaoCaoTongHopTinhHinhTangGiamTSCD] @TuNgay = '2017-7-1 02:17:04', -- datetime
    @DenNgay = '2017-09-30 02:17:04', -- datetime
    @NhanVienId = N'1', -- nvarchar(10)
    @CoSoId = N'1' -- nvarchar(10)

*/


CREATE PROC [dbo].[sp_BaoCao_BaoCaoTongHopTinhHinhTangGiamTSCD]
( 
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NhanVienId NVARCHAR(10),
	@CoSoId NVARCHAR(10)
)
AS  
BEGIN
------------------------------------------------  
	DECLARE @V_QUY NVARCHAR(10)
	
	IF(DAY(@TuNgay) = 1 AND MONTH(@TuNgay) = 1 AND DAY(@DenNgay) = 31 AND MONTH(@DenNgay) = 3)
	BEGIN SET @V_QUY = 'Quý: 1' END 
	ELSE IF(DAY(@TuNgay) = 1 AND MONTH(@TuNgay) = 4 AND DAY(@DenNgay) = 30 AND MONTH(@DenNgay) = 6)
	BEGIN SET @V_QUY = 'Quý: 2' END 
	ELSE IF(DAY(@TuNgay) = 1 AND MONTH(@TuNgay) = 7 AND DAY(@DenNgay) = 30 AND MONTH(@DenNgay) = 9)
	BEGIN SET @V_QUY = 'Quý: 3' END 
	ELSE IF(DAY(@TuNgay) = 1 AND MONTH(@TuNgay) = 10 AND DAY(@DenNgay) = 31 AND MONTH(@DenNgay) = 12)
	BEGIN SET @V_QUY = 'Quý: 4' END 
	ELSE 
	BEGIN SET @V_QUY = '' END 


	SELECT TD.MaCoSo, TD.TenCoSo, @V_QUY Quy, @TuNgay TuNgay, @DenNgay DenNgay,
		   TS.TenTaiSan, TS.DonViTinh, 
		   ISNULL(TD.TonDau,0) TonDau,
		   ISNULL(GT.SLTang,0) SLTang,
		   ISNULL(GG.SLGiam,0) SLGiam,
		   ISNULL(TD.TonDau,0) + ISNULL(GT.SLTang,0) - ISNULL(GG.SLGiam,0) TonCuoi,
		   ISNULL(SUM(NG.GiaTri),0) * ISNULL(TD.TonDau,0) GiaTriTonDau,
		   ISNULL(SUM(NG.GiaTri),0) * ISNULL(GT.SLTang,0) GiaTriGhiTang,
		   ISNULL(SUM(NG.GiaTri),0) * ISNULL(GG.SLGiam,0) GiaTriGhiGiam,
		   ISNULL(SUM(NG.GiaTri),0) * (ISNULL(TD.TonDau,0) + ISNULL(GT.SLTang,0) - ISNULL(GG.SLGiam,0)) GiaTriTonCuoi
	FROM
    (
		SELECT	CS.MaCoSo, CS.TenCoSo,
				TD.TaiSanId, SUM(TD.SLTon) TonDau
		FROM dbo.TheoDoi TD
		JOIN dbo.TaiSan TS ON TS.TaiSanId = TD.TaiSanId
		JOIN dbo.CoSo CS ON CS.CoSoId = TS.CoSoId
		WHERE TD.Nam = YEAR(@TuNgay) AND TS.CoSoId = @CoSoId
		GROUP BY TD.TaiSanId, CS.MaCoSo, CS.TenCoSo
	) AS TD
	LEFT JOIN
	(
		SELECT L.TaiSanId, SUM(L.SoLuong) SLTang
		FROM dbo.GhiTang H
		JOIN dbo.GhiTangChiTiet L ON L.GhiTangId = H.GhiTangId
		WHERE CAST(H.NgayGhiTang AS DATE) BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE)
		AND H.CoSoId = @CoSoId
		GROUP BY L.TaiSanId
	) AS GT ON GT.TaiSanId = TD.TaiSanId
	LEFT JOIN
	(
		SELECT L.TaiSanId, SUM(L.SoLuong) SLGiam
		FROM dbo.GhiGiam H
		JOIN dbo.GhiGiamChiTiet L ON l.GhiGiamId = H.GhiGiamId
		WHERE CAST(H.NgayGhiGiam AS DATE) BETWEEN CAST(@TuNgay AS DATE) AND CAST(@DenNgay AS DATE)
		AND H.CoSoId = @CoSoId
		GROUP BY L.TaiSanId
	) AS GG ON GG.TaiSanId = TD.TaiSanId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = TD.TaiSanId
	LEFT JOIN dbo.NguyenGia NG ON NG.TaiSanId = TS.TaiSanId
	GROUP BY TS.TenTaiSan, TS.DonViTinh,
			 TD.TonDau,
			 GT.SLTang,
			 GG.SLGiam,
			 TD.MaCoSo,
			 TD.TenCoSo

	
-----------------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BaoDuong_DeleteBaoDuongById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_BaoDuong_DeleteBaoDuongById]
	@BaoDuongId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	BEGIN TRAN
		
		BEGIN TRY
			
			DELETE dbo.SuaChua WHERE BaoDuongId = @BaoDuongId
			DELETE dbo.BaoDuong WHERE BaoDuongId = @BaoDuongId			
			
			SELECT @@ROWCOUNT

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BaoDuong_GetListBaoDuongByBaoDuongId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_BaoDuong_GetListBaoDuongByBaoDuongId]
( 
	@BaoDuongId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	
	SELECT	BaoDuongId,
			CAST(H.TaiSanId AS VARCHAR)TaiSanId,
			ts.TenTaiSan,
			CAST(H.PhongBanId AS VARCHAR)PhongBanId,
			pb.TenPhongBan,
			CAST(h.NhanVienId AS VARCHAR)NhanVienId,
			nv.TenNhanVien,
			CONVERT(VARCHAR, H.NgayBaoDuong,103)NgayBaoDuong,
			CONVERT(VARCHAR, H.NgayDuKien,103)NgayDuKien,
			H.DuToan,
			 CAST(H.LoaiBaoDuongId AS VARCHAR)LoaiBaoDuongId,
			H.MoTa
	FROM dbo.BaoDuong H
	LEFT JOIN dbo.TaiSan ts ON ts.TaiSanId = H.TaiSanId
	LEFT JOIN dbo.PhongBan pb ON pb.PhongBanId= h.PhongBanId
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = H.NhanVienId
	WHERE H.BaoDuongId = @BaoDuongId

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoDuong_GetListBaoDuongByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_BaoDuong_GetListBaoDuongByCriteria]
( 
	  @CoSoId	        NVARCHAR(10)		
	, @Search			nvarchar(500)   = null	
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null		
	, @LoginId			NVARCHAR(10)
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) ,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@LoginId,@NAM=@Nam OUTPUT;
	SET @Search = ISNULL(@Search, '')
	----------

	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @LoginId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0028',
		@QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria

	SET @V_SQL = N'
		SELECT COUNT(*) OVER () AS MAXCNT, H.BaoDuongId, H.NgayBaoDuong, H.NgayDuKien, H.DuToan, H.LoaiBaoDuongId, H.MoTa,
			H.TaiSanId, ts.MaTaiSan, ts.TenTaiSan, h.DuyetId, H.NguoiDuyet,ndd.TenNhanVien TenNguoiDuyet, H.CoSoId, H.NguoiTao, nd.TenNhanVien TenNguoiTao, H.NgayTao,
			H.PhongBanId, pb.TenPhongBan, H.NhanVienId, nv.TenNhanVien
	FROM dbo.BaoDuong H
	LEFT JOIN dbo.TaiSan ts ON ts.TaiSanId = H.TaiSanId
	LEFT JOIN NhanVien nd ON nd.NhanVienId = h.NguoiTao
	LEFT JOIN NhanVien ndd ON ndd.NhanVienId = h.NguoiDuyet
	LEFT JOIN dbo.PhongBan pb ON pb.PhongBanId = h.PhongBanId
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = h.NhanVienId
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=h.NguoiTao
	WHERE CAST(H.NgayBaoDuong AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) and YEAR(H.NgayBaoDuong)='''+@Nam+'''' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.MoTa LIKE N''%' +@Search+ '%'')';
	END

	
	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and H.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @LoginId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nd.NhanVienId =''' + @LoginId + '''';   
	END

	--SET @V_SQL = @V_SQL + ' GROUP BY H.GhiTangId, H.SoChungTu, H.NgayChungTu, H.NgayGhiTang, H.NoiDung,
	--						h.DuyetId, H.NguoiDuyet, H.CoSoId, H.NguoiTao, H.NgayTao,ndd.HoTen,nd.HoTen ';

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BaoDuong_InsertBaoDuong]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_BaoDuong_InsertBaoDuong]
	@TaiSanId INT,
	@PhongBanId INT,
	@CanBoId INT,
	@NgayBaoDuong DATETIME,
	@NgayDuKien DATETIME,
	@DuToan NUMERIC(18,4),
	@LoaiBaoDuongId INT,
	@MoTa NVARCHAR(MAX),
	@CoSoId INT,
	@NhanVienId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.BaoDuong
			        ( TaiSanId ,		NgayBaoDuong ,			NgayDuKien ,
			          DuToan ,			LoaiBaoDuongId ,		MoTa ,
			          DuyetId ,			NguoiDuyet ,			CoSoId ,
			          NguoiTao ,		NgayTao ,				CtrVersion,
					  PhongBanId,		NhanVienId
			        )
			SELECT	@TaiSanId			,@NgayBaoDuong			,@NgayDuKien
					,@DuToan			,@LoaiBaoDuongId		,@MoTa
					,0					,0						,@CoSoId
					,@NhanVienId		,GETDATE()				,1
					,@PhongBanId		,@CanBoId

			SELECT SCOPE_IDENTITY() AS BaoDuongIdI

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BaoDuong_UpdateBaoDuong]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_BaoDuong_UpdateBaoDuong]
	@BaoDuongId INT,
	@TaiSanId INT,
	@PhongBanId INT,
	@CanBoId INT,
	@NgayBaoDuong DATETIME,
	@NgayDuKien DATETIME,
	@DuToan NUMERIC(18,4),
	@LoaiBaoDuongId INT,
	@MoTa NVARCHAR(500),
	@CoSoId INT,
	@NhanVienId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	
	

	BEGIN TRAN
		
		BEGIN TRY
			UPDATE dbo.BaoDuong
			SET TaiSanId = @TaiSanId,
				PhongBanId = @PhongBanId,
				NhanVienId= @CanBoId,
				NgayBaoDuong = @NgayBaoDuong,
				NgayDuKien = @NgayDuKien,
				DuToan = @DuToan,
				LoaiBaoDuongId = @LoaiBaoDuongId,
				MoTa = @MoTa
			WHERE BaoDuongId = @BaoDuongId

			DELETE dbo.SuaChua WHERE BaoDuongId = @BaoDuongId

			SELECT @@ROWCOUNT AS ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BienBanKiemKe_DeleteBienBanKiemKeById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_BienBanKiemKe_DeleteBienBanKiemKeById]
	@BienBanKiemKeId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	BEGIN TRAN
		
		BEGIN TRY
			
			DELETE dbo.BanKiemKe WHERE BienBanKiemKeId = @BienBanKiemKeId
			DELETE dbo.BienBanKiemKeChiTiet WHERE BienBanKiemKeId = @BienBanKiemKeId
			DELETE dbo.BienBanKiemKe WHERE BienBanKiemKeId = @BienBanKiemKeId			
			
			SELECT @@ROWCOUNT

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BienBanKiemKe_GetListBienBanKiemKeByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_BienBanKiemKe_GetListBienBanKiemKeByCriteria]
( 
	  @CoSoId	        NVARCHAR(10)		
	, @Search			nvarchar(500)   = null	
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null		
	, @SoChungTu		NVARCHAR(50)	= null		
	, @PhongBanId		NVARCHAR(max)
	, @LoginId			NVARCHAR(10)
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 

	SET @Search = ISNULL(@Search, '')
	----------

	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @LoginId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0031',
		@QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria

	

	SET @V_SQL = N'
		SELECT COUNT(*) OVER () AS MAXCNT, H.BienBanKiemKeId, H.SoChungTu, H.NgayChungTu, H.NgayKiemKe, H.PhongBanId, PB.TenPhongBan, H.GhiChu, H.NguoiTao, nv.TenNhanVien TenNguoiTao,
			H.NgayTao
	FROM dbo.BienBanKiemKe H
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = H.PhongBanId
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = h.NguoiTao
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=h.NguoiTao
	WHERE CAST(H.NgayChungTu AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.GhiChu LIKE N''%' +@Search+ '%'')';
	END

	IF (@SoChungTu > '')
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.SoChungTu LIKE N''%' +@SoChungTu+ '%'') ';
	END

	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and H.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @LoginId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @LoginId + '''';   
	END
		

	--SET @V_SQL = @V_SQL + ' GROUP BY H.GhiTangId, H.SoChungTu, H.NgayChungTu, H.NgayGhiTang, H.NoiDung,
	--						h.DuyetId, H.NguoiDuyet, H.CoSoId, H.NguoiTao, H.NgayTao,ndd.HoTen,nd.HoTen ';

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BienBanKiemKe_GetListBienBanKiemKeById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_BienBanKiemKe_GetListBienBanKiemKeById]
( 
	@BienBanKiemKeId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT	H.BienBanKiemKeId,
			H.SoChungTu, 
			CONVERT(VARCHAR, H.NgayChungTu, 103)NgayChungTu,
			CONVERT(VARCHAR, H.NgayKiemKe, 103)NgayKiemKe,
			H.PhongBanId, 
			PB.TenPhongBan, 
			H.GhiChu, 
			H.NguoiTao, 
			nd.HoTen TenNguoiTao,
			H.NgayTao
	FROM dbo.BienBanKiemKe H
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = H.PhongBanId
	LEFT JOIN QLTS_MAIN.dbo.NguoiDung nd ON nd.NhanVienId = h.NguoiTao
	WHERE H.BienBanKiemKeId = @BienBanKiemKeId

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_BienBanKiemKe_GetListReportBienBanKiemKeById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_BienBanKiemKe_GetListReportBienBanKiemKeById]
( 
	@BienBanKiemKeId INT
)
AS  
BEGIN
------------------------------------------------  
	-- giatriconlai = nguyengia - (hao mòn nam * so nam sd)
	
	SELECT NguoiKiemKe,ChucVu, DaiDien, VaiTro  FROM dbo.BanKiemKe WHERE BienBanKiemKeId = @BienBanKiemKeId

	SELECT	H.NgayKiemKe,
			H.NgayChungTu,
			H.SoChungTu,
			TS.MaTaiSan,
			ts.TenTaiSan,
			PB.TenPhongBan,
			L.SoLuong,
			L.SoLuongKiemKe,
			(L.SoLuongKiemKe - L.SoLuong) SoLuongChenhLech,
			SUM(ISNULL(NG.GiaTri,0)) NguyenGia,
			SUM(ISNULL(NG.GiaTri,0)) - (
								DATEDIFF(YEAR, TS.NgayBDHaoMon, H.NgayKiemKe) * (SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeHaoMon / 100)
								) GiaTriConLai,
			(L.SoLuong						* SUM(ISNULL(NG.GiaTri,0))) NguyenGiaKT,
			(L.SoLuongKiemKe				* SUM(ISNULL(NG.GiaTri,0))) NguyenGiaKK,
			((L.SoLuongKiemKe - L.SoLuong)	* SUM(ISNULL(NG.GiaTri,0))) NguyenGiaCL,
			(L.SoLuong						* (SUM(ISNULL(NG.GiaTri,0)) - (DATEDIFF(YEAR, TS.NgayBDHaoMon, H.NgayKiemKe) * (SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeHaoMon / 100)))) GiaTriKT,
			(L.SoLuongKiemKe				* (SUM(ISNULL(NG.GiaTri,0)) - (DATEDIFF(YEAR, TS.NgayBDHaoMon, H.NgayKiemKe) * (SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeHaoMon / 100)))) GiaTriKK,
			((L.SoLuongKiemKe - L.SoLuong)	* (SUM(ISNULL(NG.GiaTri,0)) - (DATEDIFF(YEAR, TS.NgayBDHaoMon, H.NgayKiemKe) * (SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeHaoMon / 100)))) GiaTriCL
			,H.GhiChu

	FROM dbo.BienBanKiemKe H
	JOIN dbo.BienBanKiemKeChiTiet L ON L.BienBanKiemKeId= h.BienBanKiemKeId
	LEFT JOIN dbo.PhongBan PB ON pb.PhongBanId = H.PhongBanId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = l.TaiSanId
	LEFT JOIN dbo.NguyenGia NG ON NG.TaiSanId = ts.TaiSanId
	WHERE H.BienBanKiemKeId = @BienBanKiemKeId
	GROUP BY H.BienBanKiemKeId,
			ts.TaiSanId,
			TS.MaTaiSan,
			ts.TenTaiSan,
			H.PhongBanId,
			PB.TenPhongBan,
			L.SoLuong,
			L.SoLuongKiemKe,
			TS.NgayBDHaoMon,
			H.NgayKiemKe,
			H.NgayChungTu,
			TS.TyLeHaoMon,
			H.GhiChu,
			H.SoChungTu
	

-----------------------------------------------------
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BienBanKiemKe_InsertBienBanKiemKe]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_BienBanKiemKe_InsertBienBanKiemKe]
	@SoChungTu NVARCHAR(20),
	@NgayChungTu DATETIME,
	@NgayKiemKe DATETIME,
	@PhongBanId INT,
	@GhiChu NVARCHAR(500),
	@CoSoId INT,
	@NhanVienId INT,
	@MyTable_BanKiemKe MyTableType_BanKiemKe READONLY,
    @MyTable_BienBanKiemKeChiTiet MyTableType_BienBanKiemKeChiTiet READONLY
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	DECLARE @BienBanKiemkeId INT
	SET @BienBanKiemkeId = 0

	BEGIN TRAN
		
		BEGIN TRY

			-- insert header
			INSERT dbo.BienBanKiemKe
			        ( SoChungTu ,			NgayChungTu ,			NgayKiemKe ,
			          PhongBanId ,			GhiChu ,				CoSoId ,
			          NguoiTao ,			NgayTao ,				CtrVersion
			        )
			SELECT	@SoChungTu				,@NgayChungTu			,@NgayKiemKe
					,@PhongBanId			,@GhiChu				,@CoSoId
					,@NhanVienId			,GETDATE()				,1
			
			SELECT @BienBanKiemkeId = SCOPE_IDENTITY()
			SELECT @BienBanKiemkeId AS BienBanKiemKeIdI

			--- insert line

			INSERT dbo.BienBanKiemKeChiTiet
			SELECT @BienBanKiemKeId, TaiSanId, SoLuong, SoLuongKiemKe
			FROM @MyTable_BienBanKiemKeChiTiet


			-- insert ban kiểm kê
			INSERT dbo.BanKiemKe
			SELECT  @BienBanKiemKeId, NguoiKiemKe, ChucVu, DaiDien, VaiTro 
			FROM @MyTable_BanKiemKe


		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BienBanKiemKe_UpdateBienBanKiemKe]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_BienBanKiemKe_UpdateBienBanKiemKe]
	@BienBanKiemKeId INT,
	@SoChungTu NVARCHAR(20),
	@NgayChungTu DATETIME,
	@NgayKiemKe DATETIME,
	@PhongBanId INT,
	@GhiChu NVARCHAR(500),
	@CoSoId INT,
	@NhanVienId INT,
	@MyTable_BanKiemKe MyTableType_BanKiemKe READONLY,
    @MyTable_BienBanKiemKeChiTiet MyTableType_BienBanKiemKeChiTiet READONLY
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	
	BEGIN TRAN
		
		BEGIN TRY


			UPDATE dbo.BienBanKiemKe
			SET NgayChungTu = @NgayChungTu,
				NgayKiemKe = @NgayKiemKe,
				PhongBanId = @PhongBanId,
				GhiChu = @GhiChu
			WHERE BienBanKiemKeId = @BienBanKiemKeId
			

			DELETE dbo.BanKiemKe WHERE BienBanKiemKeId = @BienBanKiemKeId
			DELETE dbo.BienBanKiemKeChiTiet WHERE BienBanKiemKeId = @BienBanKiemKeId


			INSERT dbo.BienBanKiemKeChiTiet
			SELECT @BienBanKiemKeId, TaiSanId, SoLuong, SoLuongKiemKe
			FROM @MyTable_BienBanKiemKeChiTiet


			INSERT dbo.BanKiemKe
			SELECT  @BienBanKiemKeId, NguoiKiemKe, ChucVu, DaiDien, VaiTro 
			FROM @MyTable_BanKiemKe

			SELECT @@ROWCOUNT AS ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_BienBanKiemKeChiTiet_GetListBienBanKiemKeChiTietByKiemKeId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_BienBanKiemKeChiTiet_GetListBienBanKiemKeChiTietByKiemKeId]
( 
	@BienBanKiemKeId INT,
	@PhongBanId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	-- giatriconlai = nguyengia - (hao mòn nam * so nam sd)
	DECLARE @V_NgayKiemKe DATETIME
	if @BienBanKiemKeId = 0 
	set @V_NgayKiemKe = GETDATE();
	else
	SELECT @V_NgayKiemKe = NgayKiemKe FROM dbo.BienBanKiemKe WHERE BienBanKiemKeId = @BienBanKiemKeId

	IF EXISTS(SELECT 1 FROM dbo.BienBanKiemKe H JOIN dbo.BienBanKiemKeChiTiet L ON L.BienBanKiemKeId = H.BienBanKiemKeId WHERE H.BienBanKiemKeId = @BienBanKiemKeId)
	BEGIN
		SELECT H.BienBanKiemKeId,
				CAST(ts.TaiSanId AS VARCHAR) TaiSanId,
				TS.MaTaiSan,
				ts.TenTaiSan,
				CAST(H.PhongBanId AS VARCHAR) PhongBanId,
				PB.TenPhongBan,
				L.SoLuong,
				L.SoLuongKiemKe,
				SUM(ISNULL(NG.GiaTri,0)) NguyenGia,
				SUM(ISNULL(NG.GiaTri,0)) - (
									DATEDIFF(YEAR, TS.NgayBDHaoMon, H.NgayKiemKe) * (SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeHaoMon / 100)
								 ) GiaTriConLai

		FROM dbo.BienBanKiemKe H
		JOIN dbo.BienBanKiemKeChiTiet L ON L.BienBanKiemKeId= h.BienBanKiemKeId
		LEFT JOIN dbo.PhongBan PB ON pb.PhongBanId = H.PhongBanId
		LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = l.TaiSanId
		LEFT JOIN dbo.NguyenGia NG ON NG.TaiSanId = ts.TaiSanId
		WHERE H.BienBanKiemKeId = @BienBanKiemKeId
		GROUP BY H.BienBanKiemKeId,
				ts.TaiSanId,
				TS.MaTaiSan,
				ts.TenTaiSan,
				H.PhongBanId,
				PB.TenPhongBan,
				L.SoLuong,
				L.SoLuongKiemKe,
				TS.NgayBDHaoMon,
				H.NgayKiemKe,
				TS.TyLeHaoMon
	END
	ELSE
	BEGIN
		SELECT  0 BienBanKiemKeId,
				CAST(ts.TaiSanId AS VARCHAR) TaiSanId,
				TS.MaTaiSan,
				ts.TenTaiSan,
				CAST(H.PhongBanId AS VARCHAR) PhongBanId,
				PB.TenPhongBan,
				SUM(H.SLTon + H.SLTang - H.SLGiam) SoLuong,
				SUM(H.SLTon + H.SLTang - H.SLGiam) SoLuongKiemKe,
				TS.NguyenGia,
				TS.NguyenGia - (
									DATEDIFF(YEAR, TS.NgayBDHaoMon, GETDATE()) * (TS.NguyenGia * TS.TyLeHaoMon / 100)
								) GiaTriConLai

		FROM dbo.TheoDoi H
		LEFT JOIN dbo.PhongBan PB ON pb.PhongBanId = H.PhongBanId
		LEFT JOIN 
		(
			SELECT TS.TaiSanId, TS.MaTaiSan, TS.TenTaiSan, SUM(ISNULL(NG.GiaTri,0)) NguyenGia, TS.NgayBDHaoMon, TS.TyLeHaoMon
			FROM dbo.TaiSan TS LEFT JOIN dbo.NguyenGia NG ON NG.TaiSanId = ts.TaiSanId
			GROUP BY TS.TaiSanId, TS.MaTaiSan, TS.TenTaiSan, TS.NgayBDHaoMon, TS.TyLeHaoMon
		) AS TS ON TS.TaiSanId = H.TaiSanId 
		WHERE PB.PhongBanId = @PhongBanId  AND h.Nam = YEAR(@V_NgayKiemKe)
		GROUP BY 
				ts.TaiSanId,
				TS.MaTaiSan,
				ts.TenTaiSan,
				H.PhongBanId,
				PB.TenPhongBan,
				TS.NgayBDHaoMon,
				TS.TyLeHaoMon,
				TS.NguyenGia
		HAVING  SUM(H.SLTon + H.SLTang - H.SLGiam) >0
	END

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CongKhai_report_KhacBieu04]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.11.03
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: báo cáo công khai phương tiện đi lại và tài sản khác
				  biểu 04 Thông tư số 89/2010/TT/BTC
				  ngày 16/6/2010 của Bộ Tài chính
4. Function		: 
5. Example		: 
					EXEC [sp_CongKhai_report_KhacBieu04]
						 @Year				=	'2017'
						,@LoaiKeKhai		=	'3|4'
						,@COSO_ID			=	1
						,@NHANVIEN_ID		=	6
6. Precaution	:
7. History		:
				  2017.11.03 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_CongKhai_report_KhacBieu04]
	 @Year			NVARCHAR(MAX)	=	NULL
	,@LoaiKeKhai	NVARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
AS
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE
	 @col			varchar(max)	=	''
	,@V_DELIMITER	VARCHAR(1)		=	'|'
	,@V_SQL			nvarchar(max)	=	''


SET @LoaiKeKhai = '3|4'

IF OBJECT_ID('tempdb..#NguonNganSach') IS NOT NULL
	DROP TABLE #NguonNganSach

select *
	,(case when TenNguonNganSach like N'nguồn ngân sách' then 'NguonNganSach'
		when TenNguonNganSach like N'Nguồn bảo hiểm' then 'BaoHiem'
		when TenNguonNganSach like N'Nguồn chi không thường xuyên' then 'ChiKhongThuongXuyen'
		when TenNguonNganSach like N'Nguồn ngân sách viện trợ, tài trợ' then 'TaiTro'
		when TenNguonNganSach like N'nguồn khác' then 'NguonKhac'
		else MaNguonNganSach
	end) MaNguon
into #NguonNganSach
from NguonNganSach

-- lấy danh chuỗi sách cột nguồn nhân sách
select @col = coalesce(@col + ',','') + MaNguon
from #NguonNganSach
if @col <> ''
	set @col = substring(@col,2,len(@col))

print ('@col=' + @col)

set @V_SQL = N'
	select ts.TaiSanId
			,ts.TenTaiSan
			,ts.LoaiKeKhai
			,pv.Nam
			,cs.TenCoSo
			,cstt.TenCoSo DonViChuQuan

			,ttkk_oto.NhanHieu
			,ttkk_oto.BienKiemSoat
			,ttkk_oto.TrongTai
			,ttkk_oto.CongSuatXe

			,ttkk_500.KyHieu

			,(case 
				when htsd.NoiDung like N''Phục vụ chức danh có tiêu chuẩn''  then ''PhucVuChucDanh''
				when htsd.NoiDung like N''Phục vụ công tác chung''  then ''PhucVuChung''
				when htsd.NoiDung like N''Phục vụ HĐ đặc thù''  then ''PhucVuHoatDong''
				when htsd.NoiDung like N''Sử dụng khác''  then ''SuDungKhac''
				else ''''
			end) MaHienTrangSuDung
			,isnull(pv.NguonNganSach,0)/1000 NguonNganSach
			,isnull((pv.NguyenGia - pv.NguonNganSach),0)/1000 NguonKhac
	from (
		select td.*
			,nns.MaNguon
			,isnull(ng.GiaTri,0) GiaTri
		from (
			select _ts.TaiSanId,_td.Nam
				,sum(SLTon + SLTang - SLGiam) SoLuong
				,sum(_ng.GiaTri) NguyenGia
			from TheoDoi _td
				left join TaiSan _ts on _td.TaiSanId = _ts.TaiSanId
				left join NguyenGia _ng on _td.TaiSanId = _ng.TaiSanId
			where
				Nam = @Year
				and charindex(@V_DELIMITER + cast(_ts.LoaiKeKhai as varchar(10)) + @V_DELIMITER,@V_DELIMITER + @LoaiKeKhai + @V_DELIMITER) > 0
				and _ts.CoSoId = @COSO_ID
			group by _ts.TaiSanId,_td.Nam
			having sum(SLTon + SLTang - SLGiam) > 0
		) td
		right join #NguonNganSach nns on nns.NguonNganSachId = nns.NguonNganSachId
		left join NguyenGia ng on nns.NguonNganSachId = ng.NguonNganSachId and ng.TaiSanId = td.TaiSanId
	) rs
	pivot(
		sum(GiaTri)
		for MaNguon in (BaoHiem,NguonNganSach,ChiKhongThuongXuyen,TaiTro,NguonKhac)
	) pv
	left join TaiSan ts on pv.TaiSanId = ts.TaiSanId
	left join CoSo cs on ts.CoSoId = cs.CoSoId
	left join CoSo cstt on cs.TrucThuoc = cstt.CoSoId
	left join ThongTinKeKhai_Oto ttkk_oto on ts.TaiSanId = ttkk_oto.TaiSanId
	left join ThongTinKeKhai_Tren500 ttkk_500 on ts.TaiSanId = ttkk_500.TaiSanId
	left join HienTrangSuDung htsd on ttkk_oto.HienTrangSuDung = htsd.HienTrangSuDungId or ttkk_500.HienTrangSuDung = htsd.HienTrangSuDungId
'
print @v_sql

EXECUTE sp_executesql @V_SQL,N'
	 @Year			varchar(4)		=	null
	,@LoaiKeKhai	varchar(max)	=	null
	,@COSO_ID		int				=	null
	,@V_DELIMITER	VARCHAR(10)		=	null
	'
	,@Year			=	@Year
	,@LoaiKeKhai	=	@LoaiKeKhai
	,@COSO_ID		=	@COSO_ID
	,@V_DELIMITER	=	@V_DELIMITER
--------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CongKhai_report_NhaDatBieu03]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.11.03
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: báo cáo công khai tài sản nhà đất
				  biểu 03 Thông tư số 89/2010/TT/BTC
				  ngày 16/6/2010 của Bộ Tài chính
4. Function		: 
5. Example		: 
					EXEC [sp_CongKhai_report_NhaDatBieu03]
						 @Year				=	'2017'
						,@LoaiKeKhai		=	'1|2'
						,@COSO_ID			=	1
						,@NHANVIEN_ID		=	6
6. Precaution	:
7. History		:
				  2017.11.03 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_CongKhai_report_NhaDatBieu03]
	 @Year			NVARCHAR(MAX)	=	NULL
	,@LoaiKeKhai	NVARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
AS
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE
	 @col			varchar(max)	=	''
	,@V_DELIMITER	VARCHAR(1)		=	'|'
	,@V_SQL			nvarchar(max)	=	''


SET @LoaiKeKhai = '1|2'

IF OBJECT_ID('tempdb..#NguonNganSach') IS NOT NULL
	DROP TABLE #NguonNganSach

select *
	,(case when TenNguonNganSach like N'nguồn ngân sách' then 'NguonNganSach'
		when TenNguonNganSach like N'Nguồn bảo hiểm' then 'BaoHiem'
		when TenNguonNganSach like N'Nguồn chi không thường xuyên' then 'ChiKhongThuongXuyen'
		when TenNguonNganSach like N'Nguồn ngân sách viện trợ, tài trợ' then 'TaiTro'
		when TenNguonNganSach like N'nguồn khác' then 'NguonKhac'
		else MaNguonNganSach
	end) MaNguon
into #NguonNganSach
from NguonNganSach

-- lấy danh chuỗi sách cột nguồn nhân sách
select @col = coalesce(@col + ',','') + MaNguon
from #NguonNganSach
if @col <> ''
	set @col = substring(@col,2,len(@col))

print ('@col=' + @col)

set @V_SQL = N'
	select ts.TaiSanId
			,ts.TenTaiSan
			,ts.LoaiKeKhai
			,pv.Nam
			,cs.TenCoSo
			,cstt.TenCoSo DonViChuQuan
			
			,ttkk_dat.DienTich

			,ttkk_nha.TongDienTichSan

			,isnull(pv.NguonNganSach,0)/1000 NguonNganSach
			,isnull((pv.NguyenGia - pv.NguonNganSach),0)/1000 NguonKhac
	from (
		select td.*
			,nns.MaNguon
			,isnull(ng.GiaTri,0) GiaTri
		from (
			select _ts.TaiSanId,_td.Nam
				,sum(SLTon + SLTang - SLGiam) SoLuong
				,sum(_ng.GiaTri) NguyenGia
			from TheoDoi _td
				left join TaiSan _ts on _td.TaiSanId = _ts.TaiSanId
				left join NguyenGia _ng on _td.TaiSanId = _ng.TaiSanId
			where
				Nam = @Year
				and charindex(@V_DELIMITER + cast(_ts.LoaiKeKhai as varchar(10)) + @V_DELIMITER,@V_DELIMITER + @LoaiKeKhai + @V_DELIMITER) > 0
				and _ts.CoSoId = @COSO_ID
			group by _ts.TaiSanId,_td.Nam
			having sum(SLTon + SLTang - SLGiam) > 0
		) td
		right join #NguonNganSach nns on nns.NguonNganSachId = nns.NguonNganSachId
		left join NguyenGia ng on nns.NguonNganSachId = ng.NguonNganSachId and ng.TaiSanId = td.TaiSanId
	) rs
	pivot(
		sum(GiaTri)
		for MaNguon in ('+@col+')
	) pv
	left join TaiSan ts on pv.TaiSanId = ts.TaiSanId
	left join CoSo cs on ts.CoSoId = cs.CoSoId
	left join CoSo cstt on cs.TrucThuoc = cstt.CoSoId
	left join ThongTinKeKhai_Dat ttkk_dat on pv.TaiSanId = ttkk_dat.TaiSanId
	left join ThongTinKeKhai_Nha ttkk_nha on pv.TaiSanId = ttkk_nha.TaiSanId
'

EXECUTE sp_executesql @V_SQL,N'
	 @Year			varchar(4)		=	null
	,@LoaiKeKhai	varchar(max)	=	null
	,@COSO_ID		int				=	null
	,@V_DELIMITER	VARCHAR(10)		=	null
	'
	,@Year			=	@Year
	,@LoaiKeKhai	=	@LoaiKeKhai
	,@COSO_ID		=	@COSO_ID
	,@V_DELIMITER	=	@V_DELIMITER
--------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CoSo_cbxCoSoByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_CoSo_cbxCoSoByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.CoSoId,a.MaCoSo,a.TenCoSo
	FROM CoSo a LEFT JOIN NhanVien b on a.NguoiTao=b.NhanVienId 
	

	

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_CoSo_cbxGetListCoSoByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					EXEC [sp_CoSo_cbxGetListCoSoByCriteria]
						 @COSOIDS			=	''
						,@MACOSO			=	NULL
						,@SEARCH			=	NULL
						,@COSO_ID			=	16
						,@NHANVIEN_ID		=	10
6. Precaution	:
7. History		:
				  2017.09.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_CoSo_cbxGetListCoSoByCriteria]
	 @COSOIDS			VARCHAR(MAX)	=	NULL
	,@MACOSO			VARCHAR(MAX)	=	NULL
	,@SEARCH			NVARCHAR(MAX)	=	NULL
	,@COSO_ID			INT				=	NULL
	,@NHANVIEN_ID		INT				=	NULL
AS  
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_DELIMITER	VARCHAR(10)		=	'|'
		,@V_ISVIEW		VARCHAR(MAX)	=	'VB'
		,@V_VAITROID	INT				=	NULL

SET @COSO_ID = ISNULL(@COSO_ID, 0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID, 0)

SET @COSOIDS = ISNULL(@COSOIDS, '')
SET @MACOSO = ISNULL(@MACOSO, '')
SET @SEARCH = ISNULL(@SEARCH, '')

SELECT TOP 1 @V_VAITROID = VaiTroId FROM QLTS_MAIN.DBO.NguoiDung WHERE NhanVienId = @NHANVIEN_ID
SET @V_VAITROID = ISNULL(@V_VAITROID, 0)
PRINT CONCAT('@V_VAITROID=',@V_VAITROID)

SELECT		TOP 10 *
FROM		COSO CS
WHERE		( -- PHÂN QUYỀN VIEW
				@V_VAITROID = 1
				OR	@V_ISVIEW IN ('VA')
				OR (@V_ISVIEW IN ('VB','VR') AND CS.CoSoId = @COSO_ID)
				OR (@V_ISVIEW IN ('VE') AND CS.NguoiTao = @NHANVIEN_ID AND CS.CoSoId = @COSO_ID)
			)
			AND (@COSOIDS = '' OR CHARINDEX(@V_DELIMITER+CAST(CS.CoSoId AS VARCHAR(10))+@V_DELIMITER,@V_DELIMITER+@COSOIDS+@V_DELIMITER) > 0)
			AND (@MACOSO = '' OR CS.MaCoSo = @MACOSO)
			AND (
				@SEARCH = '' OR CS.MaCoSo LIKE '%' + @SEARCH + '%'
				OR @SEARCH = '' OR CS.TenCoSo LIKE '%' + @SEARCH + '%'
				OR @SEARCH = '' OR CS.DiaChi LIKE '%' + @SEARCH + '%'
				OR @SEARCH = '' OR CS.DienThoai LIKE '%' + @SEARCH + '%'
			)
--------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_CoSo_GetCoSoById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_CoSo_GetCoSoById]
( 
	  @CoSoId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.CoSoId,a.MaCoSo,a.TenCoSo,CONVERT(varchar, a.LoaiCoSoId) as LoaiCoSoId,a.TrucThuoc,b.MaCoSo as MaTrucThuoc,b.TenCoSo as TenTrucThuoc,a.DienThoai,a.DiaChi,a.GhiChu,a.CtrVersion
	FROM CoSo a left join CoSo b on a.TrucThuoc=b.CoSoId where a.CoSoId = @CoSoId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_CoSo_GetListCoSoByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_CoSo_GetListCoSoByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------

DECLARE @IS_VIEW varchar(10) = '0'
   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
  @NHAN_VIEN_ID = @NhanVienId,
  @CO_SO_ID = @CoSoId,
  @CHUC_NANG = 'CN0015',
  @QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.CoSoId,a.MaCoSo,a.TenCoSo,a.DienThoai,a.DiaChi,a.GhiChu,nv.TenNhanVien,a.NgayTao
	FROM CoSo a LEFT JOIN NhanVien nv on a.NguoiTao=nv.NhanVienId where 1=1 ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (MaCoSo LIKE N''%' +@Search+ '%'' OR TenCoSo LIKE  N''%' +@Search+ '%'')';


		   IF @IS_VIEW = 'VB' 
		 BEGIN    
		   SET @V_SQL = @V_SQL + ' and (a.CoSoId =''' + @CoSoId + ''' or  a.TrucThuoc =''' + @CoSoId + ''')';   
		 END
		  IF @IS_VIEW = 'VE' or @IS_VIEW = 'VR'
		 BEGIN
		   SET @V_SQL = @V_SQL + 'and a.CoSoId =''' + @CoSoId + '''';
		 END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_CoSo_GetListCoSoTrucThuocById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.12
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE  @MESSAGE		NVARCHAR(MAX)
							,@COSOID_OUT	NVARCHAR(MAX)

					EXEC [sp_CoSo_GetListCoSoTrucThuocById]
						 @COSOID		=	16
						,@COSOID_OUT	=	@COSOID_OUT	OUTPUT

					SELECT	@COSOID_OUT COSOID
6. Precaution	:
7. History		:
				  2017.10.12 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
( 
	 @COSOID		NVARCHAR(MAX)	=	NULL
	,@COSOID_OUT	NVARCHAR(MAX)		OUTPUT
)
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------
	DECLARE @COSO TABLE (MAXCNT INT,CoSoId INT,TenCoSo NVARCHAR(MAX),TrucThuoc INT,COSOIDS VARCHAR(MAX))
	SET @COSOID = ISNULL(@COSOID,0)
	SET @COSOID_OUT = @COSOID

	WHILE 1 = 1
	BEGIN
		INSERT INTO @COSO (MAXCNT,CoSoId,TenCoSo,TrucThuoc,COSOIDS)
		select COUNT(CoSoId) OVER () AS MAXCNT,CoSoId,TenCoSo,TrucThuoc,@COSOID_OUT COSOIDS
		from ( 		SELECT		*
					FROM		CoSo
					where		charindex(','+cast(CoSoId as varchar(10))+',',','+@COSOID_OUT+',') > 0
		union		select		*
					from		CoSo
					where		charindex(','+cast(TrucThuoc as varchar(10))+',',','+@COSOID_OUT+',') > 0
					) Menu

		SET @COSOID_OUT = NULL
		SELECT @COSOID_OUT = COALESCE(@COSOID_OUT + ',', '') + cast(CoSoId as varchar(10))
		FROM @COSO

		IF @COSOID_OUT = cast(@COSOID as varchar(10)) OR @COSOID_OUT = (SELECT TOP 1 COSOIDS FROM @COSO)
		BEGIN
			BREAK
		END
		DELETE FROM @COSO
	END

	SET @COSOID_OUT = NULL
	SELECT @COSOID_OUT = COALESCE(@COSOID_OUT + ',', '') + cast(CoSoId as varchar(10))
	FROM @COSO
--------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DanhGia_DeleteDanhGia]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.25
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_DanhGia_DeleteDanhGia]
					 @DanhGiaId				=	84

					,@COSO_ID				=	1
					,@NHANVIEN_ID			=	7
					,@MESSAGE				=	@MESSAGE	OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.25 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
/*
DROP TYPE NguyenGiaType
CREATE TYPE NguyenGiaType AS TABLE
( 
	TaiSanId			INT,
	NguonNganSachId		INT,
	GiaTri				numeric(18, 4)
)
*/
CREATE PROCEDURE [dbo].[sp_DanhGia_DeleteDanhGia]
	 @DanhGiaId				INT				=	NULL

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ
	DECLARE  @V_TRANS_NAME		NVARCHAR(MAX)	=	N'DG_DELETE'
			,@TaiSanId			INT				=	NULL

	-- INPUT DEFAULT
	SET @DanhGiaId		=	ISNULL(@DanhGiaId, 0)
	SET @COSO_ID		=	ISNULL(@COSO_ID, 0)
	SET @NHANVIEN_ID	=	ISNULL(@NHANVIEN_ID, 0)
	SET @MESSAGE		=	ISNULL(@MESSAGE, '')

BEGIN TRY

BEGIN TRANSACTION @V_TRANS_NAME

	IF @DanhGiaId = 0
	BEGIN
		SET @MESSAGE	=	N'DanhGiaId|1|Không tìm thấy thông tin đánh giá';
		THROW 51000, @MESSAGE, 1;
	END

	SELECT @TaiSanId = TaiSanId FROM DanhGia WHERE DanhGiaId = @DanhGiaId

	-- UPDATE TÀI SẢN
	UPDATE	TS
	SET		 TS.HaoMonLuyKe		=	ISNULL(DG.HaoMonLuyKeCu,TS.HaoMonLuyKe)
			,TS.SoNamSuDung		=	ISNULL(DG.SoNamSuDungCu,TS.SoNamSuDung)
			,TS.TyLeHaoMon		=	ISNULL(DG.TyLeHaoMonCu,TS.TyLeHaoMon)
	FROM	TaiSan TS
			LEFT JOIN DanhGia DG ON TS.TaiSanId = DG.TaiSanId AND DG.DanhGiaId = @DanhGiaId
	WHERE	DG.DanhGiaId = @DanhGiaId

	-- UPDATE NGUYÊN GIÁ
	SELECT		TS.TaiSanId,ISNULL(DG_NG.NguonNganSachId,NG.NguonNganSachId) NguonNganSachId,ISNULL(DG_NG.GiaTriCu,NG.GiaTri) GiaTriCu,ng.GiaTri
				,CASE WHEN DG_NG.NguonNganSachId IS NULL THEN 1 ELSE 0 END isCreate
	INTO		#DANHGIA_NGUYENGIA
	FROM		(	SELECT	DanhGia_NguyenGia.GiaTriCu,DanhGia_NguyenGia.NguonNganSachId,DanhGia.TaiSanId
					FROM	DanhGia_NguyenGia
							LEFT JOIN DanhGia ON DanhGia_NguyenGia.DanhGiaId = DanhGia.DanhGiaId
					WHERE	DanhGia_NguyenGia.DanhGiaId = @DanhGiaId ) DG_NG
				FULL JOIN (	SELECT * 
							FROM NguyenGia 
							WHERE TaiSanId = @TaiSanId ) NG ON DG_NG.NguonNganSachId = NG.NguonNganSachId
				LEFT JOIN TaiSan TS ON DG_NG.TaiSanId = TS.TaiSanId OR NG.TaiSanId = TS.TaiSanId
	WHERE TS.TaiSanId = @TaiSanId
	
	DELETE NguyenGia WHERE TaiSanId = @TaiSanId

	INSERT INTO NguyenGia (	TaiSanId	,NguonNganSachId		,GiaTri		)
	SELECT					@TaiSanId	,NG.NguonNganSachId		,NG.GiaTriCu
	FROM		#DANHGIA_NGUYENGIA NG
	WHERE		NG.isCreate = 0

	-- DELTE ĐÁNH GIÁ
	DELETE DanhGia_NguyenGia WHERE DanhGiaId = @DanhGiaId
	DELETE DanhGia WHERE DanhGiaId = @DanhGiaId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	IF OBJECT_ID('tempdb..#DANHGIA_NGUYENGIA') IS NOT NULL
		DROP TABLE #DANHGIA_NGUYENGIA

	SELECT * FROM DanhGia WHERE DanhGiaId = @DanhGiaId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DanhGia_GetListDanhGiaByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.20
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_DanhGia_GetListDanhGiaByCriteria]
						 @search			=	NULL
						,@DanhGiaIds		=	N'75'
						,@TaiSanIds			=	NULL
						,@PhongBanIds		=	NULL
						,@NhanVienIds		=	NULL
	
						,@Field				=	N''
						,@skip				=	N''
						,@take				=	NULL
						,@OrderClause		=	NULL
				
						,@COSO_ID			=	1
						,@NHANVIEN_ID		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.20 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_DanhGia_GetListDanhGiaByCriteria]
	 @search			NVARCHAR(MAX)	=	NULL
	,@DanhGiaIds		NVARCHAR(MAX)	=	NULL
	,@TaiSanIds			NVARCHAR(MAX)	=	NULL
	,@PhongBanIds		NVARCHAR(MAX)	=	NULL
	,@NhanVienIds		NVARCHAR(MAX)	=	NULL
	
	,@Field				NVARCHAR(MAX)	=	NULL
	,@skip				INT				=	NULL
	,@take				INT				=	NULL
	,@OrderClause		NVARCHAR(MAX)	=	NULL
				
	,@COSO_ID			NVARCHAR(MAX)				=	NULL
	,@NHANVIEN_ID		NVARCHAR(MAX)				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--------------------------------------------------
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE  @V_SQL				NVARCHAR(MAX) 
			,@_COSO_IDS			VARCHAR(MAX)	=	NULL
			,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@NHANVIEN_ID,@NAM=@Nam OUTPUT;
	-- SET DEFAULT

	SET @search = ISNULL(@search, '')
	SET @DanhGiaIds = ISNULL(@DanhGiaIds, '')
	SET @TaiSanIds = ISNULL(@TaiSanIds, '')
	SET @PhongBanIds = ISNULL(@PhongBanIds, '')
	SET @NhanVienIds = ISNULL(@NhanVienIds, '')

	SET @Field = ISNULL(@Field, '')
	IF (@Field = '')
		SET @Field = ' DG.* ';

	SET @skip = ISNULL(@skip, 0)
	SET @take = ISNULL(@take, 0)

	SET @OrderClause = ISNULL(@OrderClause,'')
	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';

	SET @COSO_ID = ISNULL(@COSO_ID, 0)
	SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID, 0)
	SET @MESSAGE = ISNULL(@MESSAGE, '')

	--EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	--   @COSOID=@COSO_ID
	--  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	--SET @_COSO_IDS = REPLACE(@_COSO_IDS,',','|')
	--PRINT concat('@_COSO_IDS=',@_COSO_IDS)

	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NHANVIEN_ID,
		@CO_SO_ID = @COSO_ID,
		@CHUC_NANG = 'CN0033',
		@QUYEN=@IS_VIEW OUTPUT
----------
	SET @V_SQL = N'
		SELECT		COUNT(DG.DanhGiaId) OVER () AS MAXCNT,DG.DanhGiaId ID
					,' + @Field + ' 
					,TS.TenTaiSan,TS.LoaiKeKhai,PB.TenPhongBan,NV.TenNhanVien
					,NV_NT.TenNhanVien TenNguoiTao,DG_NG.NguyenGiaCu
		FROM		DanhGia DG
					LEFT JOIN (
						select		DanhGiaId, SUM(GiaTriCu) NguyenGiaCu
						from		DanhGia_NguyenGia
						GROUP BY	DanhGiaId
					) DG_NG ON DG.DanhGiaId = DG_NG.DanhGiaId
					LEFT JOIN TaiSan TS ON DG.TaiSanId = TS.TaiSanId
					LEFT JOIN PhongBan PB ON DG.PhongBanId = PB.PhongBanId
					LEFT JOIN NhanVien NV ON DG.NhanVienId = NV.NhanVienId
					LEFT JOIN CoSo CS ON DG.CoSoId = CS.CoSoId
					LEFT JOIN NhanVien NV_NT ON DG.NguoiTao = NV_NT.NhanVienId
					LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=DG.NguoiTao
		WHERE YEAR(DG.NgayDanhGia)='''+@Nam+'''	'

	IF @search <> ''
	BEGIN
		SET @V_SQL = @V_SQL + N' AND (DG.SoChungTu LIKE N''%' +@search+ '%'' OR DG.NoiDung LIKE  N''%' +@search+ '%'' ';
		SET @V_SQL = @V_SQL + N' OR TS.MaTaiSan LIKE N''%' +@search+ '%'' OR TS.TenTaiSan LIKE  N''%' +@search+ '%'' ';
		SET @V_SQL = @V_SQL + N' OR PB.MaPhongBan LIKE N''%' +@search+ '%'' OR PB.TenPhongBan LIKE  N''%' +@search+ '%'' ';
		SET @V_SQL = @V_SQL + N' OR NV.MaNhanVien LIKE N''%' +@search+ '%'' OR NV.TenNhanVien LIKE  N''%' +@search+ '%'' ';
		SET @V_SQL = @V_SQL + N' OR CS.MaCoSo LIKE N''%' +@search+ '%'' OR CS.TenCoSo LIKE  N''%' +@search+ '%'') ';
	END
	------------
	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and DG.CoSoId =''' + @COSO_ID + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @NHANVIEN_ID+ '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and NV_NT.NhanVienId =''' + @NHANVIEN_ID + '''';   
	END
	----------
	IF @DanhGiaIds <> ''
		SET @V_SQL = @V_SQL + N' AND CHARINDEX(''|'' + CAST(DG.DanhGiaId AS VARCHAR(20)) + ''|'', ''|'' + @DanhGiaIds + ''|'') > 0 ';

	IF @TaiSanIds <> ''
		SET @V_SQL = @V_SQL + N' AND CHARINDEX(''|'' + CAST(DG.TaiSanId AS VARCHAR(20)) + ''|'', ''|'' + @TaiSanIds + ''|'') > 0 ';

	IF @PhongBanIds <> ''
		SET @V_SQL = @V_SQL + N' AND CHARINDEX(''|'' + CAST(DG.PhongBanId AS VARCHAR(20)) + ''|'', ''|'' + @PhongBanIds + ''|'') > 0 ';

	IF @NhanVienIds <> ''
		SET @V_SQL = @V_SQL + N' AND CHARINDEX(''|'' + CAST(DG.NhanVienId AS VARCHAR(20)) + ''|'', ''|'' + @NhanVienIds + ''|'') > 0 ';

	IF @OrderClause <> ''
		SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	IF @OrderClause <> '' AND @take <> 0
		SET @V_SQL = @V_SQL + ' OFFSET ' + CAST(@skip AS nvarchar(20)) + ' ROWS FETCH NEXT ' + CAST(@take AS nvarchar(20)) + ' ROWS ONLY '
		
	print @V_SQL
	exec sp_executesql @V_SQL,N'
		 @search			NVARCHAR(MAX)	=	NULL
		,@DanhGiaIds		NVARCHAR(MAX)	=	NULL
		,@TaiSanIds			NVARCHAR(MAX)	=	NULL
		,@PhongBanIds		NVARCHAR(MAX)	=	NULL
		,@NhanVienIds		NVARCHAR(MAX)	=	NULL
	
		,@COSO_ID			INT				=	NULL
		,@NHANVIEN_ID		INT				=	NULL
		'
		,@search			=	@search
		,@DanhGiaIds		=	@DanhGiaIds
		,@TaiSanIds			=	@TaiSanIds
		,@PhongBanIds		=	@PhongBanIds
		,@NhanVienIds		=	@NhanVienIds
				
		,@COSO_ID			=	@COSO_ID
		,@NHANVIEN_ID		=	@NHANVIEN_ID
--------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DanhGia_GetListNguyenGiaByDanhGia]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.20
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_DanhGia_GetListNguyenGiaByDanhGia]
							 @TaiSanId			=	1065
							,@DanhGiaId			=	NULL
	
							,@COSO_ID			=	1
							,@NHANVIEN_ID		=	7
							,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.20 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_DanhGia_GetListNguyenGiaByDanhGia]
	 @TaiSanId			INT				=	NULL
	,@DanhGiaId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@PhongBanId		INT				=	NULL
	
	,@COSO_ID			INT				=	NULL
	,@NHANVIEN_ID		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON
--------------------------------------------------
SELECT		TS.TaiSanId,TS.TenTaiSan,ISNULL(DG_NG.NguonNganSachId,NG.NguonNganSachId) NguonNganSachId,ISNULL(DG_NG.GiaTriCu,NG.GiaTri) GiaTriCu,NG.GiaTri
			,CASE WHEN DG_NG.NguonNganSachId IS NULL THEN 1 ELSE 0 END isCreate
FROM		(	SELECT	DanhGia_NguyenGia.GiaTriCu,DanhGia_NguyenGia.NguonNganSachId,DanhGia.TaiSanId
				FROM	DanhGia_NguyenGia
						LEFT JOIN DanhGia ON DanhGia_NguyenGia.DanhGiaId = DanhGia.DanhGiaId
				WHERE	DanhGia_NguyenGia.DanhGiaId = @DanhGiaId ) DG_NG
			FULL JOIN (	SELECT * 
						FROM NguyenGia 
						WHERE TaiSanId = @TaiSanId ) NG ON DG_NG.NguonNganSachId = NG.NguonNganSachId
			LEFT JOIN TaiSan TS ON DG_NG.TaiSanId = TS.TaiSanId OR NG.TaiSanId = TS.TaiSanId
WHERE TS.TaiSanId = @TaiSanId
--------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DanhGia_InsertDanhGia]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.20
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @NguyenGiaList dbo.NguyenGiaType
					INSERT INTO @NguyenGiaList VALUES(0,1,9000000)
					INSERT INTO @NguyenGiaList VALUES(0,2,5000000)
					INSERT INTO @NguyenGiaList VALUES(0,3,2000000)

					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_DanhGia_InsertDanhGia]
				---- THÔNG TIN ĐÁNH GIÁ
					 @DanhGiaId				=	NULL
					,@SoChungTu				=	N'CT0001'
					,@NgayChungTu			=	'2017-09-20'
					,@NgayDanhGia			=	'2017-09-20'
					,@NoiDung				=	NULL
					,@TaiSanId				=	1069
					,@PhongBanId			=	7
					,@NhanVienId			=	4
					,@SLTonCu				=	1
					,@SoNamSuDungCu			=	5
					,@TyLeHaoMonCu			=	20
					,@HaoMonLuyKeCu			=	0
					,@NguoiTao				=	7
					,@NgayTao				=	'2017-09-20'

				---- THÔNG TIN TÀI SẢN MỚI
					,@SoNamSuDung			=	5
					,@TyLeHaoMon			=	20
					,@HaoMonLuyKe			=	0
					,@SLTon					=	1

					,@NguyenGiaList			=	@NguyenGiaList

					,@COSO_ID				=	1
					,@NHANVIEN_ID			=	7
					,@MESSAGE				=	@MESSAGE	OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.20 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
/*
DROP TYPE NguyenGiaType
CREATE TYPE NguyenGiaType AS TABLE
( 
	TaiSanId			INT,
	NguonNganSachId		INT,
	GiaTri				numeric(18, 4)
)
*/
CREATE PROCEDURE [dbo].[sp_DanhGia_InsertDanhGia]
---- THÔNG TIN ĐÁNH GIÁ
	 @DanhGiaId				INT				=	NULL
	,@SoChungTu				NVARCHAR(MAX)	=	NULL
	,@NgayChungTu			DATETIME		=	NULL
	,@NgayDanhGia			DATETIME		=	NULL
	,@NoiDung				NVARCHAR(MAX)	=	NULL
	,@TaiSanId				INT				=	NULL
	,@PhongBanId			INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@SLTonCu				NUMERIC(18, 4)	=	NULL
	,@SoNamSuDungCu			INT				=	NULL
	,@TyLeHaoMonCu			NUMERIC(5,2)	=	NULL
	,@HaoMonLuyKeCu			NUMERIC(18,4)	=	NULL
	,@CoSoId				INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL

---- THÔNG TIN TÀI SẢN MỚI
    ,@SoNamSuDung			INT				=	NULL
    ,@TyLeHaoMon			NUMERIC(5,2)	=	NULL
    ,@HaoMonLuyKe			NUMERIC(18,4)	=	NULL
    ,@SLTon					NUMERIC(18,4)	=	NULL

	,@NguyenGiaList		NguyenGiaType			READONLY

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ
	DECLARE  @V_TRANS_NAME		NVARCHAR(MAX)	=	N'DG_INSERT'
			,@V_MATAISAN		NVARCHAR(MAX)	=	''

	-- INPUT DEFAULT
	SET @COSO_ID		=	ISNULL(@COSO_ID, 0)
	SET @NHANVIEN_ID	=	ISNULL(@NHANVIEN_ID, 0)
	SET @MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@PhongBanId		=	ISNULL(@PhongBanId, 0)
	SET	@NguoiTao		=	ISNULL(@NguoiTao, @NHANVIEN_ID)
	SET	@NgayTao		=	ISNULL(@NgayTao, GETDATE())

BEGIN TRY

BEGIN TRANSACTION @V_TRANS_NAME

	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE	=	N'TaiSanId|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END
	IF @NhanVienId = 0
	BEGIN
		SET @MESSAGE	=	N'NhanVienId|1|Không tìm thấy thông tin nhân viên';
		THROW 51000, @MESSAGE, 1;
	END
	IF @PhongBanId = 0
	BEGIN
		SET @MESSAGE	=	N'PhongBanId|1|Không tìm thấy thông tin phòng ban';
		THROW 51000, @MESSAGE, 1;
	END

	SELECT @SLTonCu			=	ISNULL(TD.SLTon + TD.SLTang - TD.SLGiam, 0)
	FROM TheoDoi TD
	WHERE TD.NhanVienId = @NhanVienId AND TD.PhongBanId = @PhongBanId AND TD.TaiSanId = @TaiSanId

	SELECT	@SoNamSuDungCu = SoNamSuDung
			,@TyLeHaoMonCu = TyLeHaoMon
			,@HaoMonLuyKeCu = HaoMonLuyKe
	FROM	TaiSan
	WHERE	TaiSanId = @TaiSanId

		-- SET THÔNG TIN BỊ THAY ĐỔI
	IF @SLTonCu				= @SLTon				SET @SLTonCu			= NULL
	IF @SoNamSuDungCu		= @SoNamSuDung			SET @SoNamSuDungCu		= NULL
	IF @TyLeHaoMonCu		= @TyLeHaoMon			SET @TyLeHaoMonCu		= NULL
	IF @HaoMonLuyKeCu		= @HaoMonLuyKeCu		SET @HaoMonLuyKeCu		= NULL

	-- INSERT ĐÁNH GIÁ
	INSERT INTO DanhGia	(	SoChungTu	,NgayChungTu	,NgayDanhGia	,NoiDung	,TaiSanId	,PhongBanId		,NhanVienId		,HaoMonLuyKeCu	,SoNamSuDungCu	,TyLeHaoMonCu	,SLTonCu	,CoSoId		,NguoiTao	,NgayTao	)
	VALUES				(	@SoChungTu	,@NgayChungTu	,@NgayDanhGia	,@NoiDung	,@TaiSanId	,@PhongBanId	,@NhanVienId	,@HaoMonLuyKeCu	,@SoNamSuDungCu	,@TyLeHaoMonCu	,@SLTonCu	,@COSO_ID	,@NguoiTao	,@NgayTao	)

	SET @DanhGiaId	=	@@IDENTITY

	-- INSERT ĐÁNH GIÁ NGUYÊN GIÁ TỪ BẢNG NGUYÊN GIÁ
	INSERT INTO DanhGia_NguyenGia	(	DanhGiaId	,NguonNganSachId		,GiaTriCu					)
	SELECT								@DanhGiaId	,NG_NEW.NguonNganSachId	,NG_OLD.GiaTri
	FROM		NguyenGia NG_OLD
				LEFT JOIN @NguyenGiaList NG_NEW ON NG_OLD.TaiSanId = @TaiSanId and NG_NEW.NguonNganSachId = NG_OLD.NguonNganSachId
	WHERE		NG_NEW.GiaTri <> NG_OLD.GiaTri

	INSERT INTO DanhGia_NguyenGia	(	DanhGiaId	,NguonNganSachId		,GiaTriCu					)
	SELECT								@DanhGiaId	,NG_NEW.NguonNganSachId	,NULL
	FROM		NguyenGia NG_OLD
				LEFT JOIN @NguyenGiaList NG_NEW ON NG_OLD.TaiSanId = @TaiSanId and NG_NEW.NguonNganSachId = NG_OLD.NguonNganSachId
	WHERE		NG_NEW.GiaTri = NG_OLD.GiaTri

	-- UPDATE THÔNG TIN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		 SoNamSuDung	=	@SoNamSuDung
			,TyLeHaoMon		=	@TyLeHaoMon
			,HaoMonLuyKe	=	@HaoMonLuyKe
	WHERE	TaiSanId = @TaiSanId

	-- UPDATE NGUYÊN GIÁ MỚI
	 DELETE NguyenGia WHERE TaiSanId = @TaiSanId

	INSERT INTO NguyenGia (	TaiSanId	,NguonNganSachId	,GiaTri )
	SELECT					@TaiSanId	,NguonNganSachId	,GiaTri
	FROM @NguyenGiaList

	
	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM DanhGia WHERE DanhGiaId = @DanhGiaId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DanhGia_report_DanhGiaTaiSanById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.29
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_DanhGia_report_DanhGiaTaiSanById]
						 @DanhGiaId			=	79
6. Precaution	:
7. History		:
				  2017.09.29 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_DanhGia_report_DanhGiaTaiSanById]
	 @DanhGiaId		INT			=	NULL
AS  
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_NGUYENGIA DECIMAL(18,4) = NULL
		,@V_NGUYENGIACU DECIMAL(18,4) = NULL
		,@V_TAISANID INT = NULL

SET @DanhGiaId = ISNULL(@DanhGiaId,0)

SELECT @V_TAISANID = TaiSanId FROM DanhGia WHERE DanhGiaId = @DanhGiaId

SELECT		TS.TaiSanId,TS.TenTaiSan,ISNULL(DG_NG.NguonNganSachId,NG.NguonNganSachId) NguonNganSachId,ISNULL(DG_NG.GiaTriCu,NG.GiaTri) GiaTriCu,NG.GiaTri
			,CASE WHEN DG_NG.NguonNganSachId IS NULL THEN 1 ELSE 0 END isCreate
INTO		#DANHGIA_NGUYENGIA
FROM		(	SELECT	DanhGia_NguyenGia.GiaTriCu,DanhGia_NguyenGia.NguonNganSachId,DanhGia.TaiSanId
				FROM	DanhGia_NguyenGia
						LEFT JOIN DanhGia ON DanhGia_NguyenGia.DanhGiaId = DanhGia.DanhGiaId
				WHERE	DanhGia_NguyenGia.DanhGiaId = @DanhGiaId ) DG_NG
			FULL JOIN (	SELECT * 
						FROM NguyenGia 
						WHERE TaiSanId = @V_TAISANID ) NG ON DG_NG.NguonNganSachId = NG.NguonNganSachId
			LEFT JOIN TaiSan TS ON DG_NG.TaiSanId = TS.TaiSanId OR NG.TaiSanId = TS.TaiSanId
WHERE TS.TaiSanId = @V_TAISANID

SELECT @V_NGUYENGIACU = SUM(GiaTriCu) FROM #DANHGIA_NGUYENGIA WHERE TaiSanId = @V_TAISANID AND isCreate = 0
SELECT @V_NGUYENGIA = SUM(GiaTri) FROM #DANHGIA_NGUYENGIA WHERE TaiSanId = @V_TAISANID

PRINT CONCAT('@V_NGUYENGIA',@V_NGUYENGIA)
PRINT CONCAT('@V_NGUYENGIACU',@V_NGUYENGIACU)
SELECT		-- THÔNG TIN CHUNG
			 TS.TenTaiSan,TS.LoaiKeKhai,CS.TenCoSo TenDonVi,CS_QL.TenCoSo TenDonViChuQuan
			,DG.NgayDanhGia
			--,@V_NGUYENGIA NguyenGia,@V_NGUYENGIACU NguyenGiaCu
			,CASE WHEN @V_NGUYENGIACU IS NOT NULL THEN @V_NGUYENGIA ELSE @V_NGUYENGIACU END NguyenGia
			,ISNULL(@V_NGUYENGIACU,@V_NGUYENGIA) NguyenGiaCu
			--,TS.SoNamSuDung,DG.SoNamSuDungCu
			,CASE WHEN DG.SoNamSuDungCu IS NOT NULL THEN TS.SoNamSuDung ELSE DG.SoNamSuDungCu END SoNamSuDung
			,ISNULL(DG.SoNamSuDungCu,TS.SoNamSuDung) SoNamSuDungCu

			-- THÔNG TIN NHÀ
			,TTKK_NHA.DiaChi			TTKK_NHA_DiaChi
			,TTKK_NHA.DienTich			TTKK_NHA_DienTich
			,TTKK_NHA.TongDienTichSan	TTKK_NHA_TongDienTichSan
			,TTKK_NHA.BoTrong			TTKK_NHA_BoTrong
			,TTKK_NHA.ChoThue			TTKK_NHA_ChoThue
			,TTKK_NHA.CoSoHDSuNghiep	TTKK_NHA_CoSoHDSuNghiep
			,TTKK_NHA.LamTruSo			TTKK_NHA_LamTruSo
			,TTKK_NHA.NhaO				TTKK_NHA_NhaO
			-- THÔNG TIN ĐẤT
			,TTKK_DAT.DiaChi			TTKK_DAT_DiaChi
			,TTKK_DAT.DienTich			TTKK_DAT_DienTich
			,TTKK_DAT.LamTruSo			TTKK_DAT_LamTruSo
			,TTKK_DAT.CoSoHDSuNghiep	TTKK_DAT_CoSoHDSuNghiep
			,TTKK_DAT.NhaO				TTKK_DAT_NhaO
			,TTKK_DAT.ChoThue			TTKK_DAT_ChoThue
			,TTKK_DAT.BoTrong			TTKK_DAT_BoTrong
			-- THÔNG TIN OTO
			,TTKK_OTO.BienKiemSoat		TTKK_OTO_BienKiemSoat
			,TTKK_OTO.LoaiXe			TTKK_OTO_LoaiXe
			,TTKK_OTO.TrongTai			TTKK_OTO_TrongTai
FROM		DanhGia DG
			LEFT JOIN CoSo CS ON DG.CoSoId = CS.CoSoId
			LEFT JOIN CoSo CS_QL ON CS.TrucThuoc = CS_QL.CoSoId
			LEFT JOIN TaiSan TS ON DG.TaiSanId = TS.TaiSanId
			LEFT JOIN ThongTinKeKhai_Dat TTKK_DAT ON TS.TaiSanId = TTKK_DAT.TaiSanId
			LEFT JOIN ThongTinKeKhai_Nha TTKK_NHA ON TS.TaiSanId = TTKK_NHA.TaiSanId
			LEFT JOIN ThongTinKeKhai_Oto TTKK_OTO ON TS.TaiSanId = TTKK_OTO.TaiSanId
			LEFT JOIN ThongTinKeKhai_Tren500 TTKK_500 ON TS.TaiSanId = TTKK_500.TaiSanId
WHERE		DG.DanhGiaId = @DanhGiaId

IF OBJECT_ID('tempdb..#DANHGIA_NGUYENGIA') IS NOT NULL
	DROP TABLE #DANHGIA_NGUYENGIA

--------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DanhGia_UpdateDanhGia]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.25
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @NguyenGiaList dbo.NguyenGiaType
					INSERT INTO @NguyenGiaList VALUES(0,1,9000000)
					INSERT INTO @NguyenGiaList VALUES(0,2,5000000)
					INSERT INTO @NguyenGiaList VALUES(0,3,2000000)

					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_DanhGia_UpdateDanhGia]
				---- THÔNG TIN ĐÁNH GIÁ
					 @DanhGiaId				=	NULL
					,@SoChungTu				=	N'CT0001'
					,@NgayChungTu			=	'2017-09-20'
					,@NgayDanhGia			=	'2017-09-20'
					,@NoiDung				=	NULL
					,@TaiSanId				=	1069
					,@PhongBanId			=	7
					,@NhanVienId			=	4
					,@SLTonCu				=	1
					,@SoNamSuDungCu			=	5
					,@TyLeHaoMonCu			=	20
					,@HaoMonLuyKeCu			=	0
					,@NguoiTao				=	7
					,@NgayTao				=	'2017-09-20'

				---- THÔNG TIN TÀI SẢN MỚI
					,@SoNamSuDung			=	5
					,@TyLeHaoMon			=	20
					,@HaoMonLuyKe			=	0
					,@SLTon					=	1

					,@NguyenGiaList			=	@NguyenGiaList

					,@COSO_ID				=	1
					,@NHANVIEN_ID			=	7
					,@MESSAGE				=	@MESSAGE	OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.25 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
/*
DROP TYPE NguyenGiaType
CREATE TYPE NguyenGiaType AS TABLE
( 
	TaiSanId			INT,
	NguonNganSachId		INT,
	GiaTri				numeric(18, 4)
)
*/
CREATE PROCEDURE [dbo].[sp_DanhGia_UpdateDanhGia]
---- THÔNG TIN ĐÁNH GIÁ
	 @DanhGiaId				INT				=	NULL
	,@SoChungTu				NVARCHAR(MAX)	=	NULL
	,@NgayChungTu			DATETIME		=	NULL
	,@NgayDanhGia			DATETIME		=	NULL
	,@NoiDung				NVARCHAR(MAX)	=	NULL
	,@TaiSanId				INT				=	NULL
	,@PhongBanId			INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@SLTonCu				NUMERIC(18, 4)	=	NULL
	,@SoNamSuDungCu			INT				=	NULL
	,@TyLeHaoMonCu			NUMERIC(5,2)	=	NULL
	,@HaoMonLuyKeCu			NUMERIC(18,4)	=	NULL
	,@CoSoId				INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL

---- THÔNG TIN TÀI SẢN MỚI
    ,@SoNamSuDung			INT				=	NULL
    ,@TyLeHaoMon			NUMERIC(5,2)	=	NULL
    ,@HaoMonLuyKe			NUMERIC(18,4)	=	NULL
    ,@SLTon					NUMERIC(18,4)	=	NULL

	,@NguyenGiaList		NguyenGiaType			READONLY

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ
	DECLARE  @V_TRANS_NAME		NVARCHAR(MAX)	=	N'DG_UPDATE'
			,@V_MATAISAN		NVARCHAR(MAX)	=	''

	-- INPUT DEFAULT
	SET @COSO_ID		=	ISNULL(@COSO_ID, 0)
	SET @NHANVIEN_ID	=	ISNULL(@NHANVIEN_ID, 0)
	SET @MESSAGE		=	ISNULL(@MESSAGE, '')

BEGIN TRY

BEGIN TRANSACTION @V_TRANS_NAME

	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE	=	N'TaiSanId|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END
	IF @NhanVienId = 0
	BEGIN
		SET @MESSAGE	=	N'NhanVienId|1|Không tìm thấy thông tin nhân viên';
		THROW 51000, @MESSAGE, 1;
	END
	IF @PhongBanId = 0
	BEGIN
		SET @MESSAGE	=	N'PhongBanId|1|Không tìm thấy thông tin phòng ban';
		THROW 51000, @MESSAGE, 1;
	END

	-- LÂY THÔNG TIN CŨ TỪ DB
	SELECT	 @SLTonCu		= ISNULL(DG.SLTonCu, ISNULL(TD.SLTon + TD.SLTang - TD.SLGiam, 0))
			,@SoNamSuDungCu = ISNULL(DG.SoNamSuDungCu, TS.SoNamSuDung)
			,@TyLeHaoMonCu	= ISNULL(DG.TyLeHaoMonCu, TS.TyLeHaoMon)
			,@HaoMonLuyKeCu = ISNULL(DG.HaoMonLuyKeCu, TS.HaoMonLuyKe)
	FROM	DanhGia DG
			LEFT JOIN TaiSan TS ON DG.TaiSanId = TS.TaiSanId
			LEFT JOIN TheoDoi TD ON DG.NhanVienId = TD.NhanVienId AND DG.PhongBanId = TD.PhongBanId AND DG.TaiSanId = TD.TaiSanId
	WHERE	DG.DanhGiaId = @DanhGiaId

	-- SET THÔNG TIN BỊ THAY ĐỔI
	IF @SLTonCu				= @SLTon				SET @SLTonCu			= NULL
	IF @SoNamSuDungCu		= @SoNamSuDung			SET @SoNamSuDungCu		= NULL
	IF @TyLeHaoMonCu		= @TyLeHaoMon			SET @TyLeHaoMonCu		= NULL
	IF @HaoMonLuyKeCu		= @HaoMonLuyKe			SET @HaoMonLuyKeCu		= NULL

	-- INSERT ĐÁNH GIÁ
	UPDATE	DanhGia
	SET		 NoiDung		=	@NoiDung
			,SoChungTu		=	@SoChungTu
			,NgayDanhGia	=	@NgayDanhGia
			,NgayChungTu	=	@NgayChungTu
			,HaoMonLuyKeCu	=	@HaoMonLuyKeCu
			,SoNamSuDungCu	=	@SoNamSuDungCu
			,TyLeHaoMonCu	=	@TyLeHaoMonCu
			,SLTonCu		=	@SLTonCu
	WHERE	DanhGiaId = @DanhGiaId

	-- INSERT ĐÁNH GIÁ NGUYÊN GIÁ TỪ BẢNG NGUYÊN GIÁ
	SELECT		TS.TaiSanId,ISNULL(DG_NG.NguonNganSachId,NG.NguonNganSachId) NguonNganSachId,ISNULL(DG_NG.GiaTriCu,NG.GiaTri) GiaTriCu,ng.GiaTri
				,CASE WHEN DG_NG.NguonNganSachId IS NULL THEN 1 ELSE 0 END isCreate
	INTO		#DANHGIA_NGUYENGIA
	FROM		(	SELECT	DanhGia_NguyenGia.GiaTriCu,DanhGia_NguyenGia.NguonNganSachId,DanhGia.TaiSanId
					FROM	DanhGia_NguyenGia
							LEFT JOIN DanhGia ON DanhGia_NguyenGia.DanhGiaId = DanhGia.DanhGiaId
					WHERE	DanhGia_NguyenGia.DanhGiaId = @DanhGiaId ) DG_NG
				FULL JOIN (	SELECT * 
							FROM NguyenGia 
							WHERE TaiSanId = @TaiSanId ) NG ON DG_NG.NguonNganSachId = NG.NguonNganSachId
				LEFT JOIN TaiSan TS ON DG_NG.TaiSanId = TS.TaiSanId OR NG.TaiSanId = TS.TaiSanId
	WHERE TS.TaiSanId = @TaiSanId

	UPDATE	DG_NG
	SET		NguonNganSachId		=	NG.NguonNganSachId
			,GiaTriCu			=	NG.GiaTriCu
	FROM	DanhGia_NguyenGia DG_NG
			LEFT JOIN(	SELECT	_NG.GiaTriCu, _NGL.GiaTri,_NG.NguonNganSachId,_NG.isCreate
						FROM	#DANHGIA_NGUYENGIA _NG
								 JOIN @NguyenGiaList _NGL ON _NG.NguonNganSachId = _NGL.NguonNganSachId) NG ON DG_NG.NguonNganSachId = NG.NguonNganSachId
	WHERE	DG_NG.DanhGiaId = @DanhGiaId
			AND NG.isCreate = 0 
			AND ISNULL(NG.GiaTri,0) <> ISNULL(NG.GiaTriCu,0) 
			AND DG_NG.NguonNganSachId = NG.NguonNganSachId

	UPDATE	DG_NG
	SET		NguonNganSachId		=	NG.NguonNganSachId
			,GiaTriCu			=	NULL
	FROM	DanhGia_NguyenGia DG_NG
			LEFT JOIN(	SELECT	_NG.GiaTriCu, _NGL.GiaTri,_NG.NguonNganSachId,_NG.isCreate
						FROM	#DANHGIA_NGUYENGIA _NG
								 JOIN @NguyenGiaList _NGL ON _NG.NguonNganSachId = _NGL.NguonNganSachId) NG ON DG_NG.NguonNganSachId = NG.NguonNganSachId
	WHERE	DG_NG.DanhGiaId = @DanhGiaId
			AND NG.isCreate = 0 
			AND ISNULL(NG.GiaTri,0) = ISNULL(NG.GiaTriCu,0) 
			AND DG_NG.NguonNganSachId = NG.NguonNganSachId

	-- UPDATE THÔNG TIN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		 SoNamSuDung	=	@SoNamSuDung
			,TyLeHaoMon		=	@TyLeHaoMon
			,HaoMonLuyKe	=	@HaoMonLuyKe
	WHERE	TaiSanId = @TaiSanId

	-- UPDATE NGUYÊN GIÁ MỚI
	 DELETE NguyenGia WHERE TaiSanId = @TaiSanId

	INSERT INTO NguyenGia (	TaiSanId	,NguonNganSachId	,GiaTri )
	SELECT					@TaiSanId	,NguonNganSachId	,GiaTri
	FROM @NguyenGiaList

	
	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	IF OBJECT_ID('tempdb..#DANHGIA_NGUYENGIA') IS NOT NULL
		DROP TABLE #DANHGIA_NGUYENGIA

	SELECT * FROM DanhGia WHERE DanhGiaId = @DanhGiaId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeNghiTrangCap_DeleteDeNghiTrangCapById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_DeNghiTrangCap_DeleteDeNghiTrangCapById]
	@DeNghiId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	BEGIN TRAN
		
		BEGIN TRY
			
			DELETE dbo.DeNghiTrangCapChiTiet WHERE DeNghiId = @DeNghiId
			DELETE dbo.DeNghiTrangCap WHERE DeNghiId = @DeNghiId
			
			SELECT @@ROWCOUNT

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeNghiTrangCap_GetListDeNghiTrangCapByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DeNghiTrangCap_GetListDeNghiTrangCapByCriteria]
( 
	  @CoSoId	        NVARCHAR(10)	
	, @SoPhieu		    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null		
	, @PhongBanId		NVARCHAR(MAX)	
	, @LoginId			NVARCHAR(10)
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 
	,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@LoginId,@NAM=@Nam OUTPUT;


	SET @Search = ISNULL(@Search, '')
	IF @Search <> ''
	BEGIN	
		SET @Search = N'%' + @Search + '%'
		SET @Search = CAST(@Search AS VARCHAR(max))	
	END	
	----------


	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @LoginId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0019',
		@QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria

	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, H.DeNghiId, H.Ngay, H.SoPhieu, H.PhanLoaiId, PL.TenPhanLoai, H.PhongBanId,ISNULL(PB.TenPhongBan,cs.TenCoSo) as TenPhongBan, H.NoiDung, H.CoSoId,
			H.DuyetId,H.NoiDungDuyet,D.TrangThai,H.NguoiTao,H.GuiCapTren,nv.TenNhanVien TenNhanVien,H.NgayTao,H.CtrVersion
	FROM dbo.DeNghiTrangCap H 
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = H.NguoiTao 
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = h.PhongBanId
	LEFT JOIN dbo.PhanLoai PL ON PL.PhanLoaiId = h.PhanLoaiId
	LEFT JOIN dbo.Duyet D ON D.DuyetId = h.DuyetId
	LEFT JOIN dbo.CoSo cs ON cs.CoSoId = h.CoSoId
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=h.NguoiTao
	WHERE YEAR(h.ngay)='''+@Nam+''' and CAST(Ngay AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.NoiDung LIKE N''%' +@Search+ '%'')';
	END

	IF @PhongBanId > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and  h.PhongBanId in (' + @PhongBanId + ')';
	END

	
	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and  H.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @LoginId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	 
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @LoginId + '''';   
	END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY  H.Ngay desc,' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DeNghiTrangCap_GetListDeNghiTrangCapByDeNghiId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DeNghiTrangCap_GetListDeNghiTrangCapByDeNghiId]
( 
	@DeNghiId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	
	SELECT H.DeNghiId, 
			Convert(varchar,H.Ngay,103) Ngay, 
			H.SoPhieu, 
			CAST(H.PhanLoaiId AS VARCHAR) PhanLoaiId, 
			PL.TenPhanLoai, 
			CAST(H.PhongBanId AS VARCHAR) PhongBanId, 
			PB.TenPhongBan, 
			H.NoiDung,H.DuyetId,H.NoiDungDuyet,D.TrangThai
	FROM dbo.DeNghiTrangCap H 
	LEFT JOIN QLTS_MAIN.dbo.NguoiDung ON NguoiDung.NhanVienId = H.NguoiTao 
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = h.PhongBanId
	LEFT JOIN dbo.PhanLoai PL ON PL.PhanLoaiId = h.PhanLoaiId
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = h.NguoiTao
	LEFT JOIN dbo.Duyet D ON D.DuyetId = h.DuyetId
	WHERE H.DeNghiId = @DeNghiId

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeNghiTrangCap_GetListReportDeNghiTrangCapById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

EXEC [dbo].[sp_DeNghiTrangCap_GetListReportDeNghiTrangCapById] @DeNghiId = 5 -- int

*/

CREATE PROC [dbo].[sp_DeNghiTrangCap_GetListReportDeNghiTrangCapById]
( 
	@DeNghiId NVARCHAR(10)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT	CS.MaCoSo, CS.TenCoSo,
			CONVERT(varchar,H.Ngay,103) Ngay, 
			H.SoPhieu, PL.TenPhanLoai, PB.TenPhongBan, 
			H.NoiDung, H.NoiDungDuyet, D.TrangThai,
			----------------------------------------------line
			l.TenTaiSan, L.MoTa, L.NgayDeNghi, L.SoLuong, L.DonViTinh, 
			L.DuToan, L.DuToanDuocDuyet, pt.TenPhuongThuc, L.GhiChu

	FROM dbo.DeNghiTrangCap H 
	JOIN dbo.DeNghiTrangCapChiTiet L ON L.DeNghiId = H.DeNghiId
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = h.PhongBanId
	LEFT JOIN dbo.PhanLoai PL ON PL.PhanLoaiId = h.PhanLoaiId
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = h.NguoiTao
	LEFT JOIN dbo.Duyet D ON D.DuyetId = h.DuyetId
	LEFT JOIN dbo.PhuongThuc PT ON PT.PhuongThucId = L.PhuongThucId
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
	WHERE H.DeNghiId = @DeNghiId

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeNghiTrangCap_GetTongHopDeNghiTrangCapByDeNghiId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DeNghiTrangCap_GetTongHopDeNghiTrangCapByDeNghiId]
( 
	@DeNghiId varchar(max)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	declare @query varchar(max)=null;
	set @query = 'SELECT CT.DeNghiChiTietId,
			CT.DeNghiId,
			ct.LoaiId,
			LTS.TenLoai,
			CT.TenTaiSan,
			CT.MoTa,
			LTS.TenLoai,
			CT.SoLuong,
			CT.DonViTinh,
			CAST(ct.PhuongThucId AS VARCHAR)PhuongThucId,
			PT.TenPhuongThuc,
			CONVERT(VARCHAR, CT.NgayDeNghi,103) NgayDeNghi,
			CT.DuToan,
			CT.DuToanDuocDuyet,
			CT.GhiChu,ct.DuyetId
	FROM dbo.DeNghiTrangCapChiTiet CT
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = CT.LoaiId
	LEFT JOIN dbo.PhuongThuc PT ON PT.PhuongThucId = CT.PhuongThucId
	WHERE 	CONVERT(VARCHAR, CT.DeNghiId)  in ( '+@DeNghiId+')';
	execute(@query);

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeNghiTrangCap_InsertDeNghiTrangCap]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_DeNghiTrangCap_InsertDeNghiTrangCap]
	@NgayLap DATETIME
	,@SoPhieu NVARCHAR(50)
	,@PhanLoaiId INT
	,@PhongBanId INT
	,@NoiDung NVARCHAR(max)
	,@CoSoId INT
	,@NhanVienId INT
	,@GuiCapTren INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	if(@PhongBanId = 0) SET @PhongBanId = NULL
	if(@GuiCapTren = 0) SET @GuiCapTren = NULL
	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.DeNghiTrangCap
			        ( Ngay ,			SoPhieu ,			PhanLoaiId ,
			          PhongBanId ,		NoiDung ,			CoSoId ,
			          DuyetId ,			NguoiDuyet ,		NguoiTao ,
			          NgayTao ,			CtrVersion,GuiCapTren
			        )
			SELECT	 @NgayLap			,@SoPhieu			,@PhanLoaiId
					 ,@PhongBanId		,@NoiDung			,@CoSoId
					 ,0					,0					,@NhanVienId
					 ,GETDATE()			,1, @GuiCapTren

			SELECT SCOPE_IDENTITY() AS DeNghiIdI

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeNghiTrangCap_UpdateDeNghiTrangCap]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_DeNghiTrangCap_UpdateDeNghiTrangCap]
	@DeNghiId INT
	,@NgayLap DATETIME
	,@SoPhieu NVARCHAR(50)
	,@PhanLoaiId INT
	,@PhongBanId INT
	,@NoiDung NVARCHAR(max)
	,@CoSoId INT
	,@NhanVienId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	
	BEGIN TRAN
		
		BEGIN TRY
			
			UPDATE dbo.DeNghiTrangCap
			SET Ngay = @NgayLap
				,PhanLoaiId = @PhanLoaiId
				,PhongBanId = @PhongBanId
				,NoiDung = @NoiDung
			WHERE DeNghiId = @DeNghiId

			DELETE dbo.DeNghiTrangCapChiTiet WHERE DeNghiId = @DeNghiId

			SELECT @@ROWCOUNT

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeNghiTrangCapChiTiet_GetDeNghiTrangCapChiTietByDeNghiId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_DeNghiTrangCapChiTiet_GetDeNghiTrangCapChiTietByDeNghiId]
	@DeNghiId INT
AS  
BEGIN
SET NOCOUNT ON  
	
	SELECT CT.DeNghiChiTietId,
			CT.DeNghiId,
			ct.LoaiId,
			LTS.TenLoai,
			CT.TenTaiSan,
			CT.MoTa,
			LTS.TenLoai,
			CT.SoLuong,
			CT.DonViTinh,
			CAST(ct.PhuongThucId AS VARCHAR)PhuongThucId,
			PT.TenPhuongThuc,
			CONVERT(VARCHAR, CT.NgayDeNghi,103) NgayDeNghi,
			CT.DuToan,
			CT.DuToanDuocDuyet,
			CT.GhiChu,ct.DuyetId
	FROM dbo.DeNghiTrangCapChiTiet CT
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = CT.LoaiId
	LEFT JOIN dbo.PhuongThuc PT ON PT.PhuongThucId = CT.PhuongThucId
	WHERE CT.DeNghiId = @DeNghiId
	
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeNghiTrangCapChiTiet_InsertDeNghiTrangCapChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_DeNghiTrangCapChiTiet_InsertDeNghiTrangCapChiTiet]
	@DeNghiId INT
	,@TenTaiSan NVARCHAR(max)
	,@MoTa NVARCHAR(500)
	,@LoaiId INT
	,@SoLuong NUMERIC(4,0)
	,@DonViTinh NVARCHAR(50)
	,@PhuongThucId INT
	,@NgayDeNghi DATETIME
	,@DuToan NUMERIC(18,4)
	,@DuToanDuocDuyet NUMERIC(18,4)
	,@GhiChu NVARCHAR(max)
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	
	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.DeNghiTrangCapChiTiet
			        (
			          DeNghiId ,			TenTaiSan ,				MoTa ,
			          LoaiId ,				SoLuong ,				DonViTinh ,
			          PhuongThucId ,		NgayDeNghi ,			DuToan ,
			          DuToanDuocDuyet ,		GhiChu
			        )
			SELECT	@DeNghiId				,@TenTaiSan				,@MoTa
					,@LoaiId				,@SoLuong				,@DonViTinh
					,@PhuongThucId			,@NgayDeNghi			,@DuToan
					,@DuToanDuocDuyet		,@GhiChu			

			SELECT SCOPE_IDENTITY()
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DieuChuyen_DeleteDieuChuyenyId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_DieuChuyen_DeleteDieuChuyenyId]
	@DieuChuyenId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	DECLARE @V_TB_DIEUCHUYENCT TABLE
	(
		ROWID INT IDENTITY(1,1),
		TAISANID INT,
		PHONGBANSUDUNG INT,
		NHANVIENSUDUNG INT,
		PHONGBANCHUYENDEN INT,
		NHANVIENTIEPNHAN INT,
		SOLUONG NUMERIC(18,4)
	)

	DECLARE @V_ROWID INT,
			@V_TAISANID INT,
			@V_PHONGBANSUDUNG INT,
			@V_NHANVIENSUDUNG INT,
			@V_PHONGBANCHUYENDEN INT,
			@V_NHANVIENTIEPNHAN INT,
			@V_SOLUONG NUMERIC(18,4),
			@V_NGAYDIEUCHUYEN DATETIME,
			@V_DUYETID INT,
			@V_CHOTNAM INT,
			@V_COSOID INT


	SELECT @V_NGAYDIEUCHUYEN = NgayDieuChuyen, @V_DUYETID = DuyetId, @V_COSOID = CoSoId FROM dbo.DieuChuyen WHERE DieuChuyenId = @DieuChuyenId

	SELECT @V_CHOTNAM = TrangThai FROM dbo.KhoaSoLieu WHERE Nam = YEAR(@V_NGAYDIEUCHUYEN) AND CoSoId = @V_COSOID

	-- check chốt năm + duyệt
	IF (@V_DUYETID = 1 OR @V_CHOTNAM = 1)
	BEGIN
		SELECT -1 AS ID RETURN
	END

	--------------------------------------------------------------------------------------------------------------------
	BEGIN TRAN
		
		BEGIN TRY
			
			/*
				. cập nhật lại số lượng tăng, giảm bảng theo dõi
			*/

			INSERT @V_TB_DIEUCHUYENCT(TAISANID ,PHONGBANSUDUNG ,NHANVIENSUDUNG, PHONGBANCHUYENDEN ,NHANVIENTIEPNHAN ,SOLUONG)
			SELECT TaiSanId, PhongBanSuDung, NhanVienSuDung, PhongBanChuyenDen, NhanVienTiepNhan, SoLuong
			FROM dbo.DieuChuyenChiTiet WHERE DieuChuyenId = @DieuChuyenId

			WHILE EXISTS(SELECT 1 FROM @V_TB_DIEUCHUYENCT)
			BEGIN
				SELECT TOP 1 @V_ROWID = ROWID, @V_TAISANID = TAISANID, @V_PHONGBANSUDUNG = PHONGBANSUDUNG, @V_NHANVIENSUDUNG = NHANVIENSUDUNG, @V_PHONGBANCHUYENDEN = PHONGBANCHUYENDEN, @V_NHANVIENTIEPNHAN = NHANVIENTIEPNHAN, @V_SOLUONG = SOLUONG FROM @V_TB_DIEUCHUYENCT

				-- cập nhật sl phòng sử dụng
				IF EXISTS(SELECT 1 FROM dbo.TheoDoi WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENSUDUNG AND PhongBanId = @V_PHONGBANSUDUNG AND Nam = YEAR(@V_NGAYDIEUCHUYEN))
				BEGIN
					UPDATE dbo.TheoDoi SET SLGiam = SLGiam - @V_SOLUONG WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENSUDUNG AND PhongBanId = @V_PHONGBANSUDUNG AND Nam = YEAR(@V_NGAYDIEUCHUYEN)
				END

				-- cập nhật sl phòng chuyển đến
				IF EXISTS(SELECT 1 FROM dbo.TheoDoi WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENTIEPNHAN AND PhongBanId = @V_PHONGBANCHUYENDEN AND Nam = YEAR(@V_NGAYDIEUCHUYEN))
				BEGIN
					UPDATE dbo.TheoDoi SET SLTang = SLTang - @V_SOLUONG WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENTIEPNHAN AND PhongBanId = @V_PHONGBANCHUYENDEN AND Nam = YEAR(@V_NGAYDIEUCHUYEN)
				END
				

				DELETE @V_TB_DIEUCHUYENCT WHERE ROWID = @V_ROWID
				SELECT @V_ROWID = NULL,@V_TAISANID = NULL,@V_PHONGBANSUDUNG = NULL,@V_NHANVIENSUDUNG = NULL,@V_PHONGBANCHUYENDEN = NULL, @V_NHANVIENTIEPNHAN=NULL, @V_SOLUONG = NULL
			END

			DELETE dbo.DieuChuyenChiTiet WHERE DieuChuyenId = @DieuChuyenId
			DELETE dbo.DieuChuyen WHERE DieuChuyenId = @DieuChuyenId
			
			SELECT @@ROWCOUNT

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DieuChuyen_GetListDieuChuyenByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DieuChuyen_GetListDieuChuyenByCriteria]
( 
	  @CoSoId	        NVARCHAR(10)	
	, @SoChungTu	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null			
	, @LoginId			NVARCHAR(10)
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 
	,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@LoginId,@NAM=@Nam OUTPUT;


	SET @Search = ISNULL(@Search, '')
	IF @Search <> ''
	BEGIN	
		SET @Search = N'%' + @Search + '%'
		SET @Search = CAST(@Search AS VARCHAR(max))	
	END	
	----------


	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @LoginId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0025',
		@QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------
	
    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria

	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, H.DieuChuyenId, H.SoChungTu, H.NgayDieuChuyen,H.NgayChungTu, H.GhiChu, H.DuyetId,H.NguoiDuyet, nd.TenNhanVien TenNguoiDuyet,
			H.CoSoId, H.NguoiTao, nv.TenNhanVien TenNguoiTao, H.NgayTao, H.CtrVersion
	FROM dbo.DieuChuyen H
	LEFT JOIN NhanVien nv ON nv.NhanVienId = H.NguoiTao 
	LEFT JOIN NhanVien nd ON nd.NhanVienId = H.NguoiDuyet 
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=h.NguoiTao
	WHERE CAST(H.NgayDieuChuyen AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) and YEAR(H.NgayDieuChuyen)='''+@Nam+''''; 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.NoiDung LIKE N''%' +@Search+ '%'')';
	END

	

	
	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and H.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
			SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @LoginId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @LoginId + '''';   
	END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DieuChuyen_GetListDieuChuyenByDieuChuyenId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DieuChuyen_GetListDieuChuyenByDieuChuyenId]
( 
	@DieuChuyenId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT H.DieuChuyenId,
			H.SoChungTu,
			CONVERT(VARCHAR, H.NgayChungTu,103)NgayChungTu,
			CONVERT(VARCHAR, H.NgayDieuChuyen,103)NgayDieuChuyen,
			H.GhiChu
	FROM dbo.DieuChuyen H
	WHERE H.DieuChuyenId = @DieuChuyenId

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DieuChuyen_GetListReportDieuChuyenByDieuChuyenId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

EXEC dbo.sp_DieuChuyen_GetListReportDieuChuyenByDieuChuyenId @DieuChuyenId = N'6' -- nvarchar(10)

*/


CREATE PROC [dbo].[sp_DieuChuyen_GetListReportDieuChuyenByDieuChuyenId]
( 
	@DieuChuyenId NVARCHAR(10)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT	CS.MaCoSo, CS.TenCoSo,
			H.SoChungTu,
			H.NgayChungTu,
			H.NgayDieuChuyen,
			H.GhiChu,
			----------------------------------------------------line
			TS.TenTaiSan, TS.DonViTinh, PBSD.TenPhongBan PhongBanSuDung, PBCD.TenPhongBan PhongBanChuyenDen,
			NVSD.TenNhanVien NhanVienSuDung, NVTN.TenNhanVien NhanVienTiepNhan,
			L.SoLuong, L.LyDo

	FROM dbo.DieuChuyen H
	JOIN dbo.DieuChuyenChiTiet L ON L.DieuChuyenId = H.DieuChuyenId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = L.TaiSanId
	LEFT JOIN dbo.PhongBan PBSD ON PBSD.PhongBanId = L.PhongBanSuDung
	LEFT JOIN dbo.PhongBan PBCD ON PBCD.PhongBanId = L.PhongBanChuyenDen
	LEFT JOIN dbo.NhanVien NVSD ON NVSD.NhanVienId = L.NhanVienSuDung
	LEFT JOIN dbo.NhanVien NVTN ON NVTN.NhanVienId = L.NhanVienTiepNhan
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
	WHERE H.DieuChuyenId = @DieuChuyenId

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DieuChuyen_InsertDieuChuyen]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_DieuChuyen_InsertDieuChuyen]
	@SoChungTu NVARCHAR(50)
	,@NgayChungTu datetime
	,@NgayDieuChuyen datetime
	,@GhiChu NVARCHAR(max)
	,@CoSoId INT
	,@NhanVienId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max),
			@V_CHOTNAM INT

	SELECT @V_CHOTNAM = TrangThai FROM dbo.KhoaSoLieu WHERE Nam = YEAR(@NgayDieuChuyen) AND CoSoId = @CoSoId

	-- check chốt năm
	IF (@V_CHOTNAM = 1)
	BEGIN
		SELECT -1 AS DieuChuyenIdI RETURN
	END
	
	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.DieuChuyen
			        ( SoChungTu ,		NgayChungTu ,		NgayDieuChuyen ,
			          GhiChu ,			DuyetId ,			NguoiDuyet ,
			          CoSoId ,			NguoiTao ,			NgayTao ,
			          CtrVersion
			        )
			SELECT	@SoChungTu			,@NgayChungTu		,@NgayDieuChuyen
					,@GhiChu			,0					,0
					,@CoSoId			,@NhanVienId		,GETDATE()
					,1

			SELECT SCOPE_IDENTITY() AS DieuChuyenIdI

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DieuChuyen_UpdateDieuChuyen]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_DieuChuyen_UpdateDieuChuyen]
	@DieuChuyenId INT
	,@SoChungTu NVARCHAR(50)
	,@NgayChungTu datetime
	,@NgayDieuChuyen datetime
	,@GhiChu NVARCHAR(max)
	,@CoSoId INT
	,@NhanVienId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	DECLARE @V_TB_DIEUCHUYENCT TABLE
	(
		ROWID INT IDENTITY(1,1),
		TAISANID INT,
		PHONGBANSUDUNG INT,
		NHANVIENSUDUNG INT,
		PHONGBANCHUYENDEN INT,
		NHANVIENTIEPNHAN INT,
		SOLUONG NUMERIC(18,4)
	)

	DECLARE @V_ROWID INT,
			@V_TAISANID INT,
			@V_PHONGBANSUDUNG INT,
			@V_NHANVIENSUDUNG INT,
			@V_PHONGBANCHUYENDEN INT,
			@V_NHANVIENTIEPNHAN INT,
			@V_SOLUONG NUMERIC(18,4),
			@V_CHOTNAM INT,
			@V_NGAYDIEUCHUYEN_OLD DATETIME,
			@V_DUYETID INT
	
	---------------------------------------------------------------------------------------------------
	SELECT @V_NGAYDIEUCHUYEN_OLD = NgayDieuChuyen, @V_DUYETID = DuyetId FROM dbo.DieuChuyen WHERE DieuChuyenId = @DieuChuyenId
	SELECT @V_CHOTNAM = TrangThai FROM dbo.KhoaSoLieu WHERE Nam = YEAR(@V_NGAYDIEUCHUYEN_OLD) AND CoSoId = @CoSoId

	-- check chốt năm + duyệt
	IF (@V_DUYETID = 1)
	BEGIN
		SELECT -2 AS ID RETURN
	END
	IF (@V_CHOTNAM = 1)
	BEGIN
		SELECT -3 AS ID RETURN
	END

	---------------------------------------------------------------------------------------------------

	BEGIN TRAN
		
		BEGIN TRY
			
			UPDATE dbo.DieuChuyen
			SET NgayChungTu = @NgayChungTu
				,NgayDieuChuyen = @NgayDieuChuyen
				,GhiChu = @GhiChu
			WHERE DieuChuyenId = @DieuChuyenId

			/*
				. cập nhật lại số lượng tăng, giảm bảng theo dõi
			*/

			INSERT @V_TB_DIEUCHUYENCT(TAISANID ,PHONGBANSUDUNG ,NHANVIENSUDUNG, PHONGBANCHUYENDEN ,NHANVIENTIEPNHAN ,SOLUONG)
			SELECT TaiSanId, PhongBanSuDung, NhanVienSuDung, PhongBanChuyenDen, NhanVienTiepNhan, SoLuong
			FROM dbo.DieuChuyenChiTiet WHERE DieuChuyenId = @DieuChuyenId

			WHILE EXISTS(SELECT 1 FROM @V_TB_DIEUCHUYENCT)
			BEGIN
				SELECT TOP 1 @V_ROWID = ROWID, @V_TAISANID = TAISANID, @V_PHONGBANSUDUNG = PHONGBANSUDUNG, @V_NHANVIENSUDUNG = NHANVIENSUDUNG, @V_PHONGBANCHUYENDEN = PHONGBANCHUYENDEN, @V_NHANVIENTIEPNHAN = NHANVIENTIEPNHAN, @V_SOLUONG = SOLUONG FROM @V_TB_DIEUCHUYENCT

				-- cập nhật sl phòng sử dụng
				IF EXISTS(SELECT 1 FROM dbo.TheoDoi WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENSUDUNG AND PhongBanId = @V_PHONGBANSUDUNG AND Nam = YEAR(@V_NGAYDIEUCHUYEN_OLD))
				BEGIN
					UPDATE dbo.TheoDoi SET SLGiam = SLGiam - @V_SOLUONG WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENSUDUNG AND PhongBanId = @V_PHONGBANSUDUNG AND Nam = YEAR(@V_NGAYDIEUCHUYEN_OLD)
				END

				-- cập nhật sl phòng chuyển đến
				IF EXISTS(SELECT 1 FROM dbo.TheoDoi WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENTIEPNHAN AND PhongBanId = @V_PHONGBANCHUYENDEN AND Nam = YEAR(@V_NGAYDIEUCHUYEN_OLD))
				BEGIN
					UPDATE dbo.TheoDoi SET SLTang = SLTang - @V_SOLUONG WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENTIEPNHAN AND PhongBanId = @V_PHONGBANCHUYENDEN AND Nam = YEAR(@V_NGAYDIEUCHUYEN_OLD)
				END
				

				DELETE @V_TB_DIEUCHUYENCT WHERE ROWID = @V_ROWID
				SELECT @V_ROWID = NULL,@V_TAISANID = NULL,@V_PHONGBANSUDUNG = NULL,@V_NHANVIENSUDUNG = NULL,@V_PHONGBANCHUYENDEN = NULL, @V_NHANVIENTIEPNHAN=NULL, @V_SOLUONG = NULL
			END


			DELETE dbo.DieuChuyenChiTiet WHERE DieuChuyenId = @DieuChuyenId

			SELECT @@ROWCOUNT AS ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DieuChuyenChiTiet_GetDieuChuyenChiTietByDieuChuyenId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_DieuChuyenChiTiet_GetDieuChuyenChiTietByDieuChuyenId]
	@DieuChuyenId INT
AS  
BEGIN
SET NOCOUNT ON  	

	SELECT ct.DieuChuyenChiTietId,
			ct.DieuChuyenId,
			CAST(ct.TaiSanId AS VARCHAR)TaiSanId,
			ts.MaTaiSan,
			ts.TenTaiSan,
			ts.DonViTinh,
			CAST(ct.PhongBanSuDung AS VARCHAR)PhongBanSuDung,
			pbsd.TenPhongBan TenPhongBanSuDung,
			CAST(ct.NhanVienSuDung AS VARCHAR)NhanVienSuDung,
			nvsd.TenNhanVien TenNhanVienSuDung,
			CAST(ct.PhongBanChuyenDen AS VARCHAR)PhongBanChuyenDen,
			pbcd.TenPhongBan TenPhongBanChuyenDen,
			CAST(ct.NhanVienTiepNhan AS VARCHAR)NhanVienTiepNhan,
			nvtn.TenNhanVien TenNhanVienTiepNhan,
			ct.SoLuong,
			ISNULL(td.SLTon + td.SLTang - td.SLGiam,0)SoLuongTon,
			ct.LyDo
	FROM dbo.DieuChuyen dc JOIN dbo.DieuChuyenChiTiet ct ON ct.DieuChuyenId = dc.DieuChuyenId
	LEFT JOIN dbo.TaiSan ts ON ts.TaiSanId = ct.TaiSanId
	LEFT JOIN dbo.PhongBan pbsd ON pbsd.PhongBanId = ct.PhongBanSuDung
	LEFT JOIN dbo.PhongBan pbcd ON pbcd.PhongBanId = ct.PhongBanChuyenDen
	LEFT JOIN dbo.NhanVien nvsd ON nvsd.NhanVienId = ct.NhanVienSuDung
	LEFT JOIN dbo.NhanVien nvtn ON nvtn.NhanVienId = ct.NhanVienTiepNhan
	LEFT JOIN dbo.TheoDoi td ON td.TaiSanId = ts.TaiSanId AND td.PhongBanId = ct.PhongBanSuDung AND td.NhanVienId = ct.NhanVienSuDung AND td.Nam = YEAR(dc.NgayDieuChuyen)
	WHERE ct.DieuChuyenId = @DieuChuyenId


SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DieuChuyenChiTiet_InsertDieuChuyenChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_DieuChuyenChiTiet_InsertDieuChuyenChiTiet]
	@DieuChuyenId INT
	,@TaiSanId INT
	,@PhongBanSuDung INT
	,@NhanVienSuDung INT
	,@PhongBanChuyenDen INT
	,@NhanVienTiepNhan INT
	,@SoLuong NUMERIC(18,4)
	,@LyDo NVARCHAR(max)
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	DECLARE @V_NGAYDIEUCHUYEN DATETIME

	SELECT @V_NGAYDIEUCHUYEN = NgayDieuChuyen FROM dbo.DieuChuyen WHERE DieuChuyenId = @DieuChuyenId

	BEGIN TRAN
		BEGIN TRY
			
			INSERT dbo.DieuChuyenChiTiet( DieuChuyenId ,	TaiSanId ,	PhongBanSuDung ,	NhanVienSuDung,		PhongBanChuyenDen ,		NhanVienTiepNhan,	SoLuong ,	LyDo)
			SELECT						@DieuChuyenId,		@TaiSanId,	@PhongBanSuDung,	@NhanVienSuDung,	@PhongBanChuyenDen,		@NhanVienTiepNhan,	@SoLuong,	@LyDo

			/*
				.  giảm số lượng phòng sử dụng
				.  ghi tăng số lượng phòng chuyển đến
			*/

			--------- giảm phòng su dung
			IF EXISTS(SELECT 1 FROM dbo.TheoDoi WHERE TaiSanId = @TaiSanId AND NhanVienId = @NhanVienSuDung AND PhongBanId = @PhongBanSuDung AND Nam = YEAR(@V_NGAYDIEUCHUYEN))
			BEGIN
				UPDATE dbo.TheoDoi SET SLGiam = SLGiam + @SoLuong WHERE TaiSanId = @TaiSanId AND NhanVienId = @NhanVienSuDung AND PhongBanId = @PhongBanSuDung AND Nam = YEAR(@V_NGAYDIEUCHUYEN)
			END
			

			--------- tăng phòng chuyển đến
			IF EXISTS(SELECT 1 FROM dbo.TheoDoi WHERE TaiSanId = @TaiSanId AND NhanVienId = @NhanVienTiepNhan AND PhongBanId = @PhongBanChuyenDen AND Nam = YEAR(@V_NGAYDIEUCHUYEN))
			BEGIN
				UPDATE dbo.TheoDoi SET SLTang = SLTang + @SoLuong WHERE TaiSanId = @TaiSanId AND NhanVienId = @NhanVienTiepNhan AND PhongBanId = @PhongBanChuyenDen AND Nam = YEAR(@V_NGAYDIEUCHUYEN)
			END
			ELSE
			BEGIN
				INSERT dbo.TheoDoi
						( 
							TaiSanId ,			NgayTrangCap ,			NgayBatDauSuDung ,		PhongBanId ,			
							NhanVienId ,		SLTon ,					SLTang ,				SLGiam,
							NgayGhiTang	,		Nam
						)
				SELECT		@TaiSanId			,@V_NGAYDIEUCHUYEN		,@V_NGAYDIEUCHUYEN		,@PhongBanChuyenDen
							,@NhanVienTiepNhan	,0						,@SoLuong				,0
							,@V_NGAYDIEUCHUYEN	,YEAR(@V_NGAYDIEUCHUYEN)
			END

			SELECT SCOPE_IDENTITY()
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DuAn_cbxDuAnByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.08
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					EXEC [sp_DuAn_cbxDuAnByCriteria]
						 @Search			=	N''
						,@DuAnId			=	N''
						,@MaDuAn			=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.08 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROC [dbo].[sp_DuAn_cbxDuAnByCriteria]
( 
	 @Search			NVARCHAR(500)   =	NULL	
	,@DuAnId	        INT				=	NULL			
	,@MaDuAn	        NVARCHAR(500)	=	NULL			
	,@CoSoId	        NVARCHAR(500)	=	NULL			
	,@NhanVienId	    NVARCHAR(500)	=	NULL		
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	SET @Search		=	ISNULL(@Search,'')
	SET @DuAnId		=	ISNULL(@DuAnId, 0)
	SET @MaDuAn		=	ISNULL(@MaDuAn,'')

	SELECT TOP 10 DA.*
	FROM	DuAn DA
	WHERE	(@DuAnId = 0 OR DA.DuAnId = @DuAnId)
			AND (@MaDuAn = '' OR DA.MaDuAn = @MaDuAn)
			AND (@Search = '' OR DA.MaDuAn LIKE N'%' + @Search + '%' OR DA.TenDuAn LIKE N'%' + @Search + '%')

	

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DuAn_GetListDuAnByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_DuAn_GetListDuAnByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------


		DECLARE @IS_VIEW varchar(10) = '0'
		   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		  @NHAN_VIEN_ID = @NhanVienId,
		  @CO_SO_ID = @CoSoId,
		  @CHUC_NANG = 'CN0014',
		  @QUYEN=@IS_VIEW OUTPUT
		  print @IS_VIEW
	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.DuAnId,a.MaDuAn,a.TenDuAn,a.GhiChu,nv.TenNhanVien as HoTen,a.NgayTao
	FROM DuAn a 
	LEFT JOIN NhanVien nv on a.NguoiTao=nv.NhanVienId 
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=a.NguoiTao
	where 1=1  and a.CoSoId =''' + @CoSoId + '''';

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (MaDuAn LIKE N''%' +@Search+ '%'' OR TenDuAn LIKE  N''%' +@Search+ '%'')';

	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and  a.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @NhanVienId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @NhanVienId + '''';   
	END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DuyetBaoCao_Duyet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DuyetBaoCao_Duyet]
( 
	  @LapBaoCaoId        nvarchar(500)	= null	
	, @DuyetId		    nvarchar(500)	= null		
	, @NgayDuyet		DATETIME		= null		
	, @NguoiDuyet		nvarchar(500)	= null		
	, @NoiDungDuyet		NVARCHAR(MAX)	= null	
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
Update LapBaoCao set DuyetId = @DuyetId, NgayDuyet= @NgayDuyet, NguoiDuyet = @NguoiDuyet, NoiDungDuyet=@NoiDungDuyet where LapBaoCaoId =  @LapBaoCaoId
Update LapBaoCaoChiTiet set DuyetId = @DuyetId where LapBaoCaoId =  @LapBaoCaoId
select * from LapBaoCao where  LapBaoCaoId =  @LapBaoCaoId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DuyetBaoCao_DuyetChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DuyetBaoCao_DuyetChiTiet]
( 
	  @LapBaoCaoId	        nvarchar(500)	= null	
	 ,@LapBaoCaoChiTietId   nvarchar(500)	= null
	 ,@DuyetId				nvarchar(500)	= null
	 ,@NgayDuyet		    nvarchar(500)	= null
	 ,@NoiDungDuyet			nvarchar(500)	= null
	
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
Update LapBaoCaoChiTiet set DuyetId = @DuyetId, NgayDuyet = @NgayDuyet,NoiDungDuyet = @NoiDungDuyet   where LapBaoCaoId =  @LapBaoCaoId and LapBaoCaoChiTietId = @LapBaoCaoChiTietId
declare @check int = 0;
set @check = (select count(*) from LapBaoCaoChiTiet where  LapBaoCaoId =  @LapBaoCaoId  and (DuyetId not in (1,2)  or DuyetId is null))
if(@check = 0)
begin
	declare @Duyet int = 0;
	set @Duyet = (select count(*) from LapBaoCaoChiTiet where  LapBaoCaoId =  @LapBaoCaoId  and DuyetId  = 1 )
	if(@Duyet> 0 )
	Update LapBaoCao set DuyetId = 1 where LapBaoCaoId =  @LapBaoCaoId 
	else 
	Update LapBaoCao set DuyetId = 2 where LapBaoCaoId =  @LapBaoCaoId 
end
select ISNULL(DuyetId,0) as DuyetId  from LapBaoCao where  LapBaoCaoId =  @LapBaoCaoId 
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DuyetBaoCao_GetListDuyetBaoCaoByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DuyetBaoCao_GetListDuyetBaoCaoByCriteria]
( 
	  @CoSoId	        nvarchar(10)	
	, @SoPhieu		    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null		
	, @PhongBanId		NVARCHAR(MAX)	
	, @DuyetId			nvarchar(10)				= null	
	, @LoginId			nvarchar(10)
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 

	DECLARE  @V_DELIMITER	VARCHAR(10)		=	','
			,@_COSO_IDS		VARCHAR(MAX)	=	NULL
			,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@LoginId,@NAM=@Nam OUTPUT;
	SET @Search = ISNULL(@Search, '')
	IF @Search <> ''
	BEGIN	
		SET @Search = N'%' + @Search + '%'
		SET @Search = CAST(@Search AS VARCHAR(max))	
	END	
	----------

		DECLARE @IS_VIEW varchar(10) = '0'
		exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @LoginId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0029',
		@QUYEN=@IS_VIEW OUTPUT
		PRINT(@CoSoId);
		--/ KIỂM TRA Cơ sở trực thuộc

	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
	PRINT concat('@_COSO_IDS=',@_COSO_IDS)
	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria

	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.*,Case when a.KyBaoCao =1 then CONCAT(N''Năm '', YEAR(a.TuNgay) )  else Case when a.KyBaoCao =2 then (case when month(a.TuNgay)=1 then N''Quí 1'' else case when month(a.TuNgay)=4 then N''Quí 2'' else case when month(a.TuNgay)=7 then N''Quí 3'' else N''Quí 4'' end end end  ) else Case when a.KyBaoCao =3 then CONCAT(N''Tháng'', month(a.TuNgay) ) else  CONCAT(CONCAT(N''Từ ngày '', CONVERT(VARCHAR(10),a.TuNgay,103)), CONCAT(N'' đến ngày '', CONVERT(VARCHAR(10),a.DenNgay,103) )) end end end as TenKyBaoCao  ,nv.TenNhanVien as HoTen,d.TrangThai,
	cs.TenCoSo
	FROM LapBaoCao a LEFT JOIN [dbo].[NhanVien] nv on a.NguoiTao=nv.NhanVienId 
	left join Duyet d on a.DuyetId=d.DuyetId
	LEFT JOIN dbo.CoSo cs ON cs.CoSoId = a.CoSoId
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=a.NguoiTao
	WHERE 1 = 1 and CAST(a.NgayGui AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) and YEAR(a.NgayGui)='''+@Nam+'''' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and (a.DienGiai LIKE N''%' +@Search+ '%'')';
	END

	IF @PhongBanId > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and  nv.PhongBanId in (' + @PhongBanId + ')';
	END

	IF @DuyetId > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and a.DuyetId in ('+@DuyetId+')';
	END
	IF @IS_VIEW = 'VA' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and ( a.CoSoId =''' + @CoSoId + ''' or( a.GuiCapTren = 1 and a.CoSoId in ('+@_COSO_IDS+')))';   
	END
		IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';   
	END
		IF @IS_VIEW = 'VR' 
	BEGIN    
			SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @LoginId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	 
	END
		IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @LoginId + '''';   
	END


	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY a.NgayGui desc' ;

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DuyetBaoCaoChiTiet_GetDuyetBaoCaoChiTietById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROC [dbo].[sp_DuyetBaoCaoChiTiet_GetDuyetBaoCaoChiTietById]
	@LapBaoCaoId INT
AS  
BEGIN
SET NOCOUNT ON  
	
	SELECT  a.*,b.TenBaoCao,b.Report,c.TrangThai,CONVERT(VARCHAR(10),d.TuNgay,103) as TuNgay,CONVERT(VARCHAR(10),d.DenNgay,103) as DenNgay
	from LapBaoCaoChiTiet  a 
	inner join BaoCao b on a.BaoCaoId = b.BaoCaoId
	left join Duyet c on c.DuyetId = a.DuyetId 
	left join LapBaoCao d on d.LapBaoCaoId = a.LapBaoCaoId 
	WHERE a.LapBaoCaoId = @LapBaoCaoId
	
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DuyetCap_Duyet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DuyetCap_Duyet]
( 
	  @DeNghiId	        nvarchar(500)	= null	
	, @DuyetId		    nvarchar(500)	= null		
	, @NgayDuyet		DATETIME		= null		
	, @NguoiDuyet		nvarchar(500)	= null		
	, @NoiDungDuyet		NVARCHAR(MAX)	= null	
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
Update DeNghiTrangCap set DuyetId = @DuyetId, NgayDuyet= @NgayDuyet, NguoiDuyet = @NguoiDuyet, NoiDungDuyet=@NoiDungDuyet where DeNghiId =  @DeNghiId
Update DeNghiTrangCapChiTiet set DuyetId = @DuyetId where DeNghiId =  @DeNghiId
select * from DeNghiTrangCap where  DeNghiId =  @DeNghiId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DuyetCap_DuyetChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DuyetCap_DuyetChiTiet]
( 
	  @DeNghiChiTietId  nvarchar(500)	= null	
	, @DeNghiId	        nvarchar(500)	= null	
	, @DuyetId		    nvarchar(500)	= null		
	
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
Update DeNghiTrangCapChiTiet set DuyetId = @DuyetId where DeNghiId =  @DeNghiId and DeNghiChiTietId = @DeNghiChiTietId
declare @check int = 0;
set @check = (select count(*) from DeNghiTrangCapChiTiet where  DeNghiId =  @DeNghiId  and (DuyetId not in (1,2)  or DuyetId is null))
if(@check = 0)
begin
	declare @Duyet int = 0;
	set @Duyet = (select count(*) from DeNghiTrangCapChiTiet where  DeNghiId =  @DeNghiId  and DuyetId  = 1 )
	if(@Duyet> 0 )
	Update DeNghiTrangCap set DuyetId = 1 where DeNghiId =  @DeNghiId 
	else 
	Update DeNghiTrangCap set DuyetId = 2 where DeNghiId =  @DeNghiId 
end
select ISNULL(DuyetId,0) as DuyetId  from DeNghiTrangCap where  DeNghiId =  @DeNghiId 
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DuyetCap_GetListDuyetCapByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DuyetCap_GetListDuyetCapByCriteria]
( 
	  @CoSoId	        nvarchar(10)	
	, @SoPhieu		    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null		
	, @PhongBanId		NVARCHAR(MAX)	
	, @DuyetId			nvarchar(10)				= null	
	, @LoginId			nvarchar(10)
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 
	DECLARE  @V_DELIMITER	VARCHAR(10)		=	','
			,@_COSO_IDS		VARCHAR(MAX)	=	NULL
			,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@LoginId,@NAM=@Nam OUTPUT;

	SET @Search = ISNULL(@Search, '')
	IF @Search <> ''
	BEGIN	
		SET @Search = N'%' + @Search + '%'
		SET @Search = CAST(@Search AS VARCHAR(max))	
	END	
	----------

		DECLARE @IS_VIEW varchar(10) = '0'
		exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @LoginId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0029',
		@QUYEN=@IS_VIEW OUTPUT
		PRINT(@CoSoId);
		--/ KIỂM TRA Cơ sở trực thuộc

	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
	PRINT concat('@_COSO_IDS=',@_COSO_IDS)
	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria

	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, H.DeNghiId, H.Ngay, H.SoPhieu, H.PhanLoaiId, PL.TenPhanLoai, H.PhongBanId, ISNULL(PB.TenPhongBan,cs.TenCoSo) as TenPhongBan ,cs.TenCoSo, H.NoiDung, H.CoSoId,
			H.DuyetId,H.NoiDungDuyet,D.TrangThai,H.NguoiTao,nv.TenNhanVien,H.NgayTao,H.CtrVersion
	FROM dbo.DeNghiTrangCap H 
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = H.NguoiTao 
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = h.PhongBanId
	LEFT JOIN dbo.PhanLoai PL ON PL.PhanLoaiId = h.PhanLoaiId
	LEFT JOIN dbo.Duyet D ON D.DuyetId = h.DuyetId
	LEFT JOIN dbo.CoSo cs ON cs.CoSoId = h.CoSoId
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=h.NguoiTao
	WHERE 1 = 1 and CAST(Ngay AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) and Year(h.Ngay)='''+@Nam+'''' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.NoiDung LIKE N''%' +@Search+ '%'')';
	END

	IF @PhongBanId > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and  h.PhongBanId in (' + @PhongBanId + ')';
	END

	IF @DuyetId > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and H.DuyetId in ('+@DuyetId+')';
	END
	IF @IS_VIEW = 'VA' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and ( H.CoSoId =''' + @CoSoId + ''' or( H.GuiCapTren = 1 and h.CoSoId in ('+@_COSO_IDS+')))';   
	END
		IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and h.CoSoId =''' + @CoSoId + '''';   
	END
		IF @IS_VIEW = 'VR' 
		BEGIN    
			SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @LoginId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	 
	END
		IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @LoginId + '''';   
	END


	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY H.Ngay desc' ;

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DuyetCapChiTiet_GetDuyetCapChiTietByDeNghiId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_DuyetCapChiTiet_GetDuyetCapChiTietByDeNghiId]
	@DeNghiId INT
AS  
BEGIN
SET NOCOUNT ON  
	
	SELECT CT.DeNghiChiTietId,
			CT.DeNghiId,
			ct.LoaiId,
			LTS.TenLoai,
			CT.TenTaiSan,
			CT.MoTa,
			LTS.TenLoai,
			CT.SoLuong,
			CT.DonViTinh,
			CAST(ct.PhuongThucId AS VARCHAR)PhuongThucId,
			PT.TenPhuongThuc,
			CONVERT(VARCHAR, CT.NgayDeNghi,103) NgayDeNghi,
			CT.DuToan,
			CT.DuToanDuocDuyet,
			CT.GhiChu,
			CT.DuyetId
	FROM dbo.DeNghiTrangCapChiTiet CT
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = CT.LoaiId
	LEFT JOIN dbo.PhuongThuc PT ON PT.PhuongThucId = CT.PhuongThucId
	WHERE CT.DeNghiId = @DeNghiId
	
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DuyetMua_Duyet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DuyetMua_Duyet]
( 
	  @MuaSamId	        nvarchar(500)	= null	
	, @DuyetId		    nvarchar(500)	= null		
	, @NgayDuyet		DATETIME		= null		
	, @NguoiDuyet		nvarchar(500)	= null		
	, @NoiDungDuyet		NVARCHAR(MAX)	= null	
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
Update KeHoachMuaSam set DuyetId = @DuyetId, NgayDuyet= @NgayDuyet, NguoiDuyet = @NguoiDuyet, NoiDungDuyet=@NoiDungDuyet where MuaSamId =  @MuaSamId
Update KeHoachMuaSamChiTiet set DuyetId = @DuyetId where MuaSamId =  @MuaSamId
select * from KeHoachMuaSam where  MuaSamId =  @MuaSamId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DuyetMua_DuyetChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_DuyetMua_DuyetChiTiet]
( 
	  @MuaSamChiTietId  nvarchar(500)	= null	
	, @MuaSamId	        nvarchar(500)	= null	
	, @DuyetId		    nvarchar(500)	= null		
	
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
Update KeHoachMuaSamChiTiet set DuyetId = @DuyetId where MuaSamId =  @MuaSamId and MuaSamChiTietId = @MuaSamChiTietId
declare @check int = 0;
set @check = (select COUNT(*) from KeHoachMuaSamChiTiet where  MuaSamId =  @MuaSamId  and (DuyetId not in (1,2) or DuyetId is null))
if(@check = 0)
begin
	declare @Duyet int = 0;
	set @Duyet = (select count(*) from KeHoachMuaSamChiTiet where  MuaSamId =  @MuaSamId  and DuyetId  = 1 )
	if(@Duyet> 0 )
	Update KeHoachMuaSam set DuyetId = 1 where MuaSamId =  @MuaSamId 
	else 
	Update KeHoachMuaSam set DuyetId = 2 where MuaSamId =  @MuaSamId 
end
select ISNULL(DuyetId,0) as DuyetId  from KeHoachMuaSam where  MuaSamId =  @MuaSamId 
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DuyetMua_GetDuyetMuaChiTietByMuaSamId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_DuyetMua_GetDuyetMuaChiTietByMuaSamId]
( 
	  @MuaSamId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.MuaSamId,a.MuaSamChiTietId,a.TenTaiSan,a.LoaiId,b.TenLoai,CAST(c.PhuongThucId AS VARCHAR) PhuongThucId, c.TenPhuongThuc,a.DonViTinh,a.MoTa,Convert(varchar(10),CONVERT(date,a.Ngay,106),103) AS Ngay,a.SoLuong,a.DonGia,CAST(d.HinhThucId AS VARCHAR) HinhThucId,d.TenHinhThuc,a.DuToan,a.GhiChu,a.DuyetId  from KeHoachMuaSamChiTiet  a 
	left join LoaiTaiSan b on a.LoaiId=b.LoaiId left join PhuongThuc c on a.PhuongThucId=c.PhuongThucId left join HinhThuc d on a.HinhThucId=d.HinhThucId
	where MuaSamId= @MuaSamId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_DuyetMua_GetListDuyetMuaByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_DuyetMua_GetListDuyetMuaByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null	
	, @DuyetId			nvarchar(500)	= null			
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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
	DECLARE  @V_DELIMITER	VARCHAR(10)		=	','
			,@_COSO_IDS		VARCHAR(MAX)	=	NULL
			,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@NhanVienId,@NAM=@Nam OUTPUT;

	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------

	DECLARE @IS_VIEW varchar(10) = '0'
		exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0030',
		@QUYEN=@IS_VIEW OUTPUT
		PRINT(@IS_VIEW);
		--/ KIỂM TRA Cơ sở trực thuộc

	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
	PRINT concat('@_COSO_IDS=',@_COSO_IDS)
	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT,a.*,b.TrangThai,cs.TenCoSo,nv.TenNhanVien
	FROM KeHoachMuaSam a 
	LEFT JOIN dbo.Duyet b ON b.DuyetId = a.DuyetId
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = a.NguoiTao 
	LEFT JOIN dbo.CoSo cs ON cs.CoSoId = a.CoSoId
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=a.NguoiTao
	where  a.Nam='''+@Nam+'''' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (Nam LIKE N''%' +@Search+ '%'' OR NoiDung LIKE  N''%' +@Search+ '%'')';

	IF @DuyetId > ''
	SET @V_SQL = @V_SQL + ' and a.DuyetId in (' +@DuyetId+ ')';

	IF @IS_VIEW = 'VA' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and  a.CoSoId in ('+@_COSO_IDS+')';   
	END
	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';   
	END
		IF @IS_VIEW = 'VR' 
		BEGIN    
			SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @NhanVienId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	 
	END
		IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @NhanVienId + '''';   
	END
	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY a.Nam desc';

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GhiGiam_DeleteGhiGiamById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_GhiGiam_DeleteGhiGiamById]
( 
	  @GhiGiamId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	Delete GhiGiam where GhiGiamId = @GhiGiamId
	select @@ROWCOUNT
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GhiGiam_GetListGhiGiamByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_GhiGiam_GetListGhiGiamByCriteria]
( 
@CoSoId	        nvarchar(500)	= null			
, @NhanVienId	    nvarchar(500)	= null		
, @SoChungTu		nvarchar(500)   = null	
, @TuNgay			nvarchar(500)   = null	
, @DenNgay			nvarchar(500)   = null	
, @PhongBanId			nvarchar(500)	= null			
, @OrderClause		nvarchar(500)	= null				
, @SKIP				int				= null				-- Số dòng skip (để phân trang)
, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
DECLARE @V_SQL NVARCHAR(4000) 

----------
DECLARE @IS_VIEW varchar(10) = '0'
		,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@NhanVienId,@NAM=@Nam OUTPUT;
-----------------
exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
@NHAN_VIEN_ID = @NhanVienId,
@CO_SO_ID = @CoSoId,
@CHUC_NANG = 'CN0023',
@QUYEN=@IS_VIEW OUTPUT


-- Chuẩn bị biến @Skip & @Take
IF (@SKIP IS NULL)
SET @SKIP = 0;

IF (@TAKE IS NULL)
SET @TAKE = 50;
----------

-- Chuẩn bị biến @ORDER_CLAUSE
IF (@OrderClause IS NULL)
SET @OrderClause = ' MAXCNT ';

IF (@OrderClause = '')
SET @OrderClause = ' MAXCNT ';
----------

    
---- Xây dựng nội dung câu SQL  
-- selects all rows from the table according to search criteria
SET @V_SQL = N'
SELECT DISTINCT  COUNT(*) OVER () AS MAXCNT,a.GhiGiamId,a.SoChungTu,a.NgayChungTu,a.NgayGhiGiam,a.PhongBanId,c.TenPhongBan,a.NoiDung,isnull(SUM(NG.GiaTri),0) TongNguyenGia,a.DuyetId, a.NguoiDuyet,a.CoSoId, a.NguoiTao, a.NgayTao,nv.TenNhanVien,ndd.TenNhanVien as NhanVienDuyet 
FROM GhiGiam a 
LEFT JOIN GhiGiamChiTiet b ON a.GhiGiamId =b.GhiGiamId
LEFT join PhongBan c on a.PhongBanId=c.PhongBanId 
LEFT JOIN TaiSan TS ON TS.TaiSanId = b.TaiSanId
LEFT JOIN NguyenGia NG ON NG.TaiSanId = TS.TaiSanId
LEFT JOIN NhanVien ndd ON ndd.NhanVienId = a.NguoiDuyet
LEFT JOIN NhanVien nv ON nv.NhanVienId = a.NguoiTao
LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=a.NguoiTao
where YEAR(a.NgayGhiGiam) = '''+@Nam+''' ';  

-- Build Where clause
-- Where clause Quick search
IF (@SoChungTu > '')
BEGIN
SET @V_SQL = @V_SQL + ' and (a.SoChungTu LIKE N''%' +@SoChungTu+ '%'') ';
END

IF (@PhongBanId > '')
BEGIN
SET @V_SQL = @V_SQL + ' and a.PhongBanId in ('+@PhongBanId+') ';
END

IF( @TuNgay <> '' AND @DenNgay <> '')
BEGIN 
SET @V_SQL = @V_SQL + ' and a.NgayGhiGiam BETWEEN  ''' + @TuNgay + ''' AND '''+ @DenNgay + '''';
END
ELSE IF @TuNgay <> ''
BEGIN
SET @V_SQL = @V_SQL + ' and  a.NgayGhiGiam >=  ''' + @TuNgay + '''';
END
ELSE IF @DenNgay <>''
BEGIN 
SET @V_SQL = @V_SQL + ' and  a.NgayGhiGiam <=  ''' + @DenNgay + '''';
END
		

IF @IS_VIEW = 'VB' 
BEGIN    
SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';   
END
IF @IS_VIEW = 'VR' 
BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @NhanVienId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	END
IF @IS_VIEW = 'VE' 
BEGIN    
SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @NhanVienId + '''';   
END

	
SET @V_SQL = @V_SQL + 'GROUP BY  a.GhiGiamId,a.SoChungTu,a.NgayChungTu,a.NgayGhiGiam,a.PhongBanId,c.TenPhongBan,a.NoiDung,
				a.DuyetId, a.NguoiDuyet,a.CoSoId, a.NguoiTao, a.NgayTao,ndd.TenNhanVien,nv.TenNhanVien ';

-- Build Order clause
IF @OrderClause > ''
SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

-- Build Skip clause
SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

-- Build Take clause
SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
PRINT(@V_SQL);
EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GhiGiam_InsertGhiGiamChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_GhiGiam_InsertGhiGiamChiTiet]
	@GhiGiamId int
	,@TaiSanId int
	,@PhongBanId int
	,@NhanVienId int
	,@XuLyId INT
	,@SoLuong NUMERIC(18,4) 
as
BEGIN
	Declare @ErrMsg nvarchar(max),@V_CHOTNAM INT,@NamGhiGiam int ;
	SELECT @NamGhiGiam  = YEAR(NgayGhiGiam) from GhiGiam where GhiGiamId=@GhiGiamId;
	SELECT @V_CHOTNAM = TrangThai FROM dbo.KhoaSoLieu WHERE Nam = @NamGhiGiam
	-- check chốt năm
		IF (@V_CHOTNAM = 1)
	BEGIN
		RAISERROR ('Số liệu đã khóa !', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );  RETURN
	END

	BEGIN TRAN
		
		BEGIN TRY
		Declare @SoLuongTon NUMERIC(18,4) ; 
		SET @SoLuongTon = (select Isnull((SLTon + SLTang - SLGiam),0)  from TheoDoi  where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId);
		IF(@SoLuongTon >= @SoLuong)	
		BEGIN
			Insert into GhiGiamChiTiet (GhiGiamId,TaiSanId,PhongBanId,NhanVienId,XuLyId,SoLuong) values (@GhiGiamId , @TaiSanId , @PhongBanId , @NhanVienId, @XuLyId, @SoLuong) 
			Update TheoDoi set SLGiam = (SLGiam + @SoLuong) where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId and Nam = @NamGhiGiam
			select * from  GhiGiamChiTiet where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId
		END
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GhiGiam_ReportGhiGiamById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_GhiGiam_ReportGhiGiamById]
( 
	  @GhiGiamId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT gg.SoChungTu,gg.NgayChungTu,gg.NgayGhiGiam,PB.TenPhongBan,gg.NoiDung, a.GhiGiamId,a.GhiGiamChiTietId,b.MaTaiSan,
	b.TaiSanId,b.DonViTinh,b.TenTaiSan,CAST(c.XuLyId AS VARCHAR) as XuLyId,c.TenXuLy,ISNULL((TD.SLTon + TD.SLTang - TD.SLGiam),0) as SoLuongTon ,
	a.SoLuong,ISNULL(sum(d.GiaTri),0) as NguyenGia,cs.MaCoSo,cs.TenCoSo   
	from GhiGiam gg inner join GhiGiamChiTiet  a  on gg.GhiGiamId = a. GhiGiamId
	left join TaiSan b on a.TaiSanId=b.TaiSanId  left join XuLy c on a.XuLyId=c.XuLyId
	left join NguyenGia d on a.TaiSanId=d.TaiSanId
	LEFT JOIN TheoDoi TD ON b.TaiSanId = TD.TaiSanId and a.PhongBanId=TD.PhongBanId and a.NhanVienId=TD.NhanVienId
	LEFT JOIN PhongBan PB ON gg.PhongBanId = PB.PhongBanId
	left join CoSo cs on gg.CoSoId=cs.CoSoId
	where gg.GhiGiamId = @GhiGiamId
	group by  gg.SoChungTu,gg.NgayChungTu,gg.NgayGhiGiam,gg.NoiDung,a.GhiGiamId,a.GhiGiamChiTietId,b.TaiSanId,b.MaTaiSan,b.DonViTinh,b.TenTaiSan,PB.TenPhongBan,a.NhanVienId,c.TenXuLy,a.SoLuong,TD.SLTon,TD.SLTang,TD.SLGiam,c.XuLyId,cs.MaCoSo,cs.TenCoSo  
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GhiGiamChiTiet_DeleteGhiGiamChiTietById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_GhiGiamChiTiet_DeleteGhiGiamChiTietById]
( 
	 @GhiGiamChiTietId int
	,@TaiSanId int
	,@PhongBanId int
	,@NhanVienId int
	,@SoLuong NUMERIC(18,4) 
)
AS  
BEGIN
	Declare @ErrMsg nvarchar(max),@V_CHOTNAM INT,@NamGhiGiam INT,@CoSoId INT ;
	
	SELECT Top 1  @NamGhiGiam  = YEAR(NgayGhiGiam), @CoSoId = a.CoSoId from GhiGiam a inner join GhiGiamChiTiet b on a.GhiGiamId=b.GhiGiamId where b.GhiGiamChiTietId=@GhiGiamChiTietId;
	
	SELECT @V_CHOTNAM = TrangThai FROM dbo.KhoaSoLieu WHERE Nam = @NamGhiGiam
	
	-- check chốt năm
		IF (@V_CHOTNAM = 1)
	BEGIN
		SELECT -1 AS GhiGiamIdI RETURN
		
	END
	BEGIN TRAN
		
		BEGIN TRY
		Declare @SoLuongTon NUMERIC(18,4) ;
		print(@TaiSanId) 
		print(@PhongBanId) 
		print(@NhanVienId) 
		SET @SoLuongTon = (select Isnull((SLTon + SLTang - SLGiam),0)  from TheoDoi  where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId and Nam=@NamGhiGiam );
	
			Update TheoDoi set SLGiam = (SLGiam - @SoLuong) where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId and Nam = @NamGhiGiam
			delete GhiGiamChiTiet where GhiGiamChiTietId=@GhiGiamChiTietId
			select @@ROWCOUNT
	
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GhiGiamChiTiet_GetGhiGiamChiTietByGhiGiamId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_GhiGiamChiTiet_GetGhiGiamChiTietByGhiGiamId]
( 
	  @GhiGiamId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.GhiGiamId,a.GhiGiamChiTietId,b.MaTaiSan,b.TaiSanId,b.DonViTinh,b.TenTaiSan,PB.PhongBanId,PB.TenPhongBan,a.NhanVienId,CAST(c.XuLyId AS VARCHAR) as XuLyId,c.TenXuLy,ISNULL((TD.SLTon + TD.SLTang - TD.SLGiam),0) as SoLuongTon ,a.SoLuong,ISNULL(sum(d.GiaTri),0) as NguyenGia 
	from GhiGiamChiTiet  a 
	left join TaiSan b on a.TaiSanId=b.TaiSanId  left join XuLy c on a.XuLyId=c.XuLyId
	left join NguyenGia d on a.TaiSanId=d.TaiSanId
	LEFT JOIN TheoDoi TD ON b.TaiSanId = TD.TaiSanId and a.PhongBanId=TD.PhongBanId and a.NhanVienId=TD.NhanVienId
			LEFT JOIN PhongBan PB ON TD.PhongBanId = PB.PhongBanId
	where GhiGiamId= @GhiGiamId
	group by  a.GhiGiamId,a.GhiGiamChiTietId,b.TaiSanId,b.MaTaiSan,b.DonViTinh,b.TenTaiSan,PB.PhongBanId,PB.TenPhongBan,a.NhanVienId,c.TenXuLy,a.SoLuong,TD.SLTon,TD.SLTang,TD.SLGiam,c.XuLyId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GhiGiamChiTiet_UpdateGhiGiamChiTietById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_GhiGiamChiTiet_UpdateGhiGiamChiTietById]
( 
	@GhiGiamId int
	,@TaiSanId int
	,@PhongBanId int
	,@NhanVienId int
	,@XuLyId INT
	,@SoLuong NUMERIC(18,4) 
)
AS  
BEGIN
	Declare @ErrMsg nvarchar(max),@V_CHOTNAM INT,@NamGhiGiam INT,@CoSoId INT ;
	SELECT @NamGhiGiam  = YEAR(NgayGhiGiam), @CoSoId = CoSoId from GhiGiam where GhiGiamId=@GhiGiamId;
	SELECT @V_CHOTNAM = TrangThai FROM dbo.KhoaSoLieu WHERE Nam = @NamGhiGiam AND CoSoId = @CoSoId
	-- check chốt năm
		IF (@V_CHOTNAM = 1)
	BEGIN
		RAISERROR ('Số liệu đã khóa !', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );   RETURN
	END

	BEGIN TRAN
		
		BEGIN TRY
		Declare @SoLuongTon NUMERIC(18,4) ; 
		SET @SoLuongTon = (select Isnull((SLTon + SLTang - SLGiam),0)  from TheoDoi  where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId);
		IF(@SoLuongTon >= @SoLuong)	
		BEGIN
			
			Insert into GhiGiamChiTiet (GhiGiamId,TaiSanId,PhongBanId,NhanVienId,XuLyId,SoLuong) values (@GhiGiamId , @TaiSanId , @PhongBanId , @NhanVienId, @XuLyId, @SoLuong) 
			Update TheoDoi set SLGiam = (SLGiam + @SoLuong) where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId and Nam=@NamGhiGiam
			select * from  GhiGiamChiTiet where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId
		END
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GhiTang_DeleteGhiTangById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GhiTang_DeleteGhiTangById]
	@GhiTangId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	DECLARE @V_TB_GHITANGCT TABLE
	(
		ROWID INT IDENTITY(1,1),
		TAISANID INT,
		NGAYBATDAUSUDUNG DATETIME,
		PHONGBANID INT,
		NHANVIENID INT,
		SOLUONG NUMERIC(18,4)
	)
	DECLARE @V_ROWID INT ,
			@V_TAISANID INT,
			@V_NGAYBATDAUSUDUNG DATETIME,
			@V_PHONGBANID INT,
			@V_NHANVIENID INT,
			@V_SOLUONG NUMERIC(18,4),
			@V_NGAYGHITANG DATETIME,
			@V_SOCHUNGTU NVARCHAR(50),
			@V_DUYETID INT,
			@V_CHOTNAM INT,
			@V_COSOID INT

	SELECT @V_NGAYGHITANG = NgayGhiTang, @V_SOCHUNGTU = SoChungTu, @V_DUYETID = DuyetId, @V_COSOID = CoSoId FROM dbo.GhiTang WHERE GhiTangId = @GhiTangId

	SELECT @V_CHOTNAM = TrangThai FROM dbo.KhoaSoLieu WHERE Nam = YEAR(@V_NGAYGHITANG) AND CoSoId = @V_COSOID

	-- check chốt năm + duyệt
	IF (@V_DUYETID = 1 OR @V_CHOTNAM = 1)
	BEGIN
		SELECT -1 AS ID RETURN
	END
    
	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT @V_TB_GHITANGCT( TAISANID ,NGAYBATDAUSUDUNG ,PHONGBANID ,NHANVIENID ,SOLUONG)
			SELECT GTCT.TaiSanId,GTCT.NgayBatDauSuDung,GTCT.PhongBanId,GTCT.NhanVienId,GTCT.SoLuong
			FROM dbo.GhiTangChiTiet GTCT WHERE GTCT.GhiTangId = @GhiTangId			

			WHILE EXISTS(SELECT 1 FROM @V_TB_GHITANGCT)
			BEGIN
				SELECT TOP 1 @V_ROWID = ROWID, @V_TAISANID = TAISANID, @V_NGAYBATDAUSUDUNG = NGAYBATDAUSUDUNG, @V_PHONGBANID = PHONGBANID, @V_NHANVIENID=NHANVIENID,@V_SOLUONG = SOLUONG FROM @V_TB_GHITANGCT

				IF EXISTS(SELECT 1 FROM dbo.TheoDoi WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENID AND PhongBanId = @V_PHONGBANID AND Nam = YEAR(@V_NGAYGHITANG))
				BEGIN

					UPDATE dbo.TheoDoi SET SLTang = SLTang - @V_SOLUONG WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENID AND PhongBanId = @V_PHONGBANID AND Nam = YEAR(@V_NGAYGHITANG)

					IF (SELECT SLTon + SLTang - SLGiam FROM dbo.TheoDoi WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENID AND PhongBanId = @V_PHONGBANID AND Nam = YEAR(@V_NGAYGHITANG)) < 0
					BEGIN	
						begin try rollback tran end try begin catch end CATCH
                        SELECT -1 AS ID,@V_SOCHUNGTU SOCHUNGTU
						RETURN
					END
					
				END
				

				DELETE @V_TB_GHITANGCT WHERE ROWID = @V_ROWID
				SELECT @V_ROWID = NULL,@V_TAISANID = NULL,@V_NGAYBATDAUSUDUNG = NULL,@V_PHONGBANID = NULL,@V_NHANVIENID = NULL,@V_SOLUONG = NULL
			END

			DELETE dbo.GhiTangChiTiet WHERE GhiTangId = @GhiTangId
			DELETE dbo.GhiTang WHERE GhiTangId = @GhiTangId
			
			SELECT @@ROWCOUNT

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GhiTang_GetListGhiTangByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_GhiTang_GetListGhiTangByCriteria]
( 
	  @CoSoId	        NVARCHAR(10)	
	, @SoChungTu	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null		
	, @LoginId			NVARCHAR(10)
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 
	,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@LoginId,@NAM=@Nam OUTPUT;


	SET @Search = ISNULL(@Search, '')
	IF @Search <> ''
	BEGIN	
		SET @Search = N'%' + @Search + '%'
		SET @Search = CAST(@Search AS VARCHAR(max))	
	END	
	----------

	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @LoginId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0024',
		@QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria

	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, H.GhiTangId, H.SoChungTu, H.NgayChungTu, H.NgayGhiTang, H.NoiDung,
			isnull(SUM(NG.GiaTri),0) TongNguyenGia, h.DuyetId, H.NguoiDuyet,ndd.TenNhanVien TenNguoiDuyet, H.CoSoId, H.NguoiTao,nv.TenNhanVien TenNguoiTao, H.NgayTao
	FROM dbo.GhiTang H
	LEFT JOIN dbo.GhiTangChiTiet L ON H.GhiTangId = L.GhiTangId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = L.TaiSanId
	LEFT JOIN dbo.NguyenGia NG ON NG.TaiSanId = TS.TaiSanId
	LEFT JOIN NhanVien nv ON nv.NhanVienId = h.NguoiTao
	LEFT JOIN NhanVien ndd ON ndd.NhanVienId = h.NguoiDuyet
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=h.NguoiTao
	WHERE CAST(H.NgayGhiTang AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) and YEAR(H.NgayGhiTang)='''+@Nam+''''; 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.NoiDung LIKE N''%' +@Search+ '%'')';
	END

	IF (@SoChungTu > '')
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.SoChungTu LIKE N''%' +@SoChungTu+ '%'') ';
	END
	
	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and H.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
			SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @LoginId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	  
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @LoginId + '''';   
	END

	SET @V_SQL = @V_SQL + ' GROUP BY H.GhiTangId, H.SoChungTu, H.NgayChungTu, H.NgayGhiTang, H.NoiDung,
							h.DuyetId, H.NguoiDuyet, H.CoSoId, H.NguoiTao, H.NgayTao,ndd.TenNhanVien,nv.TenNhanVien ';

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GhiTang_GetListGhiTangByGhiTangId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_GhiTang_GetListGhiTangByGhiTangId]
( 
	@GhiTangId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	
	SELECT H.GhiTangId,
			H.SoChungTu,
			CONVERT(VARCHAR, H.NgayChungTu,103)NgayChungTu,
			CONVERT(VARCHAR, H.NgayGhiTang,103)NgayGhiTang,
			H.NoiDung

	FROM dbo.GhiTang H
	WHERE H.GhiTangId = @GhiTangId

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GhiTang_GetListReportGhiTangByGhiTangId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

EXEC dbo.sp_GhiTang_GetListReportGhiTangByGhiTangId @GhiTangId = N'14' -- nvarchar(10)

*/


CREATE PROC [dbo].[sp_GhiTang_GetListReportGhiTangByGhiTangId]
( 
	@GhiTangId NVARCHAR(10)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	
	SELECT	CS.MaCoSo, CS.TenCoSo,
			H.SoChungTu,
			H.NgayChungTu,
			H.NgayGhiTang,
			H.NoiDung,
			-----------------------------------------------line
			TS.TenTaiSan, LTS.TenLoai LoaiTaiSan, TS.NamSanXuat, NSX.TenNuocSanXuat, TS.SoQDTC, PB.TenPhongBan, NV.TenNhanVien, L.SoLuong,
			L.NgayBatDauSuDung

	FROM dbo.GhiTang H
	JOIN dbo.GhiTangChiTiet L ON L.GhiTangId = H.GhiTangId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = L.TaiSanId
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = TS.LoaiId
	LEFT JOIN dbo.NuocSanXuat NSX ON NSX.NuocSanXuatId = TS.NuocSanXuatId
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = L.PhongBanId
	LEFT JOIN dbo.NhanVien NV ON NV.NhanVienId = L.NhanVienId
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
	WHERE H.GhiTangId = @GhiTangId

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GhiTang_InsertGhiTang]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_GhiTang_InsertGhiTang]
	@SoChungTu NVARCHAR(50)
	,@NgayChungTu datetime
	,@NgayGhiTang datetime
	,@NoiDung NVARCHAR(max)
	,@CoSoId INT
	,@NhanVienId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max),
			@V_CHOTNAM INT
	
	SELECT @V_CHOTNAM = TrangThai FROM dbo.KhoaSoLieu WHERE nam = YEAR(@NgayGhiTang) AND CoSoId = @CoSoId

	IF (@V_CHOTNAM = 1)
	BEGIN
		SELECT -1 AS GhiTangIdI RETURN
	END

	-----------------------------------------------------------------------------------------------------
	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.GhiTang
			        ( SoChungTu ,			NgayChungTu ,			NgayGhiTang ,
			          NoiDung ,				DuyetId ,				NguoiDuyet ,
			          CoSoId ,				NguoiTao ,				NgayTao ,
			          CtrVersion
			        )
			SELECT	@SoChungTu				,@NgayChungTu			,@NgayGhiTang
					,@NoiDung				,0						,0
					,@CoSoId				,@NhanVienId			,GETDATE()
					,1

			SELECT SCOPE_IDENTITY() AS GhiTangIdI

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GhiTang_UpdateGhiTang]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_GhiTang_UpdateGhiTang]
	@GhiTangId INT
	,@SoChungTu NVARCHAR(50)
	,@NgayChungTu datetime
	,@NgayGhiTang datetime
	,@NoiDung NVARCHAR(max)
	,@CoSoId INT
	,@NhanVienId INT
	,@CompareLine INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	
	DECLARE @V_TB_GHITANGCT TABLE
	(
		ROWID INT IDENTITY(1,1),
		TAISANID INT,
		NGAYBATDAUSUDUNG DATETIME,
		PHONGBANID INT,
		NHANVIENID INT,
		SOLUONG NUMERIC(18,4)
	)
	DECLARE @V_ROWID INT ,
			@V_TAISANID INT,
			@V_NGAYBATDAUSUDUNG DATETIME,
			@V_PHONGBANID INT,
			@V_NHANVIENID INT,
			@V_SOLUONG NUMERIC(18,4),
			@V_CHOTNAM INT,
			@V_NGAYGHITANG_OLD DATETIME,
			@V_DUYETID INT

	---------------------------------------------------------------------------------------------------
	SELECT @V_NGAYGHITANG_OLD = NgayGhiTang, @V_DUYETID = DuyetId FROM dbo.GhiTang WHERE GhiTangId = @GhiTangId
	SELECT @V_CHOTNAM = TrangThai FROM dbo.KhoaSoLieu WHERE Nam = YEAR(@V_NGAYGHITANG_OLD) AND CoSoId = @CoSoId

	-- check chốt năm + duyệt
	IF (@V_DUYETID = 1)
	BEGIN
		SELECT -2 AS ID RETURN
	END
	IF (@V_CHOTNAM = 1)
	BEGIN
		SELECT -3 AS ID RETURN
	END

	---------------------------------------------------------------------------------------------------
	BEGIN TRAN
		
		BEGIN TRY
			
			UPDATE dbo.GhiTang
			SET NgayChungTu = @NgayChungTu,
				NgayGhiTang = @NgayGhiTang,
				NoiDung = @NoiDung
			WHERE GhiTangId = @GhiTangId
			
			-------------------------------------------------------------
			/* cập nhật lại tồn cho theo dõi */

			IF (@CompareLine = 0)	
			BEGIN
				INSERT @V_TB_GHITANGCT( TAISANID ,NGAYBATDAUSUDUNG ,PHONGBANID ,NHANVIENID ,SOLUONG)
				SELECT GTCT.TaiSanId,GTCT.NgayBatDauSuDung,GTCT.PhongBanId,GTCT.NhanVienId,GTCT.SoLuong
				FROM dbo.GhiTangChiTiet GTCT WHERE GTCT.GhiTangId = @GhiTangId


				WHILE EXISTS(SELECT 1 FROM @V_TB_GHITANGCT)
				BEGIN
					SELECT TOP 1 @V_ROWID = ROWID, @V_TAISANID = TAISANID, @V_NGAYBATDAUSUDUNG = NGAYBATDAUSUDUNG, @V_PHONGBANID = PHONGBANID, @V_NHANVIENID=NHANVIENID,@V_SOLUONG = SOLUONG FROM @V_TB_GHITANGCT

					IF EXISTS(SELECT 1 FROM dbo.TheoDoi WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENID AND PhongBanId = @V_PHONGBANID AND Nam = YEAR(@V_NGAYGHITANG_OLD))
					BEGIN

						UPDATE dbo.TheoDoi SET SLTang = SLTang - @V_SOLUONG WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENID AND PhongBanId = @V_PHONGBANID AND Nam = YEAR(@V_NGAYGHITANG_OLD)

						IF (SELECT SLTon + SLTang - SLGiam FROM dbo.TheoDoi WHERE TaiSanId = @V_TAISANID AND NhanVienId = @V_NHANVIENID AND PhongBanId = @V_PHONGBANID AND Nam = YEAR(@V_NGAYGHITANG_OLD)) < 0
						BEGIN	
							begin try rollback tran end try begin catch end CATCH
							SELECT -1 AS ID
							RETURN
						END
					END
				

					DELETE @V_TB_GHITANGCT WHERE ROWID = @V_ROWID
					SELECT @V_ROWID = NULL,@V_TAISANID = NULL,@V_NGAYBATDAUSUDUNG = NULL,@V_PHONGBANID = NULL,@V_NHANVIENID = NULL,@V_SOLUONG = NULL
				END

				DELETE dbo.GhiTangChiTiet WHERE GhiTangId = @GhiTangId

			END

			SELECT @@ROWCOUNT AS ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GhiTangChiTiet_GetGhiTangChiTietByDeNghiId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_GhiTangChiTiet_GetGhiTangChiTietByDeNghiId]
	@GhiTangId INT
AS  
BEGIN
SET NOCOUNT ON  

	SELECT ct.GhiTangChiTietId,
			ct.GhiTangId,
			CAST(ct.TaiSanId AS VARCHAR)TaiSanId,
			ts.MaTaiSan,
			ts.TenTaiSan,
			ts.DonViTinh,
			CAST(ct.PhongBanId AS VARCHAR)PhongBanId,
			pb.TenPhongBan,
			CONVERT(VARCHAR, ct.NgayBatDauSuDung,103)NgayBatDauSuDung,
			CAST(ct.NhanVienId AS VARCHAR)NhanVienId,
			nv.TenNhanVien,
			ct.SoLuong,
			ISNULL(SUM(ng.GiaTri),0) NguyenGia,
			ct.HopDongId, HD.SoHopDong
	FROM dbo.GhiTangChiTiet ct
	LEFT JOIN dbo.PhongBan pb ON pb.PhongBanId = ct.PhongBanId
	LEFT JOIN dbo.TaiSan ts ON ts.TaiSanId = ct.TaiSanId
	LEFT JOIN dbo.NguyenGia ng ON ng.TaiSanId = ts.TaiSanId
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = ct.NhanVienId
	LEFT JOIN dbo.HopDong HD ON HD.HopDongId = ct.HopDongId
	WHERE ct.GhiTangId = @GhiTangId
	GROUP BY
			ct.GhiTangChiTietId,
			ct.GhiTangId,
			ct.TaiSanId,
			ts.MaTaiSan,
			ts.TenTaiSan,
			ts.DonViTinh,
			ct.PhongBanId,
			pb.TenPhongBan,
			ct.NgayBatDauSuDung,
			ct.NhanVienId,
			nv.TenNhanVien,
			ct.SoLuong,
			ct.HopDongId, HD.SoHopDong
	
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GhiTangChiTiet_InsertGhiTangChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GhiTangChiTiet_InsertGhiTangChiTiet]
	@GhiTangId INT
	,@TaiSanId INT
	,@NgayBatDauSuDung DATETIME
	,@PhongBanId INT
	,@NhanVienId INT
	,@SoLuong NUMERIC(18,4)
	,@HopDongId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	DECLARE @V_NGAYGHITANG DATETIME

	SELECT @V_NGAYGHITANG = NgayGhiTang FROM dbo.GhiTang WHERE GhiTangId = @GhiTangId
	
	IF (@PhongBanId = 0) SET @PhongBanId = NULL
	IF (@NhanVienId = 0) SET @NhanVienId = NULL

	BEGIN TRAN
		BEGIN TRY
			
			INSERT dbo.GhiTangChiTiet
			        ( GhiTangId ,			TaiSanId ,			NgayBatDauSuDung ,
			          PhongBanId ,			NhanVienId ,		SoLuong,				HopDongId
			        )
			SELECT	@GhiTangId				,@TaiSanId			,@NgayBatDauSuDung
					,@PhongBanId			,@NhanVienId		,@SoLuong,				@HopDongId
			
			IF EXISTS(SELECT 1 FROM dbo.TheoDoi WHERE TaiSanId = @TaiSanId AND NhanVienId = @NhanVienId AND PhongBanId = @PhongBanId AND Nam = YEAR(@V_NGAYGHITANG))
			BEGIN
				UPDATE dbo.TheoDoi SET SLTang = SLTang + @SoLuong,NgayGhiTang=@V_NGAYGHITANG WHERE TaiSanId = @TaiSanId AND NhanVienId = @NhanVienId AND PhongBanId = @PhongBanId AND Nam = YEAR(@V_NGAYGHITANG)
			END
			ELSE
			BEGIN
				INSERT dbo.TheoDoi
						( 
							TaiSanId ,			NgayTrangCap ,			NgayBatDauSuDung ,		PhongBanId ,			
							NhanVienId ,		SLTon ,					SLTang ,				SLGiam		, 
							NgayGhiTang ,		Nam,					HopDongId
						)
				SELECT		@TaiSanId			,@V_NGAYGHITANG			,@NgayBatDauSuDung		,@PhongBanId
							,@NhanVienId		,0						,@SoLuong				,0			
							,@V_NGAYGHITANG,	YEAR(@V_NGAYGHITANG),	@HopDongId
			END
			
			SELECT SCOPE_IDENTITY()
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GiayBaoHong_DeleteGiayBaoHongById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GiayBaoHong_DeleteGiayBaoHongById]
	@GiayBaoHongId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	BEGIN TRAN
		
		BEGIN TRY
			
			DELETE dbo.GiayBaoHongChiTiet WHERE GiayBaoHongId = @GiayBaoHongId
			DELETE dbo.GiayBaoHong WHERE GiayBaoHongId = @GiayBaoHongId
			
			SELECT @@ROWCOUNT

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GiayBaoHong_GetListGiayBaoHongByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_GiayBaoHong_GetListGiayBaoHongByCriteria]
( 
	  @CoSoId	        NVARCHAR(10)	
	, @SoPhieu		    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null		
	, @PhongBanId		NVARCHAR(MAX)	
	, @LoginId			NVARCHAR(10)
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) ,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@LoginId,@NAM=@Nam OUTPUT;



	SET @Search = ISNULL(@Search, '')
	IF @Search <> ''
	BEGIN	
		SET @Search = N'%' + @Search + '%'
		SET @Search = CAST(@Search AS VARCHAR(max))	
	END	
	----------


	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @LoginId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0043',
		@QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria

	
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, H.GiayBaoHongId, H.SoChungTu, H.Ngay, H.PhongBanId, PB.TenPhongBan,
			H.CtrVersion, H.NguoiTao , nv.TenNhanVien, H.NgayTao, H.NoiDung, H.CoSoId
	FROM dbo.GiayBaoHong H
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = h.PhongBanId
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = H.NguoiTao 
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=h.NguoiTao
	WHERE 1 = 1 and CAST(Ngay AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) and YEAR(H.Ngay)='''+@Nam+'''';  

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.NoiDung LIKE N''%' +@Search+ '%'')';
	END

	IF @PhongBanId > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and  h.PhongBanId in (' + @PhongBanId + ')';
	END

	
	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and  H.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @LoginId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @LoginId + '''';   
	END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY  H.Ngay desc,' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GiayBaoHong_GetListGiayBaoHongById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_GiayBaoHong_GetListGiayBaoHongById]
( 
	@GiayBaoHongId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	
	SELECT H.GiayBaoHongId,
			H.SoChungTu,
			CONVERT(VARCHAR, H.Ngay, 103)Ngay,
			CAST(H.PhongBanId AS VARCHAR)PhongBanId,
			PB.TenPhongBan,
			H.NoiDung
	FROM dbo.GiayBaoHong H 
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = h.PhongBanId
	WHERE H.GiayBaoHongId = @GiayBaoHongId

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GiayBaoHong_GetListReportGiayBaoHongById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_GiayBaoHong_GetListReportGiayBaoHongById]
( 
	@GiayBaoHongId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	
	SELECT CS.MaCoSo, CS.TenCoSo, H.SoChungTu, PB.TenPhongBan,
			TS.TenTaiSan, TS.DonViTinh, TD.NgayBatDauSuDung, H.Ngay, L.LyDo, L.SoLuong, CS.GhiChu, SUM(ISNULL(NG.GiaTri,0)) * L.SoLuong GiaTriXuatDung
	FROM dbo.GiayBaoHong H 
	JOIN dbo.GiayBaoHongChiTiet L ON L.GiayBaoHongId = H.GiayBaoHongId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = L.TaiSanId
	LEFT JOIN dbo.NguyenGia NG ON NG.TaiSanId = TS.TaiSanId
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = H.PhongBanId
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
	LEFT JOIN dbo.TheoDoi TD ON TD.TaiSanId = l.TaiSanId AND TD.NhanVienId = L.NhanVienId AND TD.PhongBanId = L.PhongBanId AND TD.Nam = YEAR(H.Ngay)
	WHERE H.GiayBaoHongId = @GiayBaoHongId
	GROUP BY CS.MaCoSo, CS.TenCoSo, H.SoChungTu, PB.TenPhongBan,
			L.TaiSanId, TS.TenTaiSan, TS.DonViTinh, TD.NgayBatDauSuDung, H.Ngay, L.LyDo, L.SoLuong, CS.GhiChu

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GiayBaoHong_InsertGiayBaoHong]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GiayBaoHong_InsertGiayBaoHong]
	@SoChungTu NVARCHAR(50),
	@Ngay DATETIME,
	@PhongBanId INT,
	@NoiDung NVARCHAR(500),
	@CoSoId INT,
	@NhanVienId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	if(@PhongBanId = 0) SET @PhongBanId = NULL

	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.GiayBaoHong
			        ( SoChungTu ,		Ngay ,			PhongBanId ,
			          NoiDung ,			CoSoId ,		NguoiTao ,
			          NgayTao ,			CtrVersion
			        )
			SELECT @SoChungTu,			@Ngay,			@PhongBanId,
					@NoiDung,			@CoSoId,		@NhanVienId,
					GETDATE(),			1

			SELECT SCOPE_IDENTITY() AS GiayBaoHongIdI

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GiayBaoHong_UpdateGiayBaoHongById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GiayBaoHong_UpdateGiayBaoHongById]
	@GiayBaoHongId INT,
	@SoChungTu NVARCHAR(50),
	@Ngay DATETIME,
	@PhongBanId INT,
	@NoiDung NVARCHAR(500),
	@CoSoId INT,
	@NhanVienId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	
	BEGIN TRAN
		
		BEGIN TRY
			
			UPDATE dbo.GiayBaoHong
			SET Ngay = @Ngay
				,PhongBanId = @PhongBanId
				,NoiDung = @NoiDung
			WHERE GiayBaoHongId = @GiayBaoHongId

			DELETE dbo.GiayBaoHongChiTiet WHERE GiayBaoHongId = @GiayBaoHongId

			SELECT @@ROWCOUNT

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GiayBaoHongChiTiet_GetGiayBaoHongChiTietById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_GiayBaoHongChiTiet_GetGiayBaoHongChiTietById]
	@GiayBaoHongId INT
AS  
BEGIN
SET NOCOUNT ON  
	
	SELECT CT.GiayBaoHongChiTietId,
			CT.GiayBaoHongId,
			CT.TaiSanId,
			TS.TenTaiSan,
			CT.PhongBanId,
			PB.TenPhongBan,
			CT.NhanVienId,
			NV.TenNhanVien,
			CT.SoLuong,
			CT.LyDo,
			CT.GhiChu
	FROM dbo.GiayBaoHongChiTiet CT
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = CT.TaiSanId
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = CT.PhongBanId
	LEFT JOIN dbo.NhanVien NV ON NV.NhanVienId = CT.NhanVienId
	WHERE CT.GiayBaoHongId = @GiayBaoHongId
	
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GiayBaoHongChiTiet_InsertGiayBaoHongChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GiayBaoHongChiTiet_InsertGiayBaoHongChiTiet]
	@GiayBaoHongId INT,
	@TaiSanId INT,
	@PhongBanId INT,
	@NhanVienId INT,
	@SoLuong INT,
	@LyDo NVARCHAR(500),
	@GhiChu NVARCHAR(500)
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	
	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.GiayBaoHongChiTiet
			        ( TaiSanId ,			PhongBanId ,			NhanVienId ,
			          SoLuong ,				LyDo ,					GhiChu,
					  GiayBaoHongId
			        )
			SELECT	@TaiSanId,				@PhongBanId,			@NhanVienId,
					@SoLuong,				@LyDo,					@GhiChu,
					@GiayBaoHongId

			SELECT SCOPE_IDENTITY()
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_HangSanXuat_cbxHangSanXuatByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.08
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_HangSanXuat_cbxHangSanXuatByCriteria]
						 @Search			=	N''
						,@HangSanXuatId		=	N''
						,@MaHangSanXuat		=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.08 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROC [dbo].[sp_HangSanXuat_cbxHangSanXuatByCriteria]
( 
	 @Search			NVARCHAR(500)   =	NULL
	,@HangSanXuatId		INT				=	NULL
	,@MaHangSanXuat		NVARCHAR(500)	=	NULL
	,@CoSoId			NVARCHAR(500)	=	NULL
	,@NhanVienId		NVARCHAR(500)	=	NULL
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	SET @Search				=	ISNULL(@Search,'')
	SET @HangSanXuatId		=	ISNULL(@HangSanXuatId, 0)
	SET @MaHangSanXuat		=	ISNULL(@MaHangSanXuat,'')

	SELECT TOP 10 HSX.*
	FROM	HangSanXuat HSX
	WHERE	(@HangSanXuatId = 0 OR HSX.HangSanXuatId = @HangSanXuatId)
			AND (@MaHangSanXuat = '' OR HSX.MaHangSanXuat = @MaHangSanXuat)
			AND (@Search = '' OR HSX.MaHangSanXuat LIKE N'%' + @Search + '%' OR HSX.TenHangSanXuat LIKE N'%' + @Search + '%')

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_HangSanXuat_GetListHangSanXuatByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_HangSanXuat_GetListHangSanXuatByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------

	--DECLARE @IS_VIEW_ALL varchar = '0'
 -- 	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
	--	@LOGINID = @CoSoId,
	--	@CHUC_NANG = 'CN0004',
	--	@QUYEN_TAC_VU = 'View All',
	--	@YES_NO=@IS_VIEW_ALL OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.HangSanXuatId,a.MaHangSanXuat,a.TenHangSanXuat,a.GhiChu,b.TenNhanVien as HoTen,a.NgayTao
	FROM HangSanXuat a LEFT JOIN NhanVien b on a.NguoiTao=b.NhanVienId where 1=1 ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (MaHangSanXuat LIKE N''%' +@Search+ '%'' OR TenHangSanXuat LIKE  N''%' +@Search+ '%'')';


	--	IF @IS_VIEW_ALL = '0' 
	--BEGIN			 
	--		SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';	  
	--END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_HienTrangSuDung_cbxHienTrangSuDungByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.06
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_HienTrangSuDung_cbxHienTrangSuDungByCriteria]
						 @Search			=	N''
						,@HienTrangSuDungId	=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.06 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_HienTrangSuDung_cbxHienTrangSuDungByCriteria]
( 
	 @Search				NVARCHAR(500)   =	NULL
	,@HienTrangSuDungId		INT				=	NULL
	,@CoSoId				NVARCHAR(500)	=	NULL			
	,@NhanVienId			NVARCHAR(500)	=	NULL		
	
)
AS  
BEGIN
SET NOCOUNT ON 
------------------------------------------------  
	SET @Search				=	ISNULL(@Search,'')
	SET @HienTrangSuDungId	=	ISNULL(@HienTrangSuDungId, 0)

	SELECT TOP 10 HTSD.*
	FROM	HienTrangSuDung HTSD
	WHERE	(@HienTrangSuDungId = 0 OR HTSD.HienTrangSuDungId = @HienTrangSuDungId)
			AND (@Search = '' OR HTSD.NoiDung LIKE N'%' + @Search + '%')
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_HopDong_cbxHopDongById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_HopDong_cbxHopDongById]
( 
	 @CoSoId	        nvarchar(500)	= null
	,@NhanVienId	    nvarchar(500)	= null
	,@Search			nvarchar(500)   = null
	,@HopDongId			NVARCHAR(500)   = null
	,@FunctionCode		nvarchar(500)   = null
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	DECLARE		 @_COSO_IDS		VARCHAR(MAX)	=	NULL
				,@V_ISVIEW		VARCHAR(MAX)	=	NULL
				,@V_PHONGBAN_ID	VARCHAR(MAX)	=	NULL

	SET @HopDongId = ISNULL(@HopDongId, '')
	IF @HopDongId = ''
		SET @HopDongId = '0'

	-- KIỂM TRA QUYỀN VIEW
	EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = @FunctionCode,
		@QUYEN=@V_ISVIEW OUTPUT

	--/ KIỂM TRA QUYỀN VIEW

	-- DANH SÁCH CƠ SỞ TRƯC THUỘC
	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
		@COSOID=@CoSoId
		,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',','|')

	PRINT @V_ISVIEW
	SELECT		*
	FROM		dbo.HopDong HD
	WHERE		(		(@V_ISVIEW = 'VA')
					OR	(@V_ISVIEW = 'VB' AND CHARINDEX('|' + CAST(HD.CoSoId AS VARCHAR(10)) + '|', '|' + @_COSO_IDS + '|') > 0)
				)
				AND (@HopDongId = '0' OR HD.HopDongId = @HopDongId)
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_HopDong_DeleteHopDongById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_HopDong_DeleteHopDongById]
	@HopDongId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			DELETE dbo.HopDong WHERE HopDongId = @HopDongId
			
			SELECT @@ROWCOUNT ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_HopDong_GetHopDongById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_HopDong_GetHopDongById]
( 
	  @HopDongId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT HopDongId, SoHopDong, CONVERT(VARCHAR, NgayHopDong,103)NgayHopDong, TenNhaThau, DaiDien, 
			GiaTriHopDong, NoiDung, FileDinhKem, CoSoId, NgayTao, NguoiTao
	FROM dbo.HopDong
	WHERE HopDongId = @HopDongId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_HopDong_GetListHopDongByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_HopDong_GetListHopDongByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  

------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 
	DECLARE @V_SEARCH_STRING NVARCHAR(4000) 
	DECLARE @TenPhongBan NVARCHAR(max)


	SET @Search = ISNULL(@Search, '')
	IF @Search <> ''
	BEGIN	
		SET @Search = N'%' + @Search + '%'
		SET @V_SEARCH_STRING = CAST(@Search AS VARCHAR(200))	
	END	
	----------
	DECLARE @IS_VIEW varchar(10) = '0'
   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0051',
		@QUYEN=@IS_VIEW OUTPUT


	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------
	
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, HopDongId, SoHopDong, NgayHopDong, TenNhaThau, DaiDien, 
			GiaTriHopDong, NoiDung, FileDinhKem, CoSoId, a.NgayTao, a.NguoiTao, nv.TenNhanVien AS TenNguoiTao
	FROM dbo.HopDong a
	LEFT JOIN [dbo].[NhanVien] nv on a.NguoiTao=nv.NhanVienId 
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=a.NguoiTao
	WHERE 1=1  ' 

	-- Build Where clause
	-- Where clause Quick search
	
	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (a.SoHopDong LIKE N''%' +@Search+ '%'' OR a.TenNhaThau LIKE  N''%' +@Search+ '%'' OR a.DaiDien LIKE  N''%' +@Search+ '%'')';

		IF @IS_VIEW = 'VB' 
 BEGIN    
   SET @V_SQL = @V_SQL + ' and PB.CoSoId =''' + @CoSoId + '''';   
 END
   IF @IS_VIEW = 'VR' 
 BEGIN    
   SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @NhanVienId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	   
 END
  IF @IS_VIEW = 'VE' 
 BEGIN    
   SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @NhanVienId + '''';   
 END
	

	--SET @V_SQL = @V_SQL + ' GROUP BY a.NhanVienId,a.MaNhanVien,a.TenNhanVien,a.DienThoai,a.GhiChu,nv.TenNhanVien,a.NgayTao,PB.TenPhongBan '
	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_HopDong_InsertHopDong]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_HopDong_InsertHopDong]
	@SoHopDong NVARCHAR(100),
	@NgayHopDong DATETIME,
	@TenNhaThau NVARCHAR(200),
	@DaiDien VARCHAR(200),
	@GiaTriHopDong NUMERIC(18,4),
	@NoiDung NVARCHAR(1000),
	@FileDinhKem NVARCHAR(500),
	@CoSoId INT,
	@NguoiTao NVARCHAR(100)

as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.HopDong
			        ( SoHopDong ,		NgayHopDong ,			TenNhaThau ,
			          DaiDien ,			GiaTriHopDong ,			NoiDung ,
			          FileDinhKem ,		CoSoId ,				NgayTao ,	
					  NguoiTao ,		CtrVersion
			        )
			SELECT @SoHopDong,			@NgayHopDong,			@TenNhaThau,
				   @DaiDien,			@GiaTriHopDong,			@NoiDung,
				   @FileDinhKem,		@CoSoId,				GETDATE(),
				   @NguoiTao,			1

			SELECT SCOPE_IDENTITY() AS HopDongIdI

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_HopDong_UpdateHopDong]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_HopDong_UpdateHopDong]
	@HopDongId INT,
	@SoHopDong NVARCHAR(100),
	@NgayHopDong DATETIME,
	@TenNhaThau NVARCHAR(200),
	@DaiDien VARCHAR(200),
	@GiaTriHopDong NUMERIC(18,4),
	@NoiDung NVARCHAR(1000),
	@FileDinhKem NVARCHAR(500),
	@CoSoId INT,
	@NguoiTao NVARCHAR(100)
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			
			UPDATE dbo.HopDong
			SET 
				NgayHopDong = @NgayHopDong,
				TenNhaThau = @TenNhaThau,
				DaiDien = @DaiDien,
				GiaTriHopDong = @GiaTriHopDong,
				NoiDung = @NoiDung,
				FileDinhKem = @FileDinhKem,
				NguoiTao = @NguoiTao,
				CtrVersion = CtrVersion + 1
			WHERE HopDongId = @HopDongId
			
			SELECT * FROM dbo.HopDong WHERE HopDongId = @HopDongId

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KeHoachMuaSam_DeleteKeHoachMuaSamById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KeHoachMuaSam_DeleteKeHoachMuaSamById]
( 
	  @MuaSamId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	Delete KeHoachMuaSamChiTiet where MuaSamId = @MuaSamId
	Delete KeHoachMuaSam where MuaSamId = @MuaSamId
	select @@ROWCOUNT
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KeHoachMuaSam_GetListKeHoachMuaSamByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KeHoachMuaSam_GetListKeHoachMuaSamByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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
	,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@NhanVienId,@NAM=@Nam OUTPUT;


	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------

	DECLARE @IS_VIEW varchar(10) = '0'
  	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0021',
		@QUYEN=@IS_VIEW OUTPUT
		PRINT(@IS_VIEW)
	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT,a.*,b.TrangThai
	FROM KeHoachMuaSam a 
	LEFT JOIN dbo.Duyet b ON b.DuyetId = a.DuyetId
	LEFT JOIN NhanVien nv ON nv.NhanVienId = a.NguoiTao
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=a.NguoiTao
	where a.Nam = '''+@Nam+''' ';

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (Nam LIKE N''%' +@Search+ '%'' OR NoiDung LIKE  N''%' +@Search+ '%'')';


		IF @IS_VIEW = 'VB' 
	BEGIN			 
			SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';	  
	END
	  IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @NhanVienId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	END
	 IF @IS_VIEW = 'VE' 
	BEGIN			 
			SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @NhanVienId + '''';	  
	END
	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KeHoachMuaSam_ReportKeHoachMuaSamById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KeHoachMuaSam_ReportKeHoachMuaSamById]
( 
	  @MuaSamId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT ms.Nam,ms.NoiDung,a.TenTaiSan,a.LoaiId,b.TenLoai,CAST(c.PhuongThucId AS VARCHAR) PhuongThucId, 
	c.TenPhuongThuc,a.DonViTinh,a.MoTa,Convert(varchar(10),CONVERT(date,a.Ngay,106),103) AS Ngay,a.SoLuong,a.DonGia,CAST(d.HinhThucId AS VARCHAR) HinhThucId,
	d.TenHinhThuc,a.DuToan,a.GhiChu,a.DuyetId,cs.MaCoSo,cs.TenCoSo  
	from KeHoachMuaSam ms inner join KeHoachMuaSamChiTiet  a on ms.MuaSamId=a.MuaSamId
	left join LoaiTaiSan b on a.LoaiId=b.LoaiId left join PhuongThuc c on a.PhuongThucId=c.PhuongThucId 
	left join HinhThuc d on a.HinhThucId=d.HinhThucId
	left join CoSo cs on ms.CoSoId=cs.CoSoId
	where ms.MuaSamId= @MuaSamId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KeHoachMuaSamChiTiet_DeleteKeHoachMuaSamChiTietById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROC [dbo].[sp_KeHoachMuaSamChiTiet_DeleteKeHoachMuaSamChiTietById]
( 
	  @MuaSamId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	Delete KeHoachMuaSamChiTiet where MuaSamId = @MuaSamId
	select @@ROWCOUNT
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KeHoachMuaSamChiTiet_GetKeHoachMuaSamChiTietByMuaSamId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KeHoachMuaSamChiTiet_GetKeHoachMuaSamChiTietByMuaSamId]
( 
	  @MuaSamId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.MuaSamId,a.MuaSamChiTietId,a.TenTaiSan,a.LoaiId,b.TenLoai,CAST(c.PhuongThucId AS VARCHAR) PhuongThucId, c.TenPhuongThuc,a.DonViTinh,a.MoTa,Convert(varchar(10),CONVERT(date,a.Ngay,106),103) AS Ngay,a.SoLuong,a.DonGia,CAST(d.HinhThucId AS VARCHAR) HinhThucId,d.TenHinhThuc,a.DuToan,a.GhiChu,a.MoTa,a.DuyetId  from KeHoachMuaSamChiTiet  a 
	left join LoaiTaiSan b on a.LoaiId=b.LoaiId left join PhuongThuc c on a.PhuongThucId=c.PhuongThucId left join HinhThuc d on a.HinhThucId=d.HinhThucId
	where MuaSamId= @MuaSamId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KhachHang_cbxKhachHangByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KhachHang_cbxKhachHangByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.KhachHangId,a.MaKhachHang,a.TenKhachHang
	FROM KhachHang a LEFT JOIN [QLTS_MAIN].[dbo].[NguoiDung] b on a.NguoiTao=b.NhanVienId 
	Where a.CoSoId = @CoSoId

	

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KhachHang_cbxKhachHangById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KhachHang_cbxKhachHangById]
( 
	  @CoSoId	        nvarchar(500)	= null				
	, @NhanVienId	    nvarchar(500)	= null				
	, @Search			nvarchar(500)   = null	
	, @KhachHangId		INT   = 0	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	IF(@KhachHangId IS NULL OR @KhachHangId = '') SET @KhachHangId = 0

	SELECT a.KhachHangId,a.MaKhachHang,a.TenKhachHang
	FROM KhachHang a
	Where a.CoSoId = @CoSoId
	AND (@KhachHangId = 0 OR a.KhachHangId = @KhachHangId)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KhachHang_GetListKhachHangByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KhachHang_GetListKhachHangByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @KhachHangId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------

	DECLARE @IS_VIEW varchar(10) = '0'
   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
  @NHAN_VIEN_ID = '0',
  @CO_SO_ID = @CoSoId,
  @CHUC_NANG = 'CN0010',
  @QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.KhachHangId,a.MaKhachHang,a.TenKhachHang,a.DienThoai,a.DiaChi,a.GhiChu,b.TenNhanVien as HoTen,a.NgayTao
	FROM KhachHang a LEFT JOIN NhanVien b on a.NguoiTao=b.NhanVienId where 1=1 and a.CoSoId =''' + @CoSoId + '''' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (MaKhachHang LIKE N''%' +@Search+ '%'' OR TenKhachHang LIKE  N''%' +@Search+ '%'')';



	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KhaiThac_DeleteKhaiThacById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_KhaiThac_DeleteKhaiThacById]
	@KhaiThacId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	
	BEGIN TRAN
		
		BEGIN TRY
			
			DELETE dbo.KhaiThac WHERE KhaiThacId = @KhaiThacId
			
			SELECT @@ROWCOUNT ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhaiThac_GetListKhaiThacByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_KhaiThac_GetListKhaiThacByCriteria]
( 
	  @CoSoId	        NVARCHAR(10)	
	, @SoChungTu	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null		
	, @LoginId			NVARCHAR(10)
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000),@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@LoginId,@NAM=@Nam OUTPUT; 



	SET @Search = ISNULL(@Search, '')
	IF @Search <> ''
	BEGIN	
		SET @Search = N'%' + @Search + '%'
		SET @Search = CAST(@Search AS VARCHAR(max))	
	END	
	----------


	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @LoginId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0034',
		@QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------
    

---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria

	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, H.KhaiThacId, H.TaiSanId, TS.MaTaiSan, TS.TenTaiSan, TS.DonViTinh, H.KhachHangNCCId, TenKhachHang, H.SoChungTu,
			H.SoLuongKhaiThac, H.DonGiaKhaiThac, H.ThoiGianBatDau, H.ThoiGianKetThuc, H.SoLuongKhaiThac * H.DonGiaKhaiThac TongSoTien, H.TienThu, H.NopNganSach, H.DonVi, H.GhiChu, H.NguoiTao, nv.TenNhanVien TenNguoiTao, H.NgayTao,
			PB.TenPhongBan, SoHopDong, H.HopDongId
	FROM dbo.KhaiThac H
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = H.NguoiTao 
	LEFT JOIN dbo.KhachHang KH ON KH.KhachHangId = H.KhachHangNCCId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = H.TaiSanId	
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = H.PhongBanId
	left join HopDong hd on hd.HopDongId = H.HopDongId
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=h.NguoiTao
	WHERE 1 = 1 and CAST(H.NgayTao AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) and YEAR(H.ThoiGianBatDau)='''+@Nam+'''' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.GhiChu LIKE N''%' +@Search+ '%'')';
	END

	IF (@SoChungTu > '')
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.SoChungTu LIKE N''%' +@SoChungTu+ '%'') ';
	END

	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and H.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @LoginId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @LoginId + '''';   
	END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY  H.NgayTao desc,' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KhaiThac_GetListKhaiThacById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_KhaiThac_GetListKhaiThacById]
( 
	@KhaiThacId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT	H.KhaiThacId, H.TaiSanId,H.PhongBanId,H.NhanVienId NhanVienIdKT, TS.TenTaiSan, TS.DonViTinh, 
			H.KhachHangNCCId, TenKhachHang, H.SoChungTu, H.SoLuongKhaiThac, H.DonGiaKhaiThac, 
			CONVERT(VARCHAR,H.ThoiGianBatDau,103)ThoiGianBatDau, CONVERT(VARCHAR,H.ThoiGianKetThuc,103)ThoiGianKetThuc, H.TienThu, H.NopNganSach, H.DonVi, H.GhiChu, 
			H.NguoiTao, nv.TenNhanVien TenNguoiTao, H.NgayTao, H.CtrVersion, HD.SoHopDong, H.HopDongId
	FROM dbo.KhaiThac H
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = H.NguoiTao 
	LEFT JOIN dbo.KhachHang KH ON KH.KhachHangId = H.KhachHangNCCId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = H.TaiSanId	
	LEFT JOIN dbo.HopDong HD ON HD.HopDongId = H.HopDongId
	WHERE H.KhaiThacId = @KhaiThacId

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhaiThac_InsertKhaiThac]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_KhaiThac_InsertKhaiThac]
	@TaiSanId INT
	,@PhongBanId INT
	,@NhanVienIdKT INT
	,@KhachHangNCCId INT
	,@SoChungTu NVARCHAR(50)
	,@SoLuongKhaiThac NUMERIC(18,4)
	,@DonGiaKhaiThac NUMERIC(18,4)
	,@ThoiGianBatDau datetime
	,@ThoiGianKetThuc datetime
	,@TienThu NUMERIC(18,4)
	,@NopNganSach NUMERIC(18,4)
	,@DonVi NUMERIC(18,4)
	,@GhiChu NVARCHAR(max)
	,@CoSoId INT
	,@NhanVienId INT
	,@HopDongId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	
	BEGIN TRAN
		
		BEGIN TRY
			INSERT dbo.KhaiThac
			        ( TaiSanId ,					KhachHangNCCId ,			SoChungTu ,					
					  SoLuongKhaiThac ,				DonGiaKhaiThac ,			ThoiGianBatDau ,
					  ThoiGianKetThuc ,				TienThu ,					NopNganSach ,			
					  DonVi ,						GhiChu ,					CoSoId ,			
					  NguoiTao ,					NgayTao ,					CtrVersion,
					  PhongBanId,					NhanVienId,					HopDongId
			        )
			SELECT @TaiSanId						,@KhachHangNCCId			,@SoChungTu
					,@SoLuongKhaiThac				,@DonGiaKhaiThac			,@ThoiGianBatDau
					,@ThoiGianKetThuc				,@TienThu					,@NopNganSach
					,@DonVi							,@GhiChu					,@CoSoId
					,@NhanVienId					,GETDATE()					,1
					,@PhongBanId					,@NhanVienIdKT				,@HopDongId
			
			SELECT SCOPE_IDENTITY() AS KhaiThacIdI

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhaiThac_UpdateKhaiThac]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_KhaiThac_UpdateKhaiThac]
	@KhaiThacId INT
	,@TaiSanId INT
	,@PhongBanId INT
	,@NhanVienIdKT INT
	,@KhachHangNCCId INT
	,@SoChungTu NVARCHAR(50)
	,@SoLuongKhaiThac NUMERIC(18,4)
	,@DonGiaKhaiThac NUMERIC(18,4)
	,@ThoiGianBatDau datetime
	,@ThoiGianKetThuc datetime
	,@TienThu NUMERIC(18,4)
	,@NopNganSach NUMERIC(18,4)
	,@DonVi NUMERIC(18,4)
	,@GhiChu NVARCHAR(max)
	,@CoSoId INT
	,@NhanVienId INT
	,@CtrVersion INT
	,@HopDongId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	IF EXISTS (SELECT 1 FROM dbo.KhaiThac WHERE KhaiThacId = @KhaiThacId AND CtrVersion <> @CtrVersion)
	BEGIN
		SELECT -1 AS ID
		RETURN
	END

	BEGIN TRAN
		
		BEGIN TRY
			
			UPDATE dbo.KhaiThac
			SET TaiSanId = @TaiSanId,
				PhongBanId = @PhongBanId,
				NhanVienId = @NhanVienIdKT,
				KhachHangNCCId = @KhachHangNCCId,
				SoLuongKhaiThac = @SoLuongKhaiThac,
				DonGiaKhaiThac = @DonGiaKhaiThac,
				ThoiGianBatDau = @ThoiGianBatDau,
				ThoiGianKetThuc = @ThoiGianKetThuc,
				TienThu = @TienThu,
				NopNganSach = @NopNganSach,
				DonVi = @DonVi,
				GhiChu = @GhiChu,
				HopDongId = @HopDongId,
				CtrVersion = CtrVersion + 1
			WHERE KhaiThacId = @KhaiThacId
			
			SELECT @@ROWCOUNT AS ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoaSoLieu_CheckKhoaSoLieu]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_KhoaSoLieu_CheckKhoaSoLieu]
	@Nam			NVARCHAR(MAX)	=	NULL
	,@CoSoId			INT				=	NULL
AS  
BEGIN
SET NOCOUNT ON 
--------------------------------------------------
Select TrangThai from KhoaSoLieu where nam=@Nam and CoSoId=@CoSoId

--------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoaSoLieu_InsertKhoaSoLieu]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_KhoaSoLieu_InsertKhoaSoLieu]
	@Nam INT,
	@CoSoId NVARCHAR(10),
	@NhanVienId NVARCHAR(10)
as
BEGIN
	Declare @ErrMsg nvarchar(max),
			@V_NAMTRUOC INT,
			@V_CHOTNAM INT
	
	DECLARE @V_TB_THEODOI TABLE -- chứa các tài sản của năm cần phát sinh đã có sẵn
	(
		TaiSanId INT,
		PhongBanId INT,
		NhanVienId INT,
		Nam INT
	)
	-------------------------------------------------------------------------
	SET @V_NAMTRUOC = @Nam - 1

	SELECT @V_CHOTNAM = TrangThai FROM dbo.KhoaSoLieu WHERE Nam = @V_NAMTRUOC AND CoSoId = @CoSoId
	
	IF (@V_CHOTNAM = 1)
	BEGIN
		SELECT -1 AS ID RETURN
	END
    
	-------------------------------------------------------------------------

	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT @V_TB_THEODOI( TaiSanId ,PhongBanId ,NhanVienId ,Nam)
			SELECT TaiSanId, PhongBanId, NhanVienId, Nam
			FROM dbo.TheoDoi WHERE Nam = @Nam

			--SELECT *
			UPDATE TD
			SET TD.SLTon = VTD.TonDau
			FROM dbo.TheoDoi TD
			JOIN
			(
				SELECT ISNULL(TD.SLTon,0) + ISNULL(TD.SLTang,0) - ISNULL(TD.SLGiam,0) TonDau, TD.NhanVienId, TD.PhongBanId, TD.TaiSanId
				FROM @V_TB_THEODOI VTD
				JOIN dbo.TheoDoi TD ON VTD.NhanVienId = TD.NhanVienId AND VTD.PhongBanId = TD.PhongBanId AND VTD.TaiSanId = TD.TaiSanId
				WHERE TD.Nam = @V_NAMTRUOC
			) AS VTD ON VTD.NhanVienId = TD.NhanVienId AND VTD.PhongBanId = TD.PhongBanId AND VTD.TaiSanId = TD.TaiSanId
			WHERE TD.Nam = @Nam

			/*
			
			EXEC [dbo].[sp_KhoaSoLieu_InsertKhoaSoLieu] @Nam = 2018, -- int
														@CoSoId = N'1', -- nvarchar(10)
														@NhanVienId = N'10' -- nvarchar(10)


			*/

			INSERT dbo.TheoDoi
					( TaiSanId ,				NgayGhiTang ,			NgayTrangCap ,			
						NgayBatDauSuDung ,		PhongBanId ,			NhanVienId ,
						SLTon ,					SLTang ,				SLGiam		,		Nam
					)
			SELECT	TaiSanId,					NgayGhiTang,			NgayTrangCap,
					NgayBatDauSuDung,			PhongBanId,				NhanVienId,
					(SLTon + SLTang - SLGiam),	0,						0			,		@Nam
			FROM dbo.TheoDoi td
			WHERE Nam = @V_NAMTRUOC
			AND NOT EXISTS(
							SELECT 1 FROM @V_TB_THEODOI vtd WHERE td.NhanVienId = vtd.NhanVienId AND td.TaiSanId = vtd.TaiSanId AND td.PhongBanId = vtd.PhongBanId
						  )

			Update dbo.ThongSo set Ten = @Nam where ThongSoId=2 --and CoSoId=@CoSoId
			INSERT dbo.KhoaSoLieu( Nam, TrangThai, CoSoId )
			SELECT CAST(@V_NAMTRUOC AS NCHAR), 1, @CoSoId

			SELECT @@ROWCOUNT AS ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoaSoLieuThang_ChotSoLieuThang]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_KhoaSoLieuThang_ChotSoLieuThang]
	@ThangNam NVARCHAR(100),
	@CoSoId NVARCHAR(10),
	@NhanVienId NVARCHAR(10)
as
BEGIN
	SET DATEFORMAT YMD
	Declare @ErrMsg nvarchar(max), @V_ThangTruoc NVARCHAR(4), @V_ChotThang INT, @V_NgayThangNam DATETIME, @V_KhoTonKhoId INT

	DECLARE @V_TB_KhoTonKhoChiTiet TABLE -- chứa các tài sản của tháng cần phát sinh đã có sẵn
	(
		KhoTaiSanId INT,
		TaiSanId INT,
		DonGia NUMERIC(18, 4) 
	)

	DECLARE @V_TB_KhoTaiSan AS TABLE ( KhoTaiSanId int)

	------------------------------------------------------------------------------------------------------------------------------------
	SET @V_NgayThangNam = CONVERT(date,right(@ThangNam,2) +'-'+left(@ThangNam,2) + '-01')
	SET @V_ThangTruoc = FORMAT(DATEADD(m, -1, @V_NgayThangNam),'MMyy')	

	IF NOT EXISTS(SELECT KhoTonKhoId FROM dbo.KhoTonKho WHERE ThangNam = @V_ThangTruoc AND CoSoId = @CoSoId AND TrangThai = 0)
	BEGIN
		SELECT -1 AS ID RETURN -- chốt rồi
	END
    
	INSERT @V_TB_KhoTaiSan( KhoTaiSanId )
	SELECT H.KhoTaiSanId FROM dbo.KhoTonKho H WHERE H.ThangNam = @V_ThangTruoc AND H.CoSoId = @CoSoId AND H.TrangThai = 0 GROUP BY H.KhoTaiSanId
	------------------------------------------------------------------------------------------------------------------------------------

	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT @V_TB_KhoTonKhoChiTiet( KhoTaiSanId, TaiSanId, DonGia )
			SELECT H.KhoTaiSanId, L.TaiSanId, L.DonGia
			FROM dbo.KhoTonKho H 
			JOIN dbo.KhoTonKhoChiTiet L ON L.KhoTonKhoId = H.KhoTonKhoId WHERE H.ThangNam = @ThangNam AND H.CoSoId = @CoSoId AND H.TrangThai = 0

			--SELECT *
			UPDATE L
			SET L.TonDau = VTK.TonDau
			FROM dbo.KhoTonKho H 
			JOIN dbo.KhoTonKhoChiTiet L ON L.KhoTonKhoId = H.KhoTonKhoId 
			JOIN 
			(
				SELECT ISNULL(L.TonDau,0) + ISNULL(L.SLNhap,0) + ISNULL(L.SLXuat,0) TonDau, H.KhoTaiSanId, L.TaiSanId, L.DonGia
				FROM dbo.KhoTonKho H 
				JOIN dbo.KhoTonKhoChiTiet L ON L.KhoTonKhoId = H.KhoTonKhoId 
				JOIN @V_TB_KhoTonKhoChiTiet VTK ON VTK.KhoTaiSanId = H.KhoTaiSanId AND VTK.TaiSanId = L.TaiSanId AND VTK.DonGia = L.DonGia
				WHERE H.ThangNam = @V_ThangTruoc AND H.CoSoId = @CoSoId
			) AS VTK ON VTK.KhoTaiSanId = H.KhoTaiSanId AND VTK.TaiSanId = L.TaiSanId AND VTK.DonGia = L.DonGia
			WHERE H.ThangNam = @ThangNam AND H.CoSoId = @CoSoId AND H.TrangThai = 0				
			

			/*
			
			EXEC [dbo].[sp_KhoaSoLieu_InsertKhoaSoLieu] @ThangNam = 2018, -- int
														@CoSoId = N'1', -- nvarchar(10)
														@NhanVienId = N'10' -- nvarchar(10)


			*/

			DECLARE @V_KhoTaiSanId INT
			WHILE EXISTS(SELECT 1 FROM @V_TB_KhoTaiSan)
			BEGIN
				SELECT TOP 1 @V_KhoTaiSanId = KhoTaiSanId FROM @V_TB_KhoTaiSan
				---------------------------------------------------------------
				IF EXISTS(SELECT 1 FROM @V_TB_KhoTonKhoChiTiet WHERE KhoTaiSanId = @V_KhoTaiSanId)
				BEGIN
					SELECT @V_KhoTonKhoId = H.KhoTonKhoId FROM dbo.KhoTonKho H WHERE H.ThangNam = @ThangNam AND H.CoSoId = @CoSoId AND H.TrangThai = 0
				END
				ELSE
                BEGIN
					INSERT dbo.KhoTonKho
							( KhoTaiSanId ,		CoSoId ,		ThangNam ,
								TrangThai ,		NguoiTao ,		NgayTao ,		CtrVersion
							)
					SELECT	@V_KhoTaiSanId,		@CoSoId,		@ThangNam,
							0,					@NhanVienId,	GETDATE(),		1

					SELECT @V_KhoTonKhoId = SCOPE_IDENTITY()
				END		

				INSERT dbo.KhoTonKhoChiTiet
						(	KhoTonKhoId ,		TaiSanId ,		DonGia ,
							GiaMua ,			GiaBan ,		TonDau ,
							SLNhap ,			SLXuat ,		NguonNganSachId ,
							NhaCungCapId ,		HanDung ,		LoSanXuat
						)
				SELECT		@V_KhoTonKhoId ,	TaiSanId ,		DonGia ,
							L.GiaMua ,			L.GiaBan ,		(L.TonDau + L.SLNhap - L.SLXuat) ,
							0 ,					0 ,				L.NguonNganSachId ,
							L.NhaCungCapId ,	L.HanDung ,		L.LoSanXuat
				
				FROM dbo.KhoTonKho H 
				JOIN dbo.KhoTonKhoChiTiet L ON L.KhoTonKhoId = H.KhoTonKhoId 
				WHERE H.ThangNam = @V_ThangTruoc AND H.KhoTaiSanId = @V_KhoTaiSanId AND H.CoSoId = @CoSoId AND H.TrangThai = 0
				AND NOT EXISTS(
							SELECT 1 FROM @V_TB_KhoTonKhoChiTiet vtk WHERE vtk.KhoTaiSanId = @V_KhoTaiSanId AND vtk.TaiSanId = l.TaiSanId AND vtk.DonGia = L.DonGia
						  )
				---------------------------------------------------------------
				DELETE @V_TB_KhoTaiSan WHERE KhoTaiSanId= @V_KhoTaiSanId
				SELECT @V_KhoTaiSanId= NULL, @V_KhoTonKhoId = NULL
			END
			
			UPDATE dbo.KhoTonKho SET TrangThai = 1 WHERE ThangNam = @V_ThangTruoc AND CoSoId = @CoSoId

			Update dbo.ThongSo set Ten = @ThangNam where ThongSoId=1 --and CoSoId=@CoSoId
			--INSERT dbo.KhoaSoLieu( Nam, TrangThai, CoSoId )
			--SELECT CAST(@V_ThangTruoc AS NCHAR), 1, @CoSoId

			SELECT @@ROWCOUNT AS ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuNhap_DeleteKhoPhieuNhapById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_KhoPhieuNhap_DeleteKhoPhieuNhapById]
	@KhoPhieuNhapId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max), @V_ChotKho INT, @V_KhoTaiSanId INT, @V_CoSoId INT, @V_NgayNhap DATETIME, @V_KhoTonKhoId INT
	DECLARE @V_TaiSanId INT, @V_SoLuong numeric (18, 4), @V_DonGia numeric (18, 4), @V_GiaMua numeric (18, 4), @V_GiaBan numeric (18, 4), @V_HanDung varchar (10), @V_LoSanXuat varchar (10), @V_RowId INT
	DECLARE @V_KhoPhieuNhapChiTiet_Rollback TABLE
	(
		RowId int IDENTITY(1, 1),
		KhoPhieuNhapId INT,
		TaiSanId int,
		SoLuong numeric (18, 4) ,
		DonGia numeric (18, 4) ,
		GiaMua numeric (18, 4) ,
		GiaBan numeric (18, 4) ,
		VAT numeric (4, 2) ,
		HanDung varchar (10),
		LoSanXuat varchar (10)
	)
	------------------------------------------------------------------------------------------------------------------------------------

	SELECT @V_KhoTaiSanId = KhoTaiSanId, @V_CoSoId= CoSoId, @V_NgayNhap=NgayNhap FROM dbo.KhoPhieuNhap WHERE KhoPhieuNhapId = @KhoPhieuNhapId
	SELECT @V_ChotKho = TrangThai FROM dbo.KhoTonKho WHERE KhoTaiSanId = @V_KhoTaiSanId AND CoSoId = @V_CoSoId AND ThangNam = (FORMAT(@V_NgayNhap,'MMyy'))

	IF (@V_ChotKho = 1)
	BEGIN
		SELECT -1 AS ID RETURN
	END

	INSERT @V_KhoPhieuNhapChiTiet_Rollback
	        ( KhoPhieuNhapId ,			TaiSanId ,				SoLuong ,
	          DonGia ,					GiaMua ,				GiaBan ,
	          VAT ,						HanDung ,				LoSanXuat
	        )
	SELECT	  KhoPhieuNhapId ,			TaiSanId ,				SoLuong ,
	          DonGia ,					GiaMua ,				GiaBan ,
	          VAT ,						HanDung ,				LoSanXuat
	FROM dbo.KhoPhieuNhapChiTiet WHERE KhoPhieuNhapId = @KhoPhieuNhapId 
	------------------------------------------------------------------------------------------------------------------------------------
	BEGIN TRAN
		
		BEGIN TRY
			
			SELECT @V_KhoTonKhoId = KhoTonKhoId FROM dbo.KhoTonKho WHERE KhoTaiSanId = @V_KhoTaiSanId AND CoSoId = @V_CoSoId AND ThangNam = FORMAT(@V_NgayNhap,'MMyy')

			WHILE EXISTS(SELECT 1 FROM @V_KhoPhieuNhapChiTiet_Rollback)
			BEGIN
				SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia, @V_GiaMua = GiaMua, @V_GiaBan = GiaBan, @V_HanDung = HanDung, @V_LoSanXuat = LoSanXuat FROM @V_KhoPhieuNhapChiTiet_Rollback

				IF EXISTS(SELECT 1 FROM dbo.KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia)
				BEGIN
					UPDATE dbo.KhoTonKhoChiTiet SET SLNhap = SLNhap - @V_SoLuong WHERE KhoTonKhoId = @V_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia

					IF (SELECT TonDau + SLNhap - SLXuat FROM dbo.KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia) < 0
					BEGIN	
						begin try rollback tran end try begin catch end CATCH
						SELECT -2 AS ID
						RETURN
					END
				END
				
				DELETE @V_KhoPhieuNhapChiTiet_Rollback WHERE RowId= @V_RowId
				SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_GiaMua=NULL,@V_GiaBan=NULL,@V_HanDung=NULL,@V_LoSanXuat=NULL,@V_SoLuong=NULL
			END


			-- delete
			DELETE dbo.KhoPhieuNhapChiTiet WHERE KhoPhieuNhapId = @KhoPhieuNhapId
			DELETE dbo.KhoPhieuNhap WHERE KhoPhieuNhapId = @KhoPhieuNhapId			
			
			SELECT @@ROWCOUNT

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuNhap_GetListKhoPhieuNhapByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_KhoPhieuNhap_GetListKhoPhieuNhapByCriteria]
( 
	  @CoSoId	        NVARCHAR(10)		
	, @Search			nvarchar(500)   = null	
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null		
	, @SoPhieu			NVARCHAR(50)	= null		
	, @KhoTaiSanId		NVARCHAR(max)
	, @LoginId			NVARCHAR(10)
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) ,@ThangNam	VARCHAR(MAX)	=	NULL
			--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSoTaiSanLauBen @LOAITHONGSO='SoLieuThangNam',@NHANVIEN=@LoginId,@ThangNam=@ThangNam OUTPUT; 

	SET @Search = ISNULL(@Search, '')
	----------

	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @LoginId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0044',
		@QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

	IF OBJECT_ID('tempdb..#V_TB_LOAI') IS NOT NULL
		DROP TABLE #V_TB_LOAI
	CREATE TABLE #V_TB_LOAI
	(
		 _id NVARCHAR(10),
		 _name NVARCHAR(100)
	)

	insert #V_TB_LOAI
	select '1',N'Nhập mới'	union
	select '2',N'Hoàn trả'

---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria


	SET @V_SQL = N'
		SELECT COUNT(*) OVER () AS MAXCNT, 
		   H.KhoPhieuNhapId, H.KhoTaiSanId, KTS.TenKhoTaiSan, H.NguonNganSachId, NNS.TenNguonNganSach, 
		   H.NhaCungCapId, NCC.TenNhaCungCap, H.NgayNhap, H.SoPhieu, H.Seri, SoHoaDon, H.NgayHD, H.BBKiem, H.ChietKhau,
		   H.NguoiGiao, H.Loai, LNK._name TenLoai, H.TaiKhoanNo, H.TaiKhoanCo,H.NoiDung, H.CoSoId, H.NguoiTao, NV.TenNhanVien TenNguoiTao,
		   H.NgayTao,H.CtrVersion
	FROM dbo.KhoPhieuNhap H
	LEFT JOIN dbo.KhoTaiSan KTS ON KTS.KhoTaiSanId = H.KhoTaiSanId
	LEFT JOIN dbo.NguonNganSach NNS ON NNS.NguonNganSachId = H.NguonNganSachId
	LEFT JOIN dbo.NhaCungCap NCC ON NCC.NhaCungCapId = H.NhaCungCapId
	LEFT JOIN dbo.NhanVien NV ON NV.NhanVienId = H.NguoiTao
	LEFT JOIN #V_TB_LOAI LNK ON LNK._id = H.Loai
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=h.NguoiTao
	WHERE CAST(H.NgayNhap AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) and FORMAT( H.NgayNhap, ''MMyy'')='''+@ThangNam+''''; 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.NoiDung LIKE N''%' +@Search+ '%'')';
	END

	IF (@SoPhieu > '')
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.SoPhieu LIKE N''%' +@SoPhieu+ '%'') ';
	END

	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and H.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @LoginId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @LoginId + '''';   
	END
		

	--SET @V_SQL = @V_SQL + ' GROUP BY H.GhiTangId, H.SoChungTu, H.NgayChungTu, H.NgayGhiTang, H.NoiDung,
	--						h.DuyetId, H.NguoiDuyet, H.CoSoId, H.NguoiTao, H.NgayTao,ndd.HoTen,nd.HoTen ';

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuNhap_GetListKhoPhieuNhapById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_KhoPhieuNhap_GetListKhoPhieuNhapById]
( 
	@KhoPhieuNhapId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT H.KhoPhieuNhapId, H.KhoTaiSanId, KTS.TenKhoTaiSan,H.NguonNganSachId, NNS.TenNguonNganSach, 
		   H.NhaCungCapId, NCC.TenNhaCungCap, CONVERT(VARCHAR, H.NgayNhap, 103)NgayNhap, H.SoPhieu, H.Seri, SoHoaDon, CONVERT(VARCHAR, H.NgayHD, 103)NgayHD, H.BBKiem, H.ChietKhau,
		   H.NguoiGiao, H.Loai, H.TaiKhoanNo, H.TaiKhoanCo,H.NoiDung, H.CoSoId, H.NguoiTao, NV.TenNhanVien TenNguoiTao,
		   H.NgayTao,H.CtrVersion
	FROM dbo.KhoPhieuNhap H
	LEFT JOIN dbo.KhoTaiSan KTS ON KTS.KhoTaiSanId = H.KhoTaiSanId
	LEFT JOIN dbo.NguonNganSach NNS ON NNS.NguonNganSachId = H.NguonNganSachId
	LEFT JOIN dbo.NhaCungCap NCC ON NCC.NhaCungCapId = H.NhaCungCapId
	LEFT JOIN dbo.NhanVien NV ON NV.NhanVienId = H.NguoiTao
	WHERE H.KhoPhieuNhapId = @KhoPhieuNhapId

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuNhap_GetListReportKhoPhieuNhapById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_KhoPhieuNhap_GetListReportKhoPhieuNhapById]
( 
	@KhoPhieuNhapId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	DECLARE @ThanhTienChuaVAT NUMERIC(18,4)
	SELECT @ThanhTienChuaVAT = SUM(L.SoLuong * L.DonGia)
	FROM dbo.KhoPhieuNhapChiTiet L WHERE L.KhoPhieuNhapId = @KhoPhieuNhapId

	SELECT CS.MaCoSo, CS.TenCoSo, CS.DiaChi DiaChiCoSo,
		   KTS.TenKhoTaiSan, NNS.TenNguonNganSach, NCC.TenNhaCungCap, NCC.MaSoThue MaSoThueNCC, NCC.DiaChi DiaChiNCC,
		   H.NgayNhap, H.SoPhieu, H.Seri, SoHoaDon,H.NgayHD , H.BBKiem, H.ChietKhau,
		   H.NguoiGiao, H.Loai, H.TaiKhoanNo, H.TaiKhoanCo,H.NoiDung,

		   TS.MaTaiSan, TS.TenTaiSan, TS.DonViTinh, L.SoLuong, L.DonGia, L.VAT, L.DonGia * L.SoLuong ThanhTienChuaVAT,
		   dbo.Num2Text(@ThanhTienChuaVAT) DocSo
	FROM dbo.KhoPhieuNhap H
	JOIN dbo.KhoPhieuNhapChiTiet L ON L.KhoPhieuNhapId = H.KhoPhieuNhapId
	LEFT JOIN dbo.KhoTaiSan KTS ON KTS.KhoTaiSanId = H.KhoTaiSanId
	LEFT JOIN dbo.NguonNganSach NNS ON NNS.NguonNganSachId = H.NguonNganSachId
	LEFT JOIN dbo.NhaCungCap NCC ON NCC.NhaCungCapId = H.NhaCungCapId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = L.TaiSanId
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
	WHERE H.KhoPhieuNhapId = @KhoPhieuNhapId

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuNhap_InsertKhoPhieuNhap]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- drop proc [sp_KhoPhieuNhap_InsertKhoPhieuNhap]
CREATE proc [dbo].[sp_KhoPhieuNhap_InsertKhoPhieuNhap]
	@KhoTaiSanId int,
	@NguonNganSachId int,
	@NhaCungCapId int,
	@NgayNhap datetime,
	@SoPhieu varchar (50),
	@Seri varchar (50),
	@SoHoaDon varchar (50),
	@NgayHD datetime,
	@BBKiem varchar (50),
	@ChietKhau int ,
	@NguoiGiao nvarchar (100),
	@Loai varchar (10),
	@TaiKhoanNo varchar (20),
	@TaiKhoanCo varchar (20),
	@NoiDung nvarchar (500),
	@CoSoId int ,
	@NguoiTao int ,
    @MyTable_KhoPhieuNhapChiTiet MyTableType_KhoPhieuNhapChiTiet READONLY
as
BEGIN
	
	Declare @ErrMsg nvarchar(max), @V_KhoPhieuNhapId INT, @V_ChotKho INT, @V_KhoTonKhoId INT

	DECLARE @V_TaiSanId INT, @V_SoLuong numeric (18, 4), @V_DonGia numeric (18, 4), @V_GiaMua numeric (18, 4),
			@V_GiaBan numeric (18, 4), @V_HanDung varchar (10), @V_LoSanXuat varchar (10), @V_RowId INT

	DECLARE @V_KhoPhieuNhapChiTiet TABLE
	(
		RowId int IDENTITY(1, 1),
		KhoPhieuNhapId INT,
		TaiSanId int,
		SoLuong numeric (18, 4) ,
		DonGia numeric (18, 4) ,
		GiaMua numeric (18, 4) ,
		GiaBan numeric (18, 4) ,
		VAT numeric (4, 2) ,
		HanDung varchar (10),
		LoSanXuat varchar (10)
	)
	------------------------------------------------------------------------------------------------------------------------

	SET @V_KhoPhieuNhapId = 0

	SELECT @V_ChotKho = TrangThai FROM dbo.KhoTonKho WHERE KhoTaiSanId = @KhoTaiSanId AND CoSoId = @CoSoId AND ThangNam = (FORMAT(@NgayNhap,'MMyy'))

	IF (@V_ChotKho = 1)
	BEGIN
		SELECT -1 AS KhoPhieuNhapIdI RETURN
	END

	INSERT @V_KhoPhieuNhapChiTiet
	        ( KhoPhieuNhapId ,			TaiSanId ,				SoLuong ,
	          DonGia ,					GiaMua ,				GiaBan ,
	          VAT ,						HanDung ,				LoSanXuat
	        )
	SELECT	  KhoPhieuNhapId ,			TaiSanId ,				SoLuong ,
	          DonGia ,					GiaMua ,				GiaBan ,
	          VAT ,						HanDung ,				LoSanXuat
	FROM @MyTable_KhoPhieuNhapChiTiet
	------------------------------------------------------------------------------------------------------------------------
	BEGIN TRAN		
		BEGIN TRY
				
			-- insert header
			INSERT dbo.KhoPhieuNhap
			        ( KhoTaiSanId ,			NguonNganSachId ,			NhaCungCapId ,
			          NgayNhap ,			SoPhieu ,					Seri ,
			          SoHoaDon ,			NgayHD ,					BBKiem ,
			          ChietKhau ,			NguoiGiao ,					Loai ,
			          TaiKhoanNo ,			TaiKhoanCo ,				NoiDung ,
			          CoSoId ,				NguoiTao ,					NgayTao ,
			          CtrVersion
			        )
			SELECT	@KhoTaiSanId ,			@NguonNganSachId ,			@NhaCungCapId ,
			        @NgayNhap ,				@SoPhieu ,					@Seri ,
			        @SoHoaDon ,				@NgayHD ,					@BBKiem ,
			        @ChietKhau ,			@NguoiGiao ,				@Loai ,
			        @TaiKhoanNo ,			@TaiKhoanCo ,				@NoiDung ,
			        @CoSoId ,				@NguoiTao ,					GETDATE() ,
			        1
			

			SELECT @V_KhoPhieuNhapId = SCOPE_IDENTITY()
			SELECT @V_KhoPhieuNhapId AS KhoPhieuNhapIdI

			--- insert line
			INSERT dbo.KhoPhieuNhapChiTiet
			        ( KhoPhieuNhapId ,			TaiSanId ,			SoLuong ,
			          DonGia ,					GiaMua ,			GiaBan ,
			          VAT ,						HanDung ,			LoSanXuat
			        )
			SELECT @V_KhoPhieuNhapId ,			TaiSanId ,			SoLuong ,
					DonGia ,					GiaMua ,			GiaBan ,
					VAT ,						HanDung ,			LoSanXuat
			FROM @MyTable_KhoPhieuNhapChiTiet

			--- kho ton kho
			SELECT @V_KhoTonKhoId = KhoTonKhoId FROM dbo.KhoTonKho WHERE KhoTaiSanId = @KhoTaiSanId AND CoSoId = @CoSoId AND ThangNam = FORMAT(@NgayNhap,'MMyy')

			IF (@V_KhoTonKhoId IS NOT NULL AND @V_KhoTonKhoId > 0)
			BEGIN
				WHILE EXISTS(SELECT 1 FROM @V_KhoPhieuNhapChiTiet)
				BEGIN
					SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia, @V_GiaMua = GiaMua, @V_GiaBan = GiaBan, @V_HanDung = HanDung, @V_LoSanXuat = LoSanXuat FROM @V_KhoPhieuNhapChiTiet
					IF EXISTS(SELECT 1 FROM dbo.KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia)
					BEGIN
						UPDATE dbo.KhoTonKhoChiTiet SET SLNhap = SLNhap + @V_SoLuong WHERE KhoTonKhoId = @V_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
					END
					ELSE
                    BEGIN
						INSERT dbo.KhoTonKhoChiTiet
						        ( KhoTonKhoId ,		TaiSanId ,		DonGia ,
						          GiaMua ,			GiaBan ,		TonDau ,
						          SLNhap ,			SLXuat ,		NguonNganSachId ,
						          NhaCungCapId ,	HanDung ,		LoSanXuat
						        )
						SELECT	@V_KhoTonKhoId,		@V_TaiSanId,	@V_DonGia,
								0,					0,				0,
								@V_SoLuong,			0,				@NguonNganSachId,
								@NhaCungCapId,		NULL,			NULL
						
					END

					DELETE @V_KhoPhieuNhapChiTiet WHERE RowId= @V_RowId
					SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_GiaMua=NULL,@V_GiaBan=NULL,@V_HanDung=NULL,@V_LoSanXuat=NULL,@V_SoLuong=NULL
				END
			END
			ELSE
			BEGIN
				INSERT dbo.KhoTonKho
				        ( KhoTaiSanId ,		CoSoId ,		ThangNam ,
				          TrangThai ,		NguoiTao ,		NgayTao ,		CtrVersion
				        )
				SELECT	@KhoTaiSanId,		@CoSoId,		FORMAT(@NgayNhap,'MMyy'),
						0,					@NguoiTao,		GETDATE(),		1

				SELECT @V_KhoTonKhoId = SCOPE_IDENTITY()
				
				INSERT dbo.KhoTonKhoChiTiet
						(	KhoTonKhoId ,		TaiSanId ,		DonGia ,
							GiaMua ,			GiaBan ,		TonDau ,
							SLNhap ,			SLXuat ,		NguonNganSachId ,
							NhaCungCapId ,		HanDung ,		LoSanXuat
						)
				SELECT		@V_KhoTonKhoId ,	TaiSanId ,		DonGia ,
							0 ,					0 ,				0 ,
							SUM(SoLuong) ,		0 ,				@NguonNganSachId ,
							@NhaCungCapId ,		NULL ,			NULL
				FROM @MyTable_KhoPhieuNhapChiTiet
				GROUP BY TaiSanId, DonGia

			END
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuNhap_UpdateKhoPhieuNhapById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- drop proc [sp_KhoPhieuNhap_UpdateKhoPhieuNhapById]
CREATE proc [dbo].[sp_KhoPhieuNhap_UpdateKhoPhieuNhapById]
	@KhoPhieuNhapId int ,
	@KhoTaiSanId int,
	@NguonNganSachId int,
	@NhaCungCapId int,
	@NgayNhap datetime,
	@SoPhieu varchar (50),
	@Seri varchar (50),
	@SoHoaDon varchar (50),
	@NgayHD datetime,
	@BBKiem varchar (50),
	@ChietKhau int ,
	@NguoiGiao nvarchar (100),
	@Loai varchar (10),
	@TaiKhoanNo varchar (20),
	@TaiKhoanCo varchar (20),
	@NoiDung nvarchar (500),
	@CoSoId int ,
	@NguoiTao int ,
    @MyTable_KhoPhieuNhapChiTiet MyTableType_KhoPhieuNhapChiTiet READONLY
as
BEGIN
	Declare @ErrMsg nvarchar(max), @V_ChotKho INT, @V_KhoTonKhoId INT
	DECLARE @V_TaiSanId INT, @V_SoLuong numeric (18, 4), @V_DonGia numeric (18, 4), @V_GiaMua numeric (18, 4), @V_GiaBan numeric (18, 4), @V_HanDung varchar (10), @V_LoSanXuat varchar (10), @V_RowId INT
	DECLARE @V_KhoPhieuNhapChiTiet_Rollback TABLE
	(
		RowId int IDENTITY(1, 1),
		KhoPhieuNhapId INT,
		TaiSanId int,
		SoLuong numeric (18, 4) ,
		DonGia numeric (18, 4) ,
		GiaMua numeric (18, 4) ,
		GiaBan numeric (18, 4) ,
		VAT numeric (4, 2) ,
		HanDung varchar (10),
		LoSanXuat varchar (10)
	)
	----------------------------------------------------------------------------------------------------------------------------------------------------
	SELECT @V_ChotKho = TrangThai FROM dbo.KhoTonKho WHERE KhoTaiSanId = @KhoTaiSanId AND CoSoId = @CoSoId AND ThangNam = (FORMAT(@NgayNhap,'MMyy'))

	IF (@V_ChotKho = 1)
	BEGIN
		SELECT -1 AS ID RETURN
	END

	INSERT @V_KhoPhieuNhapChiTiet_Rollback --- dùng cho rollback + cập nhật lại khotonkho
	        ( KhoPhieuNhapId ,			TaiSanId ,				SoLuong ,
	          DonGia ,					GiaMua ,				GiaBan ,
	          VAT ,						HanDung ,				LoSanXuat
	        )
	SELECT	  KhoPhieuNhapId ,			TaiSanId ,				SoLuong ,
	          DonGia ,					GiaMua ,				GiaBan ,
	          VAT ,						HanDung ,				LoSanXuat
	FROM dbo.KhoPhieuNhapChiTiet WHERE KhoPhieuNhapId = @KhoPhieuNhapId 
	----------------------------------------------------------------------------------------------------------------------------------------------------
	BEGIN TRAN
		
		BEGIN TRY


			UPDATE dbo.KhoPhieuNhap
			SET KhoTaiSanId = @KhoTaiSanId,
				NguonNganSachId = @NguonNganSachId,
				NhaCungCapId = @NhaCungCapId,
				NgayNhap = @NgayNhap,
				--SoPhieu = @SoPhieu,
				--Seri = @Seri,
				SoHoaDon = @SoHoaDon,
				NgayHD = @NgayHD,
				BBKiem = @BBKiem,
				ChietKhau = @ChietKhau,
				NguoiGiao = @NguoiGiao,
				Loai = @Loai,
				TaiKhoanNo = @TaiKhoanNo,
				TaiKhoanCo = @TaiKhoanCo,
				NoiDung = @NoiDung,
				CtrVersion = CtrVersion + 1
			WHERE KhoPhieuNhapId = @KhoPhieuNhapId
			
			--- cập nhật lại kho tồn kho - rollback
			SELECT @V_KhoTonKhoId = KhoTonKhoId FROM dbo.KhoTonKho WHERE KhoTaiSanId = @KhoTaiSanId AND CoSoId = @CoSoId AND ThangNam = FORMAT(@NgayNhap,'MMyy')

			WHILE EXISTS(SELECT 1 FROM @V_KhoPhieuNhapChiTiet_Rollback)
			BEGIN
				SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia, @V_GiaMua = GiaMua, @V_GiaBan = GiaBan, @V_HanDung = HanDung, @V_LoSanXuat = LoSanXuat FROM @V_KhoPhieuNhapChiTiet_Rollback

				IF EXISTS(SELECT 1 FROM dbo.KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia)
				BEGIN
					UPDATE dbo.KhoTonKhoChiTiet SET SLNhap = SLNhap - @V_SoLuong WHERE KhoTonKhoId = @V_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia

					IF (SELECT TonDau + SLNhap - SLXuat FROM dbo.KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia) < 0
					BEGIN	
						begin try rollback tran end try begin catch end CATCH
						SELECT -2 AS ID
						RETURN
					END
				END
				
				DELETE @V_KhoPhieuNhapChiTiet_Rollback WHERE RowId= @V_RowId
				SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_GiaMua=NULL,@V_GiaBan=NULL,@V_HanDung=NULL,@V_LoSanXuat=NULL,@V_SoLuong=NULL
			END

			--- delete chi tiết kho phiếu nhập
			DELETE dbo.KhoPhieuNhapChiTiet WHERE KhoPhieuNhapId = @KhoPhieuNhapId

			--- insert lại chi tiết kho phiếu nhập
			INSERT dbo.KhoPhieuNhapChiTiet
			        ( KhoPhieuNhapId ,			TaiSanId ,			SoLuong ,
			          DonGia ,					GiaMua ,			GiaBan ,
			          VAT ,						HanDung ,			LoSanXuat
			        )
			SELECT @KhoPhieuNhapId ,		TaiSanId ,			SoLuong ,
					DonGia ,				GiaMua ,			GiaBan ,
					VAT ,					HanDung ,			LoSanXuat
			FROM @MyTable_KhoPhieuNhapChiTiet

			--- cập nhật vào kho tồn kho
			SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_GiaMua=NULL,@V_GiaBan=NULL,@V_HanDung=NULL,@V_LoSanXuat=NULL,@V_SoLuong=NULL
			DELETE @V_KhoPhieuNhapChiTiet_Rollback
			INSERT @V_KhoPhieuNhapChiTiet_Rollback
					( KhoPhieuNhapId ,			TaiSanId ,				SoLuong ,
					  DonGia ,					GiaMua ,				GiaBan ,
					  VAT ,						HanDung ,				LoSanXuat
					)
			SELECT	  KhoPhieuNhapId ,			TaiSanId ,				SoLuong ,
					  DonGia ,					GiaMua ,				GiaBan ,
					  VAT ,						HanDung ,				LoSanXuat
			FROM @MyTable_KhoPhieuNhapChiTiet

			IF (@V_KhoTonKhoId IS NOT NULL AND @V_KhoTonKhoId > 0)
			BEGIN
				WHILE EXISTS(SELECT 1 FROM @V_KhoPhieuNhapChiTiet_Rollback)
				BEGIN
					SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia, @V_GiaMua = GiaMua, @V_GiaBan = GiaBan, @V_HanDung = HanDung, @V_LoSanXuat = LoSanXuat FROM @V_KhoPhieuNhapChiTiet_Rollback
					IF EXISTS(SELECT 1 FROM dbo.KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia)
					BEGIN
						UPDATE dbo.KhoTonKhoChiTiet SET SLNhap = SLNhap + @V_SoLuong WHERE KhoTonKhoId = @V_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
					END
					ELSE
                    BEGIN
						INSERT dbo.KhoTonKhoChiTiet
						        ( KhoTonKhoId ,		TaiSanId ,		DonGia ,
						          GiaMua ,			GiaBan ,		TonDau ,
						          SLNhap ,			SLXuat ,		NguonNganSachId ,
						          NhaCungCapId ,	HanDung ,		LoSanXuat
						        )
						SELECT	@V_KhoTonKhoId,		@V_TaiSanId,	@V_DonGia,
								0,					0,				0,
								@V_SoLuong,			0,				@NguonNganSachId,
								@NhaCungCapId,		NULL,			NULL
						
					END

					DELETE @V_KhoPhieuNhapChiTiet_Rollback WHERE RowId= @V_RowId
					SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_GiaMua=NULL,@V_GiaBan=NULL,@V_HanDung=NULL,@V_LoSanXuat=NULL,@V_SoLuong=NULL
				END
			END

			SELECT @@ROWCOUNT AS ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuNhapChiTiet_GetListKhoPhieuNhapChiTietById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_KhoPhieuNhapChiTiet_GetListKhoPhieuNhapChiTietById]
( 
	@KhoPhieuNhapId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT L.KhoPhieuNhapChiTietId, L.KhoPhieuNhapId,
		   L.TaiSanId, TS.TenTaiSan, TS.DonViTinh,
		   L.SoLuong, L.DonGia, L.GiaMua, L.GiaBan,
		   L.VAT, L.HanDung, L.LoSanXuat,
		   (L.SoLuong*L.DonGia)*L.VAT/100 TienThue
	FROM dbo.KhoPhieuNhapChiTiet L
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = L.TaiSanId
	WHERE L.KhoPhieuNhapId = @KhoPhieuNhapId

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuat_DeleteKhoPhieuXuat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.25
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuat_DeleteKhoPhieuXuat]
						@KhoPhieuXuatId			=	21

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6

						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.25 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuat_DeleteKhoPhieuXuat]
	@KhoPhieuXuatId			INT				=	NULL

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- BIẾN NỘI BỘ
DECLARE  @V_TRANS_NAME		NVARCHAR(MAX)	=	N'KPX_DELETE'

-- INPUT DEFAULT
SET @NHANVIEN_ID	= ISNULL(@NHANVIEN_ID,0)
SET @COSO_ID	= ISNULL(@COSO_ID,0)
SET @MESSAGE	= ISNULL(@MESSAGE,'')

BEGIN TRY
	declare @V_KhoaSoLieu bit
		,@V_KX_KhoTonKhoId int
		,@V_KN_KhoTonKhoId int
		,@CoSoId int
		,@KhoXuatId int
		,@KhoNhanId int
		,@V_ThangNam varchar(4)

	select @CoSoId = CoSoId
		,@KhoXuatId = KhoXuatId
		,@KhoNhanId = KhoNhanId
		,@V_ThangNam = format(NgayXuat,'MMyy')
	from KhoPhieuXuat
	where KhoPhieuXuatId = @KhoPhieuXuatId

	-- kiểm tra khóa số liệu kho xuất
	set @V_KhoaSoLieu = null

	select @V_KhoaSoLieu = TrangThai
		,@V_KX_KhoTonKhoId = KhoTonKhoId
	from KhoTonKho 
	where KhoTaiSanId = @KhoXuatId
		and CoSoId = @CoSoId
		and ThangNam = @V_ThangNam

	IF @V_KhoaSoLieu = 1
	BEGIN
		SET @MESSAGE	=	N'KHOASOLIEU|1|Đã khóa số liệu kho xuất. Không thể thay đổi thông tin phiếu xuất';
		THROW 51000, @MESSAGE, 1;
	END

	-- kiểm tra khóa số liệu kho nhập
	set @V_KhoaSoLieu = null

	select @V_KhoaSoLieu = TrangThai
		,@V_KN_KhoTonKhoId = KhoTonKhoId
	from KhoTonKho 
	where KhoTaiSanId = @KhoNhanId
		and CoSoId = @CoSoId
		and ThangNam = @V_ThangNam

	IF @V_KhoaSoLieu = 1
	BEGIN
		SET @MESSAGE	=	N'KHOASOLIEU|2|Đã khóa số liệu kho nhập. Không thể thay đổi thông tin phiếu xuất';
		THROW 51000, @MESSAGE, 1;
	END

	-- bảng tạm lưu chi tiết
	DECLARE @V_KhoPhieuXuatChiTiet TABLE
	(
		RowId int IDENTITY(1, 1),
		KhoPhieuXuatId int NULL,
		TaiSanId int NULL,
		SoLuong numeric(18, 4) NULL,
		DonGia numeric(18, 4) NULL,
		NguonNganSachId int NULL,
		NhaCungCapId int NULL,
		KhoNhanId int NULL,
		KhoXuatId int NULL
	)
	declare	 @V_RowId int
		,@V_TaiSanId int
		,@V_DonGia numeric (18, 4)
		,@V_SoLuong numeric (18, 4)
		,@V_TonCuoi numeric (18, 4)

print @KhoPhieuXuatId
	IF @KhoPhieuXuatId = 0
	BEGIN
		SET @MESSAGE	=	N'PHIEUXUATID|1|Không tìm thấy thông tin';
		THROW 51000, @MESSAGE, 1;
	END
	BEGIN TRANSACTION @V_TRANS_NAME

	SELECT * FROM KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId

	-- rollback tồn kho xuất chi tiết
	DELETE @V_KhoPhieuXuatChiTiet
	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId			,TaiSanId 				,SoLuong
				,DonGia					,NguonNganSachId		,NhaCungCapId
				,KhoNhanId				,KhoXuatId
			)
	SELECT		kpxct.KhoPhieuXuatId	,kpxct.TaiSanId			,kpxct.SoLuong
				,kpxct.DonGia			,kpxct.NguonNganSachId	,kpxct.NhaCungCapId
				,kpx.KhoNhanId			,kpx.KhoXuatId
	FROM KhoPhieuXuatChiTiet kpxct
		left join KhoPhieuXuat kpx on kpxct.KhoPhieuXuatId = kpx.KhoPhieuXuatId
	where kpx.KhoPhieuXuatId = @KhoPhieuXuatId

	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL

	while EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
	begin
		SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia
		FROM @V_KhoPhieuXuatChiTiet

		SELECT TOP 1 @V_TonCuoi = TonDau + SLNhap - SLXuat FROM KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia

		if @V_TonCuoi is not null and @V_TonCuoi < @V_SoLuong
		begin
			SET @MESSAGE	=	N'SOLUONGXUAT|1|Số lượng xuất lớn hơn số lượng tồn';
			THROW 51000, @MESSAGE, 1;
		end

		if @V_TonCuoi is not null
		begin
			UPDATE dbo.KhoTonKhoChiTiet 
			SET SLXuat = SLXuat - @V_SoLuong 
			WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		end

		DELETE @V_KhoPhieuXuatChiTiet WHERE RowId = @V_RowId
		SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL
	end

	-- rollback tồn kho nhập chi tiết
	DELETE @V_KhoPhieuXuatChiTiet
	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId			,TaiSanId 				,SoLuong
				,DonGia					,NguonNganSachId		,NhaCungCapId
				,KhoNhanId				,KhoXuatId
			)
	SELECT		kpxct.KhoPhieuXuatId	,kpxct.TaiSanId			,kpxct.SoLuong
				,kpxct.DonGia			,kpxct.NguonNganSachId	,kpxct.NhaCungCapId
				,kpx.KhoNhanId			,kpx.KhoXuatId
	FROM KhoPhieuXuatChiTiet kpxct
		left join KhoPhieuXuat kpx on kpxct.KhoPhieuXuatId = kpx.KhoPhieuXuatId
	where kpx.KhoPhieuXuatId = @KhoPhieuXuatId

	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL

	while EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
	begin
		SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia
		FROM @V_KhoPhieuXuatChiTiet

		SELECT TOP 1 @V_TonCuoi = TonDau + SLNhap - SLXuat FROM KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KN_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia

		if @V_TonCuoi is not null and @V_TonCuoi - @V_SoLuong < 0
		begin
			SET @MESSAGE	=	N'SOLUONGNHAP|1|Tồn cuối nhỏ hơn 0';
			THROW 51000, @MESSAGE, 1;
		end

		if @V_TonCuoi is not null
		begin
			UPDATE dbo.KhoTonKhoChiTiet 
			SET SLNhap = SLNhap - @V_SoLuong 
			WHERE KhoTonKhoId = @V_KN_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		end

		DELETE @V_KhoPhieuXuatChiTiet WHERE RowId = @V_RowId
		SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL
	end

	DELETE KhoPhieuXuatChiTiet WHERE KhoPhieuXuatId = @KhoPhieuXuatId
	DELETE KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME
	
	DECLARE  @ErrorMessage	NVARCHAR(MAX)	=	ERROR_MESSAGE()
			,@ErrorSeverity INT				=	ERROR_SEVERITY()
			,@ErrorState	INT				=	ERROR_STATE()

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
	SELECT * FROM KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuat_GetKhoPhieuXuatById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.24
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuat_GetKhoPhieuXuatById]
						 @KHOPHIEUXUATID		=	''

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6
						,@FUNCTIONCODE			=	'CN0046'
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.24 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuat_GetKhoPhieuXuatById]
	 @KHOPHIEUXUATID		VARCHAR(MAX)	=	NULL

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@FUNCTIONCODE			VARCHAR(MAX)	=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- INPUT DEFAULT
SET @KHOPHIEUXUATID =	ISNULL(@KHOPHIEUXUATID,'')
IF @KHOPHIEUXUATID =''
	SET @KHOPHIEUXUATID = 0;

SELECT		KPX.*
			,CS.TenCoSo
			,NV.TenNhanVien TenNguoiTao
FROM		KhoPhieuXuat KPX
			LEFT JOIN CoSo CS ON KPX.CoSoId = CS.CoSoId
			LEFT JOIN NhanVien NV ON KPX.NguoiTao = NV.NhanVienId
WHERE		KPX.KhoPhieuXuatId = @KHOPHIEUXUATID
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuat_GetKhoPhieuXuatChiTietById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.25
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuat_GetKhoPhieuXuatChiTietById]
						 @KHOPHIEUXUATID		=	'20'

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6
						,@FUNCTIONCODE			=	'CN0046'
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.25 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuat_GetKhoPhieuXuatChiTietById]
	 @KHOPHIEUXUATID		VARCHAR(MAX)	=	NULL

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@FUNCTIONCODE			VARCHAR(MAX)	=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- INPUT DEFAULT
SET @KHOPHIEUXUATID =	ISNULL(@KHOPHIEUXUATID,'')
IF @KHOPHIEUXUATID =''
	SET @KHOPHIEUXUATID = 0;

SELECT		COUNT(KPXCT.KhoPhieuXuatChiTietId) OVER () AS MAXCNT
			,KPXCT.*
			,NNS.TenNguonNganSach
			,TS.TenTaiSan,TS.DonViTinh
FROM		KhoPhieuXuatChiTiet KPXCT
			LEFT JOIN NguonNganSach NNS ON KPXCT.NguonNganSachId = NNS.NguonNganSachId
			LEFT JOIN TaiSan TS ON KPXCT.TaiSanId = TS.TaiSanId
WHERE		KPXCT.KhoPhieuXuatId = @KHOPHIEUXUATID
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuat_GetListKhoPhieuXuatByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.24
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuat_GetListKhoPhieuXuatByCriteria]
						 @SEARCH				=	NULL
						,@SOPHIEU				=	''
						,@KHOPHIEUXUATID		=	''
						,@COSOID				=	NULL
						,@NHANVIENID			=	NULL

						,@FIELD					=	NULL
						,@ORDERCLAUSE			=	'KPX.KhoPhieuXuatId DESC'
						,@SKIP					=	0
						,@TAKE					=	10

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6
						,@FUNCTIONCODE			=	'CN0046'
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.24 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuat_GetListKhoPhieuXuatByCriteria]
	 @SEARCH				NVARCHAR(MAX)	=	NULL
	,@SOPHIEU				VARCHAR(MAX)	=	NULL
	,@KHOPHIEUXUATID		VARCHAR(MAX)	=	NULL
	,@COSOID				VARCHAR(MAX)	=	NULL
	,@NHANVIENID			VARCHAR(MAX)	=	NULL
	,@KHOTAISANID			VARCHAR(MAX)	=	NULL
	,@STARTDATE				VARCHAR(MAX)	=	NULL
	,@ENDDATE				VARCHAR(MAX)	=	NULL

	,@FIELD					VARCHAR(MAX)	=	NULL
	,@ORDERCLAUSE			VARCHAR(MAX)	=	NULL
	,@SKIP					INT				=	NULL
	,@TAKE					INT				=	NULL

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@FUNCTIONCODE			VARCHAR(MAX)	=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- BIẾN NỘI BỘ
DECLARE  @V_SQL			NVARCHAR(MAX)	=	N''
		,@V_SEARCH		NVARCHAR(MAX)	=	N''
		,@V_ISVIEW		VARCHAR(MAX)	=	N''
		,@V_COSO_IDS	VARCHAR(MAX)	=	N''
		,@V_DELIMITER	VARCHAR(MAX)	=	N'|'
		 ,@ThangNam	VARCHAR(MAX)	=	NULL
			--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSoTaiSanLauBen @LOAITHONGSO='SoLieuThangNam',@NHANVIEN=@NHANVIEN_ID,@ThangNam=@ThangNam OUTPUT; 
-- INPUT DEFAULT
SET @SEARCH			=	ISNULL(@SEARCH,'')
SET @KHOPHIEUXUATID =	ISNULL(@KHOPHIEUXUATID,'')
SET @SOPHIEU		=	ISNULL(@SOPHIEU,'')
SET @COSOID			=	ISNULL(@COSOID,'')
SET @NHANVIENID		=	ISNULL(@NHANVIENID,'')

SET @ORDERCLAUSE	=	ISNULL(@ORDERCLAUSE,'')
SET @SKIP			=	ISNULL(@SKIP,0)
SET @TAKE			=	ISNULL(@TAKE,0)
SET @MESSAGE		=	ISNULL(@MESSAGE,'')

SET @V_SEARCH		=	'%' + @SEARCH + '%'

SET @FIELD			=	ISNULL(@FIELD,'')
IF @FIELD = ''
	SET @FIELD = 'KPX.*'

BEGIN TRY
	--SET @MESSAGE	=	N'MA_TAI_SAN|1|MÃ NÀY ĐÃ TỒN TẠI';
	--THROW 51000, @MESSAGE, 1;

	-- KIỂM TRA QUYỀN VIEW
	EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NHANVIEN_ID,
		@CO_SO_ID = @COSO_ID,
		@CHUC_NANG = @FUNCTIONCODE,
		@QUYEN=@V_ISVIEW OUTPUT
	--/ KIỂM TRA QUYỀN VIEW

	-- DANH SÁCH CƠ SỞ TRƯC THUỘC
	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
		@COSOID=@COSO_ID
		,@COSOID_OUT=@V_COSO_IDS OUTPUT
	SET @V_COSO_IDS = REPLACE(@V_COSO_IDS,',',@V_DELIMITER)
	--/ DANH SÁCH CƠ SỞ TRƯC THUỘC

	SET @V_SQL = N'
		SELECT		COUNT(KPX.KhoPhieuXuatId) OVER () AS MAXCNT,' + @FIELD + '
					,KPX.KhoPhieuXuatId ID,KPX.CtrVersion CTRVERSION
					,NV.TenNhanVien TenNguoiTao
		FROM		KhoPhieuXuat KPX
					LEFT JOIN NhanVien NV ON KPX.NguoiTao = NV.NhanVienId
		WHERE		(
					@V_ISVIEW IN (''VA'')
					OR (@V_ISVIEW IN (''VB'',''VR'') AND CHARINDEX(@V_DELIMITER + CAST(KPX.CoSoId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @V_COSO_IDS + @V_DELIMITER) > 0)
					OR (@V_ISVIEW IN (''VE'') AND KPX.NguoiTao = @NHANVIEN_ID)
					)
					AND (
						@SEARCH = ''''
						OR KPX.SoPhieu LIKE @V_SEARCH
						OR KPX.LyDo LIKE @V_SEARCH
						OR KPX.Loai LIKE @V_SEARCH
						OR KPX.NguoiNhanHang LIKE @V_SEARCH
					)
					AND (@SOPHIEU = '''' OR KPX.SoPhieu = @SOPHIEU)
					AND KPX.Loai = ''CK''
					AND (@STARTDATE = '''' OR KPX.NgayXuat >= @STARTDATE)
					AND (@ENDDATE = '''' OR KPX.NgayXuat <= @ENDDATE)
					AND (@KHOTAISANID = '''' OR KPX.KhoXuatId = @KHOTAISANID)
					AND (@KHOPHIEUXUATID = '''' OR CHARINDEX(@V_DELIMITER + CAST(KPX.KhoPhieuXuatId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @KHOPHIEUXUATID + @V_DELIMITER) > 0)
					and FORMAT(KPX.NgayXuat, ''MMyy'')=@ThangNam';
	IF @ORDERCLAUSE <> ''
		SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDERCLAUSE

	IF @ORDERCLAUSE <> '' AND @TAKE > 0
		SET @V_SQL = @V_SQL + ' OFFSET ' + CAST(@SKIP AS VARCHAR(20)) + ' ROWS FETCH NEXT ' + CAST(@TAKE AS VARCHAR(20)) + ' ROWS ONLY '

	PRINT @V_SQL
	EXEC SP_EXECUTESQL @V_SQL,N'
		 @COSO_ID				INT				=	NULL
		,@NHANVIEN_ID			INT				=	NULL
		,@FUNCTIONCODE			VARCHAR(MAX)	=	NULL

		,@SEARCH				NVARCHAR(MAX)	=	NULL
		,@KHOPHIEUXUATID		VARCHAR(MAX)	=	NULL
		,@SOPHIEU				VARCHAR(MAX)	=	NULL
		,@COSOID				VARCHAR(MAX)	=	NULL
		,@NHANVIENID			VARCHAR(MAX)	=	NULL
		,@KHOTAISANID			VARCHAR(MAX)	=	NULL
		,@STARTDATE				VARCHAR(MAX)	=	NULL
		,@ENDDATE				VARCHAR(MAX)	=	NULL

		,@V_SEARCH				NVARCHAR(MAX)	=	NULL
		,@V_ISVIEW				VARCHAR(MAX)	=	NULL
		,@V_COSO_IDS			VARCHAR(MAX)	=	NULL
		,@V_DELIMITER			VARCHAR(MAX)	=	NULL
		,@ThangNam				VARCHAR(MAX)	=	NULL
		'
		,@COSO_ID								=	@COSO_ID
		,@NHANVIEN_ID							=	@NHANVIEN_ID
		,@FUNCTIONCODE							=	@FUNCTIONCODE

		,@SEARCH								=	@SEARCH
		,@KHOPHIEUXUATID						=	@KHOPHIEUXUATID
		,@SOPHIEU								=	@SOPHIEU
		,@COSOID								=	@COSOID
		,@NHANVIENID							=	@NHANVIENID
		,@KHOTAISANID							=	@KHOTAISANID
		,@STARTDATE								=	@STARTDATE
		,@ENDDATE								=	@ENDDATE

		,@V_SEARCH								=	@V_SEARCH
		,@V_ISVIEW								=	@V_ISVIEW
		,@V_COSO_IDS							=	@V_COSO_IDS
		,@V_DELIMITER							=	@V_DELIMITER
		,@ThangNam								=	@ThangNam
END TRY
BEGIN CATCH
	DECLARE  @ErrorMessage	NVARCHAR(MAX)	=	ERROR_MESSAGE()
			,@ErrorSeverity INT				=	ERROR_SEVERITY()
			,@ErrorState	INT				=	ERROR_STATE()

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuat_InsertKhoPhieuXuat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.24
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @ChiTiet KhoPhieuXuatChiTietTableType
					INSERT INTO @ChiTiet	 (KhoPhieuXuatChiTietId	,KhoPhieuXuatId	,TaiSanId	,SoLuong	,DonGia	,GiaMua	,GiaBan	,NguonNganSachId	,NhaCungCapId	,HanDung	,LoSanXuat	)
								VALUES		 (0						,0				,1061		,5			,20000	,10		,20		,1					,1				,N'1'		,N'1'		)

					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuat_InsertKhoPhieuXuat]
						@KhoPhieuXuatId			=	NULL
						,@SoPhieu				=	N'test003'
						,@NgayXuat				=	'2017-09-24 00:00:00'
						,@Loai					=	N'CK'
						,@KhoXuatId				=	4
						,@KhoNhanId				=	1
						,@NguoiNhanHang			=	N'21212'
						,@LyDo					=	NULL
						,@CoSoId				=	0
						,@NguoiTao				=	0
						,@NgayTao				=	'2017-10-24 04:18:30.687'
						,@CtrVersion			=	0

						,@ChiTiet				=	@ChiTiet

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6

						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.24 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuat_InsertKhoPhieuXuat]
	@KhoPhieuXuatId			INT				=	NULL
	,@SoPhieu				VARCHAR(MAX)	=	NULL
	,@NgayXuat				DATETIME		=	NULL
	,@Loai					VARCHAR(MAX)	=	NULL
	,@KhoXuatId				INT				=	NULL
	,@KhoNhanId				INT				=	NULL
	,@NguoiNhanHang			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@CoSoId				INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	,@ChiTiet				KhoPhieuXuatChiTietTableType		READONLY

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- BIẾN NỘI BỘ
DECLARE  @V_TRANS_NAME		NVARCHAR(MAX)	=	N'KPX_INSERT'
	,@V_ThangNam varchar(4)
-- INPUT DEFAULT
SET @NHANVIEN_ID	= ISNULL(@NHANVIEN_ID,0)
SET @COSO_ID	= ISNULL(@COSO_ID,0)
SET @MESSAGE	= ISNULL(@MESSAGE,'')

SET @NgayTao	= ISNULL(@NgayTao, GETDATE())

SET @NguoiTao	= ISNULL(@NguoiTao, 0)
IF @NguoiTao = 0
	SET @NguoiTao	= @NHANVIEN_ID

SET @CoSoId	= ISNULL(@CoSoId, 0)
IF @CoSoId = 0
	SET @CoSoId	= @COSO_ID

set @V_ThangNam = format(@NgayXuat,'MMyy')

BEGIN TRY
	--SET @MESSAGE	=	N'MA_TAI_SAN|1|MÃ NÀY ĐÃ TỒN TẠI';
	--THROW 51000, @MESSAGE, 1;

	-- kiểm tra khóa số liệu kho xuất
	declare @V_KX_KhoaSoLieu bit
		,@V_KX_KhoTonKhoId int

	select @V_KX_KhoaSoLieu = TrangThai
		,@V_KX_KhoTonKhoId = KhoTonKhoId
	from KhoTonKho 
	where KhoTaiSanId = @KhoXuatId
		and CoSoId = @CoSoId
		and ThangNam = @V_ThangNam

	IF @V_KX_KhoaSoLieu = 1
	BEGIN
		SET @MESSAGE	=	N'KHOASOLIEU|1|Đã khóa số liệu kho xuất. Không thể thêm phiếu xuất';
		THROW 51000, @MESSAGE, 1;
	END

	-- kiểm tra khóa số liệu kho nhập
	declare @V_KN_KhoaSoLieu bit
		,@V_KN_KhoTonKhoId int

	select @V_KN_KhoaSoLieu = TrangThai
		,@V_KN_KhoTonKhoId = KhoTonKhoId
	from KhoTonKho 
	where KhoTaiSanId = @KhoNhanId
		and CoSoId = @CoSoId
		and ThangNam = @V_ThangNam

	IF @V_KN_KhoaSoLieu = 1
	BEGIN
		SET @MESSAGE	=	N'KHOASOLIEU|2|Đã khóa số liệu kho nhập. Không thể thêm phiếu xuất';
		THROW 51000, @MESSAGE, 1;
	END

	-- kiểm tra số phiếu
	IF EXISTS (SELECT 1 FROM KhoPhieuXuat WHERE SoPhieu = @SoPhieu)
	BEGIN
		SET @MESSAGE	=	N'SOPHIEU|1|Số phiếu đã tồn tại';
		THROW 51000, @MESSAGE, 1;
	END

	-- bảng tạm lưu chi tiết
	DECLARE @V_KhoPhieuXuatChiTiet TABLE
	(
		RowId int IDENTITY(1, 1),
		KhoPhieuXuatId int NULL,
		TaiSanId int NULL,
		SoLuong numeric(18, 4) NULL,
		DonGia numeric(18, 4) NULL,
		NguonNganSachId int NULL,
		NhaCungCapId int NULL,
		HanDung varchar(10) NULL,
		LoSanXuat varchar(10) NULL
	)
	declare	 @V_RowId int
			,@V_TaiSanId int
			,@V_DonGia numeric (18, 4)
			,@V_SoLuong numeric (18, 4)
			,@V_TonCuoi numeric (18, 4)

	BEGIN TRANSACTION @V_TRANS_NAME

	-- thêm thông tin KhoPhieuXuat
	INSERT	KhoPhieuXuat
			(
			 SoPhieu					,NgayXuat				,Loai
			,KhoXuatId					,KhoNhanId				,NguoiNhanHang
			,LyDo						,CoSoId					,NguoiTao
			,NgayTao					,CtrVersion
			)
	VALUES	(
			 @SoPhieu					,@NgayXuat				,@Loai
			,@KhoXuatId					,@KhoNhanId				,@NguoiNhanHang
			,@LyDo						,@CoSoId				,@NguoiTao
			,@NgayTao					,@CtrVersion
			)

	SET @KhoPhieuXuatId = @@IDENTITY

	-- thêm thông tin KhoPhieuXuatChiTiet
	INSERT INTO	KhoPhieuXuatChiTiet
			(
				 KhoPhieuXuatId		,TaiSanId		,SoLuong
				,DonGia				,GiaMua			,GiaBan
				,NguonNganSachId	,NhaCungCapId	,HanDung
				,LoSanXuat
			)
	SELECT		 @KhoPhieuXuatId	,TaiSanId		,SoLuong
				,DonGia				,GiaMua			,GiaBan
				,NguonNganSachId	,NhaCungCapId	,HanDung
				,LoSanXuat
	FROM		@ChiTiet

	/* **************************************************
	tồn kho xuất
	************************************************** */
	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=null
	
	DELETE @V_KhoPhieuXuatChiTiet
	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId		,TaiSanId 		,SoLuong
				,DonGia				,HanDung		,LoSanXuat
				,NguonNganSachId	,NhaCungCapId	
			)
	SELECT		KhoPhieuXuatId		,TaiSanId		,SoLuong
				,DonGia				,HanDung		,LoSanXuat
				,NguonNganSachId	,NhaCungCapId	
	FROM @ChiTiet

	if @V_KX_KhoTonKhoId is null
	begin
		insert KhoTonKho	(KhoTaiSanId	,CoSoId		,ThangNam		,TrangThai	,NguoiTao		,NgayTao	,CtrVersion	)
		select				@KhoNhanId		,@CoSoId	,@V_ThangNam	,0			,@NHANVIEN_ID	,@NgayTao	,1
	
		SET @V_KX_KhoTonKhoId = @@IDENTITY
		
		insert dbo.KhoTonKhoChiTiet
			(	 KhoTonKhoId		,TaiSanId	,DonGia
				,GiaMua				,GiaBan		,TonDau
				,SLNhap				,SLXuat		,NguonNganSachId
				,NhaCungCapId		,HanDung	,LoSanXuat
			)
		select	@V_KX_KhoTonKhoId	,TaiSanId	,DonGia
				,0					,0			,0
				,SUM(SoLuong)		,0			,NguonNganSachId
				,NhaCungCapId		,''			,''
				from @ChiTiet
				group by TaiSanId,DonGia,NguonNganSachId,NhaCungCapId
	end
	else
	begin
		WHILE EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
		BEGIN
			SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia
			FROM @V_KhoPhieuXuatChiTiet
			
			SELECT TOP 1 @V_TonCuoi = TonDau + SLNhap - SLXuat FROM KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia

			if @V_TonCuoi is not null and @V_TonCuoi < @V_SoLuong
			begin
				SET @MESSAGE	=	N'SOLUONGXUAT|1|Số lượng xuất lớn hơn số lượng tồn';
				THROW 51000, @MESSAGE, 1;
			end

			IF @V_TonCuoi is not null
			BEGIN
				UPDATE dbo.KhoTonKhoChiTiet SET SLXuat = SLXuat + @V_SoLuong WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
			END
			ELSE
            BEGIN
				INSERT dbo.KhoTonKhoChiTiet
					(	 KhoTonKhoId		,TaiSanId		,DonGia
						,GiaMua				,GiaBan			,TonDau
						,SLNhap				,SLXuat			,NguonNganSachId
						,NhaCungCapId		,HanDung		,LoSanXuat
					)
				SELECT	@V_KX_KhoTonKhoId	,TaiSanId		,DonGia
						,0					,0				,0
						,0					,SoLuong		,NguonNganSachId
						,NhaCungCapId		,NULL			,NULL
				from @V_KhoPhieuXuatChiTiet
				where RowId = @V_RowId
			END

			DELETE @V_KhoPhieuXuatChiTiet WHERE RowId= @V_RowId
			SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL
		END
	end
	--/ tồn kho xuất

	/* **************************************************
	tồn kho nhập
	************************************************** */
	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL

	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId		,TaiSanId 		,SoLuong
				,DonGia				,HanDung		,LoSanXuat
				,NguonNganSachId	,NhaCungCapId	
			)
	SELECT		KhoPhieuXuatId		,TaiSanId		,SoLuong
				,DonGia				,HanDung		,LoSanXuat
				,NguonNganSachId	,NhaCungCapId	
	FROM @ChiTiet

	if @V_KN_KhoTonKhoId is null
	begin
		insert KhoTonKho	(KhoTaiSanId	,CoSoId		,ThangNam		,TrangThai	,NguoiTao		,NgayTao	,CtrVersion	)
		select				@KhoNhanId		,@CoSoId	,@V_ThangNam	,0			,@NHANVIEN_ID	,@NgayTao	,1
	
		SET @V_KN_KhoTonKhoId = @@IDENTITY
		
		insert dbo.KhoTonKhoChiTiet
			(	 KhoTonKhoId		,TaiSanId	,DonGia
				,GiaMua				,GiaBan		,TonDau
				,SLNhap				,SLXuat		,NguonNganSachId
				,NhaCungCapId		,HanDung	,LoSanXuat
			)
		select	@V_KN_KhoTonKhoId	,TaiSanId	,DonGia
				,0					,0			,0
				,SUM(SoLuong)		,0			,NguonNganSachId
				,NhaCungCapId		,''			,''
				from @ChiTiet
				group by TaiSanId,DonGia,NguonNganSachId,NhaCungCapId
	end
	else
	begin
		WHILE EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
		BEGIN
			SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia FROM @V_KhoPhieuXuatChiTiet
				
			IF EXISTS(SELECT 1 FROM dbo.KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KN_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia)
			BEGIN
				UPDATE dbo.KhoTonKhoChiTiet SET SLNhap = SLNhap + @V_SoLuong WHERE KhoTonKhoId = @V_KN_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
			END
			ELSE
            BEGIN
				INSERT dbo.KhoTonKhoChiTiet
					(	 KhoTonKhoId		,TaiSanId		,DonGia
						,GiaMua				,GiaBan			,TonDau
						,SLNhap				,SLXuat			,NguonNganSachId
						,NhaCungCapId		,HanDung		,LoSanXuat
					)
				SELECT	@V_KN_KhoTonKhoId	,TaiSanId		,DonGia
						,0					,0				,0
						,SoLuong			,0				,NguonNganSachId
						,NhaCungCapId		,NULL			,NULL
				from @V_KhoPhieuXuatChiTiet
				where RowId = @V_RowId
			END

			DELETE @V_KhoPhieuXuatChiTiet WHERE RowId= @V_RowId
			SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL
		END
	end
	-- tồn kho nhập

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	DECLARE  @ErrorMessage	NVARCHAR(MAX)	=	ERROR_MESSAGE()
			,@ErrorSeverity INT				=	ERROR_SEVERITY()
			,@ErrorState	INT				=	ERROR_STATE()

	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
	SELECT * FROM KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuat_report_KhoPhieuXuatById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.27
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_KhoPhieuXuat_report_KhoPhieuXuatById]
						 @KhoPhieuXuatId		=	'34'
						,@COSO_ID			=	1
						,@NHANVIEN_ID		=	''
6. Precaution	:
7. History		:
				  2017.10.27 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuat_report_KhoPhieuXuatById]
	 @KhoPhieuXuatId		NVARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
AS
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_DELIMITER	VARCHAR(10)		=	','
		,@_COSO_IDS		VARCHAR(MAX)	=	NULL

SELECT	KPXCT.*
		,TS.TenTaiSan,TS.DonViTinh
		,KPX.LyDo,KPX.NgayXuat,KPX.NguoiNhanHang,KPX.SoPhieu
		,CS.TenCoSo TenCoSo
		,CS_TT.TenCoSo TenCoSoTrucThuoc
		,HSX.TenHangSanXuat
		,KTS.TenKhoTaiSan TenKhoXuat
		,KPXCT.SoLuong*KPXCT.DonGia ThanhTien
FROM	KhoPhieuXuatChiTiet KPXCT
		LEFT JOIN KhoPhieuXuat KPX ON KPXCT.KhoPhieuXuatId = KPX.KhoPhieuXuatId
		LEFT JOIN CoSo CS ON KPX.CoSoId = CS.CoSoId
		LEFT JOIN CoSo CS_TT ON CS.TrucThuoc = CS_TT.CoSoId
		LEFT JOIN TaiSan TS ON KPXCT.TaiSanId = TS.TaiSanId
		LEFT JOIN HangSanXuat HSX ON TS.HangSanXuatId = HSX.HangSanXuatId
		LEFT JOIN KhoTaiSan KTS ON KPX.KhoXuatId = KTS.KhoTaiSanId
WHERE	KPXCT.KhoPhieuXuatId = @KhoPhieuXuatId
--------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuat_UpdateKhoPhieuXuat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.25
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @ChiTiet KhoPhieuXuatChiTietTableType
					INSERT INTO @ChiTiet	 (KhoPhieuXuatChiTietId	,KhoPhieuXuatId	,TaiSanId	,SoLuong	,DonGia	,GiaMua	,GiaBan	,NguonNganSachId	,NhaCungCapId	,HangDung	,LoSanXuat	)
								VALUES		 (0						,0				,1061		,1			,20000	,10		,20		,1					,1				,N'1'		,N'1'		)

					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuat_UpdateKhoPhieuXuat]
						@KhoPhieuXuatId			=	NULL
						,@SoPhieu				=	N'121212'
						,@NgayXuat				=	'2017-10-24 00:00:00'
						,@Loai					=	N'CK'
						,@KhoXuatId				=	1
						,@KhoNhanId				=	4
						,@NguoiNhanHang			=	N'21212'
						,@LyDo					=	NULL
						,@CoSoId				=	0
						,@NguoiTao				=	0
						,@NgayTao				=	'2017-10-24 04:18:30.687'
						,@CtrVersion			=	0

						,@ChiTiet				=	@ChiTiet

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6

						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.25 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuat_UpdateKhoPhieuXuat]
	@KhoPhieuXuatId			INT				=	NULL
	,@SoPhieu				VARCHAR(MAX)	=	NULL
	,@NgayXuat				DATETIME		=	NULL
	,@Loai					VARCHAR(MAX)	=	NULL
	,@KhoXuatId				INT				=	NULL
	,@KhoNhanId				INT				=	NULL
	,@NguoiNhanHang			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@CoSoId				INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	,@ChiTiet				KhoPhieuXuatChiTietTableType		READONLY

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- BIẾN NỘI BỘ
DECLARE  @V_TRANS_NAME		NVARCHAR(MAX)	=	N'KPX_UPDATE'
	,@V_ThangNam varchar(4)

-- INPUT DEFAULT
SET @NHANVIEN_ID	= ISNULL(@NHANVIEN_ID,0)
SET @COSO_ID	= ISNULL(@COSO_ID,0)
SET @MESSAGE	= ISNULL(@MESSAGE,'')

SET @NgayTao	= ISNULL(@NgayTao, GETDATE())

SET @NguoiTao	= ISNULL(@NguoiTao, 0)
IF @NguoiTao = 0
	SET @NguoiTao	= @NHANVIEN_ID

SET @CoSoId	= ISNULL(@CoSoId, 0)
IF @CoSoId = 0
	SET @CoSoId	= @COSO_ID

set @V_ThangNam = format(@NgayXuat,'MMyy')

BEGIN TRY
	declare @V_KhoaSoLieu bit
		,@V_KX_KhoTonKhoId int
		,@V_KN_KhoTonKhoId int

	-- kiểm tra khóa số liệu kho xuất
	set @V_KhoaSoLieu = null

	select @V_KhoaSoLieu = TrangThai
		,@V_KX_KhoTonKhoId = KhoTonKhoId
	from KhoTonKho 
	where KhoTaiSanId = @KhoXuatId
		and CoSoId = @CoSoId
		and ThangNam = @V_ThangNam

	IF @V_KhoaSoLieu = 1
	BEGIN
		SET @MESSAGE	=	N'KHOASOLIEU|1|Đã khóa số liệu kho xuất. Không thể thay đổi thông tin phiếu xuất';
		THROW 51000, @MESSAGE, 1;
	END

	-- kiểm tra khóa số liệu kho nhập
	set @V_KhoaSoLieu = null

	select @V_KhoaSoLieu = TrangThai
		,@V_KN_KhoTonKhoId = KhoTonKhoId
	from KhoTonKho 
	where KhoTaiSanId = @KhoNhanId
		and CoSoId = @CoSoId
		and ThangNam = @V_ThangNam

	IF @V_KhoaSoLieu = 1
	BEGIN
		SET @MESSAGE	=	N'KHOASOLIEU|2|Đã khóa số liệu kho nhập. Không thể thay đổi thông tin phiếu xuất';
		THROW 51000, @MESSAGE, 1;
	END

	-- kiểm tra số phiếu
	IF EXISTS (SELECT 1 FROM KhoPhieuXuat WHERE SoPhieu = @SoPhieu AND KhoPhieuXuatId <> @KhoPhieuXuatId)
	BEGIN
		SET @MESSAGE	=	N'SOPHIEU|1|Số phiếu đã tồn tại';
		THROW 51000, @MESSAGE, 1;
	END

	-- bảng tạm lưu chi tiết
	DECLARE @V_KhoPhieuXuatChiTiet TABLE
	(
		RowId int IDENTITY(1, 1),
		KhoPhieuXuatId int NULL,
		TaiSanId int NULL,
		SoLuong numeric(18, 4) NULL,
		DonGia numeric(18, 4) NULL,
		NguonNganSachId int NULL,
		NhaCungCapId int NULL,
		KhoNhanId int NULL,
		KhoXuatId int NULL
	)
	declare	 @V_RowId int
		,@V_TaiSanId int
		,@V_DonGia numeric (18, 4)
		,@V_SoLuong numeric (18, 4)
		,@V_TonCuoi numeric (18, 4)

	BEGIN TRANSACTION @V_TRANS_NAME

	-- rollback tồn kho xuất chi tiết
	DELETE @V_KhoPhieuXuatChiTiet
	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId			,TaiSanId 				,SoLuong
				,DonGia					,NguonNganSachId		,NhaCungCapId
				,KhoNhanId				,KhoXuatId
			)
	SELECT		kpxct.KhoPhieuXuatId	,kpxct.TaiSanId			,kpxct.SoLuong
				,kpxct.DonGia			,kpxct.NguonNganSachId	,kpxct.NhaCungCapId
				,kpx.KhoNhanId			,kpx.KhoXuatId
	FROM KhoPhieuXuatChiTiet kpxct
		left join KhoPhieuXuat kpx on kpxct.KhoPhieuXuatId = kpx.KhoPhieuXuatId
	where kpx.KhoPhieuXuatId = @KhoPhieuXuatId

	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL

	while EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
	begin
		SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia
		FROM @V_KhoPhieuXuatChiTiet

		SELECT TOP 1 @V_TonCuoi = TonDau + SLNhap - SLXuat FROM KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		
		if @V_TonCuoi is not null
		begin
			UPDATE dbo.KhoTonKhoChiTiet 
			SET SLXuat = SLXuat - @V_SoLuong 
			WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		end

		DELETE @V_KhoPhieuXuatChiTiet WHERE RowId = @V_RowId
		SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL
	end

	-- rollback tồn kho nhập chi tiết
	DELETE @V_KhoPhieuXuatChiTiet
	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId			,TaiSanId 				,SoLuong
				,DonGia					,NguonNganSachId		,NhaCungCapId
				,KhoNhanId				,KhoXuatId
			)
	SELECT		kpxct.KhoPhieuXuatId	,kpxct.TaiSanId			,kpxct.SoLuong
				,kpxct.DonGia			,kpxct.NguonNganSachId	,kpxct.NhaCungCapId
				,kpx.KhoNhanId			,kpx.KhoXuatId
	FROM KhoPhieuXuatChiTiet kpxct
		left join KhoPhieuXuat kpx on kpxct.KhoPhieuXuatId = kpx.KhoPhieuXuatId
	where kpx.KhoPhieuXuatId = @KhoPhieuXuatId

	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL

	while EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
	begin
		SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia
		FROM @V_KhoPhieuXuatChiTiet

		SELECT TOP 1 @V_TonCuoi = TonDau + SLNhap - SLXuat FROM KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KN_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		
		if @V_TonCuoi is not null
		begin
			UPDATE dbo.KhoTonKhoChiTiet 
			SET SLNhap = SLNhap - @V_SoLuong 
			WHERE KhoTonKhoId = @V_KN_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		end

		DELETE @V_KhoPhieuXuatChiTiet WHERE RowId = @V_RowId
		SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL
	end

	-- update phiếu xuất
	UPDATE	KhoPhieuXuat
	SET		 SoPhieu		=	@SoPhieu
			,NgayXuat		=	@NgayXuat
			,Loai			=	@Loai
			,KhoXuatId		=	@KhoXuatId
			,KhoNhanId		=	@KhoNhanId
			,NguoiNhanHang	=	@NguoiNhanHang
			,LyDo			=	@LyDo
			,CoSoId			=	@CoSoId
			,NguoiTao		=	@NguoiTao
			,NgayTao		=	@NgayTao
			,CtrVersion		=	@CtrVersion
	WHERE	KhoPhieuXuatId	=	@KhoPhieuXuatId

	-- update phiếu xuất chi tiết
	DELETE KhoPhieuXuatChiTiet WHERE KhoPhieuXuatId = @KhoPhieuXuatId

	INSERT INTO	KhoPhieuXuatChiTiet
			(
				 KhoPhieuXuatId		,TaiSanId		,SoLuong
				,DonGia				,GiaMua			,GiaBan
				,NguonNganSachId	,NhaCungCapId	,HanDung
				,LoSanXuat
			)
	SELECT		 @KhoPhieuXuatId	,TaiSanId		,SoLuong
				,DonGia				,GiaMua			,GiaBan
				,NguonNganSachId	,NhaCungCapId	,HanDung
				,LoSanXuat
	FROM		@ChiTiet

	-- update tồn kho xuất chi tiết
	DELETE @V_KhoPhieuXuatChiTiet
	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId			,TaiSanId 				,SoLuong
				,DonGia					,NguonNganSachId		,NhaCungCapId
				,KhoNhanId				,KhoXuatId
			)
	SELECT		kpxct.KhoPhieuXuatId	,kpxct.TaiSanId			,kpxct.SoLuong
				,kpxct.DonGia			,kpxct.NguonNganSachId	,kpxct.NhaCungCapId
				,kpx.KhoNhanId			,kpx.KhoXuatId
	FROM KhoPhieuXuatChiTiet kpxct
		left join KhoPhieuXuat kpx on kpxct.KhoPhieuXuatId = kpx.KhoPhieuXuatId
	where kpx.KhoPhieuXuatId = @KhoPhieuXuatId

	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL

	while EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
	begin
		SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia
		FROM @V_KhoPhieuXuatChiTiet

		SELECT TOP 1 @V_TonCuoi = TonDau + SLNhap - SLXuat FROM KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		
		if @V_TonCuoi is not null and @V_TonCuoi < @V_SoLuong
		begin
			SET @MESSAGE	=	N'SOLUONGXUAT|1|Số lượng xuất lớn hơn số lượng tồn';
			THROW 51000, @MESSAGE, 1;
		end

		if @V_TonCuoi is not null
		begin
			UPDATE dbo.KhoTonKhoChiTiet 
			SET SLXuat = SLXuat + @V_SoLuong
			WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		end
		else
		begin
			INSERT dbo.KhoTonKhoChiTiet
				(	 KhoTonKhoId		,TaiSanId		,DonGia
					,GiaMua				,GiaBan			,TonDau
					,SLNhap				,SLXuat			,NguonNganSachId
					,NhaCungCapId		,HanDung		,LoSanXuat
				)
			SELECT	@V_KX_KhoTonKhoId	,TaiSanId		,DonGia
					,0					,0				,0
					,0					,SoLuong		,NguonNganSachId
					,NhaCungCapId		,NULL			,NULL
			from @V_KhoPhieuXuatChiTiet
			where RowId = @V_RowId
		end

		DELETE @V_KhoPhieuXuatChiTiet WHERE RowId = @V_RowId
		SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL
	end

	-- update tồn kho nhập chi tiết
	DELETE @V_KhoPhieuXuatChiTiet
	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId			,TaiSanId 				,SoLuong
				,DonGia					,NguonNganSachId		,NhaCungCapId
				,KhoNhanId				,KhoXuatId
			)
	SELECT		kpxct.KhoPhieuXuatId	,kpxct.TaiSanId			,kpxct.SoLuong
				,kpxct.DonGia			,kpxct.NguonNganSachId	,kpxct.NhaCungCapId
				,kpx.KhoNhanId			,kpx.KhoXuatId
	FROM KhoPhieuXuatChiTiet kpxct
		left join KhoPhieuXuat kpx on kpxct.KhoPhieuXuatId = kpx.KhoPhieuXuatId
	where kpx.KhoPhieuXuatId = @KhoPhieuXuatId

	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL

	while EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
	begin
		SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia
		FROM @V_KhoPhieuXuatChiTiet

		SELECT TOP 1 @V_TonCuoi = TonDau + SLNhap - SLXuat FROM KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KN_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		
		if @V_TonCuoi is not null and @V_TonCuoi + @V_SoLuong < 0
		begin
			SET @MESSAGE	=	N'SOLUONGNHAP|1|Tồn cuối nhỏ hơn 0';
			THROW 51000, @MESSAGE, 1;
		end

		if @V_TonCuoi is not null
		begin
			UPDATE dbo.KhoTonKhoChiTiet 
			SET SLNhap = SLNhap + @V_SoLuong
			WHERE KhoTonKhoId = @V_KN_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		end
		else
		begin
			INSERT dbo.KhoTonKhoChiTiet
				(	 KhoTonKhoId		,TaiSanId		,DonGia
					,GiaMua				,GiaBan			,TonDau
					,SLNhap				,SLXuat			,NguonNganSachId
					,NhaCungCapId		,HanDung		,LoSanXuat
				)
			SELECT	@V_KN_KhoTonKhoId	,TaiSanId		,DonGia
					,0					,0				,0
					,SoLuong			,0				,NguonNganSachId
					,NhaCungCapId		,NULL			,NULL
			from @V_KhoPhieuXuatChiTiet
			where RowId = @V_RowId
		end

		DELETE @V_KhoPhieuXuatChiTiet WHERE RowId = @V_RowId
		SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL
	end

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME
	
	DECLARE  @ErrorMessage	NVARCHAR(MAX)	=	ERROR_MESSAGE()
			,@ErrorSeverity INT				=	ERROR_SEVERITY()
			,@ErrorState	INT				=	ERROR_STATE()

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
	SELECT * FROM KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuatKhac_DeleteKhoPhieuXuat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.25
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuatKhac_DeleteKhoPhieuXuat]
						@KhoPhieuXuatId			=	21

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6

						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.25 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuatKhac_DeleteKhoPhieuXuat]
	@KhoPhieuXuatId			INT				=	NULL

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- BIẾN NỘI BỘ
DECLARE  @V_TRANS_NAME		NVARCHAR(MAX)	=	N'KPX_DELETE'

-- INPUT DEFAULT
SET @NHANVIEN_ID	= ISNULL(@NHANVIEN_ID,0)
SET @COSO_ID	= ISNULL(@COSO_ID,0)
SET @MESSAGE	= ISNULL(@MESSAGE,'')

BEGIN TRY
	declare @V_KhoaSoLieu bit
		,@V_KX_KhoTonKhoId int
		,@V_KN_KhoTonKhoId int
		,@CoSoId int
		,@KhoXuatId int
		,@KhoNhanId int
		,@V_ThangNam varchar(4)

	select @CoSoId = CoSoId
		,@KhoXuatId = KhoXuatId
		,@KhoNhanId = KhoNhanId
		,@V_ThangNam = format(NgayXuat,'MMyy')
	from KhoPhieuXuat
	where KhoPhieuXuatId = @KhoPhieuXuatId

	-- kiểm tra khóa số liệu kho xuất
	set @V_KhoaSoLieu = null

	select @V_KhoaSoLieu = TrangThai
		,@V_KX_KhoTonKhoId = KhoTonKhoId
	from KhoTonKho 
	where KhoTaiSanId = @KhoXuatId
		and CoSoId = @CoSoId
		and ThangNam = @V_ThangNam

	IF @V_KhoaSoLieu = 1
	BEGIN
		SET @MESSAGE	=	N'KHOASOLIEU|1|Đã khóa số liệu kho xuất. Không thể thay đổi thông tin phiếu xuất';
		THROW 51000, @MESSAGE, 1;
	END

	-- bảng tạm lưu chi tiết
	DECLARE @V_KhoPhieuXuatChiTiet TABLE
	(
		RowId int IDENTITY(1, 1),
		KhoPhieuXuatId int NULL,
		TaiSanId int NULL,
		SoLuong numeric(18, 4) NULL,
		DonGia numeric(18, 4) NULL,
		NguonNganSachId int NULL,
		NhaCungCapId int NULL,
		KhoNhanId int NULL,
		KhoXuatId int NULL
	)
	declare	 @V_RowId int
		,@V_TaiSanId int
		,@V_DonGia numeric (18, 4)
		,@V_SoLuong numeric (18, 4)
		,@V_TonCuoi numeric (18, 4)

print @KhoPhieuXuatId
	IF @KhoPhieuXuatId = 0
	BEGIN
		SET @MESSAGE	=	N'PHIEUXUATID|1|Không tìm thấy thông tin';
		THROW 51000, @MESSAGE, 1;
	END
	BEGIN TRANSACTION @V_TRANS_NAME

	SELECT * FROM KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId

	-- rollback tồn kho xuất chi tiết
	DELETE @V_KhoPhieuXuatChiTiet
	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId			,TaiSanId 				,SoLuong
				,DonGia					,NguonNganSachId		,NhaCungCapId
				,KhoNhanId				,KhoXuatId
			)
	SELECT		kpxct.KhoPhieuXuatId	,kpxct.TaiSanId			,kpxct.SoLuong
				,kpxct.DonGia			,kpxct.NguonNganSachId	,kpxct.NhaCungCapId
				,kpx.KhoNhanId			,kpx.KhoXuatId
	FROM KhoPhieuXuatChiTiet kpxct
		left join KhoPhieuXuat kpx on kpxct.KhoPhieuXuatId = kpx.KhoPhieuXuatId
	where kpx.KhoPhieuXuatId = @KhoPhieuXuatId

	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL

	while EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
	begin
		SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia
		FROM @V_KhoPhieuXuatChiTiet

		SELECT TOP 1 @V_TonCuoi = TonDau + SLNhap - SLXuat FROM KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia

		if @V_TonCuoi is not null and @V_TonCuoi < @V_SoLuong
		begin
			SET @MESSAGE	=	N'SOLUONGXUAT|1|Số lượng xuất lớn hơn số lượng tồn';
			THROW 51000, @MESSAGE, 1;
		end

		if @V_TonCuoi is not null
		begin
			UPDATE dbo.KhoTonKhoChiTiet 
			SET SLXuat = SLXuat - @V_SoLuong 
			WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		end

		DELETE @V_KhoPhieuXuatChiTiet WHERE RowId = @V_RowId
		SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL
	end

	-- xóa thông tin phiếu xuất khác
	DELETE KhoPhieuXuatChiTiet WHERE KhoPhieuXuatId = @KhoPhieuXuatId
	DELETE KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME
	
	DECLARE  @ErrorMessage	NVARCHAR(MAX)	=	ERROR_MESSAGE()
			,@ErrorSeverity INT				=	ERROR_SEVERITY()
			,@ErrorState	INT				=	ERROR_STATE()

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
	SELECT * FROM KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuatKhac_GetKhoPhieuXuatById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.24
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuatKhac_GetKhoPhieuXuatById]
						 @KHOPHIEUXUATID		=	'20'

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6
						,@FUNCTIONCODE			=	'CN0046'
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.24 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuatKhac_GetKhoPhieuXuatById]
	 @KHOPHIEUXUATID		VARCHAR(MAX)	=	NULL

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@FUNCTIONCODE			VARCHAR(MAX)	=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- INPUT DEFAULT
SET @KHOPHIEUXUATID =	ISNULL(@KHOPHIEUXUATID,'')
IF @KHOPHIEUXUATID =''
	SET @KHOPHIEUXUATID = 0;

SELECT		KPX.*
			,CS.TenCoSo
			,NV.TenNhanVien TenNguoiTao
FROM		KhoPhieuXuat KPX
			LEFT JOIN CoSo CS ON KPX.CoSoId = CS.CoSoId
			LEFT JOIN NhanVien NV ON KPX.NguoiTao = NV.NhanVienId
WHERE		KPX.KhoPhieuXuatId = @KHOPHIEUXUATID
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuatKhac_GetKhoPhieuXuatChiTietById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.25
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuatKhac_GetKhoPhieuXuatChiTietById]
						 @KHOPHIEUXUATID		=	'20'

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6
						,@FUNCTIONCODE			=	'CN0046'
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.25 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuatKhac_GetKhoPhieuXuatChiTietById]
	 @KHOPHIEUXUATID		VARCHAR(MAX)	=	NULL

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@FUNCTIONCODE			VARCHAR(MAX)	=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- INPUT DEFAULT
SET @KHOPHIEUXUATID =	ISNULL(@KHOPHIEUXUATID,'')
IF @KHOPHIEUXUATID =''
	SET @KHOPHIEUXUATID = 0;

SELECT		COUNT(KPXCT.KhoPhieuXuatChiTietId) OVER () AS MAXCNT
			,KPXCT.*
			,NNS.TenNguonNganSach
			,TS.TenTaiSan,TS.DonViTinh
FROM		KhoPhieuXuatChiTiet KPXCT
			LEFT JOIN NguonNganSach NNS ON KPXCT.NguonNganSachId = NNS.NguonNganSachId
			LEFT JOIN TaiSan TS ON KPXCT.TaiSanId = TS.TaiSanId
WHERE		KPXCT.KhoPhieuXuatId = @KHOPHIEUXUATID
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuatKhac_GetListKhoPhieuXuatByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.24
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuatKhac_GetListKhoPhieuXuatByCriteria]
						 @SEARCH				=	NULL
						,@SOPHIEU				=	''
						,@KHOPHIEUXUATID		=	''
						,@COSOID				=	NULL
						,@NHANVIENID			=	NULL

						,@FIELD					=	NULL
						,@ORDERCLAUSE			=	'KPX.KhoPhieuXuatId DESC'
						,@SKIP					=	0
						,@TAKE					=	10

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6
						,@FUNCTIONCODE			=	'CN0046'
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.24 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuatKhac_GetListKhoPhieuXuatByCriteria]
	 @SEARCH				NVARCHAR(MAX)	=	NULL
	,@SOPHIEU				VARCHAR(MAX)	=	NULL
	,@KHOPHIEUXUATID		VARCHAR(MAX)	=	NULL
	,@COSOID				VARCHAR(MAX)	=	NULL
	,@NHANVIENID			VARCHAR(MAX)	=	NULL
	,@KHOTAISANID			VARCHAR(MAX)	=	NULL
	,@STARTDATE				VARCHAR(MAX)	=	NULL
	,@ENDDATE				VARCHAR(MAX)	=	NULL

	,@FIELD					VARCHAR(MAX)	=	NULL
	,@ORDERCLAUSE			VARCHAR(MAX)	=	NULL
	,@SKIP					INT				=	NULL
	,@TAKE					INT				=	NULL

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@FUNCTIONCODE			VARCHAR(MAX)	=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- BIẾN NỘI BỘ
DECLARE  @V_SQL			NVARCHAR(MAX)	=	N''
		,@V_SEARCH		NVARCHAR(MAX)	=	N''
		,@V_ISVIEW		VARCHAR(MAX)	=	N''
		,@V_COSO_IDS	VARCHAR(MAX)	=	N''
		,@V_DELIMITER	VARCHAR(MAX)	=	N'|'
		 ,@ThangNam	VARCHAR(MAX)	=	NULL
			--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSoTaiSanLauBen @LOAITHONGSO='SoLieuThangNam',@NHANVIEN=@NHANVIEN_ID,@ThangNam=@ThangNam OUTPUT;
	
		PRINT('Thangnam:'+@ThangNam ) 
		PRINT('NHANVIENID:'+@NHANVIENID ) 

-- INPUT DEFAULT
SET @SEARCH			=	ISNULL(@SEARCH,'')
SET @KHOPHIEUXUATID =	ISNULL(@KHOPHIEUXUATID,'')
SET @SOPHIEU		=	ISNULL(@SOPHIEU,'')
SET @COSOID			=	ISNULL(@COSOID,'')
SET @NHANVIENID		=	ISNULL(@NHANVIENID,'')

SET @ORDERCLAUSE	=	ISNULL(@ORDERCLAUSE,'')
SET @SKIP			=	ISNULL(@SKIP,0)
SET @TAKE			=	ISNULL(@TAKE,0)
SET @MESSAGE		=	ISNULL(@MESSAGE,'')

SET @V_SEARCH		=	'%' + @SEARCH + '%'

SET @FIELD			=	ISNULL(@FIELD,'')
IF @FIELD = ''
	SET @FIELD = 'KPX.*'

BEGIN TRY
	--SET @MESSAGE	=	N'MA_TAI_SAN|1|MÃ NÀY ĐÃ TỒN TẠI';
	--THROW 51000, @MESSAGE, 1;

	-- KIỂM TRA QUYỀN VIEW
	EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NHANVIEN_ID,
		@CO_SO_ID = @COSO_ID,
		@CHUC_NANG = @FUNCTIONCODE,
		@QUYEN=@V_ISVIEW OUTPUT
	--/ KIỂM TRA QUYỀN VIEW

	-- DANH SÁCH CƠ SỞ TRƯC THUỘC
	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
		@COSOID=@COSO_ID
		,@COSOID_OUT=@V_COSO_IDS OUTPUT
	SET @V_COSO_IDS = REPLACE(@V_COSO_IDS,',',@V_DELIMITER)
	--/ DANH SÁCH CƠ SỞ TRƯC THUỘC

	SET @V_SQL = N'
		SELECT		COUNT(KPX.KhoPhieuXuatId) OVER () AS MAXCNT,' + @FIELD + '
					,KPX.KhoPhieuXuatId ID,KPX.CtrVersion CTRVERSION
					,NV.TenNhanVien TenNguoiTao
		FROM		KhoPhieuXuat KPX
					LEFT JOIN NhanVien NV ON KPX.NguoiTao = NV.NhanVienId
		WHERE		(
					@V_ISVIEW IN (''VA'')
					OR (@V_ISVIEW IN (''VB'',''VR'') AND CHARINDEX(@V_DELIMITER + CAST(KPX.CoSoId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @V_COSO_IDS + @V_DELIMITER) > 0)
					OR (@V_ISVIEW IN (''VE'') AND KPX.NguoiTao = @NHANVIEN_ID)
					)
					AND (
						@SEARCH = ''''
						OR KPX.SoPhieu LIKE @V_SEARCH
						OR KPX.LyDo LIKE @V_SEARCH
						OR KPX.Loai LIKE @V_SEARCH
						OR KPX.NguoiNhanHang LIKE @V_SEARCH
					)
					AND (@SOPHIEU = '''' OR KPX.SoPhieu = @SOPHIEU)
					AND KPX.Loai = ''XK''
					AND (@STARTDATE = '''' OR KPX.NgayXuat >= @STARTDATE)
					AND (@ENDDATE = '''' OR KPX.NgayXuat <= @ENDDATE)
					AND (@KHOTAISANID = '''' OR KPX.KhoXuatId = @KHOTAISANID)
					AND (@KHOPHIEUXUATID = '''' OR CHARINDEX(@V_DELIMITER + CAST(KPX.KhoPhieuXuatId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @KHOPHIEUXUATID + @V_DELIMITER) > 0)
					AND FORMAT(KPX.NgayXuat, ''MMyy'')=@ThangNam';
	IF @ORDERCLAUSE <> ''
		SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDERCLAUSE

	IF @ORDERCLAUSE <> '' AND @TAKE > 0
		SET @V_SQL = @V_SQL + ' OFFSET ' + CAST(@SKIP AS VARCHAR(20)) + ' ROWS FETCH NEXT ' + CAST(@TAKE AS VARCHAR(20)) + ' ROWS ONLY '

	PRINT @V_SQL

	EXEC SP_EXECUTESQL @V_SQL,N'
		 @COSO_ID				INT				=	NULL
		,@NHANVIEN_ID			INT				=	NULL
		,@FUNCTIONCODE			VARCHAR(MAX)	=	NULL

		,@SEARCH				NVARCHAR(MAX)	=	NULL
		,@KHOPHIEUXUATID		VARCHAR(MAX)	=	NULL
		,@SOPHIEU				VARCHAR(MAX)	=	NULL
		,@COSOID				VARCHAR(MAX)	=	NULL
		,@NHANVIENID			VARCHAR(MAX)	=	NULL
		,@KHOTAISANID			VARCHAR(MAX)	=	NULL
		,@STARTDATE				VARCHAR(MAX)	=	NULL
		,@ENDDATE				VARCHAR(MAX)	=	NULL

		,@V_SEARCH				NVARCHAR(MAX)	=	NULL
		,@V_ISVIEW				VARCHAR(MAX)	=	NULL
		,@V_COSO_IDS			VARCHAR(MAX)	=	NULL
		,@V_DELIMITER			VARCHAR(MAX)	=	NULL
		,@ThangNam				VARCHAR(MAX)	=	NULL
		'
		,@COSO_ID								=	@COSO_ID
		,@NHANVIEN_ID							=	@NHANVIEN_ID
		,@FUNCTIONCODE							=	@FUNCTIONCODE

		,@SEARCH								=	@SEARCH
		,@KHOPHIEUXUATID						=	@KHOPHIEUXUATID
		,@SOPHIEU								=	@SOPHIEU
		,@COSOID								=	@COSOID
		,@NHANVIENID							=	@NHANVIENID
		,@KHOTAISANID							=	@KHOTAISANID
		,@STARTDATE								=	@STARTDATE
		,@ENDDATE								=	@ENDDATE

		,@V_SEARCH								=	@V_SEARCH
		,@V_ISVIEW								=	@V_ISVIEW
		,@V_COSO_IDS							=	@V_COSO_IDS
		,@V_DELIMITER							=	@V_DELIMITER
		,@ThangNam								=	@ThangNam

END TRY
BEGIN CATCH
	DECLARE  @ErrorMessage	NVARCHAR(MAX)	=	ERROR_MESSAGE()
			,@ErrorSeverity INT				=	ERROR_SEVERITY()
			,@ErrorState	INT				=	ERROR_STATE()

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuatKhac_InsertKhoPhieuXuat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.24
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @ChiTiet KhoPhieuXuatChiTietTableType
					INSERT INTO @ChiTiet	 (KhoPhieuXuatChiTietId	,KhoPhieuXuatId	,TaiSanId	,SoLuong	,DonGia	,GiaMua	,GiaBan	,NguonNganSachId	,NhaCungCapId	,HanDung	,LoSanXuat	)
								VALUES		 (0						,0				,1061		,5			,20000	,10		,20		,1					,1				,N'1'		,N'1'		)

					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuatKhac_InsertKhoPhieuXuat]
						@KhoPhieuXuatId			=	NULL
						,@SoPhieu				=	N'test003'
						,@NgayXuat				=	'2017-09-24 00:00:00'
						,@Loai					=	N'CK'
						,@KhoXuatId				=	4
						,@KhoNhanId				=	1
						,@NguoiNhanHang			=	N'21212'
						,@LyDo					=	NULL
						,@CoSoId				=	0
						,@NguoiTao				=	0
						,@NgayTao				=	'2017-10-24 04:18:30.687'
						,@CtrVersion			=	0

						,@ChiTiet				=	@ChiTiet

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6

						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.24 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuatKhac_InsertKhoPhieuXuat]
	@KhoPhieuXuatId			INT				=	NULL
	,@SoPhieu				VARCHAR(MAX)	=	NULL
	,@NgayXuat				DATETIME		=	NULL
	,@Loai					VARCHAR(MAX)	=	NULL
	,@KhoXuatId				INT				=	NULL
	,@KhoNhanId				INT				=	NULL
	,@NguoiNhanHang			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@CoSoId				INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	,@ChiTiet				KhoPhieuXuatChiTietTableType		READONLY

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- BIẾN NỘI BỘ
DECLARE  @V_TRANS_NAME		NVARCHAR(MAX)	=	N'KPX_INSERT'
	,@V_ThangNam varchar(4)
-- INPUT DEFAULT
SET @NHANVIEN_ID	= ISNULL(@NHANVIEN_ID,0)
SET @COSO_ID	= ISNULL(@COSO_ID,0)
SET @MESSAGE	= ISNULL(@MESSAGE,'')

SET @NgayTao	= ISNULL(@NgayTao, GETDATE())

SET @NguoiTao	= ISNULL(@NguoiTao, 0)
IF @NguoiTao = 0
	SET @NguoiTao	= @NHANVIEN_ID

SET @CoSoId	= ISNULL(@CoSoId, 0)
IF @CoSoId = 0
	SET @CoSoId	= @COSO_ID

set @V_ThangNam = format(@NgayXuat,'MMyy')

BEGIN TRY
	--SET @MESSAGE	=	N'MA_TAI_SAN|1|MÃ NÀY ĐÃ TỒN TẠI';
	--THROW 51000, @MESSAGE, 1;

	-- kiểm tra khóa số liệu kho xuất
	declare @V_KX_KhoaSoLieu bit
		,@V_KX_KhoTonKhoId int

	select @V_KX_KhoaSoLieu = TrangThai
		,@V_KX_KhoTonKhoId = KhoTonKhoId
	from KhoTonKho 
	where KhoTaiSanId = @KhoXuatId
		and CoSoId = @CoSoId
		and ThangNam = @V_ThangNam

	IF @V_KX_KhoaSoLieu = 1
	BEGIN
		SET @MESSAGE	=	N'KHOASOLIEU|1|Đã khóa số liệu kho xuất. Không thể thêm phiếu xuất';
		THROW 51000, @MESSAGE, 1;
	END

	-- kiểm tra số phiếu
	IF EXISTS (SELECT 1 FROM KhoPhieuXuat WHERE SoPhieu = @SoPhieu)
	BEGIN
		SET @MESSAGE	=	N'SOPHIEU|1|Số phiếu đã tồn tại';
		THROW 51000, @MESSAGE, 1;
	END

	-- bảng tạm lưu chi tiết
	DECLARE @V_KhoPhieuXuatChiTiet TABLE
	(
		RowId int IDENTITY(1, 1),
		KhoPhieuXuatId int NULL,
		TaiSanId int NULL,
		SoLuong numeric(18, 4) NULL,
		DonGia numeric(18, 4) NULL,
		NguonNganSachId int NULL,
		NhaCungCapId int NULL,
		HanDung varchar(10) NULL,
		LoSanXuat varchar(10) NULL
	)
	declare	 @V_RowId int
			,@V_TaiSanId int
			,@V_DonGia numeric (18, 4)
			,@V_SoLuong numeric (18, 4)
			,@V_TonCuoi numeric (18, 4)

	BEGIN TRANSACTION @V_TRANS_NAME

	-- thêm thông tin KhoPhieuXuat
	INSERT	KhoPhieuXuat
			(
			 SoPhieu					,NgayXuat				,Loai
			,KhoXuatId					,KhoNhanId				,NguoiNhanHang
			,LyDo						,CoSoId					,NguoiTao
			,NgayTao					,CtrVersion
			)
	VALUES	(
			 @SoPhieu					,@NgayXuat				,@Loai
			,@KhoXuatId					,NULL					,@NguoiNhanHang
			,@LyDo						,@CoSoId				,@NguoiTao
			,@NgayTao					,@CtrVersion
			)

	SET @KhoPhieuXuatId = @@IDENTITY

	-- thêm thông tin KhoPhieuXuatChiTiet
	INSERT INTO	KhoPhieuXuatChiTiet
			(
				 KhoPhieuXuatId		,TaiSanId		,SoLuong
				,DonGia				,GiaMua			,GiaBan
				,NguonNganSachId	,NhaCungCapId	,HanDung
				,LoSanXuat
			)
	SELECT		 @KhoPhieuXuatId	,TaiSanId		,SoLuong
				,DonGia				,GiaMua			,GiaBan
				,NguonNganSachId	,NhaCungCapId	,HanDung
				,LoSanXuat
	FROM		@ChiTiet

	-- update tồn kho xuất
	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=null
	
	DELETE @V_KhoPhieuXuatChiTiet
	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId		,TaiSanId 		,SoLuong
				,DonGia				,HanDung		,LoSanXuat
				,NguonNganSachId	,NhaCungCapId	
			)
	SELECT		KhoPhieuXuatId		,TaiSanId		,SoLuong
				,DonGia				,HanDung		,LoSanXuat
				,NguonNganSachId	,NhaCungCapId	
	FROM @ChiTiet

	if @V_KX_KhoTonKhoId is null
	begin
		insert KhoTonKho	(KhoTaiSanId	,CoSoId		,ThangNam		,TrangThai	,NguoiTao		,NgayTao	,CtrVersion	)
		select				@KhoNhanId		,@CoSoId	,@V_ThangNam	,0			,@NHANVIEN_ID	,@NgayTao	,1
	
		SET @V_KX_KhoTonKhoId = @@IDENTITY
		
		insert dbo.KhoTonKhoChiTiet
			(	 KhoTonKhoId		,TaiSanId	,DonGia
				,GiaMua				,GiaBan		,TonDau
				,SLNhap				,SLXuat		,NguonNganSachId
				,NhaCungCapId		,HanDung	,LoSanXuat
			)
		select	@V_KX_KhoTonKhoId	,TaiSanId	,DonGia
				,0					,0			,0
				,SUM(SoLuong)		,0			,NguonNganSachId
				,NhaCungCapId		,''			,''
				from @ChiTiet
				group by TaiSanId,DonGia,NguonNganSachId,NhaCungCapId
	end
	else
	begin
		WHILE EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
		BEGIN
			SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia
			FROM @V_KhoPhieuXuatChiTiet
			
			SELECT TOP 1 @V_TonCuoi = TonDau + SLNhap - SLXuat FROM KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia

			if @V_TonCuoi is not null and @V_TonCuoi < @V_SoLuong
			begin
				SET @MESSAGE	=	N'SOLUONGXUAT|1|Số lượng xuất lớn hơn số lượng tồn';
				THROW 51000, @MESSAGE, 1;
			end

			IF @V_TonCuoi is not null
			BEGIN
				UPDATE dbo.KhoTonKhoChiTiet SET SLXuat = SLXuat + @V_SoLuong WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
			END
			ELSE
            BEGIN
				INSERT dbo.KhoTonKhoChiTiet
					(	 KhoTonKhoId		,TaiSanId		,DonGia
						,GiaMua				,GiaBan			,TonDau
						,SLNhap				,SLXuat			,NguonNganSachId
						,NhaCungCapId		,HanDung		,LoSanXuat
					)
				SELECT	@V_KX_KhoTonKhoId	,TaiSanId		,DonGia
						,0					,0				,0
						,0					,SoLuong		,NguonNganSachId
						,NhaCungCapId		,NULL			,NULL
				from @V_KhoPhieuXuatChiTiet
				where RowId = @V_RowId
			END

			DELETE @V_KhoPhieuXuatChiTiet WHERE RowId= @V_RowId
			SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL
		END
	end

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	DECLARE  @ErrorMessage	NVARCHAR(MAX)	=	ERROR_MESSAGE()
			,@ErrorSeverity INT				=	ERROR_SEVERITY()
			,@ErrorState	INT				=	ERROR_STATE()

	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
	SELECT * FROM KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoPhieuXuatKhac_UpdateKhoPhieuXuat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.25
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @ChiTiet KhoPhieuXuatChiTietTableType
					INSERT INTO @ChiTiet	 (KhoPhieuXuatChiTietId	,KhoPhieuXuatId	,TaiSanId	,SoLuong	,DonGia	,GiaMua	,GiaBan	,NguonNganSachId	,NhaCungCapId	,HangDung	,LoSanXuat	)
								VALUES		 (0						,0				,1061		,1			,20000	,10		,20		,1					,1				,N'1'		,N'1'		)

					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuatKhac_UpdateKhoPhieuXuat]
						@KhoPhieuXuatId			=	NULL
						,@SoPhieu				=	N'121212'
						,@NgayXuat				=	'2017-10-24 00:00:00'
						,@Loai					=	N'CK'
						,@KhoXuatId				=	1
						,@KhoNhanId				=	4
						,@NguoiNhanHang			=	N'21212'
						,@LyDo					=	NULL
						,@CoSoId				=	0
						,@NguoiTao				=	0
						,@NgayTao				=	'2017-10-24 04:18:30.687'
						,@CtrVersion			=	0

						,@ChiTiet				=	@ChiTiet

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6

						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.25 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoPhieuXuatKhac_UpdateKhoPhieuXuat]
	@KhoPhieuXuatId			INT				=	NULL
	,@SoPhieu				VARCHAR(MAX)	=	NULL
	,@NgayXuat				DATETIME		=	NULL
	,@Loai					VARCHAR(MAX)	=	NULL
	,@KhoXuatId				INT				=	NULL
	,@KhoNhanId				INT				=	NULL
	,@NguoiNhanHang			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@CoSoId				INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	,@ChiTiet				KhoPhieuXuatChiTietTableType		READONLY

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- BIẾN NỘI BỘ
DECLARE  @V_TRANS_NAME		NVARCHAR(MAX)	=	N'KPX_UPDATE'
	,@V_ThangNam varchar(4)

-- INPUT DEFAULT
SET @NHANVIEN_ID	= ISNULL(@NHANVIEN_ID,0)
SET @COSO_ID	= ISNULL(@COSO_ID,0)
SET @MESSAGE	= ISNULL(@MESSAGE,'')

SET @NgayTao	= ISNULL(@NgayTao, GETDATE())

SET @NguoiTao	= ISNULL(@NguoiTao, 0)
IF @NguoiTao = 0
	SET @NguoiTao	= @NHANVIEN_ID

SET @CoSoId	= ISNULL(@CoSoId, 0)
IF @CoSoId = 0
	SET @CoSoId	= @COSO_ID

set @V_ThangNam = format(@NgayXuat,'MMyy')

set @KhoNhanId = null

BEGIN TRY
	declare @V_KhoaSoLieu bit
		,@V_KX_KhoTonKhoId int
		,@V_KN_KhoTonKhoId int

	-- kiểm tra khóa số liệu kho xuất
	set @V_KhoaSoLieu = null

	select @V_KhoaSoLieu = TrangThai
		,@V_KX_KhoTonKhoId = KhoTonKhoId
	from KhoTonKho 
	where KhoTaiSanId = @KhoXuatId
		and CoSoId = @CoSoId
		and ThangNam = @V_ThangNam

	IF @V_KhoaSoLieu = 1
	BEGIN
		SET @MESSAGE	=	N'KHOASOLIEU|1|Đã khóa số liệu kho xuất. Không thể thay đổi thông tin phiếu xuất';
		THROW 51000, @MESSAGE, 1;
	END

	-- kiểm tra số phiếu
	IF EXISTS (SELECT 1 FROM KhoPhieuXuat WHERE SoPhieu = @SoPhieu AND KhoPhieuXuatId <> @KhoPhieuXuatId)
	BEGIN
		SET @MESSAGE	=	N'SOPHIEU|1|Số phiếu đã tồn tại';
		THROW 51000, @MESSAGE, 1;
	END

	-- bảng tạm lưu chi tiết
	DECLARE @V_KhoPhieuXuatChiTiet TABLE
	(
		RowId int IDENTITY(1, 1),
		KhoPhieuXuatId int NULL,
		TaiSanId int NULL,
		SoLuong numeric(18, 4) NULL,
		DonGia numeric(18, 4) NULL,
		NguonNganSachId int NULL,
		NhaCungCapId int NULL,
		KhoNhanId int NULL,
		KhoXuatId int NULL
	)
	declare	 @V_RowId int
		,@V_TaiSanId int
		,@V_DonGia numeric (18, 4)
		,@V_SoLuong numeric (18, 4)
		,@V_TonCuoi numeric (18, 4)

	BEGIN TRANSACTION @V_TRANS_NAME

	-- rollback tồn kho xuất chi tiết
	DELETE @V_KhoPhieuXuatChiTiet
	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId			,TaiSanId 				,SoLuong
				,DonGia					,NguonNganSachId		,NhaCungCapId
				,KhoNhanId				,KhoXuatId
			)
	SELECT		kpxct.KhoPhieuXuatId	,kpxct.TaiSanId			,kpxct.SoLuong
				,kpxct.DonGia			,kpxct.NguonNganSachId	,kpxct.NhaCungCapId
				,kpx.KhoNhanId			,kpx.KhoXuatId
	FROM KhoPhieuXuatChiTiet kpxct
		left join KhoPhieuXuat kpx on kpxct.KhoPhieuXuatId = kpx.KhoPhieuXuatId
	where kpx.KhoPhieuXuatId = @KhoPhieuXuatId

	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL

	while EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
	begin
		SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia
		FROM @V_KhoPhieuXuatChiTiet

		SELECT TOP 1 @V_TonCuoi = TonDau + SLNhap - SLXuat FROM KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		
		if @V_TonCuoi is not null
		begin
			UPDATE dbo.KhoTonKhoChiTiet 
			SET SLXuat = SLXuat - @V_SoLuong 
			WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		end

		DELETE @V_KhoPhieuXuatChiTiet WHERE RowId = @V_RowId
		SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL
	end

	-- update phiếu xuất
	UPDATE	KhoPhieuXuat
	SET		 SoPhieu		=	@SoPhieu
			,NgayXuat		=	@NgayXuat
			,Loai			=	@Loai
			,KhoXuatId		=	@KhoXuatId
			,KhoNhanId		=	@KhoNhanId
			,NguoiNhanHang	=	@NguoiNhanHang
			,LyDo			=	@LyDo
			,CoSoId			=	@CoSoId
			,NguoiTao		=	@NguoiTao
			,NgayTao		=	@NgayTao
			,CtrVersion		=	@CtrVersion
	WHERE	KhoPhieuXuatId	=	@KhoPhieuXuatId

	-- update phiếu xuất chi tiết
	DELETE KhoPhieuXuatChiTiet WHERE KhoPhieuXuatId = @KhoPhieuXuatId

	INSERT INTO	KhoPhieuXuatChiTiet
			(
				 KhoPhieuXuatId		,TaiSanId		,SoLuong
				,DonGia				,GiaMua			,GiaBan
				,NguonNganSachId	,NhaCungCapId	,HanDung
				,LoSanXuat
			)
	SELECT		 @KhoPhieuXuatId	,TaiSanId		,SoLuong
				,DonGia				,GiaMua			,GiaBan
				,NguonNganSachId	,NhaCungCapId	,HanDung
				,LoSanXuat
	FROM		@ChiTiet

	-- update tồn kho xuất chi tiết
	DELETE @V_KhoPhieuXuatChiTiet
	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId			,TaiSanId 				,SoLuong
				,DonGia					,NguonNganSachId		,NhaCungCapId
				,KhoNhanId				,KhoXuatId
			)
	SELECT		kpxct.KhoPhieuXuatId	,kpxct.TaiSanId			,kpxct.SoLuong
				,kpxct.DonGia			,kpxct.NguonNganSachId	,kpxct.NhaCungCapId
				,kpx.KhoNhanId			,kpx.KhoXuatId
	FROM KhoPhieuXuatChiTiet kpxct
		left join KhoPhieuXuat kpx on kpxct.KhoPhieuXuatId = kpx.KhoPhieuXuatId
	where kpx.KhoPhieuXuatId = @KhoPhieuXuatId

	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL

	while EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
	begin
		SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia
		FROM @V_KhoPhieuXuatChiTiet

		SELECT TOP 1 @V_TonCuoi = TonDau + SLNhap - SLXuat FROM KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		
		if @V_TonCuoi is not null and @V_TonCuoi < @V_SoLuong
		begin
			SET @MESSAGE	=	N'SOLUONGXUAT|1|Số lượng xuất lớn hơn số lượng tồn';
			THROW 51000, @MESSAGE, 1;
		end

		if @V_TonCuoi is not null
		begin
			UPDATE dbo.KhoTonKhoChiTiet 
			SET SLXuat = SLXuat + @V_SoLuong
			WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		end
		else
		begin
			INSERT dbo.KhoTonKhoChiTiet
				(	 KhoTonKhoId		,TaiSanId		,DonGia
					,GiaMua				,GiaBan			,TonDau
					,SLNhap				,SLXuat			,NguonNganSachId
					,NhaCungCapId		,HanDung		,LoSanXuat
				)
			SELECT	@V_KX_KhoTonKhoId	,TaiSanId		,DonGia
					,0					,0				,0
					,0					,SoLuong		,NguonNganSachId
					,NhaCungCapId		,NULL			,NULL
			from @V_KhoPhieuXuatChiTiet
			where RowId = @V_RowId
		end

		DELETE @V_KhoPhieuXuatChiTiet WHERE RowId = @V_RowId
		SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL
	end

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME
	
	DECLARE  @ErrorMessage	NVARCHAR(MAX)	=	ERROR_MESSAGE()
			,@ErrorSeverity INT				=	ERROR_SEVERITY()
			,@ErrorState	INT				=	ERROR_STATE()

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
	SELECT * FROM KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoTaiSan_cbxKhoTaiSanByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.19
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_KhoTaiSan_cbxKhoTaiSanByCriteria]
						 @SEARCH		=	N'CHÍNH'
						,@KHOTAISANIDS	=	''
						,@MAKHOTAISAN	=	''
						,@COSOID		=	''
						,@FUNCTIONCODE	=	''
						,@COSO_ID		=	1
						,@NHANVIEN_ID	=	6
6. Precaution	:
7. History		:
				  2017.10.19 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_KhoTaiSan_cbxKhoTaiSanByCriteria]
	 @SEARCH		NVARCHAR(MAX)	=	NULL
	,@KHOTAISANIDS	VARCHAR(MAX)	=	NULL
	,@MAKHOTAISAN	VARCHAR(MAX)	=	NULL
	,@COSOID		VARCHAR(MAX)	=	NULL
	,@FUNCTIONCODE	VARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL	
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------
DECLARE	 @V_DELIMITER	VARCHAR(10)		=	'|'
		,@V_ISVIEW		VARCHAR(MAX)	=	'VB'
		,@V_SEARCH		NVARCHAR(MAX)	=	NULL
		,@V_SQL			NVARCHAR(MAX)	=	NULL

SET @COSO_ID = ISNULL(@COSO_ID,0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID,0)

SET @SEARCH = ISNULL(@SEARCH,'')
SET @V_SEARCH = '%' + @SEARCH + '%'
SET @KHOTAISANIDS = ISNULL(@KHOTAISANIDS,'')
SET @MAKHOTAISAN = ISNULL(@MAKHOTAISAN,'')
SET @COSOID = ISNULL(@COSOID,'')

SET @V_SQL = N'
	SELECT		TOP 10 COUNT(KHOTS.KhoTaiSanId) OVER () AS MAXCNT
				,KHOTS.*
				,NV.TenNhanVien TenNguoiTao
				,CS.TenCoSo TenCoSo
	FROM		KhoTaiSan KHOTS
				LEFT JOIN CoSo CS ON KHOTS.CoSoId = CS.CoSoId
				LEFT JOIN NhanVien NV ON KHOTS.NGUOITAO = NV.NHANVIENID
	WHERE		(
					@V_ISVIEW IN (''VA'')
					OR (@V_ISVIEW IN (''VB'',''VR'') AND KHOTS.CoSoId = @COSO_ID)
					OR (@V_ISVIEW IN (''VE'') AND KHOTS.NguoiTao = @NHANVIEN_ID)
				)
				AND (@SEARCH = '''' OR KHOTS.TenKhoTaiSan LIKE  @V_SEARCH OR KHOTS.MaKhoTaiSan LIKE @V_SEARCH)
				AND (@KHOTAISANIDS = '''' OR CHARINDEX(@V_DELIMITER + CAST(KHOTS.KhoTaiSanId AS VARCHAR(10)) + @V_DELIMITER, @V_DELIMITER + @KHOTAISANIDS + @V_DELIMITER) > 0)
				AND (@MAKHOTAISAN = '''' OR KHOTS.MaKhoTaiSan = @MAKHOTAISAN)
				AND (@COSOID = '''' OR KHOTS.CoSoId = @COSOID)
'
PRINT @V_SQL
exec sp_executesql @V_SQL,N'
	 @SEARCH		NVARCHAR(MAX)
	,@V_SEARCH		NVARCHAR(MAX)
	,@KHOTAISANIDS	VARCHAR(MAX)
	,@MAKHOTAISAN	VARCHAR(MAX)
	,@COSOID		VARCHAR(MAX)
	,@COSO_ID		INT
	,@NHANVIEN_ID	INT
	,@V_DELIMITER	VARCHAR(10)
	,@V_ISVIEW		VARCHAR(MAX)
'
	,@SEARCH		=	@SEARCH
	,@V_SEARCH		=	@V_SEARCH
	,@KHOTAISANIDS	=	@KHOTAISANIDS
	,@MAKHOTAISAN	=	@MAKHOTAISAN
	,@COSOID		=	@COSOID
	,@COSO_ID		=	@COSO_ID
	,@NHANVIEN_ID	=	@NHANVIEN_ID
	,@V_DELIMITER	=	@V_DELIMITER
	,@V_ISVIEW		=	@V_ISVIEW
--------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_KhoTaiSan_GetListKhoTaiSanByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KhoTaiSan_GetListKhoTaiSanByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------


		DECLARE @IS_VIEW varchar(10) = '0'
	   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
	  @NHAN_VIEN_ID = @NhanVienId,
	  @CO_SO_ID = @CoSoId,
	  @CHUC_NANG = 'CN0013',
	  @QUYEN=@IS_VIEW OUTPUT
	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.KhoTaiSanId,a.MaKhoTaiSan,a.TenKhoTaiSan,a.GhiChu,nv.TenNhanVien HoTen,a.NgayTao
	FROM KhoTaiSan a LEFT JOIN [NhanVien] nv on a.NguoiTao=nv.NhanVienId where 1=1 ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (MaKhoTaiSan LIKE N''%' +@Search+ '%'' OR TenKhoTaiSan LIKE  N''%' +@Search+ '%'')';


		IF @IS_VIEW = 'VB' 
		 BEGIN    
		   SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';   
		 END
		   IF @IS_VIEW = 'VR' 
		 BEGIN    
		   SET @V_SQL = @V_SQL + ' and nv.PhongBanId = (select PhongBanId from NhanVien where NhanVienId=''' + @NhanVienId + ''')';   
		 END
		  IF @IS_VIEW = 'VE' 
		 BEGIN    
		   SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @NhanVienId + '''';   
		 END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KhoTonKho_checkKhoTonKho]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_KhoTonKho_checkKhoTonKho]
( 
	@KhoTaiSanId INT,
	@TaiSanId INT,
	@ThangNam varchar(4),
	@DonGia numeric(18,4)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	select COUNT(*) as NumberRow from KhoTonKhoChiTiet a inner join KhoTonKho b on a.KhoTonKhoId=b.KhoTonKhoId where b.KhoTaiSanId=@KhoTaiSanId and a.TaiSanId=@TaiSanId and b.ThangNam=@ThangNam and a.DonGia=@DonGia

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_KhoTonKho_DeleteKhoTonKho]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KhoTonKho_DeleteKhoTonKho]
( 
	  @KhoTonKhoId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
	if(Exists(select * from KhoTonKho where KhoTonKhoId = @KhoTonKhoId and TrangThai=0 ))
		begin
		Delete KhoTonKhoChiTiet where KhoTonKhoId = @KhoTonKhoId
		Delete KhoTonKho where KhoTonKhoId = @KhoTonKhoId
		select @@ROWCOUNT
		end
	else
	BEGIN
		RAISERROR ('Số liệu đã khóa !', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );   RETURN
	END
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KhoTonKho_GetListKhoTonKhoByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KhoTonKho_GetListKhoTonKhoByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------


		DECLARE @IS_VIEW varchar(10) = '0'
		   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		  @NHAN_VIEN_ID = @NhanVienId,
		  @CO_SO_ID = @CoSoId,
		  @CHUC_NANG = 'CN0045',
		  @QUYEN=@IS_VIEW OUTPUT
	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT,a.*,nv.TenNhanVien as HoTen,c.TenKhoTaiSan
	FROM KhoTonKho a LEFT JOIN NhanVien nv on a.NguoiTao=nv.NhanVienId 
	LEFT JOIN KhoTaiSan c on a.KhoTaiSanId=c.KhoTaiSanId 
	where 1=1  and a.CoSoId =''' + @CoSoId + '''';  

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (a.ThangNam LIKE N''%' +@Search+ '%'' OR c.TenKhoTaiSan LIKE  N''%' +@Search+ '%'')';



	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY a.ThangNam'

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KhoTonKho_GetListKhoTonKhoById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_KhoTonKho_GetListKhoTonKhoById]
( 
	@KhoTaiSanId INT,
	@ThangNam varchar(4),
	@KhoTonKhoId INT,
	@CoSoId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	Select a.KhoTonKhoId,a.KhoTaiSanId,c.TenKhoTaiSan,a.CoSoId,a.ThangNam,a.TrangThai,b.TaiSanId,d.MaTaiSan,d.TenTaiSan,d.DonViTinh,
	b.DonGia,b.GiaMua,b.GiaBan,b.TonDau,b.TonDau * b.DonGia as SoTien,b.NguonNganSachId,e.TenNguonNganSach,b.NhaCungCapId,f.TenNhaCungCap,b.HanDung,b.LoSanXuat
	 from KhoTonKho a 
	inner join KhoTonKhoChiTiet b on a.KhoTonKhoId=b.KhoTonKhoId
	inner join KhoTaiSan c on a.KhoTaiSanId=c.KhoTaiSanId
	inner join TaiSan d on b.TaiSanId=d.TaiSanId
	left join NguonNganSach e on b.NguonNganSachId=e.NguonNganSachId
	left join NhaCungCap f on b.NhaCungCapId=f.NhaCungCapId
	where (a.KhoTonKhoId =@KhoTonKhoId or (a.KhoTaiSanId = @KhoTaiSanId and a.ThangNam = @ThangNam ) ) and a.CoSoId=@CoSoId and b.TonDau>0

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_KhoTonKho_GetListKhoTonKhoChiTietByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KhoTonKho_GetListKhoTonKhoChiTietByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null	
	,@KhoTaiSanId		varchar(500)		= null	
	,@ThangNam			varchar(4)		= null	
	,@KhoTonKhoId		varchar(500)		= null	
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------


		DECLARE @IS_VIEW varchar(10) = '0'
		   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		  @NHAN_VIEN_ID = @NhanVienId,
		  @CO_SO_ID = @CoSoId,
		  @CHUC_NANG = 'CN0045',
		  @QUYEN=@IS_VIEW OUTPUT
	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	Select COUNT(*) OVER () AS MAXCNT, a.KhoTonKhoId,b.KhoTonKhoChiTietId,a.KhoTaiSanId,c.TenKhoTaiSan,a.CoSoId,a.ThangNam,a.TrangThai,b.TaiSanId,d.MaTaiSan,d.TenTaiSan,d.DonViTinh,
	b.DonGia,b.GiaMua,b.GiaBan,b.TonDau,b.TonDau * b.DonGia as SoTien,b.NguonNganSachId,e.TenNguonNganSach,b.NhaCungCapId,f.TenNhaCungCap,b.HanDung,b.LoSanXuat,a.TrangThai
	 from KhoTonKho a 
	inner join KhoTonKhoChiTiet b on a.KhoTonKhoId=b.KhoTonKhoId
	inner join KhoTaiSan c on a.KhoTaiSanId=c.KhoTaiSanId
	inner join TaiSan d on b.TaiSanId=d.TaiSanId
	left join NguonNganSach e on b.NguonNganSachId=e.NguonNganSachId
	left join NhaCungCap f on b.NhaCungCapId=f.NhaCungCapId where a.CoSoId =''' + @CoSoId + ''' and b.TonDau>0';  

	-- Build Where clause
	-- Where clause Quick search
	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (MaTaiSan LIKE N''%' +@Search+ '%'' OR TenTaiSan LIKE  N''%' +@Search+ '%'')';
	IF @KhoTonKhoId <> 0
	SET @V_SQL = @V_SQL + ' and a.KhoTonKhoId =''' +@KhoTonKhoId+ '''';
	else
	SET @V_SQL = @V_SQL + ' and a.KhoTaiSanId =''' + @KhoTaiSanId + ''' and a.ThangNam =''' +@ThangNam+'''';

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY d.TenTaiSan' ;

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_KhoTonKho_GetListTonKhoByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_KhoTonKho_GetListTonKhoByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
	, @KhoTaiSanId	    nvarchar(500)	= null		
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 
	DECLARE @V_SEARCH_STRING NVARCHAR(4000),@ThangNam	VARCHAR(MAX)	=	NULL
			--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSoTaiSanLauBen @LOAITHONGSO='SoLieuThangNam',@NHANVIEN=@NhanVienId,@ThangNam=@ThangNam OUTPUT; 



	----------


		DECLARE @IS_VIEW varchar(10) = '0'
		   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		  @NHAN_VIEN_ID = @NhanVienId,
		  @CO_SO_ID = @CoSoId,
		  @CHUC_NANG = 'CN0054',
		  @QUYEN=@IS_VIEW OUTPUT
	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	Select COUNT(*) OVER () AS MAXCNT, a.KhoTonKhoId,b.KhoTonKhoChiTietId,a.KhoTaiSanId,c.TenKhoTaiSan,a.CoSoId,a.ThangNam,a.TrangThai,b.TaiSanId,d.MaTaiSan,d.TenTaiSan,d.DonViTinh,
	b.DonGia,b.GiaMua,b.GiaBan,(b.TonDau + b.SLNhap - b.SLXuat) as TonKho,(b.TonDau + b.SLNhap - b.SLXuat) * b.DonGia as SoTien,b.NguonNganSachId,e.TenNguonNganSach,b.NhaCungCapId,f.TenNhaCungCap,b.HanDung,b.LoSanXuat,a.TrangThai
	 from KhoTonKho a 
	inner join KhoTonKhoChiTiet b on a.KhoTonKhoId=b.KhoTonKhoId
	inner join KhoTaiSan c on a.KhoTaiSanId=c.KhoTaiSanId
	inner join TaiSan d on b.TaiSanId=d.TaiSanId
	left join NguonNganSach e on b.NguonNganSachId=e.NguonNganSachId
	left join NhaCungCap f on b.NhaCungCapId=f.NhaCungCapId where a.CoSoId =''' + @CoSoId + ''' and (b.TonDau + b.SLNhap - b.SLXuat)>0 and a.ThangNam='''+@ThangNam+'''';  

	-- Build Where clause
	-- Where clause Quick search
	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (MaTaiSan LIKE N''%' +@Search+ '%'' OR TenTaiSan LIKE  N''%' +@Search+ '%'')';
	IF @KhoTaiSanId <> ''
	SET @V_SQL = @V_SQL + ' and a.KhoTaiSanId =''' +@KhoTaiSanId+ '''';
	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY d.TenTaiSan' ;

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LapBaoCao_DeleteLapBaoCaoById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_LapBaoCao_DeleteLapBaoCaoById]
	@LapBaoCaoId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	
	BEGIN TRAN
		
		BEGIN TRY
			DELETE dbo.LapBaoCao WHERE LapBaoCaoId = @LapBaoCaoId
			DELETE dbo.LapBaoCaoChiTiet WHERE LapBaoCaoId = @LapBaoCaoId
			
			SELECT @@ROWCOUNT ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_LapBaoCao_DeleteLapBaoCaoChiTietById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_LapBaoCao_DeleteLapBaoCaoChiTietById]
	@LapBaoCaoId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	
	BEGIN TRAN
		
		BEGIN TRY
			
			DELETE dbo.LapBaoCaoChiTiet WHERE LapBaoCaoId = @LapBaoCaoId
			
			SELECT @@ROWCOUNT ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_LapBaoCao_GetLapBaoCaoById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_LapBaoCao_GetLapBaoCaoById]
( 
	  @LapBaoCaoId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.LapBaoCaoId,a.KyBaoCao,CONVERT(VARCHAR(10),a.TuNgay,103) as TuNgay,CONVERT(VARCHAR(10),a.DenNgay,103) as DenNgay,Case when a.KyBaoCao =1 then N'Năm' else Case when a.KyBaoCao =2 then N'Quí' else Case when a.KyBaoCao =3 then N'Tháng' else  N'Ngày' end end end as TenKyBaoCao  ,nv.TenNhanVien as HoTen,d.TrangThai,
	a.DienGiai,a.CoSoId,a.NoiDungDuyet,a.DuyetId,a.NgayTao,a.NgayGui,a.GuiCapTren,a.CtrVersion
	FROM LapBaoCao a LEFT JOIN [dbo].[NhanVien] nv on a.NguoiTao=nv.NhanVienId 
	left join Duyet d on a.DuyetId=d.DuyetId
	where a.LapBaoCaoId = @LapBaoCaoId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LapBaoCao_GetLapBaoCaoChiTietById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_LapBaoCao_GetLapBaoCaoChiTietById]
( 
	  @LapBaoCaoId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT  a.*,b.TenBaoCao,b.Report,c.TrangThai,CONVERT(VARCHAR(10),d.TuNgay,103) as TuNgay,CONVERT(VARCHAR(10),d.DenNgay,103) as DenNgay
	from LapBaoCaoChiTiet  a 
	inner join BaoCao b on a.BaoCaoId = b.BaoCaoId
	left join Duyet c on c.DuyetId = a.DuyetId 
	left join LapBaoCao d on d.LapBaoCaoId = a.LapBaoCaoId 
	where a.LapBaoCaoId= @LapBaoCaoId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LapBaoCao_GetListDMBaoCao]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_LapBaoCao_GetListDMBaoCao]
(
	 @CoSoId	        int		
	, @NhanVienId	    int		
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT  * from BaoCao
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LapBaoCao_GetListLapBaoCaoByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_LapBaoCao_GetListLapBaoCaoByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------

	
		DECLARE @IS_VIEW varchar(10) = '0'
	   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
	  @NHAN_VIEN_ID = @NhanVienId,
	  @CO_SO_ID = @CoSoId,
	  @CHUC_NANG = 'CN0004',
	  @QUYEN=@IS_VIEW OUTPUT
	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.*,Case when a.KyBaoCao =1 then N''Năm'' else Case when a.KyBaoCao =2 then N''Quí'' else Case when a.KyBaoCao =3 then N''Tháng'' else  N''Ngày'' end end end as TenKyBaoCao  ,nv.TenNhanVien as HoTen,d.TrangThai
	FROM LapBaoCao a LEFT JOIN [dbo].[NhanVien] nv on a.NguoiTao=nv.NhanVienId 
	left join Duyet d on a.DuyetId=d.DuyetId
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=a.NguoiTao
	where 1=1 ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (MaLapBaoCao LIKE N''%' +@Search+ '%'' OR TenLapBaoCao LIKE  N''%' +@Search+ '%'')';


		IF @IS_VIEW = 'VB' 
 BEGIN    
   SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';   
 END
   IF @IS_VIEW = 'VR' 
	BEGIN    
	SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @NhanVienId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
  IF @IS_VIEW = 'VE' 
 BEGIN    
   SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @NhanVienId + '''';   
 END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LoaiTaiSan_cbxLoaiTaiSanByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.08
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_LoaiTaiSan_cbxLoaiTaiSanByCriteria]
						 @Search			=	N''
						,@LoaiId			=	N''
						,@MaLoai			=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.08 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROC [dbo].[sp_LoaiTaiSan_cbxLoaiTaiSanByCriteria]
( 
	 @Search			NVARCHAR(500)   =	NULL
	,@LoaiId			INT				=	NULL
	,@MaLoai			NVARCHAR(500)	=	NULL
	,@CoSoId			NVARCHAR(500)	=	NULL
	,@NhanVienId		NVARCHAR(500)	=	NULL
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	SET @Search				=	ISNULL(@Search,'')
	SET @LoaiId				=	ISNULL(@LoaiId, 0)
	SET @MaLoai				=	ISNULL(@MaLoai,'')

	SELECT TOP 10 LTS.*
	FROM	LoaiTaiSan LTS
	WHERE	(@LoaiId = 0 OR LTS.LoaiId = @LoaiId)
			AND (@MaLoai = '' OR LTS.MaLoai = @MaLoai)
			AND (@Search = '' OR LTS.MaLoai LIKE N'%' + @Search + '%' OR LTS.TenLoai LIKE N'%' + @Search + '%')
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LoaiTaiSan_GetListLoaiTaiSanByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_LoaiTaiSan_GetListLoaiTaiSanByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------
	DECLARE @IS_VIEW varchar(10) = '0'
   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
  @NHAN_VIEN_ID = @NhanVienId,
  @CO_SO_ID = @CoSoId,
  @CHUC_NANG = 'CN0005',
  @QUYEN=@IS_VIEW OUTPUT
	

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.LoaiId,a.MaLoai,a.TenLoai,b.TenNhom,a.GhiChu,c.TenNhanVien as HoTen,a.NgayTao
	FROM LoaiTaiSan a Inner join NhomTaiSan b on a.NhomId=b.NhomId LEFT JOIN NhanVien c on a.NguoiTao=c.NhanVienId where 1=1 ' 

	-- Build Where clause
	-- Where clause Quick search
	
	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (a.MaLoai LIKE N''%' +@Search+ '%'' OR a.TenLoai LIKE  N''%' +@Search+ '%'')';

	--	IF @IS_VIEW_ALL = '0' 
	--BEGIN			 
	--		SET @V_SQL = @V_SQL + ' and b.CoSoId =''' + @CoSoId + '''';	  
	--END
	
	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LoaiTaiSan_GetLoaiTaiSanById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROC [dbo].[sp_LoaiTaiSan_GetLoaiTaiSanById]
( 
	  @LoaiId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.LoaiId,a.MaLoai,a.TenLoai,b.NhomId,b.MaNhom,b.TenNhom,a.GhiChu,a.CtrVersion
	FROM LoaiTaiSan a Inner join NhomTaiSan b on a.NhomId=b.NhomId where a.LoaiId = @LoaiId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LoaiXe_cbxLoaiXeByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.06
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_LoaiXe_cbxLoaiXeByCriteria]
						 @Search			=	N''
						,@LoaiXeId	=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.06 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
create PROCEDURE [dbo].[sp_LoaiXe_cbxLoaiXeByCriteria]
( 
	 @Search				NVARCHAR(500)   =	NULL
	,@LoaiXeId		INT				=	NULL
	,@CoSoId				NVARCHAR(500)	=	NULL			
	,@NhanVienId			NVARCHAR(500)	=	NULL		
	
)
AS  
BEGIN
SET NOCOUNT ON 
------------------------------------------------  
	SET @Search				=	ISNULL(@Search,'')
	SET @LoaiXeId	=	ISNULL(@LoaiXeId, 0)

	SELECT TOP 10 LX.*
	FROM	LoaiXe LX
	WHERE	(@LoaiXeId = 0 OR LX.LoaiXeId = @LoaiXeId)
			AND (@Search = '' OR LX.NoiDung LIKE N'%' + @Search + '%')
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LogData_InsertLogData]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROC [dbo].[sp_LogData_InsertLogData]
( 
	  @Ngay	        nvarchar(500)	= null,			
	  @MaChucNang   nvarchar(500)	= null,	
	  @DoiTuongId   nvarchar(500)	= null,	
	  @SuKien       nvarchar(500)	= null,	
	  @NoiDung      nvarchar(500)	= null,	
	  @NguoiTao	        nvarchar(500)	= null
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
BEGIN TRY  
    Insert into LogData values(@Ngay,@MaChucNang,@DoiTuongId,@SuKien,@NoiDung,@NguoiTao)
END TRY  
BEGIN CATCH  
END CATCH  

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_NguonNganSach_cbxNguonNganSachByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.08
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_NguonNganSach_cbxNguonNganSachByCriteria]
						 @Search			=	N''
						,@NguonNganSachId	=	N''
						,@MaNguonNganSach	=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.08 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROC [dbo].[sp_NguonNganSach_cbxNguonNganSachByCriteria]
( 
	 @Search			NVARCHAR(500)   =	NULL
	,@NguonNganSachId	VARCHAR(MAX)	=	NULL
	,@MaNguonNganSach	NVARCHAR(500)	=	NULL
	,@CoSoId			NVARCHAR(500)	=	NULL
	,@NhanVienId		NVARCHAR(500)	=	NULL
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	SET @Search				=	ISNULL(@Search,'')
	SET @NguonNganSachId	=	ISNULL(@NguonNganSachId, '')
	SET @MaNguonNganSach	=	ISNULL(@MaNguonNganSach,'')

	SELECT TOP 10 NNS.*
	FROM	NguonNganSach NNS
	WHERE	(@NguonNganSachId = '' OR NNS.NguonNganSachId = @NguonNganSachId)
			AND (@MaNguonNganSach = '' OR NNS.MaNguonNganSach = @MaNguonNganSach)
			AND (@Search = '' OR NNS.MaNguonNganSach LIKE N'%' + @Search + '%' OR NNS.MaNguonNganSach LIKE N'%' + @Search + '%')
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_NguonNganSach_GetListNguonNganSachByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_NguonNganSach_GetListNguonNganSachByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------

	--DECLARE @IS_VIEW_ALL varchar = '0'
 -- 	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
	--	@LOGINID = @CoSoId,
	--	@CHUC_NANG = 'CN0011',
	--	@QUYEN_TAC_VU = 'View All',
	--	@YES_NO=@IS_VIEW_ALL OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.NguonNganSachId,a.MaNguonNganSach,a.TenNguonNganSach,a.GhiChu,b.TenNhanVien asHoTen,a.NgayTao
	FROM NguonNganSach a LEFT JOIN NhanVien b on a.NguoiTao=b.NhanVienId where 1=1 ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (MaNguonNganSach LIKE N''%' +@Search+ '%'' OR TenNguonNganSach LIKE  N''%' +@Search+ '%'')';


	--	IF @IS_VIEW_ALL = '0' 
	--BEGIN			 
	--		SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';	  
	--END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_NhaCungCap_cbxNhaCungCapByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.08
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_NhaCungCap_cbxNhaCungCapByCriteria]
						 @Search			=	N''
						,@NhaCungCapId		=	N''
						,@MaNhaCungCap		=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.08 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROC [dbo].[sp_NhaCungCap_cbxNhaCungCapByCriteria]
( 
	 @Search			NVARCHAR(500)   =	NULL
	,@NhaCungCapId		VARCHAR(MAX)	=	NULL
	,@MaNhaCungCap		NVARCHAR(500)	=	NULL
	,@CoSoId			NVARCHAR(500)	=	NULL
	,@NhanVienId		NVARCHAR(500)	=	NULL
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	SET @Search				=	ISNULL(@Search,'')
	SET @NhaCungCapId		=	ISNULL(@NhaCungCapId, '')
	SET @MaNhaCungCap		=	ISNULL(@MaNhaCungCap,'')

	SELECT TOP 10 NCC.*
	FROM	NhaCungCap NCC
	WHERE	NCC.CoSoId = @CoSoId
			AND (@NhaCungCapId = '' OR NCC.NhaCungCapId = @NhaCungCapId)
			AND (@MaNhaCungCap = '' OR NCC.MaNhaCungCap = @MaNhaCungCap)
			AND (@Search = '' OR NCC.MaNhaCungCap LIKE N'%' + @Search + '%' OR NCC.TenNhaCungCap LIKE N'%' + @Search + '%')
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_NhaCungCap_GetListNhaCungCapByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_NhaCungCap_GetListNhaCungCapByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhaCungCapId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------
	DECLARE @IS_VIEW varchar(10) = '0'
   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
  @NHAN_VIEN_ID = '0',
  @CO_SO_ID = @CoSoId,
  @CHUC_NANG = 'CN00012',
  @QUYEN=@IS_VIEW OUTPUT


	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.NhaCungCapId,a.MaNhaCungCap,a.TenNhaCungCap,a.DienThoai,a.DiaChi,a.GhiChu,b.TenNhanVien as HoTen,a.NgayTao
	FROM NhaCungCap a LEFT JOIN NhanVien b on a.NguoiTao=b.NhanVienId where 1=1 and a.CoSoId =''' + @CoSoId + ''''

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (MaNhaCungCap LIKE N''%' +@Search+ '%'' OR TenNhaCungCap LIKE  N''%' +@Search+ '%'')';



	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_NhanVien_cbxNhanVienByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_NhanVien_cbxNhanVienByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.NhanVienId,a.MaNhanVien,a.TenNhanVien,pbnv.PhongBanId
	FROM NhanVien a  LEFT JOIN (SELECT pbnv.NhanVienId,b.CoSoId,
		STUFF((
				select CONCAT( ',' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('')
			),1,1,'') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId,b.CoSoId) pbnv ON pbnv.NhanVienId=a.NhanVienId
	Where pbnv.CoSoId = @CoSoId

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_NhanVien_cbxNhanVienByPhongBanId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.16
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_NhanVien_cbxNhanVienByPhongBanId]
						 @CoSoId	        =	16
						,@NhanVienId	    =	10
						,@Search			=	NULL
						,@FunctionCode		=	'CN0024'
						,@PhongBanId		=	11
						,@IDNhanVien		=	NULL
6. Precaution	:
7. History		:
				  2017.10.16 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_NhanVien_cbxNhanVienByPhongBanId]
( 
	  @CoSoId	        nvarchar(500)	= null
	, @NhanVienId	    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @PhongBanId		INT				= 0
	, @IDNhanVien		INT				= 0
	
)
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------  
SET @PhongBanId = ISNULL(@PhongBanId,0)
SET @IDNhanVien = ISNULL(@IDNhanVien,0)

PRINT CONCAT('@PhongBanId = ',@PhongBanId)

	SELECT a.NhanVienId,a.MaNhanVien,a.TenNhanVien,c.PhongBanId
	FROM NhanVien a  inner join dbo.PhongBanNhanVien c on a.NhanVienId=c.NhanVienId
	Where	(@PhongBanId = 0 OR c.PhongBanId = @PhongBanId)
			AND (@IDNhanVien = 0 OR a.NhanVienId = @IDNhanVien)

--------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_NhanVien_cbxNhanVienByPhongBanId_171016]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROC [dbo].[sp_NhanVien_cbxNhanVienByPhongBanId_171016]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @PhongBanId		INT				= 0
	, @IDNhanVien		INT				= 0
	
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
	IF(@IDNhanVien IS NULL) SET @IDNhanVien = 0

	SELECT a.NhanVienId,a.MaNhanVien,a.TenNhanVien,a.PhongBanId
	FROM NhanVien a  inner join PhongBan c on a.PhongBanId=c.PhongBanId
	Where c.CoSoId = @CoSoId
	AND a.PhongBanId = @PhongBanId
	AND (@IDNhanVien = 0 OR a.NhanVienId = @IDNhanVien)

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_NhanVien_DeleteNhanVienById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_NhanVien_DeleteNhanVienById]
	@NhanVienId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			DELETE dbo.PhongBanNhanVien WHERE NhanVienId = @NhanVienId
			DELETE dbo.NhanVien WHERE NhanVienId = @NhanVienId
			
			SELECT @@ROWCOUNT ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_NhanVien_GetListNhanVienByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_NhanVien_GetListNhanVienByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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
		DECLARE @TenPhongBan NVARCHAR(max)


	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------
	DECLARE @IS_VIEW varchar(10) = '0'
   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
  @NHAN_VIEN_ID = @NhanVienId,
  @CO_SO_ID = @CoSoId,
  @CHUC_NANG = 'CN0005',
  @QUYEN=@IS_VIEW OUTPUT


	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.NhanVienId,a.MaNhanVien,a.TenNhanVien,a.DienThoai,a.GhiChu,nv.TenNhanVien as HoTen,a.NgayTao,PB.TenPhongBan
	FROM NhanVien a 
	JOIN 
	(
		SELECT pbnv.NhanVienId,b.CoSoId,
		STUFF((
				select CONCAT( '', '' ,u1.TenPhongBan)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') TenPhongBan
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId,b.CoSoId
	) AS PB ON PB.NhanVienId = a.NhanVienId
	LEFT JOIN [dbo].[NhanVien] nv on a.NguoiTao=nv.NhanVienId where 1=1  ' 

	-- Build Where clause
	-- Where clause Quick search
	
	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (a.MaNhanVien LIKE N''%' +@Search+ '%'' OR a.TenNhanVien LIKE  N''%' +@Search+ '%'')';

		IF @IS_VIEW = 'VB' 
 BEGIN    
   SET @V_SQL = @V_SQL + ' and PB.CoSoId =''' + @CoSoId + '''';   
 END
   IF @IS_VIEW = 'VR' 
 BEGIN    
   SET @V_SQL = @V_SQL + ' and nv.PhongBanId = (select PhongBanId from NhanVien where NhanVienId=''' + @NhanVienId + ''')';   
 END
  IF @IS_VIEW = 'VE' 
 BEGIN    
   SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @NhanVienId + '''';   
 END
	

	SET @V_SQL = @V_SQL + ' GROUP BY a.NhanVienId,a.MaNhanVien,a.TenNhanVien,a.DienThoai,a.GhiChu,nv.TenNhanVien,a.NgayTao,PB.TenPhongBan '
	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_NhanVien_GetNhanVienById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_NhanVien_GetNhanVienById]
( 
	  @NhanVienId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.NhanVienId,a.MaNhanVien,a.TenNhanVien,b.PhongBanId,b.MaPhongBan,b.TenPhongBan,a.ChucDanh,a.Email,a.DiaChi,a.DienThoai,a.GhiChu,a.CtrVersion
	FROM NhanVien a
	JOIN dbo.PhongBanNhanVien nvpb ON nvpb.NhanVienId = a.NhanVienId
	Inner join PhongBan b on nvpb.PhongBanId=b.PhongBanId where a.NhanVienId = @NhanVienId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_NhanVien_InsertNhanVien]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_NhanVien_InsertNhanVien]
	@PhongBanId NVARCHAR(500),
	@MaNhanVien VARCHAR(50),
	@TenNhanVien NVARCHAR(200),
	@DienThoai VARCHAR(15),
	@Email VARCHAR(100),
	@ChucDanh NVARCHAR(200),
	@DiaChi NVARCHAR(500),
	@GhiChu NVARCHAR(500),
	@NguoiTao INT,
	@CoSoId INT

as
BEGIN
	Declare @ErrMsg nvarchar(max), @NhanVienId INT

	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.NhanVien
			        ( MaNhanVien ,		TenNhanVien ,		ChucDanh ,
			          DienThoai ,		Email ,				DiaChi ,
			          GhiChu ,			NguoiTao ,			NgayTao ,
			          CtrVersion
			        )
			SELECT	 @MaNhanVien,		@TenNhanVien,		@ChucDanh,
					 @DienThoai,		@Email,				@DiaChi,
					 @GhiChu,			@NguoiTao,			GETDATE(),
					 1

			SELECT @NhanVienId = SCOPE_IDENTITY()
			SELECT @NhanVienId  AS NhanVienIdI

			INSERT dbo.PhongBanNhanVien( PhongBanId, NhanVienId, CoSoId )
			SELECT Item, @NhanVienId, @CoSoId
			FROM dbo.DelimitedSplit8K(@PhongBanId,',') WHERE Item <> ''

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_NhanVien_UpdateNhanVien]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_NhanVien_UpdateNhanVien]
	@NhanvienId INT,
	@PhongBanId NVARCHAR(500),
	@MaNhanVien VARCHAR(50),
	@TenNhanVien NVARCHAR(200),
	@DienThoai VARCHAR(15),
	@Email VARCHAR(100),
	@ChucDanh NVARCHAR(200),
	@DiaChi NVARCHAR(500),
	@GhiChu NVARCHAR(500),
	@NguoiTao INT,
	@CoSoId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			
			UPDATE dbo.NhanVien
			SET MaNhanVien = @MaNhanVien,
				TenNhanVien = @TenNhanVien,
				DienThoai = @DienThoai,
				ChucDanh = @ChucDanh,
				Email = @Email,
				DiaChi = @DiaChi,
				GhiChu = @GhiChu,
				CtrVersion = CtrVersion + 1
			WHERE NhanVienId = @NhanvienId
			
			DELETE dbo.PhongBanNhanVien WHERE NhanVienId = @NhanvienId AND CoSoId = @CoSoId

			INSERT dbo.PhongBanNhanVien( PhongBanId, NhanVienId, CoSoId )
			SELECT Item, @NhanVienId, @CoSoId
			FROM dbo.DelimitedSplit8K(@PhongBanId,',') WHERE Item <> ''

			SELECT * FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv ON pbnv.NhanVienId = nv.NhanVienId AND nv.NhanVienId = @NhanvienId
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_NhomTaiSan_cbxNhomTaiSanByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROC [dbo].[sp_NhomTaiSan_cbxNhomTaiSanByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.NhomId,a.MaNhom,a.TenNhom
	FROM NhomTaiSan a LEFT JOIN [QLTS_MAIN].[dbo].[NguoiDung] b on a.NguoiTao=b.NhanVienId 


	

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_NhomTaiSan_GetListNhomTaiSanByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_NhomTaiSan_GetListNhomTaiSanByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------
	DECLARE @IS_VIEW varchar(10) = '0'
   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
  @NHAN_VIEN_ID = @NhanVienId,
  @CO_SO_ID = @CoSoId,
  @CHUC_NANG = 'CN0004',
  @QUYEN=@IS_VIEW OUTPUT
	

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.NhomId,a.MaNhom,a.TenNhom,a.GhiChu,b.TenNhanVien as HoTen,a.NgayTao
	FROM NhomTaiSan a LEFT JOIN NhanVien b on a.NguoiTao=b.NhanVienId where 1=1 ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (a.MaNhom LIKE N''%' +@Search+ '%'' OR a.TenNhom LIKE  N''%' +@Search+ '%'')';


	--	IF @IS_VIEW_ALL = '0' 
	--BEGIN			 
	--		SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';	  
	--END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_NuocSanXuat_cbxNuocSanXuatByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.08
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_NuocSanXuat_cbxNuocSanXuatByCriteria]
						 @Search			=	N''
						,@NuocSanXuatId		=	N''
						,@MaNuocSanXuat		=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.08 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROC [dbo].[sp_NuocSanXuat_cbxNuocSanXuatByCriteria]
( 
	 @Search			NVARCHAR(500)   =	NULL
	,@NuocSanXuatId		INT				=	NULL
	,@MaNuocSanXuat		NVARCHAR(500)	=	NULL
	,@CoSoId			NVARCHAR(500)	=	NULL
	,@NhanVienId		NVARCHAR(500)	=	NULL
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	SET @Search				=	ISNULL(@Search,'')
	SET @NuocSanXuatId		=	ISNULL(@NuocSanXuatId, 0)
	SET @MaNuocSanXuat		=	ISNULL(@MaNuocSanXuat,'')

	SELECT TOP 10 NSX.*
	FROM	NuocSanXuat NSX
	WHERE	(@NuocSanXuatId = 0 OR NSX.NuocSanXuatId = @NuocSanXuatId)
			AND (@MaNuocSanXuat = '' OR NSX.MaNuocSanXuat = @MaNuocSanXuat)
			AND (@Search = '' OR NSX.MaNuocSanXuat LIKE N'%' + @Search + '%' OR NSX.TenNuocSanXuat LIKE N'%' + @Search + '%')
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_NuocSanXuat_GetListNuocSanXuatByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_NuocSanXuat_GetListNuocSanXuatByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------

	--DECLARE @IS_VIEW_ALL varchar = '0'
 -- 	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
	--	@LOGINID = @CoSoId,
	--	@CHUC_NANG = 'CN0004',
	--	@QUYEN_TAC_VU = 'View All',
	--	@YES_NO=@IS_VIEW_ALL OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, a.NuocSanXuatId,a.MaNuocSanXuat,a.TenNuocSanXuat,a.GhiChu,b.TenNhanVien as HoTen,a.NgayTao
	FROM NuocSanXuat a LEFT JOIN NhanVien b on a.NguoiTao=b.NhanVienId where 1=1 ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (MaNuocSanXuat LIKE N''%' +@Search+ '%'' OR TenNuocSanXuat LIKE  N''%' +@Search+ '%'')';


	--	IF @IS_VIEW_ALL = '0' 
	--BEGIN			 
	--		SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';	  
	--END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_PhongBan_cbxPhongBanByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_PhongBan_cbxPhongBanByCriteria]
( 
	 @CoSoId	        nvarchar(500)	= null
	,@NhanVienId	    nvarchar(500)	= null
	,@Search			nvarchar(500)   = null
	,@PhongBanId		nvarchar(500)   = null
	,@FunctionCode		nvarchar(500)   = null
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
DECLARE		 @_COSO_IDS		VARCHAR(MAX)	=	NULL
			,@V_ISVIEW		VARCHAR(MAX)	=	NULL
			,@V_PHONGBAN_ID	VARCHAR(MAX)	=	NULL

SET @PhongBanId = ISNULL(@PhongBanId, '')
IF @PhongBanId = ''
	SET @PhongBanId = '0'

-- KIỂM TRA QUYỀN VIEW
EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
	@NHAN_VIEN_ID = @NhanVienId,
	@CO_SO_ID = @CoSoId,
	@CHUC_NANG = @FunctionCode,
	@QUYEN=@V_ISVIEW OUTPUT
PRINT CONCAT('@V_ISVIEW = ',@V_ISVIEW)
--/ KIỂM TRA QUYỀN VIEW

-- DANH SÁCH CƠ SỞ TRƯC THUỘC
EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	@COSOID=@CoSoId
	,@COSOID_OUT=@_COSO_IDS OUTPUT
SET @_COSO_IDS = REPLACE(@_COSO_IDS,',','|')
PRINT CONCAT('@_COSO_IDS = ',@_COSO_IDS)
--/ DANH SÁCH CƠ SỞ TRƯC THUỘC

SELECT		*
FROM		PhongBan PB
WHERE		(		(@V_ISVIEW = 'VA')
				OR	(@V_ISVIEW = 'VB' AND CHARINDEX('|' + CAST(PB.CoSoId AS VARCHAR(10)) + '|', '|' + @_COSO_IDS + '|') > 0)
				OR	(@V_ISVIEW IN ('VR','VE') AND  EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE CHARINDEX(',' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + ',', ',' + CAST(pb.PhongBanId AS VARCHAR(10)) + ',') > 0))
			)
			AND (@PhongBanId = '0' OR CHARINDEX('|' + CAST(PB.PhongBanId AS VARCHAR(10)) + '|', '|' + @PhongBanId + '|') > 0)
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_PhongBan_cbxPhongBanById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.16
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_PhongBan_cbxPhongBanById]
						 @CoSoId	        =	16
						,@NhanVienId	    =	10
						,@Search			=	NULL
						,@PhongBanId		=	NULL
						,@FunctionCode		=	'CN0024'
6. Precaution	:
7. History		:
				  2017.10.16 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_PhongBan_cbxPhongBanById]
( 
	 @CoSoId	        nvarchar(500)	= null
	,@NhanVienId	    nvarchar(500)	= null
	,@Search			nvarchar(500)   = null
	,@PhongBanId		nvarchar(500)   = null
	,@FunctionCode		nvarchar(500)   = null
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
DECLARE		 @_COSO_IDS		VARCHAR(MAX)	=	NULL
			,@V_ISVIEW		VARCHAR(MAX)	=	NULL
			,@V_PHONGBAN_ID	VARCHAR(MAX)	=	NULL

SET @PhongBanId = ISNULL(@PhongBanId, '')
IF @PhongBanId = ''
	SET @PhongBanId = '0'

-- KIỂM TRA QUYỀN VIEW
EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
	@NHAN_VIEN_ID = @NhanVienId,
	@CO_SO_ID = @CoSoId,
	@CHUC_NANG = @FunctionCode,
	@QUYEN=@V_ISVIEW OUTPUT
PRINT CONCAT('@V_ISVIEW = ',@V_ISVIEW)
--/ KIỂM TRA QUYỀN VIEW

-- DANH SÁCH CƠ SỞ TRƯC THUỘC
EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	@COSOID=@CoSoId
	,@COSOID_OUT=@_COSO_IDS OUTPUT
SET @_COSO_IDS = REPLACE(@_COSO_IDS,',','|')
PRINT CONCAT('@_COSO_IDS = ',@_COSO_IDS)
--/ DANH SÁCH CƠ SỞ TRƯC THUỘC
print(@V_ISVIEW)
SELECT @V_PHONGBAN_ID = ( SELECT STUFF((select CONCAT( ',' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('')
			),1,1,'') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			where pbnv.NhanVienId= @PhongBanId
			GROUP BY pbnv.NhanVienId)

SELECT		*
FROM		PhongBan PB
WHERE		(		(@V_ISVIEW = 'VA')
				OR	(@V_ISVIEW = 'VB' AND CHARINDEX('|' + CAST(PB.CoSoId AS VARCHAR(10)) + '|', '|' + @_COSO_IDS + '|') > 0)
				OR	(@V_ISVIEW IN ('VR','VE') AND PB.PhongBanId in ( @V_PHONGBAN_ID))
			)
			AND (@PhongBanId = '0' OR CHARINDEX('|' + CAST(PB.PhongBanId AS VARCHAR(10)) + '|', '|' + @PhongBanId + '|') > 0)
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_PhongBan_cbxPhongBanById_171016]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_PhongBan_cbxPhongBanById_171016]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @PhongBanId		nvarchar(500)   = null	
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	IF(@PhongBanId IS NULL OR @PhongBanId = '') SET @PhongBanId ='0'
	DECLARE @V_SQL varchar(max) = '' 
	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0004',
		@QUYEN=@IS_VIEW OUTPUT
		print(@IS_VIEW)

	DECLARE  @V_DELIMITER	VARCHAR(10)		=	'|'
			,@_COSO_IDS		VARCHAR(MAX)	=	NULL

	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)

	SET @V_SQL = 'SELECT a.PhongBanId,a.MaPhongBan,a.TenPhongBan
	FROM PhongBan a
	Where 1=1 or CHARINDEX('''+@V_DELIMITER+''' + CAST(a.CoSoId AS VARCHAR(10)) + '''+@V_DELIMITER+''','''+@V_DELIMITER+''' + '''+@_COSO_IDS+''' + '''+@V_DELIMITER+''') > 0 ' ;

	IF @IS_VIEW = 'VR' or  @IS_VIEW = 'VE'
	BEGIN    
		SET @V_SQL = @V_SQL + ' and a.PhongBanId = (select PhongBanId from NhanVien where NhanVienId=''' + @NhanVienId + ''')';   
	END
	ELSE
	BEGIN
	SET @V_SQL = @V_SQL + ' AND ('+@PhongBanId+' = 0 OR a.PhongBanId = '+@PhongBanId+')';
	END
	PRINT(@V_SQL);
	EXEC(@V_SQL);
	

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_PhongBan_GetListPhongBanByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_PhongBan_GetListPhongBanByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId    nvarchar(500)	= null	
	, @Search			nvarchar(500)   = null	
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
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



	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------
	DECLARE @IS_VIEW varchar(10) = '0'
   exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
  @NHAN_VIEN_ID = @NhanVienId,
  @CO_SO_ID = @CoSoId,
  @CHUC_NANG = 'CN0004',
  @QUYEN=@IS_VIEW OUTPUT

  print(@IS_VIEW)
	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT,a.*,nv.TenNhanVien as HoTen,a.NgayTao
	FROM PhongBan a left join NhanVien nv on a.NguoiTao=nv.NhanVienId 
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=a.NguoiTao
	where 1=1 ' 

	-- Build Where clause
	-- Where clause Quick search
	
	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (a.MaPhongBan LIKE N''%' +@Search+ '%'' OR a.TenPhongBan LIKE  N''%' +@Search+ '%'')';

		IF @IS_VIEW = 'VB' 
 BEGIN    
   SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';   
 END
   IF @IS_VIEW = 'VR' 
 BEGIN    
	SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @NhanVienId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
  IF @IS_VIEW = 'VE' 
 BEGIN    
   SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @NhanVienId + '''';   
 END
	
	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_PhuongThuc_cbxPhuongThucByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.08
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_PhuongThuc_cbxPhuongThucByCriteria]
						 @Search			=	N''
						,@PhuongThucId		=	N''
						,@MaPhuongThuc		=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.08 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_PhuongThuc_cbxPhuongThucByCriteria]
( 
	 @Search			NVARCHAR(500)   =	NULL
	,@PhuongThucId		INT				=	NULL
	,@CoSoId			NVARCHAR(500)	=	NULL
	,@NhanVienId		NVARCHAR(500)	=	NULL
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	SET @Search				=	ISNULL(@Search,'')
	SET @PhuongThucId		=	ISNULL(@PhuongThucId, 0)

	SELECT TOP 10 PT.*
	FROM	PhuongThuc PT
	WHERE	(@PhuongThucId = 0 OR PT.PhuongThucId = @PhuongThucId)
			AND (PT.TenPhuongThuc LIKE N'%' + @Search + '%')
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_SuaChua_GetListReportSuaChuaByBaoDuongId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

EXEC sp_SuaChua_GetListReportSuaChuaByBaoDuongId '1'

*/

CREATE PROC [dbo].[sp_SuaChua_GetListReportSuaChuaByBaoDuongId]
( 
	@BaoDuongId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	--SELECT * FROM dbo.BaoDuong WHERE BaoDuongId = 1
	--SELECT * FROM dbo.SuaChua WHERE BaoDuongId = 1
	--SELECT TOP 2* FROM dbo.TaiSan

	DECLARE @V_NGAYBATDAU DATETIME
			,@V_NGAYKETTHUC DATETIME

	DECLARE @TableLoaiBaoDuong TABLE
	(
		 _type INT,
		 _name NVARCHAR(100)
	)

	insert @TableLoaiBaoDuong
	select 1,N'Thay thế'
	union
	select 2,N'Bảo dưỡng'
	union
	select 3,N'Sửa chữa'

	SELECT @V_NGAYBATDAU = MIN(NgayBatDau), @V_NGAYKETTHUC = MAX(NgayKetThuc) FROM SuaChua WHERE BaoDuongId = @BaoDuongId

	SELECT	cs.MaCoSo, CS.TenCoSo,
			TS.TenTaiSan, TS.SoQDTC, TS.DonViTinh, TS.MaTaiSan, '' SoThe, PB.TenPhongBan, NV.TenNhanVien, H.DuToan, H.NgayBaoDuong, H.NgayDuKien, LBD._name TenLoaiBaoDuong,
			L.TenBoPhan, L.NoiDung, L.ChiPhi, L.KetQua, L.NgayBatDau,L.NgayKetThuc, @V_NGAYBATDAU v_ngaybatdau, @V_NGAYKETTHUC v_ngayketthuc
	FROM dbo.BaoDuong H
	JOIN dbo.SuaChua L ON L.BaoDuongId = H.BaoDuongId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = H.TaiSanId
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = H.PhongBanId
	LEFT JOIN dbo.NhanVien NV ON NV.NhanVienId = H.NhanVienId
	LEFT JOIN @TableLoaiBaoDuong LBD ON LBD._type = H.LoaiBaoDuongId
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
	WHERE H.BaoDuongId = @BaoDuongId

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SuaChua_GetListSuaChuaByBaoDuongId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_SuaChua_GetListSuaChuaByBaoDuongId]
( 
	@BaoDuongId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	
	SELECT H.SuaChuaId,
			H.BaoDuongId,
			H.TenBoPhan,
			CONVERT(VARCHAR,H.NgayBatDau,103)NgayBatDau,
			CONVERT(VARCHAR,H.NgayKetThuc,103)NgayKetThuc,
			H.ChiPhi,
			H.NoiDung,
			H.NoiSua,
			H.KetQua
	FROM dbo.SuaChua H
	WHERE H.BaoDuongId = @BaoDuongId

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SuaChua_InsertSuaChua]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_SuaChua_InsertSuaChua]
	@BaoDuongId INT
	,@TenBoPhan NVARCHAR(100)
	,@NgayBatDau DATETIME
	,@NgayKetThuc DATETIME
	,@ChiPhi NUMERIC(18,4)
	,@NoiDung NVARCHAR(500)
	,@NoiSua NVARCHAR(500)
	,@KetQua NVARCHAR(500)
	,@CoSoId INT
	,@NhanVienId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.SuaChua
			        ( BaoDuongId ,		TenBoPhan ,
					  NgayBatDau ,		NgayKetThuc ,
			          ChiPhi ,			NoiDung ,
			          NoiSua ,			KetQua
			        )
			SELECT @BaoDuongId			,@TenBoPhan
					,@NgayBatDau		,@NgayKetThuc
					,@ChiPhi			,@NoiDung
					,@NoiSua			,@KetQua		
			

			SELECT SCOPE_IDENTITY() AS SuaChuaId

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SuDung_DeleteSuDungById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_SuDung_DeleteSuDungById]
	@SuDungId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	BEGIN TRAN
		
		BEGIN TRY
			
			DELETE dbo.SuDungChiTiet WHERE SuDungId = @SuDungId
			DELETE dbo.SuDung WHERE SuDungId = @SuDungId
			
			SELECT @@ROWCOUNT

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SuDung_GetListReportSuDungById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_SuDung_GetListReportSuDungById]
( 
	@SuDungId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	--1:dat
	--2:nha
	--3:oto
	--4:tren 500
	
	SELECT CS.MaCoSo, CS.TenCoSo,
		   CAST(H.KyLap AS VARCHAR)KyLap,
		   H.Nam,
		   H.NoiDung,
		   H.NguoiTao,
		   NV.TenNhanVien TenNguoiTao,
		   H.NgayTao,
		   TS.MaTaiSan,
		   TS.TenTaiSan,
		   L.SoSanPhamPhucVu,
		   L.DonViTinhSanPham,
		   L.SoNguyenLieuSuDung,
		   L.DonViTinhNguyenLieu,
		   L.GhiChu,
		   CASE WHEN TS.LoaiKeKhai = 3 THEN N'Phương tiện đi lại' ELSE N'Tài sản cố định khác' END TenLoaiTaiSan,
		   YEAR(TD.NgayBatDauSuDung) NamSuDung,
		   SUM(ISNULL(NG.GiaTri,0)) NguyenGia,
		   SUM(ISNULL(NG.GiaTri,0)) - (
								DATEDIFF(YEAR, TS.NgayBDHaoMon, H.NgayTao) * (SUM(ISNULL(NG.GiaTri,0)) * TS.TyLeHaoMon / 100)
								) GiaTriConLai
	FROM dbo.SuDung H
	JOIN dbo.SuDungChiTiet L ON L.SuDungId = H.SuDungId
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = L.TaiSanId
	LEFT JOIN dbo.NguyenGia NG ON NG.TaiSanId = ts.TaiSanId
	LEFT JOIN dbo.TheoDoi TD ON TD.TaiSanId = TS.TaiSanId AND TD.NhanVienId = l.NhanVienId AND TD.PhongBanId = l.PhongBanId AND H.Nam = YEAR(H.Nam)
	LEFT JOIN dbo.NhanVien NV ON NV.NhanVienId = h.NguoiTao
	LEFT JOIN dbo.CoSo CS ON CS.CoSoId = H.CoSoId
	WHERE H.SuDungId = @SuDungId
	GROUP BY
		   CS.MaCoSo, CS.TenCoSo,
		   H.KyLap,
		   H.Nam,
		   H.NoiDung,
		   H.NguoiTao,
		   NV.TenNhanVien,
		   H.NgayTao,
		   TS.MaTaiSan,
		   TS.TenTaiSan,
		   L.SoSanPhamPhucVu,
		   L.DonViTinhSanPham,
		   L.SoNguyenLieuSuDung,
		   L.DonViTinhNguyenLieu,
		   L.GhiChu,
		   TS.LoaiKeKhai,
		   TS.NgayBDHaoMon,
		   TS.TyLeHaoMon,
		   NgayBatDauSuDung
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_SuDung_GetListSuDungByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_SuDung_GetListSuDungByCriteria]
( 
	  @CoSoId	        NVARCHAR(10)		
	, @KyLap			nvarchar(500)   = null	
	, @Search			nvarchar(500)   = null	
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null		
	, @LoginId			NVARCHAR(10)
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) ,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@LoginId,@NAM=@Nam OUTPUT; 


	SET @Search = ISNULL(@Search, '')
	----------

	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @LoginId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0035',
		@QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

	IF OBJECT_ID('tempdb..#V_TB_KYLAP') IS NOT NULL
		DROP TABLE #V_TB_KYLAP
	CREATE TABLE #V_TB_KYLAP
	(
		 _id INT,
		 _name NVARCHAR(100)
	)

	insert #V_TB_KYLAP
	select 1,N'Cả năm'		union
	select 2,N'Quý I'		union
	select 3,N'Quý II'		union
	select 4,N'Quý III'		union
	select 5,N'Quý IV'		union
	select 6,N'Tháng 1'		union
	select 7,N'Tháng 2'		union
	select 8,N'Tháng 3'		union
	select 9,N'Tháng 4'		union
	select 10,N'Tháng 5'	union
	select 11,N'Tháng 6'	union
	select 12,N'Tháng 7'	union
	select 13,N'Tháng 8'	union
	select 14,N'Tháng 9'	union
	select 15,N'Tháng 10'	union
	select 16,N'Tháng 11'	union
	select 17,N'Tháng 12'

---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria

	SET @V_SQL = N'
		SELECT COUNT(*) OVER () AS MAXCNT, H.SuDungId, H.KyLap, KL._name TenKyLap, H.Nam, H.NoiDung, H.NguoiTao, nd.TenNhanVien TenNguoiTao, H.NgayTao
	FROM dbo.SuDung H
	LEFT JOIN #V_TB_KYLAP KL ON KL._id = H.KyLap
	LEFT JOIN NhanVien nd ON nd.NhanVienId = h.NguoiTao
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=h.NguoiTao
	WHERE CAST(H.NgayTao AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) and H.Nam='''+@Nam+'''' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and (H.NoiDung LIKE N''%' +@Search+ '%'')';
	END

	
	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and H.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @LoginId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nd.NhanVienId =''' + @LoginId + '''';   
	END

	--SET @V_SQL = @V_SQL + ' GROUP BY H.GhiTangId, H.SoChungTu, H.NgayChungTu, H.NgayGhiTang, H.NoiDung,
	--						h.DuyetId, H.NguoiDuyet, H.CoSoId, H.NguoiTao, H.NgayTao,ndd.HoTen,nd.HoTen ';

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SuDung_GetListSuDungById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_SuDung_GetListSuDungById]
( 
	@SuDungId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	
	SELECT H.SuDungId,
		   CAST(H.KyLap AS VARCHAR)KyLap,
		   H.Nam,
		   H.NoiDung,
		   H.NguoiTao,
		   NV.TenNhanVien TenNguoiTao,
		   H.NgayTao,
		   H.CtrVersion
	FROM dbo.SuDung H
	LEFT JOIN dbo.NhanVien NV ON NV.NhanVienId = h.NguoiTao
	WHERE H.SuDungId = @SuDungId

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SuDung_InsertSuDung]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_SuDung_InsertSuDung]
	@KyLap INT,
	@Nam numeric (4, 0),
	@NoiDung NVARCHAR(500),
	@CoSoId INT,
	@NguoiTao INT,
	@CtrVersion INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.SuDung
			        ( KyLap ,			Nam ,			NoiDung ,
			          CoSoId ,			NguoiTao ,		NgayTao ,
			          CtrVersion
			        )
			SELECT @KyLap,				@Nam,			@NoiDung,
					@CoSoId,			@NguoiTao,		GETDATE(),
					1

			SELECT SCOPE_IDENTITY() AS SuDungIdI

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SuDung_UpdateSuDung]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_SuDung_UpdateSuDung]
	@SuDungId INT,
	@KyLap INT,
	@Nam numeric (4, 0),
	@NoiDung NVARCHAR(500),
	@CoSoId INT,
	@NguoiTao INT,
	@CtrVersion INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	
	IF EXISTS (SELECT 1 FROM dbo.SuDung WHERE SuDungId = @SuDungId AND CtrVersion <> @CtrVersion)
	BEGIN
		SELECT -1 AS ID
		RETURN
	END

	BEGIN TRAN
		
		BEGIN TRY
			
			UPDATE dbo.SuDung 
			SET KyLap = @KyLap,
				Nam = @Nam,
				NoiDung = @NoiDung,
				CtrVersion = CtrVersion + 1
			WHERE SuDungId = @SuDungId

			DELETE dbo.SuDungChiTiet WHERE SuDungId = @SuDungId

			SELECT @@ROWCOUNT AS ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SuDungChiTiet_GetListSuDungChiTietBySuDungId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_SuDungChiTiet_GetListSuDungChiTietBySuDungId]
( 
	@SuDungId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT L.SuDungId,
		   CAST(L.TaiSanId AS VARCHAR)TaiSanId,
		   TS.TenTaiSan,
		   CAST(L.PhongBanId AS VARCHAR)PhongBanId,
		   PB.TenPhongBan,
		   CAST(L.NhanVienId AS VARCHAR)NhanVienId,
		   NV.TenNhanVien,
		   L.SoSanPhamPhucVu,
		   L.DonViTinhSanPham,
		   L.SoNguyenLieuSuDung,
		   L.DonViTinhNguyenLieu,
		   L.GhiChu
	FROM dbo.SuDungChiTiet L
	LEFT JOIN dbo.TaiSan TS ON TS.TaiSanId = L.TaiSanId
	LEFT JOIN dbo.PhongBan PB ON PB.PhongBanId = L.PhongBanId
	LEFT JOIN dbo.NhanVien NV ON NV.NhanVienId = L.NhanVienId
	WHERE SuDungId = @SuDungId

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SuDungChiTiet_InsertSuDungChiTiet]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_SuDungChiTiet_InsertSuDungChiTiet]
	@SuDungId INT,
	@TaiSanId INT,
	@PhongBanId INT,
	@NhanVienId INT,
	@SoSanPhamPhucVu NUMERIC(18,4),
	@DonViTinhSanPham NVARCHAR(50),
	@SoNguyenLieuSuDung NUMERIC(18,4),
	@DonViTinhNguyenLieu NVARCHAR(50),
	@GhiChu NVARCHAR(500)
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.SuDungChiTiet
			        ( SuDungId ,			TaiSanId ,			SoSanPhamPhucVu ,
			          DonViTinhSanPham ,	SoNguyenLieuSuDung ,DonViTinhNguyenLieu ,
			          GhiChu,				PhongBanId,			NhanVienId
			        )
			SELECT	@SuDungId,				@TaiSanId			,@SoSanPhamPhucVu
					,@DonViTinhSanPham		,@SoNguyenLieuSuDung,@DonViTinhNguyenLieu
					,@GhiChu	,			@PhongBanId			,@NhanVienId
									
			SELECT SCOPE_IDENTITY() AS SuDungChiTietIdI

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_cbxTaiSanByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_cbxTaiSanByCriteria]
						 @Search			=	N''
						,@TaiSanId			=	N'1071'
						,@MaTaiSan			=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	7
						,@FunctionCode		=	'CN0024'
6. Precaution	:
7. History		:
				  2017.09.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_cbxTaiSanByCriteria]
( 
	 @Search			NVARCHAR(500)   =	NULL
	,@TaiSanId			NVARCHAR(500)	=	NULL
	,@MaTaiSan			NVARCHAR(500)   =	NULL
	,@LoaiKeKhai		NVARCHAR(500)   =	NULL
	,@CoSoId	        NVARCHAR(500)	=	NULL
	,@NhanVienId	    NVARCHAR(500)	=	NULL
	,@FunctionCode	    NVARCHAR(500)	=	NULL
)
AS  
BEGIN
SET NOCOUNT ON
--------------------------------------------------
	DECLARE  @V_DELIMITER	VARCHAR(10)		=	'|'
			,@_COSO_IDS		VARCHAR(MAX)	=	NULL
			,@V_ISVIEW		VARCHAR(MAX)	=	NULL

	SET @Search = ISNULL(@Search,'')
	SET @TaiSanId = ISNULL(@TaiSanId, '')
	SET @MaTaiSan = ISNULL(@MaTaiSan,'')
	SET @LoaiKeKhai = ISNULL(@LoaiKeKhai,'')

	-- KIỂM TRA QUYỀN VIEW
	EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = @FunctionCode,
		@QUYEN=@V_ISVIEW OUTPUT
	PRINT @V_ISVIEW
	--/ KIỂM TRA QUYỀN VIEW

	-- DANH SÁCH CƠ SỞ TRƯC THUỘC
	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
	PRINT concat('@_COSO_IDS=',@_COSO_IDS)
	--/ DANH SÁCH CƠ SỞ TRƯC THUỘC

	SELECT		TS.*,ISNULL(NG.NguyenGia,0) NguyenGia
	FROM		(	SELECT		TOP 10 _TS.TaiSanId, ISNULL(SUM(_NG.GiaTri),0) NguyenGia
					FROM		TaiSan _TS 
								LEFT JOIN NguyenGia _NG ON _TS.TaiSanId = _NG.TaiSanId
					WHERE		(@V_ISVIEW = 'VA' OR CHARINDEX(@V_DELIMITER + CAST(_TS.CoSoId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @_COSO_IDS + @V_DELIMITER) > 0)
								AND (@Search = '' OR _TS.MaTaiSan LIKE N'%' + @Search + '%' OR _TS.TenTaiSan LIKE N'%' + @Search + '%')
								AND (@TaiSanId = '' OR CHARINDEX(@V_DELIMITER + CAST(_TS.TaiSanId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @TaiSanId + @V_DELIMITER) > 0)
								AND (@MaTaiSan = '' OR CHARINDEX(@V_DELIMITER + _TS.MaTaiSan + @V_DELIMITER,@V_DELIMITER + @MaTaiSan + @V_DELIMITER) > 0)
								AND (@LoaiKeKhai = '' OR CHARINDEX(@V_DELIMITER + CAST(_TS.LoaiKeKhai AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @LoaiKeKhai + @V_DELIMITER) > 0)
					GROUP BY	_TS.TaiSanId
				) NG
				LEFT JOIN TaiSan TS ON  TS.TaiSanId = NG.TaiSanId
--------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_cbxTaiSanSuDungByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_cbxTaiSanSuDungByCriteria]
						 @Search			=	N''
						,@TaiSanId			=	N''
						,@MaTaiSan			=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@FunctionCode		=	6
6. Precaution	:
7. History		:
				  2017.09.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_cbxTaiSanSuDungByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	, @TaiSanId			INT				=	NULL	
	, @MaTaiSan			NVARCHAR(500)   =	NULL	
	, @FunctionCode		NVARCHAR(500)   =	NULL	
	, @PhongBanFilter		NVARCHAR(500)   =	NULL	
)
AS  
BEGIN
SET NOCOUNT ON
	DECLARE  @V_DELIMITER	VARCHAR(10)		=	'|'
			,@_COSO_IDS		VARCHAR(MAX)	=	NULL
			,@V_ISVIEW		VARCHAR(MAX)	=	NULL
			,@Nam	VARCHAR(MAX)	=	NULL
			--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@NhanVienId,@NAM=@NAM OUTPUT;
	PRINT(@NAM)

	SET @Search = ISNULL(@Search,'')
	SET @TaiSanId = ISNULL(@TaiSanId, 0)
	SET @MaTaiSan = ISNULL(@MaTaiSan,'')
	SET @PhongBanFilter = ISNULL(@PhongBanFilter,'')
	-- KIỂM TRA QUYỀN VIEW
	EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = @FunctionCode,
		@QUYEN=@V_ISVIEW OUTPUT
	PRINT @V_ISVIEW
	--/ KIỂM TRA QUYỀN VIEW

	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
	PRINT concat('@_COSO_IDS=',@_COSO_IDS)

	SELECT	TOP 10 TS.TaiSanId,TS.MaTaiSan,TS.DonViTinh,TS.TenTaiSan,PB.PhongBanId,PB.TenPhongBan, ISNULL((TD.SLTon + TD.SLTang - TD.SLGiam),0) as SoLuongTon ,  ISNULL(SUM(NG.GiaTri),0) NguyenGia,nv.NhanVienId,nv.TenNhanVien
	FROM	TaiSan TS
			LEFT JOIN NguyenGia NG ON TS.TaiSanId = NG.TaiSanId
			LEFT JOIN TheoDoi TD ON TS.TaiSanId = TD.TaiSanId
			LEFT JOIN PhongBan PB ON TD.PhongBanId = PB.PhongBanId
			LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = TD.NhanVienId
	WHERE	(@V_ISVIEW = 'VA' OR CHARINDEX(@V_DELIMITER + CAST(TS.CoSoId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @_COSO_IDS + @V_DELIMITER) > 0)
			and (TD.SLTon + TD.SLTang - TD.SLGiam) > 0  
			AND (@TaiSanId = 0 OR TS.TaiSanId = @TaiSanId)
			AND TD.Nam = @Nam
			AND (@MaTaiSan = '' OR TS.MaTaiSan = @MaTaiSan)
			AND (@PhongBanFilter = '' OR TD.PhongBanId = @PhongBanFilter)
			AND (@Search = '' OR TS.MaTaiSan LIKE N'%' + @Search + '%' OR TS.TenTaiSan LIKE N'%' + @Search + '%')
	GROUP BY  TS.TaiSanId,TS.MaTaiSan,TS.TenTaiSan,TS.DonViTinh,PB.PhongBanId,PB.TenPhongBan,TD.SLTon,TD.SLTang,TD.SLGiam,nv.NhanVienId,nv.TenNhanVien
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_cbxTaiSanSuDungById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_cbxTaiSanSuDungByCriteria]
						 @Search			=	N''
						,@TaiSanId			=	N''
						,@MaTaiSan			=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_cbxTaiSanSuDungById]
( 
	  @CoSoId	        INT				= null			
	, @TaiSanId			INT				=	NULL
	, @PhongBanId		INT				=	NULL
	, @NhanVienId	    INT				=	null
	, @FunctionCode		NVARCHAR(500)   =	NULL	
)
AS  
BEGIN
DECLARE @Nam	VARCHAR(MAX)	=	NULL
			--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@NhanVienId,@NAM=@NAM OUTPUT;
	PRINT(@NAM)
SET NOCOUNT ON
	SELECT	TOP 10 TS.TaiSanId,TS.MaTaiSan,TS.DonViTinh,TS.TenTaiSan,PB.PhongBanId,PB.TenPhongBan, ISNULL((TD.SLTon + TD.SLTang - TD.SLGiam),0) as SoLuongTon ,  ISNULL(SUM(NG.GiaTri),0) NguyenGia,nv.NhanVienId,nv.TenNhanVien
	FROM	TaiSan TS
			LEFT JOIN NguyenGia NG ON TS.TaiSanId = NG.TaiSanId
			LEFT JOIN TheoDoi TD ON TS.TaiSanId = TD.TaiSanId
			LEFT JOIN PhongBan PB ON TD.PhongBanId = PB.PhongBanId
			LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = TD.NhanVienId
	WHERE	TD.TaiSanId = @TaiSanId and TD.PhongBanId = @PhongBanId and TD.NhanVienId = @NhanVienId
			AND TD.Nam = @Nam
	GROUP BY  TS.TaiSanId,TS.MaTaiSan,TS.TenTaiSan,TS.DonViTinh,PB.PhongBanId,PB.TenPhongBan,TD.SLTon,TD.SLTang,TD.SLGiam,nv.NhanVienId,nv.TenNhanVien
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_cbxTaiSanTonKhoByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.23
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_cbxTaiSanTonKhoByCriteria]
						 @COSO_ID		=	1
						,@NHANVIEN_ID	=	6
						,@FUNCTIONCODE	=	'CN0046'
						,@FIELD			=	''

						,@SEARCH		=	N''
						,@TAISANIDS		=	'27'
						,@KHOTAISANIDS	=	'1'
						,@DONGIA		=	null
						,@THANGNAM		=	'17'
6. Precaution	:
7. History		:
				  2017.10.23 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_cbxTaiSanTonKhoByCriteria]
( 
	 @COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
	,@FUNCTIONCODE	VARCHAR(MAX)	=	NULL
	,@FIELD			VARCHAR(MAX)	=	NULL

	,@SEARCH		NVARCHAR(MAX)	=	NULL
	,@TAISANIDS		VARCHAR(MAX)	=	NULL
	,@KHOTAISANIDS	VARCHAR(MAX)	=	NULL
	,@DONGIA		DECIMAL(18,4)	=	NULL
	,@THANGNAM		VARCHAR(MAX)	=	NULL
)
AS  
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_ISVIEW		VARCHAR(MAX)	=	''
		,@V_SEARCH		NVARCHAR(MAX)	=	N''
		,@V_DELIMITER	VARCHAR(10)		=	'|'
		,@_COSO_IDS		VARCHAR(MAX)	=	''
			--LAY SO LIEU CAU HINH THONG SO
	
SET @TAISANIDS = ISNULL(@TAISANIDS, '')
SET @KHOTAISANIDS = ISNULL(@KHOTAISANIDS, '')
SET @THANGNAM = ISNULL(@THANGNAM, '')
EXEC sp_ThongSoUser_GetThongSoTaiSanLauBen @LOAITHONGSO='SoLieuThangNam',@NHANVIEN=@NHANVIEN_ID,@THANGNAM=@THANGNAM OUTPUT; 
SET @SEARCH = ISNULL(@SEARCH, '')
SET @V_SEARCH = '%' + @SEARCH + '%'

SET @FIELD = ISNULL(@FIELD, '')

-- KIỂM TRA QUYỀN VIEW
EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
	@NHAN_VIEN_ID = @NHANVIEN_ID,
	@CO_SO_ID = @COSO_ID,
	@CHUC_NANG = @FUNCTIONCODE,
	@QUYEN=@V_ISVIEW OUTPUT
print '@V_ISVIEW = ' + @V_ISVIEW
--/ KIỂM TRA QUYỀN VIEW

-- DANH SÁCH CƠ SỞ TRƯC THUỘC
EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	@COSOID=@COSO_ID
	,@COSOID_OUT=@_COSO_IDS OUTPUT
SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
print '@_COSO_IDS = ' + @_COSO_IDS
--/ DANH SÁCH CƠ SỞ TRƯC THUỘC

SELECT		TOP 10 COUNT(TS.TaiSanId) OVER () AS MAXCNT
			,TS.TaiSanId,TS.MaTaiSan,TS.TenTaiSan,TS.DonViTinh
			,KTS.KhoTaiSanId,KTS.MaKhoTaiSan,KTS.TenKhoTaiSan
			,KTK.ThangNam
			,KTKCT.DonGia,KTKCT.GiaMua,KTKCT.GiaBan,KTKCT.HanDung,KTKCT.LoSanXuat
			,CS.CoSoId,CS.MaCoSo,CS.TenCoSo
			,NCC.NhaCungCapId,NCC.TenNhaCungCap
			,NNS.NguonNganSachId,NNS.TenNguonNganSach
			,(KTKCT.TonDau + KTKCT.SLNhap - KTKCT.SLXuat) SoLuong
FROM		KhoTonKhoChiTiet KTKCT
			LEFT JOIN KhoTonKho KTK ON KTKCT.KhoTonKhoId = KTK.KhoTonKhoId
			LEFT JOIN TaiSan TS ON KTKCT.TaiSanId = TS.TaiSanId
			LEFT JOIN KhoTaiSan KTS ON KTK.KhoTaiSanId = KTS.KhoTaiSanId
			LEFT JOIN CoSo CS ON KTK.CoSoId = CS.CoSoId
			LEFT JOIN NhaCungCap NCC ON KTKCT.NhaCungCapId = NCC.NhaCungCapId
			LEFT JOIN NguonNganSach NNS ON KTKCT.NguonNganSachId = NNS.NguonNganSachId
WHERE		(
				@V_ISVIEW IN ('VA')
				OR (@V_ISVIEW IN ('VB','VR') AND CHARINDEX(@V_DELIMITER + CAST(CS.CoSoId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @_COSO_IDS + @V_DELIMITER) > 0)
				OR (@V_ISVIEW IN ('VE') AND KTK.NguoiTao = @NHANVIEN_ID)
			)
			AND (
				TS.MaTaiSan LIKE @V_SEARCH
				OR TS.TenTaiSan LIKE @V_SEARCH
			)
			AND (@TAISANIDS = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.TaiSanId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @TAISANIDS + @V_DELIMITER) > 0)
			AND (@KHOTAISANIDS = '' OR CHARINDEX(@V_DELIMITER + CAST(KTS.KhoTaiSanId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @KHOTAISANIDS + @V_DELIMITER) > 0)
			AND (@DONGIA IS NULL OR KTKCT.DonGia = @DONGIA)
			AND (@THANGNAM = '' OR KTK.ThangNam = @THANGNAM)
			-- TỒN > 0
			AND (@TAISANIDS <> '' OR (KTKCT.TonDau + KTKCT.SLNhap - KTKCT.SLXuat) > 0)
--------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_CheckMaTaiSan]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.16
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_CheckMaTaiSan]
						 @TaiSanId			=	NULL
						,@MaTaiSan			=	'MAY003'

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.16 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_CheckMaTaiSan]
	 @TaiSanId			INT				=	NULL
	,@MaTaiSan			NVARCHAR(MAX)	=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON 
--------------------------------------------------
SET @MESSAGE = ISNULL(@MESSAGE,'')

SET @TaiSanId = ISNULL(@TaiSanId,0)
SET @MaTaiSan = ISNULL(@MaTaiSan,'')
SELECT *
FROM TaiSan TS
WHERE TS.MaTaiSan = @MaTaiSan and  TS.CoSoId = @CoSoId AND TS.TaiSanId <> @TaiSanId
--------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_DeleteListTaiSan]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.05
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: XÓA THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_DeleteListTaiSan]
						 @TaiSanIds			=	N'1045|1044'

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.05 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_DeleteListTaiSan]
	 @TaiSanIds			VARCHAR(MAX)	=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET @TaiSanIds = ISNULL(@TaiSanIds,'')
	SET @MESSAGE = ISNULL(@MESSAGE,'')

BEGIN TRANSACTION TAISAN_DELETE
BEGIN TRY
	-- XÓA BẢNG CON
	DELETE NguyenGia WHERE CHARINDEX('|' + CAST(TaiSanId AS VARCHAR(20)) + '|', '|' + @TaiSanIds + '|') > 0
	DELETE ThongTinCongKhai WHERE CHARINDEX('|' + CAST(TaiSanId AS VARCHAR(20)) + '|', '|' + @TaiSanIds + '|') > 0
	DELETE ThongTinKeKhai_Dat WHERE CHARINDEX('|' + CAST(TaiSanId AS VARCHAR(20)) + '|', '|' + @TaiSanIds + '|') > 0
	DELETE ThongTinKeKhai_Nha WHERE CHARINDEX('|' + CAST(TaiSanId AS VARCHAR(20)) + '|', '|' + @TaiSanIds + '|') > 0
	DELETE ThongTinKeKhai_Oto WHERE CHARINDEX('|' + CAST(TaiSanId AS VARCHAR(20)) + '|', '|' + @TaiSanIds + '|') > 0
	DELETE ThongTinKeKhai_Tren500 WHERE CHARINDEX('|' + CAST(TaiSanId AS VARCHAR(20)) + '|', '|' + @TaiSanIds + '|') > 0

	-- XÓA TÀI SẢN
	DELETE TaiSan WHERE CHARINDEX('|' + CAST(TaiSanId AS VARCHAR(20)) + '|', '|' + @TaiSanIds + '|') > 0

	COMMIT TRANSACTION TAISAN_DELETE
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION TAISAN_DELETE

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
END CATCH
	SELECT * FROM TaiSan WHERE CHARINDEX('|' + CAST(TaiSanId AS VARCHAR(20)) + '|', '|' + @TaiSanIds + '|') > 0
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_GetListNguyenGiaByTaiSanId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_GetListNguyenGiaByTaiSanId]
						 @TaiSanId			=	32

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_GetListNguyenGiaByTaiSanId]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	NG.*,NNS.TenNguonNganSach
	FROM	NguyenGia NG
			LEFT JOIN NguonNganSach NNS ON NG.NguonNganSachId = NNS.NguonNganSachId
	WHERE	TaiSanId = @TaiSanId
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_GetListTaiSanByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.05
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: DANH SÁCH TÀI SẢN
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_GetListTaiSanByCriteria]
						 @SEARCH_STRING		=	N''
						,@SKIP				=	''
						,@TAKE				=	''
						,@OrderClause		=	'MAXCNT ASC'
						,@CoSoId			=	16
						,@NhanVienId		=	10
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.05 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_GetListTaiSanByCriteria]
	 @SEARCH_STRING		NVARCHAR(MAX)	=	NULL
	,@SEARCH_MATAISAN	NVARCHAR(MAX)	=	NULL
	,@SEARCH_TENTAISAN	NVARCHAR(MAX)	=	NULL
	,@SKIP				INT				=	NULL
	,@TAKE				INT				=	NULL
	,@OrderClause		NVARCHAR(MAX)	=	NULL				
	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE  @V_SQL				NVARCHAR(MAX) 
			,@V_SEARCH_STRING	NVARCHAR(MAX) 
			,@_COSO_IDS			VARCHAR(MAX)	=	NULL
			,@V_DELIMITER		VARCHAR(10)		=	'|'

	SET @SKIP = ISNULL(@SKIP, 0)
	SET @TAKE = ISNULL(@TAKE, 0)
	IF @TAKE = 0
		SET @TAKE = 10
	
	SET @CoSoId = ISNULL(@CoSoId, 0)

	SET @NhanVienId = ISNULL(@NhanVienId, '')
	IF @NhanVienId = ''
		SET @NhanVienId = 0
	
	SET @SEARCH_MATAISAN = ISNULL(@SEARCH_MATAISAN, '')
	SET @SEARCH_TENTAISAN = ISNULL(@SEARCH_TENTAISAN, '')

	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	

	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
	PRINT concat('@_COSO_IDS=',@_COSO_IDS)

	----------

	DECLARE @IS_VIEW varchar(10) = '0'
	EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0022',
		@QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @ORDER_CLAUSE
	SET @OrderClause = ISNULL(@OrderClause, '')
	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT	COUNT(TS.TaiSanId) OVER () AS MAXCNT, TS.*,l.TenLoai,n.TenNhom,h.TenHangSanXuat,nc.TenNuocSanXuat,ISNULL(NG.NguyenGia,0) NguyenGia
			,NV.TenNhanVien TenNguoiTao
	FROM	TaiSan TS 
			LEFT JOIN (
				select		TaiSanId, SUM(GiaTri) NguyenGia
				from		NguyenGia
				GROUP BY	TaiSanId
			) NG ON TS.TaiSanId = NG.TaiSanId
			LEFT JOIN LoaiTaiSan l ON TS.LoaiId=l.LoaiId
			LEFT JOIN NhomTaiSan n ON l.NhomId=n.NhomId
			LEFT JOIN HangSanXuat h ON TS.HangSanXuatId=h.HangSanXuatId
			LEFT JOIN NuocSanXuat nc ON TS.NuocSanXuatId=nc.NuocSanXuatId
			LEFT JOIN NhanVien NV ON TS.NguoiTao=NV.NhanVienId
			LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=TS.NguoiTao
	WHERE	1=1 ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @SEARCH_STRING <> ''
	SET @V_SQL = @V_SQL + N' AND (TS.MaTaiSan LIKE N''' +@SEARCH_STRING+ ''' OR TS.TenTaiSan LIKE  N''' +@SEARCH_STRING+ ''')';

	IF @SEARCH_MATAISAN <> ''
	SET @V_SQL = @V_SQL + N' AND (TS.MaTaiSan LIKE N''%' + @SEARCH_MATAISAN + '%'')';

	IF @SEARCH_TENTAISAN <> ''
	SET @V_SQL = @V_SQL + N' AND (TS.TenTaiSan LIKE N''%' +@SEARCH_TENTAISAN+ '%'')';

	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and CHARINDEX(''|'' + CAST(TS.CoSoId AS VARCHAR(10)) + ''|'',''|' + @_COSO_IDS + '|'') > 0';   
	END
	IF @IS_VIEW = 'VR' 
		BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @NhanVienId+ '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and TS.NguoiTao =''' + @NhanVienId + '''';   
	END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@SKIP AS NVARCHAR(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@TAKE AS NVARCHAR(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_GetTaiSanById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.08.31
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_GetTaiSanById]
						 @TaiSanId			=	1065

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.08.31 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_GetTaiSanById]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	TOP 10 TS.*, ISNULL(NG.NguyenGia,0) NguyenGia
	FROM	TaiSan TS
			LEFT JOIN (	SELECT	TaiSanId, ISNULL(SUM(GiaTri),0) NguyenGia
						FROM	NguyenGia
						GROUP BY  TaiSanId
			) NG ON TS.TaiSanId = NG.TaiSanId
	WHERE	TS.TaiSanId = @TaiSanId
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_GetTaiSanByMa]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.08.31
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_GetTaiSanById]
						 @TaiSanId			=	34

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.08.31 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_GetTaiSanByMa]
	 @MaTaiSan		VARCHAR(20)				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	TOP 1 TS.TaiSanId,TS.MaTaiSan,TS.DonViTinh,TS.TenTaiSan,PB.TenPhongBan, ISNULL((TD.SLTon + TD.SLTang - TD.SLGiam),0) as SoLuongTon ,  ISNULL(SUM(NG.GiaTri),0) NguyenGia
	FROM	TaiSan TS
			LEFT JOIN NguyenGia NG ON TS.TaiSanId = NG.TaiSanId
			LEFT JOIN TheoDoi TD ON TS.TaiSanId = TD.TaiSanId
			LEFT JOIN PhongBan PB ON TD.PhongBanId = PB.PhongBanId
		WHERE	TS.MaTaiSan = @MaTaiSan and TS.CoSoId=@CoSoId
	GROUP BY  TS.TaiSanId,TS.MaTaiSan,TS.TenTaiSan,TS.DonViTinh,PB.TenPhongBan,TD.SLTon,TD.SLTang,TD.SLGiam

SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_InsertTaiSan]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.08.31
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÊM THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					DECLARE @NguyenGiaList dbo.NguyenGiaType
					INSERT INTO @NguyenGiaList VALUES(0,1,1111111)

					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_InsertTaiSan]
						 @MaTaiSan			=	'TS001'
						,@TenTaiSan			=	N'KHÔNG BIẾT'
						,@DonViTinh			=	'CÁI'
						,@LoaiId			=	1
						,@PhuongThucId		=	1
						,@NamSanXuat		=	2015
						,@NuocSanXuatId		=	1
						,@HangSanXuatId		=	2
						,@SoQDTC			=	'QDTC'
						,@NhanHieu			=	'SAMSUNG'
						,@DuAnId			=	1
						,@NgayMua			=	'2018-08-31'
						,@NgayBDHaoMon		=	'2018-08-31'
						,@SoNamSuDung		=	1
						,@TyLeHaoMon		=	1.1
						,@HaoMonLuyKe		=	1.1
						,@NgayBDKhauHao		=	'2018-08-31'
						,@KyTinhKhauHao		=	N'KỲ KH'
						,@GiaTriKhauHao		=	1
						,@SoKyKhauHao		=	1
						,@TyLeKhauHao		=	1.1
						,@KhauHaoLuyKe		=	1.1
						,@LoaiKeKhai		=	1
						,@NguoiTao			=	NULL
						,@NgayTao			=	NULL
						,@CtrVersion		=	NULL

						,@NguyenGiaList		=	@NguyenGiaList

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.08.31 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
/*
DROP TYPE NguyenGiaType
CREATE TYPE NguyenGiaType AS TABLE
( 
	TaiSanId			INT,
	NguonNganSachId		INT,
	GiaTri				numeric(18, 4)
)
*/
CREATE PROCEDURE [dbo].[sp_TaiSan_InsertTaiSan]
	 @TaiSanId			INT				=	NULL
    ,@MaTaiSan			NVARCHAR(MAX)	=	NULL
    ,@TenTaiSan			NVARCHAR(MAX)	=	NULL
    ,@DonViTinh			NVARCHAR(MAX)	=	NULL
    ,@LoaiId			INT				=	NULL
    ,@PhuongThucId		INT				=	NULL
    ,@NamSanXuat		NUMERIC(4,0)	=	NULL
    ,@NuocSanXuatId		INT				=	NULL
    ,@HangSanXuatId		INT				=	NULL
    ,@SoQDTC			NVARCHAR(MAX)	=	NULL
    ,@NhanHieu			NVARCHAR(MAX)	=	NULL
    ,@DuAnId			INT				=	NULL
    ,@NgayMua			DATETIME		=	NULL
    ,@NgayBDHaoMon		DATETIME		=	NULL
    ,@SoNamSuDung		INT				=	NULL
    ,@TyLeHaoMon		NUMERIC(5,2)	=	NULL
    ,@HaoMonLuyKe		NUMERIC(18,4)	=	NULL
    ,@NgayBDKhauHao		DATETIME		=	NULL
    ,@KyTinhKhauHao		NVARCHAR(MAX)	=	NULL
    ,@GiaTriKhauHao		NUMERIC(18,4)	=	NULL
    ,@SoKyKhauHao		NUMERIC(5,0)	=	NULL
    ,@TyLeKhauHao		NUMERIC(5,2)	=	NULL
    ,@KhauHaoLuyKe		NUMERIC(18,4)	=	NULL
    ,@LoaiKeKhai		INT				=	NULL
    ,@NguoiTao			INT				=	NULL
    ,@NgayTao			DATETIME		=	NULL
    ,@CtrVersion		INT				=	NULL

	,@NguyenGiaList		NguyenGiaType		READONLY

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ
	DECLARE @V_MATAISAN		NVARCHAR(MAX)	=	''

	-- INPUT DEFAULT
	SET	@TaiSanId	=	ISNULL(@TaiSanId, 0)
	SET	@NgayTao	=	ISNULL(@NgayTao, GETDATE())
	SET	@CtrVersion	=	ISNULL(@CtrVersion, 1)
	SET	@NhanVienId	=	ISNULL(@NhanVienId, 0)
	SET @NguoiTao	=	ISNULL(@NguoiTao, @NhanVienId)
	SET @MESSAGE	=	ISNULL(@MESSAGE, '')

BEGIN TRY
	IF EXISTS (SELECT 1 FROM TaiSan WHERE CoSoId = @CoSoId AND MaTaiSan = @MaTaiSan)
	BEGIN
		SET @MESSAGE	=	N'MA_TAI_SAN|1|Mã này đã tồn tại';
		THROW 51000, @MESSAGE, 1;
	END

BEGIN TRANSACTION TAISAN_INSERT
	-- INSERT DỮ LIỆU
	INSERT INTO TaiSan	(	MaTaiSan	,TenTaiSan	,DonViTinh	,LoaiId		,PhuongThucId	,NamSanXuat		,NuocSanXuatId	,HangSanXuatId	,SoQDTC		,NhanHieu	,DuAnId		,NgayMua	,NgayBDHaoMon	,SoNamSuDung	,TyLeHaoMon		,HaoMonLuyKe	,NgayBDKhauHao	,KyTinhKhauHao	,GiaTriKhauHao	,SoKyKhauHao	,TyLeKhauHao	,KhauHaoLuyKe	,LoaiKeKhai		,CoSoId		,NguoiTao	,NgayTao	,CtrVersion		)
	VALUES				(	@MaTaiSan	,@TenTaiSan	,@DonViTinh	,@LoaiId	,@PhuongThucId	,@NamSanXuat	,@NuocSanXuatId	,@HangSanXuatId	,@SoQDTC	,@NhanHieu	,@DuAnId	,@NgayMua	,@NgayBDHaoMon	,@SoNamSuDung	,@TyLeHaoMon	,@HaoMonLuyKe	,@NgayBDKhauHao	,@KyTinhKhauHao	,@GiaTriKhauHao	,@SoKyKhauHao	,@TyLeKhauHao	,@KhauHaoLuyKe	,@LoaiKeKhai	,@CoSoId	,@NguoiTao	,@NgayTao	,@CtrVersion	)

	SET @TaiSanId	=	@@IDENTITY

	/*** NGUYÊN GIÁ ***/
	 DELETE NguyenGia WHERE TaiSanId = @TaiSanId

	INSERT INTO NguyenGia (	TaiSanId	,NguonNganSachId	,GiaTri )
	SELECT					@TaiSanId	,NguonNganSachId	,GiaTri
	FROM @NguyenGiaList

	COMMIT TRANSACTION TAISAN_INSERT
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION TAISAN_INSERT

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH
	SELECT * FROM TaiSan WHERE TaiSanId = @TaiSanId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_report_500_TSNN]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.11.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_report_500_TSNN]
						 @TaiSanId			=	''
						,@Year				=	'2017'
						,@LoaiKeKhai		=	''
						,@COSO_ID			=	1
						,@NHANVIEN_ID		=	''
6. Precaution	:
7. History		:
				  2017.11.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
create PROCEDURE [dbo].[sp_TaiSan_report_500_TSNN]
	 @TaiSanId		NVARCHAR(MAX)	=	NULL
	,@Year			NVARCHAR(MAX)	=	NULL
	,@LoaiKeKhai	NVARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
AS
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_DELIMITER	VARCHAR(10)		=	','
		,@_COSO_IDS		VARCHAR(MAX)	=	NULL

SET @TaiSanId = ISNULL(@TaiSanId, '')
SET @LoaiKeKhai = '4'

EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
   @COSOID=@COSO_ID
  ,@COSOID_OUT=@_COSO_IDS OUTPUT
SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
PRINT @_COSO_IDS

SELECT		 COUNT(TS.TaiSanId) OVER () AS MAXCNT
			,CS.TenCoSo TenDonVi
			,CS_TT.TenCoSo TenDonViChuQuan

			,TS.TaiSanId TS_TaiSanId
			,TS.TenTaiSan TS_TenTaiSan
			,TS.LoaiKeKhai TS_LoaiKeKhai

			,TTKK_500.*
FROM		TaiSan TS
			LEFT JOIN ThongTinKeKhai_Tren500 TTKK_500 ON TS.TaiSanId = TTKK_500.TaiSanId
			LEFT JOIN CoSo CS ON TS.CoSoId = CS.CoSoId
			LEFT JOIN CoSo CS_TT ON  CS.TrucThuoc = CS_TT.CoSoId
WHERE		(@TaiSanId = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.TaiSanId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @TaiSanId + @V_DELIMITER)>0)
			AND  CHARINDEX(@V_DELIMITER + CAST(TS.CoSoId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @_COSO_IDS + @V_DELIMITER) > 0
			AND (@LoaiKeKhai = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.LoaiKeKhai AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @LoaiKeKhai + @V_DELIMITER)>0)
--------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_report_KeKhai500]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.09
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_report_KeKhai500]
						 @TaiSanId			=	''
						,@Year				=	'2017'
						,@LoaiKeKhai		=	''
						,@COSO_ID			=	1
						,@NHANVIEN_ID		=	''
6. Precaution	:
7. History		:
				  2017.10.09 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_report_KeKhai500]
	 @TaiSanId		NVARCHAR(MAX)	=	NULL
	,@Year			NVARCHAR(MAX)	=	NULL
	,@LoaiKeKhai	NVARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
AS
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_DELIMITER	VARCHAR(10)		=	','
		,@_COSO_IDS		VARCHAR(MAX)	=	NULL

SET @TaiSanId = ISNULL(@TaiSanId, '')
SET @LoaiKeKhai = '4'

EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
   @COSOID=@COSO_ID
  ,@COSOID_OUT=@_COSO_IDS OUTPUT
SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
PRINT @_COSO_IDS

SELECT		 COUNT(TS.TaiSanId) OVER () AS MAXCNT
			,CS.TenCoSo TenDonVi
			,CS_TT.TenCoSo TenDonViChuQuan

			,TS.TaiSanId TS_TaiSanId
			,TS.TenTaiSan TS_TenTaiSan
			,TS.LoaiKeKhai TS_LoaiKeKhai

			,TTKK_500.*
FROM		(
			SELECT		TaiSanId,Nam,(SLTon + SUM(SLTang) - SUM(SLGiam)) TonCuoi
			FROM		TheoDoi
			WHERE		Nam = @Year
			GROUP BY	TaiSanId,Nam,SLTon
			HAVING		(SLTon + SUM(SLTang) - SUM(SLGiam)) > 0
			) TD
			LEFT JOIN TaiSan TS ON TD.TaiSanId = TS.TaiSanId
			LEFT JOIN ThongTinKeKhai_Tren500 TTKK_500 ON TS.TaiSanId = TTKK_500.TaiSanId
			LEFT JOIN CoSo CS ON TS.CoSoId = CS.CoSoId
			LEFT JOIN CoSo CS_TT ON  CS.TrucThuoc = CS_TT.CoSoId
WHERE		(@TaiSanId = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.TaiSanId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @TaiSanId + @V_DELIMITER)>0)
			AND  CHARINDEX(@V_DELIMITER + CAST(TS.CoSoId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @_COSO_IDS + @V_DELIMITER) > 0
			AND (@LoaiKeKhai = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.LoaiKeKhai AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @LoaiKeKhai + @V_DELIMITER)>0)
--------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_report_KeKhaiDat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.09
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_report_KeKhaiDat]
						 @TaiSanId			=	NULL
						,@Year				=	'2017'
						,@LoaiKeKhai		=	''
						,@COSO_ID			=	''
						,@NHANVIEN_ID		=	''
6. Precaution	:
7. History		:
				  2017.10.09 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_report_KeKhaiDat]
	 @TaiSanId		NVARCHAR(MAX)	=	NULL
	,@Year			NVARCHAR(MAX)	=	NULL
	,@LoaiKeKhai	NVARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
AS
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_DELIMITER VARCHAR(10)	=	'|'
		,@_COSO_IDS		VARCHAR(MAX)	=	NULL

SET @TaiSanId = ISNULL(@TaiSanId, '')
SET @LoaiKeKhai = '1'

EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
   @COSOID=@COSO_ID
  ,@COSOID_OUT=@_COSO_IDS OUTPUT
SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
PRINT @_COSO_IDS

SELECT		 COUNT(TS.TaiSanId) OVER () AS MAXCNT
			,CS.TenCoSo TenDonVi
			,CS_TT.TenCoSo TenDonViChuQuan

			,TS.TaiSanId TTKK_DAT_TaiSanId
			,TS.TenTaiSan TTKK_DAT_TenTaiSan

			,TTKK_DAT.DiaChi TTKK_DAT_DiaChi
			,TTKK_DAT.DienTich TTKK_DAT_DienTich
			,TTKK_DAT.GiayTo TTKK_DAT_GiayTo
			,TTKK_DAT.BiLanChiem TTKK_DAT_BiLanChiem
			,TTKK_DAT.ChoThue TTKK_DAT_ChoThue
			,TTKK_DAT.BoTrong TTKK_DAT_BoTrong
			,TTKK_DAT.CoSoHDSuNghiep TTKK_DAT_CoSoHDSuNghiep
			,TTKK_DAT.LamTruSo TTKK_DAT_LamTruSo
			,TTKK_DAT.NhaO TTKK_DAT_NhaO
			,TTKK_DAT.SuDungKhac TTKK_DAT_SuDungKhac


			,TS_NHA.TenTaiSan TTKK_NHA_TenTaiSan
			,TTKK_NHA.DienTich TTKK_NHA_DienTich
			,TTKK_NHA.BiLanChiem TTKK_NHA_BiLanChiem
			,TTKK_NHA.BoTrong TTKK_NHA_BoTrong
			,TTKK_NHA.CapHang TTKK_NHA_CapHang
			,TTKK_NHA.ChoThue TTKK_NHA_ChoThue
			,TTKK_NHA.CoSoHDSuNghiep TTKK_NHA_CoSoHDSuNghiep
			,TTKK_NHA.DiaChi TTKK_NHA_DiaChi
			,TTKK_NHA.LamTruSo TTKK_NHA_LamTruSo
			,TTKK_NHA.NamSuDung TTKK_NHA_NamSuDung
			,TTKK_NHA.NhaO TTKK_NHA_NhaO
			,TTKK_NHA.SoTang TTKK_NHA_SoTang
			,TTKK_NHA.SuDungKhac TTKK_NHA_SuDungKhac
FROM		(
			SELECT		TaiSanId,Nam,(SLTon + SUM(SLTang) - SUM(SLGiam)) TonCuoi
			FROM		TheoDoi
			WHERE		Nam = @Year
			GROUP BY	TaiSanId,Nam,SLTon
			HAVING		(SLTon + SUM(SLTang) - SUM(SLGiam)) > 0
			) TD
			LEFT JOIN TaiSan TS ON TD.TaiSanId = TS.TaiSanId
			LEFT JOIN ThongTinKeKhai_Dat TTKK_DAT ON TS.TaiSanId = TTKK_DAT.TaiSanId
			LEFT JOIN ThongTinKeKhai_Nha TTKK_NHA ON TTKK_DAT.TaiSanId = TTKK_NHA.ThuocDat
			LEFT JOIN TaiSan TS_NHA ON TTKK_NHA.TaiSanId = TS_NHA.TaiSanId
			LEFT JOIN CoSo CS ON TS.CoSoId = CS.CoSoId
			LEFT JOIN CoSo CS_TT ON  CS.TrucThuoc = CS_TT.CoSoId
WHERE		(@TaiSanId = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.TaiSanId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @TaiSanId + @V_DELIMITER)>0)
			AND  CHARINDEX(@V_DELIMITER + CAST(TS.CoSoId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @_COSO_IDS + @V_DELIMITER) > 0
			AND (@LoaiKeKhai = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.LoaiKeKhai AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @LoaiKeKhai + @V_DELIMITER)>0)
--------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_report_KeKhaiOto]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.09
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_report_KeKhaiOto]
						 @TaiSanId			=	''
						,@Year				=	'2017'
						,@LoaiKeKhai		=	''
						,@COSO_ID			=	1
						,@NHANVIEN_ID		=	''
6. Precaution	:
7. History		:
				  2017.10.09 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_report_KeKhaiOto]
	 @TaiSanId		NVARCHAR(MAX)	=	NULL
	,@Year			NVARCHAR(MAX)	=	NULL
	,@LoaiKeKhai	NVARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
AS
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_DELIMITER	VARCHAR(10)		=	','
		,@_COSO_IDS		VARCHAR(MAX)	=	NULL

SET @TaiSanId = ISNULL(@TaiSanId, '')
SET @LoaiKeKhai = '3'

EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
   @COSOID=@COSO_ID
  ,@COSOID_OUT=@_COSO_IDS OUTPUT
SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
PRINT @_COSO_IDS

SELECT		 COUNT(TS.TaiSanId) OVER () AS MAXCNT
			,CS.TenCoSo TenDonVi
			,CS_TT.TenCoSo TenDonViChuQuan

			,TS.TaiSanId TS_TaiSanId
			,TS.TenTaiSan TS_TenTaiSan
			,TS.LoaiKeKhai TS_LoaiKeKhai

			,TTKK_OTO.*
FROM		(
			SELECT		TaiSanId,Nam,(SLTon + SUM(SLTang) - SUM(SLGiam)) TonCuoi
			FROM		TheoDoi
			WHERE		Nam = @Year
			GROUP BY	TaiSanId,Nam,SLTon
			HAVING		(SLTon + SUM(SLTang) - SUM(SLGiam)) > 0
			) TD
			LEFT JOIN TaiSan TS ON TD.TaiSanId = TS.TaiSanId
			LEFT JOIN ThongTinKeKhai_Oto TTKK_OTO ON TS.TaiSanId = TTKK_OTO.TaiSanId
			LEFT JOIN CoSo CS ON TS.CoSoId = CS.CoSoId
			LEFT JOIN CoSo CS_TT ON  CS.TrucThuoc = CS_TT.CoSoId
WHERE		(@TaiSanId = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.TaiSanId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @TaiSanId + @V_DELIMITER)>0)
			AND  CHARINDEX(@V_DELIMITER + CAST(TS.CoSoId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @_COSO_IDS + @V_DELIMITER) > 0
			AND (@LoaiKeKhai = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.LoaiKeKhai AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @LoaiKeKhai + @V_DELIMITER)>0)
--------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_report_NhaDat_TSNN]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.09
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_report_NhaDat_TSNN]
						 @TaiSanId			=	''
						,@LoaiKeKhai		=	'1'
						,@Year				=	''
						,@COSO_ID			=	1
						,@NHANVIEN_ID		=	6
6. Precaution	:
7. History		:
				  2017.10.09 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_report_NhaDat_TSNN]
	 @TaiSanId		VARCHAR(MAX)	=	NULL
	,@LoaiKeKhai	VARCHAR(MAX)	=	NULL
	,@Year			VARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
AS
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_DELIMITER VARCHAR(10)	=	'|'
		,@V_COSO_IDS		VARCHAR(MAX)	=	NULL

SET @TaiSanId = ISNULL(@TaiSanId, '')
SET @LoaiKeKhai = '1'

EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
   @COSOID=@COSO_ID
  ,@COSOID_OUT=@V_COSO_IDS OUTPUT
SET @V_COSO_IDS = REPLACE(@V_COSO_IDS,',',@V_DELIMITER)

PRINT CONCAT('@V_COSO_IDS=', @V_COSO_IDS)

SELECT		 COUNT(TS.TaiSanId) OVER () AS MAXCNT
			,CS.TenCoSo TenDonVi
			,CS_TT.TenCoSo TenDonViChuQuan

			,TS.TaiSanId TTKK_DAT_TaiSanId
			,TS.TenTaiSan TTKK_DAT_TenTaiSan
			,TTKK_DAT.DiaChi TTKK_DAT_DiaChi
			,TTKK_DAT.DienTich TTKK_DAT_DienTich
			,TTKK_DAT.GiayTo TTKK_DAT_GiayTo
			,TTKK_DAT.BiLanChiem TTKK_DAT_BiLanChiem
			,TTKK_DAT.ChoThue TTKK_DAT_ChoThue
			,TTKK_DAT.BoTrong TTKK_DAT_BoTrong
			,TTKK_DAT.CoSoHDSuNghiep TTKK_DAT_CoSoHDSuNghiep
			,TTKK_DAT.LamTruSo TTKK_DAT_LamTruSo
			,TTKK_DAT.NhaO TTKK_DAT_NhaO
			,TTKK_DAT.SuDungKhac TTKK_DAT_SuDungKhac

			,TS_NHA.TenTaiSan TTKK_NHA_TenTaiSan
			,TTKK_NHA.DienTich TTKK_NHA_DienTich
			,TTKK_NHA.BiLanChiem TTKK_NHA_BiLanChiem
			,TTKK_NHA.BoTrong TTKK_NHA_BoTrong
			,TTKK_NHA.CapHang TTKK_NHA_CapHang
			,TTKK_NHA.ChoThue TTKK_NHA_ChoThue
			,TTKK_NHA.CoSoHDSuNghiep TTKK_NHA_CoSoHDSuNghiep
			,TTKK_NHA.DiaChi TTKK_NHA_DiaChi
			,TTKK_NHA.LamTruSo TTKK_NHA_LamTruSo
			,TTKK_NHA.NamSuDung TTKK_NHA_NamSuDung
			,TTKK_NHA.NhaO TTKK_NHA_NhaO
			,TTKK_NHA.SoTang TTKK_NHA_SoTang
			,TTKK_NHA.SuDungKhac TTKK_NHA_SuDungKhac
FROM		TaiSan TS
			LEFT JOIN ThongTinKeKhai_Dat TTKK_DAT ON TS.TaiSanId = TTKK_DAT.TaiSanId
			LEFT JOIN ThongTinKeKhai_Nha TTKK_NHA ON TTKK_DAT.TaiSanId = TTKK_NHA.ThuocDat
			LEFT JOIN TaiSan TS_NHA ON TTKK_NHA.TaiSanId = TS_NHA.TaiSanId
			LEFT JOIN CoSo CS ON TS.CoSoId = CS.CoSoId
			LEFT JOIN CoSo CS_TT ON  CS.TrucThuoc = CS_TT.CoSoId
WHERE		(@TaiSanId = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.TaiSanId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @TaiSanId + @V_DELIMITER)>0)
			AND  CHARINDEX(@V_DELIMITER + CAST(TS.CoSoId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @V_COSO_IDS + @V_DELIMITER) > 0
			AND (@LoaiKeKhai = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.LoaiKeKhai AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @LoaiKeKhai + @V_DELIMITER)>0)
--------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_report_Oto_TSNN]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.11.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_report_Oto_TSNN]
						 @TaiSanId			=	''
						,@Year				=	'2017'
						,@LoaiKeKhai		=	''
						,@COSO_ID			=	1
						,@NHANVIEN_ID		=	''
6. Precaution	:
7. History		:
				  2017.11.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_report_Oto_TSNN]
	 @TaiSanId		NVARCHAR(MAX)	=	NULL
	,@Year			NVARCHAR(MAX)	=	NULL
	,@LoaiKeKhai	NVARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
AS
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_DELIMITER	VARCHAR(10)		=	','
		,@_COSO_IDS		VARCHAR(MAX)	=	NULL

SET @TaiSanId = ISNULL(@TaiSanId, '')
SET @LoaiKeKhai = '3'

EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
   @COSOID=@COSO_ID
  ,@COSOID_OUT=@_COSO_IDS OUTPUT
SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
PRINT @_COSO_IDS

SELECT		 COUNT(TS.TaiSanId) OVER () AS MAXCNT
			,CS.TenCoSo TenDonVi
			,CS_TT.TenCoSo TenDonViChuQuan

			,TS.TaiSanId TS_TaiSanId
			,TS.TenTaiSan TS_TenTaiSan
			,TS.LoaiKeKhai TS_LoaiKeKhai
			,lts.LoaiId,lts.TenLoai
			,TTKK_OTO.*
FROM		TaiSan TS
			LEFT JOIN ThongTinKeKhai_Oto TTKK_OTO ON TS.TaiSanId = TTKK_OTO.TaiSanId
			LEFT JOIN CoSo CS ON TS.CoSoId = CS.CoSoId
			LEFT JOIN CoSo CS_TT ON  CS.TrucThuoc = CS_TT.CoSoId
			left join LoaiTaiSan LTS on ts.LoaiId = lts.LoaiId
WHERE		(@TaiSanId = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.TaiSanId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @TaiSanId + @V_DELIMITER)>0)
			AND  CHARINDEX(@V_DELIMITER + CAST(TS.CoSoId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @_COSO_IDS + @V_DELIMITER) > 0
			AND (@LoaiKeKhai = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.LoaiKeKhai AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @LoaiKeKhai + @V_DELIMITER)>0)
--------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TaiSan_UpdateTaiSan]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.08.31
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: UPDATE THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					DECLARE @NguyenGiaList dbo.NguyenGiaType
					INSERT INTO @NguyenGiaList VALUES(0,1,121212121)

					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_UpdateTaiSan]
						 @TaiSanId			=	34
						,@MaTaiSan			=	'TS001'
						,@TenTaiSan			=	N'KHÔNG BIẾT'
						,@DonViTinh			=	'CÁI'
						,@LoaiId			=	1
						,@PhuongThucId		=	1
						,@NamSanXuat		=	2015
						,@NuocSanXuatId		=	1
						,@HangSanXuatId		=	2
						,@SoQDTC			=	'QDTC'
						,@NhanHieu			=	'SAMSUNG'
						,@DuAnId			=	1
						,@NgayMua			=	'2018-08-31'
						,@NgayBDHaoMon		=	'2018-08-31'
						,@SoNamSuDung		=	1
						,@TyLeHaoMon		=	1.1
						,@HaoMonLuyKe		=	1.1
						,@NgayBDKhauHao		=	'2018-08-31'
						,@KyTinhKhauHao		=	N'KỲ KH'
						,@GiaTriKhauHao		=	1
						,@SoKyKhauHao		=	1
						,@TyLeKhauHao		=	1.1
						,@KhauHaoLuyKe		=	1.1
						,@LoaiKeKhai		=	1
						,@NguoiTao			=	NULL
						,@NgayTao			=	NULL
						,@CtrVersion		=	NULL

						,@NguyenGiaList		=	@NguyenGiaList

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.08.31 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TaiSan_UpdateTaiSan]
	/* TÀI SẢN */
	 @TaiSanId			INT				=	NULL
    ,@MaTaiSan			NVARCHAR(MAX)	=	NULL
    ,@TenTaiSan			NVARCHAR(MAX)	=	NULL
    ,@DonViTinh			NVARCHAR(MAX)	=	NULL
    ,@LoaiId			INT				=	NULL
    ,@PhuongThucId		INT				=	NULL
    ,@NamSanXuat		NUMERIC(4,0)	=	NULL
    ,@NuocSanXuatId		INT				=	NULL
    ,@HangSanXuatId		INT				=	NULL
    ,@SoQDTC			NVARCHAR(MAX)	=	NULL
    ,@NhanHieu			NVARCHAR(MAX)	=	NULL
    ,@DuAnId			INT				=	NULL
    ,@NgayMua			DATETIME		=	NULL
    ,@NgayBDHaoMon		DATETIME		=	NULL
    ,@SoNamSuDung		INT				=	NULL
    ,@TyLeHaoMon		NUMERIC(5,2)	=	NULL
    ,@HaoMonLuyKe		NUMERIC(18,4)	=	NULL
    ,@NgayBDKhauHao		DATETIME		=	NULL
    ,@KyTinhKhauHao		NVARCHAR(MAX)	=	NULL
    ,@GiaTriKhauHao		NUMERIC(18,4)	=	NULL
    ,@SoKyKhauHao		NUMERIC(5,0)	=	NULL
    ,@TyLeKhauHao		NUMERIC(5,2)	=	NULL
    ,@KhauHaoLuyKe		NUMERIC(18,4)	=	NULL
    ,@LoaiKeKhai		INT				=	NULL
    ,@NguoiTao			INT				=	NULL
    ,@NgayTao			DATETIME		=	NULL
    ,@CtrVersion		INT				=	NULL

	,@NguyenGiaList		NguyenGiaType		READONLY

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@CtrVersion		=	ISNULL(@CtrVersion, 0)

BEGIN TRY

	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	-- KIỂM TRA @CtrVersion
	IF EXISTS (SELECT 1 FROM TaiSan WHERE TaiSanId = @TaiSanId AND CtrVersion <> @CtrVersion)
	BEGIN
		SET @MESSAGE = N'CTR_VERSION|1|Phiếu này đã có người thay đổi thông tin';
		THROW 51000, @MESSAGE, 1;
	END

	-- KIỂM TRA @MaTaiSan
	IF EXISTS (SELECT 1 FROM TaiSan WHERE CoSoId = @CoSoId AND MaTaiSan = @MaTaiSan AND TaiSanId <> @TaiSanId)
	BEGIN
		SET @MESSAGE	=	N'MA_TAI_SAN|1|Mã tài sản đã tồn tại';
		THROW 51000, @MESSAGE, 1;
	END

BEGIN TRANSACTION TAISAN_UPDATE
	-- INSERT DỮ LIỆU
	UPDATE	TaiSan
	SET		 MaTaiSan		=	@MaTaiSan
			,TenTaiSan		=	@TenTaiSan
			,DonViTinh		=	@DonViTinh
			,LoaiId			=	@LoaiId
			,PhuongThucId	=	@PhuongThucId
			,NamSanXuat		=	@NamSanXuat
			,NuocSanXuatId	=	@NuocSanXuatId
			,HangSanXuatId	=	@HangSanXuatId
			,SoQDTC			=	@SoQDTC
			,NhanHieu		=	@NhanHieu
			,DuAnId			=	@DuAnId
			,NgayMua		=	@NgayMua
			,NgayBDHaoMon	=	@NgayBDHaoMon
			,SoNamSuDung	=	@SoNamSuDung
			,TyLeHaoMon		=	@TyLeHaoMon
			,HaoMonLuyKe	=	@HaoMonLuyKe
			,NgayBDKhauHao	=	@NgayBDKhauHao
			,KyTinhKhauHao	=	@KyTinhKhauHao
			,GiaTriKhauHao	=	@GiaTriKhauHao
			,SoKyKhauHao	=	@SoKyKhauHao
			,TyLeKhauHao	=	@TyLeKhauHao
			,KhauHaoLuyKe	=	@KhauHaoLuyKe
			,LoaiKeKhai		=	@LoaiKeKhai
			,CtrVersion		=	CtrVersion + 1
	 WHERE TaiSanId = @TaiSanId

	/*** NGUYÊN GIÁ ***/
	 DELETE NguyenGia WHERE TaiSanId = @TaiSanId

	INSERT INTO NguyenGia (	TaiSanId	,NguonNganSachId	,GiaTri )
	SELECT					@TaiSanId	,NguonNganSachId	,GiaTri
	FROM @NguyenGiaList

	COMMIT TRANSACTION TAISAN_UPDATE
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION TAISAN_UPDATE

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();
	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM TaiSan WHERE TaiSanId = @TaiSanId

	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTin_DeleteThayDoiThongTin]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.15
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTin_DeleteThayDoiThongTin]
						 @ThayDoiThongTinId			=	39

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.15 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTin_DeleteThayDoiThongTin]
	 @ThayDoiThongTinId		INT				=	NULL

	,@CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON

DECLARE  @V_TRANS_NAME			NVARCHAR(MAX)	=	N'TDTT_DELETE'
		,@V_TAISANID			INT				=	NULL
		,@V_NGAY				DATETIME		=	NULL
		,@V_LAOIKEKHAI			INT				=	NULL

BEGIN TRY
	SET @MESSAGE = ISNULL(@MESSAGE,'')

	SELECT		 @V_TAISANID = TS.TaiSanId
				,@V_LAOIKEKHAI = TS.LoaiKeKhai
				,@V_NGAY = Ngay
	FROM		ThayDoiThongTin TDTT
				LEFT JOIN TAISAN TS ON TDTT.TaiSanId = TS.TaiSanId
	WHERE TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
	SELECT @V_TAISANID = TAISANID FROM THAYDOITHONGTIN WHERE THAYDOITHONGTINID = @THAYDOITHONGTINID

	IF EXISTS (SELECT 1 FROM THAYDOITHONGTIN WHERE TAISANID = @V_TAISANID AND THAYDOITHONGTINID <> @THAYDOITHONGTINID AND Ngay >= @V_NGAY)
	BEGIN
		SET @MESSAGE = N'NGAY|1|Không thể xóa vì đã có nhiều thay đổi';
		THROW 51000, @MESSAGE, 1;
	END

BEGIN TRANSACTION @V_TRANS_NAME

	-- UPDATE TÀI SẢN
	UPDATE		TS
	SET			TS.TenTaiSan = ISNULL(TDTT.TenTaiSanCu,TS.TenTaiSan)
	FROM		ThayDoiThongTin TDTT
				LEFT JOIN TaiSan TS ON TDTT.TaiSanId = TS.TaiSanId
	WHERE		TDTT.ThayDoiThongTinId = @ThayDoiThongTinId

	-- UPDATE THÔNG TIN TÀI SẢN KÊ KHAI
	IF @V_LAOIKEKHAI = 1 -- ĐẤT
	BEGIN
		UPDATE		TTKK
		SET			 TTKK.BiLanChiem		=	ISNULL(TDTT_LOAI.BiLanChiemCu,TTKK.BiLanChiem)
					,TTKK.BoTrong			=	ISNULL(TDTT_LOAI.BoTrongCu,TTKK.BoTrong)
					,TTKK.ChoThue			=	ISNULL(TDTT_LOAI.ChoThueCu,TTKK.ChoThue)
					,TTKK.CoSoHDSuNghiep	=	ISNULL(TDTT_LOAI.CoSoHDSuNghiepCu,TTKK.CoSoHDSuNghiep)
					,TTKK.DiaChi			=	ISNULL(TDTT_LOAI.DiaChiCu,TTKK.DiaChi)
					,TTKK.DienTich			=	ISNULL(TDTT_LOAI.DienTichCu,TTKK.DienTich)
					,TTKK.GiayTo			=	ISNULL(TDTT_LOAI.GiayToCu,TTKK.GiayTo)
					,TTKK.LamTruSo			=	ISNULL(TDTT_LOAI.LamTruSoCu,TTKK.LamTruSo)
					,TTKK.NhaO				=	ISNULL(TDTT_LOAI.NhaOCu,TTKK.NhaO)
					,TTKK.SuDungKhac		=	ISNULL(TDTT_LOAI.SuDungKhacCu,TTKK.SuDungKhac)
		FROM		ThongTinKeKhai_Dat TTKK
					LEFT JOIN ThayDoiThongTin TDTT ON TTKK.TaiSanId = TDTT.TaiSanId
					LEFT JOIN ThayDoiThongTin_Dat TDTT_LOAI ON TDTT.ThayDoiThongTinId = TDTT_LOAI.ThayDoiThongTinId
		WHERE		TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
	END
	-- UPDATE THÔNG TIN TÀI SẢN KÊ KHAI
	ELSE IF @V_LAOIKEKHAI = 2 -- NHÀ
	BEGIN
		UPDATE		TTKK
		SET			 TTKK.BiLanChiem		=	ISNULL(TDTT_LOAI.BiLanChiemCu,TTKK.BiLanChiem)
					,TTKK.BoTrong			=	ISNULL(TDTT_LOAI.BoTrongCu,TTKK.BoTrong)
					,TTKK.CapHang			=	ISNULL(TDTT_LOAI.CapHangCu,TTKK.CapHang)
					,TTKK.ChoThue			=	ISNULL(TDTT_LOAI.ChoThueCu,TTKK.ChoThue)
					,TTKK.CoSoHDSuNghiep	=	ISNULL(TDTT_LOAI.CoSoHDSuNghiepCu,TTKK.CoSoHDSuNghiep)
					,TTKK.DiaChi			=	ISNULL(TDTT_LOAI.DiaChiCu,TTKK.DiaChi)
					,TTKK.DienTich			=	ISNULL(TDTT_LOAI.DienTichCu,TTKK.DienTich)
					,TTKK.GiayTo			=	ISNULL(TDTT_LOAI.GiayToCu,TTKK.GiayTo)
					,TTKK.LamTruSo			=	ISNULL(TDTT_LOAI.LamTruSoCu,TTKK.LamTruSo)
					,TTKK.NamSuDung			=	ISNULL(TDTT_LOAI.NamSuDungCu,TTKK.NamSuDung)
					,TTKK.NhaO				=	ISNULL(TDTT_LOAI.NhaOCu,TTKK.NhaO)
					,TTKK.SuDungKhac		=	ISNULL(TDTT_LOAI.SuDungKhacCu,TTKK.SuDungKhac)
					,TTKK.TongDienTichSan	=	ISNULL(TDTT_LOAI.TongDienTichSanCu,TTKK.TongDienTichSan)
		FROM		ThongTinKeKhai_Nha TTKK
					LEFT JOIN ThayDoiThongTin TDTT ON TTKK.TaiSanId = TDTT.TaiSanId
					LEFT JOIN ThayDoiThongTin_Nha TDTT_LOAI ON TDTT.ThayDoiThongTinId = TDTT_LOAI.ThayDoiThongTinId
		WHERE		TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
	END
	ELSE IF @V_LAOIKEKHAI = 3 -- OTO
	BEGIN
		UPDATE		TTKK
		SET			 TTKK.BienKiemSoat		=	ISNULL(TDTT_LOAI.BienKiemSoatCu,TTKK.BienKiemSoat)
					,TTKK.ChucDanh			=	ISNULL(TDTT_LOAI.ChucDanhCu,TTKK.ChucDanh)
					,TTKK.CongSuatXe		=	ISNULL(TDTT_LOAI.CongSuatXeCu,TTKK.CongSuatXe)
					,TTKK.HienTrangSuDung	=	ISNULL(TDTT_LOAI.HienTrangSuDungCu,TTKK.HienTrangSuDung)
					,TTKK.LoaiXe			=	ISNULL(TDTT_LOAI.LoaiXeCu,TTKK.LoaiXe)
					,TTKK.NguonGocXe		=	ISNULL(TDTT_LOAI.NguonGocXeCu,TTKK.NguonGocXe)
					,TTKK.NhanHieu			=	ISNULL(TDTT_LOAI.NhanHieuCu,TTKK.NhanHieu)
					,TTKK.TrongTai			=	ISNULL(TDTT_LOAI.TrongTaiCu,TTKK.TrongTai)
		FROM		ThongTinKeKhai_Oto TTKK
					LEFT JOIN ThayDoiThongTin TDTT ON TTKK.TaiSanId = TDTT.TaiSanId
					LEFT JOIN ThayDoiThongTin_Oto TDTT_LOAI ON TDTT.ThayDoiThongTinId = TDTT_LOAI.ThayDoiThongTinId
		WHERE		TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
	END
	ELSE IF @V_LAOIKEKHAI = 4 -- TRÊN 500 TRIỆU
	BEGIN
		UPDATE		TTKK
		SET			 TTKK.HienTrangSuDung	=	ISNULL(TDTT_LOAI.HienTrangSuDungCu,TTKK.HienTrangSuDung)
					,TTKK.KyHieu			=	ISNULL(TDTT_LOAI.KyHieuCu,TTKK.KyHieu)
		FROM		ThongTinKeKhai_Tren500 TTKK
					LEFT JOIN ThayDoiThongTin TDTT ON TTKK.TaiSanId = TDTT.TaiSanId
					LEFT JOIN ThayDoiThongTin_Tren500 TDTT_LOAI ON TDTT.ThayDoiThongTinId = TDTT_LOAI.ThayDoiThongTinId
		WHERE		TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
	END


	-- DELETE THAY ĐỔI THÔNG TIN
	DELETE ThayDoiThongTin_Dat WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	DELETE ThayDoiThongTin_Nha WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	DELETE ThayDoiThongTin_Oto WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	DELETE ThayDoiThongTin_Tren500 WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	DELETE ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH

	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId

SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTin_GetListThayDoiThongTinByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTin_GetListThayDoiThongTinByCriteria]
						 @Search			=	N'ghế'
						,@Skip				=	6
						,@Take				=	10
						,@OrderClause		=	'ID desc'

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTin_GetListThayDoiThongTinByCriteria]
	 @Search			NVARCHAR(MAX)	=	NULL
	,@Field				NVARCHAR(MAX)	=	NULL
	,@Skip				INT				=	NULL
	,@Take				INT				=	NULL
	,@OrderClause		NVARCHAR(MAX)	=	NULL

	,@CoSoId			VARCHAR(10)		=	NULL
	,@NhanVienId		VARCHAR(10)		=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON
	DECLARE @V_SQL NVARCHAR(MAX) 
			,@V_DELIMITER	VARCHAR(10)		=	'|'
			,@_COSO_IDS		VARCHAR(MAX)	=	NULL
			,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@NhanVienId,@NAM=@Nam OUTPUT;
---- SET DEFAULT PARAMS
	SET @CoSoId = ISNULL(@CoSoId,0)
	SET @NhanVienId = ISNULL(@NhanVienId,0)
	SET @MESSAGE = ISNULL(@MESSAGE,'')

	SET @Search = ISNULL(@Search,'')
	SET @Skip = ISNULL(@Skip,0)

	SET @Take = ISNULL(@Take,0)
	IF @Take = 0
		SET @Take = 10

	SET @OrderClause = ISNULL(@OrderClause,'')
	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';

	SET @Field = ISNULL(@Field,'TDTT.*')

	--EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	--   @COSOID=@CoSoId
	--  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	--SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
	--PRINT concat('@_COSO_IDS=',@_COSO_IDS)
	----
	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0027',
		@QUYEN=@IS_VIEW OUTPUT
---- KIỂM TRA
---- BUILD SQL CLAUSE
	SET @V_SQL = N'
	SELECT		COUNT(TDTT.ThayDoiThongTinId) OVER () AS MAXCNT,' + @Field + ' 
				,TS.MaTaiSan,TS.TenTaiSan,TS.LoaiKeKhai
				,NV_ND.TenNhanVien TenNguoiDuyet
				,TDTT.ThayDoiThongTinId ID,TDTT.CtrVersion VERSION
	FROM		ThayDoiThongTin TDTT
				LEFT JOIN TaiSan TS ON TDTT.TaiSanId = TS.TaiSanId
				LEFT JOIN NhanVien NV_ND ON TDTT.NguoiDuyet = NV_ND.NhanVienId
				LEFT JOIN NhanVien NV_NT ON TDTT.NguoiTao = NV_NT.NhanVienId
				LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=TDTT.NguoiTao
	WHERE		YEAR(TDTT.Ngay)='''+@Nam+''' AND (@Search = '''' OR TS.MaTaiSan LIKE ''%'' + @Search + ''%'' OR TS.TenTaiSan LIKE ''%'' + @Search + ''%'')';
				------------
	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and TDTT.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @NhanVienId+ '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and NV_NT.NhanVienId =''' + @NhanVienId + '''';   
	END
	----------
	SET @V_SQL = @V_SQL + ' ORDER BY	' + @OrderClause + ' OFFSET @Skip ROWS FETCH NEXT @Take ROWS ONLY';

	print(@V_SQL)
---- EXEC @V_SQL
	exec sp_executesql @V_SQL,N'
		 @Search			NVARCHAR(MAX)	=	NULL
		,@Field				NVARCHAR(MAX)	=	NULL
		,@Skip				INT				=	NULL
		,@Take				INT				=	NULL
		,@CoSoId			INT				=	NULL
		'
		,@Search		=	@Search
		,@Field			=	@Field
		,@Skip			=	@Skip
		,@Take			=	@Take
		,@CoSoId		=	@CoSoId
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTin_GetThayDoiThongTinById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTin_GetThayDoiThongTinById]
						 @ThayDoiThongTinId			=	26

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTin_GetThayDoiThongTinById]
	 @ThayDoiThongTinId		INT				=	NULL

	,@CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON
	DECLARE @_COSO_IDS		VARCHAR(MAX)	=	NULL

	SET @MESSAGE = ISNULL(@MESSAGE,'')

	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',','|')
	PRINT concat('@_COSO_IDS=',@_COSO_IDS)

	SELECT	TDTT.ThayDoiThongTinId,TDTT.TaiSanId,TDTT.Ngay,
	TS.TenTaiSan  as TenTaiSanMoi,Isnull(TDTT.TenTaiSanCu,TS.TenTaiSan) as TenTaiSanCu
	,TDTT.LyDo,TDTT.DuyetId,TDTT.NguoiDuyet,TDTT.CoSoId,TDTT.NguoiTao,TDTT.NgayTao,TDTT.CtrVersion,
	 TS.LoaiKeKhai LoaiKeKhai
	FROM	ThayDoiThongTin TDTT 
			LEFT JOIN TaiSan TS ON TDTT.TaiSanId = TS.TaiSanId
	WHERE	CHARINDEX('|' + CAST(TS.CoSoId AS VARCHAR(10)) + '|','|' + @_COSO_IDS + '|') > 0
			AND TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTin_report_TDTTById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.27
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_ThayDoiThongTin_report_TDTTById]
						 @ThayDoiThongTinId			=	82
6. Precaution	:
7. History		:
				  2017.09.27 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTin_report_TDTTById]
	@ThayDoiThongTinId		INT			=	NULL
AS  
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE @V_NGUYENGIA DECIMAL(18,4) = NULL
		,@V_TAISANID INT = NULL

SET @ThayDoiThongTinId = ISNULL(@ThayDoiThongTinId, 0)

SELECT @V_TAISANID = TaiSanId FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId

SELECT @V_NGUYENGIA = ISNULL(SUM(GiaTri),0) FROM NguyenGia WHERE TaiSanId = @V_TAISANID

SELECT		-- THÔNG TIN CHUNG
			 TDTT.Ngay,TS.LoaiKeKhai,CS.TenCoSo TenDonVi,CS_QL.TenCoSo TenDonViChuQuan
			 ,@V_NGUYENGIA NguyenGia
			--,TS.TenTaiSan				,TDTT.TenTaiSanCu
			,CASE WHEN TDTT.TenTaiSanCu IS NOT NULL THEN TS.TenTaiSan ELSE TDTT.TenTaiSanCu END TenTaiSan
			,ISNULL(TDTT.TenTaiSanCu,TS.TenTaiSan) TenTaiSanCu
			
			-- THÔNG TIN NHÀ
			
			--,TTKK_NHA.DiaChi			TTKK_NHA_DiaChi			,TDTT_NHA.DiaChiCu				TDTT_NHA_DiaChiCu
			,CASE WHEN TDTT_NHA.DiaChiCu IS NOT NULL THEN TTKK_NHA.DiaChi ELSE TDTT_NHA.DiaChiCu END TTKK_NHA_DiaChi
			,ISNULL(TDTT_NHA.DiaChiCu,TTKK_NHA.DiaChi) TDTT_NHA_DiaChiCu

			--,TTKK_NHA.DienTich			TTKK_NHA_DienTich			,TDTT_NHA.DienTichCu				TDTT_NHA_DienTichCu
			,CASE WHEN TDTT_NHA.DienTichCu IS NOT NULL THEN TTKK_NHA.DienTich ELSE TDTT_NHA.DienTichCu END TTKK_NHA_DienTich
			,ISNULL(TDTT_NHA.DienTichCu,TTKK_NHA.DienTich) TDTT_NHA_DienTichCu
			--,TTKK_NHA.TongDienTichSan			TTKK_NHA_TongDienTichSan			,TDTT_NHA.TongDienTichSanCu				TDTT_NHA_TongDienTichSanCu
			,CASE WHEN TDTT_NHA.TongDienTichSanCu IS NOT NULL THEN TTKK_NHA.TongDienTichSan ELSE TDTT_NHA.TongDienTichSanCu END TTKK_NHA_TongDienTichSan
			,ISNULL(TDTT_NHA.TongDienTichSanCu,TTKK_NHA.TongDienTichSan) TDTT_NHA_TongDienTichSanCu
			--,TTKK_NHA.BoTrong			TTKK_NHA_BoTrong			,TDTT_NHA.BoTrongCu				TDTT_NHA_BoTrongCu
			,CASE WHEN TDTT_NHA.BoTrongCu IS NOT NULL THEN TTKK_NHA.BoTrong ELSE TDTT_NHA.BoTrongCu END TTKK_NHA_BoTrong
			,ISNULL(TDTT_NHA.BoTrongCu,TTKK_NHA.BoTrong) TDTT_NHA_BoTrongCu
			--,TTKK_NHA.ChoThue			TTKK_NHA_ChoThue			,TDTT_NHA.ChoThueCu				TDTT_NHA_ChoThueCu
			,CASE WHEN TDTT_NHA.ChoThueCu IS NOT NULL THEN TTKK_NHA.ChoThue ELSE TDTT_NHA.ChoThueCu END TTKK_NHA_ChoThue
			,ISNULL(TDTT_NHA.ChoThueCu,TTKK_NHA.ChoThue) TDTT_NHA_ChoThueCu
			--,TTKK_NHA.CoSoHDSuNghiep	TTKK_NHA_CoSoHDSuNghiep		,TDTT_NHA.CoSoHDSuNghiepCu		TDTT_NHA_CoSoHDSuNghiepCu
			,CASE WHEN TDTT_NHA.CoSoHDSuNghiepCu IS NOT NULL THEN TTKK_NHA.CoSoHDSuNghiep ELSE TDTT_NHA.CoSoHDSuNghiepCu END TTKK_NHA_CoSoHDSuNghiep
			,ISNULL(TDTT_NHA.CoSoHDSuNghiepCu,TTKK_NHA.CoSoHDSuNghiep) TDTT_NHA_CoSoHDSuNghiepCu
			--,TTKK_NHA.LamTruSo			TTKK_NHA_LamTruSo			,TDTT_NHA.LamTruSoCu			TDTT_NHA_LamTruSoCu
			,CASE WHEN TDTT_NHA.LamTruSoCu IS NOT NULL THEN TTKK_NHA.LamTruSo ELSE TDTT_NHA.ChoThueCu END TTKK_NHA_LamTruSo
			,ISNULL(TDTT_NHA.LamTruSoCu,TTKK_NHA.LamTruSo) TDTT_NHA_LamTruSoCu
			--,TTKK_NHA.NhaO				TTKK_NHA_NhaO				,TDTT_NHA.NhaOCu				TDTT_NHA_NhaOCu
			,CASE WHEN TDTT_NHA.NhaOCu IS NOT NULL THEN TTKK_NHA.NhaO ELSE TDTT_NHA.NhaOCu END TTKK_NHA_NhaO
			,ISNULL(TDTT_NHA.NhaOCu,TTKK_NHA.NhaO) TDTT_NHA_NhaOCu

			-- THÔNG TIN ĐẤT
			
			--,TTKK_DAT.DiaChi			TTKK_DAT_DiaChi				,TDTT_DAT.DiaChiCu				TDTT_DAT_DiaChiCu
			,CASE WHEN TDTT_DAT.DiaChiCu IS NOT NULL THEN TTKK_DAT.DiaChi ELSE TDTT_DAT.DiaChiCu END TTKK_DAT_DiaChi
			,ISNULL(TDTT_DAT.DiaChiCu,TTKK_DAT.DiaChi) TDTT_DAT_DiaChiCu
			--,TTKK_DAT.DienTich			TTKK_DAT_DienTich			,TDTT_DAT.DienTichCu			TDTT_DAT_DienTichCu
			,CASE WHEN TDTT_DAT.DienTichCu IS NOT NULL THEN TTKK_DAT.DienTich ELSE TDTT_DAT.DienTichCu END TTKK_DAT_DienTich
			,ISNULL(TDTT_DAT.DienTichCu,TTKK_DAT.DienTich) TDTT_DAT_DienTichCu
			--,TTKK_DAT.LamTruSo			TTKK_DAT_LamTruSo			,TDTT_DAT.LamTruSoCu			TDTT_DAT_LamTruSoCu
			,CASE WHEN TDTT_DAT.LamTruSoCu IS NOT NULL THEN TTKK_DAT.LamTruSo ELSE TDTT_DAT.LamTruSoCu END TTKK_DAT_LamTruSo
			,ISNULL(TDTT_DAT.LamTruSoCu,TTKK_DAT.LamTruSo) TDTT_DAT_LamTruSoCu
			--,TTKK_DAT.CoSoHDSuNghiep	TTKK_DAT_CoSoHDSuNghiep		,TDTT_DAT.CoSoHDSuNghiepCu		TDTT_DAT_CoSoHDSuNghiepCu
			,CASE WHEN TDTT_DAT.CoSoHDSuNghiepCu IS NOT NULL THEN TTKK_DAT.CoSoHDSuNghiep ELSE TDTT_DAT.CoSoHDSuNghiepCu END TTKK_DAT_CoSoHDSuNghiep
			,ISNULL(TDTT_DAT.CoSoHDSuNghiepCu,TTKK_DAT.CoSoHDSuNghiep) TDTT_DAT_CoSoHDSuNghiepCu
			--,TTKK_DAT.NhaO				TTKK_DAT_NhaO				,TDTT_DAT.NhaOCu				NhaOCu
			,CASE WHEN TDTT_DAT.NhaOCu IS NOT NULL THEN TTKK_DAT.NhaO ELSE TDTT_DAT.NhaOCu END TTKK_DAT_NhaO
			,ISNULL(TDTT_DAT.NhaOCu,TTKK_DAT.NhaO) TDTT_DAT_NhaOCu
			--,TTKK_DAT.ChoThue			TTKK_DAT_ChoThue			,TDTT_DAT.ChoThueCu				TDTT_DAT_ChoThueCu
			,CASE WHEN TDTT_DAT.ChoThueCu IS NOT NULL THEN TTKK_DAT.ChoThue ELSE TDTT_DAT.ChoThueCu END TTKK_DAT_ChoThue
			,ISNULL(TDTT_DAT.ChoThueCu,TTKK_DAT.ChoThue) TDTT_DAT_ChoThueCu
			--,TTKK_DAT.BoTrong			TTKK_DAT_BoTrong			,TDTT_DAT.BoTrongCu				TDTT_DAT_BoTrongCu
			,CASE WHEN TDTT_DAT.BoTrongCu IS NOT NULL THEN TTKK_DAT.BoTrong ELSE TDTT_DAT.BoTrongCu END TTKK_DAT_BoTrong
			,ISNULL(TDTT_DAT.BoTrongCu,TTKK_DAT.BoTrong) TDTT_DAT_BoTrongCu

			-- THÔNG TIN OTO
			
			--,TTKK_OTO.BienKiemSoat			TTKK_OTO_BienKiemSoat			,TDTT_OTO.BienKiemSoatCu				TDTT_OTO_BienKiemSoatCu
			,CASE WHEN TDTT_OTO.BienKiemSoatCu IS NOT NULL THEN TTKK_OTO.BienKiemSoat ELSE TDTT_OTO.BienKiemSoatCu END TTKK_OTO_BienKiemSoat
			,ISNULL(TDTT_OTO.BienKiemSoatCu,TTKK_OTO.BienKiemSoat) TDTT_OTO_BienKiemSoatCu
			--,TTKK_OTO.LoaiXe			TTKK_OTO_LoaiXe			,TDTT_OTO.LoaiXeCu				TDTT_OTO_LoaiXeCu
			,CASE WHEN TDTT_OTO.LoaiXeCu IS NOT NULL THEN TTKK_OTO.LoaiXe ELSE TDTT_OTO.LoaiXeCu END TTKK_OTO_LoaiXe
			,ISNULL(TDTT_OTO.LoaiXeCu,TTKK_OTO.LoaiXe) TDTT_OTO_LoaiXeCu
			--,TTKK_OTO.TrongTai			TTKK_OTO_TrongTai			,TDTT_OTO.TrongTaiCu				TDTT_OTO_TrongTaiCu
			,CASE WHEN TDTT_OTO.TrongTaiCu IS NOT NULL THEN TTKK_OTO.TrongTai ELSE TDTT_OTO.TrongTaiCu END TTKK_OTO_TrongTai
			,ISNULL(TDTT_OTO.TrongTaiCu,TTKK_OTO.TrongTai) TDTT_OTO_TrongTaiCu

FROM		ThayDoiThongTin TDTT
			LEFT JOIN CoSo CS ON TDTT.CoSoId = CS.CoSoId
			LEFT JOIN CoSo CS_QL ON CS.TrucThuoc = CS_QL.CoSoId
			LEFT JOIN TaiSan TS ON TDTT.TaiSanId = TS.TaiSanId

			LEFT JOIN ThayDoiThongTin_Dat TDTT_DAT ON TDTT.ThayDoiThongTinId = TDTT_DAT.ThayDoiThongTinId
			LEFT JOIN ThongTinKeKhai_Dat TTKK_DAT ON TDTT.TaiSanId = TTKK_DAT.TaiSanId

			LEFT JOIN ThayDoiThongTin_Nha TDTT_NHA ON TDTT.ThayDoiThongTinId = TDTT_NHA.ThayDoiThongTinId
			LEFT JOIN ThongTinKeKhai_Nha TTKK_NHA ON TDTT.TaiSanId = TTKK_NHA.TaiSanId

			LEFT JOIN ThayDoiThongTin_Oto TDTT_OTO ON TDTT.ThayDoiThongTinId = TDTT_OTO.ThayDoiThongTinId
			LEFT JOIN ThongTinKeKhai_Oto TTKK_OTO ON TDTT.TaiSanId = TTKK_OTO.TaiSanId
WHERE		TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
--------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTin500_GetThayDoiThongTin500ById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTin500_GetThayDoiThongTin500ById]
						 @ThayDoiThongTinId		=	26

						,@CoSoId				=	1
						,@NhanVienId			=	6
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTin500_GetThayDoiThongTin500ById]
	 @ThayDoiThongTinId	INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON 
	SET @MESSAGE = ISNULL(@MESSAGE,'')
	SELECT	 TDTT_500.ThayDoiThongTinId
			,ISNULL(TDTT_500.KyHieuCu			, TTKK_500.KyHieu)			KyHieuCu
			,ISNULL(TDTT_500.HienTrangSuDungCu	, TTKK_500.HienTrangSuDung)	HienTrangSuDungCu
			,ISNULL(HTSD_OLD.NoiDung			, HTSD_NEW.NoiDung)			TenHienTrangSuDungCu
	FROM	ThayDoiThongTin_Tren500 TDTT_500
			LEFT JOIN ThayDoiThongTin TDTT ON TDTT_500.ThayDoiThongTinId = TDTT.ThayDoiThongTinId
			LEFT JOIN ThongTinKeKhai_Tren500 TTKK_500 ON TDTT.TaiSanId = TTKK_500.TaiSanId
			LEFT JOIN HienTrangSuDung HTSD_OLD ON TDTT_500.HienTrangSuDungCu = HTSD_OLD.HienTrangSuDungId
			LEFT JOIN HienTrangSuDung HTSD_NEW ON TTKK_500.HienTrangSuDung = HTSD_NEW.HienTrangSuDungId
	WHERE	TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTin500_InsertThayDoiThongTin500]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTin500_InsertThayDoiThongTin500]
						 @CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	NULL
						,@TaiSanId				=	NULL
						,@Ngay					=	NULL
						,@TenTaiSanCu			=	NULL
						,@LyDo					=	NULL
						,@DuyetId				=	NULL
						,@NguoiDuyet			=	NULL
						,@NguoiTao				=	NULL
						,@NgayTao				=	NULL
						,@CtrVersion			=	NULL

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	NULL

						-- THÔNG TIN KÊ KHAI MỚI
						,@KyHieu				=	NULL
						,@HienTrangSuDung		=	NULL

						-- THÔNG TIN KÊ KHAI CŨ
						,@KyHieuCu				=	NULL
						,@HienTrangSuDungCu		=	NULL

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTin500_InsertThayDoiThongTin500]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				INT				=	NULL
	,@Ngay					DATETIME		=	NULL
	,@TenTaiSanCu			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@DuyetId				INT				=	NULL
	,@NguoiDuyet			INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSanMoi			NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI MỚI
	,@KyHieu				NVARCHAR(MAX)	=	NULL
	,@HienTrangSuDung		INT				=	NULL

AS
BEGIN
SET NOCOUNT ON;
--------------------------------------------------
---------- BIẾN NỘI BỘ
	DECLARE	 @V_TRANS_NAME		NVARCHAR(500)	=	N'TDTT_INSERT'
			-- THAY ĐỔI THÔNG TIN KÊ KHAI
			,@KyHieuCu				NVARCHAR(MAX)	=	NULL
			,@HienTrangSuDungCu		INT				=	NULL
----------/ BIẾN NỘI BỘ

---------- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)
	SET @NguoiDuyet		=	@NhanVienId
	SET @NguoiTao		=	@NhanVienId
	SET @NgayTao		=	GETDATE()
	SET @CtrVersion		=	1
----------/ INPUT DEFAULT

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	-- LẤY THÔNG TIN KÊ KHAI CŨ
	SELECT		 @HienTrangSuDungCu	=	TTKK_500.HienTrangSuDung
				,@KyHieuCu			=	TTKK_500.KyHieu
	FROM		ThongTinKeKhai_Tren500 TTKK_500
	WHERE		TaiSanId = @TaiSanId

	SELECT @TenTaiSanCu = TenTaiSan FROM TaiSan WHERE TaiSanId = @TaiSanId

	-- SO SÁNH THÔNG TIN KÊ KHAI CŨ VÀ MỚI
	IF @TenTaiSanCu			= @TenTaiSanMoi			SET @TenTaiSanCu		= NULL
	IF @KyHieuCu			= @KyHieu				SET @KyHieuCu			= NULL
	IF @HienTrangSuDungCu	= @HienTrangSuDung		SET @HienTrangSuDungCu	= NULL

BEGIN TRANSACTION @V_TRANS_NAME
/*
	- Lưu bảng ThayDoiThongTin
		- Tên tài sản cũ là tên tài sản hiện tại
	- Update tên tài sản mới vào bảng TaiSan
	- Lấy thông tin từ bảng ThongTinKeKhai_Dat lưu vào bảng ThayDoiThongTin_Dat
	- Lưu thông tin kê khai mới vào bảng ThongTinKeKhai_Dat
*/
	-- INSERT THAY ĐỔI THÔNG TIN
	INSERT INTO ThayDoiThongTin	(	TaiSanId	,Ngay	,TenTaiSanCu	,LyDo	,DuyetId	,NguoiDuyet		,CoSoId		,NguoiTao	,NgayTao	,CtrVersion		)
	VALUES						(	@TaiSanId	,@Ngay	,@TenTaiSanCu	,@LyDo	,@DuyetId	,@NguoiDuyet	,@CoSoId	,@NguoiTao	,@NgayTao	,@CtrVersion	)

	SET @ThayDoiThongTinId = @@IDENTITY

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- INSERT THAY ĐỔI THÔNG TIN ĐẤT
	INSERT INTO ThayDoiThongTin_Tren500	(	ThayDoiThongTinId	,KyHieuCu	,HienTrangSuDungCu	)
	VALUES								(	@ThayDoiThongTinId	,@KyHieuCu	,@HienTrangSuDungCu	)

	-- UPDATE THÔNG TIN KE KHAI ĐẤT
	UPDATE		ThongTinKeKhai_Tren500
	SET			 KyHieu				=	@KyHieu
				,HienTrangSuDung	=	@HienTrangSuDung
	WHERE		TaiSanId = @TaiSanId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId
--------------------------------------------------
SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTin500_UpdateThayDoiThongTin500]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.15
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTin500_UpdateThayDoiThongTin500]
						 @CoSoId				=	1
						,@NhanVienId			=	7
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	75
						,@TaiSanId				=	1065
						,@Ngay					=	'2017-09-22'
						,@TenTaiSanCu			=	N'Bơm tiêm điện Terumo'
						,@LyDo					=	N'test'
						,@CtrVersion			=	1

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	N'Bơm tiêm điện Terumo'

						-- THÔNG TIN KÊ KHAI MỚI
						,@KyHieu				=	N'Skin LOL'
						,@HienTrangSuDung		=	4

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.15 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTin500_UpdateThayDoiThongTin500]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				int				=	NULL
	,@Ngay					datetime		=	NULL
	,@TenTaiSanCu			nvarchar(MAX)	=	NULL
	,@LyDo					nvarchar(MAX)	=	NULL
	,@DuyetId				int				=	NULL
	,@NguoiDuyet			int				=	NULL
	,@NguoiTao				int				=	NULL
	,@NgayTao				datetime		=	NULL
	,@CtrVersion			int				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSanMoi			NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI MỚI
	,@KyHieu				NVARCHAR(MAX)	=	NULL
	,@HienTrangSuDung		INT				=	NULL
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
---------- BIẾN NỘI BỘ
	DECLARE	@V_TRANS_NAME		NVARCHAR(MAX)	=	N'TDTT_500_UPDATE'
			-- THAY ĐỔI THÔNG TIN KÊ KHAI
			,@KyHieuCu				NVARCHAR(MAX)	=	NULL
			,@HienTrangSuDungCu		INT				=	NULL
----------/ BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	-- LẤY THÔNG TIN KÊ KHAI CŨ
	SELECT		 @TenTaiSanCu		=	ISNULL(TenTaiSanCu, TS.TenTaiSan)
				,@HienTrangSuDungCu	=	ISNULL(TDTT_500.HienTrangSuDungCu, TTKK_500.HienTrangSuDung)
				,@KyHieuCu			=	ISNULL(TDTT_500.KyHieuCu, TTKK_500.KyHieu)
	FROM		ThayDoiThongTin TDTT
				LEFT JOIN ThayDoiThongTin_Tren500 TDTT_500 ON TDTT.ThayDoiThongTinId = TDTT_500.ThayDoiThongTinId
				LEFT JOIN TaiSan TS ON TDTT.TaiSanId = TS.TaiSanId
				LEFT JOIN ThongTinKeKhai_Tren500 TTKK_500 ON TDTT.TaiSanId = TTKK_500.TaiSanId
	WHERE		TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
				
	-- SO SÁNH THÔNG TIN KÊ KHAI CŨ VÀ MỚI
	IF @TenTaiSanCu			= @TenTaiSanMoi			SET @TenTaiSanCu		= NULL
	IF @KyHieuCu			= @KyHieu				SET @KyHieuCu			= NULL
	IF @HienTrangSuDungCu	= @HienTrangSuDung		SET @HienTrangSuDungCu	= NULL

BEGIN TRANSACTION @V_TRANS_NAME
	-- UPDATE THAY ĐỔI THÔNG TIN
	UPDATE	 ThayDoiThongTin
	SET		 Ngay			=	@Ngay
			,TenTaiSanCu	=	@TenTaiSanCu
			,LyDo			=	@LyDo
			,CtrVersion		=	CtrVersion + 1
	WHERE ThayDoiThongTinId = @ThayDoiThongTinId

	UPDATE	 ThayDoiThongTin_Tren500
	SET		 HienTrangSuDungCu	=	@HienTrangSuDungCu
			,KyHieuCu			=	@KyHieuCu
	WHERE ThayDoiThongTinId = @ThayDoiThongTinId

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- UPDATE THÔNG TIN KÊ KHAI MỚI
	UPDATE		ThongTinKeKhai_Tren500
	SET			 KyHieu				=	@KyHieu
				,HienTrangSuDung	=	@HienTrangSuDung
	WHERE		TaiSanId = @TaiSanId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinDat_GetThayDoiThongTinDatById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinDat_GetThayDoiThongTinDatById]
						 @ThayDoiThongTinId		=	26

						,@CoSoId				=	1
						,@NhanVienId			=	6
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTinDat_GetThayDoiThongTinDatById]
	 @ThayDoiThongTinId	INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON 
	SET @MESSAGE = ISNULL(@MESSAGE,'')
	SELECT	TDTT_DAT.ThayDoiThongTinId
			,ISNULL(TDTT_DAT.BiLanChiemCu		, TTKK_DAT.BiLanChiem)		BiLanChiemCu
			,ISNULL(TDTT_DAT.BoTrongCu			, TTKK_DAT.BoTrong)			BoTrongCu
			,ISNULL(TDTT_DAT.ChoThueCu			, TTKK_DAT.ChoThue)			ChoThueCu
			,ISNULL(TDTT_DAT.CoSoHDSuNghiepCu	, TTKK_DAT.CoSoHDSuNghiep)	CoSoHDSuNghiepCu
			,ISNULL(TDTT_DAT.DiaChiCu			, TTKK_DAT.DiaChi)			DiaChiCu
			,ISNULL(TDTT_DAT.DienTichCu			, TTKK_DAT.DienTich)		DienTichCu
			,ISNULL(TDTT_DAT.GiayToCu			, TTKK_DAT.GiayTo)			GiayToCu
			,ISNULL(TDTT_DAT.LamTruSoCu			, TTKK_DAT.LamTruSo)		LamTruSoCu
			,ISNULL(TDTT_DAT.NhaOCu				, TTKK_DAT.NhaO)			NhaOCu
			,ISNULL(TDTT_DAT.SuDungKhacCu		, TTKK_DAT.SuDungKhac)		SuDungKhacCu
	FROM	ThayDoiThongTin_Dat TDTT_DAT
			LEFT JOIN ThayDoiThongTin TDTT ON TDTT_DAT.ThayDoiThongTinId = TDTT.ThayDoiThongTinId
			LEFT JOIN ThongTinKeKhai_Dat TTKK_DAT ON TDTT.TaiSanId = TTKK_DAT.TaiSanId
	WHERE	TDTT_DAT.ThayDoiThongTinId = @ThayDoiThongTinId
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinDat_InsertThayDoiThongTinDat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.12
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinDat_InsertThayDoiThongTinDat]
						 @CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	NULL
						,@TaiSanId				=	NULL
						,@Ngay					=	NULL
						,@TenTaiSanCu			=	NULL
						,@LyDo					=	NULL
						,@DuyetId				=	NULL
						,@NguoiDuyet			=	NULL
						,@NguoiTao				=	NULL
						,@NgayTao				=	NULL
						,@CtrVersion			=	NULL

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	NULL

						-- THÔNG TIN KÊ KHAI ĐẤT MỚI
						,@DiaChi				=	NULL
						,@GiayTo				=	NULL
						,@DienTich				=	NULL
						,@LamTruSo				=	NULL
						,@CoSoHDSuNghiep		=	NULL
						,@NhaO					=	NULL
						,@ChoThue				=	NULL
						,@BoTrong				=	NULL
						,@BiLanChiem			=	NULL
						,@SuDungKhac			=	NULL

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.12 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTinDat_InsertThayDoiThongTinDat]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				INT				=	NULL
	,@Ngay					DATETIME		=	NULL
	,@TenTaiSanCu			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@DuyetId				INT				=	NULL
	,@NguoiDuyet			INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSanMoi			NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI ĐẤT MỚI
	,@DiaChi				NVARCHAR(MAX)	=	NULL
	,@GiayTo				NVARCHAR(MAX)	=	NULL
	,@DienTich				NUMERIC(18,4)	=	NULL
	,@LamTruSo				NUMERIC(18,4)	=	NULL
	,@CoSoHDSuNghiep		NUMERIC(18,4)	=	NULL
	,@NhaO					NUMERIC(18,4)	=	NULL
	,@ChoThue				NUMERIC(18,4)	=	NULL
	,@BoTrong				NUMERIC(18,4)	=	NULL
	,@BiLanChiem			NUMERIC(18,4)	=	NULL
	,@SuDungKhac			NUMERIC(18,4)	=	NULL
AS
BEGIN
	SET NOCOUNT ON;
---------- BIẾN NỘI BỘ
	DECLARE	@V_TRANS_NAME		NVARCHAR(500)	=	N'TDTT_DAT_INSERT'
	
		-- THAY ĐỔI THÔNG TIN ĐẤT
		,@DiaChiCu			NVARCHAR(MAX)		=	NULL
		,@GiayToCu			NVARCHAR(MAX)		=	NULL
		,@DienTichCu		NUMERIC(18, 4)		=	NULL
		,@LamTruSoCu		NUMERIC(18, 4)		=	NULL
		,@CoSoHDSuNghiepCu	NUMERIC(18, 4)		=	NULL
		,@NhaOCu			NUMERIC(18, 4)		=	NULL
		,@ChoThueCu			NUMERIC(18, 4)		=	NULL
		,@BoTrongCu			NUMERIC(18, 4)		=	NULL
		,@BiLanChiemCu		NUMERIC(18, 4)		=	NULL
		,@SuDungKhacCu		NUMERIC(18, 4)		=	NULL
----------/ BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)
	SET @NguoiDuyet		=	@NhanVienId
	SET @NguoiTao		=	@NhanVienId
	SET @NgayTao		=	GETDATE()
	SET @CtrVersion		=	1

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	-- LẤY THÔNG TIN KÊ KHAI CŨ
	SELECT		 @DiaChiCu			=	DiaChi	
				,@GiayToCu			=	GiayTo	
				,@DienTichCu		=	DienTich	
				,@LamTruSoCu		=	LamTruSo
				,@CoSoHDSuNghiepCu	=	CoSoHDSuNghiep
				,@NhaOCu			=	NhaO
				,@ChoThueCu			=	ChoThue
				,@BoTrongCu			=	BoTrong
				,@BiLanChiemCu		=	BiLanChiem
				,@SuDungKhacCu		=	SuDungKhac
	FROM		ThongTinKeKhai_Dat TTKK_DAT
	WHERE		TaiSanId = @TaiSanId

	SELECT @TenTaiSanCu = TenTaiSan FROM TaiSan WHERE TaiSanId = @TaiSanId

	IF @TenTaiSanCu			= @TenTaiSanMoi			SET @TenTaiSanCu		= NULL
	IF @DiaChiCu			= @DiaChi				SET @DiaChiCu			= NULL
	IF @GiayToCu			= @GiayTo				SET @GiayToCu			= NULL
	IF @DienTichCu			= @DienTich				SET @DienTichCu			= NULL
	IF @LamTruSoCu			= @LamTruSo				SET @LamTruSoCu			= NULL
	IF @CoSoHDSuNghiepCu	= @CoSoHDSuNghiep		SET @CoSoHDSuNghiepCu	= NULL
	IF @NhaOCu				= @NhaO					SET @NhaOCu				= NULL
	IF @ChoThueCu			= @ChoThue				SET @ChoThueCu			= NULL
	IF @BoTrongCu			= @BoTrong				SET @BoTrongCu			= NULL
	IF @BiLanChiemCu		= @BiLanChiem			SET @BiLanChiemCu		= NULL
	IF @SuDungKhacCu		= @SuDungKhac			SET @SuDungKhacCu		= NULL

BEGIN TRANSACTION @V_TRANS_NAME
/*
	- Lưu bảng ThayDoiThongTin
		- Tên tài sản cũ là tên tài sản hiện tại
	- Update tên tài sản mới vào bảng TaiSan
	- Lấy thông tin từ bảng ThongTinKeKhai_Dat lưu vào bảng ThayDoiThongTin_Dat
	- Lưu thông tin kê khai mới vào bảng ThongTinKeKhai_Dat
*/
	-- INSERT THAY ĐỔI THÔNG TIN
	INSERT INTO ThayDoiThongTin	(	TaiSanId	,Ngay	,TenTaiSanCu	,LyDo	,DuyetId	,NguoiDuyet		,CoSoId		,NguoiTao	,NgayTao	,CtrVersion		)
	VALUES						(	@TaiSanId	,@Ngay	,@TenTaiSanCu	,@LyDo	,@DuyetId	,@NguoiDuyet	,@CoSoId	,@NguoiTao	,@NgayTao	,@CtrVersion	)

	SET @ThayDoiThongTinId = @@IDENTITY

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- INSERT THAY ĐỔI THÔNG TIN ĐẤT
	INSERT INTO ThayDoiThongTin_Dat	(	ThayDoiThongTinId	,DiaChiCu	,GiayToCu	,DienTichCu		,LamTruSoCu		,CoSoHDSuNghiepCu	,NhaOCu		,ChoThueCu	,BoTrongCu	,BiLanChiemCu	,SuDungKhacCu	)
	VALUES							(	@ThayDoiThongTinId	,@DiaChiCu	,@GiayToCu	,@DienTichCu	,@LamTruSoCu	,@CoSoHDSuNghiepCu	,@NhaOCu	,@ChoThueCu	,@BoTrongCu	,@BiLanChiemCu	,@SuDungKhacCu	)

	-- UPDATE THÔNG TIN KE KHAI ĐẤT
	UPDATE		ThongTinKeKhai_Dat
	SET			 DiaChi			=	@DiaChi
				,GiayTo			=	@GiayTo
				,DienTich		=	@DienTich
				,LamTruSo		=	@LamTruSo
				,CoSoHDSuNghiep	=	@CoSoHDSuNghiep
				,NhaO			=	@NhaO
				,ChoThue		=	@ChoThue
				,BoTrong		=	@BoTrong
				,BiLanChiem		=	@BiLanChiem
				,SuDungKhac		=	@SuDungKhac
	WHERE		TaiSanId = @TaiSanId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinDat_InsertThayDoiThongTinDat_170921]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.12
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinDat_InsertThayDoiThongTinDat]
						 @CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	NULL
						,@TaiSanId				=	NULL
						,@Ngay					=	NULL
						,@TenTaiSanCu			=	NULL
						,@LyDo					=	NULL
						,@DuyetId				=	NULL
						,@NguoiDuyet			=	NULL
						,@NguoiTao				=	NULL
						,@NgayTao				=	NULL
						,@CtrVersion			=	NULL

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	NULL

						-- THÔNG TIN KÊ KHAI ĐẤT MỚI
						,@DiaChi				=	NULL
						,@GiayTo				=	NULL
						,@DienTich				=	NULL
						,@LamTruSo				=	NULL
						,@CoSoHDSuNghiep		=	NULL
						,@NhaO					=	NULL
						,@ChoThue				=	NULL
						,@BoTrong				=	NULL
						,@BiLanChiem			=	NULL
						,@SuDungKhac			=	NULL

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.12 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTinDat_InsertThayDoiThongTinDat_170921]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				INT				=	NULL
	,@Ngay					DATETIME		=	NULL
	,@TenTaiSanCu			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@DuyetId				INT				=	NULL
	,@NguoiDuyet			INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSanMoi			NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI ĐẤT MỚI
	,@DiaChi				NVARCHAR(MAX)	=	NULL
	,@GiayTo				NVARCHAR(MAX)	=	NULL
	,@DienTich				NUMERIC(18,4)	=	NULL
	,@LamTruSo				NUMERIC(18,4)	=	NULL
	,@CoSoHDSuNghiep		NUMERIC(18,4)	=	NULL
	,@NhaO					NUMERIC(18,4)	=	NULL
	,@ChoThue				NUMERIC(18,4)	=	NULL
	,@BoTrong				NUMERIC(18,4)	=	NULL
	,@BiLanChiem			NUMERIC(18,4)	=	NULL
	,@SuDungKhac			NUMERIC(18,4)	=	NULL

AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ
	DECLARE	@V_TRANS_NAME		NVARCHAR(500)	=	N'TDTT_DAT_INSERT'
	
	-- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)
	SET @NguoiDuyet		=	@NhanVienId
	SET @NguoiTao		=	@NhanVienId
	SET @NgayTao		=	GETDATE()
	SET @CtrVersion		=	1

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	SET @TenTaiSanCu = (SELECT TenTaiSan FROM TaiSan WHERE TaiSanId = @TaiSanId)

BEGIN TRANSACTION @V_TRANS_NAME
/*
	- Lưu bảng ThayDoiThongTin
		- Tên tài sản cũ là tên tài sản hiện tại
	- Update tên tài sản mới vào bảng TaiSan
	- Lấy thông tin từ bảng ThongTinKeKhai_Dat lưu vào bảng ThayDoiThongTin_Dat
	- Lưu thông tin kê khai mới vào bảng ThongTinKeKhai_Dat
*/
	-- INSERT THAY ĐỔI THÔNG TIN
	INSERT INTO ThayDoiThongTin	(	TaiSanId	,Ngay	,TenTaiSanCu	,LyDo	,DuyetId	,NguoiDuyet		,CoSoId		,NguoiTao	,NgayTao	,CtrVersion		)
	VALUES						(	@TaiSanId	,@Ngay	,@TenTaiSanCu	,@LyDo	,@DuyetId	,@NguoiDuyet	,@CoSoId	,@NguoiTao	,@NgayTao	,@CtrVersion	)

	SET @ThayDoiThongTinId = @@IDENTITY

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- INSERT THAY ĐỔI THÔNG TIN ĐẤT
	INSERT INTO ThayDoiThongTin_Dat	(	ThayDoiThongTinId	,DiaChiCu	,GiayToCu	,DienTichCu	,LamTruSoCu	,CoSoHDSuNghiepCu	,NhaOCu	,ChoThueCu	,BoTrongCu	,BiLanChiemCu	,SuDungKhacCu)
	SELECT								@ThayDoiThongTinId	,DiaChi		,GiayTo		,DienTich	,LamTruSo	,CoSoHDSuNghiep		,NhaO	,ChoThue	,BoTrong	,BiLanChiem		,SuDungKhac
	FROM		ThongTinKeKhai_Dat
	WHERE		TaiSanId = @TaiSanId

	-- UPDATE THÔNG TIN KE KHAI ĐẤT
	UPDATE		ThongTinKeKhai_Dat
	SET			 DiaChi			=	@DiaChi
				,GiayTo			=	@GiayTo
				,DienTich		=	@DienTich
				,LamTruSo		=	@LamTruSo
				,CoSoHDSuNghiep	=	@CoSoHDSuNghiep
				,NhaO			=	@NhaO
				,ChoThue		=	@ChoThue
				,BoTrong		=	@BoTrong
				,BiLanChiem		=	@BiLanChiem
				,SuDungKhac		=	@SuDungKhac
	WHERE		TaiSanId = @TaiSanId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinDat_UpdateThayDoiThongTinDat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.15
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinDat_UpdateThayDoiThongTinDat]
						 @CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	NULL
						,@TaiSanId				=	NULL
						,@Ngay					=	NULL
						,@TenTaiSanCu			=	NULL
						,@LyDo					=	NULL
						,@DuyetId				=	NULL
						,@NguoiDuyet			=	NULL
						,@NguoiTao				=	NULL
						,@NgayTao				=	NULL
						,@CtrVersion			=	NULL

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	NULL

						-- THÔNG TIN KÊ KHAI ĐẤT MỚI
						,@DiaChi				=	NULL
						,@GiayTo				=	NULL
						,@DienTich				=	NULL
						,@LamTruSo				=	NULL
						,@CoSoHDSuNghiep		=	NULL
						,@NhaO					=	NULL
						,@ChoThue				=	NULL
						,@BoTrong				=	NULL
						,@BiLanChiem			=	NULL
						,@SuDungKhac			=	NULL

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.15 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTinDat_UpdateThayDoiThongTinDat]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				INT				=	NULL
	,@Ngay					DATETIME		=	NULL
	,@TenTaiSanCu			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@DuyetId				INT				=	NULL
	,@NguoiDuyet			INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSanMoi			NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI ĐẤT MỚI
	,@DiaChi				NVARCHAR(MAX)	=	NULL
	,@GiayTo				NVARCHAR(MAX)	=	NULL
	,@DienTich				NUMERIC(18,4)	=	NULL
	,@LamTruSo				NUMERIC(18,4)	=	NULL
	,@CoSoHDSuNghiep		NUMERIC(18,4)	=	NULL
	,@NhaO					NUMERIC(18,4)	=	NULL
	,@ChoThue				NUMERIC(18,4)	=	NULL
	,@BoTrong				NUMERIC(18,4)	=	NULL
	,@BiLanChiem			NUMERIC(18,4)	=	NULL
	,@SuDungKhac			NUMERIC(18,4)	=	NULL
AS
BEGIN
	SET NOCOUNT ON;
	-- BIẾN NỘI BỘ
	DECLARE	@V_TRANS_NAME		NVARCHAR(500)	=	N'TDTT_DAT_UPDATE'
	-- THAY ĐỔI THONG TIN ĐẤT
	,@DiaChiCu			NVARCHAR(MAX)		=	NULL
	,@GiayToCu			NVARCHAR(MAX)		=	NULL
	,@DienTichCu		NUMERIC(18, 4)		=	NULL
	,@LamTruSoCu		NUMERIC(18, 4)		=	NULL
	,@CoSoHDSuNghiepCu	NUMERIC(18, 4)		=	NULL
	,@NhaOCu			NUMERIC(18, 4)		=	NULL
	,@ChoThueCu			NUMERIC(18, 4)		=	NULL
	,@BoTrongCu			NUMERIC(18, 4)		=	NULL
	,@BiLanChiemCu		NUMERIC(18, 4)		=	NULL
	,@SuDungKhacCu		NUMERIC(18, 4)		=	NULL

	-- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	-- KIỂM TRA @TaiSanId
	IF @ThayDoiThongTinId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin';
		THROW 51000, @MESSAGE, 1;
	END

	-- LẤY THÔNG TIN KÊ KHAI CŨ
	SELECT		 @TenTaiSanCu		=	ISNULL(TenTaiSanCu, TS.TenTaiSan)
				,@BiLanChiemCu		=	ISNULL(TDTT_Dat.BiLanChiemCu, TTKK_Dat.BiLanChiem)
				,@BoTrongCu			=	ISNULL(TDTT_Dat.BoTrongCu, TTKK_Dat.BoTrong)
				,@ChoThueCu			=	ISNULL(TDTT_Dat.ChoThueCu, TTKK_Dat.ChoThue)
				,@CoSoHDSuNghiepCu	=	ISNULL(TDTT_Dat.CoSoHDSuNghiepCu, TTKK_Dat.CoSoHDSuNghiep)
				,@DiaChiCu			=	ISNULL(TDTT_Dat.DiaChiCu, TTKK_Dat.DiaChi)
				,@DienTichCu		=	ISNULL(TDTT_Dat.DienTichCu, TTKK_Dat.DienTich)
				,@GiayToCu			=	ISNULL(TDTT_Dat.GiayToCu, TTKK_Dat.GiayTo)
				,@LamTruSoCu		=	ISNULL(TDTT_Dat.LamTruSoCu, TTKK_Dat.LamTruSo)
				,@NhaOCu			=	ISNULL(TDTT_Dat.NhaOCu, TTKK_Dat.NhaO)
				,@SuDungKhacCu		=	ISNULL(TDTT_Dat.SuDungKhacCu, TTKK_Dat.SuDungKhac)
	FROM		ThayDoiThongTin TDTT
				LEFT JOIN ThayDoiThongTin_Dat TDTT_Dat ON TDTT.ThayDoiThongTinId = TDTT_Dat.ThayDoiThongTinId
				LEFT JOIN TaiSan TS ON TDTT.TaiSanId = TS.TaiSanId
				LEFT JOIN ThongTinKeKhai_Dat TTKK_Dat ON TDTT.TaiSanId = TTKK_Dat.TaiSanId
	WHERE		TDTT.ThayDoiThongTinId = @ThayDoiThongTinId

	IF @TenTaiSanCu			= @TenTaiSanMoi			SET @TenTaiSanCu		= NULL
	IF @DiaChiCu			= @DiaChi				SET @DiaChiCu			= NULL
	IF @GiayToCu			= @GiayTo				SET @GiayToCu			= NULL
	IF @DienTichCu			= @DienTich				SET @DienTichCu			= NULL
	IF @LamTruSoCu			= @LamTruSo				SET @LamTruSoCu			= NULL
	IF @CoSoHDSuNghiepCu	= @CoSoHDSuNghiep		SET @CoSoHDSuNghiepCu	= NULL
	IF @NhaOCu				= @NhaO					SET @NhaOCu				= NULL
	IF @ChoThueCu			= @ChoThue				SET @ChoThueCu			= NULL
	IF @BoTrongCu			= @BoTrong				SET @BoTrongCu			= NULL
	IF @BiLanChiemCu		= @BiLanChiem			SET @BiLanChiemCu		= NULL
	IF @SuDungKhacCu		= @SuDungKhac			SET @SuDungKhacCu		= NULL

BEGIN TRANSACTION @V_TRANS_NAME
	-- UPDATE THAY ĐỔI THÔNG TIN
	UPDATE	 ThayDoiThongTin	
	SET		 TaiSanId		=	@TaiSanId
			,TenTaiSanCu	=	@TenTaiSanCu
			,Ngay			=	@Ngay
			,LyDo			=	@LyDo
			,CtrVersion		=	CtrVersion + 1
	WHERE ThayDoiThongTinId = @ThayDoiThongTinId

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- UPDATE THAY ĐỔI THÔNG TIN ĐẤT
	UPDATE	ThayDoiThongTin_Dat
	SET		 DiaChiCu			= @DiaChiCu
			,GiayToCu			= @GiayToCu
			,DienTichCu			= @DienTichCu
			,LamTruSoCu			= @LamTruSoCu
			,CoSoHDSuNghiepCu	= @CoSoHDSuNghiepCu
			,NhaOCu				= @NhaOCu
			,ChoThueCu			= @ChoThueCu
			,BoTrongCu			= @BoTrongCu
			,BiLanChiemCu		= @BiLanChiemCu
			,SuDungKhacCu		= @SuDungKhacCu
	WHERE ThayDoiThongTinId = @ThayDoiThongTinId

	-- UPDATE THÔNG TIN KE KHAI ĐẤT
	UPDATE		ThongTinKeKhai_Dat
	SET			 DiaChi			=	@DiaChi
				,GiayTo			=	@GiayTo
				,DienTich		=	@DienTich
				,LamTruSo		=	@LamTruSo
				,CoSoHDSuNghiep	=	@CoSoHDSuNghiep
				,NhaO			=	@NhaO
				,ChoThue		=	@ChoThue
				,BoTrong		=	@BoTrong
				,BiLanChiem		=	@BiLanChiem
				,SuDungKhac		=	@SuDungKhac
	WHERE		TaiSanId = @TaiSanId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinNha_GetThayDoiThongTinNhaById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinNha_GetThayDoiThongTinNhaById]
						 @ThayDoiThongTinId		=	26

						,@CoSoId				=	1
						,@NhanVienId			=	6
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTinNha_GetThayDoiThongTinNhaById]
	 @ThayDoiThongTinId	INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON 
	SET @MESSAGE = ISNULL(@MESSAGE,'')
	SELECT	 TDTT_NHA.ThayDoiThongTinId
			,ISNULL(TDTT_NHA.BiLanChiemCu		, TTKK_NHA.BiLanChiem) BiLanChiemCu
			,ISNULL(TDTT_NHA.BoTrongCu			, TTKK_NHA.BoTrong) BoTrongCu
			,ISNULL(TDTT_NHA.CapHangCu			, TTKK_NHA.CapHang) CapHangCu
			,ISNULL(TDTT_NHA.ChoThueCu			, TTKK_NHA.ChoThue) ChoThueCu
			,ISNULL(TDTT_NHA.CoSoHDSuNghiepCu	, TTKK_NHA.CoSoHDSuNghiep) CoSoHDSuNghiepCu
			,ISNULL(TDTT_NHA.DiaChiCu			, TTKK_NHA.DiaChi) DiaChiCu
			,ISNULL(TDTT_NHA.DienTichCu			, TTKK_NHA.DienTich) DienTichCu
			,ISNULL(TDTT_NHA.GiayToCu			, TTKK_NHA.GiayTo) GiayToCu
			,ISNULL(TDTT_NHA.LamTruSoCu			, TTKK_NHA.LamTruSo) LamTruSoCu
			,ISNULL(TDTT_NHA.NamSuDungCu		, TTKK_NHA.NamSuDung) NamSuDungCu
			,ISNULL(TDTT_NHA.NhaOCu				, TTKK_NHA.NhaO) NhaOCu
			,ISNULL(TDTT_NHA.SoTangCu			, TTKK_NHA.SoTang) SoTangCu
			,ISNULL(TDTT_NHA.SuDungKhacCu		, TTKK_NHA.SuDungKhac) SuDungKhacCu
			,ISNULL(TDTT_NHA.TongDienTichSanCu	, TTKK_NHA.TongDienTichSan) TongDienTichSanCu
	FROM	ThayDoiThongTin_Nha TDTT_NHA
			LEFT JOIN ThayDoiThongTin TDTT ON TDTT_NHA.ThayDoiThongTinId = TDTT.ThayDoiThongTinId
			LEFT JOIN ThongTinKeKhai_Nha TTKK_NHA ON TDTT.TaiSanId = TTKK_NHA.TaiSanId
	WHERE	TDTT_NHA.ThayDoiThongTinId = @ThayDoiThongTinId
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinNha_GetThayDoiThongTinNhaById_170921]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinNha_GetThayDoiThongTinNhaById]
						 @ThayDoiThongTinId		=	26

						,@CoSoId				=	1
						,@NhanVienId			=	6
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
create PROCEDURE [dbo].[sp_ThayDoiThongTinNha_GetThayDoiThongTinNhaById_170921]
	 @ThayDoiThongTinId	INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON 
	SET @MESSAGE = ISNULL(@MESSAGE,'')
	SELECT	*
	FROM	ThayDoiThongTin_Nha
	WHERE	ThayDoiThongTinId = @ThayDoiThongTinId
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinNha_InsertThayDoiThongTinNha]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinNha_InsertThayDoiThongTinNha]
						 @CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	NULL
						,@TaiSanId				=	NULL
						,@Ngay					=	NULL
						,@TenTaiSanCu			=	NULL
						,@LyDo					=	NULL
						,@DuyetId				=	NULL
						,@NguoiDuyet			=	NULL
						,@NguoiTao				=	NULL
						,@NgayTao				=	NULL
						,@CtrVersion			=	NULL

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	NULL

						-- THÔNG TIN KÊ KHAI MỚI
						,@DiaChi				=	NULL
						,@GiayTo				=	NULL
						,@CapHang				=	NULL
						,@SoTang				=	NULL
						,@NamSuDung				=	NULL
						,@DienTich				=	NULL
						,@TongDienTichSan		=	NULL
						,@LamTruSo				=	NULL
						,@CoSoHDSuNghiep		=	NULL
						,@NhaO					=	NULL
						,@ChoThue				=	NULL
						,@BoTrong				=	NULL
						,@BiLanChiem			=	NULL
						,@SuDungKhac			=	NULL

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTinNha_InsertThayDoiThongTinNha]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				INT				=	NULL
	,@Ngay					DATETIME		=	NULL
	,@TenTaiSanCu			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@DuyetId				INT				=	NULL
	,@NguoiDuyet			INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSan				NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI NHÀ MỚI
	,@DiaChi				NVARCHAR(MAX)	=	NULL
	,@GiayTo				NVARCHAR(MAX)	=	NULL
	,@CapHang				INT				=	NULL
	,@SoTang				INT				=	NULL
	,@NamSuDung				NUMERIC(18,4)	=	NULL
	,@DienTich				NUMERIC(18,4)	=	NULL
	,@TongDienTichSan		NUMERIC(18,4)	=	NULL
	,@LamTruSo				NUMERIC(18,4)	=	NULL
	,@CoSoHDSuNghiep		NUMERIC(18,4)	=	NULL
	,@NhaO					NUMERIC(18,4)	=	NULL
	,@ChoThue				NUMERIC(18,4)	=	NULL
	,@BoTrong				NUMERIC(18,4)	=	NULL
	,@BiLanChiem			NUMERIC(18,4)	=	NULL
	,@SuDungKhac			NUMERIC(18,4)	=	NULL
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
---------- BIẾN NỘI BỘ
	DECLARE	@V_TRANS_NAME		NVARCHAR(500)	=	N'TDTT_NHA_INSERT'
	
			-- THAY ĐỔI THÔNG TIN NHÀ
			,@DiaChiCu				NVARCHAR(MAX)	=	NULL
			,@GiayToCu				NVARCHAR(MAX)	=	NULL
			,@CapHangCu				INT				=	NULL
			,@SoTangCu				INT				=	NULL
			,@NamSuDungCu			NUMERIC(18,4)	=	NULL
			,@DienTichCu			NUMERIC(18,4)	=	NULL
			,@TongDienTichSanCu		NUMERIC(18,4)	=	NULL
			,@LamTruSoCu			NUMERIC(18,4)	=	NULL
			,@CoSoHDSuNghiepCu		NUMERIC(18,4)	=	NULL
			,@NhaOCu				NUMERIC(18,4)	=	NULL
			,@ChoThueCu				NUMERIC(18,4)	=	NULL
			,@BoTrongCu				NUMERIC(18,4)	=	NULL
			,@BiLanChiemCu			NUMERIC(18,4)	=	NULL
			,@SuDungKhacCu			NUMERIC(18,4)	=	NULL
----------/ BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)
	SET @NguoiDuyet		=	@NhanVienId
	SET @NguoiTao		=	@NhanVienId
	SET @NgayTao		=	GETDATE()
	SET @CtrVersion		=	1

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	-- LẤY THÔNG TIN KÊ KHAI CŨ
	SELECT		 @DiaChiCu			=	DiaChi
				,@GiayToCu			=	GiayTo
				,@CapHangCu			=	CapHang
				,@SoTangCu			=	SoTang
				,@NamSuDungCu		=	NamSuDung
				,@DienTichCu		=	DienTich
				,@TongDienTichSanCu	=	TongDienTichSan	
				,@LamTruSoCu		=	LamTruSo
				,@CoSoHDSuNghiepCu	=	CoSoHDSuNghiep
				,@NhaOCu			=	NhaO
				,@ChoThueCu			=	ChoThue
				,@BoTrongCu			=	BoTrong
				,@BiLanChiemCu		=	BiLanChiem
				,@SuDungKhacCu		=	SuDungKhac
	FROM		ThongTinKeKhai_Nha
	WHERE		TaiSanId = @TaiSanId

	SELECT @TenTaiSanCu = TenTaiSan FROM TaiSan WHERE TaiSanId = @TaiSanId

	-- SET THÔNG TIN BỊ THAY ĐỔI
	IF @TenTaiSanCu			= @TenTaiSan			SET @TenTaiSanCu		= NULL
	IF @DiaChiCu			= @DiaChi				SET @DiaChiCu			= NULL
	IF @GiayToCu			= @GiayTo				SET @GiayToCu			= NULL
	IF @CapHangCu			= @CapHang				SET @CapHangCu			= NULL
	IF @SoTangCu			= @SoTang				SET @SoTangCu			= NULL
	IF @NamSuDungCu			= @NamSuDung			SET @NamSuDungCu		= NULL
	IF @DienTichCu			= @DienTich				SET @DienTichCu			= NULL
	IF @TongDienTichSanCu	= @TongDienTichSan		SET @TongDienTichSanCu	= NULL
	IF @LamTruSoCu			= @LamTruSo				SET @LamTruSoCu			= NULL
	IF @CoSoHDSuNghiepCu	= @CoSoHDSuNghiep		SET @CoSoHDSuNghiepCu	= NULL
	IF @NhaOCu				= @NhaO					SET @NhaOCu				= NULL
	IF @ChoThueCu			= @ChoThue				SET @ChoThueCu			= NULL
	IF @BoTrongCu			= @BoTrong				SET @BoTrongCu			= NULL
	IF @BiLanChiemCu		= @BiLanChiem			SET @BiLanChiemCu		= NULL
	IF @SuDungKhacCu		= @SuDungKhac			SET @SuDungKhacCu		= NULL

BEGIN TRANSACTION @V_TRANS_NAME
/*
	- Lưu bảng ThayDoiThongTin
		- Tên tài sản cũ là tên tài sản hiện tại
	- Update tên tài sản mới vào bảng TaiSan
	- Lấy thông tin từ bảng ThongTinKeKhai_Dat lưu vào bảng ThayDoiThongTin_Dat
	- Lưu thông tin kê khai mới vào bảng ThongTinKeKhai_Dat
*/
	-- INSERT THAY ĐỔI THÔNG TIN
	INSERT INTO ThayDoiThongTin	(	TaiSanId	,Ngay	,TenTaiSanCu	,LyDo	,DuyetId	,NguoiDuyet		,CoSoId		,NguoiTao	,NgayTao	,CtrVersion		)
	VALUES						(	@TaiSanId	,@Ngay	,@TenTaiSanCu	,@LyDo	,@DuyetId	,@NguoiDuyet	,@CoSoId	,@NguoiTao	,@NgayTao	,@CtrVersion	)

	SET @ThayDoiThongTinId = @@IDENTITY

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSan
	WHERE	TaiSanId = @TaiSanId

	-- INSERT THAY ĐỔI THÔNG TIN NHÀ
	INSERT INTO ThayDoiThongTin_Nha	(	ThayDoiThongTinId	,DiaChiCu	,GiayToCu	,CapHangCu	,SoTangCu	,NamSuDungCu	,DienTichCu		,TongDienTichSanCu	,LamTruSoCu		,CoSoHDSuNghiepCu	,NhaOCu		,ChoThueCu	,BoTrongCu	,BiLanChiemCu	,SuDungKhacCu	)
	VALUES							(	@ThayDoiThongTinId	,@DiaChiCu	,@GiayToCu	,@CapHangCu	,@SoTangCu	,@NamSuDungCu	,@DienTichCu	,@TongDienTichSanCu	,@LamTruSoCu	,@CoSoHDSuNghiepCu	,@NhaOCu	,@ChoThueCu	,@BoTrongCu	,@BiLanChiemCu	,@SuDungKhacCu	)

	-- UPDATE THÔNG TIN KÊ KHAI NHÀ
	UPDATE		ThongTinKeKhai_Nha
	SET			 DiaChi				=	@DiaChi
				,GiayTo				=	@GiayTo
				,CapHang			=	@CapHang
				,SoTang				=	@SoTang
				,NamSuDung			=	@NamSuDung
				,DienTich			=	@DienTich
				,TongDienTichSan	=	@TongDienTichSan
				,LamTruSo			=	@LamTruSo
				,CoSoHDSuNghiep		=	@CoSoHDSuNghiep
				,NhaO				=	@NhaO
				,ChoThue			=	@ChoThue
				,BoTrong			=	@BoTrong
				,BiLanChiem			=	@BiLanChiem
				,SuDungKhac			=	@SuDungKhac
	WHERE		TaiSanId = @TaiSanId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinNha_InsertThayDoiThongTinNha_170921]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinNha_InsertThayDoiThongTinNha]
						 @CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	NULL
						,@TaiSanId				=	NULL
						,@Ngay					=	NULL
						,@TenTaiSanCu			=	NULL
						,@LyDo					=	NULL
						,@DuyetId				=	NULL
						,@NguoiDuyet			=	NULL
						,@NguoiTao				=	NULL
						,@NgayTao				=	NULL
						,@CtrVersion			=	NULL

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	NULL

						-- THÔNG TIN KÊ KHAI MỚI
						,@DiaChi				=	NULL
						,@GiayTo				=	NULL
						,@CapHang				=	NULL
						,@SoTang				=	NULL
						,@NamSuDung				=	NULL
						,@DienTich				=	NULL
						,@TongDienTichSan		=	NULL
						,@LamTruSo				=	NULL
						,@CoSoHDSuNghiep		=	NULL
						,@NhaO					=	NULL
						,@ChoThue				=	NULL
						,@BoTrong				=	NULL
						,@BiLanChiem			=	NULL
						,@SuDungKhac			=	NULL

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
create PROCEDURE [dbo].[sp_ThayDoiThongTinNha_InsertThayDoiThongTinNha_170921]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				INT				=	NULL
	,@Ngay					DATETIME		=	NULL
	,@TenTaiSanCu			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@DuyetId				INT				=	NULL
	,@NguoiDuyet			INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSanMoi			NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI NHÀ MỚI
	,@DiaChi				NVARCHAR(MAX)	=	NULL
	,@GiayTo				NVARCHAR(MAX)	=	NULL
	,@CapHang				INT				=	NULL
	,@SoTang				INT				=	NULL
	,@NamSuDung				NUMERIC(18,4)	=	NULL
	,@DienTich				NUMERIC(18,4)	=	NULL
	,@TongDienTichSan		NUMERIC(18,4)	=	NULL
	,@LamTruSo				NUMERIC(18,4)	=	NULL
	,@CoSoHDSuNghiep		NUMERIC(18,4)	=	NULL
	,@NhaO					NUMERIC(18,4)	=	NULL
	,@ChoThue				NUMERIC(18,4)	=	NULL
	,@BoTrong				NUMERIC(18,4)	=	NULL
	,@BiLanChiem			NUMERIC(18,4)	=	NULL
	,@SuDungKhac			NUMERIC(18,4)	=	NULL

AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ
	DECLARE	@V_TRANS_NAME		NVARCHAR(500)	=	N'TDTT_INSERT'
	
	-- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)
	SET @NguoiDuyet		=	@NhanVienId
	SET @NguoiTao		=	@NhanVienId
	SET @NgayTao		=	GETDATE()
	SET @CtrVersion		=	1

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	SET @TenTaiSanCu = (SELECT TenTaiSan FROM TaiSan WHERE TaiSanId = @TaiSanId)

BEGIN TRANSACTION @V_TRANS_NAME
/*
	- Lưu bảng ThayDoiThongTin
		- Tên tài sản cũ là tên tài sản hiện tại
	- Update tên tài sản mới vào bảng TaiSan
	- Lấy thông tin từ bảng ThongTinKeKhai_Dat lưu vào bảng ThayDoiThongTin_Dat
	- Lưu thông tin kê khai mới vào bảng ThongTinKeKhai_Dat
*/
	-- INSERT THAY ĐỔI THÔNG TIN
	INSERT INTO ThayDoiThongTin	(	TaiSanId	,Ngay	,TenTaiSanCu	,LyDo	,DuyetId	,NguoiDuyet		,CoSoId		,NguoiTao	,NgayTao	,CtrVersion		)
	VALUES						(	@TaiSanId	,@Ngay	,@TenTaiSanCu	,@LyDo	,@DuyetId	,@NguoiDuyet	,@CoSoId	,@NguoiTao	,@NgayTao	,@CtrVersion	)

	SET @ThayDoiThongTinId = @@IDENTITY

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- INSERT THAY ĐỔI THÔNG TIN ĐẤT
	INSERT INTO ThayDoiThongTin_Nha	(	ThayDoiThongTinId	,DiaChiCu	,GiayToCu	,CapHangCu	,SoTangCu	,NamSuDungCu	,DienTichCu	,TongDienTichSanCu	,LamTruSoCu	,CoSoHDSuNghiepCu	,NhaOCu	,ChoThueCu	,BoTrongCu	,BiLanChiemCu	,SuDungKhacCu)
	SELECT								@ThayDoiThongTinId	,DiaChi		,GiayTo		,CapHang	,SoTang		,NamSuDung		,DienTich	,TongDienTichSan	,LamTruSo	,CoSoHDSuNghiep		,NhaO	,ChoThue	,BoTrong	,BiLanChiem		,SuDungKhac
	FROM		ThongTinKeKhai_Nha
	WHERE		TaiSanId = @TaiSanId

	-- UPDATE THÔNG TIN KE KHAI ĐẤT
	UPDATE		ThongTinKeKhai_Nha
	SET			 DiaChi				=	@DiaChi
				,GiayTo				=	@GiayTo
				,CapHang			=	@CapHang
				,SoTang				=	@SoTang
				,NamSuDung			=	@NamSuDung
				,DienTich			=	@DienTich
				,TongDienTichSan	=	@TongDienTichSan
				,LamTruSo			=	@LamTruSo
				,CoSoHDSuNghiep		=	@CoSoHDSuNghiep
				,NhaO				=	@NhaO
				,ChoThue			=	@ChoThue
				,BoTrong			=	@BoTrong
				,BiLanChiem			=	@BiLanChiem
				,SuDungKhac			=	@SuDungKhac
	WHERE		TaiSanId = @TaiSanId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinNha_UpdateThayDoiThongTinNha]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.15
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinNha_UpdateThayDoiThongTinNha]
						 @CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	NULL
						,@TaiSanId				=	NULL
						,@Ngay					=	NULL
						,@TenTaiSanCu			=	NULL
						,@LyDo					=	NULL
						,@DuyetId				=	NULL
						,@NguoiDuyet			=	NULL
						,@NguoiTao				=	NULL
						,@NgayTao				=	NULL
						,@CtrVersion			=	NULL

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	NULL

						-- THÔNG TIN KÊ KHAI MỚI
						,@DiaChi				=	NULL
						,@GiayTo				=	NULL
						,@CapHang				=	NULL
						,@SoTang				=	NULL
						,@NamSuDung				=	NULL
						,@DienTich				=	NULL
						,@TongDienTichSan		=	NULL
						,@LamTruSo				=	NULL
						,@CoSoHDSuNghiep		=	NULL
						,@NhaO					=	NULL
						,@ChoThue				=	NULL
						,@BoTrong				=	NULL
						,@BiLanChiem			=	NULL
						,@SuDungKhac			=	NULL

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.15 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTinNha_UpdateThayDoiThongTinNha]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				INT				=	NULL
	,@Ngay					DATETIME		=	NULL
	,@TenTaiSanCu			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@DuyetId				INT				=	NULL
	,@NguoiDuyet			INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSanMoi			NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI NHÀ MỚI
	,@ThuocDat				INT				=	NULL
	,@DiaChi				NVARCHAR(MAX)	=	NULL
	,@GiayTo				NVARCHAR(MAX)	=	NULL
	,@CapHang				INT				=	NULL
	,@SoTang				INT				=	NULL
	,@NamSuDung				NUMERIC(18,4)	=	NULL
	,@DienTich				NUMERIC(18,4)	=	NULL
	,@TongDienTichSan		NUMERIC(18,4)	=	NULL
	,@LamTruSo				NUMERIC(18,4)	=	NULL
	,@CoSoHDSuNghiep		NUMERIC(18,4)	=	NULL
	,@NhaO					NUMERIC(18,4)	=	NULL
	,@ChoThue				NUMERIC(18,4)	=	NULL
	,@BoTrong				NUMERIC(18,4)	=	NULL
	,@BiLanChiem			NUMERIC(18,4)	=	NULL
	,@SuDungKhac			NUMERIC(18,4)	=	NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ
	DECLARE	@V_TRANS_NAME		NVARCHAR(MAX)	=	N'TDTT_NHA_UPDATE'
	-- THAY ĐỔI THÔNG TIN NHÀ
	,@DiaChiCu				NVARCHAR(MAX)	=	NULL
	,@GiayToCu				NVARCHAR(MAX)	=	NULL
	,@CapHangCu				INT				=	NULL
	,@SoTangCu				INT				=	NULL
	,@NamSuDungCu			NUMERIC(18,4)	=	NULL
	,@DienTichCu			NUMERIC(18,4)	=	NULL
	,@TongDienTichSanCu		NUMERIC(18,4)	=	NULL
	,@LamTruSoCu			NUMERIC(18,4)	=	NULL
	,@CoSoHDSuNghiepCu		NUMERIC(18,4)	=	NULL
	,@NhaOCu				NUMERIC(18,4)	=	NULL
	,@ChoThueCu				NUMERIC(18,4)	=	NULL
	,@BoTrongCu				NUMERIC(18,4)	=	NULL
	,@BiLanChiemCu			NUMERIC(18,4)	=	NULL
	,@SuDungKhacCu			NUMERIC(18,4)	=	NULL

	-- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	-- LẤY THÔNG TIN KÊ KHAI CŨ
	SELECT		 @TenTaiSanCu		=	ISNULL(TDTT.TenTaiSanCu, TS.TenTaiSan)
				,@BiLanChiemCu		=	ISNULL(TDTT_Nha.BiLanChiemCu, TTKK_Nha.BiLanChiem)
				,@BoTrongCu			=	ISNULL(TDTT_Nha.BoTrongCu, TTKK_Nha.BoTrong)
				,@CapHangCu			=	ISNULL(TDTT_Nha.CapHangCu, TTKK_Nha.CapHang)
				,@ChoThueCu			=	ISNULL(TDTT_Nha.ChoThueCu, TTKK_Nha.ChoThue)
				,@CoSoHDSuNghiepCu	=	ISNULL(TDTT_Nha.CoSoHDSuNghiepCu, TTKK_Nha.CoSoHDSuNghiep)
				,@DiaChiCu			=	ISNULL(TDTT_Nha.DiaChiCu, TTKK_Nha.DiaChi)
				,@DienTichCu		=	ISNULL(TDTT_Nha.DienTichCu, TTKK_Nha.DienTich)
				,@GiayToCu			=	ISNULL(TDTT_Nha.GiayToCu, TTKK_Nha.GiayTo)
				,@LamTruSoCu		=	ISNULL(TDTT_Nha.LamTruSoCu, TTKK_Nha.LamTruSo)
				,@NamSuDungCu		=	ISNULL(TDTT_Nha.NamSuDungCu, TTKK_Nha.NamSuDung)
				,@NhaOCu			=	ISNULL(TDTT_Nha.NhaOCu, TTKK_Nha.NhaO)
				,@SoTangCu			=	ISNULL(TDTT_Nha.SoTangCu, TTKK_Nha.SoTang)
				,@SuDungKhacCu		=	ISNULL(TDTT_Nha.SuDungKhacCu, TTKK_Nha.SuDungKhac)
				,@TongDienTichSanCu	=	ISNULL(TDTT_Nha.TongDienTichSanCu, TTKK_Nha.TongDienTichSan)
	FROM		ThayDoiThongTin TDTT
				LEFT JOIN ThayDoiThongTin_Nha TDTT_Nha ON TDTT.ThayDoiThongTinId = TDTT_Nha.ThayDoiThongTinId
				LEFT JOIN TaiSan TS ON TDTT.TaiSanId = TS.TaiSanId
				LEFT JOIN ThongTinKeKhai_Nha TTKK_Nha ON TDTT.TaiSanId = TTKK_Nha.TaiSanId
	WHERE		TDTT.ThayDoiThongTinId = @ThayDoiThongTinId

	IF @TenTaiSanCu			= @TenTaiSanMoi			SET @TenTaiSanCu		= NULL
	IF @DiaChiCu			= @DiaChi				SET @DiaChiCu			= NULL
	IF @GiayToCu			= @GiayTo				SET @GiayToCu			= NULL
	IF @CapHangCu			= @CapHang				SET @CapHangCu			= NULL
	IF @SoTangCu			= @SoTang				SET @SoTangCu			= NULL
	IF @NamSuDungCu			= @NamSuDung			SET @NamSuDungCu		= NULL
	IF @DienTichCu			= @DienTich				SET @DienTichCu			= NULL
	IF @TongDienTichSanCu	= @TongDienTichSan		SET @TongDienTichSanCu	= NULL
	IF @LamTruSoCu			= @LamTruSo				SET @LamTruSoCu			= NULL
	IF @CoSoHDSuNghiepCu	= @CoSoHDSuNghiep		SET @CoSoHDSuNghiepCu	= NULL
	IF @NhaOCu				= @NhaO					SET @NhaOCu				= NULL
	IF @ChoThueCu			= @ChoThue				SET @ChoThueCu			= NULL
	IF @BoTrongCu			= @BoTrong				SET @BoTrongCu			= NULL
	IF @BiLanChiemCu		= @BiLanChiem			SET @BiLanChiemCu		= NULL
	IF @SuDungKhacCu		= @SuDungKhac			SET @SuDungKhacCu		= NULL

	PRINT @DiaChi
	PRINT @DiaChiCu
	PRINT @GiayTo
	PRINT @GiayToCu

BEGIN TRANSACTION @V_TRANS_NAME
	-- UPDATE THAY ĐỔI THÔNG TIN
	UPDATE	 ThayDoiThongTin	
	SET		 TaiSanId		=	@TaiSanId
			,TenTaiSanCu	=	@TenTaiSanCu
			,Ngay			=	@Ngay
			,LyDo			=	@LyDo
			,CtrVersion		=	CtrVersion + 1
	WHERE ThayDoiThongTinId = @ThayDoiThongTinId

	-- UPDATE THAY ĐỔI THÔNG TIN NHÀ
	UPDATE	ThayDoiThongTin_Nha
	SET		 DiaChiCu			= @DiaChiCu
			,GiayToCu			= @GiayToCu
			,CapHangCu			= @CapHangCu
			,SoTangCu			= @SoTangCu
			,NamSuDungCu		= @NamSuDungCu
			,DienTichCu			= @DienTichCu
			,TongDienTichSanCu	= @TongDienTichSanCu
			,LamTruSoCu			= @LamTruSoCu
			,CoSoHDSuNghiepCu	= @CoSoHDSuNghiepCu
			,NhaOCu				= @NhaOCu
			,ChoThueCu			= @ChoThueCu
			,BoTrongCu			= @BoTrongCu
			,BiLanChiemCu		= @BiLanChiemCu
			,SuDungKhacCu		= @SuDungKhacCu
	WHERE ThayDoiThongTinId = @ThayDoiThongTinId

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- UPDATE THÔNG TIN KE KHAI
	UPDATE		ThongTinKeKhai_Nha
	SET			 DiaChi				=	@DiaChi
				,GiayTo				=	@GiayTo
				,CapHang			=	@CapHang
				,SoTang				=	@SoTang
				,NamSuDung			=	@NamSuDung
				,DienTich			=	@DienTich
				,TongDienTichSan	=	@TongDienTichSan
				,LamTruSo			=	@LamTruSo
				,CoSoHDSuNghiep		=	@CoSoHDSuNghiep
				,NhaO				=	@NhaO
				,ChoThue			=	@ChoThue
				,BoTrong			=	@BoTrong
				,BiLanChiem			=	@BiLanChiem
				,SuDungKhac			=	@SuDungKhac
	WHERE		TaiSanId = @TaiSanId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinNha_UpdateThayDoiThongTinNha_170921]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.15
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinNha_UpdateThayDoiThongTinNha]
						 @CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	NULL
						,@TaiSanId				=	NULL
						,@Ngay					=	NULL
						,@TenTaiSanCu			=	NULL
						,@LyDo					=	NULL
						,@DuyetId				=	NULL
						,@NguoiDuyet			=	NULL
						,@NguoiTao				=	NULL
						,@NgayTao				=	NULL
						,@CtrVersion			=	NULL

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	NULL

						-- THÔNG TIN KÊ KHAI MỚI
						,@DiaChi				=	NULL
						,@GiayTo				=	NULL
						,@CapHang				=	NULL
						,@SoTang				=	NULL
						,@NamSuDung				=	NULL
						,@DienTich				=	NULL
						,@TongDienTichSan		=	NULL
						,@LamTruSo				=	NULL
						,@CoSoHDSuNghiep		=	NULL
						,@NhaO					=	NULL
						,@ChoThue				=	NULL
						,@BoTrong				=	NULL
						,@BiLanChiem			=	NULL
						,@SuDungKhac			=	NULL

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.15 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
create PROCEDURE [dbo].[sp_ThayDoiThongTinNha_UpdateThayDoiThongTinNha_170921]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				INT				=	NULL
	,@Ngay					DATETIME		=	NULL
	,@TenTaiSanCu			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@DuyetId				INT				=	NULL
	,@NguoiDuyet			INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSanMoi			NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI NHÀ MỚI
	,@DiaChi				NVARCHAR(MAX)	=	NULL
	,@GiayTo				NVARCHAR(MAX)	=	NULL
	,@CapHang				INT				=	NULL
	,@SoTang				INT				=	NULL
	,@NamSuDung				NUMERIC(18,4)	=	NULL
	,@DienTich				NUMERIC(18,4)	=	NULL
	,@TongDienTichSan		NUMERIC(18,4)	=	NULL
	,@LamTruSo				NUMERIC(18,4)	=	NULL
	,@CoSoHDSuNghiep		NUMERIC(18,4)	=	NULL
	,@NhaO					NUMERIC(18,4)	=	NULL
	,@ChoThue				NUMERIC(18,4)	=	NULL
	,@BoTrong				NUMERIC(18,4)	=	NULL
	,@BiLanChiem			NUMERIC(18,4)	=	NULL
	,@SuDungKhac			NUMERIC(18,4)	=	NULL

AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ
	DECLARE	@V_TRANS_NAME		NVARCHAR(500)	=	N'TDTT_NHA_UPDATE'
	
	-- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	SET @TenTaiSanCu = (SELECT TenTaiSan FROM TaiSan WHERE TaiSanId = @TaiSanId)

BEGIN TRANSACTION @V_TRANS_NAME
	-- UPDATE THAY ĐỔI THÔNG TIN
	UPDATE	 ThayDoiThongTin	
	SET		 TaiSanId		=	@TaiSanId
			,Ngay			=	@Ngay
			,TenTaiSanCu	=	@TenTaiSanCu
			,LyDo			=	@LyDo
			,DuyetId		=	@DuyetId
			,NguoiDuyet		=	@NguoiDuyet
			,CoSoId			=	@CoSoId
			,NguoiTao		=	@NguoiTao
			,NgayTao		=	@NgayTao
			,CtrVersion		=	CtrVersion + 1
	WHERE ThayDoiThongTinId = @ThayDoiThongTinId

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- UPDATE THÔNG TIN KE KHAI ĐẤT
	UPDATE		ThongTinKeKhai_Nha
	SET			 DiaChi				=	@DiaChi
				,GiayTo				=	@GiayTo
				,CapHang			=	@CapHang
				,SoTang				=	@SoTang
				,NamSuDung			=	@NamSuDung
				,DienTich			=	@DienTich
				,TongDienTichSan	=	@TongDienTichSan
				,LamTruSo			=	@LamTruSo
				,CoSoHDSuNghiep		=	@CoSoHDSuNghiep
				,NhaO				=	@NhaO
				,ChoThue			=	@ChoThue
				,BoTrong			=	@BoTrong
				,BiLanChiem			=	@BiLanChiem
				,SuDungKhac			=	@SuDungKhac
	WHERE		TaiSanId = @TaiSanId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinOto_GetThayDoiThongTinOtoById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinOto_GetThayDoiThongTinOtoById]
						 @ThayDoiThongTinId		=	26

						,@CoSoId				=	1
						,@NhanVienId			=	6
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTinOto_GetThayDoiThongTinOtoById]
	 @ThayDoiThongTinId	INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON 
	SET @MESSAGE = ISNULL(@MESSAGE,'')
	SELECT	 TDTT_OTO.ThayDoiThongTinId
			,ISNULL(TDTT_OTO.BienKiemSoatCu		, TTKK_OTO.BienKiemSoat)	BienKiemSoatCu
			,ISNULL(TDTT_OTO.ChucDanhCu			, TTKK_OTO.ChucDanh)		ChucDanhCu
			,ISNULL(TDTT_OTO.CongSuatXeCu		, TTKK_OTO.CongSuatXe)		CongSuatXeCu
			,ISNULL(HTSD.NoiDung	, HTSD2.NoiDung)	TenHienTrangSuDungCu
			,ISNULL(LX.NoiDung			, LX2.NoiDung)			LoaiXeCu
			,ISNULL(TDTT_OTO.NguonGocXeCu		, TTKK_OTO.NguonGocXe)		NguonGocXeCu
			,ISNULL(TDTT_OTO.NhanHieuCu			, TTKK_OTO.NhanHieu)		NhanHieuCu
			,ISNULL(TDTT_OTO.TrongTaiCu			, TTKK_OTO.TrongTai)		TrongTaiCu
	FROM	ThayDoiThongTin_Oto TDTT_OTO
			LEFT JOIN ThayDoiThongTin TDTT ON TDTT_OTO.ThayDoiThongTinId = TDTT.ThayDoiThongTinId
			LEFT JOIN ThongTinKeKhai_Oto TTKK_OTO ON TDTT.TaiSanId = TTKK_OTO.TaiSanId
			LEFT JOIN HienTrangSuDung HTSD ON TDTT_OTO.HienTrangSuDungCu = HTSD.HienTrangSuDungId
			LEFT JOIN LoaiXe LX ON TDTT_OTO.LoaiXeCu = LX.LoaiXeId
			LEFT JOIN HienTrangSuDung HTSD2 ON TTKK_OTO.HienTrangSuDung = HTSD.HienTrangSuDungId
			LEFT JOIN LoaiXe LX2 ON TTKK_OTO.LoaiXe = LX.LoaiXeId
	WHERE	TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
SET NOCOUNT OFF
END

select HTSD.* from ThayDoiThongTin_Oto TDTT_OTO
			LEFT JOIN ThayDoiThongTin TDTT ON TDTT_OTO.ThayDoiThongTinId = TDTT.ThayDoiThongTinId
			LEFT JOIN ThongTinKeKhai_Oto TTKK_OTO ON TDTT.TaiSanId = TTKK_OTO.TaiSanId
			LEFT JOIN HienTrangSuDung HTSD ON TDTT_OTO.HienTrangSuDungCu = HTSD.HienTrangSuDungId
			LEFT JOIN LoaiXe LX ON TDTT_OTO.LoaiXeCu = LX.LoaiXeId
			LEFT JOIN HienTrangSuDung HTSD2 ON TTKK_OTO.HienTrangSuDung = HTSD.HienTrangSuDungId
			LEFT JOIN LoaiXe LX2 ON TTKK_OTO.LoaiXe = LX.LoaiXeId


GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinOto_InsertThayDoiThongTinOto]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinOto_InsertThayDoiThongTinOto]
						 @CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	NULL
						,@TaiSanId				=	NULL
						,@Ngay					=	NULL
						,@TenTaiSanCu			=	NULL
						,@LyDo					=	NULL
						,@DuyetId				=	NULL
						,@NguoiDuyet			=	NULL
						,@NguoiTao				=	NULL
						,@NgayTao				=	NULL
						,@CtrVersion			=	NULL

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	NULL

						-- THÔNG TIN KÊ KHAI MỚI
						,@NhanHieu				=	NULL
						,@BienKiemSoat			=	NULL
						,@CongSuatXe			=	NULL
						,@TrongTai				=	NULL
						,@ChucDanh				=	NULL
						,@NguonGocXe			=	NULL
						,@LoaiXe				=	NULL
						,@HienTrangSuDung		=	NULL

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTinOto_InsertThayDoiThongTinOto]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				INT				=	NULL
	,@Ngay					DATETIME		=	NULL
	,@TenTaiSanCu			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@DuyetId				INT				=	NULL
	,@NguoiDuyet			INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSanMoi			NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI MỚI
	,@NhanHieu				NVARCHAR(MAX)	=	NULL
	,@BienKiemSoat			NVARCHAR(MAX)	=	NULL
	,@CongSuatXe			NUMERIC(4,0)	=	NULL
	,@TrongTai				NUMERIC(4,0)	=	NULL
	,@ChucDanh				NVARCHAR(MAX)	=	NULL
	,@NguonGocXe			NVARCHAR(MAX)	=	NULL
	,@LoaiXe				INT				=	NULL
	,@HienTrangSuDung		INT				=	NULL

AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
---------- BIẾN NỘI BỘ
	-- BIẾN NỘI BỘ
	DECLARE	@V_TRANS_NAME		NVARCHAR(500)	=	N'TDTT_OTO_INSERT'
	
	-- THAY ĐỔI THÔNG TIN OTO
	,@NhanHieuCu			NVARCHAR(MAX)	=	NULL
	,@BienKiemSoatCu		NVARCHAR(MAX)	=	NULL
	,@CongSuatXeCu			NUMERIC(4,0)	=	NULL
	,@TrongTaiCu			NUMERIC(4,0)	=	NULL
	,@ChucDanhCu			NVARCHAR(MAX)	=	NULL
	,@NguonGocXeCu			NVARCHAR(MAX)	=	NULL
	,@LoaiXeCu				INT				=	NULL
	,@HienTrangSuDungCu		INT				=	NULL

	-- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)
	SET @NguoiDuyet		=	@NhanVienId
	SET @NguoiTao		=	@NhanVienId
	SET @NgayTao		=	GETDATE()
	SET @CtrVersion		=	1

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	-- LẤY THÔNG TIN KÊ KHAI CŨ
	SELECT		 @NhanHieuCu		=	NhanHieu
				,@BienKiemSoatCu	=	BienKiemSoat	
				,@CongSuatXeCu		=	CongSuatXe	
				,@TrongTaiCu		=	TrongTai
				,@ChucDanhCu		=	ChucDanh
				,@NguonGocXeCu		=	NguonGocXe
				,@LoaiXeCu			=	LoaiXe
				,@HienTrangSuDungCu	=	HienTrangSuDung
	FROM		ThongTinKeKhai_Oto
	WHERE		TaiSanId = @TaiSanId

	SELECT @TenTaiSanCu = TenTaiSan FROM TaiSan WHERE TaiSanId = @TaiSanId

	-- SET THÔNG TIN BỊ THAY ĐỔI
	IF @TenTaiSanCu			= @TenTaiSanMoi		SET @TenTaiSanCu		= NULL
	IF @NhanHieuCu			= @NhanHieu			SET @NhanHieuCu			= NULL
	IF @BienKiemSoatCu		= @BienKiemSoat		SET @BienKiemSoatCu		= NULL
	IF @CongSuatXeCu		= @CongSuatXe		SET @CongSuatXeCu		= NULL
	IF @TrongTaiCu			= @TrongTai			SET @TrongTaiCu			= NULL
	IF @ChucDanhCu			= @ChucDanh			SET @ChucDanhCu			= NULL
	IF @NguonGocXeCu		= @NguonGocXe		SET @NguonGocXeCu		= NULL
	IF @LoaiXeCu			= @LoaiXe			SET @LoaiXeCu			= NULL
	IF @HienTrangSuDungCu	= @HienTrangSuDung	SET @HienTrangSuDungCu	= NULL

BEGIN TRANSACTION @V_TRANS_NAME
/*
	- Lưu bảng ThayDoiThongTin
		- Tên tài sản cũ là tên tài sản hiện tại
	- Update tên tài sản mới vào bảng TaiSan
	- Lấy thông tin từ bảng ThongTinKeKhai lưu vào bảng ThayDoiThongTin
	- Lưu thông tin kê khai mới vào bảng ThongTinKeKhai
*/
	-- INSERT THAY ĐỔI THÔNG TIN
	INSERT INTO ThayDoiThongTin	(	TaiSanId	,Ngay	,TenTaiSanCu	,LyDo	,DuyetId	,NguoiDuyet		,CoSoId		,NguoiTao	,NgayTao	,CtrVersion		)
	VALUES						(	@TaiSanId	,@Ngay	,@TenTaiSanCu	,@LyDo	,@DuyetId	,@NguoiDuyet	,@CoSoId	,@NguoiTao	,@NgayTao	,@CtrVersion	)

	SET @ThayDoiThongTinId = @@IDENTITY

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- INSERT THAY ĐỔI THÔNG TIN
	INSERT INTO ThayDoiThongTin_Oto	(	ThayDoiThongTinId	,NhanHieuCu		,BienKiemSoatCu		,CongSuatXeCu	,TrongTaiCu		,ChucDanhCu		,NguonGocXeCu	,LoaiXeCu	,HienTrangSuDungCu	)
	VALUES							(	@ThayDoiThongTinId	,@NhanHieuCu	,@BienKiemSoatCu	,@CongSuatXeCu	,@TrongTaiCu	,@ChucDanhCu	,@NguonGocXeCu	,@LoaiXeCu	,@HienTrangSuDungCu	)

	-- UPDATE THÔNG TIN KE KHAI
	UPDATE		ThongTinKeKhai_Oto
	SET			NhanHieu		=	@NhanHieu
			   ,BienKiemSoat	=	@BienKiemSoat
			   ,CongSuatXe		=	@CongSuatXe
			   ,TrongTai		=	@TrongTai
			   ,ChucDanh		=	@ChucDanh
			   ,NguonGocXe		=	@NguonGocXe
			   ,LoaiXe			=	@LoaiXe
			   ,HienTrangSuDung	=	@HienTrangSuDung
	WHERE		TaiSanId = @TaiSanId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTinOto_UpdateThayDoiThongTinOto]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.15
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinOto_UpdateThayDoiThongTinOto]
						 @CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	NULL
						,@TaiSanId				=	NULL
						,@Ngay					=	NULL
						,@TenTaiSanCu			=	NULL
						,@LyDo					=	NULL
						,@DuyetId				=	NULL
						,@NguoiDuyet			=	NULL
						,@NguoiTao				=	NULL
						,@NgayTao				=	NULL
						,@CtrVersion			=	NULL

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	NULL

						-- THÔNG TIN KÊ KHAI MỚI
						,@NhanHieu				=	NULL
						,@BienKiemSoat			=	NULL
						,@CongSuatXe			=	NULL
						,@TrongTai				=	NULL
						,@ChucDanh				=	NULL
						,@NguonGocXe			=	NULL
						,@LoaiXe				=	NULL
						,@HienTrangSuDung		=	NULL

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.15 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThayDoiThongTinOto_UpdateThayDoiThongTinOto]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				INT				=	NULL
	,@Ngay					DATETIME		=	NULL
	,@TenTaiSanCu			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@DuyetId				INT				=	NULL
	,@NguoiDuyet			INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSanMoi			NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI NHÀ MỚI
	,@NhanHieu				NVARCHAR(MAX)	=	NULL
	,@BienKiemSoat			NVARCHAR(MAX)	=	NULL
	,@CongSuatXe			NUMERIC(4,0)	=	NULL
	,@TrongTai				NUMERIC(4,0)	=	NULL
	,@ChucDanh				NVARCHAR(MAX)	=	NULL
	,@NguonGocXe			NVARCHAR(MAX)	=	NULL
	,@LoaiXe				INT				=	NULL
	,@HienTrangSuDung		INT				=	NULL

AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ
	DECLARE	@V_TRANS_NAME		NVARCHAR(500)	=	N'TDTT_OTO_UPDATE'
	-- THAY ĐỔI THÔNG TIN OTO
	,@NhanHieuCu			NVARCHAR(MAX)	=	NULL
	,@BienKiemSoatCu		NVARCHAR(MAX)	=	NULL
	,@CongSuatXeCu			NUMERIC(4,0)	=	NULL
	,@TrongTaiCu			NUMERIC(4,0)	=	NULL
	,@ChucDanhCu			NVARCHAR(MAX)	=	NULL
	,@NguonGocXeCu			NVARCHAR(MAX)	=	NULL
	,@LoaiXeCu				INT				=	NULL
	,@HienTrangSuDungCu		INT				=	NULL

	-- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	-- LẤY THÔNG TIN KÊ KHAI CŨ
	SELECT		 @TenTaiSanCu			=	ISNULL(TDTT.TenTaiSanCu, TS.TenTaiSan)
				,@BienKiemSoatCu		=	ISNULL(TDTT_Oto.BienKiemSoatCu, TTKK_Oto.BienKiemSoat)
				,@ChucDanhCu			=	ISNULL(TDTT_Oto.ChucDanhCu, TTKK_Oto.ChucDanh)
				,@CongSuatXeCu			=	ISNULL(TDTT_Oto.CongSuatXeCu, TTKK_Oto.CongSuatXe)
				,@HienTrangSuDungCu		=	ISNULL(TDTT_Oto.HienTrangSuDungCu, TTKK_Oto.HienTrangSuDung)
				,@LoaiXeCu				=	ISNULL(TDTT_Oto.LoaiXeCu, TTKK_Oto.LoaiXe)
				,@NguonGocXeCu			=	ISNULL(TDTT_Oto.NguonGocXeCu, TTKK_Oto.NguonGocXe)
				,@NhanHieuCu			=	ISNULL(TDTT_Oto.NhanHieuCu, TTKK_Oto.NhanHieu)
				,@TrongTaiCu			=	ISNULL(TDTT_Oto.TrongTaiCu, TTKK_Oto.TrongTai)
	FROM		ThayDoiThongTin TDTT
				LEFT JOIN ThayDoiThongTin_Oto TDTT_Oto ON TDTT.ThayDoiThongTinId = TDTT_Oto.ThayDoiThongTinId
				LEFT JOIN TaiSan TS ON TDTT.TaiSanId = TS.TaiSanId
				LEFT JOIN ThongTinKeKhai_Oto TTKK_Oto ON TDTT.TaiSanId = TTKK_Oto.TaiSanId
	WHERE		TDTT.ThayDoiThongTinId = @ThayDoiThongTinId

	-- SET THÔNG TIN BỊ THAY ĐỔI
	IF @TenTaiSanCu			= @TenTaiSanMoi		SET @TenTaiSanCu		= NULL
	IF @NhanHieuCu			= @NhanHieu			SET @NhanHieuCu			= NULL
	IF @BienKiemSoatCu		= @BienKiemSoat		SET @BienKiemSoatCu		= NULL
	IF @CongSuatXeCu		= @CongSuatXe		SET @CongSuatXeCu		= NULL
	IF @TrongTaiCu			= @TrongTai			SET @TrongTaiCu			= NULL
	IF @ChucDanhCu			= @ChucDanh			SET @ChucDanhCu			= NULL
	IF @NguonGocXeCu		= @NguonGocXe		SET @NguonGocXeCu		= NULL
	IF @LoaiXeCu			= @LoaiXe			SET @LoaiXeCu			= NULL
	IF @HienTrangSuDungCu	= @HienTrangSuDung	SET @HienTrangSuDungCu	= NULL

BEGIN TRANSACTION @V_TRANS_NAME
	-- UPDATE THAY ĐỔI THÔNG TIN
	UPDATE	 ThayDoiThongTin	
	SET		 TenTaiSanCu	=	@TenTaiSanCu
			,LyDo			=	@LyDo
			,CtrVersion		=	CtrVersion + 1
	WHERE ThayDoiThongTinId = @ThayDoiThongTinId

	UPDATE	ThayDoiThongTin_Oto
	set		 BienKiemSoatCu			=	@BienKiemSoatCu
			,ChucDanhCu				=	@ChucDanhCu
			,CongSuatXeCu			=	@CongSuatXeCu
			,HienTrangSuDungCu		=	@HienTrangSuDungCu
			,LoaiXeCu				=	@LoaiXeCu
			,NguonGocXeCu			=	@NguonGocXeCu
			,NhanHieuCu				=	@NhanHieuCu
			,TrongTaiCu				=	@TrongTaiCu
	WHERE ThayDoiThongTinId = @ThayDoiThongTinId

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- UPDATE THÔNG TIN KE KHAI
	UPDATE		ThongTinKeKhai_Oto
	SET			NhanHieu		=	@NhanHieu
			   ,BienKiemSoat	=	@BienKiemSoat
			   ,CongSuatXe		=	@CongSuatXe
			   ,TrongTai		=	@TrongTai
			   ,ChucDanh		=	@ChucDanh
			   ,NguonGocXe		=	@NguonGocXe
			   ,LoaiXe			=	@LoaiXe
			   ,HienTrangSuDung	=	@HienTrangSuDung
	WHERE		TaiSanId = @TaiSanId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TheoDoi_DeleteTheoDoiById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_TheoDoi_DeleteTheoDoiById]
	@TaiSanId INT
	,@PhongBanId INT
	,@NhanVienId INT
	,@Nam NUMERIC(4,0)
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	DECLARE @V_SLTang NUMERIC(18,4)
			,@V_SLGiam NUMERIC(18,4)
			,@V_CoSoId INT

	SELECT @V_CoSoId = CoSoId FROM dbo.TaiSan WHERE TaiSanId = @TaiSanId

	IF (SELECT COUNT(KhoaSoLieuId) FROM dbo.KhoaSoLieu WHERE TrangThai = 1 AND CoSoId = @V_CoSoId and Nam=@Nam) > 0
	BEGIN
		SELECT -1 AS ID RETURN
	END

	SELECT @V_SLTang = SLTang, @V_SLGiam = SLGiam FROM dbo.TheoDoi WHERE TaiSanId = @TaiSanId AND PhongBanId = @PhongBanId AND NhanVienId = @NhanVienId AND Nam = @Nam

	BEGIN TRAN
		
		BEGIN TRY
			
			IF EXISTS(SELECT 1 FROM dbo.TheoDoi WHERE TaiSanId = @TaiSanId AND PhongBanId = @PhongBanId AND NhanVienId = @NhanVienId AND Nam = @Nam)
			BEGIN
				
				IF (@V_SLGiam > 0 OR @V_SLTang > 0)
				BEGIN
					SELECT -2 AS ID	-- phat sinh su dung
					RETURN
				END	

				DELETE dbo.TheoDoi WHERE TaiSanId = @TaiSanId AND PhongBanId = @PhongBanId AND NhanVienId = @NhanVienId AND Nam = @Nam
				SELECT 0 AS ID

			END
			ELSE
            BEGIN
            	SELECT -3 AS ID	-- not exists
            END

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TheoDoi_GetListTheoDoiByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_TheoDoi_GetListTheoDoiByCriteria]
( 
	  @CoSoId	        NVARCHAR(10)		
	, @Search			nvarchar(500)   = null	
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null		
	, @LoginId			NVARCHAR(10)
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 
			,@_COSO_IDS		VARCHAR(MAX)	=	NULL


	SET @Search = ISNULL(@Search, '')
	--IF @Search <> ''
	--BEGIN	
	--	SET @Search = N'%' + @Search + '%'
	--	SET @Search = CAST(@Search AS VARCHAR(max))	
	--END	
	----------

	DECLARE @IS_VIEW varchar(10) = '0'
			,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@LoginId,@NAM=@Nam OUTPUT;
	---------------------------
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @LoginId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0026',
		@QUYEN=@IS_VIEW OUTPUT

	-- DANH SÁCH CƠ SỞ TRƯC THUỘC
	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	
	PRINT concat('@_COSO_IDS=',@_COSO_IDS)

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------
	
    
	
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria

	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, td.TaiSanId, ts.MaTaiSan, ts.TenTaiSan, td.NgayGhiTang, td.NgayTrangCap, td.NgayBatDauSuDung, 
				td.PhongBanId, pb.TenPhongBan, td.NhanVienId, nv.TenNhanVien, td.SLTon, td.SLTang, td.SLGiam, Nam,
				(td.SLTon + td.SLTang -td.SLGiam) SoLuong, 
				ISNULL(SUM(NG.GiaTri),0) NguyenGia, 
				(td.SLTon + td.SLTang -td.SLGiam) * ISNULL(SUM(NG.GiaTri),0) AS ThanhTien,
				HD.HopDongId, HD.SoHopDong
	FROM dbo.TheoDoi td
	LEFT JOIN dbo.TaiSan ts ON ts.TaiSanId = td.TaiSanId
	LEFT JOIN dbo.PhongBan pb ON pb.PhongBanId = td.PhongBanId
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = td.NhanVienId
	LEFT JOIN dbo.NguyenGia NG ON NG.TaiSanId = td.TaiSanId 
	LEFT JOIN dbo.HopDong HD ON HD.HopDongId = td.HopDongId
	LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=nv.NguoiTao
	WHERE 1=1 AND TD.Nam = '''+@Nam+''' and td.SLTon >0';
	--WHERE CAST(td.NgayGhiTang AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	BEGIN
		SET @V_SQL = @V_SQL + ' and (ts.MaTaiSan LIKE N''%' + @Search+ '%'' OR ts.TenTaiSan LIKE  N''%' +@Search+ '%'' OR pb.TenPhongBan LIKE  N''%' +@Search+'%'' OR nv.TenNhanVien LIKE  N''%' +@Search+ '%'')';
	END
	
	IF @IS_VIEW = 'VB' 
	BEGIN    
		--SET @V_SQL = @V_SQL + ' and  TS.CoSoId in (' + @_COSO_IDS + ') ';   
		SET @V_SQL = @V_SQL + ' and TS.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @LoginId+ '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @LoginId + '''';   
	END

	--IF @IS_VIEW_ALL = '0' 
	--BEGIN			 
	--	SET @V_SQL = @V_SQL + ' and H.CoSoId =''' + CAST(@CoSoId AS VARCHAR) + '''';	  
	--	SET @V_SQL = @V_SQL + ' and H.NguoiTao =''' + CAST(@LoginId AS VARCHAR) + '''';	  
	--END

	SET @V_SQL = @V_SQL + ' GROUP BY td.TaiSanId, ts.MaTaiSan, ts.TenTaiSan, td.NgayGhiTang, td.NgayTrangCap, td.NgayBatDauSuDung, 
							td.PhongBanId, pb.TenPhongBan, td.NhanVienId, nv.TenNhanVien, td.SLTon, td.SLTang, td.SLGiam,
							td.SLTon,td.SLTang,td.SLGiam,Nam ,HD.HopDongId, HD.SoHopDong';

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	---SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	--SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TheoDoi_GetSoLuongTheoDoiById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROC [dbo].[sp_TheoDoi_GetSoLuongTheoDoiById]
( 
	  @TaiSanId	        nvarchar(500)	= null,
	  @PhongBanId        nvarchar(500)	= null,
	  @NhanVienId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT (SLTon + SLTang - SLGiam) as SoLuong from TheoDoi where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_TheoDoi_GetTheoDoiById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_TheoDoi_GetTheoDoiById]
	@TaiSanId INT,
	@PhongBanId INT,
	@NhanVienId INT,
	@Nam NUMERIC(4,0)
AS  
BEGIN
SET NOCOUNT ON  

	SELECT CAST(TaiSanId AS VARCHAR)TaiSanId,
			CONVERT(VARCHAR, NgayGhiTang,103)NgayGhiTang,
			CONVERT(VARCHAR, NgayTrangCap,103)NgayTrangCap,
			CONVERT(VARCHAR, NgayBatDauSuDung, 103)NgayBatDauSuDung,
			CAST(td.PhongBanId AS VARCHAR)PhongBanId,
			pb.TenPhongBan,
			CAST(td.NhanVienId AS VARCHAR)NhanVienId,
			nv.TenNhanVien,
			SLTon,
			td.Nam,
			HD.HopDongId, HD.SoHopDong
	FROM dbo.TheoDoi td
	LEFT JOIN dbo.PhongBan pb ON pb.PhongBanId = td.PhongBanId
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = td.NhanVienId
	LEFT JOIN dbo.HopDong HD ON HD.HopDongId = td.HopDongId
	WHERE TaiSanId = @TaiSanId
	AND td.PhongBanId = @PhongBanId
	AND td.NhanVienId = @NhanVienId
	AND td.Nam = @Nam
	
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TheoDoi_InsertTheoDoi]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_TheoDoi_InsertTheoDoi]
	@TaiSanId INT
	,@NgayGhiTang DATETIME
    ,@NgayTrangCap datetime
	,@NgayBatDauSuDung DATETIME
	,@PhongBanId INT
	,@NhanVienId INT
	,@SLTon NUMERIC(18,4)
	,@SLTang NUMERIC(18,4)
	,@SLGiam NUMERIC(18,4)
	,@HopDongId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max), @CoSoId INT
	,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@NhanVienId,@NAM=@Nam OUTPUT;
	---------------------------
	SELECT @CoSoId = CoSoId FROM dbo.TaiSan WHERE TaiSanId = @TaiSanId

	IF (SELECT COUNT(KhoaSoLieuId) FROM dbo.KhoaSoLieu WHERE TrangThai = 1 AND CoSoId = @CoSoId and Nam=@Nam) > 0
	BEGIN
		SELECT -1 AS ID RETURN
	END

	BEGIN TRAN
		
		BEGIN TRY
			
			IF EXISTS(SELECT 1 FROM dbo.TheoDoi WHERE TaiSanId = @TaiSanId AND PhongBanId = @PhongBanId AND NhanVienId = @NhanVienId AND Nam = YEAR(@NgayGhiTang))
			BEGIN
				--UPDATE dbo.TheoDoi
				--SET NgayGhiTang = @NgayGhiTang,
				--	NgayTrangCap = @NgayTrangCap,
				--	NgayBatDauSuDung = @NgayBatDauSuDung,
				--	SLTon = @SLTon
				--WHERE TaiSanId = @TaiSanId AND PhongBanId = @PhongBanId AND NhanVienId = @NhanVienId

				--IF (SELECT SLTon + SLTang - SLGiam FROM dbo.TheoDoi WHERE TaiSanId = @TaiSanId AND PhongBanId = @PhongBanId AND NhanVienId = @NhanVienId) < 0
				--BEGIN
				--	SELECT -1 AS ID
				--	RETURN
				--END	
				SELECT -2 AS ID
			END
			ELSE
            BEGIN
				INSERT dbo.TheoDoi
						( TaiSanId ,				NgayGhiTang ,			NgayTrangCap ,			
						  NgayBatDauSuDung ,		PhongBanId ,			NhanVienId ,
						  SLTon ,					SLTang ,				SLGiam		,		
						  Nam,						HopDongId
						)
				SELECT	@TaiSanId					,@NgayGhiTang			,@NgayTrangCap
						,@NgayBatDauSuDung			,@PhongBanId			,@NhanVienId
						,@SLTon						,0						,0					
						,@Nam						,@HopDongId

				SELECT @@ROWCOUNT AS ID
			END

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TheoDoi_UpdateTheoDoi]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_TheoDoi_UpdateTheoDoi]
	@TaiSanId INT
	,@TaiSanId_Old INT
	,@NgayGhiTang DATETIME
    ,@NgayTrangCap datetime
	,@NgayBatDauSuDung DATETIME
	,@PhongBanId INT
	,@PhongBanId_Old INT
	,@NhanVienId INT
	,@NhanVienId_Old INT
	,@Nam NUMERIC(4,0)
	,@SLTon NUMERIC(18,4)
	,@SLTang NUMERIC(18,4)
	,@SLGiam NUMERIC(18,4)
	,@HopDongId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max),
			@V_SLTang NUMERIC(18,4),
			@V_SLGiam NUMERIC(18,4),
			@V_CoSoId INT

	SELECT @V_CoSoId = CoSoId FROM dbo.TaiSan WHERE TaiSanId = @TaiSanId
	
	IF (SELECT COUNT(KhoaSoLieuId) FROM dbo.KhoaSoLieu WHERE TrangThai = 1 AND CoSoId = @V_CoSoId and Nam= @Nam) > 0
	BEGIN
		SELECT -1 AS ID RETURN
	END


	SELECT @V_SLTang = SLTang, @V_SLGiam = SLGiam FROM dbo.TheoDoi WHERE TaiSanId = @TaiSanId_Old AND PhongBanId = @PhongBanId_Old AND NhanVienId = @NhanVienId_Old AND Nam = @Nam

	BEGIN TRAN
		
		BEGIN TRY

			IF EXISTS(SELECT 1 FROM dbo.TheoDoi WHERE TaiSanId = @TaiSanId_Old AND PhongBanId = @PhongBanId_Old AND NhanVienId = @NhanVienId_Old AND Nam = @Nam)
			BEGIN

				IF (@V_SLGiam > 0 OR @V_SLTang > 0)
				BEGIN
					SELECT -2 AS ID
					RETURN
				END	
								
				UPDATE dbo.TheoDoi
				SET NgayGhiTang = @NgayGhiTang,
					NgayTrangCap = @NgayTrangCap,
					NgayBatDauSuDung = @NgayBatDauSuDung,
					SLTon = @SLTon,
					TaiSanId = @TaiSanId,
					PhongBanId = @PhongBanId,
					NhanVienId = @NhanVienId,
					HopDongId = @HopDongId
				WHERE TaiSanId = @TaiSanId_Old AND PhongBanId = @PhongBanId_Old AND NhanVienId = @NhanVienId_Old AND Nam = @Nam

			END
			

			SELECT @@ROWCOUNT AS ID

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThongBao_ThongBaoByCoSoId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_ThongBao_ThongBaoByCoSoId]
( 
	@CoSoId NCHAR(10),
	@UserId NCHAR(10)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	DECLARE @VaiTroId INT
	SELECT @VaiTroId = VaiTroId FROM QLTS_MAIN.dbo.NguoiDung WHERE NguoiDungId = @UserId

	DECLARE @TB_CHUCNANG TABLE
	(
		 ChucNangId INT,
		 MaChucNang NVARCHAR(50),
		 Quyen INT,
		 Ten NVARCHAR(250)
	)

	insert @TB_CHUCNANG
	select 0,N'CN0029',0,N'Duyệt đề nghị trang cấp'		union
	select 0,N'CN0030',0,N'Duyệt kế hoạch mua sắm'		union
	select 0,N'CN0041',0,N'Duyệt báo cáo'		

	UPDATE CN
	SET ChucNangId = MCN.ChucNangId
	FROM @TB_CHUCNANG CN
	JOIN QLTS_MAIN.dbo.ChucNang MCN ON MCN.MaChucNang = CN.MaChucNang

	UPDATE CN
	SET CN.Quyen = CHARINDEX('A',Q.DSQuyenTacVu)
	FROM QLTS_MAIN.dbo.QuyenTacVu Q JOIN @TB_CHUCNANG CN ON CN.ChucNangId = Q.ChucNangId AND Q.VaiTroId = @VaiTroId

	--SELECT *
	--FROM QLTS_MAIN.dbo.QuyenTacVu Q JOIN @TB_CHUCNANG CN ON CN.ChucNangId = Q.ChucNangId AND Q.VaiTroId = @VaiTroId

	SELECT TOP 20 TB.ThongBaoId, TB.TenThongBao, CONVERT(VARCHAR, TB.NgayTao,120)NgayTao, CONVERT(VARCHAR, GETDATE(),120) NgayHienTai, '' TimeDiff, TB.TrangThai,
				  CASE WHEN TB.TenThongBao = N'Duyệt đề nghị trang cấp' THEN 'DeNghi' --CN0029
					   WHEN TB.TenThongBao = N'Duyệt báo cáo' THEN 'BaoCao'	--CN0041
					   WHEN TB.TenThongBao = N'Duyệt kế hoạch mua sắm' THEN 'MuaSam' END Loai --CN0030
	FROM dbo.ThongBao TB
	JOIN @TB_CHUCNANG CN ON CN.Ten = TB.TenThongBao
	WHERE TB.CoSoId = @CoSoId AND TB.TrangThai = 0 AND CN.Quyen > 0
	ORDER BY TB.NgayTao DESC

-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThongBao_UpdateThongBaoById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_ThongBao_UpdateThongBaoById]
( 
	@ThongBaoId NCHAR(10)
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	UPDATE dbo.ThongBao SET TrangThai = 1 WHERE ThongBaoId = @ThongBaoId
	SELECT @@ROWCOUNT ID
-----------------------------------------------------
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThongSo_GetListThongSo]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_ThongSo_GetListThongSo]
( 
	@NhanVienId varchar(10) = null
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	select a.ThongSoId,a.Loai,Isnull(b.Ten,a.Ten) as Ten,a.TaiSan from ThongSo a 
	left join ThongSoUser b on a.ThongSoId=b.ThongSoId  AND b.NhanVienId = @NhanVienId

-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThongSo_UpdateInsert]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_ThongSo_UpdateInsert]
( 
	@ThongSoId int =null,
	@Loai nvarchar(100) =null,
	@Ten nvarchar(100) =null,
	@TaiSan varchar(2) =null,
	@NhanVienId int =null
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	if(exists(select * from ThongSo a 
	left join ThongSoUser b on a.ThongSoId=b.ThongSoId  
	where a.ThongSoId = @ThongSoId AND b.NhanVienId = @NhanVienId))
		begin
		update ThongSoUser set Ten=@Ten where  ThongSoId = @ThongSoId and NhanVienId = @NhanVienId
		end
	else
		begin
		insert into ThongSoUser (ThongSoId,NhanVienId,Loai,Ten) values (@ThongSoId,@NhanVienId,@Loai,@Ten)
		end
		select @@ROWCOUNT
-----------------------------------------------------
SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThongSoUser_GetThongSo]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_ThongSoUser_GetThongSo](
@LOAITHONGSO varchar(100),
@NHANVIEN varchar(10), 
@NAM			VARCHAR(20)='' OUTPUT
)
AS  
BEGIN
	SET @NAM = (select Isnull(b.Ten,a.Ten) as Ten from ThongSo a 
	left join ThongSoUser b on a.ThongSoId=b.ThongSoId  AND b.NhanVienId = @NHANVIEN
	where a.Loai = @LOAITHONGSO )
   
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThongSoUser_GetThongSoTaiSanLauBen]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_ThongSoUser_GetThongSoTaiSanLauBen](
@LOAITHONGSO varchar(100),
@NHANVIEN varchar(10), 
@THANGNAM			VARCHAR(20)='' OUTPUT
)
AS  
BEGIN
	SET @THANGNAM = (select Isnull(b.Ten,a.Ten) as Ten from ThongSo a 
	left join ThongSoUser b on a.ThongSoId=b.ThongSoId  AND b.NhanVienId = @NHANVIEN
	where a.Loai = @LOAITHONGSO )
   
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThongTinCongKhai_GetThongTinCongKhaiById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.07
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinCongKhai_GetThongTinCongKhaiById]
						 @TaiSanId			=	34

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.07 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
create PROCEDURE [dbo].[sp_ThongTinCongKhai_GetThongTinCongKhaiById]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	TTCK.*
	FROM	ThongTinCongKhai TTCK
	WHERE	TaiSanId = @TaiSanId
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThongTinCongKhai_InsertThongTinCongKhai]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.07
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinCongKhai_InsertThongTinCongKhai]
						 @TaiSanId				=	NULL
						,@MoTa					=	NULL
						,@MucDich				=	NULL
						,@HienTrangSuDungId		=	NULL
						,@DonGia				=	NULL
						,@NopNganSach			=	NULL
						,@DeLaiDonVi			=	NULL
						,@HHCK					=	NULL
						,@NhaCungCapId			=	NULL

						,@CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.07 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThongTinCongKhai_InsertThongTinCongKhai]
	 @TaiSanId				INT				=	NULL
	,@MoTa					NVARCHAR(MAX)	=	NULL
	,@MucDich				NVARCHAR(MAX)	=	NULL
	,@HienTrangSuDungId		INT				=	NULL
	,@DonGia				NUMERIC(18,4)	=	NULL
	,@NopNganSach			NUMERIC(18,4)	=	NULL
	,@DeLaiDonVi			NUMERIC(18,4)	=	NULL
	,@HHCK					NUMERIC(18,4)	=	NULL
	,@NhaCungCapId			INT				=	NULL

	,@CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)
	SET	@MoTa			=	ISNULL(@MoTa, '')
	SET	@MucDich		=	ISNULL(@MucDich, '')
	SET	@DonGia			=	ISNULL(@DonGia, 0)
	SET	@NopNganSach	=	ISNULL(@NopNganSach, 0)
	SET	@DeLaiDonVi		=	ISNULL(@DeLaiDonVi, 0)
	SET	@HHCK			=	ISNULL(@HHCK, 0)

	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

BEGIN TRY
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

BEGIN TRANSACTION TTCK_INSERT
	-- INSERT DỮ LIỆU
	DELETE ThongTinCongKhai WHERE TaiSanId = @TaiSanId
	INSERT INTO ThongTinCongKhai	(	TaiSanId	,MoTa	,MucDich	,HienTrangSuDungId	,DonGia		,NopNganSach	,DeLaiDonVi		,HHCK	,NhaCungCapId	)
	VALUES							(	@TaiSanId	,@MoTa	,@MucDich	,@HienTrangSuDungId	,@DonGia	,@NopNganSach	,@DeLaiDonVi	,@HHCK	,@NhaCungCapId	)

	COMMIT TRANSACTION TTCK_INSERT
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION TTCK_INSERT

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThongTinCongKhai WHERE TaiSanId = @TaiSanId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThongTinKeKhai500_GetThongTinKeKhai500ById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhai500_GetThongTinKeKhai500ById]
						 @TaiSanId			=	34

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThongTinKeKhai500_GetThongTinKeKhai500ById]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON 
	SET @MESSAGE = ISNULL(@MESSAGE, '')
	SELECT	*,
			HTSD.NoiDung TenHienTrangSuDung
	FROM	ThongTinKeKhai_Tren500 TTKK_500
			LEFT JOIN HienTrangSuDung HTSD ON TTKK_500.HienTrangSuDung = HTSD.HienTrangSuDungId
	WHERE	TaiSanId = @TaiSanId
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThongTinKeKhai500_InsertThongTinKeKhai500]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.09
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhai500_InsertThongTinKeKhai500]
						 @TaiSanId				=	NULL
						,@KyHieu				=	NULL
						,@HienTrangSuDung		=	NULL

						,@CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE					OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.09 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThongTinKeKhai500_InsertThongTinKeKhai500]
	 @TaiSanId				INT				=	NULL
	,@KyHieu				NVARCHAR(MAX)	=	NULL
	,@HienTrangSuDung		INT				=	NULL

	,@CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET @TaiSanId			=	ISNULL(@TaiSanId, 0)
	SET @KyHieu				=	ISNULL(@KyHieu, '')
	SET @HienTrangSuDung	=	ISNULL(@HienTrangSuDung, 0)

	SET @CoSoId				=	ISNULL(@CoSoId, 0)
	SET @NhanVienId			=	ISNULL(@NhanVienId, 0)
	SET @MESSAGE			=	ISNULL(@MESSAGE, '')

BEGIN TRY
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

BEGIN TRANSACTION TTKK_500_INSERT
	-- INSERT DỮ LIỆU
	DELETE ThongTinKeKhai_Tren500 WHERE TaiSanId = @TaiSanId
	INSERT INTO ThongTinKeKhai_Tren500	(	TaiSanId	,KyHieu		,HienTrangSuDung	)
	VALUES								(	@TaiSanId	,@KyHieu	,@HienTrangSuDung	)

	COMMIT TRANSACTION TTKK_500_INSERT
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION TTKK_500_INSERT

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH
	SELECT * FROM ThongTinKeKhai_Tren500 WHERE TaiSanId = @TaiSanId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThongTinKeKhaiDat_GetThongTinKeKhaiDatById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.07
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhaiDat_GetThongTinKeKhaiDatById]
						 @TaiSanId			=	34

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.07 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThongTinKeKhaiDat_GetThongTinKeKhaiDatById]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	*
	FROM	ThongTinKeKhai_Dat
	WHERE	TaiSanId = @TaiSanId
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThongTinKeKhaiDat_InsertThongTinKeKhaiDat]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.07
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhaiDat_InsertThongTinKeKhaiDat]
						 @TaiSanId				=	NULL
						,@DiaChi				=	NULL
						,@GiayTo				=	NULL
						,@DienTich				=	NULL
						,@LamTruSo				=	NULL
						,@CoSoHDSuNghiep		=	NULL
						,@NhaO					=	NULL
						,@ChoThue				=	NULL
						,@BoTrong				=	NULL
						,@BiLanChiem			=	NULL
						,@SuDungKhac			=	NULL
					
						,@CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.07 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThongTinKeKhaiDat_InsertThongTinKeKhaiDat]
	 @TaiSanId				INT				=	NULL
	,@DiaChi				NVARCHAR(MAX)	=	NULL
	,@GiayTo				NVARCHAR(MAX)	=	NULL
	,@DienTich				NUMERIC(18,4)	=	NULL
	,@LamTruSo				NUMERIC(18,4)	=	NULL
	,@CoSoHDSuNghiep		NUMERIC(18,4)	=	NULL
	,@NhaO					NUMERIC(18,4)	=	NULL
	,@ChoThue				NUMERIC(18,4)	=	NULL
	,@BoTrong				NUMERIC(18,4)	=	NULL
	,@BiLanChiem			NUMERIC(18,4)	=	NULL
	,@SuDungKhac			NUMERIC(18,4)	=	NULL

	,@CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)
	SET	@DiaChi			=	ISNULL(@DiaChi, '')
	SET	@GiayTo			=	ISNULL(@GiayTo, '')
	SET	@DienTich		=	ISNULL(@DienTich, 0)
	SET	@LamTruSo		=	ISNULL(@LamTruSo, 0)
	SET	@CoSoHDSuNghiep	=	ISNULL(@CoSoHDSuNghiep, 0)
	SET	@NhaO			=	ISNULL(@NhaO, 0)
	SET	@ChoThue		=	ISNULL(@ChoThue, 0)
	SET	@BoTrong		=	ISNULL(@BoTrong, 0)
	SET	@BiLanChiem		=	ISNULL(@BiLanChiem, 0)
	SET	@SuDungKhac		=	ISNULL(@SuDungKhac, 0)

	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

BEGIN TRY
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

BEGIN TRANSACTION TTKK_DAT_INSERT
	-- INSERT DỮ LIỆU
	DELETE ThongTinKeKhai_Dat WHERE TaiSanId = @TaiSanId
	INSERT INTO ThongTinKeKhai_Dat	(	TaiSanId	,DiaChi		,GiayTo		,DienTich	,LamTruSo	,CoSoHDSuNghiep		,NhaO	,ChoThue	,BoTrong	,BiLanChiem		,SuDungKhac		)
	VALUES							(	@TaiSanId	,@DiaChi	,@GiayTo	,@DienTich	,@LamTruSo	,@CoSoHDSuNghiep	,@NhaO	,@ChoThue	,@BoTrong	,@BiLanChiem	,@SuDungKhac	)

	COMMIT TRANSACTION TTKK_DAT_INSERT
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION TTKK_DAT_INSERT

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH
	SELECT * FROM ThongTinKeKhai_Dat WHERE TaiSanId = @TaiSanId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThongTinKeKhaiNha_GetThongTinKeKhaiNhaById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhaiNha_GetThongTinKeKhaiNhaById]
						 @TaiSanId			=	34

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThongTinKeKhaiNha_GetThongTinKeKhaiNhaById]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	*
	FROM	ThongTinKeKhai_Nha
	WHERE	TaiSanId = @TaiSanId
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThongTinKeKhaiNha_InsertThongTinKeKhaiNha]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.09
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhaiNha_InsertThongTinKeKhaiNha]
						 @TaiSanId				=	NULL
						,@ThuocDat				=	NULL
						,@DiaChi				=	NULL
						,@GiayTo				=	NULL
						,@CapHang				=	NULL
						,@SoTang				=	NULL
						,@NamSuDung				=	NULL
						,@DienTich				=	NULL
						,@TongDienTichSan		=	NULL
						,@LamTruSo				=	NULL
						,@CoSoHDSuNghiep		=	NULL
						,@NhaO					=	NULL
						,@ChoThue				=	NULL
						,@BoTrong				=	NULL
						,@BiLanChiem			=	NULL
						,@SuDungKhac			=	NULL
					
						,@CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.09 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThongTinKeKhaiNha_InsertThongTinKeKhaiNha]
	 @TaiSanId				INT				=	NULL
	,@ThuocDat				INT				=	NULL
	,@DiaChi				NVARCHAR(MAX)	=	NULL
	,@GiayTo				NVARCHAR(MAX)	=	NULL
	,@CapHang				INT				=	NULL
	,@SoTang				INT				=	NULL
	,@NamSuDung				NUMERIC(4, 0)	=	NULL
	,@DienTich				NUMERIC(18,4)	=	NULL
	,@TongDienTichSan		NUMERIC(18,4)	=	NULL
	,@LamTruSo				NUMERIC(18,4)	=	NULL
	,@CoSoHDSuNghiep		NUMERIC(18,4)	=	NULL
	,@NhaO					NUMERIC(18,4)	=	NULL
	,@ChoThue				NUMERIC(18,4)	=	NULL
	,@BoTrong				NUMERIC(18,4)	=	NULL
	,@BiLanChiem			NUMERIC(18,4)	=	NULL
	,@SuDungKhac			NUMERIC(18,4)	=	NULL

	,@CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET	@TaiSanId			=	ISNULL(@TaiSanId, 0)
	SET	@ThuocDat			=	ISNULL(@ThuocDat, 0)
	SET	@DiaChi				=	ISNULL(@DiaChi, '')
	SET	@GiayTo				=	ISNULL(@GiayTo, '')
	SET	@CapHang			=	ISNULL(@CapHang, 0)
	SET	@SoTang				=	ISNULL(@SoTang, 0)
	SET	@NamSuDung			=	ISNULL(@SoTang, 0)
	SET	@DienTich			=	ISNULL(@DienTich, 0)
	SET	@TongDienTichSan	=	ISNULL(@DienTich, 0)
	SET	@LamTruSo			=	ISNULL(@LamTruSo, 0)
	SET	@CoSoHDSuNghiep		=	ISNULL(@CoSoHDSuNghiep, 0)
	SET	@NhaO				=	ISNULL(@NhaO, 0)
	SET	@ChoThue			=	ISNULL(@ChoThue, 0)
	SET	@BoTrong			=	ISNULL(@BoTrong, 0)
	SET	@BiLanChiem			=	ISNULL(@BiLanChiem, 0)
	SET	@SuDungKhac			=	ISNULL(@SuDungKhac, 0)

	SET	@NhanVienId			=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE			=	ISNULL(@MESSAGE, '')

BEGIN TRY
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

BEGIN TRANSACTION TTKK_NHA_INSERT
	-- INSERT DỮ LIỆU
	DELETE ThongTinKeKhai_Nha WHERE TaiSanId = @TaiSanId
	INSERT INTO ThongTinKeKhai_Nha	(	TaiSanId	,ThuocDat	,DiaChi		,GiayTo		,CapHang	,SoTang		,NamSuDung	,DienTich	,TongDienTichSan	,LamTruSo	,CoSoHDSuNghiep		,NhaO	,ChoThue	,BoTrong	,BiLanChiem		,SuDungKhac		)
	VALUES							(	@TaiSanId	,@ThuocDat	,@DiaChi	,@GiayTo	,@CapHang	,@SoTang	,@NamSuDung	,@DienTich	,@TongDienTichSan	,@LamTruSo	,@CoSoHDSuNghiep	,@NhaO	,@ChoThue	,@BoTrong	,@BiLanChiem	,@SuDungKhac	)

	COMMIT TRANSACTION TTKK_NHA_INSERT
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION TTKK_NHA_INSERT

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH
	SELECT * FROM ThongTinKeKhai_Nha WHERE TaiSanId = @TaiSanId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ThongTinKeKhaiOto_GetThongTinKeKhaiOtoById]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhaiOto_GetThongTinKeKhaiOtoById]
						 @TaiSanId			=	34

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThongTinKeKhaiOto_GetThongTinKeKhaiOtoById]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	TTKK_OTO.*,HTSD.NoiDung TenHienTrangSuDung,LX.NoiDung TenLoaiXe
	FROM	ThongTinKeKhai_Oto TTKK_OTO
			LEFT JOIN HienTrangSuDung HTSD ON TTKK_OTO.HienTrangSuDung = HTSD.HienTrangSuDungId
			LEFT JOIN LoaiXe LX ON TTKK_OTO.LoaiXe = LX.LoaiXeId
	WHERE	TaiSanId = @TaiSanId
SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ThongTinKeKhaiOto_InsertThongTinKeKhaiOto]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.08
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhaiOto_InsertThongTinKeKhaiOto]
						 @TaiSanId				=	NULL
						,@NhanHieu				=	NULL
						,@BienKiemSoat			=	NULL
						,@CongSuatXe			=	NULL
						,@TrongTai				=	NULL
						,@ChucDanh				=	NULL
						,@NguonGocXe			=	NULL
						,@LoaiXe				=	NULL
						,@HienTrangSuDung		=	NULL

						,@CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE					OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.08 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_ThongTinKeKhaiOto_InsertThongTinKeKhaiOto]
	 @TaiSanId				INT				=	NULL
	,@NhanHieu				NVARCHAR(MAX)	=	NULL
	,@BienKiemSoat			NVARCHAR(MAX)	=	NULL
	,@CongSuatXe			NUMERIC(18,4)	=	NULL
	,@TrongTai				NUMERIC(18,4)	=	NULL
	,@ChucDanh				NVARCHAR(MAX)	=	NULL
	,@NguonGocXe			NVARCHAR(MAX)	=	NULL
	,@LoaiXe				INT				=	NULL
	,@HienTrangSuDung		INT				=	NULL

	,@CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET @TaiSanId			=	ISNULL(@TaiSanId, 0)
	SET @NhanHieu			=	ISNULL(@NhanHieu, '')
	SET @BienKiemSoat		=	ISNULL(@BienKiemSoat, '')
	SET @CongSuatXe			=	ISNULL(@CongSuatXe, 0)
	SET @TrongTai			=	ISNULL(@TrongTai, 0)
	SET @ChucDanh			=	ISNULL(@ChucDanh, '')
	SET @NguonGocXe			=	ISNULL(@NguonGocXe, '')
	SET @LoaiXe				=	ISNULL(@LoaiXe, 0)
	SET @HienTrangSuDung	=	ISNULL(@HienTrangSuDung, 0)

	SET @CoSoId				=	ISNULL(@CoSoId, 0)
	SET @NhanVienId			=	ISNULL(@NhanVienId, 0)
	SET @MESSAGE			=	ISNULL(@MESSAGE, '')

BEGIN TRY
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

BEGIN TRANSACTION TTKK_OTO_INSERT
	-- INSERT DỮ LIỆU
	DELETE ThongTinKeKhai_Oto WHERE TaiSanId = @TaiSanId
	INSERT INTO ThongTinKeKhai_Oto	(	TaiSanId	,NhanHieu	,BienKiemSoat	,CongSuatXe		,TrongTai	,ChucDanh	,NguonGocXe		,LoaiXe		,HienTrangSuDung	)
	VALUES							(	@TaiSanId	,@NhanHieu	,@BienKiemSoat	,@CongSuatXe	,@TrongTai	,@ChucDanh	,@NguonGocXe	,@LoaiXe	,@HienTrangSuDung	)

	COMMIT TRANSACTION TTKK_OTO_INSERT
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION TTKK_OTO_INSERT

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH
	SELECT * FROM ThongTinKeKhai_Oto WHERE TaiSanId = @TaiSanId
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TraCuuTaiSan_GetListMenuCoSoByNhanVienId]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.02
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TraCuuTaiSan_GetListMenuCoSoByNhanVienId]
						 @NhanVienId			=	7
						,@MESSAGE				=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.02 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TraCuuTaiSan_GetListMenuCoSoByNhanVienId]
	 @NhanVienId			INT				=	NULL
	,@COSO_ID				INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
---------- BIẾN NỘI BỘ
DECLARE  @FUNCTION_CODE		NVARCHAR(MAX)	=	'CN0037'
		--,@COSO_ID			INT				=	0
		,@PHONGBAN_ID		VARCHAR(MAX)	=	''
		,@IS_VIEW			VARCHAR(10)		=	''

SET @MESSAGE = ISNULL(@MESSAGE,'')
SET @NhanVienId = ISNULL(@NhanVienId,0)

	SELECT	@PHONGBAN_ID =  COALESCE(@PHONGBAN_ID + ',', '') + cast(NVPB.PhongBanId as varchar(10))
	FROM	PhongBanNhanVien NVPB
	WHERE NhanVienId = @NhanVienId

	if @PHONGBAN_ID <> ''
		set @PHONGBAN_ID = SUBSTRING(@PHONGBAN_ID,2,DATALENGTH(@PHONGBAN_ID))

SELECT		@COSO_ID = ND.CoSoId
FROM		NhanVien NV
			LEFT JOIN QLTS_MAIN.DBO.NguoiDung ND ON NV.NhanVienId = ND.NhanVienId
WHERE		NV.NhanVienId = @NhanVienId

	EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @COSO_ID,
		@CHUC_NANG = @FUNCTION_CODE,
		@QUYEN=@IS_VIEW OUTPUT

IF @IS_VIEW = 'VA'
BEGIN
	SELECT		CS.CoSoId ID, CS.MaCoSo MA, CS.TenCoSo TEN,CS.TrucThuoc TRUCTHUOC,ISNULL(CSTT.TenCoSo,'') TENTRUCTHUOC,'COSO' [TYPE]
	FROM		CoSo CS
				LEFT JOIN CoSo CSTT ON CS.TrucThuoc = CSTT.CoSoId
	UNION 
	SELECT		PB.PhongBanId,PB.MaPhongBan,PB.TenPhongBan,PB.CoSoId,ISNULL(CSTT.TenCoSo,'') TENTRUCTHUOC,'PHONGBAN' 
	FROM		PhongBan PB
				LEFT JOIN CoSo CSTT ON PB.CoSoId = CSTT.CoSoId
				LEFT JOIN CoSo CS ON PB.CoSoId = CS.CoSoId
END

IF @IS_VIEW = 'VB'
BEGIN
	SELECT		CS.CoSoId ID, CS.MaCoSo MA, CS.TenCoSo TEN,CS.TrucThuoc TRUCTHUOC,ISNULL(CSTT.TenCoSo,'') TENTRUCTHUOC,'COSO' [TYPE]
	FROM		CoSo CS
				LEFT JOIN CoSo CSTT ON CS.TrucThuoc = CSTT.CoSoId
	WHERE		CS.CoSoId = @COSO_ID OR CS.TrucThuoc = @COSO_ID
	UNION 
	SELECT		PB.PhongBanId,PB.MaPhongBan,PB.TenPhongBan,PB.CoSoId,ISNULL(CSTT.TenCoSo,'') TENTRUCTHUOC,'PHONGBAN' 
	FROM		PhongBan PB
				LEFT JOIN CoSo CSTT ON PB.CoSoId = CSTT.CoSoId
				LEFT JOIN CoSo CS ON PB.CoSoId = CS.CoSoId
	WHERE		PB.CoSoId = @COSO_ID OR CS.TrucThuoc = @COSO_ID
END

IF @IS_VIEW = 'VE' OR @IS_VIEW = 'VR'
BEGIN
	SELECT		PB.PhongBanId ID,PB.MaPhongBan MA,PB.TenPhongBan TEN,PB.CoSoId TRUCTHUOC,ISNULL(CSTT.TenCoSo,'') TENTRUCTHUOC,'PHONGBAN' [TYPE]
	FROM		PhongBan PB
				LEFT JOIN CoSo CSTT ON PB.CoSoId = CSTT.CoSoId
	WHERE		PB.CoSoId = @COSO_ID AND CHARINDEX(',' + CAST(PB.PhongBanId AS VARCHAR(10)) + ',', ',' + @PHONGBAN_ID +',') > 0
END
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TraCuuTaiSan_GetListTaiSanByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.03
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TraCuuTaiSan_GetListTaiSanByCriteria]
						 @NHANVIENID	=	0
						,@PHONGBANID	=	0
						,@COSOID		=	16
						,@LOAIKEKHAI	=	''
						,@SEARCH		=	N''
						,@SKIP			=	0
						,@TAKE			=	0
						,@ORDERCLAUSE	=	''
						,@NHANVIEN_ID	=	6
						,@COSO_ID		=	1
						,@MESSAGE		=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.03 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TraCuuTaiSan_GetListTaiSanByCriteria]
			 @NHANVIENID	INT					=	NULL
			,@PHONGBANID	INT					=	NULL
			,@COSOID		INT					=	NULL
			,@LOAIKEKHAI	VARCHAR(MAX)		=	NULL
			,@SEARCH		NVARCHAR(MAX)		=	NULL
			,@SKIP			INT					=	NULL
			,@TAKE			INT					=	NULL
			,@ORDERCLAUSE	VARCHAR(MAX)		=	NULL
			,@NHANVIEN_ID	INT					=	NULL
			,@COSO_ID		INT					=	NULL
			,@MESSAGE		NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
---------- BIẾN NỘI BỘ
	DECLARE  @V_SQL				NVARCHAR(MAX)	=	N''
			,@_COSO_IDS			NVARCHAR(MAX)	=	NULL
			,@V_FUNCTIONCODE	NVARCHAR(MAX)	=	'CN0037'
			,@V_PHONGBANID		VARCHAR(MAX)	=	''
			,@V_ISVIEW			VARCHAR(10)		=	''
			,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@NHANVIEN_ID,@NAM=@Nam OUTPUT; 
	-- SET DEFAULT
	SET @SEARCH = ISNULL(@SEARCH, '')
	SET @NHANVIENID = ISNULL(@NHANVIENID, 0)
	SET @PHONGBANID = ISNULL(@PHONGBANID, 0)
	SET @COSO_ID = ISNULL(@COSO_ID, 0)
	SET @COSOID = ISNULL(@COSOID, 0)
	
	SET @LOAIKEKHAI = ISNULL(@LOAIKEKHAI, '')

	SET @SKIP = ISNULL(@SKIP, 0)
	SET @TAKE = ISNULL(@TAKE, 0)

	SET @ORDERCLAUSE = ISNULL(@ORDERCLAUSE,'')
	IF (@ORDERCLAUSE = '')
		SET @ORDERCLAUSE = ' MAXCNT ';

	SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID,0)
	SET @MESSAGE = ISNULL(@MESSAGE,'')

	SELECT	@V_PHONGBANID =  COALESCE(@V_PHONGBANID + '|', '') + cast(NVPB.PhongBanId as varchar(10))
	FROM	PhongBanNhanVien NVPB
	WHERE NhanVienId = @NHANVIEN_ID

	if @V_PHONGBANID <> ''
		set @V_PHONGBANID = SUBSTRING(@V_PHONGBANID,2,DATALENGTH(@V_PHONGBANID))

	SET @V_PHONGBANID = ISNULL(@V_PHONGBANID,0)

	-- KIỂM TRA QUYỀN VIEW
	EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NHANVIEN_ID,
		@CO_SO_ID = @COSO_ID,
		@CHUC_NANG = @V_FUNCTIONCODE,
		@QUYEN=@V_ISVIEW OUTPUT
	PRINT @V_ISVIEW
	--/ KIỂM TRA QUYỀN VIEW

	IF @V_ISVIEW = 'VB' AND @COSOID = 0
		SET @COSOID = @COSO_ID

	-- DANH SÁCH CƠ SỞ TRƯC THUỘC
	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
		 @COSOID=@COSOID
		,@COSOID_OUT=@_COSO_IDS OUTPUT
	PRINT @_COSO_IDS
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',','|')
	--/ DANH SÁCH CƠ SỞ TRƯC THUỘC

	-- BUILD QUERY
	SET @V_SQL = N' 
				SELECT		 COUNT(TS.CoSoId) OVER () AS MAXCNT
							,TD.Nam
							,TS.TaiSanId ID,TS.MaTaiSan,TS.TenTaiSan,TS.LoaiKeKhai
							,PB.PhongBanId,PB.MaPhongBan,PB.TenPhongBan
							,NV.NhanVienId,NV.MaNhanVien,NV.TenNhanVien
							,CS.CoSoId,CS.MaCoSo,CS.TenCoSo
							,(TD.SLTon + TD.SLTang - TD.SLGiam) SoLuong
							,SUM(NG.GiaTri) NguyenGia,SUM(NG.GiaTri)*(TD.SLTon + TD.SLTang - TD.SLGiam) ThanhTien
							,HD.SoHopDong
				FROM		TheoDoi TD
							LEFT JOIN TaiSan TS ON TD.TaiSanId = TS.TaiSanId
							LEFT JOIN PhongBan PB ON TD.PhongBanId = PB.PhongBanId
							LEFT JOIN NhanVien NV ON TD.NhanVienId = NV.NhanVienId
							LEFT JOIN CoSo CS ON TS.CoSoId = CS.CoSoId
							LEFT JOIN NguyenGia NG ON NG.TaiSanId = TD.TaiSanId
							LEFT JOIN HopDong HD ON TD.HopDongId = HD.HopDongId
				WHERE		1 = 1 and (TD.SLTon + TD.SLTang - TD.SLGiam) >0 and td.Nam='''+@Nam+'''';

	-- PHÂN QUYỀN
	IF @V_ISVIEW IN('VE')
	BEGIN 
		SET @V_SQL = @V_SQL + N' AND (@NHANVIEN_ID = 0 OR TD.NhanVienId = @NHANVIEN_ID) ';
	END

	IF @V_ISVIEW IN('VR')
	BEGIN 
		SET @V_SQL = @V_SQL + N' AND (@V_PHONGBANID = '''' OR charindex(''|''+cast(TD.PhongBanId as varchar(10))+''|'',''|'+@V_PHONGBANID+'|'') > 0) ';
	END

	IF @V_ISVIEW IN('VB')
	BEGIN 
		SET @V_SQL = @V_SQL + N' AND (@COSO_ID = 0 OR charindex(''|''+cast(TS.CoSoId as varchar(10))+''|'',''|'+@_COSO_IDS+'|'') > 0) ';
	END

	IF @V_ISVIEW IN('VA')
	BEGIN 
		SET @V_SQL = @V_SQL + N' AND (@COSOID = 0 OR charindex(''|''+cast(TS.CoSoId as varchar(10))+''|'',''|'+@_COSO_IDS+'|'') > 0) ';
	END
	--/ PHÂN QUYỀN

	-- TÌM KIẾM
	IF @LOAIKEKHAI <> ''
	BEGIN
		SET @V_SQL = @V_SQL + N' AND (@LOAIKEKHAI = '''' OR CHARINDEX(''|'' + CAST(TS.LoaiKeKhai AS VARCHAR(20)) + ''|'', ''|'' + @LOAIKEKHAI + ''|'') > 0) ';
	END

	IF @NHANVIENID <> 0
	BEGIN
		SET @V_SQL = @V_SQL + N' AND (@NHANVIENID = 0 OR TD.NhanVienId = @NHANVIENID) ';
	END

	IF @PHONGBANID <> 0
	BEGIN
		SET @V_SQL = @V_SQL + N' AND (@PHONGBANID = 0 OR TD.PhongBanId = @PHONGBANID) ';
	END

	IF @SEARCH <> ''
	BEGIN
		SET @V_SQL = @V_SQL + N' AND ( ';
		SET @V_SQL = @V_SQL + N' (CS.MaCoSo LIKE N''%'' + @SEARCH + ''%'' OR CS.TenCoSo LIKE N''%'' + @SEARCH + ''%'') ';
		SET @V_SQL = @V_SQL + N' OR (TS.MaTaiSan LIKE N''%'' + @SEARCH + ''%'' OR TS.TenTaiSan LIKE N''%'' + @SEARCH + ''%'') ';
		SET @V_SQL = @V_SQL + N' OR (PB.MaPhongBan LIKE N''%'' + @SEARCH + ''%'' OR PB.TenPhongBan LIKE N''%'' + @SEARCH + ''%'') ';
		SET @V_SQL = @V_SQL + N' OR (NV.MaNhanVien LIKE N''%'' + @SEARCH + ''%'' OR NV.TenNhanVien LIKE N''%'' + @SEARCH + ''%'') ';
		SET @V_SQL = @V_SQL + N') ';
	END

	SET @V_SQL = @V_SQL + N' GROUP BY
		 TD.Nam,TS.CoSoId
		,TS.TaiSanId,TS.MaTaiSan,TS.TenTaiSan,TS.LoaiKeKhai
		,PB.PhongBanId,PB.MaPhongBan,PB.TenPhongBan
		,NV.NhanVienId,NV.MaNhanVien,NV.TenNhanVien
		,CS.CoSoId,CS.MaCoSo,CS.TenCoSo
		,TD.SLTon,TD.SLTang,TD.SLGiam
		,HD.SoHopDong 
	';

	IF @ORDERCLAUSE <> ''
		SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDERCLAUSE

	IF @OrderClause <> '' AND @TAKE <> 0
		SET @V_SQL = @V_SQL + ' OFFSET ' + CAST(@skip AS nvarchar(20)) + ' ROWS FETCH NEXT ' + CAST(@take AS nvarchar(20)) + ' ROWS ONLY '

	print @V_SQL
	exec sp_executesql @V_SQL,N'
			 @NHANVIENID	INT					=	NULL
			,@PHONGBANID	INT					=	NULL
			,@COSOID		INT					=	NULL
			,@NHANVIEN_ID	INT					=	NULL
			,@V_PHONGBANID	VARCHAR(MAX)		=	NULL
			,@COSO_ID		INT					=	NULL
			,@LOAIKEKHAI	VARCHAR(MAX)		=	NULL
			,@SEARCH		NVARCHAR(MAX)		=	NULL
			'
			,@NHANVIENID	=	@NHANVIENID
			,@PHONGBANID	=	@PHONGBANID
			,@COSOID		=	@COSOID
			,@NHANVIEN_ID	=	@NHANVIEN_ID
			,@V_PHONGBANID	=	@V_PHONGBANID
			,@COSO_ID		=	@COSO_ID
			,@LOAIKEKHAI	=	@LOAIKEKHAI
			,@SEARCH		=	@SEARCH
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_TraCuuTaiSan_LuocSu]    Script Date: 11/3/2017 3:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.10.06
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TraCuuTaiSan_LuocSu]
						 @TAISANID		=	0
						,@NHANVIENID	=	0
						,@PHONGBANID	=	0
						,@NHANVIEN_ID	=	6
						,@COSO_ID		=	1
						,@MESSAGE		=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.06 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
CREATE PROCEDURE [dbo].[sp_TraCuuTaiSan_LuocSu]
			 @TAISANID		INT					=	NULL
			,@NHANVIENID	INT					=	NULL
			,@PHONGBANID	INT					=	NULL
			,@NHANVIEN_ID	INT					=	NULL
			,@COSO_ID		INT					=	NULL
			,@MESSAGE		NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
SET @MESSAGE = ISNULL(@MESSAGE,'')

IF OBJECT_ID('TEMPDB..##LUOCSU') IS NOT NULL
	DROP TABLE ##LUOCSU

SELECT * INTO ##LUOCSU FROM
(
			SELECT		DG.DanhGiaId Id
						,DG.NoiDung
						,DG.NgayDanhGia Ngay,'DANHGIA' [Type],DG.TaiSanId,DG.NhanVienId,DG.PhongBanId 
			FROM		DanhGia DG
			WHERE		DG.TaiSanId = @TAISANID

	UNION	SELECT		KT.KhaiThacId ID
						,concat(	 N'- Phòng ban: ',PB.TenPhongBan
									,N'<br />- Cán bộ: ',NV.TenNhanVien
									,N'<br />- Số lượng: ',FORMAT(KT.SoLuongKhaiThac, 'N0')
								    ,N'<br />- Đơn vị thuê: ',KH.TenKhachHang
								    ,N'<br />- Số hợp đồng: ',HD.SoHopDong
								) MoTa
						,KT.ThoiGianBatDau,'KHAITHAC',KT.TaiSanId,KT.NhanVienId,KT.PhongBanId
			FROM		KhaiThac KT 
						LEFT JOIN PhongBan PB ON KT.PhongBanId = PB.PhongBanId
						LEFT JOIN NhanVien NV ON KT.NhanVienId = NV.NhanVienId
						LEFT JOIN KhachHang KH ON KT.KhachHangNCCId = KH.KhachHangId
						LEFT JOIN HopDong HD ON KT.HopDongId = HD.HopDongId
			WHERE		KT.TaiSanId = @TAISANID AND KT.NhanVienId = @NHANVIENID AND KT.PhongBanId = @PHONGBANID

	UNION	SELECT		TDTT.ThayDoiThongTinId ID,TDTT.LyDo,TDTT.Ngay,'TDTT',TDTT.TaiSanId,'','' 
			FROM		ThayDoiThongTin TDTT 
			WHERE		TDTT.TaiSanId = @TAISANID

	UNION	SELECT		GTCT.GhiTangId
						,concat(	 N'- Phòng ban: ',PB.TenPhongBan
									,N'<br />- Cán bộ: ',NV.TenNhanVien
									,N'<br />- Số lượng: ',FORMAT(GTCT.SoLuong, 'N0')
								    ,N'<br />- Số hợp đồng: ',HD.SoHopDong
								) MoTa
						,GT.NgayGhiTang,'GHITANG',GTCT.TaiSanId,GTCT.NhanVienId,GTCT.PhongBanId 
			FROM		GhiTangChiTiet GTCT 
						LEFT JOIN GHITANG GT ON GTCT.GhiTangId = GT.GhiTangId
						LEFT JOIN PhongBan PB ON GTCT.PhongBanId = PB.PhongBanId
						LEFT JOIN NhanVien NV ON GTCT.NhanVienId = NV.NhanVienId
						LEFT JOIN HopDong HD ON GTCT.HopDongId = HD.HopDongId
			WHERE		GTCT.TaiSanId = @TAISANID AND GTCT.NhanVienId = @NHANVIENID AND GTCT.PhongBanId = @PHONGBANID

	UNION	SELECT		GGCT.GhiGiamId
						,concat(	 N'- Phòng ban: ',PB.TenPhongBan,N'<br />- Cán bộ: ',NV.TenNhanVien,N'<br />- Số lượng: ',FORMAT(GGCT.SoLuong, 'N0') 
								) MoTa
						,GG.NgayGhiGiam,'GHIGIAM',GGCT.TaiSanId,GGCT.NhanVienId,GGCT.PhongBanId 
			FROM		GhiGiamChiTiet GGCT 
						LEFT JOIN GhiGiam GG ON GGCT.GhiGiamId = GG.GhiGiamId
						LEFT JOIN PhongBan PB ON GGCT.PhongBanId = PB.PhongBanId
						LEFT JOIN NhanVien NV ON GGCT.NhanVienId = NV.NhanVienId
			WHERE		GGCT.TaiSanId = @TAISANID AND GGCT.NhanVienId = @NHANVIENID AND GGCT.PhongBanId = @PHONGBANID

	UNION	SELECT		DCCT.DieuChuyenId
						,concat(	 N'- Chuyển từ: ',PB_SD.TenPhongBan,' - ',NV_SD.TenNhanVien
									,N'<br />- Chuyển đến: ',PB_CD.TenPhongBan,' - ',NV_CD.TenNhanVien
								) MoTa
						,DC.NgayDieuChuyen,'DIEUCHUYEN',DCCT.TaiSanId,DCCT.NhanVienTiepNhan,DCCT.PhongBanChuyenDen 
			FROM		DieuChuyenChiTiet DCCT 
						LEFT JOIN DieuChuyen DC ON DCCT.DieuChuyenId = DC.DieuChuyenId
						LEFT JOIN PhongBan PB_SD ON DCCT.PhongBanSuDung = PB_SD.PhongBanId
						LEFT JOIN PhongBan PB_CD ON DCCT.PhongBanChuyenDen = PB_CD.PhongBanId
						LEFT JOIN NhanVien NV_SD ON DCCT.NhanVienSuDung = NV_SD.NhanVienId
						LEFT JOIN NhanVien NV_CD ON DCCT.NhanVienTiepNhan = NV_CD.NhanVienId
			WHERE		DCCT.TaiSanId = @TAISANID AND DCCT.NhanVienTiepNhan = @NHANVIENID AND DCCT.PhongBanChuyenDen = @PHONGBANID
	
	UNION	SELECT		BD.BaoDuongId
						,concat(
							 N'- Ngày bảo dưỡng: ',CONVERT(VARCHAR(10),bd.NgayBaoDuong,103)
							,N'<br />- Các bộ phận sửa chữa: ',sc.TenBoPhan
							,N'<br />- Mô tả: ',BD.MoTa
							) MoTa
						,BD.NgayBaoDuong,'BAODUONG',BD.TaiSanId,BD.NhanVienId,BD.PhongBanId
			FROM		BaoDuong BD 
						LEFT JOIN (
								SELECT
									 BaoDuongId,
									 STUFF(
										 (SELECT ',' + TenBoPhan
										  FROM SuaChua
										  WHERE BaoDuongId = SC.BaoDuongId
										  FOR XML PATH (''))
										  , 1, 1, '')  TenBoPhan
								FROM SuaChua SC
								GROUP BY BaoDuongId
						) SC ON BD.BaoDuongId = SC.BaoDuongId
			WHERE		BD.TaiSanId = @TAISANID AND BD.NhanVienId = @NHANVIENID AND BD.PhongBanId = @PHONGBANID
) TEMP

SELECT	LS.*,PB.TenPhongBan,NV.TenNhanVien,TS.TenTaiSan 
FROM	##LUOCSU LS
		LEFT JOIN TaiSan TS ON LS.TaiSanId = TS.TaiSanId
		LEFT JOIN PhongBan PB ON LS.PhongBanId = PB.PhongBanId
		LEFT JOIN NhanVien NV ON LS.NhanVienId = NV.NhanVienId
ORDER BY LS.Ngay DESC

IF OBJECT_ID('TEMPDB..##LUOCSU') IS NOT NULL
	DROP TABLE ##LUOCSU
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_VaiTro_GetListVaiTroByCriteria]    Script Date: 11/3/2017 3:35:52 PM ******/
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
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TraCuuTaiSan_GetListTaiSanByCriteria]
						 @NHANVIENID	=	0
						,@PHONGBANID	=	0
						,@COSOID		=	16
						,@LOAIKEKHAI	=	''
						,@SEARCH		=	N''
						,@SKIP			=	0
						,@TAKE			=	0
						,@ORDERCLAUSE	=	''
						,@NHANVIEN_ID	=	10
						,@COSO_ID		=	16
						,@MESSAGE		=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
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
	SELECT		 COUNT(TS.CoSoId) OVER () AS MAXCNT
				,TS.*
	FROM		VaiTro VT
	WHERE		1=1
			AND (
				@V_VAITROID = 1
				OR	@V_ISVIEW IN (''VA'')
				OR (@V_ISVIEW IN (''VB'',''VR'') AND VT.CoSoId = @COSO_ID)
				OR (@V_ISVIEW IN (''VE'') AND VT.NguoiTao = @NHANVIEN_ID AND VT.CoSoId = @COSO_ID)
			)
			AND (@VAITROIDS = '' OR CHARINDEX(@V_DELIMITER+CAST(VT.VaiTroId AS VARCHAR(10))+@V_DELIMITER,@V_DELIMITER+@VAITROIDS+@V_DELIMITER) > 0)
			AND (@COSOIDS = '' OR CHARINDEX(@V_DELIMITER+CAST(VT.CoSoId AS VARCHAR(10))+@V_DELIMITER,@V_DELIMITER+@COSOIDS+@V_DELIMITER) > 0)
			AND (@MAVAITRO = '' OR VT.MaVaiTro = @MAVAITRO)
			AND (
				@SEARCH = '' OR VT.MaVaiTro LIKE @V_SEARCH
				OR @SEARCH = '' OR VT.TenVaiTro LIKE @V_SEARCH
				OR @SEARCH = '' OR VT.MoTa LIKE @V_SEARCH
			)
'
	IF @ORDERCLAUSE <> ''
		SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDERCLAUSE

	IF @ORDERCLAUSE <> '' AND @TAKE > 0
		SET @V_SQL = @V_SQL + ' OFFSET ' + CAST(@skip AS nvarchar(20)) + ' ROWS FETCH NEXT ' + CAST(@take AS nvarchar(20)) + ' ROWS ONLY '

	print @V_SQL
	exec sp_executesql @V_SQL
		,N'
		 @VAITROIDS			VARCHAR(MAX)
		,@MAVAITRO			VARCHAR(MAX)
		,@COSOIDS			VARCHAR(MAX)
		,@SEARCH			NVARCHAR(MAX)
		,@NHANVIEN_ID		INT
		,@COSO_ID			INT
		,@V_SEARCH			NVARCHAR(MAX)
		'
		,@VAITROIDS			=	@VAITROIDS
		,@MAVAITRO			=	@MAVAITRO
		,@COSOIDS			=	@COSOIDS
		,@SEARCH			=	@SEARCH
		,@NHANVIEN_ID		=	@NHANVIEN_ID
		,@COSO_ID			=	@COSO_ID
		,@V_SEARCH			=	@V_SEARCH
--------------------------------------------------
	SET NOCOUNT OFF;
END

GO
USE [master]
GO
ALTER DATABASE [QLTS] SET  READ_WRITE 
GO
