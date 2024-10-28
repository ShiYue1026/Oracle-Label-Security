-- INSERT INTO CATEGORIES
CREATE OR REPLACE PROCEDURE PROJECT2.INSERT_CATEGORIES (
    p_categoryid NUMBER,
    p_categoryname VARCHAR2,
    p_description CLOB
)
AS  
    v_level VARCHAR2(100) := 'P';
    v_compartment VARCHAR2(100) := 'CC';
    v_group VARCHAR2(100) := 'EMP,CUST';     
    v_label VARCHAR2(100);
BEGIN

    -- 创建 OLS 标签
    v_label := CHAR_TO_LABEL('SUP_OLS_POL', v_level || ':' || v_compartment || ':' || v_group);

    -- 插入category记录
    INSERT INTO PROJECT2.CATEGORIES (
        CATEGORYID,
        CATEGORYNAME,
        DESCRIPTION,
        OLS_COL
    ) VALUES (
        p_categoryid,
        p_categoryname,
        p_description,
        v_label
    );

END;
/

BEGIN
    PROJECT2.INSERT_CATEGORIES(
        p_categoryid => 1, 
        p_categoryname => 'Category1', 
        p_description => 'Category1 description' 
    );
    PROJECT2.INSERT_CATEGORIES(
        p_categoryid => 2, 
        p_categoryname => 'Category2', 
        p_description => 'Category2 description' 
    );
END;
/