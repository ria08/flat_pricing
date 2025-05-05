
# 🏠 House Price Data Analysis Project

A full-stack data analysis project using Excel, MySQL, and Power BI on a housing dataset from Kaggle. This project covers data cleaning, transformation, and visual analysis to generate actionable real estate insights.

---

## 📑 Table of Contents

- [📂 Introduction](#-introduction)
- [📊 Changes in Excel](#-changes-in-excel)
- [🧹 Data Cleaning in MySQL](#-data-cleaning-in-mysql)
- [📈 Derived Insights from Power BI](#-derived-insights-from-power-bi)
- [📝 Executive Summary](#-executive-summary)
- [📚 Key Learnings](#-key-learnings)
- [🛠️ Tools Used](#-tools-used)

---

## 📂 Introduction

Performed data cleaning and analysis on a **house price dataset** sourced from Kaggle:  
🔗 [Kaggle Dataset - House Prices](https://www.kaggle.com/datasets/juhibhojani/house-price)

- **Total Rows**: 100,688
- **Objective**: Clean and structure raw data for meaningful analysis on real estate trends, pricing patterns, and regional performance.

---

## 📊 Changes in Excel

Initial transformation steps performed in Excel before importing into MySQL:

- Created a new column called **Flat Type** by extracting flat size (e.g., 2BHK, 3BHK) from the `title` column.
- Dropped the original `title` column after extraction.
- Saved the cleaned file as CSV for import into MySQL.

---

## 🧹 Data Cleaning in MySQL

- Imported data into MySQL using **Table Import Wizard**.
- Created a **duplicate table** as a safe backup to avoid accidental data loss.
- Identified and removed **77,103 duplicate rows**.
- Dropped columns with high null values: `carpet_area`, `society`, `car_parking`, and `ownership` (after careful review).
- Retained `balcony` column due to its potential influence on buyer decisions.
- **Filled missing values** in key categorical fields: `status`, `floor`, `transaction`, `furnishing`, `ownership`, and `balcony`.
- Normalized the `Amount` column for calculation and created a new binned column **Amount Range** for segmentation.
- Created a derived column `floor number` from the `floor` text.
- Final columns used in analysis:

  ```
  Index, Flat type, Location, Status, Floor, Transaction, Furnishing,
  Bathroom, Balcony, Ownership, Amount num, Amount range, Floor number
  ```

---

## 📈 Derived Insights from Power BI

Visualizations and slicers were used to bring out key patterns in the data:

- **📌 Most Popular Flat Type**: 3 BHK with 9,724 listings
- **🏙️ City with Most Listings**: Gurgaon
- **💰 Flat Distribution by Price**: Mid-range flats form the largest share
- **📜 Flat Distribution by Ownership**: Majority are freehold properties; within freehold, **resale** leads
- **📍 Average Price by Location**: Highest in Mumbai, lowest in Nagpur
- **🛋️ Average Price per Furnishing**: Highest for **semi-furnished** flats

**Slicers Used**: Flat Type, Floor Number, Bathroom, Balcony

---

## 📝 Executive Summary

- 🏙️ **Prioritize Gurgaon** for marketing efforts—it has the highest property listings.
- 📢 **Focus on 3BHK flats**—they are the most in demand.
- 💰 **Promote mid-range flats**—offering deals in this segment can boost conversions.
- 📝 **List more resale properties under freehold**—simpler and quicker to transact.
- 🏡 **Target city-specific audiences**: luxury in Mumbai, budget-conscious in Nagpur.

---

## 📚 Key Learnings

- Handling large datasets in SQL with efficient cleaning strategies.
- Detecting and safely removing duplicate records using subqueries and table backups.
- Column transformation techniques in Excel and SQL.
- Data normalization and segmentation for dashboard-ready output.
- Creating impactful visual storytelling with Power BI using slicers and calculated fields.

---

## 🛠️ Tools Used

- **Excel** – Initial transformation and manual cleaning
- **MySQL** – Data wrangling and cleaning
- **Power BI** – Data visualization and insight derivation
- **Kaggle** – Dataset source

---
