-- INSERT INTO EMPLOYEES
CREATE OR REPLACE PROCEDURE PROJECT2.INSERT_EMPLOYEES (
    p_employeeid NUMBER,
    p_username VARCHAR2,
    p_firstname VARCHAR2,
    p_lastname VARCHAR2,
    p_birthdate DATE,
    p_hiredate DATE,
    p_address VARCHAR2,
    p_postalcode VARCHAR2,
    p_phone VARCHAR2,
    p_email VARCHAR2
)
AS  
    v_role VARCHAR2(100);
    v_level VARCHAR2(100);
    v_compartment VARCHAR2(100) := 'CE';
    v_group VARCHAR2(100) := 'Emp';     
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

    -- 设置不同角色对应的等级
    IF UPPER(v_role) = 'DBA' THEN
        v_level := 'TS';
    ELSIF UPPER(v_role) = 'HR' THEN
        v_level := 'S';
    ELSE
        v_level := 'C';
    END IF;

    -- 创建 OLS 标签
    v_label := CHAR_TO_LABEL('SUP_OLS_POL', v_level || ':' || v_compartment || ':' || v_group);

    -- 插入新员工记录
    INSERT INTO PROJECT2.EMPLOYEES (
        EMPLOYEEID,
        USERNAME,
        FIRSTNAME,
        LASTNAME,
        BIRTHDATE,
        HIREDATE, 
        ADDRESS,
        POSTALCODE,
        PHONE,
        EMAIL,
        OLS_COL
    ) VALUES (
        p_employeeid,
        p_username,
        p_firstname,
        p_lastname,
        p_birthdate,
        p_hiredate, 
        p_address,
        p_postalcode,
        p_phone,
        p_email,
        v_label
    );
END;
/

BEGIN
    PROJECT2.INSERT_EMPLOYEES(
        p_employeeid => 1,
        p_username => 'ALICE',
        p_firstname => 'Alice',
        p_lastname => 'Wang',
        p_birthdate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_hiredate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
        p_address => 'address_Alice',
        p_postalcode => 'postal_Alice',
        p_phone => 'phone_Alice',
        p_email => 'email_Alice'
    );

    PROJECT2.INSERT_EMPLOYEES(
        p_employeeid => 2,
        p_username => 'BOB',
        p_firstname => 'Bob',
        p_lastname => 'Wang',
        p_birthdate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_hiredate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
        p_address => 'address_Bob',
        p_postalcode => 'postal_Bob',
        p_phone => 'phone_Bob',
        p_email => 'email_Bob'
    );

    PROJECT2.INSERT_EMPLOYEES(
        p_employeeid => 3,
        p_username => 'CATH',
        p_firstname => 'Cath',
        p_lastname => 'Wang',
        p_birthdate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_hiredate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
        p_address => 'address_Cath',
        p_postalcode => 'postal_Cath',
        p_phone => 'phone_Cath',
        p_email => 'email_Cath'
    );

    PROJECT2.INSERT_EMPLOYEES(
        p_employeeid => 4,
        p_username => 'DAVE',
        p_firstname => 'Dave',
        p_lastname => 'Wang',
        p_birthdate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_hiredate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
        p_address => 'address_Dave',
        p_postalcode => 'postal_Dave',
        p_phone => 'phone_Dave',
        p_email => 'email_Dave'
    );

    PROJECT2.INSERT_EMPLOYEES(
        p_employeeid => 5,
        p_username => 'ETHAN',
        p_firstname => 'Ethan',
        p_lastname => 'Wang',
        p_birthdate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_hiredate => TO_DATE('2000-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
        p_address => 'address_Ethan',
        p_postalcode => 'postal_Ethan',
        p_phone => 'phone_Ethan',
        p_email => 'email_Ethan'
    );
END;
/
