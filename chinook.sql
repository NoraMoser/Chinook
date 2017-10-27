-- non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT FirstName, LastName, CustomerId, Country FROM Customer WHERE Country != "USA";

-- brazil_customers.sql: Provide a query only showing the Customers from Brazil.

SELECT * FROM Customer WHERE Country = "Brazil";

--brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT cust.FirstName, cust.LastName, inv.InvoiceId, inv.BillingCountry, inv.InvoiceDate
FROM Invoice as inv LEFT JOIN Customer as cust on inv.CustomerId = cust.CustomerId WHERE inv.BillingCountry = "Brazil"; 

-- sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.

SELECT * FROM Employee WHERE Title = "Sales Support Agent"

-- unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.

SELECT DISTINCT BillingCountry FROM Invoice;

-- sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.

SELECT emp.FirstName, emp.LastName, emp.Title, inv.InvoiceId
FROM Customer as cust LEFT JOIN Invoice as inv ON cust.customerId = inv.customerId
LEFT JOIN Employee as emp ON cust.SupportRepId = emp.EmployeeId WHERE emp.Title = "Sales Support Agent";

-- invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

SELECT cust.FirstName, cust.LastName, inv.Total, emp.FirstName, emp.LastName, cust.Country
FROM Customer as cust LEFT JOIN Employee as emp ON cust.customerId = inv.customerId
LEFT JOIN Invoice as inv ON cust.SupportRepId = emp.EmployeeId


-- total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?

SELECT SUM(Total)
FROM Invoice
WHERE InvoiceDate GLOB "2009*" OR InvoiceDate GLOB "2011*"
GROUP BY InvoiceDate GLOB "2011*";

-- total_sales_{year}.sql: What are the respective total sales for each of those years?

SELECT SUM(Total)
FROM Invoice
WHERE InvoiceDate GLOB "2009*" OR InvoiceDate GLOB "2011*"
GROUP BY InvoiceDate GLOB "2011*";


-- invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT COUNT(InvoiceId)
FROM InvoiceLine
WHERE InvoiceId = "37";


-- line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY

SELECT InvoiceId, COUNT(InvoiceId) as "Line Items"
FROM InvoiceLine
GROUP BY InvoiceId;


-- line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.

SELECT t.Name, art.Name, il.*
FROM Track as t LEFT JOIN InvoiceLine as il ON t.TrackId = il.TrackId
LEFT JOIN Album as a ON t. AlbumId = a.AlbumId
LEFT JOIN Artist as art ON a.AlbumId = art.ArtistId;



-- line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.

SELECT t.Name, art.Name, il.*
FROM Track as t LEFT JOIN InvoiceLine as il ON t.TrackId = il.TrackId
LEFT JOIN Album as a ON t. AlbumId = a.AlbumId
LEFT JOIN Artist as art ON a.AlbumId = art.ArtistId;


-- country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY

SELECT BillingCountry, COUNT(InvoiceId)
FROM Invoice
GROUP BY BillingCountry;


-- playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.

SELECT p.name, COUNT(pt.TrackId)
From Playlist as p LEFT JOIN PlaylistTrack as pt ON p.PlaylistId = pt.PlaylistId
group by p.PlaylistId


-- tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.

SELECT t.Name, a.Title, mt.Name, g.Name
FROM Track as t LEFT JOIN Album as a ON t.AlbumId = a.AlbumId
LEFT JOIN MediaType as mt ON t.MediaTypeId = mt.MediaTypeId
LEFT JOIN Genre as g ON t.GenreId = g.GenreId;

-- invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.

SELECT inv.*, il.Quantity
FROM Invoice as inv LEFT JOIN InvoiceLine as il ON inv.InvoiceId = il.InvoiceId

-- sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.

SELECT emp.Title, Count (cust.SupportRepId)
FROM Customer as cust LEFT JOIN Employee as emp ON cust.SupportRepId = emp.EmployeeId
GROUP BY emp.EmployeeId;

-- top_2009_agent.sql: Which sales agent made the most in sales in 2009?

--     Hint: Use the MAX function on a subquery.
SELECT emp.Title, emp.FirstName, COUNT (inv.InvoiceDate)
FROM Customer as cust LEFT JOIN Employee as emp ON cust.SupportRepId = emp.EmployeeId
LEFT JOIN Invoice as inv ON cust.CustomerId = inv.CustomerId
WHERE inv.InvoiceDate GLOB "2009*" IN
	(SELECT MAX (COUNT (InvoiceDate)))
GROUP BY emp.EmployeeId;


-- top_agent.sql: Which sales agent made the most in sales over all?

SELECT MAX(winner.totalsales) as TotalSales, winner.name
FROM (SELECT emp.Title, emp.FirstName as name, SUM (inv.Total) as totalsales
	FROM Customer as cust LEFT JOIN Employee as emp ON cust.SupportRepId = emp.EmployeeId
	LEFT JOIN Invoice as inv ON cust.CustomerId = inv.CustomerId
	WHERE inv.InvoiceDate GLOB "2009*" 
	GROUP BY emp.EmployeeId ORDER BY SUM (inv.Total) DESC) AS winner;


-- sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.

Select Employee.FirstName, Employee.LastName, Employee.Title, Count(Customer.CustomerId)
From Employee, Customer
where Employee.EmployeeId = Customer.SupportRepId
GROUP BY Employee.EmployeeId


-- sales_per_country.sql: Provide a query that shows the total sales per country.

SELECT BillingCountry, SUM(Total)
FROM invoice
GROUP BY BillingCountry;

-- top_country.sql: Which country's customers spent the most?

SELECT i.BillingCountry, SUM (i.Total)
FROM Invoice as i LEFT JOIN Customer as c ON i.CustomerId = c.CustomerId
GROUP BY i.BillingCountry ORDER BY SUM (i.Total) DESC LIMIT 1;


-- top_2013_track.sql: Provide a query that shows the most purchased track of 2013.

SELECT t.Name 'Track', count(*) 'Purchases'
FROM Track t, Invoice inv, InvoiceLine il
WHERE t.TrackId = il.TrackId and inv.InvoiceId = il.InvoiceId and inv.InvoiceDate GLOB "2013*"
GROUP BY t.TrackId
ORDER BY COUNT(*) desc LIMIT 1;

-- top_5_tracks.sql: Provide a query that shows the top 5 most purchased tracks over all.

SELECT t.Name, COUNT (il.InvoiceId) as Sales, SUM (i.Total) as Money
FROM Track as t LEFT JOIN InvoiceLine as il ON t.TrackId = il.TrackId
LEFT JOIN Invoice as i ON il.InvoiceId = i.InvoiceId
GROUP BY il.InvoiceId ORDER BY Money DESC LIMIT 5;


-- top_3_artists.sql: Provide a query that shows the top 3 best selling artists.

SELECT  art.Name, COUNT (a.ArtistId) as NumberAlbumsSold, SUM (i.Total) as TotalMoney
FROM Track as t LEFT JOIN InvoiceLine as il ON t.TrackId = il.TrackId
LEFT JOIN Album as a ON t.AlbumId = a.AlbumId
LEFT JOIN Invoice as i ON il.InvoiceId = i.InvoiceId
LEFT JOIN Artist as art ON a.ArtistId = art.ArtistId
GROUP BY art.Name ORDER BY TotalMoney DESC LIMIT 3;

-- top_media_type.sql: Provide a query that shows the most purchased Media Type.

SELECT mt.Name, COUNT (t.MediaTypeId) as NumberSold
FROM Track as t LEFT JOIN MediaType as mt ON t.MediaTypeId = mt.MediaTypeId
LEFT JOIN InvoiceLine as il ON t.TrackId = il.TrackId
LEFT JOIN Invoice as i ON il.InvoiceId = i.InvoiceId
GROUP BY mt.Name ORDER BY NumberSold DESC LIMIT 1;