defmodule Paystack.BulkCharge.Base do
  @callback initiate(list) :: Paystack.Api.t()
  @callback list_batches() :: Paystack.Api.t()
  @callback list_batches(map | list) :: Paystack.Api.t()
  @callback fetch_batch(String.t()) :: Paystack.Api.t()
  @callback fetch_batch_charges(String.t()) :: Paystack.Api.t()
  @callback pause_batch(String.t()) :: Paystack.Api.t()
  @callback resume_batch(String.t()) :: Paystack.Api.t()
end

defmodule Paystack.BulkCharge do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Bulk Charges API allows you create and manage multiple recurring payments from your customers

  https://paystack.com/docs/api/#bulk-charge
  """

  @doc """
  Send an array of objects with authorization codes and amount (in kobo if currency is NGN, pesewas,
  if currency is GHS, and cents, if currency is ZAR ) so we can process transactions as a batch.
  """
  @impl true
  def initiate(params), do: paystack().post("/bulkcharge", params)

  @doc """
  his lists all bulk charge batches created by the integration.
  Statuses can be active, paused, or complete.
  """
  @impl true
  def list_batches(), do: paystack().get("/bulkcharge")

  @impl true
  def list_batches(query_params),
    do: paystack().get("/bulkcharge?" <> URI.encode_query(query_params))

  @doc """
  This endpoint retrieves a specific batch code.
  It also returns useful information on its progress by way of the total_charges and pending_charges attributes.
  """
  @impl true
  def fetch_batch(id_or_code),
    do: paystack().get("/bulkcharge/#{id_or_code}")

  @doc """
  This endpoint retrieves the charges associated with a specified batch code.
  Pagination parameters are available.
  You can also filter by status. Charge statuses can be pending, success or failed.
  """
  @impl true
  def fetch_batch_charges(id_or_code),
    do: paystack().get("/bulkcharge/#{id_or_code}/charges")

  @doc """
  Use this endpoint to pause processing a batch
  """
  @impl true
  def pause_batch(batch_code),
    do: paystack().get("/bulkcharge/pause/#{batch_code}")

  @doc """
  Use this endpoint to resume processing a batch
  """
  @impl true
  def resume_batch(batch_code),
    do: paystack().get("/bulkcharge/resume/#{batch_code}")
end
