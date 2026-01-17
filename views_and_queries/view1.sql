-- VIEW 1: CUSTOMER ACCOUNTS
-- Περιγραφή: Συγκεντρώνει βασικές πληροφορίες για όλους τους πελάτες και τους λογαριασμούς που διαθέτουν.


USE BankDB;

CREATE OR REPLACE VIEW customer_accounts AS
SELECT 
    c.CustomerID, 
    c.TIN, 
    c.Name, 
    a.AccountID, 
    a.AccountNumber, 
    a.Currency
FROM customer c
-- Π(CustomerID, Name, TIN)  'join'  Π(AccountID, CustomerID, AccountNumber, Currency)
JOIN account a ON c.CustomerID = a.CustomerID
-- Ταξινόμηση αποτελεσμάτων κατά ID πελάτη (αύξουσα σειρά)
ORDER BY c.CustomerID ASC;