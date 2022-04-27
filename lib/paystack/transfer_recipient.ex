defmodule Paystack.TransferRecipient.Base do
  @callback create(map) :: Paystack.Api.t()
  @callback bulk_create(map) :: Paystack.Api.t()
  @callback list() :: Paystack.Api.t()
  @callback list(map | list) :: Paystack.Api.t()
  @callback fetch(String.t()) :: Paystack.Api.t()
  @callback update(String.t(), map) :: Paystack.Api.t()
  @callback delete(String.t()) :: Paystack.Api.t()
end

defmodule Paystack.TransferRecipient do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Transfer Recipients API allows you create and manage beneficiaries that you send money to

  https://paystack.com/docs/api/#transfer-recipient
  """

  @doc """
  Creates a new recipient. A duplicate account number will lead to the retrieval of the existing record.
  """
  @impl true
  def create(params), do: paystack().post("/transferrecipient", params)

  @doc """
  Create multiple transfer recipients in batches. A duplicate account number will lead to the retrieval of the existing record.
  """
  @impl true
  def bulk_create(params), do: paystack().post("/transferrecipient/bulk", params)

  @doc """
  List transfer recipients available on your integration
  """
  @impl true
  def list(), do: paystack().get("/transferrecipient")

  @impl true
  def list(query_params),
    do: paystack().get("/transferrecipient?" <> URI.encode_query(query_params))

  @doc """
  Fetch the details of a transfer recipient
  """
  @impl true
  def fetch(id_or_code), do: paystack().get("/transferrecipient/#{id_or_code}")

  @doc """
  Update an existing recipient. An duplicate account number will lead to the retrieval of the existing record.
  """
  @impl true
  def update(id_or_code, params), do: paystack().put("/transferrecipient/#{id_or_code}", params)

  @doc """
  Deletes a transfer recipient (sets the transfer recipient to inactive)
  """
  @impl true
  def delete(id_or_code), do: paystack().delete("/transferrecipient/#{id_or_code}")
end
