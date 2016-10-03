defmodule ExAvro.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_avro,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "A light Elixir wrapper around eavro for parsing Avro protocol files.",
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [
        :logger,
        :eavro,
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:eavro, git: "https://github.com/sifoxdevteam/eavro.git", tag: "v0.0.3"},
    ]
  end

  defp package do
    [
     licenses: ["MIT"],
     links: %{
       "github" => "https://github.com/avvo/ex_avro",
     },
     maintainers: ["Donald Plummer"],
    ]
  end
end
