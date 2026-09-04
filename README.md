# ☕ BrewMetrics — Coffee Shop Sales & Market Analysis

## 📌 Project Overview

BrewMetrics is a MySQL-based data analysis project designed to analyze coffee shop sales, customer behavior, product performance, and city-level market potential.

The project uses relational data across cities, customers, products, and sales to answer real-world business questions and generate actionable insights for business expansion and decision-making.

The analysis is performed entirely using SQL and covers aggregation, joins, CTEs, window functions, date functions, ranking, customer segmentation, and growth analysis.

---

## 🎯 Business Objective

The primary objective of this project is to use sales and customer data to understand:

- Which cities generate the highest revenue?
- Which coffee products sell the most?
- How many customers are purchasing in each city?
- What is the average sales contribution per customer?
- Which cities have the largest potential coffee-consuming population?
- How are monthly sales changing over time?
- Which cities provide the best market expansion opportunities?

---

## 🗂️ Database Schema

The project consists of four main tables:

### 1. City

Stores city-level information.

| Column | Description |
|---|---|
| city_id | Primary key |
| city_name | Name of the city |
| population | City population |
| estimated_rent | Estimated rent |
| city_rank | City ranking |

### 2. Customers

Stores customer information and their associated city.

| Column | Description |
|---|---|
| customer_id | Primary key |
| customer_name | Customer name |
| city_id | Foreign key referencing City |

### 3. Products

Stores coffee product information.

| Column | Description |
|---|---|
| product_id | Primary key |
| product_name | Product name |
| price | Product price |

### 4. Sales

Stores individual sales transactions.

| Column | Description |
|---|---|
| sale_id | Primary key |
| sale_date | Date of sale |
| product_id | Foreign key referencing Products |
| customer_id | Foreign key referencing Customers |
| total | Total sales amount |
| rating | Customer/product rating |

---
# 💡 Key Business Insights

## 1. Pune is the strongest existing market

- **₹12.58 lakh total sales** — highest among the analyzed cities.
- **52 customers** generating approximately **₹24.2K sales/customer**, indicating strong customer monetization.
- Estimated rent is **₹15,300**, resulting in approximately **82× sales-to-rent**, making Pune highly cost-efficient.

**Business implication:** Pune appears to be the strongest market for maintaining and scaling the existing business.

---

## 2. Jaipur offers a cost-efficient expansion opportunity

- **69 customers** — the highest customer base among the cities.
- Estimated rent of only **₹10,800**, the lowest rent among the highlighted markets.
- Generates **₹8.03 lakh** in sales with approximately **74× sales-to-rent**.

**Business implication:** Jaipur has a strong customer base and low operating-cost potential, making it attractive for cost-efficient expansion.

---

## 3. Delhi has the largest untapped market potential

- Estimated **7.75 million coffee consumers**, the largest potential consumer base in the dataset.
- **68 customers**, the second-highest customer base.
- Current sales are **₹7.50 lakh**, which is lower than Pune, Chennai, Bangalore, and Jaipur despite the significantly larger potential consumer market.

**Business implication:** Delhi could offer significant growth potential if the business can increase customer penetration.

---

## 4. High population does not automatically mean high sales

The analysis shows that market size and current sales performance are not always aligned.

For example:

- Delhi → **7.75M** estimated coffee consumers
- Mumbai → **5.10M**
- Bangalore → **3.08M**
- Chennai → **2.78M**

However, Pune generates the highest sales at **₹12.58 lakh**.

**Business implication:** Population size alone should not determine expansion decisions. Customer acquisition, spending behavior, rent, and existing sales performance should also be considered.

---

## 5. Customer monetization varies significantly by city

Pune generates approximately **₹24.2K sales per customer**, while:

- Chennai → **₹22.48K**
- Bangalore → **₹22.05K**
- Jaipur → **₹11.64K**
- Delhi → **₹11.04K**

**Business implication:** There is a significant difference in customer value across cities. Cities with lower sales per customer may have opportunities to increase revenue through higher purchase frequency, upselling, or premium products.

---

# 🏆 Market Expansion Recommendation

Based on the combined analysis rather than simply selecting the top 3 cities by sales:

| Priority | City | Strategic Reason |
|---|---|---|
| 🥇 | **Pune** | Highest sales + strong customer monetization + low relative rent |
| 🥈 | **Jaipur** | Highest customer base + lowest rent + strong sales-to-rent |
| 🥉 | **Delhi** | Largest estimated coffee consumer market + significant growth potential |

The recommendation balances **current performance, operating cost, customer base, and future market potential**.

---
