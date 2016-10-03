# ExAvro

A light Elixir wrapper around [eavro](https://github.com/SIfoxDevTeam/eavro)
for parsing Avro protocol files.

## Installation

The package can be installed as:

  1. Add `eavro` and `ex_avro` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [
        {:eavro, git: "https://github.com/sifoxdevteam/eavro.git", tag: "v0.0.3"},
        {:ex_avro, "~> 0.1.0"},
      ]
    end
    ```

  2. Ensure `eavro` and `ex_avro` are started before your application:

    ```elixir
    def application do
      [
        applications: [
          :eavro,
          :ex_avro,
        ]
      ]
    end
    ```

