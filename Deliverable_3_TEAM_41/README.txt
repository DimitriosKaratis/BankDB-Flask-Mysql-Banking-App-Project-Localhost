BANK MANAGEMENT WEB APPLICATION - USER MANUAL & TECHNICAL GUIDE
================================================================

1. PROJECT OVERVIEW
-------------------
This is a full-stack web application developed using Python (Flask) and MySQL. 
It provides a secure interface for customers to view their bank accounts, perform money transfers, 
and locate bank branches.

2. PREREQUISITES
----------------
Before running the application, ensure you have the following installed on your machine:
- Python 3.x
- MySQL Server (must be running properly)
- Python Libraries: flask, mysql-connector-python

To install the required libraries (using pip or pip3), run:
   pip install flask mysql-connector-python

3. DATABASE SETUP (CRITICAL STEP)
---------------------------------
The application relies on a MySQL database named 'BankDB'. You must set this up manually 
because the provided SQL dump file contains table structures but might not create the database itself.

Step 1: Open your terminal/command prompt.
Step 2: Log in to MySQL:
   mysql -u root -p

Step 3: Create the database:
   CREATE DATABASE IF NOT EXISTS BankDB;
   EXIT;

Step 4: Import the provided SQL dump (Dump20251219.sql) into the database (from the directory of the project, where the dump file is located):
   mysql -u root -p BankDB < Dump20251219.sql

4. CONFIGURATION
----------------
The application connects to the database using credentials defined in 'app.py'.
Open 'app.py' and look for the 'db_config' dictionary (approx. line 11):

   db_config = {
       'host': 'localhost',
       'user': 'root',
       'password': 'YOUR_MYSQL_PASSWORD',  <-- Make sure this matches your local MySQL password
       'database': 'BankDB'
   }

*Note: The current code uses the password '1234'. Change this if your local root password differs, which it will.*

5. HOW TO LAUNCH THE APP
------------------------
1. Navigate to the project folder in your terminal. (For example in Linux):
   cd path/to/project_folder

2. Run the Flask application. (For example in Linux):
   python3 app.py

3. You will see output indicating the server is running (usually on http://127.0.0.1:5000).
4. Open your web browser and go to: http://127.0.0.1:5000

6. HOW TO USE THE APPLICATION
-----------------------------

A. LOGIN
   - The system does not use a separate 'users' table. Instead, it authenticates existing Customers using their TIN.
   - Go to the Login page.
   - Enter a valid TIN (Tax Identification Number).
     Example Valid TIN: 123456789 (User: Maria Papadopoulou)
   - Enter any password.

B. DASHBOARD
   - Once logged in, you will see the 'Dashboard'.
   - This page lists all accounts belonging to the logged-in customer.
   - It displays the Account Number, Currency, Status, Current Balance etc.
   - The balance is calculated dynamically using the 'accounts_balance' SQL View logic. Note that Total Networth calculation takes into consideration the current balance of ALL customer's accounts, whether they are active or not.

C. MONEY TRANSFER (TRANSACTION)
   - Click 'Transfer' in the navigation bar.
   - From Account: Select one of your accounts from the dropdown menu.
   - To Account Number: Enter the full Account Number of the recipient.
     (You can find example account numbers in the SQL dump, e.g., GR1311891434567890123456789).
   - Amount: Enter a positive value.
   - Click 'Confirm Transfer'.
   - If successful, you are redirected to the dashboard with updated balances.
   - If failed (insufficient funds, invalid account), an error message appears.

D. BRANCH LOCATOR
   - Click 'Branches' in the navigation bar.
   - This page lists all available bank branches, including addresses, operating hours, and contact details.

E. PAY LOAN
   - Click 'Pay Loan' in the navigation bar.
   - Shows your active loan details (Amount, Expiration Date, Current Debt).
   - Select one of your accounts to pay from.
   - Enter the amount you wish to pay.
   - Click 'Confirm Payment'.
   - The system validates sufficient funds and that you aren't overpaying the debt.

F. PAY CREDIT CARD
   - Click 'Pay Card' in the navigation bar.
   - Lists your credit cards that have outstanding debt (Available Balance < Limit).
   - Select the credit card to pay off.
   - Select the source account.
   - Enter the amount.
   - Click 'Confirm Payment'.
   - This re-adjusts your credit card's available balance and deducts from your account.

G. SETTINGS
   - Click 'Settings' in the navigation bar.
   - View your personal details (Name, TIN, phone numbers).
   - Update your Physical Address.
   - Manage Email Addresses: Add new emails, update existing ones, or delete old ones.

7. TECHNICAL IMPLEMENTATION DETAILS
---------------------------------------------------
- Framework: Python Flask (backend), Bootstrap 5, Jinja2 (frontend).
- Database: MySQL.
- Security:
  * Prepared Statements: Used for ALL database queries to prevent SQL Injection.
  * ACID Transactions: Money transfers use 'conn.start_transaction()', 'commit()', and 'rollback()' 
    to ensure that money is never lost if a step fails.
  * Session Management: Uses Flask sessions to keep users logged in securely.
- Logic:
  * Application Handles Transactions: Since the schema lacked AUTO_INCREMENT on TransactionID, 
    the app manually calculates the next ID (MAX + 1) to ensure uniqueness.
  * Data Views: Uses 'customer_accounts', 'accounts_balance' views etc. for data retrieval.


** NOTE: The app is also hosted live in the following URL: https://flask-mysql-bank-project.onrender.com/, thanks to Render and Aiven hosting services. **