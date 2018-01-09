USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_DonHang_InsertDonHang]    Script Date: 12/19/2017 9:52:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[sp_KD_DonHang_InsertDonHang]
	@SoPhieu VARCHAR(20) ,
	@TenDonHang NVARCHAR(100),
	@NgayLap DATETIME ,
	@KhachHangId INT,
	@LyDo NVARCHAR(300) ,
	@HopDongId INT,
	@NhanVienId INT ,
	@DiaChiNhan NVARCHAR(500) ,
	@BoPhanNhan NVARCHAR(100) ,
	@NguoiNhan NVARCHAR(100) ,
	@GhiChu NVARCHAR(300) ,
	@TrangThai INT ,
	@NgayDuyet DATETIME ,
	@NguoiTao INT,
	@UserId NVARCHAR(10),
    @MyTableType_DonHangChiTiet MyTableType_DonHangChiTiet READONLY
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	DECLARE @DonHangId INT
	SET @DonHangId = 0

	BEGIN TRAN
		
		BEGIN TRY

			-- insert header
			INSERT dbo.KDDonHang
			        ( SoPhieu ,			TenDonHang ,		NgayLap ,
			          KhachHangId ,		LyDo ,				HopDongId ,
			          NhanVienId ,		BoPhanNhan ,		NguoiNhan ,
			          GhiChu ,			TrangThai ,			NgayDuyet ,
			          NguoiTao ,		NgayTao ,			CtrVersion,			DiaChiNhan
			        )
			SELECT	  @SoPhieu ,		@TenDonHang ,		@NgayLap ,
			          @KhachHangId ,	@LyDo ,				@HopDongId ,
			          @NhanVienId ,		@BoPhanNhan ,		@NguoiNhan ,
			          @GhiChu ,			@TrangThai ,		@NgayDuyet ,
			          @NguoiTao ,		GETDATE() ,			1,					@DiaChiNhan
			
			SELECT @DonHangId = SCOPE_IDENTITY()
			SELECT @DonHangId AS DonHangIdI

			--- insert line

			INSERT dbo.KDDonHangChiTiet
			        ( DonHangId ,		HangHoaId ,			SoLuong ,
			          DonGia ,			NgayYeuCau ,		NgayNhanHang
			        )
			SELECT	@DonHangId ,		HangHoaId ,			SoLuong ,
			        DonGia ,			NgayYeuCau ,		NgayNhanHang
			FROM @MyTableType_DonHangChiTiet

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
