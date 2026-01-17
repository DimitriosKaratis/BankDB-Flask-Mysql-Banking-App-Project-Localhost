-- Ερώτημα 6: Άθροισμα πληρωμών πιστωτικής κάρτας από λογαριασμό
-- Περιγραφή: Το ερώτημα αυτό αποσκοπεί στην εύρεση του αθροίσματος των πληρωμών πιστωτικής κάρτας που έχουν γίνει από κάθε λογαριασμό.


USE BankDB;

SELECT 
    ca.*, 
    A.creditTransSum
FROM customer_accounts AS ca
INNER JOIN (
    -- Υλοποίηση του συνόλου A (Ομαδοποίηση και Άθροιση)
    SELECT 
        cpt.AccountID, 
        SUM(t.Amount) AS CreditTransSum
    FROM credit_payment_transaction AS cpt
    INNER JOIN transaction AS t ON cpt.TransactionID = t.TransactionID
    INNER JOIN account AS acc ON cpt.AccountID = acc.AccountID
    GROUP BY cpt.AccountID
) AS A ON ca.AccountID = A.AccountID;