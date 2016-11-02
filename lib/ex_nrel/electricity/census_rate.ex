defmodule ExNrel.Electricity.CensusRate do
  @moduledoc """
  Given a location and Census Bureau region level (block, blockgroup, tract), return the Census Bureau ID, utility rate and company information.

  Please refer to the [Utility Rates by Census Region documentation](http://developer.nrel.gov/docs/electricity/census-rate-v3/) for more details.

  ## Examples

      iex> ExNrel.Electricity.CensusRate.get(id: 101, lat: 39.323, lon: -94.23)

      iex> ExNrel.Electricity.CensusRate.get(id: 101, address: "1712 Main Street, Kansas City")
  """

  use ExNrel.Api

  @defaults [
    id: nil,
    address: nil,
    lat: nil,
    lon: nil,
    region: "block"
  ]

  def get(opts \\ []) do
    opts = Keyword.merge(@defaults, opts)
    do_get("census_rate/v3", opts)
  end
end
