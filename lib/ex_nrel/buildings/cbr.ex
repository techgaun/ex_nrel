defmodule ExNrel.Buildings.CBR do
  @moduledoc """
  Commercial Building Resources API wrapper

  Please refer to the [Commercial Building Resources](http://developer.nrel.gov/docs/buildings/commercial-building-resource-database-v1/)

  ## Examples

      iex> ExNrel.Buildings.CBR.get(portal: "Energy")

      iex> ExNrel.Buildings.CBR.events(portal: 5)

      iex> ExNrel.Buildings.CBR.vocabularies(name: "audience-types")
  """

  use ExNrel.Api

  @resource_defaults [
    {:s, nil},
    {:"audience-type", nil},
    {:"building-type", nil},
    {:collection, nil},
    {:"construction-type", nil},
    {:institution, nil},
    {:keyword, nil},
    {:portal, nil},
    {:"publication-type", nil},
    {:"resource-type", nil},
    {:state, nil},
    {:"tool-type", nil},
    {:topic, nil}
  ]

  @event_defaults [
    portal: nil,
    scope: nil,
    callback: nil
  ]

  def get(opts \\ []) do
    opts = Keyword.merge(@resource_defaults, opts)
    do_get("commercial-building-resources/v1/resources", opts)
  end

  def events(opts \\ []) do
    opts = Keyword.merge(@event_defaults, opts)
    do_get("commercial-building-resources/v1/events", opts)
  end

  def vocabularies(opts \\ []) do
    vocabulary = opts[:name] || "audience-types"
    do_get("commercial-building-resources/v1/#{vocabulary}", opts)
  end
end
