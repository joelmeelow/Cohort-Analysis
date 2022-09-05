use portifolio;

---data cleaning
---Total Records = 541909
---135080 Records have no customerID
---406829 Records have customerID


;with online_retail as

 (
     select * from [dbo].[Online Retail Store]
     where CustomerID != 0

)
,quantity_unit_price as
(  

    ---397882 records with quantity and unit price
    select *
    from online_retail
    where Quantity > 0 and UnitPrice > 0
)
,duplicate_check as
(

    ---Duplicate check

	select * , ROW_NUMBER() OVER (partition by InvoiceNo, StockCode, Quantity order by InvoiceDate)duplicates
	from quantity_unit_price
)

---397667 clean data
---5215 duplicate records
select *
into #cleaned_online_data
from duplicate_check
where duplicates = 1

--- cohort analysis

select * from #cleaned_online_data
---Unique Identifier (customerID)
---Initial Start Date (First Invoice Date)
---Revenue Date

select 
	CustomerID,
	min(InvoiceDate)first_purchase_date,
	DATEFROMPARTS(year(min(InvoiceDate)), month(min(invoiceDate)), 1) cohort_Date
into #cohort_time
from #cleaned_online_data
group by CustomerID


select * from #cohort_time 

---Create cohort index

select
   diff.*,
   cohort_index = year_diff * 12 + month_diff + 1

into #cohort_retention_time
from
    (
		select
		   joined.*,
		   year_diff = invoice_year - cohort_year,
		   month_diff = invoice_month - cohort_month

		from 
			  (
					select 
						d.*,
						t.Cohort_Date,
						year(d.InvoiceDate) invoice_year,
						month(d.InvoiceDate) invoice_month,
						year(t.Cohort_Date) cohort_year,
						month(t.Cohort_Date) cohort_month
					from #cleaned_online_data d
					left join #cohort_time t
					on d.CustomerID = t.CustomerID
			  )joined
	)diff

select * from  #cohort_retention_time


---creating a pivot table

select
*
into #cohort_pivot_table
from
	(select distinct
		CustomerID,
		Cohort_Date,
		cohort_index

	from #cohort_retention_time
	
	
 )grouped_data
 pivot(
      count(CustomerID)
	  for cohort_index in
	  ([1],
	  [2],
	  [3],
	  [4],
	  [5],
	  [6],
	  [7],
	  [8],
	  [9],
	  [10],
	  [11],
	  [12],
	  [13])
	  ) as pivot_table

select 
	*, 1.0 * [1]/[1] * 100 as first_month,
			1.0 * [2]/[1] * 100 as second_month,
			1.0 * [3]/[1] * 100 as third_month,
			1.0 * [4]/[1] * 100 as forth_month,
			1.0 * [5]/[1] * 100 as fifth_month,
			1.0 * [6]/[1] * 100 as sixth_month,
			1.0 * [7]/[1] * 100 as seventh_month,
			1.0 * [8]/[1] * 100 as eight_month,
			1.0 * [9]/[1] * 100 as nineth_month,
			1.0 * [10]/[1] * 100 as tenth_month,
			1.0 * [11]/[1] * 100 as eleventh_month,
			1.0 * [12]/[1] * 100 as twelveth_month,
			1.0 * [13]/[1] * 100 as thirteeth_month
from #cohort_pivot_table
order by Cohort_Date