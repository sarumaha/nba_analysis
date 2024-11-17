{% macro test_efficiency_rating(model) %}

with validation as (
    select
        *,
        case
            when efficiency_rating < 0 then 1
            else 0
        end as invalid_efficiency_rating
    from {{ model }}
    where efficiency_rating is not null
)

select * from validation
where invalid_efficiency_rating = 1

{% endmacro %}
