defmodule ExNrel.Solar.PVWatts do
  @moduledoc """
  PVWatts v5 wrapper

  Please refer to the [PVWatts documentation](https://developer.nrel.gov/docs/solar/pvwatts-v5/) for more details.

  ## Examples

      iex> ExNrel.Solar.PVWatts.get(lat: 39.323, lon: -94.23)

      iex> ExNrel.Solar.PVWatts.get(address: "1712 Main Street, Kansas City")

      iex> ExNrel.Solar.PVWatts.get(lat: 39.323, lon: -94.23, timeframe: "hourly")
  """
  use ExNrel.Api

  @defaults [
    system_capacity: 0.05,
    module_type: 0,
    losses: 0,
    array_type: 0,
    tilt: 0,
    azimuth: 0,
    address: nil,
    lat: nil,
    lon: nil,
    file_id: nil,
    dataset: nil,
    radius: 100,
    timeframe: "monthly",
    dc_ac_ratio: 1.1,
    gcr: 0.4,
    inv_eff: 96,
    callback: nil
  ]

  def get(opts \\ []) do
    opts = Keyword.merge(@defaults, opts)
    do_get("pvwatts/v5", opts)
  end
end
