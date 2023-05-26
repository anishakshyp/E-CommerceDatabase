# E-CommerceDatabase

## ER Diagram -

### Entities :

* User (__userId__, name, phoneNum)
* Buyer (__userId__)
* Seller (__userId__)
* Bank Card (__cardNumber__, userId, bank, expiryDate)
* Credit Card (__cardNumber__, organization)
* Debit Card (__cardNumber__)
* Store (__SId__, name, startTime, customerGrade, streetAddr, city, province)
* Product (__PId__, SId, name, brand, type, amount, price, colour, customerReview, modelNumber)
* Order Item (__itemId__, PId, price, creationTime)
* Order (__orderNumber__, creationTime, paymentStatus, totalAmount)
* Address (__AddrId__, userId, name, city, postalCode, streetAddr, province, contactPhoneNumber)

### Relationships :

* Manage (__userId__, __SId__, SetupTime) (userId ref Seller, SId ref Store)
* Save to Shopping Cart (__userId__, __PId__, quantity, addtime) (userId ref Buyer, PId ref Product)
* Contain (__orderNumber__, __itemId__, quantity) (orderNumber ref Order, itemId ref Order Item)
* Deliver To (__AddrId__, __orderNumber__, TimeDelivered) (AddrId ref Address, orderNumber ref Order)
* Payment (__C.cardNumber__, __orderNumber__, payTime) (C.cardNumber ref Credit Card, orderNumber ref Order)


## Create Database

* [Table.sql](https://github.com/anishakshyp/E-CommerceDatabase/blob/main/Table.sql): Create tables for entities and relationships above.
* [Insert.sql](https://github.com/anishakshyp/E-CommerceDatabase/blob/main/Insert.sql): Insert datas into tables.
* [Modification.sql](https://github.com/anishakshyp/E-CommerceDatabase/blob/main/Modification.sql): Modify the data.
