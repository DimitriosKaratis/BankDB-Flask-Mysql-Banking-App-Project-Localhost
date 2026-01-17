-- VIEW 3: LOAN DEBTS
-- Περιγραφή: Συγκεντρώνει όλα τα δάνεια μαζί με το υπολοιπόμενο χρέος που το κάθε ένα έχει καθώς και σχετικές
-- πληροφορίες για τον πελάτη (ή τους πελάτες συνδικαιούχους) που αυτά αφορούν.


USE BankDB;

CREATE OR REPLACE VIEW loan_debts AS
SELECT 
    E.CustomerID, 
    E.Name, 
    E.TIN, 
    E.LoanID, 
    E.ExpirationDate, 
    E.Type, 
    E.Amount, 
    -- Σύνολο Ε: Υπολογισμός Debt = Amount + custLoanPaymentSum
    -- Η COALESCE διασφαλίζει ότι αν δεν υπάρχουν πληρωμές, το χρέος παραμένει ίσο με το αρχικό ποσό.
    (E.Amount + COALESCE(E.custLoanPaymentSum, 0)) AS Debt
FROM (
    -- Σύνολο D: Left Outer Join μεταξύ στοιχείων δανείου (C) και πληρωμών (B)
    SELECT 
        C.*, 
        B.custLoanPaymentSum
    FROM (
        -- Σύνολο C: Στοιχεία Πελάτη και Δανείου (CUSTOMER join LOAN)
        SELECT 
            cust.CustomerID, cust.Name, cust.TIN, 
            l.LoanID, l.ExpirationDate, l.Type, l.Amount
        FROM customer cust
        JOIN loan l ON cust.LoanID = l.LoanID 
    ) C
    LEFT JOIN (
        -- Σύνολο B: Υπολογισμός αθροίσματος πληρωμών δανείου ανά CustomerID
        SELECT 
            acc.CustomerID, 
            SUM(t.Amount) AS custLoanPaymentSum
        FROM account_transaction at
        JOIN transaction t ON at.TransactionID = t.TransactionID
        JOIN account acc ON at.AccountID = acc.AccountID
        WHERE at.MovementType = 'LoanPayment'
        GROUP BY acc.CustomerID
    ) B ON C.CustomerID = B.CustomerID
) E;