CREATE OR REPLACE PROCEDURE tprad_spill_brett_trekk (v_spiller IN VARCHAR2)
--*****************************************************************************
-- Modul       : FORS - Oppgave 2
-- Type        : PL/SQL - Prosedyre
-- Filnavn     : tprad_spill_brett_trekk.prc
-- Skrevet av  : Pål Hermann Gjertsen
-- Versjon     : 0.9
-- Beskrivelse : Procedyre som simulerer en datamaskin eller bruker om spiller,
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