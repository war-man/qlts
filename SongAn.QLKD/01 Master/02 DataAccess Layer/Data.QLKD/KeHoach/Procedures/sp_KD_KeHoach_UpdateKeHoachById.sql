USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_KeHoach_UpdateKeHoachById]    Script Date: 12/19/2017 10:02:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[sp_KD_KeHoach_UpdateKeHoachById]
	@KeHoachId INT ,
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

	BEGIN TRAN
		
		BEGIN TRY
			
			UPDATE KDKeHoach 
			SET KyKeHoach = @KyKeHoach,
				Nam = @Nam,
				SoPhieu = @SoPhieu,
				KhachHangId= @KhachHangId,
				CtrVersion = CtrVersion + 1
			WHERE KeHoachId = @KeHoachId


			DELETE dbo.KDKeHoachChiTiet WHERE KeHoachId = @KeHoachId

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


			SELECT @@ROWCOUNT AS ID
		END TRY
		BEGIN CATCH
			select @ErrMsg=ERROR_MESSAGE()
			raiserror(@ErrMsg,16,1)
			begin try rollback tran end try begin catch end catch
			return 
		END CATCH
	COMMIT TRAN
END
