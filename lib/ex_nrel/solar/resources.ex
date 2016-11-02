defmodule ExNrel.Solar.Resources do
  @moduledoc """
  Returns various types of solar data for a location. The service currently returns data for average Direct Normal Irradiance, average Global Horizontal Irradiance, and average Tilt at Latitude.

  Please refer to the [Solar Resources documentation](http://developer.nrel.gov/docs/solar/solar-resource-v1/) for more details.

  ## Examples

      iex> ExNrel.Solar.Resources.get(lat: 39.323, lon: -94.23)

      iex> ExNrel.Solar.Resources.get(address: "1712 Main Street, Kansas City")
  """
  use ExNrel.Api

  @defaults [
    address: nil,
    lat: nil,
    lon: nil
  ]

  def get(opts \\ []) do
    opts = Keyword.merge(@defaults, opts)
    do_get("solar/solar_resource/v1", opts)
  end
end
