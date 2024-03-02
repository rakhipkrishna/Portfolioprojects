---identifying NULL values---

SELECT *
FROM dbo.googleplaystore
WHERE App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL
OR Genres IS NULL
OR Last_Updated IS NULL
OR Current_Ver IS NULL
OR Android_Ver IS NULL
;

---Removing NULL values--

DELETE
FROM dbo.googleplaystore
WHERE App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL
OR Genres IS NULL
OR Last_Updated IS NULL
OR Current_Ver IS NULL
OR Android_Ver IS NULL
;

---Overview of dataset---

SELECT 
COUNT(DISTINCT App) AS total_apps,
COUNT(DISTINCT Category) AS total_categories
FROM dbO.googleplaystore
;

--Explore App categories---

SELECT TOP 5
Category,
COUNT(App) AS Total_apps
FROM dbo.googleplaystore
GROUP BY Category
ORDER BY Total_apps DESC
;

--Top rated free apps--
SELECT
App,
Category,
Rating,
Reviews
FROM dbo.googleplaystore
WHERE Type='Free' AND Rating <> 'NaN'
ORDER BY Rating DESC
;

---Most reviewed app--
SELECT TOP 10
Category,
App,
Reviews
FROM dbo.googleplaystore
ORDER BY Reviews DESC
;

--Average rating by category---
SELECT 
Category,
AVG(TRY_CAST(Rating AS FLOAT)) AS avg_rating
FROM dbo.googleplaystore
GROUP BY Category
ORDER BY avg_rating DESC
;

--Top categories by number of installs---

SELECT
Category,
SUM(CAST(REPLACE(SUBSTRING(Installs, 1, PATINDEX('%[^0-9]%',Installs + ' ') - 1),' ,',' ') AS INT))
AS total_installs
FROM dbo.googleplaystore
GROUP BY Category
ORDER BY total_installs

---avg sentiment polarity by App category---
SELECT 
Category,
AVG(TRY_CAST(Sentiment_Polarity AS FLOAT)) AS avg_sentiment_polarity
FROM dbo.googleplaystore
JOIN dbo.googleplaystore_user_reviews
ON dbo.googleplaystore.App=dbo.googleplaystore_user_reviews.App
GROUP BY Category
ORDER BY avg_sentiment_polarity DESC

-- sentiment reviews by app category --
SELECT TOP 10
Category,
Sentiment,
COUNT(*) AS total_sentiment
FROM dbo.googleplaystore
JOIN dbo.googleplaystore_user_reviews
ON dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.App
WHERE Sentiment <> 'nan'
GROUP BY Category, Sentiment
ORDER BY total_sentiment DESC