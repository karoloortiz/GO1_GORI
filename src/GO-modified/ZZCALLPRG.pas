unit ZZCALLPRG;

interface

uses
  GGGO1GESORDVCL,
  GGGO1GESTMODULA,
  GGGO1GESTUB,
  GGGO1ESPMODULA,
  GGGO1GESORDAFRN;

const
  GO_PERS_CODICE = 'GO1';
  prefisso_integrita = GO_PERS_CODICE;

procedure assegna_programma_personalizzato(programma_da_eseguire: string; var codice_archivio: variant;
  var programma_personalizzato: boolean);

const
  ELENCO_PROGRAMMI_PERSONALIZZATI =
    GGGO1GESORDVCL.PROGRAM_NAME + ';' +
    GGGO1GESTMODULA.PROGRAM_NAME + ';' +
    GGGO1GESTUB.PROGRAM_NAME + ';' +
    GGGO1ESPMODULA.PROGRAM_NAME + ';' +
    GGGO1GESORDAFRN.PROGRAM_NAME + ';'
    ;

implementation

uses
  System.SysUtils, System.Variants, System.StrUtils;

const
  LIST_CUSTOM_PROGRAMS: array [1 .. 5] of string = (
    GGGO1GESORDVCL.PROGRAM_NAME,
    GGGO1GESTMODULA.PROGRAM_NAME,
    GGGO1GESTUB.PROGRAM_NAME,
    GGGO1ESPMODULA.PROGRAM_NAME,
    GGGO1GESORDAFRN.PROGRAM_NAME
    );

procedure assegna_programma_personalizzato(programma_da_eseguire: string; var codice_archivio: variant;
  var programma_personalizzato: boolean);
var
  _programCode: string;
begin
  programma_personalizzato := false;

  (*
    if uppercase(programma_da_eseguire) = 'xxxxxx' then
    begin
    if vartype(codice_archivio) = varustring then
    begin
    codice_archivio := vararrayof(['', '']);
    end;
    programma_personalizzato := true;
    end;
  *)
  _programCode := trim(programma_da_eseguire);
  if MatchText(_programCode, LIST_CUSTOM_PROGRAMS) then
  begin
    if VarIsNull(codice_archivio) then
    begin
      codice_archivio := '';
    end;
    programma_personalizzato := true;
  end;
end;

end.
