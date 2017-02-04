

C1

CREATE OR REPLACE TRIGGER ProfDepartement
  BEFORE DELETE OR INSERT  
  ON Professeur
  FOR EACH ROW
  DECLARE 
	nombreProfDepartement INTEGER;
  BEGIN 
	SELECT COUNT(*) INTO nombreProfDepartement
	FROM Professeur
	WHERE codedept =:NEW.codedept;
	if nombreProfDepartement >= 40 Or nombreProfDepartement <= 1
	then
	RAISE_APPLICATION_ERROR (-20000,'Erreur: Trop ou pas assez de prof dans le   departement');
	end if;
  END;
/


C2

Alter table groupecours
add constraint unq_sess_cour_prof
UNIQUE (codeprof,codesess,codecours);
/


C3

create or replace trigger trigg_MAJ
before insert
on professeur
for each row
begin
:new.nomprof := upper (:new.nomprof);
end;
/



C4

Alter Table groupeCours
add nbInscriptions Integer
add check (nbInscription > -1)
/

C5


Notes:
Il suffit de recreer les tables de la base de données, pour
qu'elle implemente un delete cascade sur les professeurs concernés.


SET ECHO ON
SET SERVEROUTPUT ON


DROP TABLE GroupeCours;
DROP TABLE Professeur;
DROP TABLE Cours;
DROP TABLE SessionCours;
DROP TABLE Departement;

CREATE TABLE Departement
(Coddept varchar(10) NOT NULL PRIMARY KEY,
Nomdept varchar(20) NOT NULL
);

CREATE TABLE Professeur
(Codeprof varchar(10) NOT NULL PRIMARY KEY,
 nomprof varchar(30) NOT NULL,
 Prenomprof varchar(30) NOT NULL,
 codedept varchar(10) NOT NULL,
 CONSTRAINT profdep FOREIGN KEY (Codedept) REFERENCES Departement (Coddept) on delete cascade
);

CREATE TABLE Cours
(Codecours varchar(10) NOT NULL PRIMARY KEY,
Libelle varchar (60) NOT NULL,
Codedept varchar(10) NOT NULL,
FOREIGN KEY 	(Codedept) REFERENCES Departement (Coddept) on delete cascade
);

CREATE TABLE SessionCours
(Codesess varchar(5) NOT NULL PRIMARY KEY,
DateDebut date,
Datefin date,
Libelle varchar(100)
);
 
CREATE TABLE GroupeCours
(Codecours varchar(10) NOT NULL,
Codegrp INTEGER NOT NULL,
Codesess varchar(5) NOT NULL,
Codeprof varchar(10) NOT NULL,
Libelle varchar(200) NOT NULL,
PRIMARY KEY (Codecours, Codegrp, Codesess),
FOREIGN KEY(Codecours) REFERENCES Cours(Codecours),
FOREIGN KEY (Codesess) REFERENCES SessionCours (Codesess),
FOREIGN KEY (Codeprof) REFERENCES Professeur (Codeprof) on delete cascade
);

--Insertion des données dans les tables
INSERT INTO Departement VALUES('INFO', 'Informatique');
INSERT INTO Departement VALUES('MATH', 'Mathematiqe');
INSERT INTO Departement VALUES('BIO', 'Biologie');

INSERT INTO Professeur VALUES('GODR0', 'Godin', 'Robert','INFO');
INSERT INTO Professeur VALUES('SADF0', 'Sadat', 'Fatiha', 'INFO');
INSERT INTO Professeur VALUES('LABL0', 'Labelle', 'Laura', 'MATH');
INSERT INTO Professeur VALUES('LABL1', 'Labelle', 'Laurent', 'BIO');
INSERT INTO Professeur VALUES('BEAM0', 'Beausoleil', 'Mireille', 'MATH');
INSERT INTO Professeur VALUES('AJIW0', 'Ajib', 'Wessam', 'INFO');
INSERT INTO Professeur VALUES('BEAE0', 'Beaudry', 'Eric', 'INFO');
INSERT INTO Professeur VALUES('BEGG0', 'Begin', 'Guy', 'INFO');
INSERT INTO Professeur VALUES('BERA0', 'Bergeron', 'Anne', 'INFO');
INSERT INTO Professeur VALUES('BLAY0', 'Blaquiere', 'Yves', 'INFO');
INSERT INTO Professeur VALUES('BLOA0', 'Blondin-Masse', 'Alexandre', 'INFO');
INSERT INTO Professeur VALUES('BOUM0', 'Bouguessa', 'Mohamed', 'INFO');
INSERT INTO Professeur VALUES('BOUM1', 'Boukadoum', 'Mounir', 'INFO');
INSERT INTO Professeur VALUES('BRLS0', 'Brlek', 'Srecko', 'INFO');
INSERT INTO Professeur VALUES('CHEO0', 'Cherkaoui', 'Omar', 'INFO');
INSERT INTO Professeur VALUES('CICP0', 'Cicek', 'Paul-Vache', 'INFO');
INSERT INTO Professeur VALUES('DESD0', 'Deslandes', 'Dominic', 'INFO');
INSERT INTO Professeur VALUES('DIAA0', 'Diallo', 'Abdoulaye', 'INFO');
INSERT INTO Professeur VALUES('ELBH0', 'Elbiaze', 'Halima', 'INFO');
INSERT INTO Professeur VALUES('FAYC0', 'Fayomi', 'Christian', 'INFO');
INSERT INTO Professeur VALUES('GAGE0', 'Gagnon', 'Etienne', 'INFO');
INSERT INTO Professeur VALUES('GAMS0', 'Gambs', 'Sebastien', 'INFO');
INSERT INTO Professeur VALUES('IZQR0', 'Izquierdo', 'Ricardo', 'INFO');
INSERT INTO Professeur VALUES('KERB0', 'Kerherve', 'Brigitte', 'INFO');
INSERT INTO Professeur VALUES('LAFL0', 'Laforest', 'Louise', 'INFO');
INSERT INTO Professeur VALUES('LOUH0', 'Lounis', 'Hakim', 'INFO');
INSERT INTO Professeur VALUES('MAKV0', 'Makarenkov', 'Vladimir', 'INFO');
INSERT INTO Professeur VALUES('MARL0', 'Martin', 'Louis', 'INFO');
INSERT INTO Professeur VALUES('MEMD0', 'Memmi', 'Daniel', 'INFO');
INSERT INTO Professeur VALUES('MENM0', 'Menard', 'Michael', 'INFO');
INSERT INTO Professeur VALUES('MEUM0', 'Meurs', 'Marie-Jean', 'INFO');
INSERT INTO Professeur VALUES('MILH0', 'Mili', 'Hafedh', 'INFO');
INSERT INTO Professeur VALUES('MOHN0', 'Moha', 'Naouel', 'INFO');
INSERT INTO Professeur VALUES('NABF0', 'Nabki', 'Frederic', 'INFO');
INSERT INTO Professeur VALUES('NKAR0', 'Nkambou', 'Roger', 'INFO');
INSERT INTO Professeur VALUES('OBAA0', 'Obaid', 'Abdel', 'INFO');
INSERT INTO Professeur VALUES('PRIJ0', 'Privat', 'Jean', 'INFO');
INSERT INTO Professeur VALUES('SALA0', 'Salah', 'Aziz', 'INFO');
INSERT INTO Professeur VALUES('SEGN0', 'Seguin', 'Normand', 'INFO');
INSERT INTO Professeur VALUES('TREG0', 'Tremblay', 'Guy', 'INFO');
INSERT INTO Professeur VALUES('TRUS0', 'Trudel', 'Sylie', 'INFO');
INSERT INTO Professeur VALUES('VALP0', 'Valtchev', 'Petko', 'INFO');

INSERT INTO Cours VALUES('INF3180','Base de donnée relationnelles', 'INFO');
INSERT INTO Cours VALUES('INF5180', 'Base de données avancées', 'INFO');
INSERT INTO Cours VALUES('DIC9320', 'Traitement automatique du langage naturel', 'INFO');
INSERT INTO Cours VALUES('MAT1120', 'Principe essentiels de la logique', 'MATH');
INSERT INTO Cours VALUES('INF7210', 'Nouvelles perspectives en base de données', 'INFO');

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';
INSERT INTO SessionCours VALUES('00112', '03/09/2013', '16/12/2013', 'Session automne 2013');
INSERT INTO SessionCours VALUES('00543','05/01/2014','30/04/2014', 'Session hiver 2014');
INSERT INTO SessionCours VALUES('01234','01/05/2014', '31/07/2014', 'Session ete 2014');

INSERT INTO GroupeCours VALUES('INF3180', 10, '00112', 'SADF0', 'Groupe 10 du cours INF3180 de la session de l,automne 2013');
INSERT INTO GroupeCours VALUES('INF3180', 30, '00112', 'GODR0','Groupe 30 du cours INF3180 de la session de l,automne 2013' );
INSERT INTO GroupeCours VALUES('INF5180', 30, '00112', 'GODR0','Groupe 30 du cours INF5180 de la session de l,automne 2013' );

COMMIT;


ex 2:

--Il y a 5 procédures a importer

create or replace function getDeptName 
(inputCode IN departement.codDept%type)
Return departement.nomDept%type is nom departement.nomDept%type;
begin
select nomdept
into nom
from departement
where coddept = inputCode;
return nom;
end;

create or replace function getdebutSession
(code IN Integer)
Return sessionCours.datedebut%type is Alice sessionCours.datedebut%type;
begin
select datedebut
into Alice
from sessioncours
where codesess = code;
return alice;
end;

create or replace function getfinSession
(code In Integer)
Return sessionCours.datefin%type is dateF sessionCours.datefin%type;
begin
select datefin
into dateF
from sessioncours
where codesess = code;
return dateF;
end;

create or replace procedure trouverProfCours
(input professeur.codeprof%type)
is
leCodeCours groupeCours.codeCours%type;
lecodegrp groupecours.codegrp%type;
lecodeSess groupeCours.codesess%type;
debutSess sessioncours.datedebut%type;
finSess sessioncours.datefin%type;
cursor bob(inputCode professeur.codeprof%type)
is
select codeCours,codegrp,codesess
from groupeCours 
where codeprof = inputCode;
Begin
open bob(input);
loop
fetch bob into leCodeCours,lecodeGrp,lecodeSess;
exit when bob%notFound;
debutSess := getdebutSession(00112);
finSess := getfinSession(00112);
dbms_output.put_line('codeCours  ' ||' codeGrp   '|| 'date_debut_session '|| 'date_fin_session');
dbms_output.put_line(lecodeCours || '       ' || lecodegrp || '       ' || debutSess || '          ' || finSess);
end loop;
end;

create or replace procedure TacheEnseignement
(input professeur.codeprof%type)
is
lenomProf professeur.nomprof%type;
leprenomProf professeur.prenomprof%type;
lenomDept departement.nomdept%type;
lecodeDept departement.coddept%type;
cursor bob(prof professeur.codeprof%type)
is
select nomProf,prenomProf,codeDept
from professeur
where codeProf = input;
Begin
open bob(input);
loop
fetch bob into lenomProf,leprenomProf,lecodeDept;
exit when bob%notFound;
lenomDept := getDeptName(lecodeDept);
dbms_output.put('Code professeur : ');
dbms_output.put_line(input);
dbms_output.put('Nom: ');
dbms_output.put_line(lenomProf);
dbms_output.put('Prenom: ');
dbms_output.put_line(lePrenomProf);
dbms_output.put('Department : ');
dbms_output.put_line(lenomDept);
dbms_output.put_line('. ');
dbms_output.put_line('. ');
trouverProfCours(input);
end loop;
end;


ex 3


create or replace function nombreCoursSession
(code IN number)
return number is duration number;
begin
select  ROUND((datefin - datedebut)/7,0)  
into duration
from sessioncours 
where codesess = code;
return duration;
end;
/


create or replace procedure getProfInfo
(input integer,inputProf professeur.codeprof%type)
Is
lecodeCours groupeCours.codeCours%type;
lecodeGrp	 groupeCours.codeGrp%type;
lecodeSess  groupeCours.codeSess%type;
nombreCours Integer;
cursor bob(inputSess Integer,inputP professeur.codeprof%type) is
select codecours,codegrp
from groupeCours
where codesess = inputSess and codeProf = inputP;
begin
nombrecours := nombreCoursSession(input);
dbms_output.put('CodeProf ');
dbms_output.put('codecours ');
dbms_output.put('codegrp ');
dbms_output.put('codesess ');
dbms_output.put_line('nombre cours');
open bob(input,inputProf);
loop
fetch bob into lecodeCours,lecodeGrp;
exit when bob%notFound;
dbms_output.put_line(inputProf || '    ' || lecodeCours  || '     ' || lecodeGrp || '     ' || input || '      ' || nombrecours);
end loop;
dbms_output.put_line('.');
dbms_output.put_line('.');
end;



create or replace procedure EmploiduTemps
(input Integer)
IS
lecodeProf professeur.codeprof%type;
lenomProf professeur.nomprof%type;
leprenomProf professeur.prenomprof%type;
lenomDept departement.nomdept%type;
lecodeDept departement.coddept%type;
cursor bob(inputSess Integer) is
select codeProf,nomprof,prenomprof,codedept
from professeur
where codeProf in
(select codeprof from groupeCours where codesess = inputSess);
begin
open bob(input);
loop
fetch bob into lecodeProf,lenomProf,leprenomProf,lecodeDept;
exit when bob%notFound;
lenomDept := getDeptName(lecodeDept);
dbms_output.put('Code professeur : ');
dbms_output.put_line(lecodeProf);
dbms_output.put('Nom: ');
dbms_output.put_line(lenomProf);
dbms_output.put('Prenom: ');
dbms_output.put_line(lePrenomProf);
dbms_output.put('Department : ');
dbms_output.put_line(lenomDept);
dbms_output.put_line('. ');
dbms_output.put_line('. ');
getProfInfo(input,lecodeProf);
end loop;
close bob;
end;
/




