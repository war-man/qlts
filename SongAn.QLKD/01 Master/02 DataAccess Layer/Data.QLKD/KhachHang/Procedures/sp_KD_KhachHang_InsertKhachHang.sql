USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_KhachHang_InsertKhachHang]    Script Date: 12/19/2017 10:03:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[sp_KD_KhachHang_InsertKhachHang]
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
			
			INSERT dbo.KDKhachHang
			        ( MaKhachHang ,			NhomKhachHangId ,			TenKhachHang ,
			          NgaySinh ,			GioiTinh ,					HinhAnh ,
			          SoNha ,				TinhThanhPhoId ,			QuanHuyenId ,
			          PhuongXaId ,			DienThoai ,					FaceBook ,
			          Email ,				NgheNghiep ,				CoQuan ,
			          MaSoThue ,			EmailCoQuan ,				Fax ,
			          DiaChiCoQuan ,		NgayThanhLap ,				TheoDoi ,
			          Khac ,				NguoiPhuTrach ,				CachLamViec ,
			          TinhCach ,			SoThich ,					ThoiQuen ,
			          GhiChu ,				NguoiTao ,					NgayTao ,
			          CtrVersion
			        )
			SELECT	@MaKhachHang ,			@NhomKhachHangId ,			@TenKhachHang ,
			        @NgaySinh ,				@GioiTinh ,					@HinhAnh ,
			        @SoNha ,				@TinhThanhPhoId ,			@QuanHuyenId ,
			        @PhuongXaId ,			@DienThoai ,				@FaceBook ,
			        @Email ,				@NgheNghiep ,				@CoQuan ,
			        @MaSoThue ,				@EmailCoQuan ,				@Fax ,
			        @DiaChiCoQuan ,			@NgayThanhLap ,				@TheoDoi ,
			        @Khac ,					@NguoiPhuTrach ,			@CachLamViec ,
			        @TinhCach ,				@SoThich ,					@ThoiQuen ,
			        @GhiChu ,				@NguoiTao ,					GETDATE() ,
			        1

			SELECT SCOPE_IDENTITY() AS KhachHangIdI

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
