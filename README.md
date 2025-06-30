# SQL Business Analytics Portfolio

This repository contains SQL projects that solve real-world business problems using a normalized relational database. Each project uses SQL to generate business insights around sales performance, customer behavior, and operational efficiency.

---

## 🗃️ Database Schema

This project is based on a simplified business database with four normalized tables:

### 🧑‍💼 `Customer`
Stores customer profiles and segmentation info.

| Column        | Description                      |
|---------------|----------------------------------|
| `CustomerID`  | Unique ID per customer           |
| `CustomerName`| Full name                        |
| `CompanyType` | Business type (e.g., Non-Profit) |
| `Region`      | Customer region                  |
| `JoinDate`    | Date customer signed up          |
| `TotalSpend`  | Lifetime value of customer       |

### 📦 `Order`
Contains order-level information.

| Column        | Description                             |
|---------------|------------------------------------------|
| `OrderID`     | Unique ID per order                      |
| `CustomerID`  | Foreign key → `Customer`                 |
| `OrderDate`   | Date the order was placed                |
| `TotalAmount` | Total value of the order                 |
| `OrderStatus` | Order status (`Completed`, `Returned`)   |
| `DeliveryTime`| Days taken to deliver                    |

### 🧾 `OrderDetail`
Captures line-item product information for each order.

| Column          | Description                   |
|------------------|-------------------------------|
| `OrderDetailID`  | Unique ID for each line item  |
| `OrderID`        | Foreign key → `Order`         |
| `ProductID`      | Foreign key → `Product`       |
| `Quantity`       | Units ordered                 |
| `Subtotal`       | Line item total cost          |

### 🛍️ `Product`
Represents items available for purchase.

| Column      | Description                      |
|-------------|----------------------------------|
| `ProductID` | Unique product ID                |
| `ProductName` | Name of the product             |
| `Category`  | Product category (e.g., Electronics) |
| `Price`     | Price per unit                   |
| `Supplier`  | Vendor or manufacturer           |
| `StockLevel`| Units in inventory               |

---

## 📁 Project Folders

| Folder | Description |
|--------|-------------|
| [`/sales_analysis`](https://github.com/CZIKPI/sql-business-analytics/blob/main/sales_dashboard_queries.sql) | Revenue KPIs, growth trends, order volumes, top customers |

Each folder contains:
- ✅ Business-driven SQL questions
- 🧠 Insights from well-structured queries
- ⚙️ Advanced SQL features like `CTEs`, `JOINS`, `WINDOW FUNCTIONS`

---

## Key Analyses
| Query | Description |
|-------|-------------|
| Q1    | Orders placed each year |
| Q2    | Revenue per year (completed orders) |
| Q3    | Month with most orders |
| Q4    | Year-over-year sales growth |
| Q5    | Highest avg order amount by year |
| Q6    | Revenue: Completed vs Pending |
| Q7    | Avg shipping time (days) |
| Q8    | Running monthly total |
| Q9    | Top 3 customers by revenue |
| Q10   | Cancelled orders per year |
| Q11   | Avg order in Q1 per year |
| Q12   | Customers ordering in multiple years |
---

## 🛠 Tools

- SQL (MySQL/PostgreSQL)
- Git & GitHub

---

## 📫 Contact

Created by **[Christian Zikpi]**  
📧 christianzikpi@gmail.com • [LinkedIn](https://linkedin.com/in/kzikpi)
