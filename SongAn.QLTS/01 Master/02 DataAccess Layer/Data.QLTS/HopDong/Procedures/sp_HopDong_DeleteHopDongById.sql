ALTER proc [dbo].[sp_HopDong_DeleteHopDongById]
	@HopDongId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			DELETE dbo.HopDong WHERE HopDongId = @HopDongId
			
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
