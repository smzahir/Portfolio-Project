-- Exploratory Data Analysis Of Udemy Financial Courses


SELECT * 
FROM Udemy_data

-- Removing unwanted columns from the table

ALTER TABLE Udemy_data
DROP COLUMN  url, avg_rating, avg_rating_recent, is_wishlisted,
			 num_published_practice_tests, created, discount_price__currency,
			 discount_price__price_string, price_detail__price_string,
			 price_detail__currency

-- Renaming columns for better understanding

sp_rename 'Udemy_data.id','ID'
GO
sp_rename 'Udemy_data.title','Title'
GO
sp_rename 'Udemy_data.is_paid','PaidCourse'
GO
sp_rename 'Udemy_data.num_subscribers','Subscribers'
GO
sp_rename 'Udemy_data.rating','Rating'
GO
sp_rename 'Udemy_data.num_reviews','Reviews'
GO
sp_rename 'Udemy_data.num_published_lectures','LecturesPublished'
GO
sp_rename 'Udemy_data.published_time','DatePublished'
GO
sp_rename 'Udemy_data.discount_price__amount','OfferPrice'
GO
sp_rename 'Udemy_data.price_detail__amount','Price'

-- As checked OfferPrice and Price Columns contains null values

SELECT * 
FROM Udemy_data
WHERE Price IS NULL

-- Replacing null values with Zeroes

UPDATE Udemy_data
SET Price =
	CASE
		WHEN Price IS NULL THEN 0
		ELSE Price
	END 

UPDATE Udemy_data
SET OfferPrice =
	CASE 
		WHEN OfferPrice IS NULL THEN 0
		ELSE OfferPrice
	END

-- Converting DataPublished into Date type only

UPDATE Udemy_data
SET DatePublished =
	CAST(DatePublished as DATE)




--insights--

-- Top 5 courses with high rating and subscribers 

SELECT TOP 5 *
FROM Udemy_data
ORDER BY Rating DESC, Subscribers DESC, Reviews DESC

-- Most Reviewed courses with subscribers

SELECT *
FROM Udemy_data
ORDER BY Reviews DESC, Subscribers DESC

-- Top 10 free courses based on rating and subscribers on Udemy 
SELECT TOP 10 *
FROM Udemy_data
WHERE PaidCourse = 0
ORDER BY Rating DESC, Subscribers DESC

-- High Paid Course with Top Reviews

SELECT *
FROM Udemy_data
ORDER BY Price DESC, Reviews DESC

-- Affordable and underrated Courses
SELECT ID, Title, Subscribers,Reviews,Rating, DatePublished, OfferPrice
FROM Udemy_data 
WHERE OfferPrice > 0
ORDER BY Reviews DESC, Subscribers DESC

-- Top 5 sql courses with high rating and subscribers

SELECT TOP 5 ID, Title, Subscribers,Reviews,Rating, DatePublished, OfferPrice
FROM Udemy_data
WHERE Title LIKE '%sql%'
ORDER BY Subscribers DESC, Rating DESC

