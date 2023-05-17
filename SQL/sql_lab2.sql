USE AdventureWorks2014

-- 1. Wybierz nazwę produktu i cenę katalogową dla wszystkich produktów w tabeli [Production.Product] i dołącz nazwę kategorii produktów [Production.ProductCategory]
SELECT pp.Name AS ProductName, pp.ListPrice AS CatalogPrice, ppc.Name AS ProductCategory
FROM Production.Product pp
         LEFT JOIN Production.ProductSubcategory psc ON psc.ProductSubcategoryID = pp.ProductSubcategoryID
         LEFT JOIN Production.ProductCategory ppc ON ppc.ProductCategoryID = psc.ProductCategoryID

-- 2. Wybierz imię, nazwisko i adres e-mail dla wszystkich pracowników w [HumanResources.Employee] i podaj nazwy działu z tabeli [HumanResources.Department]
SELECT FirstName, LastName, pea.EmailAddress, hrd.Name AS DepartmentName
FROM HumanResources.Employee hre
         LEFT JOIN HumanResources.EmployeeDepartmentHistory hrdh ON hre.BusinessEntityID = hrdh.BusinessEntityID
         LEFT JOIN HumanResources.Department hrd ON hrdh.DepartmentID = hrd.DepartmentID
         LEFT JOIN Person.Person pp ON hre.BusinessEntityID = pp.BusinessEntityID
         LEFT JOIN Person.EmailAddress pea ON pp.BusinessEntityID = pea.BusinessEntityID

-- 3. Wybierz datę zamówienia, nazwa klienta (Imię + Nazwisko) i sumę należności dla wszystkich zamówień w tabeli [Sales.SalesOrderHeader], i podaj nazwę obszaru sprzedaży z tabeli [Sales.SalesTerritory]
SELECT soh.OrderDate, pp.LastName + ' ' + pp.FirstName AS ClientName, soh.TotalDue, sst.Name AS TerritoryName
FROM Sales.SalesOrderHeader soh
         LEFT JOIN Sales.Customer sc ON soh.CustomerID = sc.CustomerID
         LEFT JOIN Person.Person pp ON sc.PersonID = pp.BusinessEntityID
         LEFT JOIN Sales.SalesTerritory sst ON soh.TerritoryID = sst.TerritoryID

-- 4. Pobierz listę wszystkich klientów i odpowiadające im zamówienia sprzedaży [Sales.Customer] [Sales.SalesOrderHeader]
SELECT *
FROM Sales.Customer sc
         LEFT JOIN Sales.SalesOrderHeader soh ON sc.CustomerID = soh.CustomerID

-- 5. Wybierz Imię i Nazwisko wszystkich klientów [Sales.Customer] wraz z ich adresami e-mail [Person.EmailAddress]
SELECT pp.FirstName, pp.LastName, ea.EmailAddress
FROM Sales.Customer sc
         LEFT JOIN Person.Person pp ON sc.PersonID = pp.BusinessEntityID
         LEFT JOIN Person.EmailAddress ea on pp.BusinessEntityID = ea.BusinessEntityID

-- 6. Pobierz listę wszystkich zamówień sprzedaży [Sales.SalesOrderHeader] oraz odpowiadających im klientów [Sales.Customer] do wyniku załącz adresy [Person.Address]
SELECT *
FROM Sales.SalesOrderHeader soh
         LEFT JOIN Sales.Customer sc ON soh.CustomerID = sc.CustomerID
         LEFT JOIN Person.Person pp ON sc.PersonID = pp.BusinessEntityID
         LEFT JOIN Person.Address pa ON soh.BillToAddressID = pa.AddressID and soh.ShipToAddressID = pa.AddressID

-- 7. Wybierz wszystkich pracowników [HumanResources.Employee] wraz z nazwami departamentów. [humanresources.department]. Posortuj dane po Nazwisku malejąco i Sart Date rosnąco
SELECT pp.LastName, pp.FirstName, hre.*, hrd.*
FROM HumanResources.Employee hre
         LEFT JOIN HumanResources.EmployeeDepartmentHistory edh on hre.BusinessEntityID = edh.BusinessEntityID
         LEFT JOIN HumanResources.Department hrd on hrd.DepartmentID = edh.DepartmentID
         LEFT JOIN Person.Person pp ON hre.BusinessEntityID = pp.BusinessEntityID
ORDER BY pp.LastName DESC, edh.StartDate

-- 8. Wybierz wszystkie nazwy produktów [Production.Product] wraz z ich dostawcami (tylko nazwa) [Purchasing.Vendor]
SELECT pp.*, pv.Name AS VendorName
FROM Production.Product pp
         LEFT JOIN Purchasing.ProductVendor ppv ON pp.ProductID = ppv.ProductID
         LEFT JOIN Purchasing.Vendor pv ON ppv.BusinessEntityID = pv.BusinessEntityID

-- 9. Wybierz wszystkie zamówienia pracowników [humanresources.employee] o imieniu zaczynającym się na 'E' oraz metodzie dostawy zawierającej 'OVER' [purchasing.shipmethod]
SELECT soh.*, pp.FirstName, pp.LastName, psm.Name AS ShipMethodName
FROM Sales.SalesOrderHeader soh
         INNER JOIN Sales.Customer sc ON soh.CustomerID = sc.CustomerID
         INNER JOIN Person.Person pp ON sc.PersonID = pp.BusinessEntityID AND pp.FirstName LIKE 'E%'
         INNER JOIN HumanResources.Employee hre ON pp.BusinessEntityID = hre.BusinessEntityID
         LEFT JOIN Purchasing.ShipMethod psm ON soh.ShipMethodID = psm.ShipMethodID AND psm.Name LIKE '%OVER%'

-- 10. Wybierz wszystkie zamówienia [Sales.SalesOrderHeader] wraz z danymi o pracownikach odpowiedzialnych za ich obsługę [HumanResources.Employee]
SELECT soh.*, pp.FirstName as FirstName, pp.LastName AS LastName, hre.*
FROM Sales.SalesOrderHeader soh
         LEFT JOIN Sales.SalesPerson ssp ON soh.SalesPersonID = ssp.BusinessEntityID
         LEFT JOIN HumanResources.Employee hre ON ssp.BusinessEntityID = hre.BusinessEntityID
         LEFT JOIN Person.Person pp ON hre.BusinessEntityID = pp.BusinessEntityID

-- 11. Wybierz wszystkie produkty [Production.Product] z kategorii "Clothing" [production.productcategory] wraz z danymi o dostawcach[Purchasing.Vendor]
SELECT pp.*, pc.Name AS CategoryName, pv.Name AS VendorName, pv.CreditRating, pv.PurchasingWebServiceURL
FROM Production.Product pp
         LEFT JOIN Production.ProductSubcategory psc ON pp.ProductSubcategoryID = psc.ProductSubcategoryID
         LEFT JOIN Production.ProductCategory pc
                   ON psc.ProductCategoryID = pc.ProductCategoryID AND pc.Name = 'Clothing'
         LEFT JOIN Purchasing.ProductVendor ppv ON pp.ProductID = ppv.ProductID
         LEFT JOIN Purchasing.Vendor pv ON ppv.BusinessEntityID = pv.BusinessEntityID

-- 12. Wybierz wszystkie zamówienia złożone w 2008 roku wraz z danymi o klientach. [Sales.SalesOrderHeader] [Sales.Customer]
SELECT *
FROM Sales.SalesOrderHeader soh
         LEFT JOIN Sales.Customer sc ON soh.CustomerID = sc.CustomerID
WHERE YEAR(soh.OrderDate) = 2008

-- 13. Wybierz wszystkie produkty [Production.Product] z ceną detaliczną (ListPrice) większą niż 25 dolarów wraz z danymi o dostawcach [Purchasing.Vendor]. Posortuj wyniki po cenie malejąco
SELECT pp.*, pv.*
FROM Production.Product pp
         LEFT JOIN Purchasing.ProductVendor ppv ON pp.ProductID = ppv.ProductID
         LEFT JOIN Purchasing.Vendor pv ON ppv.BusinessEntityID = pv.BusinessEntityID
WHERE pp.ListPrice > 25
ORDER BY pp.ListPrice DESC
