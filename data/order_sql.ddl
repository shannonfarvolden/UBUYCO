CREATE TABLE User (
    uid INT NOT NULL PRIMARY KEY,
    username VARCHAR(20) NOT NULL,
    password VARCHAR(20) NOT NULL,
    email VARCHAR(50),
    picture BLOB(65535),
    description VARCHAR(255),
    rating FLOAT,
    showemail BOOL,
    itemsbought INT
);

CREATE TABLE Category (
    cname VARCHAR(20) NOT NULL PRIMARY KEY
);

CREATE TABLE Product (
    pid INT,
    pname VARCHAR(30),
    price DECIMAL(10,2),
    description VARCHAR(255),
    pcondition VARCHAR(255),
    issold BOOL,
    userselling INT,
    pcategory VARCHAR(20),
    PRIMARY KEY(pid),
    FOREIGN KEY(userselling) REFERENCES User(uid),
    FOREIGN KEY(pcategory) REFERENCES Category(cname)
);


CREATE TABLE User (
    uid INT,
    username VARCHAR(20),
    password VARCHAR(20),
    email VARCHAR(50),
    picture BLOB(65535),
    description VARCHAR(255),
    rating FLOAT,
    showemail BOOL,
    itemsbought INT,
    PRIMARY KEY (uid)
);

CREATE TABLE Category (
    cname VARCHAR(20),
PRIMARY KEY(cname)
);



CREATE TABLE Product (
    pid INT,
    pname VARCHAR(30),
    price DECIMAL(10,2),
    description VARCHAR(255),
    pcondition VARCHAR(255),
    issold BOOL,
    userselling INT,
    pcategory VARCHAR(20),
    PRIMARY KEY(pid),
    FOREIGN KEY(userselling) REFERENCES User(uid),
    FOREIGN KEY(pcategory) REFERENCES Category(cname)
);



CREATE TABLE Message (
    mid INT,
    senttime TIMESTAMP,
    receiver INT,
    subject VARCHAR(50),
    content VARCHAR(255),
    sender INT,
    PRIMARY KEY (mid),
    FOREIGN KEY (sender) REFERENCES User(uid)
);

CREATE TABLE Comment (
    cid INT,
    subject VARCHAR(50),
    content VARCHAR(255),
    commenter INT,
    onproduct INT,
    incategory VARCHAR(20),
    PRIMARY KEY(cid),
    FOREIGN KEY(commenter) REFERENCES User(uid),
    FOREIGN KEY(onproduct) REFERENCES Product(pid),
    FOREIGN KEY(incategory) REFERENCES Category(cname)
);

CREATE TABLE Message (
    mid INT NOT NULL PRIMARY KEY,
    senttime TIMESTAMP,
    receiver INT,
    subject VARCHAR(50),
    content VARCHAR(255),
    sender INT,
    FOREIGN KEY (sender) REFERENCES User(uid)
);

CREATE TABLE Comment (
    cid INT NOT NULL PRIMARY KEY,
    subject VARCHAR(50),
    content VARCHAR(255),
    commenter INT,
    onproduct INT,
    incategory VARCHAR(20),
    FOREIGN KEY(commenter) REFERENCES User(uid),
    FOREIGN KEY(onproduct) REFERENCES Product(pid),
    FOREIGN KEY(incategory) REFERENCES Category(cname)
);
