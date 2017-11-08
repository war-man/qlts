ALTER proc [dbo].[sp_GhiGiam_InsertGhiGiamChiTiet]
	@GhiGiamId int
	,@TaiSanId int
	,@PhongBanId int
	,@NhanVienId int
	,@XuLyId INT
	,@SoLuong NUMERIC(18,4) 
as
BEGIN
	Declare @ErrMsg nvarchar(max),@V_CHOTNAM INT,@NamGhiGiam int ;
	SELECT @NamGhiGiam  = YEAR(NgayGhiGiam) from GhiGiam where GhiGiamId=@GhiGiamId;
	SELECT @V_CHOTNAM = TrangThai FROM dbo.KhoaSoLieu WHERE Nam = @NamGhiGiam
	-- check chốt năm
		IF (@V_CHOTNAM = 1)
	BEGIN
		RAISERROR ('Số liệu đã khóa !', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );  RETURN
	END

	BEGIN TRAN
		
		BEGIN TRY
		Declare @SoLuongTon NUMERIC(18,4) ; 
		SET @SoLuongTon = (select Isnull((SLTon + SLTang - SLGiam),0)  from TheoDoi  where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId);
		IF(@SoLuongTon >= @SoLuong)	
		BEGIN
			Insert into GhiGiamChiTiet (GhiGiamId,TaiSanId,PhongBanId,NhanVienId,XuLyId,SoLuong) values (@GhiGiamId , @TaiSanId , @PhongBanId , @NhanVienId, @XuLyId, @SoLuong) 
			Update TheoDoi set SLGiam = (SLGiam + @SoLuong) where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId and Nam = @NamGhiGiam
			select * from  GhiGiamChiTiet where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId
		END
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
