import csv

filename = 'ingredients.csv'

ingredients = []

dialect = csv.excel
dialect.delimiter = ';'

with open(filename, encoding='utf-8') as ingredients_file:
    headers = ingredients_file.readline().strip('\n').split(dialect.delimiter)

    ingredients_db = ingredients_file.read()

    reader = csv.DictReader(ingredients_file, dialect=dialect)

    print(ingredients_db)