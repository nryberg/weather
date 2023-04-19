with fix_date as (
    SELECT
    select
        substr(observed_timestamp_s, 1, 10) as obs_date
    from
        wx_load
    limit
        10
)
SELECT
    *
FROm
    fix_date