{% macro excel_serial_to_date(expression) %}
case
    when {{ expression }} is null then null
    when ({{ expression }})::text ~ '^[0-9]+(\.0+)?$'
        then (date '1899-12-30' + (({{ expression }})::numeric)::int)
    else ({{ expression }})::text::date
end
{% endmacro %}
