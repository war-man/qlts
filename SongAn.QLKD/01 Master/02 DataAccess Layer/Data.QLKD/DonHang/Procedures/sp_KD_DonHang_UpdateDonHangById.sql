USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_DonHang_UpdateDonHangById]    Script Date: 12/19/2017 9:52:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[sp_KD_DonHang_UpdateDonHangById]
	@DonHangId INT,
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

	BEGIN TRAN
		
		BEGIN TRY

			-- update header
			UPDATE [dbo].[KDDonHang]
			   SET [SoPhieu] = @SoPhieu, 
				   [TenDonHang] = @TenDonHang, 
				   [NgayLap] = @NgayLap, 
				   [KhachHangId] = @KhachHangId, 
				   [LyDo] = @LyDo, 
				   [HopDongId] = @HopDongId, 
				   [NhanVienId] = @NhanVienId,
				   diachinhan = @DiaChiNhan,
				   [BoPhanNhan] = @BoPhanNhan,
				   [NguoiNhan] = @NguoiNhan, 
				   [GhiChu] = @GhiChu,
				   [TrangThai] = @TrangThai,
				   [NgayDuyet] = @NgayDuyet, 
				   --[NguoiTao] = @NguoiTao,
				   [CtrVersion] = [CtrVersion] + 1
			WHERE DonHangId = @DonHangId

			DELETE dbo.KDDonHangChiTiet WHERE DonHangId = @DonHangId

			--- insert line

			INSERT dbo.KDDonHangChiTiet
			        ( DonHangId ,		HangHoaId ,			SoLuong ,
			          DonGia ,			NgayYeuCau ,		NgayNhanHang
			        )
			SELECT	@DonHangId ,		HangHoaId ,			SoLuong ,
			        DonGia ,			NgayYeuCau ,		NgayNhanHang
			FROM @MyTableType_DonHangChiTiet

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
