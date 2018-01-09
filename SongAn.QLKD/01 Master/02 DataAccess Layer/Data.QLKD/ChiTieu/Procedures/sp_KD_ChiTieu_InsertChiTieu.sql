
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_ChiTieu_InsertChiTieu]    Script Date: 12/19/2017 9:46:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- drop proc sp_KD_ChiTieu_InsertChiTieu
ALTER proc [dbo].[sp_KD_ChiTieu_InsertChiTieu]
	@Nam VARCHAR(20) ,
	@NguoiTao INT,
	@UserId NVARCHAR(10),
    @MyTableType_ChiTieuChiTiet MyTableType_ChiTieuChiTiet READONLY
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	DECLARE @ChiTieuId INT
	SET @ChiTieuId = 0

	BEGIN TRAN
		
		BEGIN TRY

			-- insert header
			INSERT dbo.KDChiTieu( Nam, NguoiTao, NgayTao, CtrVersion )
			SELECT @Nam, @NguoiTao, GETDATE(), 1        
			
			SELECT @ChiTieuId = SCOPE_IDENTITY()
			SELECT @ChiTieuId AS ChiTieuIdI

			--- insert line

			INSERT dbo.KDChiTieuChiTiet
			        ( ChiTieuId ,		NhanVienId ,		Thang1 ,
			          Thang2 ,			Thang3 ,			Thang4 ,
			          Thang5 ,			Thang6 ,			Thang7 ,
			          Thang8 ,			Thang9 ,			Thang10 ,
			          Thang11,			Thang12 ,			NgayCapNhat
			        )
			
			SELECT	@ChiTieuId ,		NhanVienId ,		Thang1 ,
			          Thang2 ,			Thang3 ,			Thang4 ,
			          Thang5 ,			Thang6 ,			Thang7 ,
			          Thang8 ,			Thang9 ,			Thang10 ,
			          Thang11,			Thang12 ,			NgayCapNhat
			FROM @MyTableType_ChiTieuChiTiet

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
