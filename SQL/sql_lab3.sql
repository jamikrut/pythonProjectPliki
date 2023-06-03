USE AdventureWorks2014
GO

-- 1. Jakie są średnie roczne zarobki pracowników [HumanResources.Employee] Adventure Works według stanowisk? [humanresources.employeepayhistory]
SELECT *
FROM HumanResources.Employee HRE
         LEFT JOIN HumanResources.EmployeePayHistory EPH on HRE.BusinessEntityID = EPH.BusinessEntityID
--??

-- 2. Jakie jest łączne zamówienie dla każdego klienta, który kupił produkty Adventure Works w 2013 roku? [Sales.SalesOrderHeader]


-- 3. Ile zamówień zostało złożonych przez każdego pracownika Adventure Works? [Sales.SalesOrderHeader]


-- 4. Jaka jest łączna ilość zamówień (LineTotal) dla każdej kategorii produktów Adventure Works? [Sales.SalesOrderDetail] [Production.Product]


-- 5. Znajdź średnią wartość zamówienia dla każdego klienta w 2012 roku [Sales.Customer] [Sales.SalesOrderHeader]


-- 6. Znajdź trzy najlepiej sprzedające się produkty (w największej ilości orderqty) w 2016 roku [Production.Product] [Sales.SalesOrderDetail] [Sales.SalesOrderHeader]


-- 7. Znajdź średnią wartość zamówienia dla każdego kraju. Weź pod uwagę tylko klientów którzy dokonali co najmniej 10 zamówień (subquery) [Sales.Customer] [Sales.SalesOrderHeader]


-- 8. Znajdź 10 najlepszych klientów pod względem wartości zamówień (TotalDue) [Sales.Customer] [Sales.SalesOrderHeader]


-- 9. Napisz zapytanie, aby znaleźć 5 najlepszych sprzedawców z najwyższą średnią kwotą sprzedaży na zamówienie, i uwzględnij ich Imię, Nazwisko i średnią kwotę sprzedaży na zamówienie. Uporządkuj wyniki według średniej wielkości sprzedaży na zamówienie w kolejności malejącej [Sales.SalesPerson] [Sales.SalesOrderHeader] [Sales.SalesOrderDetail]


-- 10. Napisz zapytanie, aby znaleźć 10 najlepszych produktów o najwyższej łącznej wartości sprzedaży i podaj nazwę produktu, kategoria produktu i łączna kwota sprzedaży. Posortuj wyniki według łącznej kwoty sprzedaży w kolejności malejącej [Production.Product] [Production.ProductSubcategory] [Sales.SalesOrderDetail]