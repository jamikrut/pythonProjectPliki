USE AdventureWorks2014
GO

-- 1. Jakie są średnie roczne zarobki pracowników [HumanResources.Employee] Adventure Works według stanowisk? [humanresources.employeepayhistory]
SELECT HRE.JobTitle, AVG(HRPH.Rate) AS AveragePayPerHour, AVG(HRPH.Rate * 40 * 52) AS AproxAveragePayPerYear
FROM HumanResources.Employee HRE
         LEFT JOIN HumanResources.EmployeePayHistory HRPH ON HRE.BusinessEntityID = HRPH.BusinessEntityID
GROUP BY HRE.JobTitle


-- 2. Jakie jest łączne zamówienie dla każdego klienta, który kupił produkty Adventure Works w 2013 roku? [Sales.SalesOrderHeader]
SELECT SC.CustomerID, SUM(SOH.TotalDue) AS CustomerTotalDue
FROM Sales.Customer SC
         LEFT JOIN Sales.SalesOrderHeader SOH ON SC.CustomerID = SOH.CustomerID
WHERE YEAR(SOH.OrderDate) = 2012
GROUP BY SC.CustomerID


-- 3. Ile zamówień zostało złożonych przez każdego pracownika Adventure Works? [Sales.SalesOrderHeader]
SELECT SOH.CustomerID, COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader SOH
         LEFT JOIN Sales.Customer SC ON SOH.CustomerID = SC.CustomerID
         LEFT JOIN Person.Person PP ON SC.PersonID = PP.BusinessEntityID
         INNER JOIN HumanResources.Employee HRE ON PP.BusinessEntityID = HRE.BusinessEntityID
GROUP BY SOH.CustomerID


-- 4. Jaka jest łączna ilość zamówień (LineTotal) dla każdej kategorii produktów Adventure Works? [Sales.SalesOrderDetail] [Production.Product]
SELECT PSC.ProductCategoryID, SUM(SOD.LineTotal) AS SumLineTotal
FROM Sales.SalesOrderDetail SOD
         LEFT JOIN Production.Product PP ON PP.ProductID = SOD.ProductID
         LEFT JOIN Production.ProductSubcategory PSC
                   ON PSC.ProductSubcategoryID = PP.ProductSubcategoryID
GROUP BY PSC.ProductCategoryID


-- 5. Znajdź średnią wartość zamówienia dla każdego klienta w 2012 roku [Sales.Customer] [Sales.SalesOrderHeader]
SELECT SC.CustomerID, AVG(SOH.TotalDue) AS AverageTotalDue
FROM Sales.Customer SC
         LEFT JOIN Sales.SalesOrderHeader SOH ON SC.CustomerID = SOH.CustomerID
WHERE YEAR(SOH.OrderDate) = 2012
GROUP BY SC.CustomerID


-- 6. Znajdź trzy najlepiej sprzedające się produkty (w największej ilości orderqty) w 2016 roku [Production.Product] [Sales.SalesOrderDetail] [Sales.SalesOrderHeader]
SELECT TOP 3 PP.ProductID, PP.Name AS ProductNAme, SUM(SOD.OrderQty) AS TotalSoldAmount
FROM Production.Product PP
         LEFT JOIN Sales.SalesOrderDetail SOD ON SOD.ProductID = PP.ProductID
         LEFT JOIN Sales.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE YEAR(SOH.OrderDate) = 2016 --2014
GROUP BY PP.ProductID, PP.Name
ORDER BY SUM(SOD.OrderQty) DESC


-- 7. Znajdź średnią wartość zamówienia dla każdego kraju. Weź pod uwagę tylko klientów którzy dokonali co najmniej 10 zamówień (subquery) [Sales.Customer] [Sales.SalesOrderHeader]
SELECT SST.CountryRegionCode, AVG(SOH.TotalDue) AS AvarageTotalDue
FROM Sales.SalesOrderHeader SOH
         LEFT JOIN Sales.Customer SC ON SOH.CustomerID = SC.CustomerID AND SC.CustomerID IN (SELECT SC.CustomerID
                                                                                             FROM Sales.SalesOrderHeader SOH
                                                                                                      LEFT JOIN Sales.Customer SC ON SOH.CustomerID = SC.CustomerID
                                                                                                      LEFT JOIN Sales.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
                                                                                             WHERE SOD.OrderQty >= 10)
         LEFT JOIN Sales.SalesTerritory SST ON SC.TerritoryID = SST.TerritoryID
GROUP BY SST.CountryRegionCode
HAVING SST.CountryRegionCode IS NOT NULL


-- 8. Znajdź 10 najlepszych klientów pod względem wartości zamówień (TotalDue) [Sales.Customer] [Sales.SalesOrderHeader]
SELECT TOP 10 SC.CustomerID, SC.PersonID, SUM(SOH.TotalDue) AS TotalOrderDue
FROM Sales.Customer SC
         LEFT JOIN Sales.SalesOrderHeader SOH ON SC.CustomerID = SOH.CustomerID
GROUP BY SC.CustomerID, SC.PersonID
ORDER BY SUM(SOH.TotalDue) DESC


-- 9. Napisz zapytanie, aby znaleźć 5 najlepszych sprzedawców z najwyższą średnią kwotą sprzedaży na zamówienie, i uwzględnij ich Imię, Nazwisko i średnią kwotę sprzedaży na zamówienie. Uporządkuj wyniki według średniej wielkości sprzedaży na zamówienie w kolejności malejącej [Sales.SalesPerson] [Sales.SalesOrderHeader] [Sales.SalesOrderDetail]
SELECT TOP 5 PP.FirstName AS SellerName, PP.LastName AS SellerSurname, AVG(SOH.TotalDue) AS AverageOrderAmount
FROM Sales.SalesOrderHeader SOH
         LEFT JOIN Sales.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
         LEFT JOIN Sales.SalesPerson SP ON SOH.SalesPersonID = SP.BusinessEntityID
         LEFT JOIN Person.Person PP ON SP.BusinessEntityID = PP.BusinessEntityID
GROUP BY PP.FirstName, PP.LastName
ORDER BY AVG(SOH.TotalDue) DESC


-- 10. Napisz zapytanie, aby znaleźć 10 najlepszych produktów o najwyższej łącznej wartości sprzedaży i podaj nazwę produktu, kategoria produktu i łączna kwota sprzedaży. Posortuj wyniki według łącznej kwoty sprzedaży w kolejności malejącej [Production.Product] [Production.ProductSubcategory] [Sales.SalesOrderDetail]
SELECT TOP 10 PP.ProductID,
              PP.Name                          AS ProductName,
              PPSC.ProductCategoryID,
              SUM(SOD.OrderQty * PP.ListPrice) AS TotalProductSellValue
FROM Sales.SalesOrderDetail SOD
         LEFT JOIN Production.Product PP ON PP.ProductID = SOD.ProductID
         LEFT JOIN Production.ProductSubcategory PPSC ON PP.ProductSubcategoryID = PPSC.ProductSubcategoryID
GROUP BY PP.ProductID, PP.Name, PPSC.ProductCategoryID
ORDER BY TotalProductSellValue DESC