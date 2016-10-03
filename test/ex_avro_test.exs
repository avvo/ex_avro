defmodule ExAvroTest do
  use ExUnit.Case
  doctest ExAvro

  alias ExAvro.{Protocol,Record,Message,Field}

  describe "elixir_convert" do
    test "parses simple protocol" do

      avro_protocol = {
        :avro_proto,
        "Quasi",
        "Ad",
        [
          {
            :avro_record,
            :Ad,
            [
              {"id", :int},
              {"customer_id", :int},
              {"detail_type", :string},
              {"detail_id", :int},
              {"disabled", :boolean},
              {"created_at", :string},
              {"updated_at", :string}
            ]
          },
          {:avro_record, :AdSearchParams, [{"ids", [:null, {:avro_array, :int}]}]}
        ],
        [
          {
            :avro_message,
            "index",
            [{:avro_record, :AdSearchParams, [{"ids", [:null, {:avro_array, :int}]}]}],
            {
              :avro_array,
              {
                :avro_record,
                :Ad,
                [
                  {"id", :int},
                  {"customer_id", :int},
                  {"detail_type", :string},
                  {"detail_id", :int},
                  {"disabled", :boolean},
                  {"created_at", :string},
                  {"updated_at", :string}
                ]
              }
            }
          }
        ],
        ""
      }

      expected = %Protocol{
        ns: "Quasi",
        name: "Ad",
        records: [
          %Record{name: :Ad, fields: [
              %Field{name: "id", type: :int},
              %Field{name: "customer_id", type: :int},
              %Field{name: "detail_type", type: :string},
              %Field{name: "detail_id", type: :int},
              %Field{name: "disabled", type: :boolean},
              %Field{name: "created_at", type: :string},
              %Field{name: "updated_at", type: :string}
            ]},
          %Record{name: :AdSearchParams, fields: [
              %Field{name: "ids", type: {:union, [nil, {:array, :int}]}}
            ]}
        ],
        messages: [
          %Message{
            name: "index",
            args: [
              %Record{name: :AdSearchParams, fields: [
                %Field{name: "ids", type: {:union, [nil, {:array, :int}]}}
              ]}
            ],
            return: {
              :array,
              %Record{name: :Ad, fields: [
                %Field{name: "id", type: :int},
                %Field{name: "customer_id", type: :int},
                %Field{name: "detail_type", type: :string},
                %Field{name: "detail_id", type: :int},
                %Field{name: "disabled", type: :boolean},
                %Field{name: "created_at", type: :string},
                %Field{name: "updated_at", type: :string}
              ]}
            }
          }
        ],
        json: "",
      }

      assert expected == ExAvro.elixir_convert(avro_protocol)
    end
  end
end
