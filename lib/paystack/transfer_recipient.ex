defmodule Paystack.TransferRecipient do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Transfer Recipients API allows you create and manage beneficiaries that you send money to

  https://paystack.com/docs/api/#transfer-recipient
  """

  @doc """
  Creates a new recipient. A duplicate account number will lead to the retrieval of the existing record.
  """
  @spec create(map) :: Paystack.Api.t
  def create(params), do: paystack().post("/transferrecipient", params)

  @doc """
  Create multiple transfer recipients in batches. A duplicate account number will lead to the retrieval of the existing record.
  """
  @spec bulk_create(map) :: Paystack.Api.t
  def bulk_create(params), do: paystack().post("/transferrecipient/bulk", params)

  @doc """
  List transfer recipients available on your integration
  """
  @spec list() :: Paystack.Api.t
  def list(), do: paystack().get("/transferrecipient")

  @spec list(map | list) :: Paystack.Api.t
  def list(query_params),
    do: paystack().get("/transferrecipient?" <> URI.encode_query(query_params))

  @doc """
  Fetch the details of a transfer recipient
  """
  @spec fetch(String.t) :: Paystack.Api.t
  def fetch(id_or_code), do: paystack().get("/transferrecipient/#{id_or_code}")

  @doc """
  Update an existing recipient. An duplicate account number will lead to the retrieval of the existing record.
  """
  @spec update(String.t, map) :: Paystack.Api.t
  def update(id_or_code, params), do: paystack().put("/transferrecipient/#{id_or_code}", params)

  @doc """
  Deletes a transfer recipient (sets the transfer recipient to inactive)
  """
  @spec delete(String.t) :: Paystack.Api.t
  def delete(id_or_code), do: paystack().delete("/transferrecipient/#{id_or_code}")
end
