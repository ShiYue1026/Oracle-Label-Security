# Oracle OLS

# 需求

（[dba]()：can see and modify all things）

**USER_ROLES表**

- [hr]() can see all employees’ user info
- [customer]() service can see all customers’ user info

**EMPLOYEES 表**

- [customer]() can't view any of the data.
- Only [hr]() can see all the information
- Other stuff can see  the information of ordinary employees
- Other stuff can’t see the [dba]() && [hr]()’s  information
- [hr]() can `WRITEUP` the level of the tuple for an employee（应用场景：比如一些员工的工作机密性要求高，不能暴露个人信息）

**SUPPLIERS表**

- Only [buyer]() can view or modify the table, other stuff or 'customer' have no such rights.

**CATEGORIES表 **

- Everyone can view the table, but only [buyer]() can modify the table.

**CUSTOMERS表**

- Only [customer_service]() can view or modify the table.

- Other stuff have no access to the table.

**PRODUCTS表**

- Everyone can view all the info

- Only [buyer]() and [cashier]() are able to view and modify entire table.

- [buyer]() can `WRITEDOWN` the level of the tuple for a product

- [cashier]() can `WRITEUP` the level of the tuple for a product

  ( 应用场景：在某件商品的库存不足时，[cashier]()可以通过 `WRITEUP` 权限将该商品的level设为‘C’，以限制顾客访问，确保仅有超市内部人员能查看该商品的一些具体信息。当该[buyer]()采购完成后，可以使用 `WRITEDOWN` 权限将该商品的level重新设为‘P’，以便顾客可以获得该商品的信息并进行购买）

**PURCHASERECORDS表**

- Only [buyer]() can view and modify the table.

**SALES表**

- Only [customer]()  and [cashier]() and [customer_service]() can view the records,

- Only  [cashier]() can modify the table.

**SALEDETAILS表**

- Only  [cashier]() and [customer_service]() can  view the records,

- Only  [cashier]() can modify the table.



# OLS设计

**1. Level**

- *Public*：100
- *Confidential*：200
- *Secret*：300
- *Top Secret* ：400



**2. Compartment**

不同业务分区：

- *Comp_Employee* （CE）
- *Comp_Supplier* （CS）
- *Comp_Category* （CC）

- *Comp_Product* （CP）
- *Comp_PurchaseRecord* （CPR）
- *Comp_Customer* （CCC）
- *Comp_Sale* （CSA）
- *Comp_SaleDetail*  （CSD）



**3. Group**

定义不同的用户组，以限制访问权限：

- *DBA*（父级）      

  - *Emp*

  - *Cust*

    

**4. Tuple Label**



顾客无权访问的的业务：

- USER_ROLES表中的tuple：
  - DBA的用户信息：*TS || DBA*   （只有DBA可以访问）
  - 普通员工的用户信息：*S |CE| Emp*   （HR可以访问）
  - 顾客的用户信息：*C |CCC| Emp*  （Customer Service可以访问）



- EMPLOYEES表中的tuple：

  - DBA那条：*TS | CE | Emp*
  - HR那条：*S | CE | Emp*

  - 其余：*C | CE | Emp*

  

- SUPPLIERS表中的tuple：
  - *C| CS | Emp*

- CUSTOMERS表中的tuple：
  - *C | CCC | Emp*

- PURCHASERECORDS表中的tuple：
  - *C | CPR | Emp*

- SALEDETAILS表中的tuple：

  - *C | CSD| Emp*

    

顾客有权访问的业务：

- CATEGORIES表中的tuple：
  - *P | CC| Emp, Cust*

- PRODUCTS表中的tuple：
  - *P | CP | Emp, Cust*

- SALES表中的tuple：
  - *P | CSA | Emp, Cust*



**5. User Label** (Level | Compartment | Group)

- DBA

  - *TS | CE, CS, CC, CCC, CP, CPR, CSA, CSD| DBA*  （全部最高权限，相当于FULL特权）

  (直接使用特权FULL)

- HR

  - *S | CE, CC, CP | Emp*
  - 只有Employees表的写权限
  - 有writeup特权，可以隐藏一些Employees的个人信息

- Cashier
  - *C | CE, CC, CP, CSA, CSD | Emp*
  - 只有Products，Sales，SaleDetails的写权限
  - 有writedown特权，可以降低指定product的机密级别

- Buyer
  - *C| CE, CS, CC, CP, CPR | Emp*
  - 只有Suppliers，Categories，Products，PurchaseRecords的写权限
  - 有writeup特权，可以提高指定product的机密级别
- Customer Service
  - *C | CE, CC, CP, CCC, CSA, CSD | Emp*
  - 只有Customers表的写权限
- Customer
  - *P | CC, CP, CSA | Cust*
  - 无写权限



# 实现步骤

1. 登录**/ as sysdba**用户

   - 执行`0_create_schema.sql`
   - 执行`1_create_table.sql`

2. 登录**LBACSYS**用户，创建ols所需的policy，level，compartment，label

   - 执行`2_create_ols.sql`

3. 再次登录**/ as sysdba**用户，

   - 创建一些用户及各种procedure 并初始化一些数据到对应的表中

     - 依次执行    `insert_user.sql`,

       ​		   `insert_employee.sql`, 

       ​	           `insert_customer.sql`, 

       ​                   `insert_category.sql`, 

       ​                   `insert_supplier.sql`, 

       ​                   `insert_product.sql`, 

       ​                   `insert_purchase_record.sql`,

       ​                   `insert_sale.sql`, 

       ​                   `insert_sale_detail.sql`

     - 执行 `3_create_user.sql`

4. 再次登录**LBACSYS**用户，设置用户label

   - 执行`4_create_user_label.sql`



==（执行上述过程后初始化的一些用户）：==

![image-20241028001406418](https://github.com/user-attachments/assets/da252694-2e57-4d86-952d-50a10e570f6d)



# 测试

**User表**

- DBA用户可以看到所有，HR用户只能看到员工的，CUSTOMER SERVICE只能看到顾客的

![image-20241028143843322](https://github.com/user-attachments/assets/1fe17ef7-e215-48d7-8f5a-1ed8778adde2)

- 其余用户看不到

  ![image-20241028144642313](https://github.com/user-attachments/assets/7374488b-a8cf-4b9a-bcb7-c971d0b877dd)

**Employee表**

- DBA可以看到所有

    ![image-20241028144128686](https://github.com/user-attachments/assets/3b3b78fb-d125-4779-b164-45c329217025)

- HR能看到除了DBA的

   ![image-20241028144229236](https://github.com/user-attachments/assets/7d9a2d88-36f7-4218-a655-a4667df38d6e)

- 其余员工只能看到除了DBA和HR的

  ![image-20241028144415233](https://github.com/user-attachments/assets/2d2e2aaf-e9a2-4d21-a5d3-5c03dd994da8)

- HR用户使用writeup特权对普通员工隐藏ETHAN的信息

  ![image-20241028144954078](https://github.com/user-attachments/assets/6f60ba60-1189-4aa9-a0a9-e03742454204)



**Product表**

- 所有人可以访问

  ![image-20241028145406404](https://github.com/user-attachments/assets/6ff42e2d-dfc3-4166-9acf-afa0f05fb302)

- CASHIER用户使用writeup特权对外隐藏3号商品

  ![img](https://private-user-images.githubusercontent.com/110983008/380754000-b4fc6e6a-2a24-4f25-b49f-67c9ac4fbf56.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzAxMjU2OTgsIm5iZiI6MTczMDEyNTM5OCwicGF0aCI6Ii8xMTA5ODMwMDgvMzgwNzU0MDAwLWI0ZmM2ZTZhLTJhMjQtNGYyNS1iNDlmLTY3YzlhYzRmYmY1Ni5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjQxMDI4JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI0MTAyOFQxNDIzMThaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00ZGI1Yzk2N2MyODZhZTZjNDQwMDkwMThmNzUzNWUxNmQzYjNlM2ZiZmVhNDYyNzgyNDJmYjIxM2MwZjRlZjY0JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.4oPPX_qC2wT18NkzjLaLZPX7j6xUwIepgdGApikC3lY)

- BUYER用户使用writedown特权对外公开3号商品

  ![img](https://github-production-user-asset-6210df.s3.amazonaws.com/110983008/380755417-36cc5af2-d473-48e8-9089-d1de861eec64.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20241028%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241028T142616Z&X-Amz-Expires=300&X-Amz-Signature=215bfcab73f58a9bc1b77556053f9b348d2ff004cb2d135423e5225e3e4673bc&X-Amz-SignedHeaders=host)



# 附录

**每个用户上查看自己的label**

```sql
SELECT SA_SESSION.LABEL('SUP_OLS_POL') FROM DUAL;
```



**标签从tag到value的转换**

```sql
SELECT LABEL_TO_CHAR(OLS_COL) AS "Label" FROM PROJECT2.USER_ROLES; 
```



**调整控制台输出的格式**

```sql
COLUMN USERNAME FORMAT A15;
COLUMN PASSWORD FORMAT A20;
COLUMN ROLE FORMAT A20;
SET LINESIZE 300;
SET PAGESIZE 50;

COLUMN EMPLOYEEID FORMAT 99;
COLUMN USERNAME FORMAT A5;
COLUMN FIRSTNAME FORMAT A5;
COLUMN LASTNAME FORMAT A5;
COLUMN BIRTHDATE FORMAT A5;
COLUMN HIREDATE FORMAT A5;
COLUMN ADDRESS FORMAT A5;
COLUMN POSTALCODE FORMAT A5;
COLUMN PHONE FORMAT A5;
COLUMN EMAIL FORMAT A5;
SET LINESIZE 100;
SET PAGESIZE 50;

COLUMN PRODUCTID FORMAT 9999
COLUMN PRODUCTNAME FORMAT A10
COLUMN CATEGORYID FORMAT 9999
COLUMN UNITPRICE FORMAT 99999
COLUMN UNITSINSTOCK FORMAT 9999

COLUMN CATEGORYID FORMAT 9999
COLUMN CATEGORYNAME FORMAT A10
COLUMN DESCRIPTION FORMAT A15

COLUMN SUPPLIERID FORMAT 9999
COLUMN NAME FORMAT A10
COLUMN CONTACTPERSONNAME FORMAT A10
COLUMN PHONE FORMAT A5
COLUMN EMAIL FORMAT A5

COLUMN CUSTOMERID FORMAT 9999
COLUMN USERNAME FORMAT A5
COLUMN FIRSTNAME FORMAT A5
COLUMN LASTNAME FORMAT A5
COLUMN CONTACTNAME FORMAT A10
COLUMN ADDRESS FORMAT A10
COLUMN POSTALCODE FORMAT A10
COLUMN PHONE FORMAT A5
COLUMN EMAIL FORMAT A5

COLUMN SALEID FORMAT 9999
COLUMN CUSTOMERID FORMAT 9999
COLUMN USERNAME FORMAT A5
COLUMN SALEDATE FORMAT A10
COLUMN TOTALAMOUNT FORMAT 9999
COLUMN PAYMENTMETHOD FORMAT A10
```



**writeup && writedown特权**

```sql
-- 将ETHAN的员工信息的level提升到'Secret'级别
UPDATE project2.employees SET ols_col = CHAR_TO_LABEL('SUP_OLS_POL','S:CE:EMP') WHERE username='ETHAN';

-- 将3号商品的level提升到'Confidential'级别
UPDATE project2.products SET ols_col = CHAR_TO_LABEL('SUP_OLS_POL','C:CP:EMP,CUST') WHERE productid=3;

-- 将3号商品的level降低到'Public'级别
UPDATE project2.products SET ols_col = CHAR_TO_LABEL('SUP_OLS_POL','P:CP:EMP,CUST') WHERE productid=3;
```



**查看当前用户的特权**

```sql
SELECT * FROM ALL_SA_USER_PRIVS WHERE user_name = 'BOB';
```
