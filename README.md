# House Price Data Analysis

## Overview
This repository contains a structured analysis of a Kaggle housing dataset using Excel, MySQL, and Power BI. The work covers data preparation, cleaning, and visualization to surface insights on flat types, pricing, and regional patterns.

- **Dataset**: Kaggle House Prices (Juhibhojani)
- **Rows**: 100,688
- **Focus**: Clean raw listings and derive real estate insights

## Repository Contents
| File | Description |
| --- | --- |
| `sql cleaning.sql` | SQL steps for cleaning and transforming the dataset in MySQL. |
| `house_price_visualisation.pbix` | Power BI report with visuals and slicers. |
| `README.md` | Project documentation. |

## Workflow Summary
### 1) Excel Preprocessing
- Extracted **Flat Type** (e.g., 2BHK, 3BHK) from `title`.
- Dropped the original `title` column.
- Exported the cleaned data to CSV for MySQL import.

### 2) MySQL Cleaning
- Imported data using **Table Import Wizard**.
- Created a **duplicate table** for safety.
- Removed **77,103 duplicate rows**.
- Dropped columns with high null rates: `carpet_area`, `society`, `car_parking`, `ownership`.
- Retained `balcony` due to decision-making relevance.
- Filled missing values in: `status`, `floor`, `transaction`, `furnishing`, `ownership`, `balcony`.
- Normalized `Amount` into `Amount num`.
- Added `Amount range` bins for segmentation.
- Derived `floor number` from the `floor` text.

**Final analysis columns**:
```
Index, Flat type, Location, Status, Floor, Transaction, Furnishing,
Bathroom, Balcony, Ownership, Amount num, Amount range, Floor number
```

### 3) Power BI Analysis
**Key visuals**:
- Popular flat type
- Listings by city
- Price distribution by range
- Ownership vs. transaction types
- Average price by location and furnishing

**Slicers**: Flat Type, Floor Number, Bathroom, Balcony

## Insights
- **Most popular flat type**: 3 BHK (9,724 listings)
- **City with most listings**: Gurgaon
- **Price distribution**: Mid-range flats dominate
- **Ownership**: Freehold is most common; resale leads within freehold
- **Average price**: Highest in Mumbai, lowest in Nagpur
- **Furnishing impact**: Semi-furnished flats show the highest average price

## Executive Recommendations
- Prioritize **Gurgaon** for marketing due to listing volume.
- Emphasize **3BHK** offerings to match demand.
- Target the **mid-range** segment to maximize conversions.
- Promote **resale freehold** properties for faster transactions.
- Tailor city campaigns: premium focus in Mumbai, value focus in Nagpur.

## Tools Used
- **Excel**: Initial transformation
- **MySQL**: Data cleaning and normalization
- **Power BI**: Visualization and insight derivation
- **Kaggle**: Data source

## Dataset
- Kaggle: https://www.kaggle.com/datasets/juhibhojani/house-price

