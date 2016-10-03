# ExAvro

A light Elixir wrapper around [eavro](https://github.com/SIfoxDevTeam/eavro)
for parsing Avro protocol files.

## Installation

The package can be installed as:

  1. Add `ex_avro` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ex_avro, "~> 0.1.0"}]
    end
    ```

  2. Ensure `ex_avro` is started before your application:

    ```elixir
    def application do
      [applications: [:ex_avro]]
    end
    ```

