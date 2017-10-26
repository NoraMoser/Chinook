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


-- total_sales_{year}.sql: What are the respective total sales for each of those years?


-- invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.


-- line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY


-- line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.


-- line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.


-- country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY


-- playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.


-- tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.


-- invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.


-- sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.


-- top_2009_agent.sql: Which sales agent made the most in sales in 2009?

--     Hint: Use the MAX function on a subquery.


-- top_agent.sql: Which sales agent made the most in sales over all?


-- sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.


-- sales_per_country.sql: Provide a query that shows the total sales per country.


-- top_country.sql: Which country's customers spent the most?


-- top_2013_track.sql: Provide a query that shows the most purchased track of 2013.


-- top_5_tracks.sql: Provide a query that shows the top 5 most purchased tracks over all.


-- top_3_artists.sql: Provide a query that shows the top 3 best selling artists.


-- top_media_type.sql: Provide a query that shows the most purchased Media Type.