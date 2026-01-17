-- VIEW 2: EMPLOYEE BRANCH SUMMARY
-- Περιγραφή: Εμφανίζει το πλήθος και γενικές πληροφορίες υπαλλήλων που απασχολούνται από κάθε υποκατάστημα.


USE BankDB;

CREATE OR REPLACE VIEW employee_branch_summary AS
SELECT 
    ei.Name,
    ei.TIN,
    ei.EmpAddress,
    ei.Tel,
    ei.Email,
    bi.BranchID,
    bi.BranchAddress
FROM 
    -- branch_info (A): Π(BranchID, BranchAddress)
    (SELECT BranchID, Address AS BranchAddress 
     FROM bank_branch) AS bi
INNER JOIN 
    -- employee_info (B): EMAIL  'join'  TEL  'join'  Π(EmployeeID, TIN, Name, EmpAddress, BranchID)
    (SELECT 
        e.EmployeeID, e.TIN, e.Name, e.Address AS EmpAddress, e.BranchID,
        et.Tel,
        ee.Email
     FROM employee e
     INNER JOIN employee_tel et ON e.EmployeeID = et.EmployeeID
     INNER JOIN employee_email ee ON e.EmployeeID = ee.EmployeeID) AS ei
ON bi.BranchID = ei.BranchID;