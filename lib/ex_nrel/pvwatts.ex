defmodule ExNrel.PVWatts do
  @moduledoc """
  PVWatts v5 wrapper

  Please refer to the [PVWatts documentation](https://developer.nrel.gov/docs/solar/pvwatts-v5/) for more details.
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
    format = opts[:format] || "json"
    do_get("pvwatts/v5.#{format}", Keyword.delete(opts, :format))
  end
end
