
-- =============================================================================
-- CREATE TBALE retail_store_sales
-- =============================================================================
CREATE TABLE retail_store_sales (
    Transaction_ID VARCHAR(50),
    Customer_ID VARCHAR(50),
    Category VARCHAR(100),
    Item VARCHAR(100),
    Price_Per_Unit VARCHAR(50),
    Quantity VARCHAR(50),
    Total_Spent VARCHAR(50),
    Payment_Method VARCHAR(50),
    Location VARCHAR(50),
    Transaction_Date VARCHAR(50),
    Discount_Applied VARCHAR(50)
);

-- Instead of directly importing the CSV file,
-- a staging table was manually created with all columns as VARCHAR.
-- This approach avoids datatype conflicts during import.
-- After successful import using MySQL Workbench Import Wizard,
-- data cleaning and datatype standardization were performed.


-- =============================================================================
-- INITIAL DATA INSPECTION
-- =============================================================================

-- Check Total Number Of Records
select count(*) as total_records
	from retail_store_sales;
        
-- Examine Tbale Structure
describe retail_store_sales;

-- Identify Missing Values
select 
      sum(case when Transaction_ID is null then 1 else 0 end) as missing_trans_id,
	  sum(case when Customer_ID is null then 1 else 0 end) as total_missing_Cust_id, 
      sum(case when Category is null then 1 else 0 end) as missing_Category,
      sum(case when Item is null then 1 else 0 end) as missing_Item,
      sum(case when Price_Per_Unit is null then 1 else 0 end) as missing_Price_Per_Unit,
      sum(case when Quantity is null then 1 else 0 end) as missing_Quantity,
      sum(case when Total_Spent is null then 1 else 0 end) as missing_Total_Spent,
      sum(case when Payment_Method is null then 1 else 0 end) as missing_Payment_Method,
      sum(case when Location is null then 1 else 0 end) as missing_Location,
      sum(case when Transaction_Date is null then 1 else 0 end) as missing_Transaction_Date,
      sum(case when Discount_Applied is null then 1 else 0 end) as missing_Discount_Applied
   
from retail_store_sales;   
     -- No Nulls values Find But Dataset Show Blanks 
     
     -- Lets Check Empty(Blank) Values 
     
select 
      sum(case when Transaction_ID = '' then 1 else 0 end) as missing_trans_id,
	  sum(case when Customer_ID = '' then 1 else 0 end) as total_missing_Cust_id, 
      sum(case when Category = '' then 1 else 0 end) as missing_Category,
      sum(case when Item = '' then 1 else 0 end) as missing_Item,
      sum(case when Price_Per_Unit = '' then 1 else 0 end) as missing_Price_Per_Unit,
      sum(case when Quantity = '' then 1 else 0 end) as missing_Quantity,
      sum(case when Total_Spent = '' then 1 else 0 end) as missing_Total_Spent,
      sum(case when Payment_Method = '' then 1 else 0 end) as missing_Payment_Method,
      sum(case when Location = '' then 1 else 0 end) as missing_Location,
      sum(case when Transaction_Date = '' then 1 else 0 end) as missing_Transaction_Date,
      sum(case when Discount_Applied = '' then 1 else 0 end) as missing_Discount_Applied
   
from retail_store_sales;       
-- In The Result Show Empty(Blank) Values      

-- ====================================================================================================
-- Convert Empty Strings To NULL
-- ====================================================================================================
SET SQL_SAFE_UPDATES = 0;

update retail_store_sales
set
    Item = NULLIF(TRIM(Item), ''),
    Price_Per_Unit = NULLIF(TRIM(Price_Per_Unit), ''),
    Quantity = NULLIF(TRIM(Quantity), ''),
    Total_Spent = NULLIF(TRIM(Total_Spent), ''),
    Discount_Applied = NULLIF(TRIM(Discount_Applied), '');

-- Verify Conversion
select 
       sum(Item is null ) as missing_item,
       sum(Price_Per_Unit is null ) as missing_Price_Per_Unit,
       sum(Quantity is null ) as missing_Quantity,
       sum(Total_Spent is null ) as missing_Total_Spent,
       sum(Discount_Applied is null ) as Discount_Applied
from retail_store_sales;       

-- =================================================================================================
-- HANDLE MISSING VALUES PROPERLY
-- =================================================================================================

-- Replace Missing Items
update retail_store_sales
set Item ='Unknown'
where Item is null;


-- Delete Rows Missing Price Or Quantity
delete from retail_store_sales
where Price_Per_Unit is null
or Quantity is null;


-- Recalculate Total spent
update retail_store_sales
set Total_Spent=Price_Per_Unit*Quantity
where Total_Spent is null;


-- Replace Missing Discount_Applied
update retail_store_sales
set Discount_Applied='NO'
where Discount_Applied is null;


-- ===========================================================================
-- DATA TYPE STANDARDIZATION
-- ===========================================================================

-- Convert Numeric Columns

alter table retail_store_sales
modify Price_Per_Unit decimal(10,2);

alter table retail_store_sales
modify Quantity int;


alter table retail_store_sales
modify Total_Spent decimal(10,2);


-- Add New Date Column  
alter table retail_store_sales
add column Clean_Transaction_Date Date;

-- Update Clean_Transaction_Date 
UPDATE retail_store_sales
SET Clean_Transaction_Date =
STR_TO_DATE(Transaction_Date, '%d-%m-%Y')
WHERE Transaction_Date IS NOT NULL
AND TRIM(Transaction_Date) <> '';

-- Delete Transaction_Date
alter table retail_store_sales
drop column Transaction_Date;

-- Rename Clean_Transaction_Date To Transaction_Date
alter table retail_store_sales
change Clean_Transaction_Date Transaction_Date date; 


-- ==============================================================================
-- DATA VALIDATION
-- ==============================================================================

-- Indetify Incorrect Total_Spent Values
select Total_Spent 
from retail_store_sales
where Total_Spent <> (Price_Per_Unit * Quantity);

-- Correct Inconsistent Total_Spent Values
update retail_store_sales
set Total_Spent=Price_Per_Unit*Quantity
where Total_Spent <> (Price_Per_Unit * Quantity); 


-- =========================================================================
--  DATA QUALITY CHECK 
-- =========================================================================

-- Check Duplicate Transaction_ID
select  Transaction_ID,count(*)
from retail_store_sales
group by Transaction_ID
having count(*)>1;

-- Check Range Validity
select * 
from retail_store_sales
where Price_Per_Unit < 0
or    Quantity       < 0;

-- Check Inconsistent Spelling
select distinct Category from retail_store_sales;

select distinct Payment_Method from retail_store_sales;

-- ================================================================
-- OPTIMIZE TABLE
-- ================================================================
optimize table retail_store_sales;

select * from retail_store_sales;











      
     