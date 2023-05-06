filename = 'country_info.txt'

with open(filename, encoding='utf-8') as country_file:
    country_list = []
    country_dict = {}
    for row in country_file:
        data = row.strip().split('|')
        country_list.append(data[0])
        country_dict.update({data[0]: data})

print(country_dict)

while (True):
    country_name = input("Podaj nazwę kraju lub ENTER aby wyjść: ")
    if country_name == "":
        break
    print(country_dict.get(country_name))
    continue

'''
    country_name = input("Podaj nazwę kraju: ")
    for row in country_file:
        data = row.strip().split('|')
        if data[0] == country_name:
            print(data)
            '''
