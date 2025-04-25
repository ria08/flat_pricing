 Table of Contents

- [Introduction](#introduction)
- [Changes in Excel](#changes-in-excel)
- [Data Cleaning in My SQL](#data-cleaning-in-my-sql)
- [Derived Insights from Power BI](#derived-insights-from-power-bi)

   



## Introduction

Performed data cleaning on house price dataset from kaggle. **https://www.kaggle.com/datasets/juhibhojani/house-price**

This involved processing and cleaning of 100688 rows.

## Changes in Excel

Created a new column flat type in excel then copied the type of flat substring from column ‘title’ and then drop the column title.

## Data Cleaning in My SQL

1. Used table import wizard to import values from csv file into database table.
2. Created duplicate table to perform data cleaning so main data is unaffected in case of any error.
3. There were 77103 duplicate rows in the table so created new table again to drop them and perform the necessary cleaning here.
4. From observations, I noticed that carpet_area, society, car_parking, and ownership have large amount of blank values so these colns can be dropped. Left the feature balcony as it can be a crucial deciding factor for customers in buying a flat.
5. Populated blank or empty values in status, floor, transaction, furnishing, ownerhsip and balcony columns.
6. Performed normalisation on Amount column for calculations in Power BI before segmenting it in column Amount Range for visualisation.
7. Added new column called floor number derived from floor for analysis in BI.
8. Dropped some more columns which didnt seem very important. Final columns were Index, Flat type, Location, Status, Floor, Transaction, Furnishing, Bathroom, Balcony, Ownership, Amount num, Amount range, and floor number.
   
   ## Derived Insights from Power BI

   1. MOST POPULAR FLAT TYPE
   
   3 BHK with 9724 listings

   2. CITY WITH MOST LISTINGS

    Gurgaon


   3. FLAT DISTRIBUTION BY PRICE

Mid-Range flat makes for the largest share of flat types.

   4. FLAT DISTRIBUTION BY OWNERSHIP

Majority of flats are freehold

   5. AVERAGE PRICE PER LOCATION

Average price of flats in Mumbai is highest and lowest in Nagpur.

   6. AVERAGE PRICE PER FURNISHING

Average price of flata is highest for semi furnished flats.

   7. SLICERS USED: Flat type, floor number, bathroom, balcony.

