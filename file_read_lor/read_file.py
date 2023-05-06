lord_of_the_rings = open('lor.txt', 'r', encoding='utf-8')

for line in lord_of_the_rings:
    print(line.rstrip())

lord_of_the_rings.close()
