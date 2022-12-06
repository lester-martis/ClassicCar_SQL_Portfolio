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

/* 4. Yearly Sales and Sold Qty */
SELECT
	year(od.orderDate) As Years,
    SUM(os.quantityOrdered) AS Sold_Qty,
    SUM(os.quantityOrdered * os.priceEach) AS Total_Sale
FROM
	orders od
JOIN
	orderdetails os ON od.orderNumber = os.orderNumber
GROUP BY year(od.orderDate);


/* 5. Yearly Profit Summary */
SELECT
	YEAR(od.orderDate) AS Years,
    SUM(os.priceEach * os.quantityOrdered) AS Revenue,
	SUM(os.priceEach - pd.buyPrice) * os.quantityOrdered AS Gross_Profit,
    ROUND (SUM(os.priceEach - pd.buyPrice) * os.quantityOrdered / SUM(os.priceEach * os.quantityOrdered) * 100, 2) AS GP_Per
FROM
	products pd
JOIN
	orderdetails os ON pd.productCode = os.productCode
JOIN
	orders od ON os.orderNumber = od.orderNumber
GROUP BY YEAR(od.orderDate) ;


/* 6. Product Lines GP% for the years 2003-2005(May) */
SELECT
	YEAR(od.orderDate) AS Years,
    pd.productLine,
    SUM(os.quantityOrdered * os.priceEach) AS Revenue,
    SUM(os.priceEach - pd.buyPrice) * os.quantityOrdered  AS Gross_Profit,
   ROUND(SUM(os.priceEach - pd.buyPrice) * os.quantityOrdered / SUM(os.quantityOrdered * os.priceEach) * 100,2) AS GP_Perc
FROM
	orders od
JOIN
	orderdetails os ON od.orderNumber = os.orderNumber
JOIN
	products pd ON os.productCode = pd.productCode
GROUP BY YEAR(od.orderDate), pd.productLine;

/* 7. Highest Gross Profit by customers */ 

SELECT
	YEAR(od.orderDate) AS Years,
    cs.customerName,
    SUM(os.quantityOrdered * os.priceEach) - SUM(pd.buyPrice * os.quantityOrdered) AS GP_Amount,
    ROUND(SUM(pd.buyPrice * os.quantityOrdered) / SUM(os.quantityOrdered * os.priceEach) * 100,2) AS GP_Perc
FROM
	customers cs
INNER JOIN 
	orders od ON cs.customerNumber = od.customerNumber
INNER JOIN
	orderdetails os ON od.orderNumber = os.orderNumber
INNER JOIN
	products pd ON os.productCode = pd.productCode
WHERE status = 'Shipped'
GROUP BY customerName;
	
    
    