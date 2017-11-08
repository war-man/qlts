ALTER PROCEDURE [dbo].[sp_HopDong_cbxHopDongById]
( 
	 @CoSoId	        nvarchar(500)	= null
	,@NhanVienId	    nvarchar(500)	= null
	,@Search			nvarchar(500)   = null
	,@HopDongId			NVARCHAR(500)   = null
	,@FunctionCode		nvarchar(500)   = null
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	DECLARE		 @_COSO_IDS		VARCHAR(MAX)	=	NULL
				,@V_ISVIEW		VARCHAR(MAX)	=	NULL
				,@V_PHONGBAN_ID	VARCHAR(MAX)	=	NULL

	SET @HopDongId = ISNULL(@HopDongId, '')
	IF @HopDongId = ''
		SET @HopDongId = '0'

	-- KIỂM TRA QUYỀN VIEW
	EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = @FunctionCode,
		@QUYEN=@V_ISVIEW OUTPUT

	--/ KIỂM TRA QUYỀN VIEW

	-- DANH SÁCH CƠ SỞ TRƯC THUỘC
	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
		@COSOID=@CoSoId
		,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',','|')

	PRINT @V_ISVIEW
	SELECT		*
	FROM		dbo.HopDong HD
	WHERE		(		(@V_ISVIEW = 'VA')
					OR	(@V_ISVIEW = 'VB' AND CHARINDEX('|' + CAST(HD.CoSoId AS VARCHAR(10)) + '|', '|' + @_COSO_IDS + '|') > 0)
				)
				AND (@HopDongId = '0' OR HD.HopDongId = @HopDongId)
-----------------------------------------------------
SET NOCOUNT OFF
END

