-- Create a new database called 'PracQuery'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'PracQuery'
)
CREATE DATABASE PracQuery
GO

USE PracQuery
IF OBJECT_ID('Enrolment', 'U') IS NOT NULL
DROP TABLE Enrolment
GO
IF OBJECT_ID('Student', 'U') IS NOT NULL
DROP TABLE Student
GO
IF OBJECT_ID('SubjectOffering', 'U') IS NOT NULL
DROP TABLE SubjectOffering
GO
IF OBJECT_ID('Subject', 'U') IS NOT NULL
DROP TABLE Subject
GO

IF OBJECT_ID('Teacher', 'U') IS NOT NULL
DROP TABLE Teacher
GO





CREATE TABLE Subject
(
    SubjCode [NVARCHAR] (100) PRIMARY KEY,
    Description [NVARCHAR] (500),
);


CREATE TABLE Student
(
    StudentId [NVARCHAR] (10) PRIMARY KEY,
    Surname [NVARCHAR] (100) NOT NULL,
    GivenName [NVARCHAR] (100) NOT NULL,
    Gender [NVARCHAR] (1) NULL,
    CONSTRAINT check_gender CHECK (Gender IN ('M','F','I'))
);

CREATE TABLE Teacher
(
    StaffID INT PRIMARY KEY,
    Surname [NVARCHAR] (100) NOT NULL,
    GivenName [NVARCHAR] (100) NOT NULL,
    CONSTRAINT check_StaffID CHECK (LEN(StaffID) = 8),

);

CREATE TABLE SubjectOffering
(
    SubjCode [NVARCHAR] (100)
    FOREIGN KEY (SubjCode) REFERENCES Subject,
    Year INT,
    Semester INT,
    Fee Money NOT NULL,
    StaffID INT,
    FOREIGN KEY (StaffID) REFERENCES Teacher,
    PRIMARY KEY(SubjCode, Year, Semester),
    CONSTRAINT check_year CHECK (LEN(Year) = 4),
    CONSTRAINT check_Semester CHECK (Semester IN('1','2')),
    CONSTRAINT check_Fee CHECK (Fee > 0)
);

CREATE TABLE Enrolment
(
    StudentId [NVARCHAR] (10)
    FOREIGN KEY (StudentId) REFERENCES Student,
    SubjCode [NVARCHAR] (100),
    Year INT,
    Semester INT,
    Grade [NVARCHAR] (2) NULL,
    DateEnrolled DATE,
    PRIMARY KEY(StudentId, SubjCode, Year, Semester),
     CONSTRAINT FK_SubjCode FOREIGN KEY (SubjCode, Year, Semester)
        REFERENCES SubjectOffering(SubjCode, Year, Semester),
    CONSTRAINT check_Grade CHECK (Grade IN('N','P','C','D','HD'))
);

    Insert INTO Subject (SubjCode, [Description])
    VALUES('ICTWEB425',	'Apply SQL to extract & manipulate data'),
        ('ICTDBS403',	'Create Basic Databases'),
        ('ICTDBS502',	'Design a Database')
    
    Insert INTO Student (StudentId, Surname, GivenName, Gender)
    VALUES('s12233445',	'Morrison',	'Scott',	'M'),
        ('s23344556',	'Gillard',	'Julia',	'F'),
        ('s34455667',	'Whitlam',	'Gough',	'M')

    Insert INTO Teacher (StaffID, Surname, GivenName)
    VALUES
    ('98776655',	'Starr',	'Ringo'),
    ('87665544',	'Lennon',	'John'),
    ('76554433',	'McCartney',	'Paul')
    
    INSERT INTO SubjectOffering (SubjCode, [Year], Semester, Fee, StaffID)
    VALUES
    ('ICTWEB425',	2020,	'1',	'200',	'98776655'),
    ('ICTWEB425',	2021,	'1',	'225',	'98776655'),
    ('ICTDBS403',	2021,	'1',	'200',	'87665544'),
    ('ICTDBS403',	2021,	'2',	'200',	'76554433'),
    ('ICTDBS502',	2020,	'2',	'225',	'87665544')

    Insert INTO Enrolment(StudentId, SubjCode, [Year], Semester, Grade, DateEnrolled)
    VALUES
 ('s12233445',  'ICTWEB425',	2020,	'1',    'D',	'2020/02/20'),
 ('s23344556',	'ICTWEB425',	2020,	'1',	'P',	'2020/02/15'),
 ('s12233445',	'ICTWEB425',	2021,	'1',	'C',	'2020/01/30'),
 ('s23344556',	'ICTWEB425',	2021,	'1',	'HD',	'2020/02/26'),
 ('s34455667',	'ICTWEB425',	2020,	'1',	'P',	'2020/01/28'),
 ('s12233445',	'ICTDBS403',	2021,	'1',	'C',	'2020/02/08'),
 ('s23344556',	'ICTDBS403',	2021,	'1',	NULL,	    '2021/02/28'),
 ('s34455667',	'ICTDBS403',	2021,	'2',	NULL,	    '2021/03/03'),
 ('s23344556',	'ICTDBS502',	2020,	'2',	'P',	'2021/07/01'),
 ('s34455667',	'ICTDBS502',	2020,	'2',	'N',	'2020/07/13')
    
select * FROM Subject
select * FROM Student
select * FROM SubjectOffering
select * FROM Enrolment
select * FROM Teacher

--task 4
--query one


--query 2
Select SubjectOffering.[Year], SubjectOffering.Semester,  count(*) "Enrolments"
from SubjectOffering
Group by SubjectOffering.[Year], SubjectOffering.Semester

--query 3
select *
from SubjectOffering
where Fee >(select AVG(Fee) from SubjectOffering);




GO

