-- VIEW 4: ACCOUNTS BALANCE
-- Περιγραφή: Συγκεντρώνει όλους τους λογαριασμους μαζί με το διαθέσιμο υπόλοιπο που ο καθένας έχει.


USE BankDB;

CREATE OR REPLACE VIEW accounts_balance AS
SELECT 
    G.AccountID,
    G.AccSum,
    G.CrPaySum,
    G.DebSum,
    -- Σύνολο Η: Τελική προβολή και υπολογισμός Balance (H = AccSum + CrPaySum + DebSum)
    (G.AccSum + G.CrPaySum + G.DebSum) AS Balance
FROM (
    -- Σύνολο G: Φυσική συνένωση των επιμέρους αθροισμάτων B, D και F
    SELECT 
        acc.AccountID,
        COALESCE(B.AccSum, 0) AS AccSum,
        COALESCE(D.CrPaySum, 0) AS CrPaySum,
        COALESCE(F.DebSum, 0) AS DebSum
    FROM account acc
    
    -- Σύνολο B: Υπολογισμός AccSum από τον πίνακα account_transaction (πρώην Α και B)
    LEFT JOIN (
        SELECT at.AccountID, SUM(t.Amount) AS AccSum
        FROM account_transaction at
        JOIN transaction t ON at.TransactionID = t.TransactionID
        GROUP BY at.AccountID
    ) B ON acc.AccountID = B.AccountID

    -- Σύνολο D: Υπολογισμός CrPaySum από πληρωμές πιστωτικών καρτών (C και D)
    LEFT JOIN (
        SELECT cpt.AccountID, SUM(t.Amount) AS CrPaySum
        FROM credit_payment_transaction cpt
        JOIN transaction t ON cpt.TransactionID = t.TransactionID
        GROUP BY cpt.AccountID
    ) D ON acc.AccountID = D.AccountID

    -- Σύνολο F: Υπολογισμός DebSum από κινήσεις χρεωστικών καρτών (E και F)
    LEFT JOIN (
        SELECT dc.AccountID, SUM(t.Amount) AS DebSum
        FROM card_transaction ct
        JOIN transaction t ON ct.TransactionID = t.TransactionID
        JOIN debit_card dc ON ct.CardID = dc.CardID 
        GROUP BY dc.AccountID
    ) F ON acc.AccountID = F.AccountID
) G;
