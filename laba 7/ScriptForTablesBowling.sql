-- Удаляем базу данных если она существует
SET FOREIGN_KEY_CHECKS = 0;
DROP DATABASE IF EXISTS bowling_center ;
CREATE DATABASE bowling_center;
SET FOREIGN_KEY_CHECKS = 1;
-- Используем созданную базу
USE bowling_center;

--  TABLE: staffposition
CREATE TABLE staffposition (
    PositionId INT AUTO_INCREMENT PRIMARY KEY,
    Type VARCHAR(30) NOT NULL
);

--  TABLE: staff
CREATE TABLE staff (
    StaffId INT AUTO_INCREMENT PRIMARY KEY,
    PositionId INT NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    FOREIGN KEY (PositionId) REFERENCES staffposition(PositionId)
);

--  TABLE: customer
CREATE TABLE customer (
    CustomerId INT AUTO_INCREMENT PRIMARY KEY,
    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50),
    BirthDate DATE ,
    BookingHistory TEXT,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15) NOT NULL
);

--  TABLE: discount
CREATE TABLE discount (
    DiscountCode VARCHAR(20) PRIMARY KEY ,
    Description TEXT,
    DiscountValue DECIMAL(5,2 ) NOT NULL,
    Conditions TEXT
);

--  TABLE: customerdiscount
CREATE TABLE customerdiscount (
    CustomerDiscountID INT AUTO_INCREMENT PRIMARY KEY,
    DiscountCode VARCHAR(20) NOT NULL,
    CustomerId INT NOT NULL,
    FOREIGN KEY (DiscountCode) REFERENCES discount(DiscountCode),
    FOREIGN KEY (CustomerId) REFERENCES customer(CustomerId)
);
--  TABLE: track
CREATE TABLE track (
    TrackId INT AUTO_INCREMENT PRIMARY KEY,
    Dostupmost BOOLEAN NOT NULL,
    MaxPlayers INT NOT NULL,
    IsForChildren BOOLEAN NOT NULL
);
--  TABLE: booking

CREATE TABLE booking (
    BookingId INT AUTO_INCREMENT PRIMARY KEY,
    CustomerDiscountID INT NOT NULL,
    MAXDuration INT NOT NULL,
    NumberOfPlayers INT NOT NULL,
    FinalPrice DECIMAL(10,2) NOT NULL,
    ReservationUsed BOOLEAN NOT NULL,
    StartDate DATE NOT NULL,
    BookingDate DATE NOT NULL,
    StaffID INT NOT NULL,
    StartTime TIME NOT NULL,
    FOREIGN KEY (CustomerDiscountID) REFERENCES customerdiscount(CustomerDiscountID),
    FOREIGN KEY (StaffID) REFERENCES staff(StaffId)
);

--  TABLE: bookingtrack
CREATE TABLE bookingtrack (
    BookingTrackId INT AUTO_INCREMENT PRIMARY KEY,
    BookingId INT NOT NULL,
    TrackId INT NOT NULL,
    Duration INT NOT NULL,
    FOREIGN KEY (BookingId) REFERENCES booking(BookingId),
    FOREIGN KEY (TrackId) REFERENCES track(TrackId)
);