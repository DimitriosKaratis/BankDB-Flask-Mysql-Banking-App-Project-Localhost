-- VIEW 5: CREDIT CARD BALANCE
-- Περιγραφή: Συγκεντρώνει όλες τις πιστωτικές κάρτες με το διαθέσιμο υπόλοιπο που η κάθε μια έχει.
   
   
USE BankDB;

CREATE OR REPLACE VIEW credit_card_balance AS
SELECT 
    CC.CardID,
    CC.CreditLimit,
    -- Υπολογισμός διαθέσιμου υπολοίπου: Όριο - (συνολικές πληρωμές)
    -- Χρησιμοποιούμε COALESCE(..., 0) ώστε αν δεν υπάρχει καμία πληρωμή, 
    -- το υπόλοιπο να ισούται με το όριο και όχι με NULL.
    (CC.CreditLimit + COALESCE(Pay.CreditPaySum, 0)) AS AvailableBalance
FROM credit_card CC


-- B: Σύνδεση με το άθροισμα των πληρωμών (CreditPaySum) ανά CardID
LEFT JOIN (
    SELECT 
        CPT.CardID, 
        SUM(T.Amount) AS CreditPaySum
    FROM credit_payment_transaction CPT
    JOIN transaction T ON CPT.TransactionID = T.TransactionID
    GROUP BY CPT.CardID
) Pay ON CC.CardID = Pay.CardID;