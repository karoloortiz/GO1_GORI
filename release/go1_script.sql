CREATE TABLE `go1tmodula` (
	`ID` ENUM('1') NOT NULL COLLATE 'utf8_bin',
	`server` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_bin',
	`porta` SMALLINT NULL DEFAULT NULL COLLATE 'utf8_bin',
	`username` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_bin',
	`password` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_bin',
	PRIMARY KEY (`ID`) USING BTREE
)
COMMENT='Tabella definizione impostazioni magazzino Modula'
COLLATE='utf8_bin'
ENGINE=InnoDB
;

#INSERT INTO `go1tmodula` (`ID`, `server`, `porta`, `username`, `password`) VALUES ('1', '192.168.1.125', 1433, 'sa', 'masterkey');

CREATE TABLE `go1espmodula` (
	`ID` ENUM('1') NOT NULL COLLATE 'utf8_bin',
	`data_ultimo_aggiornamento_art` DATETIME NULL DEFAULT NULL,
	`data_ultimo_aggiornamento_giacenze` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`ID`) USING BTREE
)
COMMENT='Tabella log esportazione magazzino Modula'
COLLATE='utf8_bin'
ENGINE=INNODB
;

CREATE TABLE `go1_modula_invio` (
	`ID` INT(11) NOT NULL AUTO_INCREMENT,
	`TABELLA` ENUM('VER','OVR','OAR','FVR','DVR') NOT NULL COLLATE 'utf8_bin',
	`PROGRESSIVO` INT(11) NOT NULL DEFAULT '0',
	`RIGA` INT(11) NULL DEFAULT '0',
	quantita_inviata DECIMAL(18,6) NULL DEFAULT '0.000000',
	PRIMARY KEY (`ID`) USING BTREE,
	UNIQUE INDEX `CODICE` (`TABELLA`,`PROGRESSIVO`, `RIGA`) USING BTREE
)
COMMENT='Tabella quantità righe documenti da inviare a Modula'
COLLATE='utf8_bin'
ENGINE=INNODB
;

ALTER TABLE tub add COLUMN go1_modula ENUM('no','si') DEFAULT 'no';

INSERT INTO ARC.prg (`ID`, `codice`, `DESCRIZIONE`, `ESEGUIBILE_MENU`, `UTENTE`, `DATA_ORA`, `MODULO`, `RECORD_STANDARD`, `PROGRAMMA_ESTERNO`, `LEVEL_CODE`, `PROGRAMMA_STAMPA`, `STAMPA_PARAMETRI_SELEZIONE`, `IMMAGINE_MENU`, `UTENTE_CREAZIONE`, `DATA_ORA_CREAZIONE`, `ESEGUIBILE`, `MODULO_DARWIN`, `testo_query`, `programma_foxg`, `descrizione_cinese`, `versione_easy`) VALUES (76578, 'GO1ESPMODULA', 'GO1 Esportazione modula', 'programma', 'GO', '2021-09-14 09:26:31', 0, 'no', '', '0', 'no', 'no', 0, 'GO', '2021-09-14 09:26:31', 'si', '', NULL, 'no', '', 'no');
INSERT INTO ARC.prg (`ID`, `codice`, `DESCRIZIONE`, `ESEGUIBILE_MENU`, `UTENTE`, `DATA_ORA`, `MODULO`, `RECORD_STANDARD`, `PROGRAMMA_ESTERNO`, `LEVEL_CODE`, `PROGRAMMA_STAMPA`, `STAMPA_PARAMETRI_SELEZIONE`, `IMMAGINE_MENU`, `UTENTE_CREAZIONE`, `DATA_ORA_CREAZIONE`, `ESEGUIBILE`, `MODULO_DARWIN`, `testo_query`, `programma_foxg`, `descrizione_cinese`, `versione_easy`) VALUES (76577, 'GO1GESTMODULA', 'GO1 Gestione tabella parametri modula', 'programma', 'GO', '2021-09-14 09:21:26', 0, 'no', '', '0', 'no', 'no', 0, 'GO', '2021-09-14 09:21:26', 'si', '', NULL, 'no', '', 'no');
INSERT INTO ARC.prg (`ID`, `codice`, `DESCRIZIONE`, `ESEGUIBILE_MENU`, `UTENTE`, `DATA_ORA`, `MODULO`, `RECORD_STANDARD`, `PROGRAMMA_ESTERNO`, `LEVEL_CODE`, `PROGRAMMA_STAMPA`, `STAMPA_PARAMETRI_SELEZIONE`, `IMMAGINE_MENU`, `UTENTE_CREAZIONE`, `DATA_ORA_CREAZIONE`, `ESEGUIBILE`, `MODULO_DARWIN`, `testo_query`, `programma_foxg`, `descrizione_cinese`, `versione_easy`) VALUES (76574, 'GO1GESORDAFRN', 'GO1 Gestione ordini acquisto fornitore', 'programma', 'GO', '2021-09-14 09:19:42', 0, 'no', '', '0', 'no', 'no', 0, 'GO', '2021-09-14 09:19:42', 'si', '', NULL, 'no', '', 'no');
INSERT INTO ARC.prg (`ID`, `codice`, `DESCRIZIONE`, `ESEGUIBILE_MENU`, `UTENTE`, `DATA_ORA`, `MODULO`, `RECORD_STANDARD`, `PROGRAMMA_ESTERNO`, `LEVEL_CODE`, `PROGRAMMA_STAMPA`, `STAMPA_PARAMETRI_SELEZIONE`, `IMMAGINE_MENU`, `UTENTE_CREAZIONE`, `DATA_ORA_CREAZIONE`, `ESEGUIBILE`, `MODULO_DARWIN`, `testo_query`, `programma_foxg`, `descrizione_cinese`, `versione_easy`) VALUES (76573, 'GO1GESORDVCL', 'GO1 Gestione ordini vendita clienti', 'programma', 'GO', '2021-09-14 09:19:10', 0, 'no', '', '0', 'no', 'no', 0, 'GO', '2021-09-14 09:19:10', 'si', '', NULL, 'no', '', 'no');

INSERT INTO ARC.prg (`ID`, `codice`, `DESCRIZIONE`, `ESEGUIBILE_MENU`, `UTENTE`, `DATA_ORA`, `MODULO`, `RECORD_STANDARD`, `PROGRAMMA_ESTERNO`, `LEVEL_CODE`, `PROGRAMMA_STAMPA`, `STAMPA_PARAMETRI_SELEZIONE`, `IMMAGINE_MENU`, `UTENTE_CREAZIONE`, `DATA_ORA_CREAZIONE`, `ESEGUIBILE`, `MODULO_DARWIN`, `testo_query`, `programma_foxg`, `descrizione_cinese`, `versione_easy`) VALUES (76575, 'GO1GESTUB', 'GO1 Gestione ubicazione', 'programma', 'GO', '2021-09-14 09:20:15', 0, 'no', '', '0', 'no', 'no', 0, 'GO', '2021-09-14 09:20:15', 'si', '', NULL, 'no', '', 'no');
INSERT INTO ARC.pra (`ID`, `CODICE`, `prg_codice`, `UTENTE`, `DATA_ORA`, `RECORD_STANDARD`, `UTENTE_CREAZIONE`, `DATA_ORA_CREAZIONE`) VALUES (1, 'GESTUB', 'GO1GESTUB', 'GO', '2021-09-14 09:35:02', 'no', 'GO', '2021-09-14 09:35:02');


ALTER TABLE ovr add COLUMN go1_modula_sospeso ENUM('no','si') DEFAULT 'no';

ALTER TABLE oar ADD COLUMN go1_modula_quantita_da_inviare DECIMAL(18,6) NULL DEFAULT '0.000000';

CREATE TABLE `go1_modula_SYSTOREDB_dbo_DAT_SCOMPART` (
	`SCO_ARTICOLO` VARCHAR(50) NOT NULL COLLATE 'utf8_bin',
	`SCO_GIAC` DECIMAL(18,6) NULL DEFAULT '0.000000',
	`SCO_LIM` DECIMAL(18,6) NULL DEFAULT '0.000000',
	`SCO_CAP` DECIMAL(18,6) NULL DEFAULT '0.000000'
)
COMMENT='Tabella Modula SYSTOREDB.dbo.DAT_SCOMPART'
COLLATE='utf8_bin'
ENGINE=INNODB
;

CREATE TABLE `go1_modula_SYSTOREDB_dbo_DAT_ARTICOLI` (
	`ART_ARTICOLO` VARCHAR(50) NOT NULL COLLATE 'utf8_bin',
	`ART_SOTTOSCO` DECIMAL(18,6) NULL DEFAULT '0.000000'
)
COMMENT='Tabella Modula SYSTOREDB.dbo.DAT_ARTICOLI'
COLLATE='utf8_bin'
ENGINE=INNODB
;

ALTER TABLE oar add COLUMN go1_modula_sospeso ENUM('no','si') DEFAULT 'no';
