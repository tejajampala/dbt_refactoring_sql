{% set person = {
    ‘name’: ‘me’,
    ‘number’: 3
} %}

{{ person.name }}

--me

{{ person[‘number’] }}

--3
------------------

{% set self = [‘me’, ‘myself’] %}

{{ self[0] }}

-------------------

{% set temperature = 80.0 %}

On a day like this, I especially like

{% if temperature > 70.0 %}

a refreshing mango sorbet.

{% else %}

A decadent chocolate ice cream.

{% endif %}

--On a day like this, I especially like

--a refreshing mango sorbet

-------------------

{% set flavors = [‘chocolate’, ‘vanilla’, ‘strawberry’] %}

{% for flavor in flavors %}

Today I want {{ flavor }} ice cream!

{% endfor %}

--Today I want chocolate ice cream!

--Today I want vanilla ice cream!

--Today I want strawberry ice cream!

---------------------

{% macro hoyquiero(flavor, dessert = ‘ice cream’) %}

Today I want {{ flavor }} {{ dessert }}!

{% endmacro %}

{{ hoyquiero(flavor = ‘chocolate’) }}

Today I want chocolate ice cream!

{{ hoyquiero(mango, sorbet) }}

--Today I want mango sorbet!