CREATE DATABASE housing;
 
-- We used table import wizard to import values from csv file into database table.
SELECT * FROM pricing_house;

-- creating duplicate table to perform data cleaning so main data is unaffected in case of any error.
CREATE TABLE pricing_home LIKE pricing_house;

SELECT * FROM PRICING_HOME;

-- inserting all the values from house to home table.
INSERT PRICING_HOME
SELECT * FROM pricing_house;

-- these columns were entirely empty
alter table pricing_home
drop column Dimensions, 
drop column `Plot Area`;

-- renaming some columns that had space
ALTER TABLE pricing_home
RENAME COLUMN `Amount(in rupees)` to Amount,
RENAME COLUMN `Price (in rupees)` to Price,
RENAME COLUMN `Carpet Area` to Carpet_Area,
RENAME COLUMN `Super Area` to Super_Area,
RENAME COLUMN `Car Parking` to Car_Parking,
RENAME COLUMN `Flat Type` to Flat_Type;

WITH DUPLICATE_VALUE AS
(
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY 
               Flat_Type, Description, Amount, Price, location,
               Carpet_Area, Status, Floor, Transaction, Furnishing, facing, overlooking,
               Society, Bathroom, Balcony, Car_Parking, Ownership, Super_Area
       ) AS row_num
FROM pricing_home
)
SELECT *
FROM DUPLICATE_VALUE
WHERE row_num >1;


-- We can see that 77103 rows out of 100688 rows are duplicate in dataset. Since we cannot delete directly from cte, we create new table.

CREATE TABLE PRICE_HOUSING AS
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY Flat_Type, Description, Amount, Price, location,
                        Carpet_Area, Status, Floor, Transaction, Furnishing, facing,
                        overlooking, Society, Bathroom, Balcony, Car_Parking, Ownership, Super_Area
       ) AS row_num
FROM pricing_home;

SELECT *
FROM PRICE_HOUSING
WHERE row_num>1;

-- To ADDRESS THE ERORR CODE:1175 (AKA you are using safe mode and you tried to update a table without a where....)
SET SQL_SAFE_UPDATES = 0;

DELETE 
FROM PRICE_HOUSING
WHERE row_num>1;

SELECT *
FROM PRICE_HOUSING;


-- Dropping some columns which are not that essential 

ALTER TABLE PRICE_HOUSING
DROP COLUMN DESCRIPTION,
DROP COLUMN PRICE,
DROP COLUMN FACING,
DROP COLUMN overlooking,
DROP COLUMN Super_Area;


-- DEALING WITH THE BLANK SPACES AND NULL VALUES

SELECT *
FROM PRICE_HOUSING
WHERE Carpet_Area
IS NULL 
OR Carpet_Area = '';

 -- It has 11 k blank rows

SELECT *
FROM
    PRICE_HOUSING
WHERE
    status IS NULL OR status = '';

-- It has 109 blank rows

SELECT *
FROM PRICE_HOUSING
WHERE Floor
IS NULL 
OR floor = '';

-- It has 1047 blank rows


SELECT *
FROM
    PRICE_HOUSING
WHERE
    Transaction IS NULL OR Transaction = '';
    
  -- It has 38 blank rows 
    
SELECT 
    *
FROM
    PRICE_HOUSING
WHERE
    Furnishing IS NULL OR Furnishing = '';
    
    -- It has 467 blank rows
    
    SELECT 
    *
FROM
    PRICE_HOUSING
WHERE
    Society IS NULL OR Society = '';
    
    -- It has 14k blank rows
    
    SELECT *
FROM PRICE_HOUSING
WHERE Balcony
IS NULL 
OR Balcony = '';

-- It has 7k blank rows.
    
    SELECT 
    *
FROM
    PRICE_HOUSING
WHERE
	Car_Parking IS NULL OR Car_Parking = '';
    
    -- It has 12k blank rows
    
    SELECT 
    *
FROM
    PRICE_HOUSING
WHERE
    Ownership IS NULL OR Ownership = '';
    
-- It has 8k blank rows

-- From observations we can notice that carpet_area, society, car_parking, and ownership have large amount of blank values so these colns can be dropped. Left the feature balcony as it can be a crucial deciding factor for customers in buying a flat.

ALTER TABLE PRICE_HOUSING
DROP COLUMN CARPET_AREA,
DROP COLUMN Society,
DROP COLUMN CAR_PARKING;

-- Now we need to populate blank or empty columns in status, floor, transaction, furnishing, and balcony. We can replace with null values or we can use some placeholders that feel appropriate.

UPDATE PRICE_HOUSING
SET
    furnishing = CASE 
    WHEN furnishing IS NULL OR TRIM(furnishing) = '' THEN 'Unknown' 
    ELSE furnishing 
    END,
    floor = CASE 
    WHEN floor IS NULL OR TRIM(floor) = '' THEN 'Not Specified' 
    ELSE floor 
    END,
    status = CASE 
    WHEN status IS NULL OR TRIM(status) = '' THEN 'Unknown' 
    ELSE status 
    END,
    transaction = CASE 
    WHEN transaction IS NULL OR TRIM(transaction) = '' THEN 'Not Specified' 
    ELSE transaction 
    END,
    ownership = CASE 
    WHEN ownership IS NULL OR TRIM(ownership) = '' THEN 'Not Specified' 
    ELSE ownership
    END;
         
                  
UPDATE price_housing
SET BALCONY = NULL
WHERE BALCONY = '';
                  
SELECT * FROM price_housing;

-- STANDARDISATION 

UPDATE price_housing
SET location = CONCAT(UPPER(LEFT(location, 1)), LOWER(SUBSTRING(location, 2)));

-- Converting Amount in numerical value (Normalisation)

ALTER TABLE price_housing
ADD COLUMN Amount_Num BIGINT;

UPDATE price_housing
SET Amount_num = 
  CASE
    WHEN LOWER(amount) LIKE '%lac%' THEN
      CAST(REPLACE(LOWER(amount), 'lac', '') AS DECIMAL(10,2)) * 100000

    WHEN LOWER(amount) LIKE '%cr%' THEN
      CAST(REPLACE(LOWER(amount), 'cr', '') AS DECIMAL(10,2)) * 10000000

    ELSE NULL
  END;
  
  SELECT MIN(AMOUNT_NUM)
  FROM price_housing
  WHERE AMOUNT_NUM IS NOT NULL;
  
  -- SEGMENTING THE AMOUNT FOR VISUALISATION
  
  SELECT avg(AMOUNT_NUM) as Mean
  FROM price_housing
  WHERE Amount_Num IS NOT NULL;
  
  WITH calc_median AS (  
    SELECT 
        Flat_Type, 
        Amount_Num, 
        ROW_NUMBER() OVER (ORDER BY amount_num) AS row_num,  
        COUNT(*) OVER () AS total_rows  
    FROM price_housing
)  
SELECT AVG(Amount_Num) AS median  
FROM calc_median
WHERE row_num IN (FLOOR((total_rows + 1) / 2), CEIL((total_rows + 1) / 2));     

SELECT *
FROM price_housing
WHERE amount_num IS NOT NULL
ORDER BY amount_num ASC
LIMIT 10;

-- We found out that our data ranges from 1 lac to 55 crores with the overall distribution being right skewed. So for better analysis and visualisation, we can divide them in sub categories. 

ALTER TABLE price_housing ADD COLUMN Amount_Range VARCHAR(50);

UPDATE price_housing
SET Amount_Range = CASE
    WHEN amount_num < 1000000 THEN 'Affordable'
    WHEN amount_num >= 1000000 AND amount_num < 3000000 THEN 'Lower-mid'
    WHEN amount_num >= 3000000 AND amount_num < 10000000 THEN 'Mid-range'
    WHEN amount_num >= 10000000 AND amount_num < 30000000 THEN 'Upper-mid'
    WHEN amount_num >= 30000000 AND amount_num < 70000000 THEN 'Premium'
    WHEN amount_num >= 70000000 AND amount_num < 150000000 THEN 'Ultra-Premium'
    WHEN amount_num >= 150000000 THEN 'Luxury'
    ELSE 'Unknown'
END;


-- NOW LETS DROP SOME COLUMNS LIKE AMOUNT AND ROW_NUM WHICH WONT BE REQUIRED FOR OUR ANALYSIS IN POWER BI

ALTER TABLE price_housing
DROP COLUMN Amount,
DROP COLUMN row_num;

SELECT * FROM price_housing;


-- Finally added a new column floor number to extract the floor no from column floor for analysis.

ALTER TABLE price_housing ADD COLUMN Floor_Number INT;

UPDATE price_housing
SET Floor_Number = CASE 
    WHEN LOWER(Floor) LIKE 'ground%' THEN 0
    WHEN FLOOR REGEXP '^[0-9]+' THEN CAST(SUBSTRING_INDEX(Floor, ' ', 1) AS UNSIGNED)
    ELSE NULL
END;



