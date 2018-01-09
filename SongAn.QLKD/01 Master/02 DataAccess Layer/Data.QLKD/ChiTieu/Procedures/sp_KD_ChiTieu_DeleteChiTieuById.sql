
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_ChiTieu_DeleteChiTieuById]    Script Date: 12/19/2017 9:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[sp_KD_ChiTieu_DeleteChiTieuById]
	@ChiTieuId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			DELETE dbo.KDChiTieuChiTiet WHERE ChiTieuId = @ChiTieuId
			DELETE dbo.KDChiTieu WHERE ChiTieuId = @ChiTieuId
			
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
