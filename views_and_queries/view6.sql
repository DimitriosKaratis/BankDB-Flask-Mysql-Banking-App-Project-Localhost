-- VIEW 6: V CUSTOMER ACCOUNTS
-- Περιγραφή: Συγκεντρώνει βασικές πληροφορίες για έναν συγκεκριμένο πελάτη και τους λογαριασμούς/δάνεια που διαθέτει.


USE BankDB;

CREATE OR REPLACE VIEW  v_customer_accounts_loan AS
SELECT 
    c.*,
    a.AccountID, 
    a.AccountNumber,
    a.Status as AccountStatus,
    a.OpeningDate as AccountOpeningDate,
    a.Currency,
    ab.Balance as AccountBalance,
    ce.Email,
    ct.Tel,
    l.Type as LoanType,
    l.OpeningDate as LoanOpeningDate,
    l.ExpirationDate as LoanExpirationDate,
    l.InterestRate,
    l.Amount as LoanAmount
FROM customer c
JOIN customer_email ce ON c.CustomerID = ce.CustomerID
JOIN customer_tel ct ON c.CustomerID = ct.CustomerID
JOIN account a ON c.CustomerID = a.CustomerID
JOIN accounts_balance ab ON a.AccountID = ab.AccountID
JOIN loan l ON l.loanID = c.loanID
-- Φιλτράρισμα με βάση το ΑΦΜ (TIN)
WHERE c.TIN = SUBSTRING_INDEX(USER(), '@', 1);


