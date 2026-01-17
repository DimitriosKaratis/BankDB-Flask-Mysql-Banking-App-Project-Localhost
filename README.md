# BankDB: A Banking Management System 

[![MySQL](https://img.shields.io/badge/Database-MySQL-blue.svg)](https://www.mysql.com/)
[![Python](https://img.shields.io/badge/Backend-Python_Flask-lightgrey.svg)](https://flask.palletsprojects.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)]()

## 📌 Project Overview
BankDB is a full-stack banking platform designed for secure and reliable financial management. It bridges the gap between complex relational database design and modern web interfaces. The system handles multi-role access, real-time balance tracking, and sophisticated transaction logic.

### 🌐 Live Deployment
The application is hosted and accessible online:
👉 **[Live Demo on Render](https://flask-mysql-bank-project.onrender.com/)** *(Note: Initial loading may take 30-50s due to Render's free-tier spin-up. Database hosted on Aiven Console).*

---

## 🏗️ Technical Architecture & Security

### 1. Database & Schema Design
The system is built on a **MySQL** database designed in **Third Normal Form (3NF)** to ensure zero data redundancy.
- **Relational Integrity:** Strict use of Foreign Keys and constraints across 10+ tables.
- **Optimized Retrieval:** Extensive use of SQL Views (e.g., `customer_accounts`, `accounts_balance`) to simplify complex data reporting.



### 2. Security & Reliability Features
- **ACID Transactions:** Money transfers implement full ACID properties. Using `conn.start_transaction()`, `commit()`, and `rollback()`, the system ensures that funds are never lost or duplicated in case of network or hardware failure.
- **SQL Injection Protection:** All database interactions utilize **Prepared Statements** to sanitize user input.
- **Manual ID Calculation:** Due to the lack of `AUTO_INCREMENT` in certain legacy schema parts, the application dynamically calculates the next `TransactionID` using `MAX+1` logic to ensure absolute uniqueness.
- **Double Transaction Strategy:** Credit card payments are handled as synchronized two-step processes: re-adjusting the card's available balance while simultaneously deducting the amount from the linked bank account.

---

## 💻 User Features

* **Dashboard:** View real-time balances for all linked accounts (Savings, Checking, etc.).
* **Money Transfer:** Execute secure capital movements between accounts.
* **Credit Card Management:** Monitor credit limits and pay off outstanding debt.
* **Branch Locator:** Search for physical bank branches by city or name.
* **Settings:** Dynamically update physical addresses and manage multiple email aliases.

---

## 🛠️ Installation & Local Setup

Follow these steps to run the application on your local machine:

### 1. Prerequisites
Ensure you have the following installed:
- **Python 3.x**
- **MySQL Server**
- Required Libraries:
  ```bash
  pip install flask mysql-connector-python
2. Database Setup (Critical)
The application relies on a database named BankDB.

Open your MySQL terminal/Workbench and log in:

SQL

CREATE DATABASE IF NOT EXISTS BankDB;
Import the SQL Dump: Navigate to the project directory and run:

Bash

mysql -u your_username -p BankDB < Dump20251219.sql
3. Configuration
Open app.py and update the db_config dictionary with your local MySQL credentials:

Python

db_config = {
    'host': 'localhost',
    'user': 'your_username',
    'password': 'your_password',
    'database': 'BankDB'
}
4. Running the Application
Execute the following command in your terminal:

Bash

python app.py
Access the web interface at: http://127.0.0.1:5000
