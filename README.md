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
| [`/sales_analysis`](./sales_analysis) | Revenue KPIs, growth trends, order volumes, top customers |
| [`/customer_behavior`](./customer_behavior) | Customer value, multi-year activity, segmentation |
| [`/risk_analysis`](./risk_analysis) | Returns, delayed deliveries, cancellation trends |

Each folder contains:
- ✅ Business-driven SQL questions
- 🧠 Insights from well-structured queries
- ⚙️ Advanced SQL features like `CTEs`, `JOINS`, `WINDOW FUNCTIONS`

---

## 🔍 Example Questions Answered

- How many orders were completed each year?
- What is the average delivery time by customer region?
- Who are the top 3 customers by total spend?
- What is the total revenue from each product category?
- What is the year-over-year sales growth from 2020 to 2025?
- How does revenue from completed orders compare to returned ones?

---

## 🛠 Tools

- SQL (MySQL/PostgreSQL)
- Git & GitHub

---

## 📫 Contact

Created by **[Your Name]**  
📧 your.email@example.com • [LinkedIn](https://linkedin.com/in/yourname)
