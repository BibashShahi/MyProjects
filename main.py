import operation

def main():
    print("WELCOME TO THE SHOP")    
    print("Choose From the given Options")

    while True:
        print("\nLaptop Shop")
        print("1. Display available laptops")
        print("2. Purchase laptop")
        print("3. Sell laptop")
        print("4. Quit")
        choice = input("Enter your choice: ")

        if choice == '1':
            operation.display_laptops()
        elif choice == '2':
            operation.purchase()
        elif choice == '3':
            operation.sell()
        elif choice == '4':
            break
        else:
            print("Invalid choice. Please select a valid option.")

if __name__ == "__main__":
    main()
