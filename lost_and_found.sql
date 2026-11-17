CREATE DATABASE LostAndFound;
SHOW DATABASES;
USE LostAndFound;

CREATE TABLE User (
User_ID INT,
Fname VARCHAR(60),
Lname VARCHAR(60),
Email VARCHAR(100),
Phone VARCHAR(20),
Role ENUM('User','Admin') 
);
DESCRIBE User;

CREATE TABLE Report (
Report_ID INT,
Report_Date DATE,
Report_Type VARCHAR(20),
Report_Status ENUM('Pending', 'Resolved', 'Cancelled'), 
Pickup_Location VARCHAR(100),
User_ID INT
);
DESCRIBE Report;

CREATE TABLE Item (
Item_ID INT,
Item_Name VARCHAR(100),
Category VARCHAR(50),
Description VARCHAR(100),
Status VARCHAR(20),
Report_ID INT
);
DESCRIBE Item;

SHOW TABLES;

ALTER TABLE User
ADD PRIMARY KEY (User_ID);

ALTER TABLE Report
ADD PRIMARY KEY (Report_ID);

ALTER TABLE Item
ADD PRIMARY KEY (Item_ID);

ALTER TABLE Report
ADD FOREIGN KEY (User_ID) REFERENCES User(User_ID);

ALTER TABLE Item
ADD UNIQUE (Report_ID);

ALTER TABLE Item

ADD FOREIGN KEY (Report_ID) REFERENCES Report(Report_ID);

SHOW CREATE TABLE User;
SHOW CREATE TABLE Report;
SHOW CREATE TABLE Item;

ALTER TABLE User
ADD UNIQUE (Email);

ALTER TABLE User
MODIFY COLUMN Fname VARCHAR(60) NOT NULL,
MODIFY COLUMN Lname VARCHAR(60) NOT NULL;

ALTER TABLE Report
MODIFY COLUMN Report_Date DATE NOT NULL,
MODIFY COLUMN Report_Status ENUM('Pending','Resolved','Cancelled') NOT NULL,
MODIFY COLUMN User_ID INT NOT NULL;

ALTER TABLE Item
MODIFY COLUMN Item_Name VARCHAR(100) NOT NULL,
MODIFY COLUMN Status ENUM('Lost','Found') NOT NULL,
MODIFY COLUMN Report_ID INT NOT NULL;

ALTER TABLE Item
ADD CHECK (Status IN ('Lost','Found'));

ALTER TABLE Report
ADD CHECK (Report_Status IN ('Pending','Resolved','Cancelled'));

INSERT INTO User VALUES
(1,'Layan','Mohammed','layan@email.com','0501111111','Admin'),
(2,'Ethar','Hatem','ethar@email.com','0502222222','User'),
(3,'Azizah','Al-Ajyan','azizah@email.com','0503333333','User'),
(4,'Ruwaina','Majid','ruwaina@email.com','0504444444','User'),
(5,'Noor','Ali','noor@email.com','0505555555','User');

INSERT INTO Report VALUES
(2,'2025-01-02','Found','Resolved','Gate B',2),
(3,'2025-01-03','Lost','Pending','Library',3),
(4,'2025-01-04','Found','Resolved','Cafeteria',4),
(5,'2025-01-05','Lost','Pending','Parking',5);

INSERT INTO Item VALUES
(2,'Wallet','Personal','Black wallet','Found',2),
(3,'Bag','Accessories','Backpack','Lost',3),
(4,'Keys','Personal','Car keys','Found',4),
(5,'Watch','Accessories','Silver watch','Lost',5);

SELECT User_ID , Fname , Lname , Role From User
WHERE Role IN ('User');

SELECT Item_ID, Item_Name, Category FROM Item
WHERE Status IN ('Lost');

SELECT Report_ID, Report_Status, Pickup_Location From Report
where Report_Status IN ('Pending');

SELECT COUNT(*) AS Total_Reports
FROM Report;

SELECT Status, COUNT(*) AS Total_Items
FROM Item
GROUP BY Status;

SELECT User.Fname, User.Lname, Report.Report_Status
FROM User
JOIN Report ON User.User_ID = Report.User_ID;

SELECT Item_Name
FROM Item
WHERE Report_ID IN (SELECT Report_ID FROM Report
WHERE Pickup_Location = 'Library');

CREATE VIEW Pending_Reports AS
SELECT Report_ID, Pickup_Location, Report_Status
FROM Report
WHERE Report_Status = 'Pending';

SELECT * FROM Pending_Reports;

SELECT * FROM User;
SELECT * FROM Report;
SELECT * FROM Item;
