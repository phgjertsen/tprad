/* Formatted on 2021/06/20 13:57 (Formatter Plus v4.8.8) */
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