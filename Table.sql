DROP VIEW product_sales_for_2023;
DROP VIEW products_above_average_price;

DROP TABLE Deliver_To;
DROP TABLE Contain;
DROP TABLE Payment;
DROP TABLE Manage;
DROP TABLE Save_to_Shopping_Cart;
DROP TABLE After_Sales_Service_At;

DROP TABLE Address;
DROP TABLE Orders;
DROP TABLE OrderItem;
DROP TABLE CreditCard;
DROP TABLE DebitCard;
DROP TABLE BankCard;
DROP TABLE Seller;
DROP TABLE Comments;
DROP TABLE Buyer;
DROP TABLE Users;
DROP TABLE Product;
DROP TABLE Store;
DROP TABLE ServicePoint;
DROP TABLE Brand;

-- Entity
CREATE TABLE Users
(
    userId INT NOT NULL
    ,name VARCHAR(20)
    ,phoneNumber VARCHAR(20)
    ,PRIMARY KEY(userId)
);

CREATE TABLE Buyer
(
    userId INT NOT NULL
    ,PRIMARY KEY(userId)
    ,FOREIGN KEY(userId) REFERENCES Users(userId)
);

CREATE TABLE Seller
(
    userId INT NOT NULL
    ,PRIMARY KEY(userId)
    ,FOREIGN KEY(userId) REFERENCES Users(userId)
);

CREATE TABLE BankCard
(
    cardNumber VARCHAR(25) NOT NULL
    ,expiryDate DATE
    ,bank VARCHAR(20)
    ,PRIMARY KEY(cardNumber)
);

CREATE TABLE
CreditCard
(
    cardNumber VARCHAR(25) NOT NULL
    ,userId INT NOT NULL
    ,organization VARCHAR(20)
    ,PRIMARY KEY(cardNumber)
    ,FOREIGN KEY(cardNumber) REFERENCES BankCard(cardNumber)
    ,FOREIGN KEY(userId) REFERENCES Users(userId)
);

CREATE TABLE DebitCard
(
    cardNumber VARCHAR(25) NOT NULL
    ,userId INT NOT NULL
    ,PRIMARY KEY(cardNumber)
    ,FOREIGN KEY(cardNumber) REFERENCES BankCard(cardNumber)
    ,FOREIGN KEY(userId) REFERENCES Users(userId)
);

CREATE TABLE Address
(
    AddrId INT NOT NULL
    ,userId INT NOT NULL
    ,name VARCHAR(50)
    ,contactPhoneNumber VARCHAR(20)
    ,province VARCHAR(100)
    ,city VARCHAR(100)
    ,streetaddr VARCHAR(100)
    ,postCode VARCHAR(12)
    ,PRIMARY KEY(AddrId)
    ,FOREIGN KEY(userId) REFERENCES Users(userId)
);

CREATE TABLE Store
(
    SId INT NOT NULL
    ,name VARCHAR(20)
    ,province VARCHAR(20)
    ,city VARCHAR(20)
    ,streetaddr VARCHAR(20)
    ,customerGrade INT
    ,startTime DATE
    ,PRIMARY KEY(SId)
);

CREATE TABLE Brand
(
    brandName VARCHAR(20) NOT NULL
    ,PRIMARY KEY (brandName)
);

CREATE TABLE Product
(
    PId INT NOT NULL
    ,SId INT NOT NULL
    ,brand VARCHAR(50) NOT NULL
    ,name VARCHAR(100)
    ,type VARCHAR(50)
    ,modelNumber VARCHAR(50)
    ,color VARCHAR(50)
    ,amount INT
    ,price INT
    ,PRIMARY KEY(PId)
    ,FOREIGN KEY(SId) REFERENCES Store(SId)
    ,FOREIGN KEY(brand) REFERENCES Brand(brandName)
);

CREATE TABLE OrderItem
(
    itemid INT NOT NULL
    ,PId INT NOT NULL
    ,price INT
    ,creationTime DATE
    ,PRIMARY KEY(itemId)
    ,FOREIGN KEY(PId) REFERENCES Product(PId)
);

CREATE TABLE Orders
(
    orderNumber INT NOT NULL
    ,paymentState VARCHAR(12)
    ,creationTime DATE
    ,totalAmount INT
    ,PRIMARY KEY (orderNumber)
);


CREATE TABLE Comments  -- Weak Entity
(
    creationTime DATE NOT NULL
    ,userId INT NOT NULL
    ,PId INT NOT NULL
    ,grade FLOAT
    ,content VARCHAR(500)
    ,PRIMARY KEY(creationTime,userId,PId)
    ,FOREIGN KEY(userId) REFERENCES Buyer(userId)
    ,FOREIGN KEY(PId) REFERENCES Product(PId)
);

CREATE TABLE ServicePoint
(
    sPId INT NOT NULL
    ,streetaddr VARCHAR(40)
    ,city VARCHAR(30)
    ,province VARCHAR(20)
    ,startTime VARCHAR(20)
    ,endTime VARCHAR(20)
    ,PRIMARY KEY(spid)
);
-- Relationship

CREATE TABLE Save_to_Shopping_Cart
(
    userId INT NOT NULL
    ,PId INT NOT NULL
    ,addTime DATE
    ,quantity INT
    ,PRIMARY KEY (userId,PId)
    ,FOREIGN KEY(userId) REFERENCES Buyer(userId)
    ,FOREIGN KEY(PId) REFERENCES Product(PId)
);

CREATE TABLE Contain
(
    orderNumber INT NOT NULL
    ,itemId INT NOT NULL
    ,quantity INT
    ,PRIMARY KEY (orderNumber,itemId)
    ,FOREIGN KEY(orderNumber) REFERENCES Orders(orderNumber)
    ,FOREIGN KEY(itemId) REFERENCES OrderItem(itemId)
);

CREATE TABLE Payment
(
    orderNumber INT NOT NULL
    ,creditcardNumber VARCHAR(25) NOT NULL
    ,payTime DATE
    ,PRIMARY KEY(orderNumber,creditcardNumber)
    ,FOREIGN KEY(orderNumber) REFERENCES Orders(orderNumber)
    ,FOREIGN KEY(creditcardNumber) REFERENCES CreditCard(cardNumber)
);

CREATE TABLE Deliver_To
(
    AddrId INT NOT NULL
    ,orderNumber INT NOT NULL
    ,TimeDelivered DATE
    ,PRIMARY KEY(AddrId,orderNumber)
    ,FOREIGN KEY(AddrId) REFERENCES Address(AddrId)
    ,FOREIGN KEY(orderNumber) REFERENCES Orders(orderNumber)
);

CREATE TABLE Manage
(
    userId INT NOT NULL
    ,SId INT NOT NULL
    ,SetUpTime DATE
    ,PRIMARY KEY(userId,SId)
    ,FOREIGN KEY(userId) REFERENCES Seller(userId)
    ,FOREIGN KEY(SId) REFERENCES Store
);

CREATE TABLE After_Sales_Service_At
(
    brandName VARCHAR(20) NOT NULL
    ,sPId INT NOT NULL
    ,PRIMARY KEY(brandName, sPId)
    ,FOREIGN KEY(brandName) REFERENCES Brand (brandName)
    ,FOREIGN KEY(sPId) REFERENCES ServicePoint(sPId)
);
