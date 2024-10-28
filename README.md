
# Oracle OLS Design and Implementation
## Database Design
<img width="431" alt="image" src="https://github.com/user-attachments/assets/e4dfbfed-9253-4ffc-bc9f-7d435309e80a">

## Requirements

**USER_ROLES Table**

- **HR**: Can view all employee user information.
- **Customer Service**: Can view all customer user information.

**EMPLOYEES Table**

- **Customers**: Cannot view any data in this table.
- **HR**: Can view all employee information.
- Other employees can view only regular employee information.
- Other employees cannot view information of **DBA** and **HR**.
- **HR** has `WRITEUP` privilege to increase the confidentiality level for an employee’s data if needed.
   - Use case: if an employee's information requires higher confidentiality.)

**SUPPLIERS Table**

- Only **Buyer** can view and modify the table; other employees and customers have no access.

**CATEGORIES Table**

- All users can view the table, but only **Buyer** can modify it.

**CUSTOMERS Table**

- Only **Customer Service** can view and modify the table.
- Other employees have no access.

**PRODUCTS Table**

- All users can view the information.

- Only **Buyer** and **Cashier** can view and modify the entire table.

- **Buyer** has `WRITEDOWN` privilege to lower a product's confidentiality level.

- Cashier has `WRITEUP` privilege to increase a product's confidentiality level.

  - Use case: When a product is out of stock, **Cashier** can use the `WRITEUP` privilege to change the product’s level to "Confidential," restricting customer access and ensuring that only supermarket staff can see product details. Once restocked, **Buyer** can use `WRITEDOWN` to reset the level, allowing customers to view and purchase it.

**PURCHASERECORDS Table**

- Only **Buyer** can view and modify the table.

**SALES Table**

- Only **Customer**, **Cashier**, and **Customer Service** can view records.
- Only **Cashier** can modify the table.

**SALEDETAILS Table**

- Only **Cashier** and **Customer Service** can view records.

- Only **Cashier** can modify the table.

  

## OLS Design

**1. Levels**

- *Public* (P): 100
- *Confidential* (C): 200
- *Secret* (S): 300
- *Top Secret* (TS): 400

**2. Compartments**

Different business divisions:

- *Comp_Employee* (CE)
- *Comp_Supplier* (CS)
- *Comp_Category* (CC)
- *Comp_Product* (CP)
- *Comp_PurchaseRecord* (CPR)
- *Comp_Customer* (CCC)
- *Comp_Sale* (CSA)
- *Comp_SaleDetail* (CSD)

**3. Groups**

Define user groups to control access permissions:

- DBA

   (Parent)

  - *Employee* (Emp)
  - *Customer* (Cust)

**4. Tuple Labeling**

Data tuples for which customers have no access:

- **USER_ROLES Table**:
  - DBA user information: *TS || DBA* (Only DBA can view)
  - Regular employee information: *S | CE | Emp* (HR can view)
  - Customer information: *C | CCC | Emp* (Customer Service can view)
- **EMPLOYEES Table**:
  - DBA row: *TS | CE | Emp*
  - HR row: *S | CE | Emp*
  - Others: *C | CE | Emp*
- **SUPPLIERS Table**:
  - *C | CS | Emp*
- **CUSTOMERS Table**:
  - *C | CCC | Emp*
- **PURCHASERECORDS Table**:
  - *C | CPR | Emp*
- **SALEDETAILS Table**:
  - *C | CSD | Emp*

Data tuples for which customers have access:

- **CATEGORIES Table**:
  - *P | CC | Emp, Cust*
- **PRODUCTS Table**:
  - *P | CP | Emp, Cust*
- **SALES Table**:
  - *P | CSA | Emp, Cust*

**5. User Labels** (Level | Compartment | Group)

- **DBA**:

  - *TS | CE, CS, CC, CCC, CP, CPR, CSA, CSD | DBA* (Full access, equivalent to FULL privilege)

- **HR**:

  - *S | CE, CC, CP | Emp*
  - Write access to **Employees** table only.
  - Has `WRITEUP` privilege to increase confidentiality level for employee information.

- **Cashier**:

  - *C | CE, CC, CP, CSA, CSD | Emp*
  - Write access to **Products**, **Sales**, and **SaleDetails** tables.
  - Has `WRITEDOWN` privilege to lower confidentiality level for products.

- **Buyer**:

  - *C | CE, CS, CC, CP, CPR | Emp*
  - Write access to **Suppliers**, **Categories**, **Products**, and **PurchaseRecords** tables.
  - Has `WRITEUP` privilege to increase confidentiality level for products.

- **Customer Service**:

  - *C | CE, CC, CP, CCC, CSA, CSD | Emp*
  - Write access to **Customers** table only.

- **Customer**:

  - *P | CC, CP, CSA | Cust*

  - No write privileges.

    

## Implementation Steps

1. Log in as **SYSDBA**
   - Execute `0_create_schema.sql`
   - Execute `1_create_table.sql`
2. Log in as **LBACSYS** to create OLS policy, levels, compartments, and labels
   - Execute `2_create_ols.sql`
3. Log in again as **SYSDBA**
   - Create users and procedures, and initialize data in relevant tables:
     - Execute scripts in the following order:
       - `insert_user.sql`
       - `insert_employee.sql`
       - `insert_customer.sql`
       - `insert_category.sql`
       - `insert_supplier.sql`
       - `insert_product.sql`
       - `insert_purchase_record.sql`
       - `insert_sale.sql`
       - `insert_sale_detail.sql`
     - Execute `3_create_user.sql`
4. Log in again as **LBACSYS** to set user labels
   - Execute `4_create_user_label.sql`

After completing these steps, the system is initialized with the required users:

![image-20241028001406418](https://github.com/user-attachments/assets/da252694-2e57-4d86-952d-50a10e570f6d)


## Testing

**USER_ROLES Table**

- DBA user can view everything, HR can view employee information only, and Customer Service can view customer information.
  
  ![image-20241028143843322](https://github.com/user-attachments/assets/1fe17ef7-e215-48d7-8f5a-1ed8778adde2)
  
- Other users have no access.
  
  ![image-20241028144642313](https://github.com/user-attachments/assets/7374488b-a8cf-4b9a-bcb7-c971d0b877dd)

**EMPLOYEES Table**

- DBA can view everything.

  ![image-20241028144128686](https://github.com/user-attachments/assets/3b3b78fb-d125-4779-b164-45c329217025)
  
- HR can view all except DBA information.

  ![image-20241028144229236](https://github.com/user-attachments/assets/7d9a2d88-36f7-4218-a655-a4667df38d6e)
  
- Other employees can view everything except DBA and HR information.

  ![image-20241028144415233](https://github.com/user-attachments/assets/2d2e2aaf-e9a2-4d21-a5d3-5c03dd994da8)
  
- HR uses `WRITEUP` privilege to hide specific employee information.
  ![image-20241028144954078](https://github.com/user-attachments/assets/6f60ba60-1189-4aa9-a0a9-e03742454204)
  

**PRODUCTS Table**

- All users can view products.

  ![image-20241028145406404](https://github.com/user-attachments/assets/6ff42e2d-dfc3-4166-9acf-afa0f05fb302)
  
- Cashier uses `WRITEUP` to hide Product ID 3.
  
  ![img](https://private-user-images.githubusercontent.com/110983008/380754000-b4fc6e6a-2a24-4f25-b49f-67c9ac4fbf56.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzAxMjU2OTgsIm5iZiI6MTczMDEyNTM5OCwicGF0aCI6Ii8xMTA5ODMwMDgvMzgwNzU0MDAwLWI0ZmM2ZTZhLTJhMjQtNGYyNS1iNDlmLTY3YzlhYzRmYmY1Ni5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjQxMDI4JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI0MTAyOFQxNDIzMThaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00ZGI1Yzk2N2MyODZhZTZjNDQwMDkwMThmNzUzNWUxNmQzYjNlM2ZiZmVhNDYyNzgyNDJmYjIxM2MwZjRlZjY0JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.4oPPX_qC2wT18NkzjLaLZPX7j6xUwIepgdGApikC3lY)
  

- Buyer uses `WRITEDOWN` to make Product ID 3 public.
  
![img](https://github-production-user-asset-6210df.s3.amazonaws.com/110983008/380755417-36cc5af2-d473-48e8-9089-d1de861eec64.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20241028%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241028T142616Z&X-Amz-Expires=300&X-Amz-Signature=215bfcab73f58a9bc1b77556053f9b348d2ff004cb2d135423e5225e3e4673bc&X-Amz-SignedHeaders=host)
  

## Additional Commands

**Check the label for the current user**

```sql
SELECT SA_SESSION.LABEL('SUP_OLS_POL') FROM DUAL;
```



**Convert labels to display format**

```sql
SELECT LABEL_TO_CHAR(OLS_COL) AS "Label" FROM PROJECT2.USER_ROLES; 
```



**Adjust console output format**

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



**WRITEUP and WRITEDOWN Privileges**

```sql
-- Increase confidentiality of employee Ethan to 'Secret'
UPDATE project2.employees SET ols_col = CHAR_TO_LABEL('SUP_OLS_POL','S:CE:EMP') WHERE username='ETHAN';

-- Increase confidentiality of Product ID 3 to 'Confidential'
UPDATE project2.products SET ols_col = CHAR_TO_LABEL('SUP_OLS_POL','C:CP:EMP,CUST') WHERE productid=3;

-- Lower confidentiality of Product ID 3 to 'Public'
UPDATE project2.products SET ols_col = CHAR_TO_LABEL('SUP_OLS_POL','P:CP:EMP,CUST') WHERE productid=3;
```



**View current privileges for a user**

```sql
SELECT * FROM ALL_SA_USER_PRIVS WHERE user_name = 'BOB';
```
