USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_NhomKhachHang_UpdateNhomKhachHangById]    Script Date: 12/19/2017 10:06:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[sp_KD_NhomKhachHang_UpdateNhomKhachHangById]
	@NhomKhachHangId varchar (20) ,
	@MaNhom varchar (20) ,
	@TenNhom varchar (20) ,
	@NguoiTao NVARCHAR(10) ,
	@UserId NVARCHAR(10) 
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			
			UPDATE dbo.KDNhomKhachHang
			SET MaNhom= @MaNhom,
				TenNhom = @TenNhom
			WHERE NhomKhachHangId = @NhomKhachHangId

			SELECT * FROM dbo.KDNhomKhachHang WHERE NhomKhachHangId = @NhomKhachHangId
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
