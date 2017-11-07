/**************************************************
1. Create Date	: 2017.11.07
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_Home_ThongKeTaiSan]
						 @COSO_ID				=	1
						,@NHANVIEN_ID			=	6

						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.11.07 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_Home_ThongKeTaiSan]
	 @COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------

declare @V_TRANS_NAME varchar(max) = null
	,@V_Nam varchar(4) = null
	,@O_TongTaiSan numeric(18,4) = null
	,@O_GhiTang numeric(18,4) = null
	,@O_GhiGiam numeric(18,4) = null
	,@O_DieuChuyen numeric(18,4) = null

BEGIN TRY

set @MESSAGE = ''

EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@NHANVIEN_ID,@NAM=@V_Nam OUTPUT;

print concat('@Nam = ' , @V_Nam)

-- tính tổng tài sản

select @O_TongTaiSan = sum(td.SLTon + td.SLTang - td.SLGiam)
from TheoDoi td
	left join TaiSan ts on td.TaiSanId = ts.TaiSanId
where td.Nam = @V_Nam
	and ts.CoSoId = @COSO_ID
group by td.Nam
having  sum(td.SLTon + td.SLTang - td.SLGiam) > 0

-- tính ghi tăng

select @O_GhiTang = sum(gtct.SoLuong)
from GhiTangChiTiet gtct
	left join GhiTang gt on gtct.GhiTangId = gt.GhiTangId
where year(gt.NgayGhiTang) = @V_Nam
	and gt.CoSoId = @COSO_ID

-- tính ghi giảm

select @O_GhiGiam = sum(ggct.SoLuong)
from GhiGiamChiTiet ggct
	left join GhiGiam gg on ggct.GhiGiamId = gg.GhiGiamId
where year(gg.NgayGhiGiam) = @V_Nam
	and gg.CoSoId = @COSO_ID

-- tính điều chuyển

select @O_DieuChuyen = sum(dcct.SoLuong)
from DieuChuyenChiTiet dcct
	left join DieuChuyen dc on dcct.DieuChuyenId = dc.DieuChuyenId
where year(dc.NgayDieuChuyen) = @V_Nam
	and dc.CoSoId = @COSO_ID

END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME
	
	DECLARE  @ErrorMessage	NVARCHAR(MAX)	=	ERROR_MESSAGE()
			,@ErrorSeverity INT				=	ERROR_SEVERITY()
			,@ErrorState	INT				=	ERROR_STATE()

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH

select @O_TongTaiSan TongTaiSan
	,@O_GhiTang GhiTang
	,@O_GhiGiam GhiGiam
	,@O_DieuChuyen DieuChuyen

--------------------------------------------------
	SET NOCOUNT OFF;
END
