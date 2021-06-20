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