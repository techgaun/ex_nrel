defmodule ExNrel.Solar.Dataset do
  @moduledoc """
  Returns information on the closest climate data for a location.

  Please refer to the [Dataset documentation](http://developer.nrel.gov/docs/solar/data-query-v1/) for more details.

  ## Examples

      iex> ExNrel.Solar.Dataset.get(lat: 39.323, lon: -94.23, radius: 20)

      iex> ExNrel.Solar.Dataset.get(address: "1712 Main Street, Kansas City")

      iex> ExNrel.Solar.Dataset.get(lat: 39.323, lon: -94.23, all: 1)
  """
  use ExNrel.Api

  @defaults [
    address: nil,
    lat: nil,
    lon: nil,
    radius: 100,
    all: 0
  ]

  def get(opts \\ []) do
    opts = Keyword.merge(@defaults, opts)
    do_get("solar/data_query/v1", opts)
  end
end
