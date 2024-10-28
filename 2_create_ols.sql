-- Create Policy
BEGIN
  SA_SYSDBA.CREATE_POLICY (
    policy_name => 'SUP_OLS_POL',
    column_name => 'OLS_COL',
    default_options => 'ALL_CONTROL');
END;
/

-- Create Level
BEGIN
  SA_COMPONENTS.CREATE_LEVEL (
    policy_name => 'SUP_OLS_POL',
    level_num => 100,
    short_name => 'P',
    long_name => 'PUBLIC');
  SA_COMPONENTS.CREATE_LEVEL (
    policy_name => 'SUP_OLS_POL',
    level_num => 200,
    short_name => 'C',
    long_name => 'CONFIDENTIAL');
  SA_COMPONENTS.CREATE_LEVEL (
    policy_name => 'SUP_OLS_POL',
    level_num => 300,
    short_name => 'S',
    long_name => 'SECRET');
  SA_COMPONENTS.CREATE_LEVEL (
    policy_name => 'SUP_OLS_POL',
    level_num => 400,
    short_name => 'TS',
    long_name => 'TOP_SECRET');
END;
/


-- Create Compartment
BEGIN
  SA_COMPONENTS.CREATE_COMPARTMENT (
    policy_name => 'SUP_OLS_POL',
    comp_num => '1',
    short_name => 'CE',
    long_name => 'COMP_EMPLOYEE');
  SA_COMPONENTS.CREATE_COMPARTMENT (
    policy_name => 'SUP_OLS_POL',
    comp_num => '2',
    short_name => 'CS',
    long_name => 'COMP_SUPPLIER');
  SA_COMPONENTS.CREATE_COMPARTMENT (
    policy_name => 'SUP_OLS_POL',
    comp_num => '3',
    short_name => 'CC',
    long_name => 'COMP_CATEGORY');
  SA_COMPONENTS.CREATE_COMPARTMENT (
    policy_name => 'SUP_OLS_POL',
    comp_num => '4',
    short_name => 'CP',
    long_name => 'COMP_PRODUCT');
  SA_COMPONENTS.CREATE_COMPARTMENT (
    policy_name => 'SUP_OLS_POL',
    comp_num => '5',
    short_name => 'CPR',
    long_name => 'COMP_PURCHASERECORD');
  SA_COMPONENTS.CREATE_COMPARTMENT (
    policy_name => 'SUP_OLS_POL',
    comp_num => '6',
    short_name => 'CCC',
    long_name => 'COMP_CUSTOMER');
  SA_COMPONENTS.CREATE_COMPARTMENT (
    policy_name => 'SUP_OLS_POL',
    comp_num => '7',
    short_name => 'CSA',
    long_name => 'COMP_SALE');
  SA_COMPONENTS.CREATE_COMPARTMENT (
    policy_name => 'SUP_OLS_POL',
    comp_num => '8',
    short_name => 'CSD',
    long_name => 'COMP_SALEDETAIL');
END;
/

-- Create Group
BEGIN
  SA_COMPONENTS.CREATE_GROUP (
    policy_name => 'SUP_OLS_POL',
    group_num => '1',
    short_name => 'DBA',
    long_name => 'DBA_GROUP');

  SA_COMPONENTS.CREATE_GROUP (
    policy_name => 'SUP_OLS_POL',
    group_num => '10',
    short_name => 'EMP',
    long_name => 'EMPLOYEE_GROUP',
    parent_name => 'DBA');
    
  SA_COMPONENTS.CREATE_GROUP (
    policy_name => 'SUP_OLS_POL',
    group_num => '20',
    short_name => 'CUST',
    long_name => 'CUSTOMER_GROUP',
    parent_name => 'DBA');
END;
/

-- Create Label
BEGIN
  -- tuple label
  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '1',
    label_value => 'TS::DBA',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '2',
    label_value => 'S:CE:EMP',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '3',
    label_value => 'C:CCC:EMP',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '4',
    label_value => 'TS:CE:EMP',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '5',
    label_value => 'C:CE:EMP',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '6',
    label_value => 'C:CS:EMP',
    data_label => TRUE);
  
  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '7',
    label_value => 'P:CCC:EMP',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '8',
    label_value => 'C:CPR:EMP',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '9',
    label_value => 'C:CSD:EMP',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '10',
    label_value => 'P:CC:EMP,CUST',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '11',
    label_value => 'P:CP:EMP,CUST',
    data_label => TRUE);
  
  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '12',
    label_value => 'C:CP:EMP,CUST',
    data_label => TRUE);

  -- user label
  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '13',
    label_value => 'TS:CE,CS,CC,CCC,CP,CPR,CSA,CSD:DBA',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '14',
    label_value => 'S:CE,CC,CP:EMP',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '15',
    label_value => 'C:CE,CC,CP,CSA,CSD:EMP',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '16',
    label_value => 'C:CE,CS,CC,CP,CPR:EMP',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '17',
    label_value => 'C:CE,CC,CP,CCC,CSA,CSD:EMP',
    data_label => TRUE);

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'SUP_OLS_POL',
    label_tag => '18',
    label_value => 'P:CC,CP,CSA:CUST',
    data_label => TRUE);
END;
/

--Apply Policy
BEGIN
  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name => 'SUP_OLS_POL',
    schema_name => 'PROJECT2',
    table_name => 'USER_ROLES',
    table_options => 'LABEL_UPDATE,READ_CONTROL,WRITE_CONTROL'
  );
  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name => 'SUP_OLS_POL',
    schema_name => 'PROJECT2',
    table_name => 'EMPLOYEES',
    table_options => 'LABEL_UPDATE,READ_CONTROL,WRITE_CONTROL'
  );

  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name => 'SUP_OLS_POL',
    schema_name => 'PROJECT2',
    table_name => 'CATEGORIES',
    table_options => 'LABEL_UPDATE,READ_CONTROL,WRITE_CONTROL'
  );

  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name => 'SUP_OLS_POL',
    schema_name => 'PROJECT2',
    table_name => 'CUSTOMERS',
    table_options => 'LABEL_UPDATE,READ_CONTROL,WRITE_CONTROL'
  );

  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name => 'SUP_OLS_POL',
    schema_name => 'PROJECT2',
    table_name => 'SUPPLIERS',
    table_options => 'LABEL_UPDATE,READ_CONTROL,WRITE_CONTROL'
  );

  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name => 'SUP_OLS_POL',
    schema_name => 'PROJECT2',
    table_name => 'PRODUCTS',
    table_options => 'LABEL_UPDATE,READ_CONTROL,WRITE_CONTROL'
  );

  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name => 'SUP_OLS_POL',
    schema_name => 'PROJECT2',
    table_name => 'PURCHASERECORDS',
    table_options => 'LABEL_UPDATE,READ_CONTROL,WRITE_CONTROL'
  );
  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name => 'SUP_OLS_POL',
    schema_name => 'PROJECT2',
    table_name => 'SALES',
    table_options => 'LABEL_UPDATE,READ_CONTROL,WRITE_CONTROL'
  );
  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name => 'SUP_OLS_POL',
    schema_name => 'PROJECT2',
    table_name => 'SALEDETAILS',
    table_options => 'LABEL_UPDATE,READ_CONTROL,WRITE_CONTROL'
  );
END;
/

-- BEGIN
--   SA_SYSDBA.DROP_POLICY('SUP_OLS_POL');
-- END;
-- /

-- BEGIN
--   SA_COMPONENTS.DROP_LEVEL(
--     policy_name => 'SUP_OLS_POL',
--     level_num => 100);
--   SA_COMPONENTS.DROP_LEVEL(
--     policy_name => 'SUP_OLS_POL',
--     level_num => 200);
--   SA_COMPONENTS.DROP_LEVEL(
--     policy_name => 'SUP_OLS_POL',
--     level_num => 300);
--   SA_COMPONENTS.DROP_LEVEL(
--     policy_name => 'SUP_OLS_POL',
--     level_num => 400);
-- END;
-- /


-- BEGIN
--   SA_COMPONENTS.DROP_COMPARTMENT(
--     policy_name => 'SUP_OLS_POL',
--     comp_num => '1');
--   SA_COMPONENTS.DROP_COMPARTMENT(
--     policy_name => 'SUP_OLS_POL',
--     comp_num => '2');
--   SA_COMPONENTS.DROP_COMPARTMENT(
--     policy_name => 'SUP_OLS_POL',
--     comp_num => '3');
--   SA_COMPONENTS.DROP_COMPARTMENT(
--     policy_name => 'SUP_OLS_POL',
--     comp_num => '4');
--   SA_COMPONENTS.DROP_COMPARTMENT(
--     policy_name => 'SUP_OLS_POL',
--     comp_num => '5');
--   SA_COMPONENTS.DROP_COMPARTMENT(
--     policy_name => 'SUP_OLS_POL',
--     comp_num => '6');
--   SA_COMPONENTS.DROP_COMPARTMENT(
--     policy_name => 'SUP_OLS_POL',
--     comp_num => '7');
--   SA_COMPONENTS.DROP_COMPARTMENT(
--     policy_name => 'SUP_OLS_POL',
--     comp_num => '8');
-- END;
-- /

-- BEGIN
--   SA_COMPONENTS.DROP_GROUP(
--     policy_name => 'SUP_OLS_POL',
--     group_num => '1');
--   SA_COMPONENTS.DROP_GROUP(
--     policy_name => 'SUP_OLS_POL',
--     group_num => '10');
--   SA_COMPONENTS.DROP_GROUP(
--     policy_name => 'SUP_OLS_POL',
--     group_num => '20');
-- END;
-- /

-- BEGIN
--   FOR ROW IN (SELECT * FROM ALL_SA_LABELS)
--   LOOP
--     SA_LABEL_ADMIN.DROP_LABEL (
--       policy_name => 'SUP_OLS_POL',
--       label_value => ROW.LABEL);
--   END LOOP;
-- END;
-- /