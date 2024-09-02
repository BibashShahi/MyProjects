import datetime

FILENAME = 'laptops.txt'

class LaptopInventoryError(Exception):
    pass

def display_laptops():
    try:
        with open(FILENAME, 'r') as file:
            lines = file.readlines()
            for line in lines:
                print(line.strip())
    except FileNotFoundError:
        raise LaptopInventoryError("Laptops file not found!")
    except Exception as e:
        raise LaptopInventoryError(f"An error occurred while displaying laptops: {e}")

def update_stock(name, count):
    try:
        lines = []
        with open(FILENAME, 'r') as file:
            lines = file.readlines()
            for index, line in enumerate(lines):
                details = line.strip().split(", ")
                if details[0] == name:
                    details[3] = str(int(details[3]) + count)
                    lines[index] = ", ".join(details) + "\n"
                    break
        with open(FILENAME, 'w') as file:
            file.writelines(lines)
    except FileNotFoundError:
        raise LaptopInventoryError("Laptops file not found!")
    except Exception as e:
        raise LaptopInventoryError(f"An error occurred while updating stock: {e}")

def generate_purchase_invoice(name, brand, price, quantity):
    filename = f"purchase_invoice_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.txt"
    try:
        with open(filename, 'w') as file:
            file.write(f"Purchased Laptops:\n")
            file.write(f"Name of Laptop: {name}\n")
            file.write(f"Brand: {brand}\n")
            file.write(f"Date and Time: {datetime.datetime.now()}\n")
            file.write(f"Price: ${price}\n")
            file.write(f"Quantity: {quantity}\n")
            total_amount = float(price.replace('$', '').replace(',', '')) * quantity
            file.write(f"Total Amount: ${total_amount:.2f}\n")
        print(f"Invoice saved as {filename}")
    except Exception as e:
        raise LaptopInventoryError(f"An error occurred while generating the invoice: {e}")

def generate_sale_invoice(name, brand, customer_name, price, count):
    filename = f"sale_invoice_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.txt"
    try:
        with open(filename, 'w') as file:
            file.write(f"Customer Name: {customer_name}\n")
            file.write(f"Sold Laptops:\n")
            file.write(f"Name of Laptop: {name}\n")
            file.write(f"Brand: {brand}\n")
            file.write(f"Date and Time: {datetime.datetime.now()}\n")
            file.write(f"Price: ${price}\n")
            file.write(f"Quantity: {count}\n")
            total_amount = float(price.replace('$', '').replace(',', '')) * count
            file.write(f"Total Amount: ${total_amount:.2f}\n")
        print(f"Invoice saved as {filename}")
    except Exception as e:
        raise LaptopInventoryError(f"An error occurred while generating the invoice: {e}")

def purchase():
    name = input("Enter laptop name: ")
    brand = input("Enter brand: ")
    price = input("Enter price: $")
    quantity = int(input("Enter quantity: "))
    processor = input("Enter processor details: ")
    graphic_card = input("Enter graphic card details: ")

    # Check if laptop already exists
    with open(FILENAME, 'r') as file:
        lines = file.readlines()
        for index, line in enumerate(lines):
            details = line.strip().split(", ")
            if details[0] == name:
                details[3] = str(int(details[3]) + quantity)
                lines[index] = ", ".join(details) + "\n"
                break
        else:
            lines.append(f"{name}, {brand}, ${price}, {quantity}, {processor}, {graphic_card}\n")

    with open(FILENAME, 'w') as file:
        file.writelines(lines)

    # Generate invoice
    generate_purchase_invoice(name, brand, price, quantity)

def sell():
    name = input("Enter laptop name to sell: ")
    count = int(input("Enter quantity to sell: "))
    customer_name = input("Enter customer name: ")

    with open(FILENAME, 'r') as file:
        lines = file.readlines()
        laptop_details = []
        for index, line in enumerate(lines):
            details = line.strip().split(", ")
            if details[0] == name:
                if int(details[3]) >= count:
                    details[3] = str(int(details[3]) - count)
                    lines[index] = ", ".join(details) + "\n"
                    laptop_details.append((name, details[1], details[2], count))
                else:
                    raise LaptopInventoryError(f"Only {details[3]} {name} laptops available.")

    with open(FILENAME, 'w') as file:
        file.writelines(lines)

    # Generate invoice
    for laptop in laptop_details:
        generate_sale_invoice(laptop[0], laptop[1], customer_name, laptop[2], laptop[3])

def main():
    while True:
        try:
            choice = input("Do you want to sell (S) or order more (O) laptops? (Type 'exit' to quit): ")
            if choice.lower() == 's':
                sell()
            elif choice.lower() == 'o':
                purchase()
            elif choice.lower() == 'exit':
                break
            else:
                print("Invalid choice. Please enter 'S' for selling or 'O' for ordering more laptops.")
        except LaptopInventoryError as e:
            print(f"Error: {e}")
        except Exception as e:
            print(f"An unexpected error occurred: {e}")


