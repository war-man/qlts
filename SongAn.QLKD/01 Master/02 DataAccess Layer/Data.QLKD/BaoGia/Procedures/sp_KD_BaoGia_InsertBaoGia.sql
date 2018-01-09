
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_BaoGia_InsertBaoGia]    Script Date: 12/19/2017 9:45:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[sp_KD_BaoGia_InsertBaoGia]
	@SoPhieu VARCHAR(20) ,
	@TenBaoGia NVARCHAR(100),
	@NgayBaoGia DATETIME ,
	@KhachHangId INT,
	@LyDo NVARCHAR(300) ,
	@NhanVienId INT ,
	@NguoiNhan NVARCHAR(100) ,
	@DienThoai NVARCHAR(12) ,
	@DaNhan int,
	@TrangThai INT ,
	@GhiChu NVARCHAR(300) ,
	@NguoiTao INT,
	@UserId NVARCHAR(10),
    @MyTableType_BaoGiaChiTiet MyTableType_BaoGiaChiTiet READONLY
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	DECLARE @BaoGiaId INT
	SET @BaoGiaId = 0

	BEGIN TRAN
		
		BEGIN TRY

			-- insert header
			INSERT dbo.KDBaoGia
			        ( SoPhieu ,			TenBaoGia ,			NgayBaoGia ,
			          NhanVienId ,		KhachHangId ,		LyDo ,
			          NguoiNhan ,		DienThoai ,			DaNhan ,
			          TrangThai ,		GhiChu ,			NguoiTao ,
			          NgayTao ,			CtrVersion
			        )
			SELECT	  @SoPhieu ,		@TenBaoGia ,		@NgayBaoGia ,
			          @NhanVienId ,		@KhachHangId ,		@LyDo ,
			          @NguoiNhan ,		@DienThoai ,		@DaNhan ,
			          @TrangThai ,		@GhiChu ,			@NguoiTao ,
			          GETDATE() ,		1
			
			SELECT @BaoGiaId = SCOPE_IDENTITY()
			SELECT @BaoGiaId AS BaoGiaIdI

			--- insert line

			INSERT dbo.KDBaoGiaChiTiet
			        ( BaoGiaId ,	HangHoaId ,		SoLuong ,
			          DonGia ,		NgayBao ,		NgayNhan
			        )
			SELECT @BaoGiaId ,		HangHoaId ,		SoLuong ,
			       DonGia ,			NgayBao ,		NgayNhan
			FROM @MyTableType_BaoGiaChiTiet

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
