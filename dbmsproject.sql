create database project;
use project;
-- BANKSTAFF TABLE
CREATE TABLE BankStaff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(50),
    Department VARCHAR(50),
    Address VARCHAR(200),
    Email VARCHAR(100),
    PhoneNo VARCHAR(15)
);

-- ACCOUNT TABLE
CREATE TABLE Account (
    AccountID INT PRIMARY KEY,
    Balance DECIMAL(15,2),
    DebitDate DATE,
    CreditDate DATE,
    Type VARCHAR(50)
);

-- RELATIONSHIP: BankStaff MANAGES Account (N:1)
CREATE TABLE Manages (
    StaffID INT,
    AccountID INT,
    PRIMARY KEY (StaffID, AccountID),
    FOREIGN KEY (StaffID) REFERENCES BankStaff(StaffID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- CUSTOMER TABLE
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Address VARCHAR(200),
    Contact VARCHAR(15),
    Username VARCHAR(50),
    UPassword VARCHAR(50),
    AccountID INT,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- TRANSACTION TABLE
CREATE TABLE Transaction (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    Type VARCHAR(50),
    Amount DECIMAL(15,2),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- RELATIONSHIP: Customer initiates Transaction
CREATE TABLE Initiates (
    CustomerID INT,
    TransactionID INT,
    PRIMARY KEY (CustomerID, TransactionID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (TransactionID) REFERENCES Transaction(TransactionID)
);

-- DEPOSITOR TABLE
CREATE TABLE Depositor (
    DName VARCHAR(100),
    AccountID INT,
    Address VARCHAR(200),
    PhoneNo VARCHAR(15),
    Email VARCHAR(100),
    PRIMARY KEY (DName, AccountID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- RELATIONSHIP: Customer associates Depositor
CREATE TABLE Associates (
    CustomerID INT,
    DName VARCHAR(100),
    AccountID INT,
    PRIMARY KEY (CustomerID, DName, AccountID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (DName, AccountID) REFERENCES Depositor(DName, AccountID)
);

-- FIXED DEPOSITOR TABLE
CREATE TABLE FixedDepositor (
    FDID INT PRIMARY KEY,
    Name VARCHAR(100),
    AccountID INT,
    Amount DECIMAL(15,2),
    DurationMonths INT,
    StartDate DATE,
    InterestRate DECIMAL(5,2),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- LOAN TABLE
CREATE TABLE Loan (
    LoanNumber INT PRIMARY KEY,
    LoanHolder VARCHAR(100),
    Amount DECIMAL(15,2),
    BranchName VARCHAR(100),
    DurationMonths INT,
    StartDate DATE,
    InterestRate DECIMAL(5,2)
);

-- RELATIONSHIP: Customer takes Loan
CREATE TABLE Takes (
    CustomerID INT,
    LoanNumber INT,
    PRIMARY KEY (CustomerID, LoanNumber),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (LoanNumber) REFERENCES Loan(LoanNumber)
);

-- BORROWER TABLE
CREATE TABLE Borrower (
    AccountID INT,
    LoanNumber INT,
    LoanHolder VARCHAR(100),
    Address VARCHAR(200),
    PRIMARY KEY (AccountID, LoanNumber),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (LoanNumber) REFERENCES Loan(LoanNumber)
);
SELECT * FROM Customer;
SELECT AccountID, Balance FROM Account;
SELECT * FROM FixedDepositor WHERE StartDate > '2022-01-01';
SELECT MIN(Balance) AS MinimumBalance FROM Account;
SELECT * FROM Account WHERE Type = 'Savings';

SELECT C.Customer_Name, A.AccountID, A.Balance
FROM Customer C JOIN  Account A ON C.AccountID = A.AccountID;

SELECT Name, AccountID, Amount, DurationMonths, StartDate, InterestRate
FROM FixedDepositor;

SELECT AccountID, COUNT(CustomerID) AS Num_Customers FROM Customer GROUP BY AccountID
HAVING COUNT(CustomerID) > 1;






