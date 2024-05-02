--CREATE DATABASE Mp3Music
--USE Mp3Music

CREATE TABLE Users(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR (15) NOT NULL,
Surname NVARCHAR(25) DEFAULT 'XXX',
Username NVARCHAR(50) NOT NULL UNIQUE,
Password NVARCHAR(10)NOT NULL,
Gender NVARCHAR(10) NOT NULL
)

INSERT INTO Users
VALUES 
    ('Anar', 'Amanli', 'anaramanli', 'anar201', 'Male'),
    ('Sahibe', 'Memmedova', 'sahibe_memmedova :)', 'sahibe1212', 'Female')

CREATE TABLE Artists(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR (20) NOT NULL,
Surname NVARCHAR(20)NOT NULL,
Birthday DATETIME NOT NULL,
Gender NVARCHAR(10) NOT NULL
)

INSERT INTO Artists
VALUES 
    ('Weekend', 'The', '1990-07-12', 'Male'),
    ('Madisson', 'Beer', '1997-12-23', 'Female')

CREATE TABLE Categories(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR (30) NOT NULL
)

INSERT INTO Categories 
VALUES 
('Jazz'),
('Rock'),
('Pop')


CREATE TABLE Music(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR (50) NOT NULL,
Duration TIME,
FOREIGN KEY (Id) REFERENCES Categories(Id),
FOREIGN KEY (Id) REFERENCES Artists(Id)
)

INSERT INTO Music
VALUES 
('One of the girls', '00:04:31', 1,1),
('Single Ladies', '00:03:49', 1,2)

CREATE TABLE Playlists (
    Id INT IDENTITY PRIMARY KEY,
    UserID INT,
    Name NVARCHAR(100),
    FOREIGN KEY (Id) REFERENCES Users(Id)
);

INSERT INTO Playlists
VALUES 
('My Playlist'),
('Liked'),
('Favorites')

CREATE TABLE PlaylistMusics (
    PlaylistId INT,
    MusicId INT,
    PRIMARY KEY (PlaylistId, MusicId),
    FOREIGN KEY (PlaylistId) REFERENCES Playlists(Id),
    FOREIGN KEY (MusicId) REFERENCES Music(Id)
);

INSERT INTO PlaylistMusics 
VALUES 
(1,1),
(2,2),
(1,3)

CREATE VIEW MusicFull 
AS 
SELECT m.Name AS MusicName, m.Duration, c.Name AS Category, a.Name AS Artist
FROM Music as m
INNER JOIN Categories as c 
ON m.Id = c.Id
INNER JOIN Artists as a 
ON m.Id = a.Id;

SELECT p.Name AS PlaylistName, m.Name AS MusicName
FROM Playlists as p
INNER JOIN PlaylistMusics pm ON p.Id = pm.Id 
INNER JOIN Music m ON pm.MusicID = m.Id
WHERE p.UserId = UserId;

SELECT a.Name AS Artist, COUNT(*) AS SongCount
FROM Music m
INNER JOIN Artists a ON m.Id = a.Id
GROUP BY a.Id, a.Name
HAVING COUNT(*) = (
    SELECT MAX(SongCount)
    FROM (
        SELECT COUNT(*) AS SongCount
        FROM Music
        GROUP BY a.Id
    ) AS MaxSongCount
);



 

	