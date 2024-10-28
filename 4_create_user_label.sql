-- 设置user label
BEGIN
    SA_USER_ADMIN.SET_LEVELS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'ALICE',
        max_level => 'TS'
    );
    SA_USER_ADMIN.SET_COMPARTMENTS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'ALICE',
        read_comps => 'CE,CS,CC,CCC,CP,CPR,CSA,CSD'
    );
    SA_USER_ADMIN.SET_GROUPS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'ALICE',
        read_groups => 'DBA'
    );
    SA_USER_ADMIN.SET_USER_PRIVS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'ALICE',
        privileges => 'FULL'
    );

END;
/

BEGIN
    SA_USER_ADMIN.SET_LEVELS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'BOB',
        max_level => 'S',
        min_level => 'C'
    );
    SA_USER_ADMIN.SET_COMPARTMENTS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'BOB',
        read_comps => 'CE,CC,CP'
    );
    SA_USER_ADMIN.SET_GROUPS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'BOB',
        read_groups => 'EMP'
    );
    SA_USER_ADMIN.SET_USER_PRIVS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'BOB',
        privileges => 'writeup'
    );
END;
/

BEGIN
    SA_USER_ADMIN.SET_LEVELS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'CATH',
        max_level => 'C'
    );
    SA_USER_ADMIN.SET_COMPARTMENTS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'CATH',
        read_comps => 'CE,CC,CP,CSA,CSD'
    );
    SA_USER_ADMIN.SET_GROUPS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'CATH',
        read_groups => 'EMP'
    );
    SA_USER_ADMIN.SET_USER_PRIVS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'CATH',
        privileges => 'writeup'
    );
END;
/

BEGIN
    SA_USER_ADMIN.SET_LEVELS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'DAVE',
        max_level => 'C',
        min_level => 'P'
    );
    SA_USER_ADMIN.SET_COMPARTMENTS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'DAVE',
        read_comps => 'CE,CS,CC,CP,CPR'
    );
    SA_USER_ADMIN.SET_GROUPS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'DAVE',
        read_groups => 'EMP'
    );
    SA_USER_ADMIN.SET_USER_PRIVS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'DAVE',
        privileges => 'writedown'
    );
END;
/

BEGIN
    SA_USER_ADMIN.SET_LEVELS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'ETHAN',
        max_level => 'C'
    );
    SA_USER_ADMIN.SET_COMPARTMENTS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'ETHAN',
        read_comps => 'CE,CC,CP,CCC,CSA,CSD'
    );
    SA_USER_ADMIN.SET_GROUPS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'ETHAN',
        read_groups => 'EMP'
    );
    SA_USER_ADMIN.SET_USER_PRIVS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'ETHAN',
        privileges => ''
    );
END;
/

BEGIN
    SA_USER_ADMIN.SET_LEVELS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'FRANK',
        max_level => 'P'
    );
    SA_USER_ADMIN.SET_COMPARTMENTS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'FRANK',
        read_comps => 'CC,CP,CSA'
    );
    SA_USER_ADMIN.SET_GROUPS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'FRANK',
        read_groups => 'CUST'
    );
    SA_USER_ADMIN.SET_USER_PRIVS (
        policy_name => 'SUP_OLS_POL',
        user_name => 'FRANK',
        privileges => ''
    );
END;
/


