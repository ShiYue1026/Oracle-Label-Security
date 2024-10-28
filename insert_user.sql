-- INSERT INTO USER_ROLES
CREATE OR REPLACE PROCEDURE PROJECT2.INSERT_USER(
    p_username VARCHAR2,
    p_password VARCHAR2,
    p_role VARCHAR2
)
AS
    v_level VARCHAR2(100);
    v_compartment VARCHAR2(100);
    v_group VARCHAR2(100);
    v_label VARCHAR2(100);
    v_count NUMBER;
BEGIN
    -- 检查用户是否已存在
    SELECT COUNT(*) INTO v_count
    FROM PROJECT2.USER_ROLES
    WHERE username = UPPER(p_username);

    -- 如果用户已存在
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('User already exists. Drop it first.');
        RETURN;
    END IF;

    -- 设置标签
    IF UPPER(p_role) = 'DBA' THEN
        v_level := 'TS';
        v_compartment := ''; 
        v_group := 'DBA';
    ELSIF UPPER(p_role) = 'CUSTOMER' THEN
        v_level := 'C';
        v_compartment := 'CCC'; 
        v_group := 'EMP';
    ELSE
        v_level := 'S';
        v_compartment := 'CE'; 
        v_group := 'EMP';
    END IF;

    v_label := CHAR_TO_LABEL('SUP_OLS_POL', v_level || ':' || v_compartment || ':' || v_group);

    -- 插入新用户到 USER_ROLES 表
    INSERT INTO PROJECT2.USER_ROLES (
        USERNAME,
        PASSWORD,
        ROLE,
        OLS_COL
    ) VALUES (
        UPPER(p_username),
        p_password,
        p_role,
        v_label
    );
END;
/


BEGIN
    PROJECT2.INSERT_USER(
        p_username => 'ALICE',
        p_password => 'alice',
        p_role => 'DBA'
    );

    PROJECT2.INSERT_USER(
        p_username => 'BOB',
        p_password => 'bob',
        p_role => 'HR'
    );

    PROJECT2.INSERT_USER(
        p_username => 'CATH',
        p_password => 'cath',
        p_role => 'CASHIER'
    );

    PROJECT2.INSERT_USER(
        p_username => 'DAVE',
        p_password => 'dave',
        p_role => 'BUYER'
    );

    PROJECT2.INSERT_USER(
        p_username => 'ETHAN',
        p_password => 'ethan',
        p_role => 'CUSTOMER SERVICE'
    );

    PROJECT2.INSERT_USER(
        p_username => 'FRANK',
        p_password => 'frank',
        p_role => 'CUSTOMER'
    );
END;
/

