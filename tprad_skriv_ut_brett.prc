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

