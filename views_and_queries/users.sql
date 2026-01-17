# ΧΡΗΣΤΕΣ ΤΗΣ ΒΑΣΗΣ

USE BankDB;

-- ==========================================================
-- 1. ΔΙΑΧΕΙΡΙΣΤΗΣ (Admin)
-- ==========================================================
DROP USER IF EXISTS 'bank_admin'@'localhost';
CREATE USER 'bank_admin'@'localhost' IDENTIFIED BY 'admin123';
-- Πλήρη πρόσβαση (ALL PRIVILEGES) σε όλη τη βάση BankDB
GRANT ALL PRIVILEGES ON BankDB.* TO 'bank_admin'@'localhost' WITH GRANT OPTION;


-- ==========================================================
-- 2. ΔΙΕΥΘΥΝΤΗΣ ΚΑΤΑΣΤΗΜΑΤΟΣ (Manager)
-- ==========================================================
DROP USER IF EXISTS 'manager'@'%';
CREATE USER 'manager'@'%' IDENTIFIED BY 'manPass2025';

-- 1. ΛΟΓΑΡΙΑΣΜΟΙ
GRANT SELECT ON BankDB.account TO 'manager'@'%';
GRANT SELECT ON BankDB.savings_account TO 'manager'@'%';
GRANT SELECT ON BankDB.checking_account TO 'manager'@'%';

-- 2. ΚΑΡΤΕΣ 
GRANT SELECT ON BankDB.card TO 'manager'@'%';
GRANT SELECT ON BankDB.credit_card TO 'manager'@'%';
GRANT SELECT ON BankDB.debit_card TO 'manager'@'%';

-- 3. ΣΥΝΑΛΛΑΓΕΣ 
GRANT SELECT ON BankDB.transaction TO 'manager'@'%';
GRANT SELECT ON BankDB.account_transaction TO 'manager'@'%';
GRANT SELECT ON BankDB.card_transaction TO 'manager'@'%';
GRANT SELECT ON BankDB.credit_payment_transaction TO 'manager'@'%';

-- 4. ΠΕΛΑΤΕΣ & ΕΠΙΚΟΙΝΩΝΙΑ ΠΕΛΑΤΩΝ
GRANT SELECT ON BankDB.customer TO 'manager'@'%';
GRANT SELECT ON BankDB.customer_email TO 'manager'@'%';
GRANT SELECT ON BankDB.customer_tel TO 'manager'@'%';

-- 5. ΠΡΟΣΩΠΙΚΟ & ΕΠΙΚΟΙΝΩΝΙΑ ΠΡΟΣΩΠΙΚΟΥ 
GRANT SELECT, INSERT, UPDATE ON BankDB.employee TO 'manager'@'%';
GRANT SELECT, INSERT, UPDATE ON BankDB.employee_email TO 'manager'@'%';
GRANT SELECT, INSERT, UPDATE ON BankDB.employee_tel TO 'manager'@'%';

-- 6. ΥΠΟΚΑΤΑΣΤΗΜΑΤΑ & ΕΠΙΚΟΙΝΩΝΙΑ ΥΠΟΚΑΤΑΣΤΗΜΑΤΩΝ
GRANT SELECT, INSERT, UPDATE ON BankDB.bank_branch TO 'manager'@'%';
GRANT SELECT, INSERT, UPDATE ON BankDB.bank_branch_email TO 'manager'@'%';
GRANT SELECT, INSERT, UPDATE ON BankDB.bank_branch_tel TO 'manager'@'%';
GRANT SELECT, INSERT, UPDATE ON BankDB.served_by TO 'manager'@'%';

-- 7. ΔΑΝΕΙΑ & ΟΨΕΙΣ
GRANT SELECT, INSERT, UPDATE ON BankDB.loan TO 'manager'@'%';
GRANT SELECT ON BankDB.accounts_balance TO 'manager'@'%';
GRANT SELECT ON BankDB.credit_card_balance TO 'manager'@'%';
GRANT SELECT ON BankDB.customer_accounts TO 'manager'@'%';
GRANT SELECT ON BankDB.employee_branch_summary TO 'manager'@'%';
GRANT SELECT ON BankDB.loan_debts TO 'manager'@'%';



-- ==========================================================
-- 3. ΥΠΑΛΛΗΛΟΣ ΚΑΤΑΣΤΗΜΑΤΟΣ (Employee)
-- ==========================================================
DROP USER IF EXISTS 'bank_emp'@'localhost';
CREATE USER 'bank_emp'@'localhost' IDENTIFIED BY 'empPass2025';

-- 1. Ο υπάλληλος βλέπει τα βασικά στοιχεία των συναδέλφων του (χωρίς TIN, DoB)
GRANT SELECT (Employeeid, Name, Branchid) ON BankDB.employee TO 'bank_emp'@'localhost';

-- 2. Ο υπάλληλος βλέπει τα email και τηλέφωνα για εσωτερική επικοινωνία
GRANT SELECT ON BankDB.employee_email TO 'bank_emp'@'localhost';
GRANT SELECT ON BankDB.employee_tel TO 'bank_emp'@'localhost';

-- 1. ΠΕΛΑΤΕΣ & ΕΠΙΚΟΙΝΩΝΙΑ (Δικαίωμα εγγραφής νέων πελατών)
GRANT SELECT, INSERT, UPDATE ON BankDB.customer TO 'bank_emp'@'localhost';
GRANT SELECT, INSERT, UPDATE ON BankDB.customer_email TO 'bank_emp'@'localhost';
GRANT SELECT, INSERT, UPDATE ON BankDB.customer_tel TO 'bank_emp'@'localhost';

-- 2. ΛΟΓΑΡΙΑΣΜΟΙ (Άνοιγμα λογαριασμών και διαχείριση υπολοίπου)
GRANT SELECT, INSERT, UPDATE ON BankDB.account TO 'bank_emp'@'localhost';
GRANT SELECT, INSERT, UPDATE ON BankDB.savings_account TO 'bank_emp'@'localhost';
GRANT SELECT, INSERT, UPDATE ON BankDB.checking_account TO 'bank_emp'@'localhost';

-- 3. ΣΥΝΑΛΛΑΓΕΣ (Μόνο SELECT και INSERT - Όχι αλλαγές σε καταχωρημένες κινήσεις)
GRANT SELECT, INSERT ON BankDB.transaction TO 'bank_emp'@'localhost';
GRANT SELECT, INSERT ON BankDB.account_transaction TO 'bank_emp'@'localhost';
GRANT SELECT, INSERT ON BankDB.card_transaction TO 'bank_emp'@'localhost';
GRANT SELECT, INSERT ON BankDB.credit_payment_transaction TO 'bank_emp'@'localhost';

-- 4. ΚΑΡΤΕΣ (Έκδοση νέας κάρτας και αλλαγή status π.χ. απώλεια. Δεν μπορεί να ενημερώσει όρια ανάληψης κλπ για τις χρεωστικές και πιστωτικές)
GRANT SELECT, INSERT, UPDATE ON BankDB.card TO 'bank_emp'@'localhost';
GRANT SELECT, INSERT ON BankDB.debit_card TO 'bank_emp'@'localhost';
GRANT SELECT, INSERT ON BankDB.credit_card TO 'bank_emp'@'localhost';

-- 5. ΔΑΝΕΙΑ (Μόνο SELECT για πληροφόρηση και INSERT για υποβολή αίτησης)
GRANT SELECT, INSERT ON BankDB.loan TO 'bank_emp'@'localhost';

-- 6. ΥΠΟΚΑΤΑΣΤΗΜΑΤΑ (Μόνο SELECT για πληροφόρηση)
GRANT SELECT ON BankDB.bank_branch TO 'bank_emp'@'localhost';
GRANT SELECT ON BankDB.bank_branch_email TO 'bank_emp'@'localhost';
GRANT SELECT ON BankDB.bank_branch_tel TO 'bank_emp'@'localhost';
GRANT SELECT ON BankDB.served_by TO 'bank_emp'@'localhost';

-- 7. ΠΡΟΣΒΑΣΗ ΣΤΙΣ ΟΨΕΙΣ 
-- Ο υπάλληλος βλέπει ΜΟΝΟ τα απαραίτητα στοιχεία επικοινωνίας των συναδέλφων του
GRANT SELECT ON BankDB.accounts_balance TO 'bank_emp'@'localhost';
GRANT SELECT ON BankDB.credit_card_balance TO 'bank_emp'@'localhost';
GRANT SELECT ON BankDB.customer_accounts TO 'bank_emp'@'localhost';
GRANT SELECT (Name, Tel, Email, BranchID) ON BankDB.employee_branch_summary TO 'bank_emp'@'localhost';
GRANT SELECT ON BankDB.loan_debts TO 'bank_emp'@'localhost';


-- ==========================================================
-- 4. ΠΕΛΑΤΗΣ (Customer)
-- ==========================================================
-- Δημιουργία του γενικού χρήστη πελάτη (ως παράδειγμα)
DROP USER IF EXISTS 'bank_customer'@'%';
CREATE USER 'bank_customer'@'%' IDENTIFIED BY 'custPass2025';
-- Ο πελάτης βλέπει τα δικά του στοιχεία  (SELECT) μόνο.
-- Στην πράξη, κάθε πελάτης θα είχε το δικό του Login με το email και τον κωδικό πρόσβασής του
GRANT SELECT ON BankDB.v_customer_accounts_loan TO 'bank_customer'@'%';
-- Δίνουμε δικαίωμα αλλαγής ΜΟΝΟ στο Email και τη Διεύθυνση. Όλα τα υπόλοιπα πρέπει να γίνουν σε κάποιο υποκατάστημα.
GRANT UPDATE (Email, Address) ON BankDB.v_customer_accounts_loan TO 'bank_customer'@'%';

-- Για τον Πελάτη, η όλη λογική βασίζεται στο ότι η βάση «καταλαβαίνει» ποιος είσαι μόλις συνδεθείς. Αντί να του 
-- δώσουμε πρόσβαση στους πίνακες όπου φαίνονται όλα τα στοιχεία όλων των πελατών, του δίνουμε πρόσβαση μόνο στην «έξυπνη» 
-- όψη v_customer_accounts_loan η οποία δημιουργήθηκε για αυτόν τον σκοπό και μόνο. Αυτή η όψη παίρνει το ΑΦΜ (TIN) με το οποίο έκανε
-- login ο κάθε πελάτης και φιλτράρει αυτόματα μερικά από τα διαθέσιμα δεδομένα του, 
-- δείχνοντάς του σε μία γραμμή τους λογαριασμούς, τα δάνειά κλπ. Να σημειωθεί επίσης ότι 
-- στην πράξη, κάθε πελάτης θα είχε το δικό του Login με βάση το email και τον κωδικό πρόσβασής του, ενώ κανονικά θα έπρεπε να εμφανίζονται
-- ΟΛΕΣ οι πληροφορίες σχετικές με τον πελάτη (δηλαδή και υπόλοιπα πιστωτικής κάρτας κλπ), επομένως, θα έπρεπε να προστεθούν και επιπλέον
-- όψεις αποκλειστικά και μόνο για τον σκοπό αυτόν. 


-- Εφαρμογή των αλλαγών
FLUSH PRIVILEGES;
