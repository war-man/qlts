
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_DieuPhoi_UpdateDieuPhoiById]    Script Date: 12/19/2017 9:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[sp_KD_DieuPhoi_UpdateDieuPhoiById]
	@DieuPhoiId INT,
	@DonHangId int ,
	@NgayDieuPhoi datetime  ,
	@NhanVienDieuPhoi int  ,
	@NguoiTao INT,
	@UserId NVARCHAR(10),
    @MyTableType_DieuPhoiChiTiet MyTableType_DieuPhoiChiTiet READONLY
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY

			-- update header
			UPDATE [dbo].[KDDieuPhoi]
			SET [DonHangId] = @DonHangId, 
				[NgayDieuPhoi] = @NgayDieuPhoi, 
				[NhanVienDieuPhoi] = @NhanVienDieuPhoi,
				[NguoiTao] = @NguoiTao,
				--[NgayTao] = @NgayTao, 
				[CtrVersion] = [CtrVersion] + 1
			WHERE DieuPhoiId = @DieuPhoiId

			DELETE dbo.KDDieuPhoiChiTiet WHERE DieuPhoiId = @DieuPhoiId

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
