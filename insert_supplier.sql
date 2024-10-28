-- INSERT INTO SUPPLIERS
CREATE OR REPLACE PROCEDURE PROJECT2.INSERT_SUPPLIERS (
    p_supplierid NUMBER,
    p_name VARCHAR2,
    p_contact_person_name VARCHAR2,
    p_phone VARCHAR2,
    p_email VARCHAR2
)
AS  
    v_level VARCHAR2(100) := 'C';
    v_compartment VARCHAR2(100) := 'CS';
    v_group VARCHAR2(100) := 'EMP';     
    v_label VARCHAR2(100);
BEGIN

    -- 创建 OLS 标签
    v_label := CHAR_TO_LABEL('SUP_OLS_POL', v_level || ':' || v_compartment || ':' || v_group);

    -- 插入supplier记录
    INSERT INTO PROJECT2.SUPPLIERS (
        SUPPLIERID,
        NAME,
        CONTACTPERSONNAME,
        PHONE,
        EMAIL,
        OLS_COL
    ) VALUES (
        p_supplierid,
        p_name,
        p_contact_person_name,
        p_phone,
        p_email,
        v_label
    );
END;
/

BEGIN
    PROJECT2.INSERT_SUPPLIERS(
        p_supplierid => 1,
        p_name => 'ZhaoLiu', 
        p_contact_person_name => 'ZhaoliuContact', 
        p_phone => 'phone_zhaoliu',
        p_email => 'email_zhaoliu'
    );
    PROJECT2.INSERT_SUPPLIERS(
        p_supplierid => 2,
        p_name => 'SunQi', 
        p_contact_person_name => 'SunQiContact', 
        p_phone => 'phone_sunqi',
        p_email => 'email_sunqi'
    );
END;
/
