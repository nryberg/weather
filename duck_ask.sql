SELECT Wind_Speed,
    Case
        When Wind_Speed = 0 THEN 'None'
        WHEN Wind_Speed < 4 THEN 'Moderate'
        WHEN Wind_Speed <= 10 THEN 'Breezy'
        WHEN Wind_Speed > 10 THEN 'Hurricane'
        ELSE 'Unknown'
    END as Wind_Speed_Category
FROM wx_raw USING sample 10 Rows;