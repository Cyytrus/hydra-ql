defmodule Hydra.Pickings.Core.SendProductsToKafka do
  @topic "k-picking"
  def execute(products) do
    client_id = :hydra_producer
    hosts = [localhost: 9092]
    :ok = :brod.start_client(hosts, client_id)
    :ok = :brod.start_producer(client_id, @topic, [])
    :brod.produce(client_id, @topic, 0, _key = "", Jason.encode!(products))
  end
end

# %{
#   products: [
#     %{product: "123", stores: ["123", "123123"]},
#     %{product: "123", stores: ["123", "123123"]}
#   ]
# }
