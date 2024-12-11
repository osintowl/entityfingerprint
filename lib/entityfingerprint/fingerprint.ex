defmodule EntityFingerprint.Fingerprint do
  alias EntityFingerprint.Loader

  @abbreviations Loader.load_abbreviations()

  @doc """
  Creates a fingerprint for the given entity name. It supports special character, emojis (because we all know that emoji's in company names are coming), and entity types in other non-latin scripts.

  ## Examples

    ```
    iex(1)> EntityFingerprint.create("ФИЛИАЛ КОМПАНИИ С ОГРАНИЧЕННОЙ")

    {:ok,
    [
      fingerprint: "filial kompanii ogranichennoy s",
      original: "ФИЛИАЛ КОМПАНИИ С ОГРАНИЧЕННОЙ",
      script: "cyrillic"
    ]}

    iex(2)> EntityFingerprint.create("ООО КУРЬЕР-РЕГИОН СТОЛИЦА")

    {:ok,
    [
      fingerprint: "kurerregion ooo stolitsa",
      original: "ООО КУРЬЕР-РЕГИОН СТОЛИЦА",
      script: "cyrillic"
    ]}

    iex(3)> EntityFingerprint.create("Google Limited Liability Company")

    {:ok,
    [
      fingerprint: "google llc",
      original: "Google Limited Liability Company",
      script: "latin"
    ]}

    iex(4)> EntityFingerprint.create("현대해상화재보험")

    {:ok,
    [
      fingerprint: "hyeondaehaesanghwajaeboheom",
      original: "현대해상화재보험",
      script: "hangul"
    ]}

    iex(5)> EntityFingerprint.create(" 💩 Limited Liability Company")

    {:ok,
    [
      fingerprint: "llc poop",
      original: " 💩 Limited Liability Company",
      script: "common"
    ]}

    iex(6)> EntityFingerprint.create("佐贤鸣智（上海）企业管理咨询有限公司")
    {:ok,
    [
      fingerprint: "guanlizixun shanghai zuoxianmingzhi",
      original: "佐贤鸣智（上海）企业管理咨询有限公司",
      script: "han"
    ]}

    iex(7)> EntityFingerprint.create("Siemens Aktiengesellschaft")
  {:ok,
  %{
   script: "latin",
   original: "Google Limited Liability Company",
   fingerprint: "382621CA5922751BB77F398DD0B3CB1B4EACE596",
   fingerprint_str: "google llc"
  }}
  iex(4)> EntityFingerprint.Fingerprint.create("현대해상화재보험")
  {:ok,
  %{
   script: "hangul",
   original: "현대해상화재보험",
   fingerprint: "00044613027E2BF63B36225EAFF0EB48352A68E4",
   fingerprint_str: "hyeondaehaesanghwajaeboheom"
  }}
  iex(5)> EntityFingerprint.Fingerprint.create(" 💩 Limited Liability Company")
  {:ok,
  %{
   script: "common",
   original: " 💩 Limited Liability Company",
   fingerprint: "2881722FEEB9C5AB87B7519C8FB711455690C330",
   fingerprint_str: "llc poop"
  }}
  iex(6)> EntityFingerprint.Fingerprint.create("佐贤鸣智（上海）企业管理咨询有限公司")
  {:ok,
  %{
   script: "han",
   original: "佐贤鸣智（上海）企业管理咨询有限公司",
   fingerprint: "51DDB4F4AA0F7484E7D9AD5CA2A81C4CAFAB5A4C",
   fingerprint_str: "guanlizixun shanghai zuoxianmingzhi"
  }}
  iex(7)> EntityFingerprint.Fingerprint.create("Siemens Aktiengesellschaft")
  {:ok,
  %{
   script: "latin",
   original: "Siemens Aktiengesellschaft",
   fingerprint: "069BCC150A2D09F1968E220F48B2362A655A7685",
   fingerprint_str: "ag siemens"
  }}
  iex(8)> EntityFingerprint.create("New York, New York")
  ** (UndefinedFunctionError) function EntityFingerprint.create/1 is undefined (module EntityFingerprint is not available)
    EntityFingerprint.create("New York, New York")
    iex:8: (file)
  iex(8)> EntityFingerprint.Fingerprint.create("New York, New York")
  {:ok,
  %{
   script: "latin",
   original: "New York, New York",
   fingerprint: "DDDD9606DD438582C9642AA4DEB3C013CBC89148",
   fingerprint_str: "new york"
  }}
  iex(9)>
    ```
  ## Thanks

    This library was heavily inspired by the python tool \[alephdata\/fingerprints\](https://github.com/alephdata/fingerprints)

    - A \[Google Spreadsheet\](https://docs.google.com/spreadsheets/d/1Cw2xQ3hcZOAgnnzejlY5Sv3OeMxKePTqcRhXQU8rCAw/edit?ts=5e7754cf#gid=0) created by OCCRP.

    - The ISO 20275: \[Entity Legal Forms Code List\](https://www.gleif.org/en/about-lei/code-lists/iso-20275-entity-legal-forms-code-list)

    - Wikipedia also maintains an index of \[types of business entity\](https://en.wikipedia.org/wiki/Types_of_business_entity).

  ## See also

    - \[Clustering in Depth\](https://github.com/OpenRefine/OpenRefine/wiki/Clustering-In-Depth), part of the OpenRefine documentation discussing how to create collisions in data clustering.
  """
  def create(entity) do
    abbreviated_entity = abbreviate_entity(entity)
    fingerprint_str = create_fingerprint_str(abbreviated_entity)
    fingerprint = create_fingerprint(fingerprint_str)

    if String.trim(abbreviated_entity) == "" do
      {:error, "Entity perfectly matches abbreviation: " <> entity}
    else
      case Unicode.script(abbreviated_entity) do
        [script_atom | _] ->
          script = Atom.to_string(script_atom)

          {:ok,
           %{
             fingerprint: fingerprint,
             fingerprint_str: fingerprint_str,
             original: entity,
             script: script
           }}

        _ ->
          {:error, "Failed to get script for entity: " <> entity}
      end
    end
  end

  defp abbreviate_entity(entity) do
    entity
    |> String.trim()
    |> String.upcase()
    |> replace_abbreviations()
  end

  defp replace_abbreviations(text) do
    Enum.reduce(@abbreviations, text, fn {full, abbr}, acc ->
      String.replace(acc, full, abbr, global: false)
    end)
  end

  defp create_fingerprint(fingerprint_str) do
    :crypto.hash(:sha, fingerprint_str)
    |> Base.encode16()
  end

  defp create_fingerprint_str(abbreviated_entity) do
    case Unicode.script(abbreviated_entity) do
      [:latin | _] ->
        generate_fingerprint_str(abbreviated_entity)

      [:common | _] ->
        abbreviated_entity
        |> AnyAscii.transliterate()
        |> IO.chardata_to_string()
        |> generate_fingerprint_str()

      _ ->
        abbreviated_entity
        |> String.trim()
        |> String.split(~r/[^[:alnum:]-]/u, trim: true)
        |> AnyAscii.transliterate()
        |> Enum.join(" ")
        |> generate_fingerprint_str()
    end
  end

  defp generate_fingerprint_str(transformed_entity) do
    transformed_entity
    |> String.normalize(:nfd)
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\s]/u, "")
    |> String.replace(~r/\s+/, " ")
    |> String.split()
    |> Enum.uniq()
    |> Enum.sort()
    |> Enum.join(" ")
  end
end
