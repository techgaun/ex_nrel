defmodule ExNrel.Electricity.EnergyIncentives do
  @moduledoc """
  This service lists the incentives found in the [DSIRE](http://www.dsireusa.org/) quantitative spreadsheet by location.

  Please refer to the [Energy Incentives documentation](http://developer.nrel.gov/docs/electricity/energy-incentives-v2/) for more details.

  ## Examples

      iex> ExNrel.Electricity.EnergyIncentives.get(lat: 39.323, lon: -94.23)

      iex> ExNrel.Electricity.EnergyIncentives.get(lat: 39.323, lon: -94.23, category: "hvac")

      iex> ExNrel.Electricity.EnergyIncentives.get(lat: 39.323, lon: -94.23, category: "hvac", technology: "air_conditioners")

      iex> ExNrel.Electricity.EnergyIncentives.get(address: "1712 Main Street, Kansas City")
  """

  use ExNrel.Api

  @defaults [
    address: nil,
    lat: nil,
    lon: nil,
    category: nil,
    technology: nil
  ]

  def get(opts \\ []) do
    opts = Keyword.merge(@defaults, opts)
    do_get("energy_incentives/v2/dsire", opts)
  end
end
