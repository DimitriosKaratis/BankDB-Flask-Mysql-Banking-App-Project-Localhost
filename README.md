# 🏦 BankDB: A Banking Management System 

[![MySQL](https://img.shields.io/badge/Database-MySQL-blue.svg)](https://www.mysql.com/)
[![Python](https://img.shields.io/badge/Backend-Python_Flask-lightgrey.svg)](https://flask.palletsprojects.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)]()

## 📌 Project Overview
BankDB is a full-stack banking platform designed for secure and reliable financial management. It bridges the gap between complex relational database design and modern web interfaces. The system handles multi-role access, real-time balance tracking, and sophisticated transaction logic.

### 🌐 Live Deployment
The application is hosted and accessible online:
👉 **[Live Demo on Render](https://flask-mysql-bank-project.onrender.com/)** *(Note: Initial loading may take 30-50s due to Render's free-tier spin-up. Database hosted on Aiven Console).*

> [!NOTE]
> The live version linked above is maintained in a **separate repository** optimized for cloud deployment. The instructions below (in this repository) focus on the **local implementation** using `localhost` and a local MySQL instance.

---

## 💻 Local Implementation & Setup
Follow the steps below to run the application on your machine using a local environment.

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
### 2. Database Setup (CRITICAL STEP)
The application relies on a MySQL database named **'BankDB'**. You must set this up manually because the provided SQL dump file contains table structures but might not create the database itself.

### Execution Steps:

1. **Open your terminal** or command prompt.
2. **Log in to MySQL:**
   ```bash
   mysql -u root -p
   
**Step 3: Create the database**
```sql
CREATE DATABASE IF NOT EXISTS BankDB;
EXIT;
```


Step 4: Import the provided SQL dump (Dump20251219.sql) into the database (Run this from the project directory where the dump file is located):

 ```bash
mysql -u root -p BankDB < Dump20251219.sql
```

### 3. Configuration
The application connects to the database using credentials defined in app.py. Open app.py and look for the db_config dictionary (approx. line 11):

```Python

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'YOUR_MYSQL_PASSWORD',  # Ensure this matches your local MySQL password
    'database': 'BankDB'
}
Note: The current code may use the password '1234'. Change this if your local root password differs.
```

### 4. How to Launch the App
Navigate to the project folder in your terminal:

```bash

cd path/to/project_folder
```
Run the Flask application:

```bash

python3 app.py
```
Open your web browser and go to: http://127.0.0.1:5000

### 📖 User Manual

---

#### **A. Login**
* **Authentication:** Use a **Customer TIN** (Tax Identification Number) to log in.
* **Credentials:** * **Example Valid TIN:** `123456789` (User: Maria Papadopoulou).
    * **Password:** Enter any password to proceed (Development mode).

#### **B. Dashboard**
* **Account Overview:** View all accounts linked to your profile.
* **Live Balances:** Real-time balances are dynamically calculated using specialized SQL Views (`accounts_balance`).

#### **C. Money Transfer (Transaction)**
* **Reliability (ACID):** The system uses `start_transaction()`, `commit()`, and `rollback()` to ensure that no money is ever "lost" during a transfer.
* **Process:** Choose your source account, enter the recipient's Account Number, and specify the amount.

#### **D. Pay Loan & Credit Card**
* **Pay Loan:** Monitor your debt in real-time and make payments directly from your accounts.
* **Pay Credit Card:** Features a **Double Transaction Strategy** to simultaneously update credit limits and deduct the payment amount.

#### **E. Branch Locator & Settings**
* **Branches:** Access a full directory of all physical bank branch locations.
* **Settings:** * Update your **Physical Address**.
    * Manage and add multiple **Email aliases**.

---

### ⚙️ Technical Implementation Details

* **Security:** Implemented **Prepared Statements** for *every* database query to provide 100% protection against SQL Injection.
* **ID Management:** Uses a manual calculation for the next `TransactionID` ($MAX + 1$) to maintain strict uniqueness and sequence control.
* **Frontend Stack:** Built with **Bootstrap 5** for responsive design and **Jinja2** for dynamic server-side templating.
