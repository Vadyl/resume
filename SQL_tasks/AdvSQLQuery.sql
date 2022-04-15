/*********** SQL Views  ************/
CREATE VIEW NumberCust AS
SELECT TerritoryID,
		COUNT(TerritoryID) AS COUNT_TerritoryID
FROM Sales.Customer
GROUP BY TerritoryID



/*********** SQL Tiggers  ************/

CREATE TABLE Deleted_HumanResources_Department(
	DepartmentID smallint IDENTITY(1,1) PRIMARY KEY,
	Name nvarchar(50) NOT NULL,
	GroupName nvarchar(50) NOT NULL,
	ModifiedDate datetime NOT NULL
	)


CREATE TRIGGER trgDeleted
ON HumanResources.Department
AFTER DELETE
AS
BEGIN
INSERT INTO Deleted_HumanResources_Department (Name, GroupName, ModifiedDate)
SELECT Name, GroupName, ModifiedDate FROM deleted
END
GO

CREATE TRIGGER trgUpdate 
ON HumanResources.vEmployee
INSTEAD OF UPDATE
AS
BEGIN
	PRINT('You cannot update this DB')
	ROLLBACK TRANSACTION
END
GO




/*********** SQL Stored Procedures  ************/
CREATE PROC sp_ChangeCity
AS
SET NOCOUNT ON
UPDATE Person.Address
SET City = UPPER(City)

CREATE PROC sp_GetLastName
@EmployeeID int
AS
SET NOCOUNT ON
SELECT Person.Person.BusinessEntityID, Person.Person.LastName
FROM Person.Person
INNER JOIN HumanResources.Employee
ON HumanResources.Employee.BusinessEntityID = Person.Person.BusinessEntityID
WHERE HumanResources.Employee.BusinessEntityID = @EmployeeID

USE AdventureWorks2019
GO



/*********** SQL XML grouping and ranking functions  ************/
SELECT [Group] , CountryRegionCode, Name, SalesYTD, SaleslastYear, avg(SalesYTD) avg_SalesYTD
FROM Sales.SalesTerritory 
GROUP BY 
GROUPING SETS
(
	([Group]),
	([Group] , CountryRegionCode),
	([Group] , CountryRegionCode, Name),
	([Group] , CountryRegionCode, Name, SalesYTD),
	([Group] , CountryRegionCode, Name, SalesYTD, SaleslastYear)
);





SELECT [Group], CountryRegionCode,  Name, SalesYTD, SaleslastYear, avg(SalesYTD) avg_SalesYTD
FROM Sales.SalesTerritory 
GROUP BY 
CUBE([Group] , CountryRegionCode, Name, SalesYTD, SaleslastYear)


SELECT [Group], CountryRegionCode,  Name, SalesYTD, SaleslastYear, avg(SalesYTD) avg_SalesYTD
FROM Sales.SalesTerritory 
GROUP BY
ROLLUP([Group] , CountryRegionCode, Name, SalesYTD, SaleslastYear)



/*********** SQL XML data types  ************/

 creating an XML table

CREATE TABLE Online_GameShop_VasylZavadetskyi 
(
	xmlcolumn XML
)

-- inserting data into xml 
INSERT INTO Online_GameShop_VasylZavadetskyi 
VALUES ( '<Online_GameShop_VasylZavadetskyi>
	
	<Product>
		<Name>Dead by daylight</Name>
		<Type>Horror</Type>
		<Price>20.00</Price>
	</Product>

	<Product>
		<Name>Counter-Strike: Global Offensive</Name>
		<Type>Shooter</Type>
		<Price>20.00</Price>
	</Product>

	<Product>
		<Name>Cyberpunk 2077</Name>
		<Type>Adventure</Type>
		<Price>60.00</Price>
	</Product>

	<Product>
		<Name>The Elder Scrolls V: Skyrim Special Edition</Name>
		<Type>Adventure</Type>
		<Price>40.00</Price>
	</Product>

	<Product>
		<Name>Pathologic 2</Name>
		<Type>Adventure</Type>
		<Price>35.00</Price>
	</Product>
</Online_GameShop_VasylZavadetskyi>'
)



SELECT [xmlcolumn].query('/Online_GameShop_VasylZavadetskyi/Product/Name') as 'Name'
FROM [dbo].Online_GameShop_VasylZavadetskyi

SELECT [xmlcolumn].value('(/Online_GameShop_VasylZavadetskyi/Product/Name)[1]', 'VARCHAR(50)') as 'Name'		--'value' requires 2 arguments: path and datatype
FROM [dbo].Online_GameShop_VasylZavadetskyi

DECLARE @xmlhandle INT
DECLARE @xmlinput XML


SET @xmlinput = (SELECT * FROM [dbo].Online_GameShop_VasylZavadetskyi
FOR XML AUTO, ELEMENTS, ROOT ('Online_GameShop_VasylZavadetskyi'))


EXEC sp_xml_preparedocument @xmlhandle OUTPUT, @xmlinput

SELECT * FROM sys.dm_exec_xml_handles (0)


SELECT * FROM OPENXML(@xmlhandle, 'Online_GameShop_VasylZavadetskyi', 2)
WITH ( [Name] VARCHAR(50), [Type] VARCHAR(20), Colour VARCHAR(20), Price money)

EXEC sp_xml_removedocument @xmlhandle

SELECT * FROM sys.dm_exec_xml_handles (0)


/*********** SQL PARTITIONS  ************/

SELECT DISTINCT YEAR(TransactionDate) FROM [Production].[TransactionHistoryArchive]
SELECT * FROM [Production].[TransactionHistoryArchive]


CREATE DATABASE VasylZavadetskyi_DateTimePartition
go
USE VasylZavadetskyi_DateTimePartition
go



ALTER DATABASE VasylZavadetskyi_DateTimePartition
ADD FILEGROUP t1fg;  
GO  
ALTER DATABASE VasylZavadetskyi_DateTimePartition
ADD FILEGROUP t2fg;  
GO  




ALTER DATABASE  VasylZavadetskyi_DateTimePartition 
ADD FILE   
(  
    NAME = t1d1,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\t1d1.ndf'  
)  
TO FILEGROUP t1fg;  

ALTER DATABASE VasylZavadetskyi_DateTimePartition  
ADD FILE   
(  
    NAME = t2d2,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\t2d2.ndf' 
)  
TO FILEGROUP t2fg;  
GO  


CREATE PARTITION FUNCTION VasylZavadetskyi_Partition_Transaction_History490
(DATETIME)
AS RANGE RIGHT FOR VALUES (2010-01-01, 2011-01-01)
GO

CREATE PARTITION SCHEME PartitionScheme10
    AS PARTITION VasylZavadetskyi_Partition_Transaction_History490
    TO (t1fg, t2fg) ;  
GO  

use VasylZavadetskyi_DateTimePartition
go

CREATE TABLE PartitionTable2 (TransactionDate DATETIME PRIMARY KEY, TransactionID int)  
    ON PartitionScheme10 (TransactionDate) ;  
GO  

use VasylZavadetskyi_DateTimePartition
go

INSERT INTO PartitionTable2 (TransactionDate, TransactionID)
VALUES ('2011-04-12', 1),
	('2012-05-25', 2),
	('2014-03-21', 3),
	('2015-04-21', 4),
	('2008-10-08',5),
	('2014-12-04',6),
	('2011-03-24',7)



/*********** SQL GEOMETR  ************/
CREATE TABLE SpatialTable1   
    ( id int IDENTITY (1,1),  
    [Geometry] geometry,   
    [Label] AS [Geometry].STAsText() );  
GO  

INSERT INTO SpatialTable1 ([Geometry])  
VALUES (geometry::STGeomFromText('LINESTRING (100 100, 50 150, 150 150)', 0));  
  
INSERT INTO SpatialTable1 ([Geometry])  
VALUES (geometry::STGeomFromText('POLYGON ((0 0, 150 0, 150 150, 0 150, 0 0))', 0));  
GO  

DECLARE @Sq geometry 
= geometry::STGeomFromText('POLYGON((100 0, 100 100, 300 100, 300 0, 100 0))', 0),
@Tri geometry 
= geometry::STGeomFromText('POLYGON((100 100,200 300,300 100, 100 100))', 0);
SELECT @Sq.STUnion(@Tri)