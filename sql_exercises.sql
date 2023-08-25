CREATE TABLE Wampiry(
pseudo_wampira VARCHAR2(15) CONSTRAINT w_pk PRIMARY KEY,
wampir_w_rodzinie DATE CONSTRAINT w_wampiry_w_rodzinie_nn NOT NULL,
plec_wampira CHAR(1) CONSTRAINT w_plec_wampira_nn NOT NULL
                  CONSTRAINT w_plec_wampira_ck CHECK (plec_wampira IN ('K', 'M')),
pseudo_szefa VARCHAR2(15) CONSTRAINT w_pseudo_szefa_fk REFERENCES Wampiry(pseudo_wampira)
);

CREATE TABLE Zlecenia(
nr_zlecenia NUMBER(6) CONSTRAINT z_pk PRIMARY KEY
                      CONSTRAINT z_nr_zlecenia_ck CHECK(nr_zlecenia>0),
data_zlecenia DATE CONSTRAINT z_data_zlecenia_nn NOT NULL,
pseudo_wampira VARCHAR2(15)CONSTRAINT z_pseudo_wampira_nn NOT NULL
                           CONSTRAINT z_pseudo_wampira_fk REFERENCES Wampiry(pseudo_wampira)
);

CREATE TABLE Dawcy(
pseudo_dawcy VARCHAR2(15) CONSTRAINT d_pk PRIMARY KEY,
rocznik_dawcy NUMBER(4)CONSTRAINT d_rocznik_dawcy_nn NOT NULL,
plec_dawcy CHAR(1) CONSTRAINT d_plec_dawcy_nn NOT NULL
                   CONSTRAINT d_plec_dawcy_ck CHECK (plec_dawcy IN ('K', 'M')),
grupa_krwi VARCHAR2(2) CONSTRAINT d_grupa_krwi_nn NOT NULL
                       CONSTRAINT d_grupa_krwi_ck CHECK (grupa_krwi IN ('0', 'A', 'B', 'AB'))
);

CREATE TABLE Donacje(
nr_zlecenia NUMBER(6) CONSTRAINT d_nr_zlecenia_fk REFERENCES Zlecenia(nr_zlecenia),
pseudo_dawcy VARCHAR2(15) CONSTRAINT d_pseudo_dawcy_fk REFERENCES Dawcy(pseudo_dawcy),
data_oddania DATE CONSTRAINT d_data_oddania_nn NOT NULL,
ilosc_krwi NUMBER(3) CONSTRAINT d_ilosc_krwi_ck CHECK(ilosc_krwi>0),
pseudo_wampira VARCHAR2(15) CONSTRAINT d_pseudo_wampira_fk REFERENCES Wampiry(pseudo_wampira),
data_wydania DATE,
                    CONSTRAINT do_pk PRIMARY KEY(nr_zlecenia, pseudo_dawcy),
                    CONSTRAINT d_data_wydania_ck CHECK(data_wydania>=data_oddania)
);

CREATE TABLE Sprawnosci(
sprawnosc VARCHAR2(20) CONSTRAINT s_pk PRIMARY KEY
);

CREATE TABLE Sprawnosci_w(
pseudo_wampira VARCHAR2(15) CONSTRAINT s_w_pseudo_wampira_fk REFERENCES Wampiry(pseudo_wampira),
sprawnosc VARCHAR2(20) CONSTRAINT s_w_sprawnosc_fk REFERENCES Sprawnosci(sprawnosc),
sprawnosc_od DATE CONSTRAINT sprawnosc_od_nn NOT NULL,
                    CONSTRAINT s_w_pk PRIMARY KEY(pseudo_wampira, sprawnosc)
);

CREATE TABLE Jezyki_obce(
jezyk_obcy VARCHAR2(20) CONSTRAINT j_o_pk PRIMARY KEY
);

CREATE TABLE Jezyki_obce_w(
pseudo_wampira VARCHAR2(15) CONSTRAINT j_o_w_pseudo_wampira_fk REFERENCES Wampiry(pseudo_wampira),
jezyk_obcy VARCHAR2(20) CONSTRAINT j_o_w_jezyk_obcy_fk REFERENCES Jezyki_obce(jezyk_obcy),
jezyk_obcy_od DATE CONSTRAINT j_o_w_j_o_od_nn NOT NULL,
                    CONSTRAINT j_o_w_pk PRIMARY KEY(pseudo_wampira, jezyk_obcy)
);

ALTER session set NLS_DATE_FORMAT= 'DD.MM.YYYY';

INSERT ALL 
INTO Wampiry VALUES ('Drakula','12.12.1217','M',NULL)
INTO Wampiry VALUES ('Opoj','07.11.1777','M','Drakula')
INTO Wampiry VALUES ('Wicek','11.11.1721','M','Drakula')
INTO Wampiry VALUES ('Baczek','13.04.1855','M','Opoj')
INTO Wampiry VALUES ('Bolek','31.05.1945','M','Opoj')
INTO Wampiry VALUES ('Gacek','21.02.1891','M','Wicek')
INTO Wampiry VALUES ('Pijawka','03.11.1901','K','Wicek')
INTO Wampiry VALUES ('Czerwony','13.09.1823','M','Wicek')
INTO Wampiry VALUES ('Komar','23.07.1911','M','Wicek')
INTO Wampiry VALUES ('Zyleta','23.09.1911','K','Opoj')
INTO Wampiry VALUES ('Predka','29.03.1877','K','Drakula')

INTO Zlecenia VALUES (221,'04.07.2005','Opoj')
INTO Zlecenia VALUES (222,'04.07.2005','Baczek')
INTO Zlecenia VALUES (223,'17.07.2005','Bolek')
INTO Zlecenia VALUES (224,'22.07.2005','Opoj')
INTO Zlecenia VALUES (225,'01.08.2005','Pijawka')
INTO Zlecenia VALUES (226,'07.08.2005','Gacek')

INTO Dawcy VALUES ('Slodka',1966,'K','AB')
INTO Dawcy VALUES ('Miodzio',1983,'M','B')
INTO Dawcy VALUES ('Gorzka',1958,'K','0')
INTO Dawcy VALUES ('Lolita',1987,'K','0')
INTO Dawcy VALUES ('Wytrawny',1971,'M','A')
INTO Dawcy VALUES ('Okocim',1966,'M','B')
INTO Dawcy VALUES ('Adonis',1977,'M','AB')
INTO Dawcy VALUES ('Zywiec',1969,'M','A')
INTO Dawcy VALUES ('Eliksir',1977,'M','0')
INTO Dawcy VALUES ('Zenek',1959,'M','B')
INTO Dawcy VALUES ('Zoska',1963,'K','0')
INTO Dawcy VALUES ('Czerwonka',1953,'M','A')

INTO Donacje VALUES (221,'Slodka','04.07.2005',455,'Drakula','06.08.2005')
INTO Donacje VALUES (221,'Miodzio','04.07.2005',680,'Gacek','15.08.2005')
INTO Donacje VALUES (221,'Gorzka','05.07.2005',471,'Pijawka','11.08.2005')
INTO Donacje VALUES (221,'Lolita','05.07.2005',340,'Czerwony','21.08.2005')
INTO Donacje VALUES (222,'Wytrawny','07.07.2005',703,'Drakula','17.07.2005')
INTO Donacje VALUES (222,'Okocim','07.07.2005',530,'Komar','01.09.2005')
INTO Donacje VALUES (222,'Adonis','08.07.2005',221,'Zyleta','11.09.2005')
INTO Donacje VALUES (223,'Zywiec','17.07.2005',587,'Wicek','18.09.2005')
INTO Donacje VALUES (224,'Gorzka','22.07.2005',421,'Drakula','23.08.2005')
INTO Donacje VALUES (224,'Eliksir','25.07.2005',377,'Predka','26.07.2005')
INTO Donacje VALUES (225,'Zenek','04.08.2005',600,'Opoj','15.08.2005')
INTO Donacje VALUES (225,'Zoska','06.08.2005',450,NULL,NULL)
INTO Donacje VALUES (226,'Czerwonka','10.08.2005',517,'Pijawka','30.09.2005')
INTO Donacje VALUES (226,'Miodzio','11.08.2005',644,NULL,NULL)

INTO Sprawnosci VALUES ('podryw')
INTO Sprawnosci VALUES ('gorzala')
INTO Sprawnosci VALUES ('kasa')
INTO Sprawnosci VALUES ('przymus')
INTO Sprawnosci VALUES ('niesmiertelnosc')

INTO Sprawnosci_w VALUES ('Drakula','podryw','12.12.1217')
INTO Sprawnosci_w VALUES ('Drakula','gorzala','12.12.1217')
INTO Sprawnosci_w VALUES ('Wicek','kasa','11.11.1721')
INTO Sprawnosci_w VALUES ('Wicek','przymus','07.01.1771')
INTO Sprawnosci_w VALUES ('Opoj','podryw','07.11.1777')
INTO Sprawnosci_w VALUES ('Czerwony','niesmiertelnosc','13.09.1823')
INTO Sprawnosci_w VALUES ('Drakula','kasa','13.09.1823')
INTO Sprawnosci_w VALUES ('Opoj','gorzala','11.12.1844')
INTO Sprawnosci_w VALUES ('Baczek','gorzala','13.04.1855')
INTO Sprawnosci_w VALUES ('Drakula','przymus','14.06.1857')
INTO Sprawnosci_w VALUES ('Drakula','niesmiertelnosc','21.08.1858')
INTO Sprawnosci_w VALUES ('Opoj','przymus','15.07.1861')
INTO Sprawnosci_w VALUES ('Wicek','gorzala','19.01.1866')
INTO Sprawnosci_w VALUES ('Predka','podryw','29.03.1877')
INTO Sprawnosci_w VALUES ('Czerwony','kasa','03.02.1891')
INTO Sprawnosci_w VALUES ('Gacek','kasa','21.02.1891')
INTO Sprawnosci_w VALUES ('Pijawka','podryw','03.11.1901')
INTO Sprawnosci_w VALUES ('Komar','gorzala','23.07.1911')
INTO Sprawnosci_w VALUES ('Zyleta','przymus','23.09.1911')
INTO Sprawnosci_w VALUES ('Bolek','gorzala','31.05.1945')

INTO Jezyki_obce VALUES ('niemiecki')
INTO Jezyki_obce VALUES ('wegierski')
INTO Jezyki_obce VALUES ('bulgarski')
INTO Jezyki_obce VALUES ('rosyjski')
INTO Jezyki_obce VALUES ('portugalski')
INTO Jezyki_obce VALUES ('francuski')
INTO Jezyki_obce VALUES ('angielski')
INTO Jezyki_obce VALUES ('polski')
INTO Jezyki_obce VALUES ('hiszpanski')
INTO Jezyki_obce VALUES ('czeski')
INTO Jezyki_obce VALUES ('wloski')
INTO Jezyki_obce VALUES ('szwedzki')

INTO Jezyki_obce_w VALUES ('Drakula','niemiecki','12.12.1217')
INTO Jezyki_obce_w VALUES ('Drakula','wegierski','12.12.1217')
INTO Jezyki_obce_w VALUES ('Drakula','bulgarski','03.04.1455')
INTO Jezyki_obce_w VALUES ('Wicek','rosyjski','11.11.1721')
INTO Jezyki_obce_w VALUES ('Opoj','portugalski','07.11.1777')
INTO Jezyki_obce_w VALUES ('Czerwony','francuski','13.09.1823')
INTO Jezyki_obce_w VALUES ('Drakula','angielski','13.09.1823')
INTO Jezyki_obce_w VALUES ('Wicek','polski','18.08.1835')
INTO Jezyki_obce_w VALUES ('Opoj','hiszpanski','12.03.1851')
INTO Jezyki_obce_w VALUES ('Baczek','czeski','13.04.1855')
INTO Jezyki_obce_w VALUES ('Wicek','niemiecki','11.06.1869')
INTO Jezyki_obce_w VALUES ('Wicek','wloski','14.03.1873')
INTO Jezyki_obce_w VALUES ('Predka','czeski','29.03.1877')
INTO Jezyki_obce_w VALUES ('Opoj','polski','13.09.1883')
INTO Jezyki_obce_w VALUES ('Czerwony','rosyjski','23.11.1888')
INTO Jezyki_obce_w VALUES ('Gacek','polski','21.02.1891')
INTO Jezyki_obce_w VALUES ('Predka','niemiecki','07.06.1894')
INTO Jezyki_obce_w VALUES ('Baczek','angielski','04.12.1899')
INTO Jezyki_obce_w VALUES ('Pijawka','angielski','03.11.1901')
INTO Jezyki_obce_w VALUES ('Komar','szwedzki','23.07.1911')
INTO Jezyki_obce_w VALUES ('Zyleta','angielski','23.09.1911')
INTO Jezyki_obce_w VALUES ('Bolek','francuski','31.05.1945')

SELECT * FROM Dual;

ALTER session set NLS_DATE_FORMAT= 'DD.MM.YYYY';


--LISTA 2

--1.
SELECT pseudo_dawcy "Dawca A", rocznik_dawcy "Rocznik"
FROM Dawcy
WHERE grupa_krwi = 'A';

--2.
SELECT DISTINCT pseudo_dawcy "Dawca"
FROM Donacje
WHERE data_oddania BETWEEN '20.07.2005' AND '20.08.2005'
ORDER BY pseudo_dawcy;

--3.
SELECT pseudo_dawcy "Dawca", plec_dawcy "Plec"
FROM Dawcy
WHERE rocznik_dawcy IN (1977, 1971);

--4.
SELECT DISTINCT pseudo_dawcy "Dawca"
FROM Donacje
WHERE MONTHS_BETWEEN('17.05.2006', data_wydania)>=10;

--5.
SELECT pseudo_dawcy "Dawca", ilosc_krwi "Donacja", NVL(TO_CHAR(data_wydania), 'Na stanie') "Wydano"
FROM Donacje
WHERE data_oddania>'10.07.2005';

--6.
SELECT COUNT(DISTINCT sprawnosc) "Liczba sprawnosci"
FROM sprawnosci_w
WHERE pseudo_wampira IN ('Opoj', 'Czerwony');

--7.
SELECT SUM(ilosc_krwi) "Cieple buleczki"
FROM Donacje
WHERE data_wydania - data_oddania <=10;

--8.
SELECT pseudo_wampira "Wampir", COUNT(jezyk_obcy) "liczba jezykow"
FROM Jezyki_obce_w
WHERE jezyk_obcy != 'rosyjski'
GROUP BY pseudo_wampira;

--9.
SELECT pseudo_wampira "Wampir", COUNT(data_wydania) "Liczba konsumpcji"
FROM Donacje
GROUP BY pseudo_wampira
HAVING COUNT(data_wydania)>1;

--10.
SELECT grupa_krwi "Grupa", plec_dawcy "Plec", COUNT(DISTINCT pseudo_dawcy) "Liczba dawcow"
FROM Dawcy
GROUP BY grupa_krwi, plec_dawcy;




--LISTA 3

--1
SELECT nr_zlecenia "Zlecenie AB"
FROM Donacje JOIN Dawcy USING(pseudo_dawcy)
WHERE grupa_krwi = 'AB';

--2
SELECT W1.pseudo_wampira "PSEUDO WAMPIRA", W1. plec_wampira "PLEC", NVL(W1.pseudo_szefa, ' ') "PSEUDO SZEFA", NVL(W2.plec_wampira, ' ') "PLEC SZEFA"
FROM Wampiry W1  LEFT JOIN Wampiry W2 ON W1.pseudo_szefa = W2.pseudo_wampira;

--3
SELECT pseudo_dawcy "Dawca przed Slodka", plec_dawcy "Plec"
FROM Dawcy
WHERE rocznik_dawcy < (SELECT rocznik_dawcy FROM Dawcy WHERE pseudo_dawcy = 'Slodka');

--4
SELECT pseudo_dawcy "Pseudonim", 'Powyzej 1000' "Pobor"
FROM Donacje
GROUP BY pseudo_dawcy
HAVING SUM(ilosc_krwi)>1000
UNION ALL
SELECT pseudo_dawcy, 'Miedzy 700 a 1000'
FROM Donacje
GROUP BY pseudo_dawcy
HAVING SUM(ilosc_krwi) BETWEEN 700 AND 1000
UNION ALL
SELECT pseudo_dawcy, 'Ponizej 700'
FROM Donacje
GROUP BY pseudo_dawcy
HAVING SUM(ilosc_krwi)<700
ORDER BY 1;

--5
SELECT pseudo_wampira "Wampir", COUNT(DISTINCT(jezyk_obcy)) "Liczba"
FROM Jezyki_obce_W JOIN Sprawnosci_W USING(pseudo_wampira)
GROUP BY pseudo_wampira
HAVING COUNT(DISTINCT(jezyk_obcy))=COUNT(DISTINCT(sprawnosc));

--6
SELECT nr_zlecenia "Zlecenie AB", data_zlecenia "Data wykonania"
FROM ZLECENIA 
WHERE nr_zlecenia IN (SELECT nr_zlecenia
                      FROM Donacje
                      WHERE pseudo_dawcy IN (SELECT pseudo_dawcy
                                             FROM Dawcy
                                             WHERE grupa_krwi = 'AB'));

--7
SELECT plec_wampira "Plec", COUNT(pseudo_wampira) "Liczba lingwistow"
FROM  Wampiry
WHERE pseudo_wampira IN (SELECT pseudo_wampira
                         FROM jezyki_obce_w
                         GROUP BY pseudo_wampira
                         HAVING COUNT(jezyk_obcy)>=2)
GROUP BY plec_wampira;


--8 dodac distnicty
    --a)
SELECT ilosc_krwi "Objetosc", pseudo_dawcy "Dawca"
FROM Donacje D1
WHERE 3 > (SELECT COUNT(DISTINCT ilosc_krwi)
           FROM Donacje D2
           WHERE D1.ilosc_krwi<D2.ilosc_krwi)
ORDER BY ilosc_krwi DESC;
    --b);
SELECT D1.ilosc_krwi "Objetosc", D1.pseudo_dawcy "Dawca"
FROM Donacje D1 JOIN Donacje D2 ON D1.ilosc_krwi<=D2.ilosc_krwi
GROUP BY D1.ilosc_krwi, D1.pseudo_dawcy, D1.nr_zlecenia
HAVING COUNT(DISTINCT D2.ilosc_krwi) <=3
ORDER BY D1.ilosc_krwi DESC;

--9
    --podzapytania
SELECT pseudo_dawcy "Dawcy", grupa_krwi "Grupa"
FROM Dawcy
WHERE pseudo_dawcy IN (SELECT pseudo_dawcy
                       FROM Donacje
                       WHERE nr_zlecenia IN(SELECT nr_zlecenia
                                            FROM Zlecenia
                                            WHERE pseudo_wampira IN (SELECT pseudo_wampira 
                                                                     FROM Wampiry
                                                                     WHERE plec_wampira = 'M')
                                            AND pseudo_wampira IN(SELECT pseudo_wampira
                                                                  FROM Jezyki_obce_w
                                                                  WHERE jezyk_obcy = 'polski')));
    --zlaczenia
SELECT DISTINCT D1.pseudo_dawcy "Dawcy", D1.grupa_krwi "Grupa",  Z.pseudo_wampira "Biorca"
FROM Dawcy D1 JOIN Donacje D2 ON D1.pseudo_dawcy = D2.pseudo_dawcy
              JOIN Zlecenia Z ON D2.nr_zlecenia = Z.nr_zlecenia
              JOIN Wampiry W ON Z.pseudo_wampira =W.pseudo_wampira
              JOIN Jezyki_obce_w J ON Z.pseudo_wampira=J.pseudo_wampira
WHERE W.plec_wampira ='M' AND J.jezyk_obcy = 'polski' ;

--10.
SELECT pseudo_wampira "Wampir", EXTRACT(YEAR FROM wampir_w_rodzinie) "Rok wstapienia"
FROM Wampiry
WHERE EXTRACT(YEAR FROM wampir_w_rodzinie) IN (SELECT EXTRACT(YEAR FROM wampir_w_rodzinie)
                                               FROM Wampiry
                                               GROUP BY EXTRACT(YEAR FROM wampir_w_rodzinie)
                                               HAVING COUNT(*)>1);

--1l. podloga sufit
SELECT 'Srednia' "ROK", AVG(COUNT(pseudo_wampira)) "LICZBA WSTAPIEN"
FROM Wampiry
GROUP BY EXTRACT(YEAR FROM wampir_w_rodzinie)
UNION ALL
SELECT TO_CHAR(EXTRACT(YEAR FROM wampir_w_rodzinie)), COUNT(wampir_w_rodzinie)
FROM Wampiry
GROUP BY EXTRACT(YEAR FROM wampir_w_rodzinie)
HAVING COUNT(*) <= (SELECT FLOOR(AVG(COUNT(wampir_w_rodzinie))) FROM Wampiry GROUP BY EXTRACT(YEAR FROM wampir_w_rodzinie))
OR 
COUNT(*) >=(SELECT CEIL(AVG(COUNT(wampir_w_rodzinie))) FROM Wampiry GROUP BY EXTRACT(YEAR FROM wampir_w_rodzinie))
ORDER BY 2;

--12.
--a)
SELECT pseudo_dawcy "Dawczyni", grupa_krwi "Grupa krwi", 
(SELECT SUM(ilosc_krwi)
 FROM Donacje D
 WHERE D.pseudo_dawcy = Da.pseudo_dawcy)"W sumie oddala", 
(SELECT ROUND(AVG(SUM(ilosc_krwi)),0)
 FROM Dawcy JOIN Donacje USING(pseudo_dawcy)
 WHERE grupa_krwi=Da.grupa_krwi AND plec_dawcy='K'
 GROUP BY pseudo_dawcy)"Srednia suma w jej grupie"
FROM Dawcy Da
WHERE plec_dawcy = 'K';
--b)
SELECT pseudo_dawcy "Dawczyni", grupa_krwi "Grupa krwi", "W sumie oddala", "Srednia suma w jej grupie"
FROM (SELECT pseudo_dawcy, grupa_krwi,SUM(ilosc_krwi) "W sumie oddala"
      FROM Dawcy JOIN Donacje USING(pseudo_dawcy)
      WHERE plec_dawcy = 'K'
      GROUP BY pseudo_dawcy, grupa_krwi)
JOIN
     (SELECT ROUND(AVG("Suma poszczegolnych grup"), 0) "Srednia suma w jej grupie", grupa_krwi
      FROM (SELECT SUM(ilosc_krwi) "Suma poszczegolnych grup", pseudo_dawcy, grupa_krwi
            FROM Dawcy JOIN Donacje USING(pseudo_dawcy)
            WHERE plec_dawcy = 'K'
            GROUP BY pseudo_dawcy, grupa_krwi)
      GROUP BY grupa_krwi)
USING(grupa_krwi);
   
--13                                                                        
SELECT W.pseudo_wampira "Wampir", D.pseudo_dawcy "Zrodlo", ilosc_krwi "Wypil ml"
FROM Wampiry W LEFT JOIN Zlecenia Z ON W.pseudo_wampira = Z.pseudo_wampira JOIN Donacje D ON W.pseudo_wampira = D.pseudo_wampira
WHERE W.plec_wampira = 'M' AND Z.nr_zlecenia IS NULL AND D.pseudo_dawcy IN (SELECT pseudo_dawcy
                                                                            FROM Donacje JOIN Dawcy USING(pseudo_dawcy)
                                                                            WHERE plec_dawcy = 'K'
                                                                            GROUP BY pseudo_dawcy
                                                                            HAVING SUM(ilosc_krwi)>800);                                                                            
--14
SELECT pseudo_dawcy "Dawca", rocznik_dawcy "Rocznik"
FROM Dawcy
WHERE grupa_krwi = '0';

SAVEPOINT starzy_dawcy;

UPDATE Dawcy 
SET rocznik_dawcy = rocznik_dawcy + 5
WHERE grupa_krwi = '0';

SELECT pseudo_dawcy "Dawca", rocznik_dawcy "Rocznik"
FROM Dawcy
WHERE grupa_krwi = '0';

ROLLBACK TO SAVEPOINT starzy_dawcy;

--15 uzyc 3 razy lewostronne
SELECT W1.pseudo_wampira "Pseudo wampira", W1.pseudo_szefa "Pseudo szefa", 
TO_CHAR(W2.wampir_w_rodzinie) "W rodzinie s",W2.pseudo_szefa "Pseudo szefa szefa", '12.12.1217' "W Rodzinie ss"
FROM Wampiry W1, Wampiry W2
WHERE W2.pseudo_wampira = W1.pseudo_szefa and W1.plec_wampira = 'M' AND W1.pseudo_wampira NOT IN ('Opoj', 'Wicek')
UNION
SELECT 'Drakula', ' ', ' ', ' ', ' '
FROM Dual
UNION
SELECT W1.pseudo_wampira , W1.pseudo_szefa, 
TO_CHAR(W2.wampir_w_rodzinie) , ' ', ' '
FROM Wampiry W1, Wampiry W2
WHERE W2.pseudo_wampira = W1.pseudo_szefa and W1.plec_wampira = 'M' AND W1.pseudo_wampira IN ('Opoj', 'Wicek')
ORDER BY 5 dESC;

--15
SELECT W1.pseudo_wampira "Pseudo wampira", NVL(W1.pseudo_szefa, ' ') "Pseudo szefa", 
NVL(TO_CHAR(W2.wampir_w_rodzinie), ' ') "W rodzinie s",NVL(W2.pseudo_szefa, ' ') "Pseudo szefa szefa", NVL(TO_CHAR(W3.wampir_w_rodzinie), ' ') "W Rodzinie ss"
FROM Wampiry W1 LEFT JOIN Wampiry W2 ON W1.pseudo_szefa = W2.pseudo_wampira LEFT JOIN Wampiry W3 ON W2.pseudo_szefa = W3.pseudo_wampira
WHERE W1.plec_wampira = 'M';
--16
SELECT DECODE(plec_wampira,'K','Wampirki','Wampiry') "Plec podwladnych",
SUM(DECODE(pseudo_szefa, 'Drakula', ilosc_krwi, 0)) "Pod Drakula",
SUM(DECODE(pseudo_szefa, 'Opoj', ilosc_krwi, 0)) "Pod Opojem",
SUM(DECODE(pseudo_szefa, 'Wicek', ilosc_krwi, 0)) "Pod Wickiem"
FROM Wampiry JOIN Donacje USING(pseudo_wampira)
GROUP BY plec_wampira;

















-- RZECZYWISTOSC KOTOW
DROP TABLE Koty;
DROP TABLE Funkcje;
DROP TABLE Funkcje NOWAIT;
DROP TABLE Lapowki;
DROP TABLE Lapowki_wrogow;
DROP TABLE Myszy;
DROP TABLE Wrogowie;
DROP TABLE Incydenty;
DROP TABLE BANDY;

CREATE TABLE Funkcje (
    nazwa_funkcji VARCHAR2(15) CONSTRAINT FUNKCJE_NAZWA_PK PRIMARY KEY,
    min_myszy NUMBER(3) CONSTRAINT FUNKCJE_MIN_NN NOT NULL,
    max_myszy NUMBER(3) CONSTRAINT FUNKCJE_MAX_NN NOT NULL,
    CONSTRAINT FUNKCJE_MIN_MAX_CHECK CHECK (MIN_MYSZY <= MAX_MYSZY)
);

CREATE TABLE Koty(
    pseudo VARCHAR2(15) CONSTRAINT KOT_PK PRIMARY KEY,
    plec CHAR(1) CONSTRAINT KOT_PLEC_CHECK CHECK(PLEC IN ('K', 'M')) CONSTRAINT KOT_PLEC_NN NOT NULL,
    data_wstapienia DATE CONSTRAINT KOTY_DATA_WSTAPIENIA_NN NOT NULL,
    przydzial_myszy NUMBER(3) CONSTRAINT PRZYDZIAL_MIN_CHECK CHECK(PRZYDZIAL_MYSZY >=0),
    pseudo_szefa VARCHAR2(15) REFERENCES Koty(PSEUDO),
    nr_bandy NUMBER(2), --REFERENCES BANDY(NR_BANDY),
    nazwa_funkcji VARCHAR2(15) REFERENCES Funkcje(NAZWA_FUNKCJI)
);

ALTER TABLE Koty ADD CONSTRAINT KOT_NR_BANDY_FK FOREIGN KEY (nr_bandy) REFERENCES Bandy(nr_bandy);

CREATE TABLE Myszy(
    nr_myszy NUMBER(3) CONSTRAINT MYSZY_PK PRIMARY KEY,
    waga NUMBER(1) CONSTRAINT MYSZY_WAGA_CHECK CHECK(WAGA BETWEEN 0 AND 10) CONSTRAINT MYSZY_WAGA_NN NOT NULL,
    dlugosc NUMBER(1) CONSTRAINT MYSZY_DLUGOSC_CHECK CHECK(DLUGOSC BETWEEN 0 AND 5) CONSTRAINT MYSZY_DLUGOSC_NN NOT NULL,
    data_upolowania DATE CONSTRAINT MYSZY_UPOLOWANIA_NN NOT NULL,
    data_wydania DATE,
    pseudo_lapacza VARCHAR2(15) CONSTRAINT MYSZY_LAPACZ_NN NOT NULL CONSTRAINT MYSZY_LAPACZ_FK REFERENCES Koty(pseudo),
    pseudo_zjadacza VARCHAR2(15) CONSTRAINT MYSZY_ZJADACZ_FK REFERENCES Koty(pseudo),
    CONSTRAINT MYSZY_DATA_CHECK CHECK(DATA_WYDANIA>=DATA_UPOLOWANIA)
);

CREATE TABLE Bandy(
    nr_bandy NUMBER(6) CONSTRAINT BANDY_PK PRIMARY KEY,
    teren VARCHAR2(15) CONSTRAINT BANDY_TEREN_NN NOT NULL,
    nazwa VARCHAR2(15) CONSTRAINT BANDY_NAZWA_NN NOT NULL,
    szef_bandy VARCHAR2(15) CONSTRAINT BANDY_SZEF_FK REFERENCES Koty(PSEUDO)
);

CREATE TABLE Wrogowie(
    imie VARCHAR2(15) CONSTRAINT WROGOWIE_IMIE_PK PRIMARY KEY,
    gatunek VARCHAR2(15),
    stopien_wrogosci NUMBER(2) CONSTRAINT WROGOWIE_WROGOSC_NN NOT NULL 
                               CONSTRAINT WROGOWIE_WROGOSC_CHECK CHECK(STOPIEN_WROGOSCI BETWEEN 1 AND 10)
);

CREATE TABLE Lapowki (
    lapowka VARCHAR2(15) CONSTRAINT LAPOWKI_LAPOWKA_PK PRIMARY KEY
);



CREATE TABLE Incydenty (
    data_incydentu DATE CONSTRAINT INCYDENTY_DATA_NN NOT NULL,
    opis VARCHAR2(30) CONSTRAINT INCYDENTY_OPIS_NN NOT NULL,
    pseudo_kota VARCHAR2(15) CONSTRAINT INCYDENTY_KOT_NN NOT NULL
                             CONSTRAINT INCYDENTY_KOT_FK REFERENCES Koty(PSEUDO),
    imie VARCHAR2(15) CONSTRAINT INCYDENTY_WROG_NN NOT NULL 
                      CONSTRAINT INCYDENTY_IMIE_FK REFERENCES Wrogowie(IMIE)
);

ALTER TABLE Incydenty ADD CONSTRAINT INCYDENTY_PK PRIMARY KEY(pseudo_kota, imie);

CREATE TABLE Lapowki_wrogow (
    imie VARCHAR2(15) CONSTRAINT LW_IMIE_FK REFERENCES WROGOWIE(IMIE),
    lapowka VARCHAR2(30) CONSTRAINT LW_LAPOWKA_FK REFERENCES Lapowki(lapowka),
    CONSTRAINT LW_PK PRIMARY KEY(imie, lapowka)
);


-- PO POLSKU

INSERT ALL
INTO Funkcje VALUES ('Lowca', 5, 10)
INTO Funkcje VALUES ('Straznik', 3, 7)
INTO Funkcje VALUES ('Zwiadowca', 1, 4)
INTO Funkcje VALUES ('Rybak', 2, 6)
INTO Funkcje VALUES ('Sledzacy', 4, 8)
INTO Funkcje VALUES ('Patrolujacy', 3, 6)
INTO Funkcje VALUES ('Zabojca', 7, 10)
INTO Funkcje VALUES ('Pracz', 2, 5)
INTO Funkcje VALUES ('Wojownik', 6, 9)
INTO Funkcje VALUES ('Strazak', 4, 7)
SELECT * FROM Dual;


INSERT ALL
INTO Koty VALUES ('Tygrys', 'M', '01.01.2020', 5, null, 1, 'Lowca')
INTO Koty VALUES ('Simba', 'M', '01.02.2022', 2, 'Tygrys', 2, 'Straznik')
INTO Koty VALUES ('Mittens', 'K', '01.03.2022', 3, 'Tygrys', 1, 'Straznik')
INTO Koty VALUES ('Fluffy', 'K', '01.04.2022', 4, 'Tygrys', 3, 'Lowca')
INTO Koty VALUES ('Nala', 'K', '01.05.2022', 3, 'Tygrys', 1, 'Wojownik')
INTO Koty VALUES ('Luna', 'K', '01.06.2022', 2, 'Tygrys', 4, 'Sledzacy')
INTO Koty VALUES ('Oliver', 'M', '01.07.2022', 5, 'Tygrys', 1, 'Zwiadowca')
INTO Koty VALUES ('Johny', 'M', '01.08.2022', 3, 'Simba', 2, 'Rybak')
INTO Koty VALUES ('Garfield', 'M', '01.09.2022', 4, 'Tygrys', 1, 'Patrolujacy')
INTO Koty VALUES ('Socks', 'M', '01.10.2022', 2, 'Simba', 2, 'Zabojca')
SELECT * FROM Dual;

INSERT ALL
INTO Bandy VALUES (1, 'Dzungla', 'Dziki', 'Tygrys')
INTO Bandy VALUES (2, 'Pustynia', 'Piasek', 'Simba')
INTO Bandy VALUES (3, 'Góra', 'Urwisko', 'Fluffy')
INTO Bandy VALUES (4, 'Las', 'Zielony', 'Luna')
INTO Bandy VALUES (5, 'Step', '�?ąka', NULL)
INTO Bandy VALUES (6, 'Tundra', 'Mroźny', NULL)
INTO Bandy VALUES (7, 'Bagno', 'Błoto', NULL)
INTO Bandy VALUES (8, 'Jaskinia', 'Ciemno', NULL)
INTO Bandy VALUES (9, 'Plaża', 'Piasek', NULL)
INTO Bandy VALUES (10, 'Rzeka', 'Woda', NULL)
SELECT * FROM Dual;

INSERT ALL
INTO Myszy VALUES (1, 5, 2, '01.01.2022', '02.01.2022', 'Tygrys', 'Simba')
INTO Myszy VALUES (2, 7, 3, '03.01.2022', '04.01.2022', 'Fluffy', 'Nala')
INTO Myszy VALUES (3, 3, 1, '05.01.2022', '06.01.2022', 'Mittens', 'Tygrys')
INTO Myszy VALUES (4, 8, 4, '07.01.2022', '08.01.2022', 'Simba', 'Fluffy')
INTO Myszy VALUES (5, 2, 1, '09.01.2022', '10.01.2022', 'Nala', 'Mittens')
INTO Myszy VALUES (6, 9, 2, '11.01.2022', '12.01.2022', 'Luna', 'Tygrys')
INTO Myszy VALUES (7, 4, 3, '13.01.2022', '14.01.2022', 'Oliver', 'Simba')
INTO Myszy VALUES (8, 6, 1, '15.01.2022', '16.01.2022', 'Johny', 'Nala')
INTO Myszy VALUES (9, 1, 2, '17.01.2022', '18.01.2022', 'Garfield', 'Fluffy')
INTO Myszy VALUES (10, 5, 3, '19.01.2022', '20.01.2022', 'Socks', 'Mittens')
SELECT * FROM Dual;

INSERT ALL
INTO Wrogowie VALUES ('Lis', 'Canidae', 8)
INTO Wrogowie VALUES ('Sowa', 'Strigiformes', 5)
INTO Wrogowie VALUES ('Szop', 'Procyonidae', 7)
INTO Wrogowie VALUES ('Skunks', 'Mephitidae', 9)
INTO Wrogowie VALUES ('Kojot', 'Canidae', 6)
INTO Wrogowie VALUES ('Niedzwiedz', 'Ursidae', 10)
INTO Wrogowie VALUES ('Wilk', 'Canidae', 8)
INTO Wrogowie VALUES ('Jastrzab', 'Accipitridae', 4)
INTO Wrogowie VALUES ('Wydra', 'Mustelidae', 7)
INTO Wrogowie VALUES ('Kruk', 'Corvidae', 6)
SELECT * FROM Dual;

INSERT ALL
INTO Lapowki VALUES ('Pierze')
INTO Lapowki VALUES ('Ogon myszy')
INTO Lapowki VALUES ('Ogon szczura')
INTO Lapowki VALUES ('Ogon wiewiorki')
INTO Lapowki VALUES ('Skrzydlo ptaka')
INTO Lapowki VALUES ('Luski ryby')
INTO Lapowki VALUES ('Nogi zaba')
INTO Lapowki VALUES ('Pajeczyna')
INTO Lapowki VALUES ('Skrzydla motyla')
INTO Lapowki VALUES ('Skrzydla wazki');
INTO Lapowki VALUES ('Kosc')
INTO Lapowki VALUES ('Kwiatek')
SELECT * FROM Dual;

INSERT ALL
INTO Lapowki_wrogow VALUES ('Lis', 'Pierze')
INTO Lapowki_wrogow VALUES ('Sowa', 'Ogon myszy')
INTO Lapowki_wrogow VALUES ('Szop', 'Ogon szczura')
INTO Lapowki_wrogow VALUES ('Skunks', 'Ogon wiewiorki')
INTO Lapowki_wrogow VALUES ('Kojot', 'Skrzydlo ptaka')
INTO Lapowki_wrogow VALUES ('Niedzwiedz', 'Luski ryby')
INTO Lapowki_wrogow VALUES ('Wilk', 'Nogi zaba')
INTO Lapowki_wrogow VALUES ('Jastrzab','Pajeczyna')
INTO Lapowki_wrogow VALUES ('Wydra','Skrzydla motyla')
INTO Lapowki_wrogow VALUES ('Kruk','Skrzydla wazki')
SELECT * FROM Dual;


INSERT ALL
INTO Incydenty VALUES ('01.01.2023', 'Wtargnal na jego terytorium.', 'Tygrys', 'Lis')
INTO Incydenty VALUES ('02.01.2023', 'Zagrozila jego rodzinie.', 'Simba', 'Sowa')
INTO Incydenty VALUES ('03.01.2023', 'Zabral jedzenie z jego miski.', 'Fluffy', 'Szop')
INTO Incydenty VALUES ('04.01.2023', 'Zaatakowal spokoj w okolicy.', 'Mittens', 'Skunks')
INTO Incydenty VALUES ('05.01.2023', 'Probowal ukrasc jego mysz', 'Nala', 'Kojot')
INTO Incydenty VALUES ('06.01.2023', 'Dokonal zbrodni niewybaczalnej', 'Luna', 'Niedzwiedz')
INTO Incydenty VALUES ('07.01.2023', 'Straszyl go', 'Oliver', 'Wilk')
INTO Incydenty VALUES ('08.01.2023', 'Zabral mu jedzenie', 'Luna', 'Jastrzab')
INTO Incydenty VALUES ('09.01.2023', 'Zabral mu rybe', 'Garfield', 'Wydra')
INTO Incydenty VALUES ('10.01.2023', 'Nadepnal mu na ogon', 'Socks', 'Kruk')
SELECT * FROM Dual;



ALTER session set NLS_DATE_FORMAT= 'DD.MM.YYYY';


--Pojedyncze relacje
--Wyswietl koty, ktore dzieki swojej funkcji maja przydzial myszy wiekszy niz 3
SELECT pseudo "Kot", nazwa_funkcji "Funkcja" 
FROM Koty 
WHERE PRZYDZIAL_MYSZY > 3;

--Ustal jaka plec ma srednio wiekszy przydzial mysszy
SELECT plec "Plec", AVG(przydzial_myszy) "Sredni przydzial"
FROM Koty
GROUP BY plec;

--Wyswietl koty ktore pobraly myszy wiecej niz 1 raz
SELECT pseudo_zjadacza "Kot", COUNT(pseudo_zjadacza) "Ile razy jadl"
FROM Myszy
GROUP BY pseudo_zjadacza
HAVING COUNT(pseudo_zjadacza)>=1;


--JOIN
--Wyswietl bandy aktualnie posiadajace obsade oraz ich szefow
SELECT B.nazwa "Nazwa", K.pseudo "Szef" 
FROM Bandy B JOIN Koty K ON B.SZEF_BANDY = K.PSEUDO;

--Wyswietl srednia wage myszy lapanych przez wszystkie funkcje uporzadkowane malejaco
SELECT F.nazwa_funkcji "Funkcja", NVL(TO_CHAR(AVG(M.waga)), 'brak myszy')"Srednia waga"
FROM Koty K JOIN Myszy M ON K.pseudo = M.pseudo_lapacza RIGHT JOIN Funkcje F ON K.nazwa_funkcji = F.nazwa_funkcji
GROUP BY  F.nazwa_funkcji
ORDER BY 2 DESC;

--Wyswietl jacy wrogowie atakowali  poszczegolne bandy
SELECT B.nazwa "Banda", W.imie "Wrog"
FROM Wrogowie W
JOIN Incydenty I ON I.imie = W.imie
JOIN Koty K ON K.pseudo = I.pseudo_kota
JOIN Bandy B ON B.nr_bandy = K.nr_bandy
GROUP BY B.nazwa, W.imie
ORDER BY 1;


--PODZAPYTANIA
--Wyswietl nieuzyte /niepreferowane lapowki
SELECT lapowka
FROM lapowki
WHERE lapowka NOT IN (SELECT lapowka
                      FROM Lapowki_wrogow);
                      
                      
--Wyswietl wszystkie incydenty kotow, ktore braly w nich udzial w wiecej niz 2 razy oraz lapowki jakimi przekupili wrogow
SELECT K.pseudo "Kot", I.imie "Wrog", I.opis "Opis", L.lapowka "Karta przetargowa"
FROM Koty K JOIN Incydenty I ON K.pseudo = I.pseudo_kota JOIN Lapowki_wrogow L ON L.imie = I.imie
WHERE K.pseudo IN (SELECT pseudo_kota 
                   FROM Incydenty 
                   GROUP BY pseudo_kota
                   HAVING COUNT(pseudo_kota)>=2);

                   
--Wyswietl koty, ktore weszly swietnie w nowy rok 2022 i w 10 dni zlapaly mysz oraz sa z bandy tygrysa
SELECT pseudo "Kot", NR_BANDY "Banda"
FROM Koty
WHERE nr_bandy = (SELECT nr_bandy 
                  FROM Koty 
                  WHERE pseudo='Tygrys') 
AND pseudo IN (SELECT pseudo_lapacza 
               FROM Myszy 
               WHERE data_upolowania BETWEEN '01.01.2022' AND '10.01.2022');



