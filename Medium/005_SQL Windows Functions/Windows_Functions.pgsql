WITH 
    movie_rents AS (
        SELECT      title
                    , genre
                    , renting_price
                    , AVG(renting_price) OVER (PARTITION BY genre) AS Avg_Renting_Price
            FROM    postgres."DDDM".movies
            ORDER BY 
                genre
    )

SELECT      title
            , genre
            , renting_price
            , ROUND(Avg_Renting_Price, 2) AS Avg_Renting_Price
    FROM    movie_rents