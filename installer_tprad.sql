BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE tprad_brett CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

--------------------------------------------------------------------------------

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE tprad_resultat_liste CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

--------------------------------------------------------------------------------

CREATE TABLE tprad_brett
(
  rad  INTEGER                                  NOT NULL,
  a    VARCHAR2(1 BYTE),
  b    VARCHAR2(1 BYTE),
  c    VARCHAR2(1 BYTE)
)
TABLESPACE users
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
MONITORING;

/

CREATE TABLE tprad_resultat_liste
(
  resultat  VARCHAR2(1 BYTE)
)
TABLESPACE apps_ts_tx_data
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
MONITORING;

/

CREATE or replace PROCEDURE tprad_skriv_ut_brett

--*****************************************************************************
-- Modul       : FORS - Oppgave 2
-- Type        : PL/SQL - Procedyre
-- Filnavn     : tprad_skriv_ut_brett.prc
-- Skrevet av  : Pål Hermann Gjertsen
-- Versjon     : 0.9
-- Beskrivelse : Prosedyre som skriver ut innholdet i tabellen tprad_bett
--
-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- Endringslogg
-- 2021.06.15 Pål Hermann Gjertsen Opprettet 
-- -----------------------------------------------------------------------------

AS

BEGIN
   DBMS_OUTPUT.ENABLE;
   DBMS_OUTPUT.put_line ('-------------------------------------');
   DBMS_OUTPUT.put_line ('RAD ' || ' A ' || ' B ' || ' C ');
   FOR v_rec IN (SELECT rad, a, b, c
                   FROM tprad_brett)
   LOOP
     
      DBMS_OUTPUT.put_line (v_rec.rad || '    ' || v_rec.a || '  ' || v_rec.b || '  '|| v_rec.c);
   END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE tprad_nullstill_brett
--*****************************************************************************
-- Modul       : FORS - Oppgave 2
-- Type        : PL/SQL - Prosedyre
-- Filnavn     : tprad_nullstill_brett.prc
-- Skrevet av  : Pål Hermann Gjertsen
-- Versjon     : 1.0
-- Beskrivelse : Prosedyre som tømmer tabellen tprad_brett
--
-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- Endringslogg
-- 2021.06.15 Pål Hermann Gjertsen Opprettet 
-- -----------------------------------------------------------------------------
AS
BEGIN
   EXECUTE IMMEDIATE 'truncate table tprad_brett';

   INSERT INTO tprad_brett
        VALUES (1, ' ', ' ', ' ');

   INSERT INTO tprad_brett
        VALUES (2, ' ', ' ', ' ');

   INSERT INTO tprad_brett
        VALUES (3, ' ', ' ', ' ');
END;
/

CREATE OR REPLACE PROCEDURE tprad_nullstill_resultat_liste
--*****************************************************************************
-- Modul       : FORS - Oppgave 2
-- Type        : PL/SQL - Prosedyre
-- Filnavn     : tprad_nullstill_resultat_liste.prc
-- Skrevet av  : Pål Hermann Gjertsen
-- Versjon     : 1.0
-- Beskrivelse : Prosedyre som tømmer tabellen tprad_resultat_liste
--
-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- Endringslogg
-- 2021.06.15 Pål Hermann Gjertsen Opprettet 
-- -----------------------------------------------------------------------------

AS
BEGIN
   EXECUTE IMMEDIATE 'truncate table tprad_resultat_liste';
END;
/

CREATE OR REPLACE PROCEDURE tprad_spill_brett_trekk (v_spiller IN VARCHAR2)
--*****************************************************************************
-- Modul       : FORS - Oppgave 2
-- Type        : PL/SQL - Prosedyre
-- Filnavn     : tprad_spill_brett_trekk.prc
-- Skrevet av  : Pål Hermann Gjertsen
-- Versjon     : 0.9
-- Beskrivelse : Procedyre som simulerer en datamaskin eller bruker som spiller,
--               setter en X eller O inn i tabellen tprad_brett

-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- Endringslogg
-- 2021.06.15 Pål Hermann Gjertsen: Opprettet
-- -----------------------------------------------------------------------------
AS
   v_rad            INTEGER     (1) ; -- raden i brettet
   v_temp           INTEGER     (1) ; -- hjelpevariable for å velge kolonne 
   v_kolonne        VARCHAR2    (1) ; -- kolonnen i brettet
   v_brikke         VARCHAR2    (1) ; -- verdien av rute i brettet 
   v_brett_fylt     BOOLEAN := FALSE; -- angir om procedyren har utført et trekk

BEGIN
   WHILE v_brett_fylt = FALSE
   LOOP
      SELECT TRUNC (DBMS_RANDOM.VALUE (1, 4))
        INTO v_rad
        FROM DUAL;

      SELECT TRUNC (DBMS_RANDOM.VALUE (1, 4))
        INTO v_temp
        FROM DUAL;

      IF v_temp = 1
      THEN
         v_kolonne := 'A';
      ELSIF v_temp = 2
      THEN
         v_kolonne := 'B';
      ELSE
         v_kolonne := 'C';
      END IF;

      IF v_kolonne = 'A'
      THEN
         SELECT a
           INTO v_brikke
           FROM tprad_brett
          WHERE rad = v_rad;
      ELSIF v_kolonne = 'B'
      THEN
         SELECT b
           INTO v_brikke
           FROM tprad_brett
          WHERE rad = v_rad;
      ELSE
         SELECT c
           INTO v_brikke
           FROM tprad_brett
          WHERE rad = v_rad;
      END IF;

      IF v_brikke = ' '
      THEN
         IF (v_kolonne) = 'A'
         THEN
            UPDATE tprad_brett
               SET a = v_spiller
             WHERE rad = v_rad;

            v_brett_fylt := TRUE;
         END IF;

         IF (v_kolonne) = 'B'
         THEN
            UPDATE tprad_brett
               SET b = v_spiller
             WHERE rad = v_rad;

            v_brett_fylt := TRUE;
         END IF;

         IF (v_kolonne) = 'C'
         THEN
            UPDATE tprad_brett
               SET c = v_spiller
             WHERE rad = v_rad;

            v_brett_fylt := TRUE;
         END IF;
      END IF;
   END LOOP;

   COMMIT;
END tprad_spill_brett_trekk;
/

CREATE OR REPLACE PROCEDURE tprad_sjekk_vinner (spill_status out VARCHAR2) 

--*****************************************************************************
-- Modul       : FORS - Oppgave 2
-- Type        : PL/SQL - Prosedyre
-- Filnavn     : tprad_sjekk_vinner.prc
-- Skrevet av  : Pål Hermann Gjertsen
-- Versjon     : 1.0
-- Beskrivelse : Procedyren sjekker om det er en vinner av spillet og oppdaterer 
--               resultat liste. Procedyren har en ut parameter som kan ha følgende
--               verdier: X: Vinneren av brettet er X
--                        O: Vinneren av brettet er O
--                        P: Runden er ikke avgjort, spillet pågår
--                        U: Brettet er fullt, men ingen vinner, uavgjort                 
--
-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- Endringslogg
-- 2021.06.15 Pål Hermann Gjertsen Opprettet 
-- -----------------------------------------------------------------------------

AS

   a1   VARCHAR2 (1);
   a2   VARCHAR2 (1);
   a3   VARCHAR2 (1);
   b1   VARCHAR2 (1);
   b2   VARCHAR2 (1);
   b3   VARCHAR2 (1);
   c1   VARCHAR2 (1);
   c2   VARCHAR2 (1);
   c3   VARCHAR2 (1);

BEGIN

   DBMS_OUTPUT.ENABLE;
   SELECT a INTO a1 FROM tprad_brett WHERE rad = 1;
   SELECT a INTO a2 FROM tprad_brett WHERE rad = 2;
   SELECT a INTO a3 FROM tprad_brett WHERE rad = 3;
   SELECT b INTO b1 FROM tprad_brett WHERE rad = 1;
   SELECT b INTO b2 FROM tprad_brett WHERE rad = 2;
   SELECT b INTO b3 FROM tprad_brett WHERE rad = 3;
   SELECT c INTO c1 FROM tprad_brett WHERE rad = 1;
   SELECT c INTO c2 FROM tprad_brett WHERE rad = 2;
   SELECT c INTO c3 FROM tprad_brett WHERE rad = 3;

-- sjekk horisentale vinnere

   IF a1 = b1 AND b1 = c1 AND c1 != ' ' 
   THEN     tprad_skriv_ut_brett;
   DBMS_OUTPUT.put_line ('Vinner av denne runden er ' || a1 || ' på rad 1');
   spill_status := a1;
   insert into tprad_resultat_liste values(a1);
   
   ELSIF a2 = b2 AND b2 = c2 AND c2 != ' ' 
   THEN     tprad_skriv_ut_brett;
   DBMS_OUTPUT.put_line ('Vinner av denne runden er ' || a2 || ' på rad 2');
   spill_status := a2;
   insert into tprad_resultat_liste values(a2);
   
   ELSIF a3 = b3 AND b3 = c3 AND c3 != ' ' 
   THEN  tprad_skriv_ut_brett; 
   DBMS_OUTPUT.put_line ('Vinner av denne runden er ' || a3 || ' på rad 3');
   spill_status := a3;
   insert into tprad_resultat_liste values(a3);
   
-- sjekk vertikale vinnere 
   
   ELSIF a1 = a2 AND a2 = a3 AND a3 != ' ' 
   THEN     tprad_skriv_ut_brett;
   DBMS_OUTPUT.put_line ('Vinner av denne runden er ' || a3 || ' i kolonne A');
   spill_status := a3;
   insert into tprad_resultat_liste values(a3);     
   
   ELSIF b1 = b2 AND b2 = b3 AND b3 != ' ' 
   THEN     tprad_skriv_ut_brett;
   DBMS_OUTPUT.put_line ('Vinner av denne runden er ' || b3 || ' i kolonne B');
   spill_status := b3;
   insert into tprad_resultat_liste values(b3);
   
   ELSIF c1 = c2 AND c2 = c3 AND c3 != ' ' 
   THEN     tprad_skriv_ut_brett;
   DBMS_OUTPUT.put_line ('Vinner av denne runden er ' || c3 || ' i kolonne C');
   spill_status := c3;
   insert into tprad_resultat_liste values(c3);
   
-- sjekk vinnere på skrå
   
   ELSIF a1 = b2 AND b2 = c3 AND c3 != ' ' 
   THEN     tprad_skriv_ut_brett;
   DBMS_OUTPUT.put_line ('Vinner av denne runden er ' || c3 || ' på skrå nedover fra A1 til C3');
   spill_status := c3;
   insert into tprad_resultat_liste values(c3);
   
   ELSIF a3 = b2 AND b2 = c1 AND c1 != ' ' 
   THEN     tprad_skriv_ut_brett;
   DBMS_OUTPUT.put_line ('Vinner av denne runden er ' || c1 || ' på skrå oppover fra A3 til C1');
   spill_status := c1;
   insert into tprad_resultat_liste values(c1);
      
   ELSIF a1=' ' or a2=' ' or a3=' ' or b1=' ' or b2=' ' or b3=' ' or c1=' ' or c2=' '
   THEN 
   --tprad_skriv_ut_brett;
   --DBMS_OUTPUT.put_line ('Spillet pågår, ingen vinner så langt');
   spill_status := 'P';
   
   ELSE     tprad_skriv_ut_brett;
   DBMS_OUTPUT.put_line ('Denne runden er slutt, ingen vinner');
   spill_status := 'U';
   insert into tprad_resultat_liste values('U');

   END IF;

--COMMIT;

END tprad_sjekk_vinner;

/

CREATE OR REPLACE PROCEDURE tprad_skriv_ut_resultat_liste
--*****************************************************************************
-- Modul       : FORS - Oppgave 2
-- Type        : PL/SQL - Prosedyre
-- Filnavn     : tprad_skriv_ut_resultat_liste.prc
-- Skrevet av  : Pål Hermann Gjertsen
-- Versjon     : 0.9
-- Beskrivelse :
--
-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- Endringslogg
-- 2021.06.15 Pål Hermann Gjertsen Opprettet 
-- -----------------------------------------------------------------------------

AS
   v_antall_seier_x   INTEGER (2) := 0;
   v_antall_seier_o   INTEGER (2) := 0;
   v_antall_seier_u   INTEGER (2) := 0;
BEGIN
   DBMS_OUTPUT.ENABLE;

   SELECT COUNT (1)
     INTO v_antall_seier_x
     FROM tprad_resultat_liste
    WHERE resultat = 'X';

   SELECT COUNT (1)
     INTO v_antall_seier_o
     FROM tprad_resultat_liste
    WHERE resultat = 'O';

   SELECT COUNT (1)
     INTO v_antall_seier_u
     FROM tprad_resultat_liste
    WHERE resultat = 'U';
   DBMS_OUTPUT.put_line ('---------------------------------------------');
   DBMS_OUTPUT.put_line ('-');
   DBMS_OUTPUT.put_line ('-');
   DBMS_OUTPUT.put_line ('Runder vunnet av X    : ' || v_antall_seier_x);
   DBMS_OUTPUT.put_line ('Runder vunnet av O    : ' || v_antall_seier_o);
   DBMS_OUTPUT.put_line ('Antall runder uavgjort: ' || v_antall_seier_u);
END tprad_skriv_ut_resultat_liste;

/

CREATE OR REPLACE PROCEDURE tprad_spill
--*****************************************************************************
-- Modul       : FORS - Oppgave 2
-- Type        : PL/SQL - Prosedyre
-- Filnavn     : trad_tpsill.prc
-- Skrevet av  : Pål Hermann Gjertsen
-- Versjon     : 0.9
-- Beskrivelse : Hovedprosedyre for spillet Tre på rad (tprad)
--
-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- Endringslogg
-- 2021.06.15 Pål Hermann Gjertsen: Opprettet
-- -----------------------------------------------------------------------------
AS
   v_spill_status    VARCHAR2 (1) := 'P'; -- status på brettet, pågår, vunnet, uavgjort
   v_antall_runder   INTEGER      := 10 ; -- antall runder det skal spilles
   v_runde_nr        INTEGER      := 1  ; -- runde nr
   v_spillers_tur    VARCHAR2 (1) := 'O'; -- hvem som skal begynne
BEGIN
   tprad_nullstill_resultat_liste;
   DBMS_OUTPUT.ENABLE;

   WHILE v_runde_nr <= v_antall_runder
   LOOP
      tprad_nullstill_brett;

      WHILE v_spill_status = 'P'
      LOOP
            tprad_spill_brett_trekk (v_spillers_tur);
            tprad_sjekk_vinner (v_spill_status);

         IF v_spillers_tur = 'O'
         THEN
            v_spillers_tur := 'X';
         ELSE
            v_spillers_tur := 'O';
         END IF;
      END LOOP;

      v_spill_status := 'P';
      v_runde_nr := v_runde_nr + 1;
   END LOOP;

   tprad_skriv_ut_resultat_liste;
   
END;
/


