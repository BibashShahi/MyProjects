FILENAME = 'laptops.txt'

def display():
    with open(FILENAME, 'r') as file:
        for line in file:
            print(line.strip())
