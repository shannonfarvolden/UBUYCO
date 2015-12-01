DROP TABLE Message;
DROP TABLE Comment;
DROP TABLE Item;
DROP TABLE User;

CREATE TABLE User (
    uid INT NOT NULL,
    username VARCHAR(20),
    password VARCHAR(20),
    email VARCHAR(50),
    picture VARCHAR(255),
    description VARCHAR(255),
    rating FLOAT,
    showemail BOOL,
    itemsbought INT,
    PRIMARY KEY (uid)
);

CREATE TABLE Item (
    pid INT NOT NULL,
    pname VARCHAR(100),
    price DECIMAL(10,2),
    description VARCHAR(255),
    pcondition VARCHAR(255),
    issold BOOL,
    userselling INT,
    pcategory VARCHAR(20),
    PRIMARY KEY(pid),
    FOREIGN KEY(userselling) REFERENCES User(uid) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Message (
    mid INT NOT NULL,
    senttime TIMESTAMP,
    receiver INT,
    subject VARCHAR(50),
    content VARCHAR(255),
    sender INT,
    isRead BOOLEAN,
    PRIMARY KEY (mid),
    FOREIGN KEY (sender) REFERENCES User(uid) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (receiver) REFERENCES User(uid) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Comment (
    cid INT NOT NULL,
    subject VARCHAR(50),
    content VARCHAR(255),
    commenter INT,
    onproduct INT,
    incategory VARCHAR(20),
    receiver INT,
    PRIMARY KEY(cid),
    FOREIGN KEY(commenter) REFERENCES User(uid) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(onproduct) REFERENCES Item(pid) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(receiver) REFERENCES User(uid) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO User VALUES (1,"Carson","boop","carson@internet.com","/coolguy.jpeg","A real neat guy.",5000,TRUE,125);
INSERT INTO User VALUES (2,"Jeff","bop","jeff@internet.com","/coolguy.jpeg","This guy is going places.",10000,TRUE,1);
INSERT INTO User VALUES (3,"Shannon","beep","shannon@internet.com","/coolgirl.jpeg","Shannon knows what's up.",-5000,TRUE,5000);
INSERT INTO User VALUES (4,"Dana","asparagus","carson@internet.com","/coolgirl.jpeg","Someone who you don't want to owe money to.",12345,TRUE,12345);

INSERT INTO Item VALUES (1,"UBC Sweater",15.00,"A really cool sweater, with cool sleeves","Essentially mint condition",FALSE,2,"misc");
INSERT INTO Item VALUES (2,"Scrubs",25.00,"Mauve scrubs with shirt pocket and white trim","Slightly faded",FALSE,2,"nrsg");
INSERT INTO Item VALUES (3,"Algorithm Design by Kleinberg & Tardos",240.00,"Textbook required for COSC320","Tear-stained, but otherwise good",FALSE,3,"sci");
INSERT INTO Item VALUES (4,"Quantum Chemistry by McQuarrie",180.00,"The only way you will get through CHEM312","Impeccable",FALSE,1,"sci");
INSERT INTO Item VALUES (5,"The Hobbit by JRR Tolkien",63.00,"An old book about short people","Very beaten up",FALSE,1,"arts");
INSERT INTO Item VALUES (6,"Labcoat",13.00,"Standard white cotton lab coat used for labs","Never used it, still in packaging",FALSE,1,"sci");
INSERT INTO Item VALUES (7,"Lab glasses",9.99,"Plastic glasses useful for stopping chemicals from hitting your eyes","Pretty decent",FALSE,4,"sci");
INSERT INTO Item VALUES (8,"Stethoscope",27.00,"An instrument for hearing heartbeats","Good",FALSE,4,"nrsg");
INSERT INTO Item VALUES (9,"Paintbrush",2.50,"Synthetic brush, ultra fine point tip. Best on the market","Still in original packaging",FALSE,2,"fina");
INSERT INTO Item VALUES (10,"Acrylic Paint",18.00,"It's paint, but acrylic based","As good as paint can be",FALSE,3,"fina");
INSERT INTO Item VALUES (11,"Engineering Notepad",26.50,"Those yellow pages you see kids in the EME writing on","Well it's paper",FALSE,4,"engi");
INSERT INTO Item VALUES (12,"Graphing Calculator",112.00,"Texas Instruments TI-84","Couple of scratches but that's it, I swear",FALSE,1,"engi");
INSERT INTO Item VALUES (13,"Suit",95.50,"Rich, luxurious Wal-Mart brand suit","Worn once for a presentation",FALSE,2,"mgmt");
INSERT INTO Item VALUES (14,"Friends",1.99,"Jeb, Sandy and Dale. Their dad's all co-own Menchie's","A little beat up",FALSE,4,"mgmt");
INSERT INTO Item VALUES (15,"How to Teach Kids by T. Eetcher",319.99,"A text focusing on childhood education","Perfect",FALSE,3,"educ");
INSERT INTO Item VALUES (16,"How to Teach Teenagers by I.N. Structor",329.99,"A text focusing on adolescent education","Perfect",FALSE,3,"educ");
INSERT INTO Item VALUES (17,"Nursing for Dummies by Florence Nightingale",176.00,"Pretty good read, but slightly 'old-fashioned'","Old",FALSE,4,"nrsg");
INSERT INTO Item VALUES (18,"Acting for Dummies by Hayden Christensen",89.99,"The best acting text by the best actor","Been kept in protective facilities",FALSE,1,"fina");
INSERT INTO Item VALUES (19,"Size 11 Air Jordans",58.50,"My old shoes","Not great",FALSE,2,"misc");
INSERT INTO Item VALUES (20,"China and Historical Capitalism: Genealogies of Sinological Knowledge",160.28,"Text for learning some stuff about China's history with Capitalism","Quite good",FALSE,2,"arts");
INSERT INTO Item VALUES (21,"5 lb. Dumbell",10.66,"A dumbell, but one that happens to weigh 5 lb.","Really really high quality",FALSE,4,"hkin");
INSERT INTO Item VALUES (22,"Muscles and How to get Big Ones by Schwarzenegger",123.45,"A text on getting swull","Okay",FALSE,3,"hkin");
INSERT INTO Item VALUES (23,"Fundamentals of Analytical Chemistry by Skoog",170.18,"Required text for CHEM311","Good",FALSE,2,"sci");
INSERT INTO Item VALUES (24,"Introduction to Telling Folks How to Work Good by I.N. Chaergh",138.99,"A quintessential work for those interested in managing","Essentially mint condition",FALSE,3,"mgmt");
INSERT INTO Item VALUES (25,"Pandora Bracelet",50.00,"A gift from my ex. Can't stand to see it any longer","Stained with emotional baggage",FALSE,1,"misc");
