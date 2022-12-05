				/*Classic Car Models is a Trading co. for Toy cars of Classic vintage cars around the globe. 
				Dataset  which includes 8 datasets for different attributes, has the information on Customer, Products, 
				Customer Orders, Product lines, Employees and Payment Details. 
				This project is for Explanatory Data Analysis using DML.
Link to the Dataset: https://github.com/agatakj/MySLQ/blob/master/classicmodels.sql

				 */

/* 1. Retrieve the data for Total Order amount for Each customer and present Top 10 customers */ 
SELECT
	cs.customerName,
    cs.country,
    od.orderNumber,
    SUM(os.quantityOrdered * os.priceEach) AS Order_Amnt
FROM
	customers cs
JOIN
	orders od ON cs.customerNumber = od.customerNumber
JOIN
	orderdetails os ON od.orderNumber = os.orderNumber
GROUP BY orderNumber
ORDER BY SUM(os.quantityOrdered * os.priceEach) DESC
LIMIT 10;
    

/* 2. Customers' order Qty and Order Amount for Each product */
SELECT
	cs.customerName,
    pd.productName,
    os.quantityOrdered,
    os.quantityOrdered * os.priceEach AS Amount
FROM
	customers cs
JOIN
	orders od ON cs.customerNumber = od.customerNumber
JOIN
	orderdetails os ON od.orderNumber = os.orderNumber
JOIN
	products pd ON os.productCode = pd.productCode
ORDER BY cs.customerName;
    

/* 3. Customers' order Qty and Order Amount for Each product Line */
SELECT
	cs.customerName,
    pd.productLine,
    os.quantityOrdered,
    SUM(os.quantityOrdered * os.priceEach) AS Amount
FROM
	customers cs
JOIN
	orders od ON cs.customerNumber = od.customerNumber
JOIN
	orderdetails os ON od.orderNumber = os.orderNumber
JOIN
	products pd ON os.productCode = pd.productCode
GROUP BY cs.customerName, pd.productLine
ORDER BY cs.customerName;

	
