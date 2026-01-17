# Data Bases Project: BankDB. A Banking Management System 

[![MySQL](https://img.shields.io/badge/Database-MySQL-blue.svg)](https://www.mysql.com/)
[![Python](https://img.shields.io/badge/Backend-Python_Flask-lightgrey.svg)](https://flask.palletsprojects.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)]()

## 📌 Project Overview
BankDB is a full-stack banking platform designed for secure and reliable financial management. It bridges the gap between complex relational database design and modern web interfaces. The system handles multi-role access, real-time balance tracking, and sophisticated transaction logic.

### 🌐 Live Deployment
The application is hosted and accessible online:
👉 **[Live Demo on Render](https://flask-mysql-bank-project.onrender.com/)** *(Note: Initial loading may take 30-50s due to Render's free-tier spin-up. Database hosted on Aiven Console).*

---

## 🏗️ Technical Architecture

### 1. Database & Schema Design
The backend is powered by a **MySQL** database designed in **Third Normal Form (3NF)** to ensure zero data redundancy and maximum integrity.
- **Relational Integrity:** Strict use of Foreign Keys and Constraints across 10+ tables.
- **Security:** Implementation of **Prepared Statements** in all SQL queries to prevent SQL Injection attacks.
- **Views:** Optimized data retrieval through custom views like `customer_accounts` and `accounts_balance`.



### 2. Transaction Logic & Reliability
Financial accuracy is guaranteed through:
- **ACID Transactions:** Money transfers utilize `start_transaction()`, `commit()`, and `rollback()` mechanisms to ensure that no funds are lost in case of a system or network failure.
- **Double Transaction Strategy:** Credit card payments are handled as a synchronized two-step process: adjusting the card's available balance while simultaneously deducting funds from the linked bank account.
- **Manual ID Calculation:** To ensure uniqueness without relying on specific DB auto-increments, the app dynamically calculates the next `TransactionID` using `MAX+1` logic.

---

## 💻 Features & User Manual

### For Customers:
* **Dashboard:** Real-time view of all bank accounts (Savings, Checking, etc.) and current balances.
* **Money Transfer:** Secure fund movement between accounts by providing the recipient's Account ID.
* **Credit Card Management:** Pay off outstanding debt and monitor remaining credit limits.
* **Branch Locator:** Find physical bank branches by city or name.
* **Settings:** Manage personal profile, update physical addresses, and handle multiple email aliases.

---

## 🛠️ Local Installation & Setup

### 1. Prerequisites
* Python 3.x
* MySQL Server
* Libraries: `pip install flask mysql-connector-python`

### 2. Database Configuration
1. Log in to your MySQL terminal and create the schema:
   ```sql
   CREATE DATABASE IF NOT EXISTS BankDB;
Import the provided SQL dump:

Bash

mysql -u root -p BankDB < db_dump.sql
Update the db_config dictionary in app.py with your local credentials.

3. Run the App
Bash

python app.py
Open your browser at http://127.0.0.1:5000.
