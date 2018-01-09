
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_ChiTieu_UpdateChiTieuById]    Script Date: 12/19/2017 9:46:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- drop proc sp_KD_ChiTieu_UpdateChiTieuById
ALTER proc [dbo].[sp_KD_ChiTieu_UpdateChiTieuById]
	@ChiTieuId INT,
	@Nam VARCHAR(20) ,
	@NguoiTao INT,
	@UserId NVARCHAR(10),
    @MyTableType_ChiTieuChiTiet MyTableType_ChiTieuChiTiet READONLY
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY

			-- update header
			UPDATE [dbo].[KDChiTieu]
			   SET Nam = @Nam,
				   [CtrVersion] = [CtrVersion] + 1
			WHERE ChiTieuId = @ChiTieuId

			DELETE dbo.KDChiTieuChiTiet WHERE ChiTieuId = @ChiTieuId

			--- insert line

			INSERT dbo.KDChiTieuChiTiet
			        ( ChiTieuId ,		NhanVienId ,		Thang1 ,
			          Thang2 ,			Thang3 ,			Thang4 ,
			          Thang5 ,			Thang6 ,			Thang7 ,
			          Thang8 ,			Thang9 ,			Thang10 ,
			          Thang11,			Thang12 ,			NgayCapNhat
			        )
			
			SELECT	@ChiTieuId ,		NhanVienId ,		Thang1 ,
			          Thang2 ,			Thang3 ,			Thang4 ,
			          Thang5 ,			Thang6 ,			Thang7 ,
			          Thang8 ,			Thang9 ,			Thang10 ,
			          Thang11,			Thang12 ,			NgayCapNhat
			FROM @MyTableType_ChiTieuChiTiet

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
