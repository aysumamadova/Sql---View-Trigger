CREATE DATABASE SocialNetwork
USE SocialNetwork


CREATE TABLE Posts(
ID int identity(1,1) primary key,
Content nvarchar(255),
WhenShared date DEFAULT getdate(),
UserId int references Users(ID),
LikeNumber int,
IsDeleted bit

)

CREATE TABLE Users(
ID int identity(1,1) primary key,
[Login] nvarchar(255),
[Password] nvarchar(255),
Mail nvarchar(255) UNIQUE NOT NULL
)

CREATE TABLE Comments(
ID int identity (1,1) primary key,
UserId int references Users(ID),
PostId int references Posts(ID),
LikeNumber int,
IsDeleted bit
)

CREATE TABLE Peoples(
ID int identity (1,1) primary key,
[Name] nvarchar(70),
Surname nvarchar(100),
Age int
)

INSERT INTO Peoples(Name,Surname,Age)
VALUES('Aysu','Memmedova',19),
('Asif','Orucov',20),
('Nergiz','Ehmedli',20)

SELECT * FROM Peoples

INSERT INTO Users(Login,Password,Mail)
VALUES('A.mmva','Aysu123','Ay@gm.com'),
('O.Asif','Asif04','Af@gm.com'),
('Nergizseyyaf','JJN12','NS@gm.com')

SELECT * FROM Users
 
INSERT INTO Posts(Content,UserId,LikeNumber,IsDeleted)
VALUES('ZBLED',1,250,0),
('ASSD',2,200,0),
('AOSDYKKK',2,600,0),
('ghasjk',1,500,0),
('akskjh',2,300,0),
('nsmdjd',3,450,0)

SELECT * FROM Posts
 
INSERT INTO Comments(UserId,PostId,LikeNumber,IsDeleted)
VALUES(1,1,45,0),
(1,4,23,0),
(2,2,50,0),
(2,5,12,0),
(2,3,12,0),
(3,6,80,0)

SELECT * FROM Comments

------QUERY 1--------
SELECT  COUNT(*) as'Comment'
FROM Comments
JOIN Posts
ON Comments.PostId=Posts.ID
GROUP BY Posts.ID

------QUERY 2--------
CREATE VIEW INFOSocialNetwork
AS
SELECT Peoples.Name,Peoples.Surname,Peoples.Age,Users.Login,Users.Mail,Users.Password,Comments.PostId,Comments.LikeNumber as 'LikeNumberComment',Comments.IsDeleted as'CommentDelet',Posts.Content,Posts.LikeNumber as 'LikeNumberPost',Posts.WhenShared,Posts.IsDeleted as 'PostDelet'
FROM Comments
JOIN Peoples
ON Comments.UserId=Peoples.ID
JOIN Users
ON Comments.UserId=Users.ID
JOIN Posts
ON Comments.PostId=Posts.ID

------QUERY 3---------

-------DeletePosts---------
CREATE TRIGGER DeletePOSTS
ON Posts
INSTEAD OF DELETE
AS
 DECLARE @ID INT
 SELECT @ID=ID FROM DELETED
 UPDATE Posts SET IsDeleted=1 WHERE ID=@ID

 DELETE Posts WHERE ID=2

 -------DeleteComments---------
 CREATE TRIGGER DeleteComments
ON Comments
INSTEAD OF DELETE
AS
 DECLARE @ID INT
 SELECT @ID=ID FROM DELETED
 UPDATE Comments SET IsDeleted=1 WHERE ID=@ID

 DELETE Comments WHERE ID=1
