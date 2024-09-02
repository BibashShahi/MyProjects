import datetime

VAT_RATE = 0.13

def generate_purchase_invoice(name, brand, price, quantity):
    net_amount = float(price) * quantity
    vat_amount = net_amount * VAT_RATE
    total = net_amount + vat_amount
    invoice_name = f"purchase_invoice_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.txt"
    with open(invoice_name, 'w') as inv:
        inv.write(f"Purchase Invoice\n")
        inv.write(f"Date & Time: {datetime.datetime.now()}\n")
        inv.write(f"Name: {name}\nBrand: {brand}\nQuantity: {quantity}\nNet Amount: ${net_amount}\n")
        inv.write(f"VAT (13%): ${vat_amount}\nTotal: ${total}\n")
    return invoice_name

def generate_sale_invoice(name, brand, customer_name, price, count):
    total_amount = price * count
    invoice_name = f"sale_invoice_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.txt"
    with open(invoice_name, 'w') as inv:
        inv.write(f"Sale Invoice\n")
        inv.write(f"Date & Time: {datetime.datetime.now()}\n")
        inv.write(f"Name: {name}\nBrand: {brand}\nCustomer: {customer_name}\n")
        inv.write(f"Total Amount: ${total_amount}\n")
    return invoice_name
