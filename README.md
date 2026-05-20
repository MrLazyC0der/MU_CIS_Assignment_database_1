# 🛒 Store Database — SQL Server Project

A relational database designed for managing an online store, built with **Microsoft SQL Server (T-SQL)**. It covers product categories, customer management, order processing, and order item tracking.

---

## 📐 Entity Relationship Diagram (ERD)

The database is designed based on the following ERD:

```
CATEGORIES ──(1)── BELONGS_TO ──(N)── PRODUCTS
                                          │
                                         (1)
                                          │
                                       INCLUDES
                                          │
                                         (N)
                                          │
CUSTOMERS ──(1)── PLACES ──(N)── ORDERS ──(1)── CONTAINS ──(N)── ORDER_ITEMS
```

---

## 🗂️ Database Schema

### 1. `categories`
Stores product categories.

| Column          | Type           | Constraints        |
|-----------------|----------------|--------------------|
| `category_id`   | INT (IDENTITY) | PRIMARY KEY        |
| `category_name` | VARCHAR(100)   | NOT NULL           |
| `description`   | VARCHAR(255)   | —                  |

---

### 2. `customers`
Stores customer information.

| Column        | Type           | Constraints        |
|---------------|----------------|--------------------|
| `customer_id` | INT (IDENTITY) | PRIMARY KEY        |
| `name`        | VARCHAR(100)   | NOT NULL           |
| `email`       | VARCHAR(100)   | UNIQUE             |
| `phone`       | VARCHAR(20)    | —                  |
| `address`     | VARCHAR(255)   | —                  |

---

### 3. `products`
Stores product details linked to a category.

| Column         | Type            | Constraints                          |
|----------------|-----------------|--------------------------------------|
| `product_id`   | INT (IDENTITY)  | PRIMARY KEY                          |
| `product_name` | VARCHAR(150)    | NOT NULL                             |
| `price`        | DECIMAL(10,2)   | NOT NULL                             |
| `stock_qty`    | INT             | DEFAULT 0                            |
| `category_id`  | INT             | FK → `categories(category_id)`       |

---

### 4. `orders`
Stores orders placed by customers.

| Column         | Type            | Constraints                          |
|----------------|-----------------|--------------------------------------|
| `order_id`     | INT (IDENTITY)  | PRIMARY KEY                          |
| `customer_id`  | INT             | NOT NULL, FK → `customers(customer_id)` |
| `order_date`   | DATETIME        | DEFAULT GETDATE()                    |
| `total_amount` | DECIMAL(10,2)   | —                                    |
| `status`       | VARCHAR(50)     | DEFAULT `'pending'`                  |

---

### 5. `order_items`
Stores individual items within each order.

| Column       | Type            | Constraints                          |
|--------------|-----------------|--------------------------------------|
| `item_id`    | INT (IDENTITY)  | PRIMARY KEY                          |
| `order_id`   | INT             | NOT NULL, FK → `orders(order_id)`    |
| `product_id` | INT             | NOT NULL, FK → `products(product_id)`|
| `quantity`   | INT             | NOT NULL                             |
| `unit_price` | DECIMAL(10,2)   | NOT NULL                             |

---

## 🔗 Relationships

| Relationship  | Type  | Description                                      |
|---------------|-------|--------------------------------------------------|
| BELONGS_TO    | 1 → N | One category contains many products              |
| PLACES        | 1 → N | One customer can place many orders               |
| CONTAINS      | 1 → N | One order contains many order items              |
| INCLUDES      | 1 → N | One product can appear in many order items       |

---

## 🚀 Getting Started

### Prerequisites
- Microsoft SQL Server (2016 or later)
- SQL Server Management Studio (SSMS) or Azure Data Studio

### Setup Instructions

1. **Clone or download** this repository.
2. **Open** the `.sql` file in SSMS or Azure Data Studio.
3. **Run** the full script to:
   - Create the `store` database
   - Create all 5 tables with constraints
   - Insert sample data

```sql
-- Run this in SSMS
USE master;
GO
-- Then execute the full script
```

---

## 📦 Sample Data

The script includes pre-loaded sample data:

- **5 Categories** — Electronics, Clothes, Furniture, Books, Sports
- **5 Customers** — from Cairo, Alexandria, Giza, Assiut, Mansoura
- **5 Products** — Dell Laptop, Samsung Mobile, Cotton T-Shirt, Office Chair, SQL Book
- **5 Orders** — with statuses: `completed`, `pending`, `cancelled`
- **5 Order Items** — linked to orders and products

---

## 📁 Project Structure

```
store-database/
│
├── store.sql        # Full database script (DDL + DML)
├── ERD.png          # Entity Relationship Diagram
└── README.md        # Project documentation
```

---

## 🛠️ Technologies Used

- **Database:** Microsoft SQL Server
- **Language:** T-SQL (Transact-SQL)
- **Design:** ERD (Entity Relationship Diagram)

---

## 📄 License

This project is open-source and available for educational use.