defmodule ExNrel.Api do
  @moduledoc """
  API entrypoint that performs the API calls to the NREL API endpoints.

  TODO: Add examples
  """

  alias __MODULE__
  alias ExNrel.Parser
  import ExNrel.Utils
  use HTTPoison.Base

  @base_url "https://developer.nrel.gov/api"

  def build_url(path_arg, query_params) do
    "#{@base_url}/#{api_key}/#{path_arg}?#{URI.encode_query(query_params)}"
  end

  def read(path_arg, query_params \\ %{}) do
    path_arg
    |> build_url(query_params)
    |> Api.get(request_headers)
    |> Parser.parse
  end
end
