CREATE OR REPLACE PROCEDURE PROJECT2.INSERT_PRODUCTS (
    p_productid NUMBER,
    p_productname VARCHAR2,
    p_categoryid NUMBER,
    p_unitprice NUMBER,
    p_unitsinstock NUMBER
)
AS  
    v_level VARCHAR2(100) := 'P';
    v_compartment VARCHAR2(100) := 'CP';
    v_group VARCHAR2(100) := 'EMP,CUST';     
    v_label VARCHAR2(100);
BEGIN
    -- 创建 OLS 标签
    v_label := CHAR_TO_LABEL('SUP_OLS_POL', v_level || ':' || v_compartment || ':' || v_group);

    -- 插入product记录
    INSERT INTO PROJECT2.PRODUCTS (
        PRODUCTID,
        PRODUCTNAME,
        CATEGORYID,
        UNITPRICE,
        UNITSINSTOCK,
        OLS_COL
    ) VALUES (
        p_productid,
        p_productname,
        p_categoryid,
        p_unitprice,
        p_unitsinstock,
        v_label
    );

END;
/

BEGIN
    PROJECT2.INSERT_PRODUCTS(
        p_productid => 1, 
        p_productname => 'Product1', 
        p_categoryid => 1,
        p_unitprice => 11,
        p_unitsinstock => 111
    );
    PROJECT2.INSERT_PRODUCTS(
        p_productid => 2, 
        p_productname => 'Product2', 
        p_categoryid => 2,
        p_unitprice => 22,
        p_unitsinstock => 222
    );
    PROJECT2.INSERT_PRODUCTS(
        p_productid => 3, 
        p_productname => 'Product3', 
        p_categoryid => 2,
        p_unitprice => 33,
        p_unitsinstock => 333
    );
END;
/