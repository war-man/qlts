
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_BaoGia_UpdateBaoGiaById]    Script Date: 12/19/2017 9:45:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[sp_KD_BaoGia_UpdateBaoGiaById]
	@BaoGiaId INT,
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

	BEGIN TRAN
		
		BEGIN TRY

			-- update header
			UPDATE [dbo].[KDBaoGia]
			   SET [SoPhieu] = @SoPhieu, 
				   [TenBaoGia] = @TenBaoGia, 
				   [NgayBaoGia] = @NgayBaoGia, 
				   [NhanVienId] = @NhanVienId, 
				   [KhachHangId] = @KhachHangId, 
				   [LyDo] = @LyDo,
				   [NguoiNhan] = @NguoiNhan, 
				   [DienThoai] = @DienThoai,
				   [DaNhan] = @DaNhan,
				   [TrangThai] = @TrangThai, 
				   [GhiChu] = @GhiChu, 
				   [NguoiTao] = @NguoiTao,
				   --[NgayTao] = @NgayTao, 
				   [CtrVersion] = CtrVersion + 1
			WHERE BaoGiaId = @BaoGiaId

			DELETE dbo.KDBaoGiaChiTiet WHERE BaoGiaId = @BaoGiaId

			--- insert line

			INSERT dbo.KDBaoGiaChiTiet
			        ( BaoGiaId ,	HangHoaId ,		SoLuong ,
			          DonGia ,		NgayBao ,		NgayNhan
			        )
			SELECT @BaoGiaId ,		HangHoaId ,		SoLuong ,
			       DonGia ,			NgayBao ,		NgayNhan
			FROM @MyTableType_BaoGiaChiTiet

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
