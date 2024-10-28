-- INSERT INTO SALE DETAIL
CREATE OR REPLACE PROCEDURE PROJECT2.INSERT_SALEDETAILS (
    p_saledetailid NUMBER,
    p_saleid NUMBER,
    p_productid NUMBER,
    p_unitprice NUMBER,
    p_quantity NUMBER,
    p_discount NUMBER
)
AS  
    v_level VARCHAR2(100) := 'C';
    v_compartment VARCHAR2(100) := 'CSD';
    v_group VARCHAR2(100) := 'EMP';     
    v_label VARCHAR2(100);
BEGIN

    -- 创建 OLS 标签
    v_label := CHAR_TO_LABEL('SUP_OLS_POL', v_level || ':' || v_compartment || ':' || v_group);

    -- 插入sale记录
    INSERT INTO PROJECT2.SALEDETAILS (
        SALEDETAILID,
        SALEID,
        PRODUCTID,
        UNITPRICE,
        QUANTITY,
        DISCOUNT,
        OLS_COL
    ) VALUES (
        p_saledetailid,
        p_saleid,
        p_productid,
        p_unitprice,
        p_quantity,
        p_discount,
        v_label
    );

END;
/


BEGIN
    PROJECT2.INSERT_SALEDETAILS(
        p_saledetailid => 1,
        p_saleid => 1, 
        p_productid => 1, 
        p_unitprice => 11,
        p_quantity => 111,
        p_discount => 0
    );
END;
/