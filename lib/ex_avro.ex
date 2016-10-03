defmodule ExAvro do
  def parse_protocol_file(filepath) do
    :eavro_rpc_proto.parse_protocol_file(filepath)
    |> elixir_convert()
  end

  def parse_protocol(protocol_json) do
    :eavro_rpc_proto.parse_protocol(protocol_json)
    |> elixir_convert()
  end

  defmodule Protocol, do: defstruct [:ns, :name, :records, :messages, :json]
  defmodule Record, do: defstruct [:name, :fields]
  defmodule Message, do: defstruct [:name, :args, :return]
  defmodule Field, do: defstruct [:name, :type]
  defmodule AvroEnum, do: defstruct [:name, :values]

  def elixir_convert({:avro_proto, ns, name, records, messages, json}) do
    %Protocol{
      ns: ns,
      name: name,
      records: records |> Enum.map(&elixir_convert/1),
      messages: messages |> Enum.map(&elixir_convert/1),
      json: json,
    }
  end

  def elixir_convert({:avro_record, name, fields}) do
    %Record{
      name: name,
      fields: fields |> Enum.map(&field_convert/1),
    }
  end

  def elixir_convert({:avro_array, record}) do
    {:array, record |> elixir_convert()}
  end

  def elixir_convert({:avro_enum, name, values}) do
    %AvroEnum{name: name, values: values}
  end

  def elixir_convert({:avro_message, name, args, return}) do
    %Message{
      name: name,
      args: args |> Enum.map(&elixir_convert/1),
      return: return |> elixir_convert(),
    }
  end
  def elixir_convert(:null), do: nil
  def elixir_convert(value) when is_list(value), do: {:union, value |> Enum.map(&elixir_convert/1)}
  def elixir_convert(value), do: value

  def field_convert({name, type}), do: %Field{name: name, type: type |> elixir_convert()}

end
