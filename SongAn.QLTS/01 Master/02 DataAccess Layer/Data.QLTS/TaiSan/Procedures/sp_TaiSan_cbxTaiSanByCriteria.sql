/**************************************************
1. Create Date	: 2017.09.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_cbxTaiSanByCriteria]
						 @Search			=	N''
						,@TaiSanId			=	N''
						,@MaTaiSan			=	N''
						,@CoSoId			=	16
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TaiSan_cbxTaiSanByCriteria]
( 
	 @Search			NVARCHAR(500)   =	NULL
	,@TaiSanId			NVARCHAR(500)	=	NULL
	,@MaTaiSan			NVARCHAR(500)   =	NULL
	,@LoaiKeKhai		NVARCHAR(500)   =	NULL
	,@CoSoId	        NVARCHAR(500)	=	NULL
	,@NhanVienId	    NVARCHAR(500)	=	NULL
	
)
AS  
BEGIN
SET NOCOUNT ON
--------------------------------------------------
	DECLARE  @V_DELIMITER	VARCHAR(10)		=	'|'
			,@_COSO_IDS		VARCHAR(MAX)	=	NULL

	SET @Search = ISNULL(@Search,'')
	SET @TaiSanId = ISNULL(@TaiSanId, '')
	SET @MaTaiSan = ISNULL(@MaTaiSan,'')
	SET @LoaiKeKhai = ISNULL(@LoaiKeKhai,'')

	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
	PRINT concat('@_COSO_IDS=',@_COSO_IDS)

	SELECT		TS.*,ISNULL(NG.NguyenGia,0) NguyenGia
	FROM		(	SELECT		TOP 10 _TS.TaiSanId, ISNULL(SUM(_NG.GiaTri),0) NguyenGia
					FROM		TaiSan _TS 
								LEFT JOIN NguyenGia _NG ON _TS.TaiSanId = _NG.TaiSanId
					WHERE		CHARINDEX(@V_DELIMITER + CAST(_TS.CoSoId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @_COSO_IDS + @V_DELIMITER) > 0
								AND (@Search = '' OR _TS.MaTaiSan LIKE N'%' + @Search + '%' OR _TS.TenTaiSan LIKE N'%' + @Search + '%')
								AND (@TaiSanId = '' OR CHARINDEX(@V_DELIMITER + CAST(_TS.TaiSanId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @TaiSanId + @V_DELIMITER) > 0)
								AND (@MaTaiSan = '' OR CHARINDEX(@V_DELIMITER + _TS.MaTaiSan + @V_DELIMITER,@V_DELIMITER + @MaTaiSan + @V_DELIMITER) > 0)
								AND (@LoaiKeKhai = '' OR CHARINDEX(@V_DELIMITER + CAST(_TS.LoaiKeKhai AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @LoaiKeKhai + @V_DELIMITER) > 0)
					GROUP BY	_TS.TaiSanId
				) NG
				LEFT JOIN TaiSan TS ON  TS.TaiSanId = NG.TaiSanId
--------------------------------------------------
SET NOCOUNT OFF
END

