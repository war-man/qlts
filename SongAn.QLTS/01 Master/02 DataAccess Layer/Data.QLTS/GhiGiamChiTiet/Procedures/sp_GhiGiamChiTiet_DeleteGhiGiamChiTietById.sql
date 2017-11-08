ALTER PROC [dbo].[sp_GhiGiamChiTiet_DeleteGhiGiamChiTietById]
( 
	 @GhiGiamChiTietId int
	,@TaiSanId int
	,@PhongBanId int
	,@NhanVienId int
	,@SoLuong NUMERIC(18,4) 
)
AS  
BEGIN
	Declare @ErrMsg nvarchar(max),@V_CHOTNAM INT,@NamGhiGiam INT,@CoSoId INT ;
	
	SELECT Top 1  @NamGhiGiam  = YEAR(NgayGhiGiam), @CoSoId = a.CoSoId from GhiGiam a inner join GhiGiamChiTiet b on a.GhiGiamId=b.GhiGiamId where b.GhiGiamChiTietId=@GhiGiamChiTietId;
	
	SELECT @V_CHOTNAM = TrangThai FROM dbo.KhoaSoLieu WHERE Nam = @NamGhiGiam
	
	-- check chốt năm
		IF (@V_CHOTNAM = 1)
	BEGIN
		SELECT -1 AS GhiGiamIdI RETURN
		
	END
	BEGIN TRAN
		
		BEGIN TRY
		Declare @SoLuongTon NUMERIC(18,4) ;
		print(@TaiSanId) 
		print(@PhongBanId) 
		print(@NhanVienId) 
		SET @SoLuongTon = (select Isnull((SLTon + SLTang - SLGiam),0)  from TheoDoi  where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId and Nam=@NamGhiGiam );
	
			Update TheoDoi set SLGiam = (SLGiam - @SoLuong) where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId and Nam = @NamGhiGiam
			delete GhiGiamChiTiet where GhiGiamChiTietId=@GhiGiamChiTietId
			select @@ROWCOUNT
	
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
	
END

