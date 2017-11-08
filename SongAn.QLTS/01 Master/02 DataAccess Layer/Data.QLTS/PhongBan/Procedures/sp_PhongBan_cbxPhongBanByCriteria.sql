USE [QLTS]
GO

ALTER PROC [dbo].[sp_PhongBan_cbxPhongBanByCriteria]
( 
	 @CoSoId	        nvarchar(500)	= null
	,@NhanVienId	    nvarchar(500)	= null
	,@Search			nvarchar(500)   = null
	,@PhongBanId		nvarchar(500)   = null
	,@FunctionCode		nvarchar(500)   = null
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
DECLARE		 @_COSO_IDS		VARCHAR(MAX)	=	NULL
			,@V_ISVIEW		VARCHAR(MAX)	=	NULL
			,@V_PHONGBAN_ID	VARCHAR(MAX)	=	NULL

SET @PhongBanId = ISNULL(@PhongBanId, '')
IF @PhongBanId = ''
	SET @PhongBanId = '0'

-- KIỂM TRA QUYỀN VIEW
EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
	@NHAN_VIEN_ID = @NhanVienId,
	@CO_SO_ID = @CoSoId,
	@CHUC_NANG = @FunctionCode,
	@QUYEN=@V_ISVIEW OUTPUT
PRINT CONCAT('@V_ISVIEW = ',@V_ISVIEW)
--/ KIỂM TRA QUYỀN VIEW

-- DANH SÁCH CƠ SỞ TRƯC THUỘC
EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	@COSOID=@CoSoId
	,@COSOID_OUT=@_COSO_IDS OUTPUT
SET @_COSO_IDS = REPLACE(@_COSO_IDS,',','|')
PRINT CONCAT('@_COSO_IDS = ',@_COSO_IDS)
--/ DANH SÁCH CƠ SỞ TRƯC THUỘC

SELECT		*
FROM		PhongBan PB
WHERE		(		(@V_ISVIEW = 'VA')
				OR	(@V_ISVIEW = 'VB' AND CHARINDEX('|' + CAST(PB.CoSoId AS VARCHAR(10)) + '|', '|' + @_COSO_IDS + '|') > 0)
				OR	(@V_ISVIEW IN ('VR','VE') AND  EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE CHARINDEX(',' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + ',', ',' + CAST(pb.PhongBanId AS VARCHAR(10)) + ',') > 0))
			)
			AND (@PhongBanId = '0' OR CHARINDEX('|' + CAST(PB.PhongBanId AS VARCHAR(10)) + '|', '|' + @PhongBanId + '|') > 0)
-----------------------------------------------------
SET NOCOUNT OFF
END

