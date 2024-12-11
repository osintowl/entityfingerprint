defmodule EntityFingerprint.FingerprintTest do
  use ExUnit.Case
  alias EntityFingerprint.Fingerprint

  test "create fingerprint for Siemens Aktiengesellschaft" do
    entity = "Siemens Aktiengesellschaft"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "Siemens Aktiengesellschaft",
                fingerprint: "069BCC150A2D09F1968E220F48B2362A655A7685",
                fingerprint_str: "ag siemens"
              }}
  end

  test "create fingerprint for New York, New York" do
    entity = "New York, New York"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "New York, New York",
                fingerprint: "DDDD9606DD438582C9642AA4DEB3C013CBC89148",
                fingerprint_str: "new york"
              }}
  end

  test "create fingerprint for empty abbreviation" do
    entity = "CHAMBRE DE COMMERCE"

    assert Fingerprint.create(entity) ==
             {:error, "Entity perfectly matches abbreviation: CHAMBRE DE COMMERCE"}
  end

  test "create fingerprint for Google" do
    entity = "Google Limited Liability Company    !!!"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "Google Limited Liability Company    !!!",
                fingerprint: "382621CA5922751BB77F398DD0B3CB1B4EACE596",
                fingerprint_str: "google llc"
              }}
  end

  test "create fingerprint with emoji" do
    entity = " 💩 Limited Liability Company"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "common",
                original: " 💩 Limited Liability Company",
                fingerprint: "2881722FEEB9C5AB87B7519C8FB711455690C330",
                fingerprint_str: "llc poop"
              }}
  end

  test "create fingerprint for Google llc dba" do
    entity = "GOOGLE LLC (DBA)"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "GOOGLE LLC (DBA)",
                fingerprint: "382621CA5922751BB77F398DD0B3CB1B4EACE596",
                fingerprint_str: "google llc"
              }}
  end

  test "create fingerprint Spark" do
    entity = "SPARK FOUNDRY (DBA)"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "SPARK FOUNDRY (DBA)",
                fingerprint: "C3571766B564FAEFC42F03AA6712D7E72DD1CA72",
                fingerprint_str: "foundry spark"
              }}
  end

  test "create fingerprint Seoul Yakup Co.,Ltd" do
    entity = "Seoul Yakup Co.,Ltd"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "Seoul Yakup Co.,Ltd",
                fingerprint: "58E422A1A0845506B50F8B0004A5E400B0EA922D",
                fingerprint_str: "coltd seoul yakup"
              }}
  end

  test "create fingerprint INSIGHT CANADA INC." do
    entity = "INSIGHT CANADA INC."

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "INSIGHT CANADA INC.",
                fingerprint: "60C4BDBCD10ACBBD5BE1CA0C77C1BA50405780C8",
                fingerprint_str: "canada inc insight"
              }}
  end

  test "create fingerprint MARMARA ÜNİVERSİTESİ DÖNER SERMAYE" do
    entity = "MARMARA ÜNİVERSİTESİ DÖNER SERMAYE"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "MARMARA ÜNİVERSİTESİ DÖNER SERMAYE",
                fingerprint: "79DBD107836719C92E571C4A1DCE0841331960C3",
                fingerprint_str: "doner marmara sermaye universitesi"
              }}
  end

  test "create fingerprint NCT HOLDINGS INC" do
    entity = "NCT HOLDINGS INC"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "NCT HOLDINGS INC",
                fingerprint: "28A7E39001BFA0540D034BB6AFC7DDD395C497A8",
                fingerprint_str: "holdings inc nct"
              }}
  end

  test "create fingerprint ANTICIMEX" do
    entity = "ANTICIMEX"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "ANTICIMEX",
                fingerprint: "5AEF14385072DC13E5BCF8FC427288CA25A364CB",
                fingerprint_str: "anticimex"
              }}
  end

  test "create fingerprint INVENTIV HEALTH CLINICAL" do
    entity = "INVENTIV HEALTH CLINICAL"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "INVENTIV HEALTH CLINICAL",
                fingerprint: "142E241CA48DB175D668FB5A6DBF463EBD018C38",
                fingerprint_str: "clinical health inventiv"
              }}
  end

  test "create fingerprint DOLPHIN GAYRIMENKUL" do
    entity = "DOLPHIN GAYRIMENKUL"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "DOLPHIN GAYRIMENKUL",
                fingerprint: "C608D545025F2F83B1944CA1775C000A59F6D8E6",
                fingerprint_str: "dolphin gayrimenkul"
              }}
  end

  test "create fingerprint INSTITUTE PHARM. SERVICES" do
    entity = "INSTITUTE PHARM. SERVICES"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "INSTITUTE PHARM. SERVICES",
                fingerprint: "5C81EB8B8B5E16BF38E645C9CBBBF015B22E3646",
                fingerprint_str: "institute pharm services"
              }}
  end

  test "create fingerprint MAGYAR TELEKOM NYRT" do
    entity = "MAGYAR TELEKOM NYRT"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "MAGYAR TELEKOM NYRT",
                fingerprint: "A318C1BABB6BD2C0C4FC8BC9A95A66072C1AC977",
                fingerprint_str: "magyar nyrt telekom"
              }}
  end

  test "create fingerprint IMAGEN ENSAYOS CLINICOS S.L." do
    entity = "IMAGEN ENSAYOS CLINICOS S.L."

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "IMAGEN ENSAYOS CLINICOS S.L.",
                fingerprint: "3802412D5ACDA4740D079046DE1CF75F99FBC666",
                fingerprint_str: "clinicos ensayos imagen sl"
              }}
  end

  test "create fingerprint SYNEOS HEALTH HUNGARY KFT" do
    entity = "SYNEOS HEALTH HUNGARY KFT"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "SYNEOS HEALTH HUNGARY KFT",
                fingerprint: "991EE0B97F16D29CC09786BDCDA41FE52DB4B7AD",
                fingerprint_str: "health hungary kft syneos"
              }}
  end

  test "create fingerprint WIND TRE S.P.A." do
    entity = "WIND TRE S.P.A."

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "WIND TRE S.P.A.",
                fingerprint: "1E0CF009D5FD8132B5DD85EF791609164537EF58",
                fingerprint_str: "spa tre wind"
              }}
  end

  test "create fingerprint BHS HOTEL AG" do
    entity = "BHS HOTEL AG"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "BHS HOTEL AG",
                fingerprint: "1B300C7B0CF8CC7E4638D1C04CAED90C6400B9EE",
                fingerprint_str: "ag bhs hotel"
              }}
  end

  test "create fingerprint SYNEOS HEALTH NETHERLANDS B.V." do
    entity = "SYNEOS HEALTH NETHERLANDS B.V."

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "SYNEOS HEALTH NETHERLANDS B.V.",
                fingerprint: "DDADE50D7A6E73C853EFB9657CC149FD1827747E",
                fingerprint_str: "bv health netherlands syneos"
              }}
  end

  test "create fingerprint HAAS & HEALTH PARTNER PUBLIC RELATI" do
    entity = "HAAS & HEALTH PARTNER PUBLIC RELATI"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "HAAS & HEALTH PARTNER PUBLIC RELATI",
                fingerprint: "3A000B500B5C519CFB8CBDC9FE2B4A6B13F31B63",
                fingerprint_str: "haas health partner public relati"
              }}
  end

  test "create fingerprint INVENTIV HEALTH SWEDEN AB" do
    entity = "INVENTIV HEALTH SWEDEN AB"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "INVENTIV HEALTH SWEDEN AB",
                fingerprint: "EEBE224ACAEE82B005B14393468E2D29B0438F9A",
                fingerprint_str: "ab health inventiv sweden"
              }}
  end

  test "create fingerprint SYNEOS HEALTH FRANCE SARL" do
    entity = "SYNEOS HEALTH FRANCE SARL"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "SYNEOS HEALTH FRANCE SARL",
                fingerprint: "37CFC482B4AB1CAF6A030CB95BC83D9768B061DD",
                fingerprint_str: "france health sarl syneos"
              }}
  end

  test "create fingerprint CESKA POSTA,S.P." do
    entity = "CESKA POSTA,S.P."

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "CESKA POSTA,S.P.",
                fingerprint: "949060F392A64355AF9A56968C3A400A4F6ED59A",
                fingerprint_str: "ceska postasp"
              }}
  end

  test "create fingerprint SYNEOS HEALTH CZ S.R.O." do
    entity = "SYNEOS HEALTH CZ S.R.O."

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "SYNEOS HEALTH CZ S.R.O.",
                fingerprint: "D6D3BB08ABDC9249DAEE4E596BE7A9324891B504",
                fingerprint_str: "cz health sro syneos"
              }}
  end

  test "create fingerprint GALEN-SYMPOSION S.R.O." do
    entity = "GALEN-SYMPOSION S.R.O."

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "GALEN-SYMPOSION S.R.O.",
                fingerprint: "CAE82440DAB8E2A34AA5EC14E14F6F06DEC55612",
                fingerprint_str: "galensymposion sro"
              }}
  end

  test "create fingerprint ICON CLINICAL RESEARCH LTD" do
    entity = "ICON CLINICAL RESEARCH LTD"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "ICON CLINICAL RESEARCH LTD",
                fingerprint: "788E2A6CE6AC31E744929F6C755592E3D786CA3B",
                fingerprint_str: "clinical icon ltd research"
              }}
  end

  test "create fingerprint CEPHEID" do
    entity = "CEPHEID"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "CEPHEID",
                fingerprint: "36F899E5B8D135560DBC88BE787D5284AC87EAC4",
                fingerprint_str: "cepheid"
              }}
  end

  test "create fingerprint HOLOGIC, INC" do
    entity = "HOLOGIC, INC"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "HOLOGIC, INC",
                fingerprint: "AA505D10E541C96995318689FBB9168480350F12",
                fingerprint_str: "hologic inc"
              }}
  end

  test "create fingerprint BRACKET GLOBAL, L.L.C." do
    entity = "BRACKET GLOBAL, L.L.C."

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "BRACKET GLOBAL, L.L.C.",
                fingerprint: "29EEBE7AE84235013EC0DCEA758F8D99CF372E5C",
                fingerprint_str: "bracket global llc"
              }}
  end

  test "create fingerprint COVANCE LABORATORIES" do
    entity = "COVANCE LABORATORIES"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "COVANCE LABORATORIES",
                fingerprint: "F8EB033A7CF91D9D79C6C7D49FE6A6F52AC90E4B",
                fingerprint_str: "covance laboratories"
              }}
  end

  test "create fingerprint WATERMARK RESEARCH PARTNERS," do
    entity = "WATERMARK RESEARCH PARTNERS,"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "WATERMARK RESEARCH PARTNERS,",
                fingerprint: "EBFC96106AE60312234A76E2984D7491FEA3FB8E",
                fingerprint_str: "partners research watermark"
              }}
  end

  test "create fingerprint SIGNANT HEALTH GLOBAL LLC" do
    entity = "SIGNANT HEALTH GLOBAL LLC"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "SIGNANT HEALTH GLOBAL LLC",
                fingerprint: "B44395176769D3BB2FC7070A20C075FB5EF0AD2E",
                fingerprint_str: "global health llc signant"
              }}
  end

  test "create fingerprint CAMBRIDGE ENTERPRISE LIMITED" do
    entity = "CAMBRIDGE ENTERPRISE LIMITED"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "CAMBRIDGE ENTERPRISE LIMITED",
                fingerprint: "0EA076937E723567FAEF16BFD2F5AFFAAAF05E70",
                fingerprint_str: "cambridge enterprise limited"
              }}
  end

  test "create fingerprint JOHN WILEY AND SONS INC" do
    entity = "JOHN WILEY AND SONS INC"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "latin",
                original: "JOHN WILEY AND SONS INC",
                fingerprint: "8077071BFE891BC4AE17108AADAD3A84FA85BB99",
                fingerprint_str: "and inc john sons wiley"
              }}
  end

  test "create fingerprint for 佐贤鸣智（上海）企业管理咨询有限公司" do
    entity = "佐贤鸣智（上海）企业管理咨询有限公司"

    assert Fingerprint.create(entity) ==
             {:ok,
              %{
                script: "han",
                original: "佐贤鸣智（上海）企业管理咨询有限公司",
                fingerprint: "51DDB4F4AA0F7484E7D9AD5CA2A81C4CAFAB5A4C",
                fingerprint_str: "guanlizixun shanghai zuoxianmingzhi"
              }}
  end
end
