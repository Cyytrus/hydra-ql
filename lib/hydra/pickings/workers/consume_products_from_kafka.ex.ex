defmodule Hydra.Pickings.Workers.ConsumeProductsFromKafka do
  use Broadway
  alias Broadway.Message
  alias Hydra.Pickings

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: :picking_consumer,
      producer: [
        module:
          {BroadwayKafka.Producer,
           hosts: [localhost: 9092],
           group_id: "k-pickings-orders-to-create",
           topics: ["k-picking"]},
        concurrency: 2
      ],
      processors: [
        default: [
          concurrency: 10
        ]
      ]
    )
  end

  def handle_message(_, message, _) do
    IO.inspect(message.data, label: "Got message")
    message
  end
end
