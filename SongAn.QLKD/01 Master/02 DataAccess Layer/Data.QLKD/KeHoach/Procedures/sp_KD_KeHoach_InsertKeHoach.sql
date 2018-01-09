USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_KeHoach_InsertKeHoach]    Script Date: 12/19/2017 10:02:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[sp_KD_KeHoach_InsertKeHoach]
	@KyKeHoach VARCHAR(50) ,
	@Nam VARCHAR(4) ,
	@SoPhieu VARCHAR(50),
	@KhachHangId INT,
	@NguoiTao INT,
	@UserId NVARCHAR(10),
    @MyTableType_KeHoachChiTiet MyTableType_KeHoachChiTiet READONLY
as
BEGIN
	Declare @ErrMsg nvarchar(max)
	DECLARE @KeHoachId INT
	SET @KeHoachId = 0

	BEGIN TRAN
		
		BEGIN TRY

			-- insert header
			INSERT dbo.KDKeHoach
			        ( KyKeHoach ,		Nam ,		SoPhieu ,
			          KhachHangId ,		NguoiTao ,	NgayTao ,
			          CtrVersion
			        )
			SELECT  @KyKeHoach ,	@Nam ,		@SoPhieu ,
					@KhachHangId ,	@NguoiTao ,	GETDATE() ,
					1
			
			SELECT @KeHoachId = SCOPE_IDENTITY()
			SELECT @KeHoachId AS KeHoachIdI

			--- insert line

			INSERT dbo.KDKeHoachChiTiet
			        ( KeHoachId ,		HangHoaId ,			LoaiHangHoa ,
			          SoLuong ,			DonGia ,			NgayDuKien ,
			          TrangThai ,		NgayTao
			        )
			SELECT	@KeHoachId ,		HangHoaId ,			LoaiHangHoa ,
			        SoLuong ,			DonGia ,			NgayDuKien ,
			        TrangThai ,			GETDATE()
			FROM @MyTableType_KeHoachChiTiet

		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
