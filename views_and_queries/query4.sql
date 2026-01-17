-- Ερώτημα 4: Πελάτες με ενεργό στεγαστικό δάνειο
-- Περιγραφή: Το ερώτημα αυτό αποσκοπεί στην εύρεση όλων των πελατών που έχουν ενεργό στεγαστικό δάνειο.


USE BankDB;

-- Επιλογή όλων των τελικών στηλών
SELECT 
	active_loans.LoanID, 
    active_loans.Type, 
    c.CustomerID, 
    c.TIN, c.Name, 
    c.Address
FROM (
	-- Π(LoanID, Type)(σ Debt>0 and Type='Housing'(LOAN DEBTS))
    SELECT LoanID, Type 
    FROM loan_debts 
    WHERE Debt > 0 AND Type = 'Housing'
) AS active_loans
-- Π(CustomerID, TIN, Name, Address, LoanID)(CUSTOMER)
INNER JOIN (
    SELECT CustomerID, TIN, Name, Address, LoanID 
    FROM customer
) AS c ON active_loans.LoanID = c.LoanID;