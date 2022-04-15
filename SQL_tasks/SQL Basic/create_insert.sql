
 CREATE TABLE Music

USE Music
GO

CREATE TABLE dbo.Singers(
	id int IDENTITY(1,1) PRIMARY KEY,
	first_name  varchar(55) NOT NULL,
	last_name varchar(55) NOT NULL,
	pseudonym varchar(55),
	country char(50) NOT NULL,
	sex char(10) NOT NULL,
	birthday date NOT NULL
);

CREATE TABLE dbo.Genres(
	name varchar(55) PRIMARY KEY NOT NULL,
	description varchar(max)
);

CREATE TABLE dbo.Songs(
	id int IDENTITY(1,1) PRIMARY KEY,
	title varchar(55) NOT NULL,
	singers_id int FOREIGN KEY REFERENCES Singers(id),
	genres_id varchar(55) FOREIGN KEY REFERENCES Genres(name),
	albums_id int FOREIGN KEY REFERENCES Albums(id)

);


CREATE TABLE dbo.Albums(
	id int IDENTITY(1,1) PRIMARY KEY,
	title varchar(55) NOT NULL,
	release date NOT NULL,

);



---- Standard syntax  
INSERT dbo.Genres(name, description)
 VALUES ('rapping', 'is a musical form of vocal delivery that incorporates "rhyme, rhythmic speech, and street vernacular", which is performed or chanted in a variety of ways, usually over a backing beat or musical accompaniment.')  

INSERT dbo.Genres(name, description)
	VALUES ('���', '�������� ���������, �������� �������� �� ������ � ������ ����')  

INSERT dbo.Genres(name, description)
	VALUES ('���', '����������� ���� � ������� ���-����, �� ����������� ����������, �� ������������� (����� � � ������� ��������)')

INSERT dbo.Genres(name, description)
	VALUES ('����', '������������ ������ � �����������, ��������, ��������� �� ������������ ������, � ��������� �������� ������� ��������� ������� ������� � ����')


INSERT dbo.Singers(first_name, last_name, pseudonym, country, sex, birthday)
VALUES('�''�������', '������', '����� ����', '����', '������', '1990-05-09')

INSERT dbo.Singers(first_name, last_name, pseudonym, country, sex, birthday)
VALUES('�����', '�������', 'Oxxxymiron', '����', '������', '1985-01-31')

INSERT dbo.Singers(first_name, last_name, pseudonym, country, sex, birthday)
VALUES('�����', '��뺺�', 'Morgenshtern', '����', '������', '1998-02-17')

INSERT dbo.Singers(first_name, last_name, pseudonym, country, sex, birthday)
VALUES('����� ������', '������� III', '50 Cent', '���', '������', '1975-06-06') 

INSERT dbo.Singers(first_name, last_name, country, sex, birthday)
VALUES('���������', '��������', '������', '������', '1975-05-14')


INSERT dbo.Songs(title, singers_id, genres_id, albums_id)
VALUES('����, �� ��', 14, '����', 4 )

INSERT dbo.Songs(title, singers_id, genres_id, albums_id)
VALUES('Grime Vietnam', 10, '���',1 )

INSERT dbo.Songs(title, singers_id, genres_id, albums_id)
VALUES('������� ����', 10, '���', 1 )

INSERT dbo.Songs(title, singers_id, genres_id, albums_id)
VALUES('���� � ����', 11, '���', 5)

INSERT dbo.Songs(title, singers_id, genres_id, albums_id)
VALUES('���� ', 11, '���', 5)

INSERT dbo.Songs(title, singers_id, genres_id, albums_id)
VALUES('�����', 12, '���', 2)

INSERT dbo.Songs(title, singers_id, genres_id, albums_id)
VALUES('insomnia ', 12, '���',2 )

INSERT dbo.Songs(title, singers_id, genres_id, albums_id)
VALUES('P.I.M.P', 13, '���' , 3)

INSERT dbo.Songs(title, singers_id, genres_id, albums_id)
VALUES('In da club ', 13, '���' , 3)



INSERT dbo.Albums(title,  release )
VALUES('get rich or die tryin', '2003-02-06')

INSERT dbo.Albums(title, release)
VALUES('�����', '2008-12-04')

INSERT dbo.Albums(title, release )
VALUES('ANTIHYPETRAIN', '2021-07-09')

INSERT dbo.Albums(title, release )
VALUES('miXXXtape I', '2012-03-12')

INSERT dbo.Albums(title, release)
VALUES('Hate Me','2018-02-17')




