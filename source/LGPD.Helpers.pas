unit LGPD.Helpers;

interface
  uses
    System.SysUtils;

  function Encrypt(AValor: string): String;
  function Decrypt(AValor: string): String;

function EncryptStr(const S :WideString; Key: Word): String;
function DecryptStr(const S: String; Key: Word): String;


implementation

const CKEY1 = 53761;
      CKEY2 = 32618;

function EncryptStr(const S :WideString; Key: Word): String;
var   i          :Integer;
      RStr       :RawByteString;
      RStrB      :TBytes Absolute RStr;
begin
  Result:= '';
  RStr:= UTF8Encode(S);
  for i := 0 to Length(RStr)-1 do begin
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (RStrB[i] + Key) * CKEY1 + CKEY2;
  end;
  for i := 0 to Length(RStr)-1 do begin
    Result:= Result + IntToHex(RStrB[i], 2);
  end;
end;

function DecryptStr(const S: String; Key: Word): String;
var   i, tmpKey  :Integer;
      RStr       :RawByteString;
      RStrB      :TBytes Absolute RStr;
      tmpStr     :string;
begin
  tmpStr:= UpperCase(S);
  SetLength(RStr, Length(tmpStr) div 2);
  i:= 1;
  try
    while (i < Length(tmpStr)) do begin
      RStrB[i div 2]:= StrToInt('$' + tmpStr[i] + tmpStr[i+1]);
      Inc(i, 2);
    end;
  except
    Result:= '';
    Exit;
  end;
  for i := 0 to Length(RStr)-1 do begin
    tmpKey:= RStrB[i];
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (tmpKey + Key) * CKEY1 + CKEY2;
  end;
  Result:= UTF8Decode(RStr);
end;

const
  CRIPTY : Array[1..10]  of String = ( 'K �RBEVHJC4��LM��ZX�T.7I�����G1D-O0:SP��Q\6�F�Y3U&�W��/5829AN',
                                       'OS�FR6�X AT�M�8LE�YZG�UI�C�P5D�37���:0�J�1B�\H&/9KN�-�.Q2W4V�',
                                       'G ��H&C�:R47QA�IVF8J�6�-�2XL�K50S�9.�/3N�OBP�M1TD\U�WZ����E�Y',
                                       '6��0&:M8��BH�5�PJZ�.4��W� �YEOQGS3V9NT��KIC/1F�\A7RL�2D-�X��U',
                                       'U�LPH5�/3 N&QKW7O�D�FGIAX�TM0Z�21��VEJ9�-�8.C4�:��\�Y�S6��B�R',
                                       '�.��X�A3D9��CQ�-TJNKL7/�Y6�8�0GF�O&�5SU:1VBR�Z �2�W4HPI\�ME��',
                                       '���H.�N��:S 5VAC�2D\F37�W/J�0�Z9O��Q�&RK-EI4�1TY8�6�B��XGLMPU',
                                       'P5�9JG-H�K�V��3:�UD�I�1\S.�4E/OWB07LCN��&�Y286MX��Q�T �FA�Z�R',
                                       '�VJ�9�X&K��-O:Y�CMS�DTF��8R1/6��.3NI0AB Q�EU�74WH�5�L�\PZG��2',
                                       'Z�6�1O�R�LC3EA���-���8P0�&Q�2�94XS7�GNW\BI��K /D�:VFTM�JU.5YH');

  CRIPTY_KEYS : Array[1..61]  of String = ('?-5t$�1y@�8pu=O�]}#\�k:6eǢ>!DVn�Z{<_�jrb��~/�f9w��A�&+�0[*S2',
                                           '_V�y}0@�<t6u�9$�b5\#&w+An{f!2�-ke�pDS]j8~��?O>[���1�=:*r�/�Z�',
                                           '�Z��2b={6n@�p$*j>!�r0\��tu8+V�&�y<:eA/�9?w1]�Df�_-#S�~}O�[k5�',
                                           ':0>uy]���&n=�w�6j�O$<#�-Zb1?!A[��Sk�5�~�}�\/p_�f{2+e�89*@DtrV',
                                           '��=?Z~r#y&�\n<91]65u*$�0�@S�kf�!/[A��2�8{:>���Dp+w�}Vte-b_jO',
                                           '�]�w2y�0<+�6=uf@$-\D�[~jS�!/�8A1#�&5��:r�9�bV?*O>�k_p{Zn�te}',
                                           '>j\�f8-�k60~!wu�1:�e/S�p]�t}*���Z<�9_?�A�{5O[ry=�+Vn�b2@&D$�#',
                                           '910fO����b:��-y�?~e<$�[>8S���5\=A�p�j2!+&�#rD]w@6{u_kZV}*t/n',
                                           'ZS2y�n���r>$[56�@?\9_{�:/�A�D=~1k�]��&e�+#O}f<b-8!jtw0�uV�p*',
                                           '�pt�[f+n1Ze:9*~S&{O-�Vj���$A_2w��#<uky}�5?0b�D]��\=>r�6/8�!�@',
                                           '&�S@k9�+�/�-�b:$��=}*<�?_5{0�A81nj�fyO[e~�#Dr]V��Z2�tp\6w>u!�',
                                           '�&#�Z}��$1?O�!���k@-{>�2r=�j*8wf~_D0nySAb�[p6�/u9V:]�t�e+�5\<',
                                           '{<w=��\�pk~£�yb}j8tDfOe59*n>A���2�Z��u+�r:1#@/S�&]$_�[6?!V-0',
                                           '2-jV5@e�8/~Z]&�*+��A?\!bS_9{t}�=�$�:k#wuO�6�D�>�10y[�n�p�fr<�',
                                           '$�p�~8��V�+On�uAf\b<Dw�]?�>�/_yjS&r!5t}*21�:�90e�=k#�-[�6Z�{@',
                                           '�nj�tk:]{w�910*$-/O�@5D�>[e�6!+}uA�fp��<&�\b2Z��V��yr8S~_=#?�',
                                           't��Dn�20p+�$19rf-�bZ<�#@!{]?}yOe~�A�k[����_*:V�/u=S>w65��j&\8',
                                           '1~jw��[�06/_�?>+&$�Z:{�D�r<ep=�f8}�O�@�n�9u5A\2tV*!Sy��bk-�]#',
                                           't+����*19:p5&Ok�$fySb��uVr/�<-�!D]_��e2n�@A�>�\w{}=[�~8?#6jZ0',
                                           '�p@}>�<{+2S&���1Dt�bjf�Z!y�_~90�[\�nV]5r=��$Ok�68?A:-�uew/�#*',
                                           'w�Sp}A#V��j?eb�6D<y:&k*�n59!0f�t1O�=]�ǣ$2Z8+�@��>r/{�[~u�-\_',
                                           '09�ty>w�2-]{jV!���6/p�rD=\8bu5+#��:_&<�*Sek�$~��Z@1�?[OnA}�f�',
                                           'A=~_��r]ty�?O>/��86}#b2&�p*jZ<�\�15:S�eD�!Vukn�0w��9$-�f+�@{[',
                                           '�~pt\/�6=S}!0br-A:#�Vk_<&{*2j�>��?yeǢu5@��O+w�$�19��n�8ZDf[]',
                                           'reDp��/\j�<t�Z!�@�V�k$+�:*52f[{O�0u6?-#��_}~�]�wy&n89>�b1SA=�',
                                           '�>&�2:@De�ZV[\*-O{S��=5}_�kn�y�#w0]r�p9�u�fb�A�<1/+�t8!6$~?�j',
                                           'r/*t!��A-V�>S�0@�[5j{��e<&_$�2+w�f:=Zn�kD��~#y698�1�O\]ubp�?}',
                                           '/$�]=6&j8*�e?y{!�Z0Ok5[�¢-<�t�9uV@:}~>��+S�f��D�\A2w1pb#r_�n',
                                           '}S�y�[b?5:V�p�/]�n@�_u9ͣ&12�-�!8�+jO~Z6\$frt*#<=�AwD�e>{��0k',
                                           'b��0!</]j&�ruV_�5w�pS�6tf19�8+}D$-O�nA\>�k?{@�=���#�y[e�~2:*Z',
                                           '=�jf5b-Zr�p~n+�t/�S�:?e��uO$A8_w�*��9<�D�#]�[k�6y&>V�2!1\}{0@',
                                           'uS#_ɢ�\{��/w+*1$90j��&-y?5@nf]�O:=D��rb~ZA�2t>p�6[8k�!eV��<}',
                                           '<>�bZV8~_wO�[?renAuk=py#5}�!6j���@fD9��]2�/{0+*$1\:����t�-S&�',
                                           '�~p=$�S_>0�t<���9/*{][}:�\�-kf81n+?VZr�#��yODjAu�!���5b&2@ew6',
                                           'rVS{�9f@w=�<&��pDj*}�b1:A]�/2?~�$[0�n�_�-�y\k5+!ZOe��6t�>�8u#',
                                           '_+&#D�[!�ZV~S�w15<�:�*-O6=p\9y�?�2>bt�/$k�{]��0�f��jA}8�r@uen',
                                           '�}D\�*&y��]�t<1=5~:-�#[n_8r?>{+wA��2eVu�/Ob�p��6�0k$Z9�j@!fS',
                                           '-?���t]�=9�Dy��<���b+\@2#>6O&��A�p/VS5k1[�Z0nrj8*w~}:{e!_$�fu',
                                           '2@�9tyb��-5_�1[=p�kSOZ&{n0w~!�$\e<��*r>��j]uA86:��?#}D/�Vf��+',
                                           '?VOrb�$0�D-�&j/�k�eS!��#6t1~{�<�*�f@[Aw9:n5_+}\y��]�Z�8�2u>p=',
                                           '�O�D�{f�#[}-y!SZt�pe�+n9]V�=�*A�bu:_5\1$&j~�>2rk�/�w0<@��?68',
                                           '~����91y!=rkO:#�<b�D_�2�tuej}[��{\>p+8S$*/�@5�60wZ&�VA]-?�nf�',
                                           '<�*�\?0e�/n:r�>�D}j�5p!�91&V�6Ob2tu�{=Z$A#�]�@-fw+�Syk[_�~8��',
                                           '�tybf-Se>$/:V#!Z9�[ju���Dwk\��p�6�}��*{<]0_�=+@~n&2r15��?8OA�',
                                           '�0�{f}uk~6y�t+]�:=?�\8[SZp@n!V5��_91A�2rj/>$�#��<�w�&OebD��*-',
                                           '5re�=_���-A*#t�D@n:�{���?Ou8��1/+<Vfk0Sj9�y!�>&b\Z}]~w62$�[p�',
                                           'w#]u:�D$@e1�&/�j9�fS{r�!�k2n�AVb�6_t?=��p[Z~>�y5�}+-*0�<O�\�8',
                                           '��Zf-O�@61]�#k*�V~?/9\�8u�52bA&>{�+�$�=�}ry�p�_Sn�[:t�!<ewDj0',
                                           '~�9:�wD6n�?[t�*�@VA<r2/��u>Z�5�O+f#1$]-S{��&e0p�ybj=}8!k�_�\�',
                                           '�V~@{$!&j�+O�:1#��8A?t<�9kS}6Zf]n�p0r-/_D����>25*uwb=e[�y�\�',
                                           '-+A[n6�/p_@�Z$O{f8�y�&u�<�5D>��S~!�\#e�2:r=w���b�}j*V]�109?kt',
                                           '���#!:?�j=\�[e]�Z+$�w6b�S�n2~�f}k�y/8<O-@&�>1*90_�Dr{uV5t�pA�',
                                           'weDb$[f-�!p��\8=}<���S�*#&�?2:]V1>�/O�_Zn~j6A��5��y{+9rk@�0tu',
                                           'rj25��/�$}�wt]y�u6���Vb8n�?De:��_*�k{+=90!\>-O�p<A[ZSf@1��~#&',
                                           '9�����/8u#�tOAp�~Z2�Skwfn1V?e>+�=6�_�[*�@r5-jb{]�<&!�Dy0}:�\$',
                                           '6t�D:j�*<8}Z�fy����kw59�/AeV0~p@1�>!�S�{-�#?n&=\u[$�]O+r_2b',
                                           '���-+n}ZV{:61S&eD�@<u�[k�¢p�\yw�>_?�~�]!#�05Atj�8r2=$b9�fO/*',
                                           '<�@$\�&SZ�enk~/:pj�[�r�#?�>2w�u�Ob0�8�5*=�VtA{�]9f}+_!61�-�Dy',
                                           '�VS:+\n�6ujy{$��-0=���k��98*2t�Z}/�!�5O�e><b1p[#~A@]wr�fD&_?',
                                           ':1e]w{8!�6�f5n@�?r_�p\�&O�y��+>D}jZ9-V/<#�tbS~���*$u20k��=A�[',
                                           '8k2>+rS1jZ���:�nV?�u=��_{�f\9-�b�O0�~6pt}y�]$�5@�D<e/w[#!�A*&');

  RANDOM_NUMBERS : Array[1..110] of Integer = (05, 24, 25, 08, 59, 53, 102, 07, 58, 09, 10, 60, 31,
                                               01, 43,  106, 44, 02, 03, 32, 33, 13, 14, 34, 35, 40,
                                               45, 109, 46, 77, 78, 103, 79, 80, 81, 85, 41, 42, 36,
                                               86, 61, 101, 48, 26, 27, 63, 64, 74, 75, 76, 65, 18,
                                               87, 88, 110, 89, 50, 96, 97, 98, 20, 04, 11, 12, 82,
                                               19, 99, 21, 47, 62, 104, 49, 95, 51, 90, 91, 92, 93,
                                               94, 52, 57, 22, 06, 54, 55, 56, 23, 28, 107, 29, 30,
                                               83, 84, 15, 16, 17, 105, 67, 68, 69, 37, 38, 66, 70,
                                               39, 71, 108, 72, 73, 100);


function Encrypt(AValor: string): String;
var
  FIdent,
  FIndex,
  FIndexChange : Integer;
  FString,
  FChar: string;

  function StrRandom(AText: string): string;
  var
    FIndex : integer;
  begin
    Result := '';
    AText := AText + StringOfChar(' ', (110 - Length(AText)));
    for FIndex := 1 to Length(AText) do
      Result := Result + AText[(RANDOM_NUMBERS[FIndex])];
  end;
begin
  FString := '';
  Randomize;
  FIndexChange := Trunc(Random(60)) + 1;
  for FIndex := 1 to Length(AValor) do
  begin
     FIdent     := StrtoInt(Copy(FormatFloat('000', FIndex), 3, 1));
     if FIdent = 0 then FIdent := 10;
     FChar := Copy(CRIPTY_KEYS[FIndexChange], Pos(AValor[FIndex], Cripty[FIdent]), 1);
     FString := FString + FChar;
  end;
  Result := StrRandom(FormatFloat('00', FIndexChange) + FString);
end;

function Decrypt(AValor: string): String;
var
  FIndex,
  FIdent,
  FIndexChange : Integer;
  FChar,
  FString,
  FValue: string;

  function StrUnRandom(AText: string): string;
  var
    FIndex,
    FIndex2 : integer;
    FText : array[1..110] of String;
  begin
    for FIndex := 1 to 110 do
      FText[(RANDOM_NUMBERS[FIndex])] := AText[FIndex];

    Result := '';

    for FIndex2 := 1 to 110 do
      if FText[FIndex2] <> ' ' then
        Result := Result + FText[FIndex2];

    Result := Trim(Result);
  end;
begin
  FValue    := StrUnRandom(AValor);
  FIndexChange := StrtoInt(Copy(FValue, 1, 2));
  FValue := Copy(FValue, 3, (Length(FValue) - 2));
  for FIndex := 1 to Length(FValue) do
  begin
    FIdent   := StrtoInt(Copy(FormatFloat('000', FIndex), 3, 1));
    if FIdent = 0 then FIdent := 10;
      FChar := Copy(Cripty[FIdent], Pos(FValue[FIndex], CRIPTY_KEYS[FIndexChange]), 1);
    FString := FString + FChar;
  end;
  Result := FString;
end;

end.
