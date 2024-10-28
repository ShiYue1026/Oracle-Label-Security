-- INSERT INTO PURCHASE RECORDS
CREATE OR REPLACE PROCEDURE PROJECT2.INSERT_PURCHASERECORDS (
    p_transactionid NUMBER,
    p_productid NUMBER,
    p_transactiondate DATE,
    p_quantity NUMBER,
    p_employeeid NUMBER,
    p_supplierid NUMBER
)
AS  
    v_level VARCHAR2(100) := 'C';
    v_compartment VARCHAR2(100) := 'CPR';
    v_group VARCHAR2(100) := 'EMP';     
    v_label VARCHAR2(100);
BEGIN

    -- 创建 OLS 标签
    v_label := CHAR_TO_LABEL('SUP_OLS_POL', v_level || ':' || v_compartment || ':' || v_group);

    -- 插入purchase record记录
    INSERT INTO PROJECT2.PURCHASERECORDS (
        TRANSACTIONID,
        PRODUCTID,
        TRANSACTIONDATE,
        QUANTITY,
        EMPLOYEEID,
        SUPPLIERID,
        OLS_COL
    ) VALUES (
        p_transactionid,
        p_productid,
        p_transactiondate,
        p_quantity,
        p_employeeid,
        p_supplierid,
        v_label
    );

END;
/


BEGIN
    PROJECT2.INSERT_PURCHASERECORDS(
        p_transactionid => 1, 
        p_productid => 1, 
        p_transactiondate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_quantity => 111,
        p_employeeid => 4,
        p_supplierid => 1
    );
    PROJECT2.INSERT_PURCHASERECORDS(
        p_transactionid => 2, 
        p_productid => 2, 
        p_transactiondate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_quantity => 222,
        p_employeeid => 4,
        p_supplierid => 2
    );
END;
/