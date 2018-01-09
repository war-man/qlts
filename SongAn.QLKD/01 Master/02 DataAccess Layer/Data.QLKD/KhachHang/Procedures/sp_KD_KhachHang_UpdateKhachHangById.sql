USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_KhachHang_UpdateKhachHangById]    Script Date: 12/19/2017 10:03:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[sp_KD_KhachHang_UpdateKhachHangById]
	@KhachHangId varchar (20) ,
	@MaKhachHang varchar (20) ,
	@NhomKhachHangId int ,
	@TenKhachHang nvarchar (100) ,
	@NgaySinh datetime ,
	@GioiTinh int ,
	@HinhAnh nvarchar (100),
	@SoNha nvarchar (50) ,
	@TinhThanhPhoId int ,
	@QuanHuyenId int ,
	@PhuongXaId int ,
	@DienThoai varchar (12) ,
	@FaceBook nvarchar (100) ,
	@Email nvarchar (100) ,
	@NgheNghiep nvarchar (30) ,
	@CoQuan nvarchar (30) ,
	@MaSoThue varchar (20) ,
	@EmailCoQuan nvarchar (100) ,
	@Fax nvarchar (50) ,
	@DiaChiCoQuan nvarchar (300),
	@NgayThanhLap datetime ,
	@TheoDoi nchar (10) , 
	@Khac nvarchar (500) ,
	@NguoiPhuTrach nvarchar (100),
	@CachLamViec nvarchar (500),
	@TinhCach nvarchar (500) ,
	@SoThich nvarchar (500) ,
	@ThoiQuen nvarchar (500) ,
	@GhiChu nvarchar,
	@NguoiTao NVARCHAR(10) ,
	@UserId NVARCHAR(10) 
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			
			UPDATE dbo.KDKhachHang
			SET [MaKhachHang] = @MaKhachHang,
				[NhomKhachHangId] = @NhomKhachHangId,
				[TenKhachHang] = @TenKhachHang,
				[NgaySinh] = @NgaySinh,
				[GioiTinh] = @GioiTinh,
				[HinhAnh] = @HinhAnh,
				[SoNha] = @SoNha,
				[TinhThanhPhoId] = @TinhThanhPhoId,
				[QuanHuyenId] = @QuanHuyenId, 
				[PhuongXaId] = @PhuongXaId,
				[DienThoai] = @DienThoai, 
				[FaceBook] = @FaceBook,
				[Email] = @Email,
				[NgheNghiep] = @NgheNghiep,
				[CoQuan] = @CoQuan,
				[MaSoThue] = @MaSoThue, 
				[EmailCoQuan] = @EmailCoQuan, 
				[Fax] = @Fax, 
				[DiaChiCoQuan] = @DiaChiCoQuan,
				[NgayThanhLap] = @NgayThanhLap,
				[TheoDoi] = @TheoDoi, 
				[Khac] = @Khac,
				[NguoiPhuTrach] = @NguoiPhuTrach,
				[CachLamViec] = @CachLamViec, 
				[TinhCach] = @TinhCach, 
				[SoThich] = @SoThich,
				[ThoiQuen] = @ThoiQuen, 
				[GhiChu] = @GhiChu, 
				--[NguoiTao] = @NguoiTao, 
				--[NgayTao] = @NgayTao, 
				[CtrVersion] = [CtrVersion] + 1
			WHERE KhachHangId = @KhachHangId

			 
			SELECT KH.KhachHangId, KH.MaKhachHang, CAST(KH.NhomKhachHangId AS VARCHAR)NhomKhachHangId, KH.TenKhachHang, CAST(KH.GioiTinh AS VARCHAR)GioiTinh, KH.HinhAnh
				, KH.SoNha, CAST(KH.TinhThanhPhoId AS VARCHAR)TinhThanhPhoId, CAST(KH.QuanHuyenId AS VARCHAR)QuanHuyenId, CAST(KH.PhuongXaId AS VARCHAR)PhuongXaId
				, KH.DienThoai, KH.FaceBook, KH.Email, KH.NgheNghiep, KH.CoQuan, KH.MaSoThue
				, KH.EmailCoQuan, KH.Fax, KH.DiaChiCoQuan, KH.TheoDoi, KH.Khac
				, KH.NguoiPhuTrach, KH.CachLamViec, KH.TinhCach, KH.SoThich, KH.ThoiQuen
				, KH.GhiChu, KH.NguoiTao, KH.NgayTao,
				CONVERT(NVARCHAR, NgaySinh, 103) NgaySinh, 
				CONVERT(NVARCHAR, KH.NgayThanhLap, 103) NgayThanhLap,
				CASE WHEN GioiTinh = 1 THEN 'Nam' ELSE N'Nữ' END TenGioiTinh

			FROM dbo.KDKhachHang KH WHERE KhachHangId = @KhachHangId
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
