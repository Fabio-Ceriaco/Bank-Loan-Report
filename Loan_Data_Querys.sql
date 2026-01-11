SELECT *
FROM loan_data

-- KPI's

-- Total Loan Applications

SELECT COUNT(*) AS Total_Loan_Aplications
FROM loan_data

-- MTD Loan Applications (Loans in the last month of the current year)

SELECT COUNT(*) AS MTD_Loan_Alications
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- PMTD Loan Application

SELECT COUNT(*) AS MTD_Loan_Alications
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--MOM = (MTD - PMTD) / PMTD

-- Total Funded Amount

SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM loan_data

-- MTD Total Funded Amount

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- PMTD Total Funded Amount

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Total Amout Received

SELECT SUM(total_payment) As Total_Amout_Received
FROM loan_data


--MTD_Total_Amout_Received
SELECT SUM(total_payment) As MTD_Total_Amout_Received
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- PMTD_Total_Amout_Received
SELECT SUM(total_payment) As PMTD_Total_Amout_Received
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021



--Average_Interested_Rate
SELECT CAST(AVG(int_rate) * 100 AS DECIMAL(10,2)) AS Average_Interested_Rate
FROM loan_data


-- MTD Average_Interested_Rate
SELECT CAST(AVG(int_rate) * 100 AS DECIMAL(10,2)) AS MTD_Average_Interested_Rate
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- PMTD_Average_Interested_Rate
SELECT CAST(AVG(int_rate) * 100 AS DECIMAL(10,2)) AS PMTD_Average_Interested_Rate
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


-- Average Debt-to-Income Ratio

SELECT ROUND(AVG(dti) * 100, 2) As Average_Debt_to_Income_Ratio
FROM loan_data

-- MTD Average Debt-to-Income Ratio

SELECT ROUND(AVG(dti) * 100, 2) As MTD_Average_Debt_to_Income_Ratio
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- PMTD Average Debt-to-Income Ratio

SELECT ROUND(AVG(dti) * 100, 2) As PMTD_Average_Debt_to_Income_Ratio
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- DASHBOARD 1#

-- GOOD LOANS

-- Good_Loan_Percantage

SELECT 
	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100) 
	/
	COUNT(id) AS Good_Loan_Percantage
FROM loan_data

-- Good_Loan_Applications

SELECT COUNT(id) AS Good_Loan_Applications
FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Funded Amount

SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Recieved Amount

SELECT SUM(total_payment) AS Good_Loan_Received_Amount
FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--BAD LOANS

-- Bad_Loan_Percantage

SELECT 
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) 
	/
	COUNT(id) AS Bad_Loan_Percantage
FROM loan_data

--Bad Loan Applications

SELECT COUNT(id) AS Bad_Loan_Applications
FROM loan_data
WHERE loan_status = 'Charged Off'

-- Bad Loan Funded Amount

SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM loan_data
WHERE loan_status = 'Charged Off'

-- Bad Loan Recieved Amount

SELECT SUM(total_payment) AS Good_Loan_Received_Amount
FROM loan_data
WHERE loan_status = 'Charged Off'

-- Loan Status 

SELECT 
	loan_status AS Loan_Status,
	COUNT(id) AS Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	AVG(int_rate * 100) AS Interest_Rate,
	AVG(dti * 100) AS DTI
FROM loan_data
GROUP BY loan_status

-- MTD Loan Status
SELECT
	loan_status AS Loan_Status,
	SUM(total_payment) AS MTD_Total_Amount_Recived,
	SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status

-- PMTD Loan Status
SELECT
	loan_status AS Loan_Status,
	SUM(total_payment) AS PMTD_Total_Amount_Recived,
	SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM loan_data
WHERE MONTH(issue_date) = 11
GROUP BY loan_status


-- DASHBOARD #2

-- Monthly Trends by Issue Date

SELECT
	MONTH(issue_date) AS Month_Number,
	DATENAME(MONTH, issue_date) AS Month,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

-- Regional Analysis by State

SELECT 
	address_state AS State,
	COUNT(id) As Total_Loan_Applications,
	SUM(loan_amount) As Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY address_state
ORDER BY address_state

-- Loan Term Analysis

SELECT 
	term AS Term,
	COUNT(id) As Total_Loan_Applications,
	SUM(loan_amount) As Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY term
ORDER BY term

-- Employee Lenght Analysis

SELECT 
	emp_length AS Employee_Length,
	COUNT(id) As Total_Loan_Applications,
	SUM(loan_amount) As Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY emp_length
ORDER BY emp_length

-- Loan Purpose Breakdown

SELECT 
	purpose AS Purpose,
	COUNT(id) As Total_Loan_Applications,
	SUM(loan_amount) As Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY purpose
ORDER BY purpose

-- Home OwnerShip

SELECT 
	home_ownership AS Home_Ownership,
	COUNT(id) As Total_Loan_Applications,
	SUM(loan_amount) As Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY home_ownership
ORDER BY home_ownership


-- DASHBOARD #3

SELECT 
	home_ownership AS Home_Ownership,
	COUNT(id) As Total_Loan_Applications,
	SUM(loan_amount) As Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
WHERE grade = 'A' AND address_state = 'CA'
GROUP BY home_ownership
ORDER BY home_ownership








