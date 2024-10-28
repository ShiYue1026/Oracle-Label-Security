-- INSERT INTO SALE
CREATE OR REPLACE PROCEDURE PROJECT2.INSERT_SALES (
    p_saleid NUMBER,
    p_customerid NUMBER,
    p_username VARCHAR,
    p_saledate DATE,
    p_totalamount NUMBER,
    p_paymentmethod VARCHAR
)
AS  
    v_role VARCHAR2(100);
    v_level VARCHAR2(100) := 'C';
    v_compartment VARCHAR2(100) := 'CSA';
    v_group VARCHAR2(100) := 'EMP, CUST';     
    v_label VARCHAR2(100);
BEGIN

    -- 查询用户是否存在
    BEGIN
        SELECT role INTO v_role
        FROM PROJECT2.USER_ROLES
        WHERE username = p_username;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('User does not exist. Cannot insert into sales table.');
            RETURN;
    END;


    -- 创建 OLS 标签
    v_label := CHAR_TO_LABEL('SUP_OLS_POL', v_level || ':' || v_compartment || ':' || v_group);

    -- 插入sale记录
    INSERT INTO PROJECT2.SALES (
        SALEID,
        CUSTOMERID,
        USERNAME,
        SALEDATE,
        TOTALAMOUNT,
        PAYMENTMETHOD,
        OLS_COL
    ) VALUES (
        p_saleid,
        p_customerid,
        p_username,
        p_saledate,
        p_totalamount,
        p_paymentmethod,
        v_label
    );

END;
/

BEGIN
    PROJECT2.INSERT_SALES(
        p_saleid => 1, 
        p_customerid => 1, 
        p_username => 'FRANK',
        p_saledate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_totalamount => 1234,
        p_paymentmethod => 'wechat'
    );
END;
/