#Rename Column
alter table customer_profiles
rename column  ï»¿CustomerID to CustomerID;
select * from customer_profiles;

alter table product_inventory
rename column ï»¿ProductID to ProductID;
select * from product_inventory;

alter table sales_transaction
rename column ï»¿TransactionID to TransactionID;
select * from sales_transaction;

#Remove Duplicates
select TransactionID, count(*) from sales_transaction group by TransactionID having count(*)>1;
create table sales_transaction_unique as 
select  distinct * from sales_transaction;
drop table sales_transaction;
RENAME TABLE sales_transaction_unique to Sales_transaction;
select * from Sales_transaction;

#Fix Incorrect Prices
# Step 1: Check mismatches
SELECT st.TransactionID, st.Price AS TransactionPrice, pi.Price AS InventoryPrice
FROM sales_transaction st
JOIN product_inventory pi  ON st.ProductID = pi.ProductID
WHERE st.Price <> pi.Price;
# Step 2: Fix using JOIN
UPDATE sales_transaction st
JOIN product_inventory pi 
    ON st.ProductID = pi.ProductID
SET st.Price = pi.Price
WHERE st.Price <> pi.Price;
# Step 3: Verify
SELECT * FROM sales_transaction;

#Fixing Null Values
SELECT COUNT(*) 
FROM customer_profiles
WHERE trim(Location)='';

SET SQL_SAFE_UPDATES = 0;
UPDATE customer_profiles
SET Location = 'Unknown'
WHERE trim(Location) ='';
SELECT * FROM customer_profiles;
