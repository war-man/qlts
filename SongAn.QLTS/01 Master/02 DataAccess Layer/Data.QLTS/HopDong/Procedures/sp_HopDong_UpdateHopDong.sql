ALTER proc [dbo].[sp_HopDong_UpdateHopDong]
	@HopDongId INT,
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
			
			UPDATE dbo.HopDong
			SET 
				NgayHopDong = @NgayHopDong,
				TenNhaThau = @TenNhaThau,
				DaiDien = @DaiDien,
				GiaTriHopDong = @GiaTriHopDong,
				NoiDung = @NoiDung,
				FileDinhKem = @FileDinhKem,
				NguoiTao = @NguoiTao,
				CtrVersion = CtrVersion + 1
			WHERE HopDongId = @HopDongId
			
			SELECT * FROM dbo.HopDong WHERE HopDongId = @HopDongId

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
