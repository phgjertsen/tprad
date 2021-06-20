CREATE OR REPLACE PROCEDURE tprad_nullstill_resultat_liste
--*****************************************************************************
-- Modul       : FORS - Oppgave 2
-- Type        : PL/SQL - Prosedyre
-- Filnavn     : tprad_nullstill_resultat_liste.prc
-- Skrevet av  : P�l Hermann Gjertsen
-- Versjon     : 1.0
-- Beskrivelse : Prosedyre som t�mmer tabellen tprad_resultat_liste
--
-- *****************************************************************************
-- -----------------------------------------------------------------------------
-- Endringslogg
-- 2021.06.15 P�l Hermann Gjertsen Opprettet 
-- -----------------------------------------------------------------------------

AS
BEGIN
   EXECUTE IMMEDIATE 'truncate table tprad_resultat_liste';
END;
/

