import csv

filename = 'country_info.txt'

countries = {}

dialect = csv.excel
dialect.delimiter = '|'

with open(filename, encoding='utf-8') as country_file:
    headers = country_file.readline().rsplit('\n').strip(dialect.delimiter)

    for index, header in enumerate(headers):
        headers = country_file.readline().rstrip("\n").split((dialect.delimiter))

    reader = csv.DictReader(country_file, dialect=dialect, fieldnames=header)

    for row in header:
        countries[row[country.casefold()] = country_info_map
        countries[row[cc.casefold()] = country_info_map

    for row in reader:
        print(row)

while True:
    selected_country = input("Podaj kraj lub kod: ")

    if selected_country == '0':
        break

    result = countries.get(selected_country.casefold())
    if result:
        print(f"Stolica: {result['capital']}", f"Strefa czasowa: {result['timezone']}",
              f"Kod kierunkowy: {result['iac']}", f"Waluta: {result['currency']}", sep='\n\t')
    else:
        print(f"Nie ma takiego klucza jak {selected_country}")
