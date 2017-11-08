ALTER proc [dbo].[sp_HopDong_InsertHopDong]
	@SoHopDong NVARCHAR(100),
	@NgayHopDong DATETIME,
	@TenNhaThau NVARCHAR(200),
	@DaiDien VARCHAR(200),
	@GiaTriHopDong NUMERIC(18,4),
	@NoiDung NVARCHAR(1000),
	@FileDinhKem NVARCHAR(500),
	@CoSoId INT,
	@NguoiTao NVARCHAR(100)

as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.HopDong
			        ( SoHopDong ,		NgayHopDong ,			TenNhaThau ,
			          DaiDien ,			GiaTriHopDong ,			NoiDung ,
			          FileDinhKem ,		CoSoId ,				NgayTao ,	
					  NguoiTao ,		CtrVersion
			        )
			SELECT @SoHopDong,			@NgayHopDong,			@TenNhaThau,
				   @DaiDien,			@GiaTriHopDong,			@NoiDung,
				   @FileDinhKem,		@CoSoId,				GETDATE(),
				   @NguoiTao,			1

			SELECT SCOPE_IDENTITY() AS HopDongIdI

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
