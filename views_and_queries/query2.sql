-- Ερώτημα 2: Ενεργές χρεωστικές κάρτες πελάτη
-- Περιγραφή: Το ερώτημα αυτό αποσκοπεί στην επιλογή όλων των ενεργών χρεωστικών καρτών κάθε πελάτη.


USE BankDB;

-- Επιλογή των τελικών στηλών
SELECT 
    ac.CardID, 
    ac.CardNumber, 
    ac.CardholderName, 
    ac.CVV, 
    ac.ExpirationDate, 
    ca.CustomerID, 
    ca.TIN, 
    ca.Name
FROM (
    -- Π(CardID, CardNumber, CardholderName, CVV, ExpirationDate)(σ Status='Active'(CARD))
    SELECT CardID, CardNumber, CardholderName, CVV, ExpirationDate 
    FROM card 
    WHERE Status = 'Active'
) AS ac
INNER JOIN debit_card dc ON ac.CardID = dc.CardID
INNER JOIN customer_accounts ca ON dc.AccountID = ca.AccountID;