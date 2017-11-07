/**************************************************
1. Create Date	: 2017.11.07
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_Home_GetListThongBao]
						 @COSO_ID				=	1
						,@NHANVIEN_ID			=	6

						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.11.07 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_Home_GetListThongBao]
	 @COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------

declare @V_TRANS_NAME varchar(max) = null

BEGIN TRY

set @MESSAGE = ''

select top 10 *
	,(case 
		--when datediff(year,NgayTao,GETDATE()) between 1 and 2 then concat(datediff(year,NgayTao,GETDATE()),N' năm trước')
		--when datediff(MONTH,NgayTao,GETDATE()) between 1 and 12 then concat(datediff(MONTH,NgayTao,GETDATE()),N' tháng trước')
		when datediff(day,NgayTao,GETDATE()) between 1 and 3 then concat(datediff(day,NgayTao,GETDATE()),N' ngày trước')
		when datediff(HOUR,NgayTao,GETDATE()) between 1 and 23 then concat(datediff(HOUR,NgayTao,GETDATE()),N' giờ trước')
		when datediff(minute,NgayTao,GETDATE()) between 1 and 59 then concat(datediff(minute,NgayTao,GETDATE()),N' phút trước')
		when datediff(SECOND,NgayTao,GETDATE()) between 0 and 59 then concat(datediff(SECOND,NgayTao,GETDATE()),N' giây trước')
		else ''
	end) Label
	,(case
		WHEN TenThongBao = N'Duyệt đề nghị trang cấp' THEN 'DeNghi'
		WHEN TenThongBao = N'Duyệt báo cáo' THEN 'BaoCao'
		WHEN TenThongBao = N'Duyệt kế hoạch mua sắm' THEN 'MuaSam'
	end) Loai
from ThongBao
order by NgayTao desc

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
--------------------------------------------------
	SET NOCOUNT OFF;
END
