-- INSERT INTO CUSTOMERS
CREATE OR REPLACE PROCEDURE PROJECT2.INSERT_CUSTOMERS (
    p_customerid NUMBER,
    p_username VARCHAR2,
    p_firstname VARCHAR2,
    p_lastname VARCHAR2,
    p_contactname VARCHAR2,
    p_address VARCHAR2,
    p_postalcode VARCHAR2,
    p_phone VARCHAR2,
    p_email VARCHAR2
)
AS  
    v_role VARCHAR2(100);
    v_level VARCHAR2(100) := 'P';
    v_compartment VARCHAR2(100) := 'CCC';
    v_group VARCHAR2(100) := 'EMP';     
    v_label VARCHAR2(100);
BEGIN

    -- 检查用户是否已存在
    SELECT role INTO v_role
    FROM PROJECT2.USER_ROLES
    WHERE username = UPPER(p_username);

    -- 如果用户不存在
    IF v_role IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('User does not exists. Create user first!');
        RETURN;
    END IF;

    -- 创建 OLS 标签
    v_label := CHAR_TO_LABEL('SUP_OLS_POL', v_level || ':' || v_compartment || ':' || v_group);

    -- 插入新顾客记录
    INSERT INTO PROJECT2.CUSTOMERS (
        CUSTOMERID,
        USERNAME,
        FIRSTNAME,
        LASTNAME,
        CONTACTNAME,
        ADDRESS,
        POSTALCODE,
        PHONE,
        EMAIL,
        OLS_COL
    ) VALUES (
        p_customerid,
        p_username,
        p_firstname,
        p_lastname,
        p_contactname,
        p_address,
        p_postalcode,
        p_phone,
        p_email,
        v_label
    );

END;
/

BEGIN
    PROJECT2.INSERT_CUSTOMERS(
        p_customerid => 1,
        p_username => 'FRANK',
        p_firstname => 'Frank',
        p_lastname => 'Wang',
        p_contactname => 'ContactName1',
        p_address => 'address_Frank',
        p_postalcode => 'postal_Frank',
        p_phone => 'phone_Frank',
        p_email => 'email_Frank'
    );
END;
/