# 🍕 Pizza Sales Performance & Revenue Analytics (MySQL 8.0)

**Author:** Suraj Yadav  
**Role Target:** Data Analyst / Business Analyst  
**Tools Used:** MySQL 8.0, Relational Database Modeling, Advanced SQL  
**Documentation:** [View Full Presentation PDF](./Pizza%20Sales%20SQL%20Project%20-%20Suraj%20Yadav.pdf)

---

## 📌 Executive Summary
Analyzed **48,000+ pizza sales transaction records** to evaluate overall business health, revenue drivers, hourly order distribution, and menu performance. The goal of this analysis is to provide actionable recommendations for inventory forecasting, peak-hour kitchen staffing, and revenue optimization.

---

## 📊 Key Business Metrics
- **Total Orders Placed:** 21,350 unique orders (averaging ~58–60 orders/day)
- **Total Gross Revenue:** $817,860.05
- **Average Order Value (AOV):** ~$38.30 per order
- **Average Daily Production:** 138 pizzas per day

---

## 🔍 Core Analysis & Business Findings

### 1. Revenue Drivers by Pizza Category
| Category | Revenue Contribution (%) | Key Observation |
| :--- | :---: | :--- |
| **Classic** | **26.91%** | Core volume driver anchored by Pepperoni and Hawaiian staples |
| **Supreme** | **25.46%** | High consistency across flavor profiles |
| **Chicken** | **23.96%** | High-ticket margins driven by premium poultry options |
| **Veggie** | **23.68%** | Steady baseline with zero single-category fragility |

### 2. Operational Peak Hours (Staffing & Prep)
- **Lunch Rush:** 12:00 PM – 1:00 PM (~4,975 orders combined)
- **Dinner Rush:** 5:00 PM – 7:00 PM (~4,735 orders combined)
- **Recommendation:** Implement staggered kitchen shift scheduling and schedule sauce/dough prep during afternoon lulls (3:00 PM – 5:00 PM).

### 3. Customer Size Preferences
- **Large (L):** 18,526 orders (Dominant volume driver)
- **Medium (M):** 15,385 orders
- **Small (S):** 14,137 orders
- **XL & XXL:** Niche segment (572 orders combined)

### 4. Top Revenue-Generating Pizzas
1. **The Thai Chicken Pizza** — $43,434.25
2. **The Barbecue Chicken Pizza** — $42,768.00
3. **The California Chicken Pizza** — $41,409.50

---

## 🛠️ SQL Technical Skills Demonstrated
- **Complex Aggregations & Grouping:** `COUNT()`, `SUM()`, `ROUND()`, `AVG()`
- **Multi-Table Relational Joins:** Inner joins across `orders`, `order_details`, `pizzas`, and `pizza_types`
- **Subqueries & Derived Tables:** Daily sales aggregations and order volume normalization
- **Window Functions:** 
  - Cumulative sales tracking: `SUM(revenue) OVER (ORDER BY order_date)`
  - Category-level revenue ranking: `DENSE_RANK() OVER (PARTITION BY category ORDER BY revenue DESC)`

---

## 📁 Repository Structure
```text
├── pizza_analysis.sql                           # Full SQL script containing all 13 queries
├── Pizza Sales SQL Project - Suraj Yadav.pdf   # Slide-by-slide visual presentation & insights
└── README.md                                    # Executive project summary & business findings
