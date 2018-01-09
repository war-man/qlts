USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_KeHoach_DeleteKeHoachById]    Script Date: 12/19/2017 10:02:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[sp_KD_KeHoach_DeleteKeHoachById]
	@KeHoachId INT
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			DELETE dbo.KDKeHoachChiTiet WHERE KeHoachId = @KeHoachId
			DELETE dbo.KDKeHoach WHERE KeHoachId = @KeHoachId
			
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
