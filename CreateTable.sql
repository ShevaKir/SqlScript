USE master
GO

ALTER DATABASE Football SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

DROP DATABASE Football
GO

CREATE DATABASE Football
GO

USE Football
GO

CREATE TABLE Teams
(
	IdTeam		INT						NOT NULL IDENTITY(1,1),
	NameTeam	VARCHAR(30)				NOT NULL,
	Stadion		VARCHAR(20)				NOT NULL,
	IdLocation  INT						NOT NULL
)
GO

CREATE TABLE Tournaments
(
	IdTournament		INT						NOT NULL IDENTITY(1,1),
	Tournament			VARCHAR(20)				NOT NULL
)
GO

CREATE TABLE TournamentTeams
(
	IdTournamentTeam	INT		NOT NULL IDENTITY(1,1),
	IdTeam				INT		NOT NULL,
	IdTournament		INT		NOT NULL
)
GO

CREATE TABLE Country
(
	IdCountry		INT				NOT NULL IDENTITY(1,1),
	Country			VARCHAR(15)		NOT NULL
)
GO

CREATE TABLE Cities
(
	IdCity			INT				NOT NULL IDENTITY(1,1),
	City			VARCHAR(15)		NOT NULL
)
GO

CREATE TABLE Locations
(
	IdLocation		INT				NOT NULL IDENTITY(1,1),
	IdCountry		INT				NOT NULL,
	IdCity			INT				NOT NULL
)
GO

CREATE TABLE Matches
(
	IdTournament	INT				NOT NULL,
	DataMatch		DATETIME		NOT NULL,
	IdTeam1			INT				NOT NULL,
	IdTeam2			INT				NOT NULL,
	GoalsTeam1		TINYINT			NOT NULL,
	GoalsTeam2		TINYINT			NOT NULL	
)
GO

CREATE TABLE Scores
(
	IdTournamentTeam	INT			NOT NULL,
	Points				INT
)
GO

ALTER TABLE Teams
	ADD CONSTRAINT PK_Teams_IdTeam 
		PRIMARY KEY CLUSTERED(IdTeam)
GO

ALTER TABLE Tournaments
	ADD CONSTRAINT PK_Tournaments_IdTournament 
		PRIMARY KEY CLUSTERED(IdTournament)
GO

ALTER TABLE Country
	ADD CONSTRAINT PK_Country_IdCountry 
		PRIMARY KEY CLUSTERED(IdCountry)
GO

ALTER TABLE Cities
	ADD CONSTRAINT PK_Cities_IdCity 
		PRIMARY KEY CLUSTERED(IdCity)
GO

ALTER TABLE Locations
	ADD CONSTRAINT PK_Locations_IdLocation 
		PRIMARY KEY CLUSTERED(IdLocation)
GO

ALTER TABLE TournamentTeams
	ADD CONSTRAINT PK_Locations_IdTournamentTeam 
		PRIMARY KEY CLUSTERED(IdTournamentTeam)
GO

ALTER TABLE TournamentTeams
	WITH CHECK ADD CONSTRAINT FK_TournamentTeams_Teams	
		FOREIGN KEY(IdTeam) REFERENCES Teams(IdTeam)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
GO

ALTER TABLE TournamentTeams
	WITH CHECK ADD CONSTRAINT FK_TournamentTeams_Tournaments	
		FOREIGN KEY(IdTournament) REFERENCES Tournaments(IdTournament)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
GO

ALTER TABLE Locations
	WITH CHECK ADD CONSTRAINT FK_Locations_Country	
		FOREIGN KEY(IdCountry) REFERENCES Country(IdCountry)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
GO

ALTER TABLE Locations
	WITH CHECK ADD CONSTRAINT FK_Locations_Cities	
		FOREIGN KEY(IdCity) REFERENCES Cities(IdCity)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
GO

ALTER TABLE Matches
	WITH CHECK ADD CONSTRAINT FK_Matches_Tournaments	
		FOREIGN KEY(IdTournament) REFERENCES Tournaments(IdTournament)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
GO

ALTER TABLE Scores
	WITH CHECK ADD CONSTRAINT FK_Scores_TournamentTeams	
		FOREIGN KEY(IdTournamentTeam) REFERENCES TournamentTeams(IdTournamentTeam)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
GO


INSERT INTO Teams(NameTeam, Stadion, IdLocation)
	VALUES('Chelsea',			'Stamford Bridge',		1),
		  ('Manchester United',	'Old Trafford',			2),
		  ('Manchester City',	'Etihad stadium',		2),
		  ('Arsenal',			'Emirates Stadium',		1),
		  ('Real Madrid',		'Santiago Bernabéu',	4),
		  ('Barcelona',			'Camp Nou',				3),
		  ('Bayern',			'Allianz Arena',		5),
		  ('Borussia',			'Signal Iduna Park',	6)
GO

INSERT INTO Tournaments(Tournament)
	VALUES('Champions League'),
		  ('Europa League'),
		  ('FA Cup'),
		  ('Copa del ray'),
		  ('DFB Pokal'),
		  ('Premier League'),
		  ('La Liga'),
		  ('Bundesliga')
GO

INSERT INTO TournamentTeams(IdTeam, IdTournament)
	VALUES(1, 1),
		  (1, 3),
		  (1, 6),
		  (2, 1),
		  (2, 3),
		  (2, 6),
		  (3, 1),
		  (3, 3),
		  (3, 6),
		  (4, 1),
		  (4, 3),
		  (4, 6),
		  (4, 2),
		  (5, 1),
		  (5, 4),
		  (5, 7),
		  (6, 1),
		  (6, 4),
		  (6, 7),
		  (7, 1),
		  (7, 5),
		  (7, 8),
		  (8, 1),
		  (8, 5),
		  (8, 8),
		  (8, 2)
GO

INSERT INTO Country(Country)
	VALUES('England'),
		  ('Spain'),
		  ('Germany')
GO

INSERT INTO Cities(City)
	VALUES('London'),
		  ('Manchester'),
		  ('Barcelona'),
		  ('Madrid'),
		  ('Bayern'),
		  ('Dortmund')
GO

INSERT INTO Locations(IdCountry, IdCity)
	VALUES(1, 1),
		  (1, 2),
		  (2, 3),
		  (2, 4),
		  (3, 5),
		  (3, 6)
GO

CREATE TABLE Players
(
	IdPlayer		INT	IDENTITY(1,1)		NOT NULL, 
	NamePlayer		VARCHAR(20)				NOT NULL,
	SurnamePlayer	VARCHAR(20)				NOT NULL,
	DateOfBirth		DATE				 	NOT NULL,
	IdCountry		INT						NOT NULL,
	IdTeam			INT						NOT NULL,
	PlayerNumber	TINYINT					NOT NULL
)
GO

ALTER TABLE Players
	ADD CONSTRAINT PK_Players_IdPlayer
		PRIMARY KEY CLUSTERED(IdPlayer)
GO

ALTER TABLE Players
	WITH CHECK ADD CONSTRAINT FK_Players_Teams	
		FOREIGN KEY(IdTeam) REFERENCES Teams(IdTeam)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
GO

ALTER TABLE Players
	WITH CHECK ADD CONSTRAINT FK_Players_Country	
		FOREIGN KEY(IdCountry) REFERENCES Country(IdCountry)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
GO

ALTER TABLE Teams
	WITH CHECK ADD CONSTRAINT FK_Teams_Locations	
		FOREIGN KEY(IdLocation) REFERENCES Locations(IdLocation)
			ON UPDATE NO ACTION
			ON DELETE NO ACTION
GO

INSERT INTO Players(NamePlayer, SurnamePlayer, DateOfBirth, IdCountry, IdTeam, PlayerNumber)
	VALUES('Cristiano', 'Ronaldo',	'1987-1-13',		1, 2, 7),
		  ('Lionel',	'Messi',	'1990-2-1',			3, 2, 10),
		  ('Sergio',	'Ramos',	'1986-2-23',		1, 3, 4),
		  ('Kilian',	'Mbape',	'2000-1-13',		1, 3, 7),
		  ('Jonh',		'Terry',	'1985-11-1',		1, 1, 3),
		  ('Luis',		'Suarez',	'1986-2-23',		3, 1, 7)
GO

INSERT INTO Matches(IdTournament, DataMatch, IdTeam1, IdTeam2, GoalsTeam1, GoalsTeam2)
	VALUES(1, '2021-12-1 19:00:00', 1, 2, 3, 2),
		  (1, '2021-12-2 19:00:00', 3, 4, 1, 0),
		  (1, '2021-12-3 19:00:00', 5, 6, 3, 2),
		  (1, '2021-12-3 19:00:00', 7, 8, 1, 3),
		  (6, '2021-12-4 17:00:00', 1, 2, 1, 1),
		  (6, '2021-12-4 21:00:00', 3, 4, 2, 1),
		  (6, '2021-12-4 22:00:00', 2, 1, 0, 4),
		  (6, '2021-12-8 21:00:00', 4, 3, 3, 3),
		  (6, '2021-12-9 21:00:00', 1, 3, 3, 3),
		  (6, '2021-12-9 21:00:00', 1, 4, 4, 3),
		  (6, '2021-12-11 21:00:00', 1, 3, 3, 5),
		  (6, '2021-12-12 21:00:00', 1, 2, 3, 0)
GO

ALTER TABLE Matches
	WITH CHECK ADD CONSTRAINT FK_Matches_Teams_IdTeam1	
		FOREIGN KEY(IdTeam1) REFERENCES Teams(IdTeam)
			ON UPDATE NO ACTION
			ON DELETE NO ACTION
GO

ALTER TABLE Matches
	WITH CHECK ADD CONSTRAINT FK_Matches_Teams_IdTeam2	
		FOREIGN KEY(IdTeam2) REFERENCES Teams(IdTeam)
			ON UPDATE NO ACTION
			ON DELETE NO ACTION
GO