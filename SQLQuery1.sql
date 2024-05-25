SELECT *
FROM Sales.Customer;
select * from Sales.Customer as t1
join Sales.Store as t2 on t1.StoreID=t2.BusinessEntityID
where Name like '%N'
select * from Sales.Customer as t1
join Sales.SalesTerritory as t2 on t1.TerritoryID=t2.TerritoryID
where Name='United Kingdom'or Name='Germany'
select * from Sales.Customer as t1
join Sales.SalesTerritory as t2 on t1.TerritoryID=t2.TerritoryID
where Name='United Kingdom'or CountryRegionCode='US'
SELECT ProductID, Name, ProductNumber, ListPrice
FROM Production.Product
ORDER BY Name;
SELECT ProductID, Name, ProductNumber, ListPrice
FROM Production.Product
WHERE Name LIKE 'A%'
SELECT *
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
SELECT *
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Person.Address a ON soh.BillToAddressID = a.AddressID
WHERE a.City = 'London' AND p.Name = 'Chain';
SELECT *
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE soh.SalesOrderID IS NULL;
SELECT *
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE p.Name = 'Tofu';
SELECT TOP 1 *
FROM Sales.SalesOrderHeader
ORDER BY OrderDate ASC;
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.CustomerID,
    soh.TotalDue,
    ot.LineTotal
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Sales.SalesOrderDetail ot ON soh.SalesOrderID = ot.SalesOrderID
WHERE 
    ot.LineTotal = (SELECT MAX(LineTotal) FROM Sales.SalesOrderDetail)
ORDER BY 
    soh.SalesOrderID;
SELECT SalesOrderID, AVG(OrderQty) AS AverageQuantity
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY SalesOrderID;

SELECT SalesOrderID, MIN(OrderQty) AS MinimumQuantity, MAX(OrderQty) AS MaximumQuantity
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY SalesOrderID;

SELECT SalesOrderID, SUM(OrderQty) AS TotalQuantity
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty) > 300
ORDER BY SalesOrderID;

SELECT SalesOrderID, OrderDate, CustomerID, TotalDue
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '1996-12-31'
ORDER BY OrderDate;

SELECT SalesOrderID,OrderDate,ShipDate,sh.TerritoryID FROM Sales.SalesOrderHeader AS sh 
JOIN sales.SalesTerritory As st on  sh.TerritoryID=st.TerritoryID
WHERE CountryRegionCode='CA'
order by SalesOrderID

SELECT SalesOrderID, TotalDue, OrderDate, CustomerID
FROM Sales.SalesOrderHeader
WHERE TotalDue > 200
ORDER BY TotalDue DESC;

SELECT ShipToAddressID, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY ShipToAddressID
ORDER BY TotalSales DESC;

SELECT c.CustomerID, COUNT(soh.SalesOrderID) AS OrderCount
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID
ORDER BY OrderCount DESC;

SELECT c.CustomerID, COUNT(soh.SalesOrderID) AS OrderCount
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID
HAVING COUNT(soh.SalesOrderID) > 3
ORDER BY OrderCount DESC

SELECT DISTINCT p.ProductID, p.Name
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE p.DiscontinuedDate IS NOT NULL AND soh.OrderDate BETWEEN '1997-01-01' AND '1998-01-01';

SELECT soh.SalesOrderID, p.Name
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
ORDER BY soh.SalesOrderID, p.Name;

SELECT TOP 1 CustomerID, COUNT(SalesOrderID) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY OrderCount DESC

SELECT DISTINCT a.PostalCode
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
WHERE p.Name = 'Tofu';

SELECT DISTINCT p.Name
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Person.StateProvince  a ON soh.ShipToAddressID = a.StateProvinceID
WHERE a.CountryRegionCode = 'FR';

SELECT p.Name AS ProductName, pc.Name AS CategoryName
FROM Production.Product p
JOIN Production.ProductCategory pc ON p.ProductID = pc.ProductCategoryID
JOIN Purchasing.ProductVendor pv ON p.ProductID = pv.ProductID
JOIN Purchasing.Vendor v ON pv.BusinessEntityID = v.BusinessEntityID
WHERE v.Name = 'Specialty Biscuits, Ltd.';

SELECT p.ProductID, p.Name
FROM Production.Product p
LEFT JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
WHERE sod.ProductID IS NULL;

SELECT
    p.ProductID,
    p.Name AS ProductName,
    pi.Quantity AS UnitsInStock,
    p.ReorderPoint AS UnitsOnOrder
FROM
    Production.Product p
INNER JOIN
    Production.ProductInventory pi ON p.ProductID = pi.ProductID
WHERE
    pi.Quantity < 10
    AND p.ReorderPoint = 0;

SELECT TOP 10 a.StateProvinceID ,SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
GROUP BY a.StateProvinceID
ORDER BY TotalSales DESC;

SELECT TOP 1 OrderDate
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC;

SELECT p.Name, SUM(sod.LineTotal) AS TotalRevenue
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY p.Name
ORDER BY TotalRevenue DESC;

SELECT pv.BusinessEntityID AS SupplierID, COUNT(pv.ProductID) AS ProductCount
FROM Purchasing.ProductVendor pv
GROUP BY pv.BusinessEntityID
ORDER BY ProductCount DESC;

SELECT TOP 10 c.CustomerID, SUM(soh.TotalDue) AS TotalBusiness
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalBusiness DESC;

SELECT SUM(TotalDue) AS TotalRevenue
FROM Sales.SalesOrderHeader;


