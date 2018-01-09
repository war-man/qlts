USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_NhomKhachHang_InsertNhomKhachHangById]    Script Date: 12/19/2017 10:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[sp_KD_NhomKhachHang_InsertNhomKhachHangById]
	
	@MaNhom varchar (20) ,
	@TenNhom varchar (20) ,
	@NguoiTao NVARCHAR(10) ,
	@UserId NVARCHAR(10) 
as
BEGIN
	Declare @ErrMsg nvarchar(max)

	BEGIN TRAN
		
		BEGIN TRY
			
			INSERT dbo.KDNhomKhachHang( MaNhom ,	TenNhom ,	NguoiTao ,	NgayTao ,	CtrVersion)
			SELECT @MaNhom, @TenNhom, @NguoiTao, GETDATE(), 1

			SELECT SCOPE_IDENTITY() AS NhomKhachHangIdI
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
