defmodule ExNrel.Electricity.UtilityRate do
  @moduledoc """
  This service returns annual average utility rates ($/kWH) for residential, commercial and industrial sectors as well as the local utility name for a specific location. This service does not return complex rate information.

  Please refer to the [Utility Rates documentation](http://developer.nrel.gov/docs/electricity/utility-rates-v3/) for more details.

  ## Examples

      iex> ExNrel.Electricity.UtilityRate.get(lat: 39.323, lon: -94.23)

      iex> ExNrel.Electricity.UtilityRate.get(address: "1712 Main Street, Kansas City")
  """

  use ExNrel.Api

  @defaults [
    address: nil,
    lat: nil,
    lon: nil
  ]

  def get(opts \\ []) do
    opts = Keyword.merge(@defaults, opts)
    do_get("utility_rates/v3", opts)
  end
end
