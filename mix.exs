defmodule EntityFingerprint.MixProject do
  use Mix.Project

  def project do
    [
      app: :entityfingerprint,
      version: "0.3.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: "A library for the creation of Entity Fingerprints."
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.2"},
      {:unicode, "~> 1.19"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:any_ascii, "~> 0.3.2"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp package do
    [
      files: ~w(lib priv .formatter.exs mix.exs LICENSE*),
      licenses: ["BSD-3-Clause"],
      links: %{"GitHub" => "https://github.com/osintowl/entityfingerprint"}
    ]
  end
end
