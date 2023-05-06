filename = 'country_info.txt'

countries = {}
with open(filename, encoding='utf-8') as country_file:
    for line in country_file:
        data = line.strip().split('|')
        country, capital, cc, cc3, iac, timezone, currency = data
        # Teraz chcemy zasilić mapę countries

        # Toworzymy mapę z danymi
        country_info_map = {
            'capital': capital,
            'timezone': timezone,
            'iac': iac,
            'currency': currency
        }
        countries[country.casefold()] = country_info_map
        countries[cc.casefold()] = country_info_map

for key in countries:
    print(f"KEY: {key}, VALUE: {countries[key]}")

while True:
    selected_country = input("Podaj kraj lub kod: ")
    if not selected_country:
        break

    result = countries.get(selected_country.casefold())
    if result:
        print(f"Stolica: {result['capital']}", f"Strefa czasowa: {result['timezone']}",
              f"Kod kierunkowy: {result['iac']}", f"Waluta: {result['currency']}", sep='\n')
    else:
        print(f"Nie ma takiego klucza jak {selected_country}")
