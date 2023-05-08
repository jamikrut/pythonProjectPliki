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
-- 5. Wybierz Imię i Nazwisko wszystkich klientów [Sales.Customer] wraz z ich adresami e-mail [Person.EmailAddress]
-- 6. Pobierz listę wszystkich zamówień sprzedaży [Sales.SalesOrderHeader] oraz odpowiadających im klientów [Sales.Customer] do wyniku załącz adresy [Person.Address]
-- 7. Wybierz wszystkich pracowników [HumanResources.Employee] wraz z nazwami departamentów. [humanresources.department]. Posortuj dane po Nazwisku malejąco i Sart Date rosnąco
-- 8. Wybierz wszystkie nazwy produktów [Production.Product] wraz z ich dostawcami (tylko nazwa) [Purchasing.Vendor]
-- 9. Wybierz wszystkie zamówienia pracowników [humanresources.employee] o imieniu zaczynającym się na 'E' oraz metodzie dostawy zawierającej 'OVER' [purchasing.shipmethod]
-- 10. Wybierz wszystkie zamówienia [Sales.SalesOrderHeader] wraz z danymi o pracownikach odpowiedzialnych za ich obsługę [HumanResources.Employee]
-- 11. Wybierz wszystkie produkty [Production.Product] z kategorii "Clothing" [production.productcategory] wraz z danymi o dostawcach[Purchasing.Vendor]
-- 12. Wybierz wszystkie zamówienia złożone w 2008 roku wraz z danymi o klientach. [Sales.SalesOrderHeader] [Sales.Customer]
-- 13. Wybierz wszystkie produkty [Production.Product] z ceną detaliczną (ListPrice) większą niż 25 dolarów wraz z danymi o dostawcach [Purchasing.Vendor]. Posortuj wyniki po cenie malejąco