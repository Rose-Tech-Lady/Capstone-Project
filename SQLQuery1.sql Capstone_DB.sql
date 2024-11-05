 Create DataBase Capstone_DB

 -------Sales Analysis-----------
Select * from [dbo].[Capstone Sales.xlsx2]

Alter [dbo].[Capstone Sales.xlsx2]
Drop Column column 10, column 11,column 12,column 13, column 14, column 15,column 16;

----Total Sale Per Product-----
Select product, 
sum(quantity*unitprice) As TotalSale
from [dbo].[Capstone Sales.xlsx2]
Group By product;

------sales Per Region-----
Select Region, count(*) as NumberOfTransactions
from [dbo].[Capstone Sales.xlsx2]
Group By Region;

----Product with Highest Total Sale-----
Select Top 1 product,
sum(quantity*UnitPrice) as totalSales
from [dbo].[Capstone Sales.xlsx2]
Group By product
Order By TotalSales Desc;

-----total Revenue Per Product------
Select Month(OrderDate) as month, sum(quantity*UnitPrice) as MonthlySales
from [dbo].[Capstone Sales.xlsx2]
Where Year(OrderDate)=Year(GetDate())
Group By month(OrderDate)
Order By month;

----Top 5 Customers By Total Purchase Amount-----
Select Top 5 Customer_Id, 
sum(quantity*UnitPrice) as TotalPurchaseAmount
from [dbo].[Capstone Sales.xlsx2]
Group By Customer_Id
Order By TotalPurchaseAmount Desc;

-----Total Sales % By Region-----
select Region, sum(quantity*UnitPrice) as TotalSales,
sum(quantity*UnitPrice) * 1.0/(Select sum(quantity*Unitprice)
from [dbo].[Capstone Sales.xlsx2]) * 100
as PercentageOfTotalsales
from [dbo].[Capstone Sales.xlsx2]
Group by region;

----Product With No sales in the Last Quarter-----
Select Distinct product
from [dbo].[Capstone Sales.xlsx2]
Where product Not In(
Select product
from [dbo].[Capstone Sales.xlsx2]
Where OrderDate >= DateAdd(Quarter, -1, GetDate()) and OrderDate < GetDate());


-------------------------------------------------------------------------------------------------------------

-----Customers Analysis------

Select * from [dbo].[cleaned customer]	

-------Total Number of Customers per region-------

Select Region, count(Distinct Customerid) as Total_Customers
from [dbo].[cleaned customer]
group By Region;

-------Most Popular Subscription Type------

Select Top 1 SubscriptionType,
count(Distinct customerid) as total_customers
from [dbo].[cleaned customer]
Group By SubscriptionType
Order By Total_customers Desc;

------Customers who Cancelled Subscription within 6 months------

Select CustomerId
from [dbo].[cleaned customer]
Where DateDiff(month, subscriptionstart, subscriptionend)<= 6;

-----average Subscription Duration Per Customer-----

Select Avg(DateDiff(day, Subscriptionstart, subscriptionend))
as Avg_subscription_duration
from [dbo].[cleaned customer];

------Customers with subscription longer than 12 months------

Select CustomerId
from [dbo].[cleaned customer]
where datediff(month, subscriptionstart, subscriptionend)>12;

----Total Revenue By Subscription Type-----

select subscriptiontype, sum(revenue) as TotalRevenue
from [dbo].[cleaned customer]
Group by subscriptiontype;

-----Number of Active and cancelled Subscription--------

Select Top 3 region,
count(*) as subscriptionend_count
from [dbo].[cleaned customer]
where subscriptionend is null
Group by region
Order By subscriptionend_count Desc;