
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_DieuPhoi_InsertDieuPhoi]    Script Date: 12/19/2017 9:49:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[sp_KD_DieuPhoi_InsertDieuPhoi]
	@DonHangId int ,
	@NgayDieuPhoi datetime  ,
	@NhanVienDieuPhoi int  ,
	@NguoiTao INT,
	@UserId NVARCHAR(10),
    @MyTableType_DieuPhoiChiTiet MyTableType_DieuPhoiChiTiet READONLY
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	DECLARE @DieuPhoiId INT
	SET @DieuPhoiId = 0

	BEGIN TRAN
		
		BEGIN TRY

			-- insert header
			INSERT dbo.KDDieuPhoi
			        ( DonHangId ,		NgayDieuPhoi ,		NhanVienDieuPhoi ,
			          NguoiTao ,		NgayTao ,			CtrVersion
			        )
			SELECT @DonHangId,			@NgayDieuPhoi,		@NhanVienDieuPhoi,
					@NguoiTao,			GETDATE(),			1

			SELECT @DieuPhoiId = SCOPE_IDENTITY()
			SELECT @DieuPhoiId AS DieuPhoiIdI

			--- insert line

			INSERT dbo.KDDieuPhoiChiTiet
			        ( DieuPhoiId ,		HangHoaId ,			NhanVienId ,
			          KhachHangId ,		DaChuyen ,			NguoiChuyen ,
			          DiaChiGui ,		DiaChiNhan ,		NguoiNhan ,
			          NgayNhan ,		TrangThai
			        )
			SELECT	@DieuPhoiId ,		HangHoaId ,			NhanVienId ,
			          KhachHangId ,		DaChuyen ,			NguoiChuyen ,
			          DiaChiGui ,		DiaChiNhan ,		NguoiNhan ,
			          NgayNhan ,		TrangThai
			FROM @MyTableType_DieuPhoiChiTiet

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
