-- Drop Table Statments

drop table if exists challenges;
drop table if exists eventapplication;
drop table if exists gamepurchase;
drop table if exists review;
drop table if exists users;
drop table if exists events;
drop table if exists fanbase;
drop table if exists rpg_game;
drop table if exists racing_game;
drop table if exists games;
drop table if exists developers;
drop table if exists sales;

-- Create Table Functions

create table Sales (
SaleID int (12) PRIMARY KEY AUTO_INCREMENT UNIQUE,
SaleName varchar (50) NOT NULL UNIQUE,
SeasonalSale varchar (5) NOT NULL,
Duration int (10) NOT NULL,
SalePercentage varchar (25) NOT NULL
);

create table Developers (
DeveloperID int (12) PRIMARY KEY AUTO_INCREMENT UNIQUE,
CompanyName varchar (50) NOT NULL,
Products varchar (500) NOT NULL,
Location varchar (100) NOT NULL,

sales_num int (6),
foreign key Sales_D(sales_num) references Sales(SaleID)
on update cascade
on delete set null
);

create table Games (
GameID int (12) PRIMARY KEY AUTO_INCREMENT UNIQUE,
GameName varchar(50) NOT NULL UNIQUE,
GamePrice decimal (5,2) NOT NULL,
RecommendedAge int (3) NOT NULL,
Duration int (10) NOT NULL,
Genres varchar (50) NOT NULL,

dev_num int (6),
sales_num int (6),
foreign key Developers_G(dev_num) references Developers(DeveloperID)
on update cascade
on delete set null,
foreign key Sales_G(sales_num) references Sales(SaleID)
on update cascade
on delete set null
);

create table Racing_Game (
GameID int (12) PRIMARY KEY AUTO_INCREMENT UNIQUE,
GameName varchar(50) NOT NULL UNIQUE,
GamePrice decimal (5,2) NOT NULL,
RecommendedAge int (3) NOT NULL,
Duration int (10) NOT NULL,
Genres varchar (50) NOT NULL,

RacingGameID int (12) NOT NULL,
NumOfCars int (12) NOT NULL,
NumOfTracks int (12) NOT NULL,

dev_num int (6),
sales_num int (6),
foreign key RacingGameFK(RacingGameID) references Racing_Game(GameID)
on update cascade,
foreign key Developers_G(dev_num) references Developers(DeveloperID)
on update cascade
on delete set null,
foreign key Sales_G(sales_num) references Sales(SaleID)
on update cascade
on delete set null
);

create table RPG_Game (
GameID int (12) PRIMARY KEY AUTO_INCREMENT UNIQUE,
GameName varchar(50) NOT NULL UNIQUE,
GamePrice decimal (5,2) NOT NULL,
RecommendedAge int (3) NOT NULL,
Duration int (10) NOT NULL,
Genres varchar (50) NOT NULL,

RPGGameID int (12) NOT NULL UNIQUE,
Subgenre varchar (50) NOT NULL,
Setting varchar (50) NOT NULL,

dev_num int (6),
sales_num int (6),
foreign key RPGGameFK(RPGGameID) references RPG_Game(GameID)
on update cascade,
foreign key Developers_G(dev_num) references Developers(DeveloperID)
on update cascade
on delete set null,
foreign key Sales_G(sales_num) references Sales(SaleID)
on update cascade
on delete set null
);

create table Fanbase (
FanbaseID int (12) PRIMARY KEY AUTO_INCREMENT UNIQUE,
FanbaseCount int (20) NOT NULL,

dev_num int (6),
foreign key Developer_F(dev_num) references Developers(DeveloperID)
on update cascade
on delete set null
);

Create table Events (
EventID int (12) PRIMARY KEY AUTO_INCREMENT UNIQUE,
EventName varchar (50) NOT NULL UNIQUE,
EventDuration int (10) NOT NULL,
EventTheme varchar (50) NOT NULL,
Prizes varchar (500) NOT NULL
);

create table Users (
AccountID int (12) PRIMARY KEY AUTO_INCREMENT UNIQUE,
Username varchar (20) NOT NULL UNIQUE,
FullName varchar (50) NOT NULL,
DOB date NOT NULL,
OwnedGames varchar (500) NOT NULL,
ItemsOwned varchar (500) NOT NULL,
Playtime int (10),

fanbase_num int (6),
foreign key Fanbase_U(fanbase_num) references Fanbase(FanbaseID)
on update cascade
on delete set null
);

create table Review (
ReviewID int (12) PRIMARY KEY AUTO_INCREMENT UNIQUE,
ReviewContents varchar (1000) NOT NULL,
Rating varchar (10) NOT NULL,

user_num int (6),
game_num int(6),
foreign key User_R(user_num) references UserS(AccountID)
on update cascade
on delete set null,
foreign key Games_R(game_num) references Games(GameID)
on update cascade
on delete set null
);

create table GamePurchase (
PurchaseID int (12) PRIMARY KEY AUTO_INCREMENT UNIQUE,
PurchaseDate date NOT NULL,
UserMoney decimal(10,2) NOT NULL,

user_num int (6),
sale_num int (6),
game_num int (6),
foreign key Users_GP(user_num) references Users(AccountID)
on update cascade
on delete set null,
foreign key Sales_GP(sale_num) references Sales(SaleID)
on update cascade
on delete set null,
foreign key Games_GP(game_num) references Games(GameID)
on update cascade
on delete set null
);

create table EventApplication (
ApplicationID int (12) PRIMARY KEY AUTO_INCREMENT UNIQUE,
Details varchar (250) NOT NULL,

event_num int (6),
user_num int (6),
dev_num int (6),
foreign key Event_A(event_num) references Events(EventID)
on update cascade
on delete set null,
foreign key User_A(user_num) references Users(AccountID)
on update cascade
on delete set null,
foreign key Developer_A(dev_num) references Developers(DeveloperID)
on update cascade
on delete set null
);

create table Challenges (
ChallengeID int (12) PRIMARY KEY AUTO_INCREMENT UNIQUE,
Type varchar (50) NOT NULL,
Difficulty varchar (10) NOT NULL,
TimeToComplete varchar (15) NOT NULL,

event_num int (6) NOT NULL	,
foreign key Event_C(event_num) references Events(EventID)
);

-- Insert Into Functions

insert into Sales (
SaleID, SaleName, SeasonalSale, Duration, SalePercentage)
Values 
(Default, 'Black Friday Sale', 'Yes', 10, '20% off'),
(Default, 'Halloween Sale', 'Yes', 7, '5% off'),
(Default, 'Capcom Sale', 'No', 3, '30% off');

insert into Developers (
DeveloperID, CompanyName, Products, Location, sales_num)
Values 
(Default, 'Crytek', 'Crysis 1, Crysis 2, Crysis 3, Hunt Showdown', 'Germany', 1),
(Default, 'Coffee Stain Studio', 'Satisfactory', 'Sweden', 2),
(Default, 'Valve', 'CSGO, Team Fortress 2, Portal 1, Portal 2', 'America', 3);

insert into Games (
GameID, GameName, GamePrice, RecommendedAge, Duration, Genres, dev_num, sales_num)
Values 
(Default, 'Far Cry 4', '29.99', '18', '30', 'FPS, Stealth, Open-World', 1, 1),
(Default, 'COD Modern Warfare', '69.99', '18', '100', 'FPS, Multiplayer', 2, 2),
(Default, 'Hollow Knight', '9.99', '12', '20', 'Open-World, Metroidvenia, Souls-Like', 3, 3);

insert into Racing_Game (
GameID, GameName, GamePrice, RecommendedAge, Duration, Genres, RacingGameID, NumOfCars, NumOfTracks, dev_num, sales_num)
Values
(Default, 'Formula 1', 15.99, '12', '50', 'Racing, Sport', 1, 25, 12, 2, 2);

insert into RPG_Game (
GameID, GameName, GamePrice, RecommendedAge, Duration, Genres, RPGGameID, Subgenre, Setting, dev_num, sales_num)
Values
(Default, 'Elden Ring', 59.99, '18', '200', 'RPG', 1, 'Fantasy, Souls-Like, Co-op', 'Post-Apocalypse', 3, 1);

insert into Fanbase (
FanbaseID, FanbaseCount, dev_num)
Values 
(Default, 13590, 1),
(Default, 596812, 1),
(Default, 102544, 2),
(Default, 1319416, 2),
(Default, 405, 3),
(Default, 98, 3);

insert into Events (
EventID, EventName, EventDuration, EventTheme, Prizes)
Values 
(Default, 'World Cup Event', '60', 'Sport', '1st - World Cup Tickets, 2nd - 500 Euro, 3rd - Game of Choice'),
(Default, 'Terraria Event', '10', 'Pixel Game', 'In-game Items'),
(Default, 'Discovery Event', '15', 'Niche Games', 'Keep Game of Choice');

insert into Users (
AccountID, FullName, Username, DOB, OwnedGames, ItemsOwned, Playtime, fanbase_num)
Values 
(Default, 'John Joe', 'XxSniperGodxX', '2001-03-25', 'Fallout 4, GTA5, CSGO, Fortnite', 'Fortnite Battlepass', 250, 1),
(Default, 'Bobby Bill', 'THE360GOD', '1984-09-1', 'Animal Crossing, Fifa 2022, Forza Horizen', 'Mercedes Skin - Forza Horizen', 172, 1),
(Default, 'Mike Murphy', 'anon214359056', '2008-09-1', 'Mario Cart, Sonic, Doom, COD Modern Warfare', 'DLC 1 - Doom', 539, 2),
(Default, 'Jamie Johnson', 'GlizzyGulper39', '2011-5-14', 'Fortnite, Fifa 2022, Minecraft, Hollowknight', ' ',5423, 3),
(Default, 'Jill Jane', 'howdoInamemyself?', '2014-7-28', 'Satisfactory, Space Engineers, Stardew Valley, Stickfight', 'Profile Banner - Red',912, 3);

insert into Review (
ReviewID, ReviewContents, Rating, user_num, game_num)
Values 
(Default, 'Good Game but needs some more polish and weapon balancing', '7/10', 1, 1),
(Default, 'Unfair for new players', '3/10', 3, 1),
(Default, 'Game doesnt run well on my pc, crashes alot and corrupts my save data', '1/10', 2, 3);

insert into GamePurchase (
PurchaseID, PurchaseDate, UserMoney, user_num, sale_num, game_num)
Values 
(Default, '2021-11-18', '135.09', 1, 1, 1),
(Default, '2017-2-26', '0.13', 2, 2, 2),
(Default, '2006-5-6', '1836.59', 3, 3, 3);

insert into EventApplication (
ApplicationID, Details, event_num, user_num, dev_num)
Values 
(Default, 'Most Sane Rust Player, 2001-3-18, ......', 1, 1, 1),
(Default, 'ThisIs1984, 1984-12-29, ......', 2, 2, 2),
(Default, 'IPlayLOL, 1998-7-27, ......', 3, 3, 3);

insert into Challenges (
ChallengeID, Type, Difficulty, TimeToComplete, event_num)
Values 
(Default, 'Aim Test', '5/5', '12 Hours', 1),
(Default, 'Time Trial', '3/5', '3 Hours', 2),
(Default, 'Survival', '2/5', '1 Hours', 3);

-- Select Functions

Select *
From Users
Where OwnedGames Like '%Doom%';

Select 
AccountID As "Deal Booth User Number", 
Username As "Gamer Tag",
OwnedGames As "Owned Games",
Playtime As "Total Playtime"
From Users
Where (DOB > '2010-1-1') AND (OwnedGames NOT Like '%Fortnite%')
Order By playtime;

Select 
CompanyName As 'Company Name',
Products As 'Created Games',
Location As 'Head Office Location'
From Developers
Where (Location = 'Germany') And (CompanyName Like 'C%');

Select *
From Developers
Where Location != 'Germany';

Select 
GameName As 'Game Title',
GamePrice As 'Price',
RecommendedAge As 'Age to Play',
Genres
From Games
Where (GamePrice > 15) And (RecommendedAge = 18) And (Genres like '%FPS%')
Order By Duration DESC;

Select 
GameName As 'Game Name',
RecommendedAge As 'Age Rating',
Duration
From Games
Order By GamePrice;

Select 
SaleName As 'Sale Name',
SeasonalSale As 'Seasonal Sale',
Duration As 'Sale Duration (In Days)'
From Sales
Where SeasonalSale Like '%Yes%';

Select
FanbaseID As 'Fanbase Number',
FanbaseCount As 'Number Of Followers'
From Fanbase
Order By FanbaseCount;

Select 
Sum(FanbaseCount) As 'Total Fans'
From Fanbase;

Select 
EventName As 'Event Name',
EventTheme As 'Theme',
Prizes As 'Participation Rewards'
From Events
Order by EventID DESC;

Select
ReviewContents As 'Review',
Rating
From Review;

Select 
U.Username As 'Gamertag',
G.GameName As 'Game Name',
GP.PurchaseDate As 'Date Purchases',
GP.UserMoney As 'User Funds Before Transaction'
From GamePurchase GP
Inner Join Games G on GP.PurchaseID = G.GameID
Inner Join Users U on GP.PurchaseID = U.AccountID
Where PurchaseDate >= '2010-1-1';
