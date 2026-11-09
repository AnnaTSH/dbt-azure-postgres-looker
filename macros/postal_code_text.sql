{% macro postal_code_text(expression) %}
case
    when {{ expression }} is null then null
    when btrim(({{ expression }})::text) = '' then null
    else lpad(split_part(btrim(({{ expression }})::text), '.', 1), 5, '0')
end
{% endmacro %}
