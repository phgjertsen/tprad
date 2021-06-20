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