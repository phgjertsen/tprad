CREATE OR REPLACE PROCEDURE tprad_nullstill_brett
--*****************************************************************************
-- Modul       : FORS - Oppgave 2
-- Type        : PL/SQL - Prosedyre
-- Filnavn     : tprad_nullstill_brett.prc
-- Skrevet av  : P�l Hermann Gjertsen
-- Versjon     : 1.0
-- Beskrivelse : Prosedyre som t�mmer tabellen tprad_brett
--
-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- Endringslogg
-- 2021.06.15 P�l Hermann Gjertsen Opprettet 
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