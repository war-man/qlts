
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_BaoGia_DeleteBaoGiaById]    Script Date: 12/19/2017 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[sp_KD_BaoGia_DeleteBaoGiaById]
	@BaoGiaId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			DELETE dbo.KDBaoGiaChiTiet WHERE BaoGiaId = @BaoGiaId
			DELETE dbo.KDBaoGia WHERE BaoGiaId = @BaoGiaId
			
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
