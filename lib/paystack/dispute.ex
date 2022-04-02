defmodule Paystack.Dispute do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Disputes API allows you manage transaction disputes on your integration
  """

  @doc """
  List disputes filed against you
  """
  @spec list(map | list) :: Paystack.Api.t
  def list(query_params), do: paystack().get("/dispute?" <> URI.encode_query(query_params))

  @doc """
  Get more details about a dispute.
  """
  @spec fetch(String.t) :: Paystack.Api.t
  def fetch(dispute_id), do: paystack().get("/dispute/#{dispute_id}")

  @doc """
  This endpoint retrieves disputes for a particular transaction
  """
  @spec list_transaction_disputes(String.t) :: Paystack.Api.t
  def list_transaction_disputes(transaction_id),
    do: paystack().get("/dispute/transaction/#{transaction_id}")

  @doc """
  Update details of a dispute on your integration
  """
  @spec update(String.t, map) :: Paystack.Api.t
  def update(dispute_id, params),
    do: paystack().put("/dispute/#{dispute_id}", params)

  @doc """
  Provide evidence for a dispute
  """
  @spec add_evidence(String.t, map) :: Paystack.Api.t
  def add_evidence(dispute_id, params),
    do: paystack().post("/dispute/#{dispute_id}/evidence", params)

  @doc """
  Get URL to upload a dispute evidence.
  """
  @spec get_upload_url(String.t, String.t) :: Paystack.Api.t
  def get_upload_url(dispute_id, filename),
    do: paystack().get("/dispute/#{dispute_id}/upload_url?upload_filename=#{filename}")

  @doc """
  Resolve a dispute on your integration
  """
  @spec resolve(String, map) :: Paystack.Api.t
  def resolve(dispute_id, params),
    do: paystack().put("/dispute/#{dispute_id}/resolve", params)

  @doc """
  Export disputes available on your integration
  """
  @spec export(map | list) :: Paystack.Api.t
  def export(query_params),
    do: paystack().get("/dispute/export?" <> URI.encode_query(query_params))
end
