create database QLThuePhong
use QLThuePhong
go
create table Phong
(
	MaPhong char(10) constraint PK_MP primary key,
	SoGiuong int unique not null,
	NhanVienPhuTrach nvarchar(50) not null,
	GiaTien decimal(8,2) not null,
	GhiChu nvarchar(max),
)

create table KhachHang
(	
	MaKhachHang int identity(1,1) constraint PK_MKH primary key,
	TenKhachHang nvarchar(50) unique not null,
	DiaChi nvarchar(100) not null,
	SoDienThoai nvarchar(12) unique not null,
	GhiChu nvarchar(max),
)
create table ThuePhong
(
	MaKhachHang int,
	MaPhong char(10) not null,
	NgayLayPhong datetime default(getdate()),
	NgayTraPhong datetime default(getdate()),
	SoTienDaTra decimal(8,2) not null,
	GhiChu nvarchar(max),
	constraint PK_ThuePhong primary key(MaKhachHang, MaPhong, NgayLayPhong),
	constraint FK_MKH foreign key (MaKhachHang) references KhachHang(MaKhachHang),
	constraint FK_MP foreign key (MaPhong) references Phong(MaPhong),
)
insert into Phong
values
('01',20,'Nguyen Tran Khang',49.9,null),
('02',30,'Nguyen Tran Thi',90.0, 'vip'),
('03',5,'Nguyen Van B',100, 'luxury')
select * from Phong

insert into KhachHang
values
('nguyen as a', 'binh phuoc', '0718471881', 'khach vip'),
('nguyen mmm b', 'quang ngai', '1234567890', 'khach db'),
('nguyen palsd a', 'dak lak', '14280912439', 'khach hlon')
select * from KhachHang

insert into ThuePhong
values
(4, '02', '1936/07/02', '1940/09/03', 100, 'khach hang lau nam')
select * from ThuePhong

insert into ThuePhong
values
(5, '01', '2077/12/03', '2100/12/23', 40.1, 'khach hang den tu tuong lai'),
(6, '03', '1900/1/1', '2000/2/3', 90.9, 'khach hang tu qua khu')
select * from ThuePhong

--CAU 2--
use AdventureWorks2019
go

select st.TerritoryID, CountOfCust = COUNT(sh.CustomerID), SubTotal = SUM(sd.OrderQty * sd.UnitPrice)
from Sales.SalesTerritory st join Sales.SalesOrderHeader sh on st.TerritoryID = sh.TerritoryID
join Sales.SalesOrderDetail sd on sh.SalesOrderID = sd.SalesOrderID
where st.CountryRegionCode = 'US'
group by st.TerritoryID

select pv.BusinessEntityID, pv.Name, ppv.ProductID, SumOfQty = SUM(pd.OrderQty), SubTotal = SUM(pd.UnitPrice * pd.OrderQty)
from Purchasing.Vendor pv join Purchasing.ProductVendor ppv on pv.BusinessEntityID = ppv.BusinessEntityID
join Purchasing.PurchaseOrderDetail pd on ppv.ProductID = pd.ProductID
where pv.Name like '%Bicycles'
group by pv.BusinessEntityID, pv.Name, ppv.ProductID
having SUM(pd.OrderQty * pd.UnitPrice) > 800000

select hd.DepartmentID, hd.Name, AvgOfRate = AVG(he.Rate)
from HumanResources.Department hd join HumanResources.EmployeeDepartmentHistory dh on hd.DepartmentID = dh.DepartmentID
join HumanResources.EmployeePayHistory he on dh.BusinessEntityID = he.BusinessEntityID
group by hd.DepartmentID, hd.Name
having AVG(he.Rate) < 20

select top 10 pp.ProductID, pp.Name, sd.OrderQty
from Production.Product pp join Sales.SalesOrderDetail sd on pp.ProductID = sd.ProductID
join Sales.SalesOrderHeader sh on sd.SalesOrderID = sh.SalesOrderID
where MONTH(sh.OrderDate) = 7 and YEAR(sh.OrderDate) = 2011
group by pp.ProductID, pp.Name, sd.OrderQty
order by sd.OrderQty desc

