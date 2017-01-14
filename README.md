# ExNrel

[![Build Status](https://semaphoreci.com/api/v1/samaracharya/ex_nrel/branches/master/badge.svg)](https://semaphoreci.com/samaracharya/ex_nrel) [![Hex version](https://img.shields.io/hexpm/v/ex_nrel.svg "Hex version")](https://hex.pm/packages/ex_nrel) ![Hex downloads](https://img.shields.io/hexpm/dt/ex_nrel.svg "Hex downloads")

> NREL(https://developer.nrel.gov/) Api client for Elixir

## Installation

You can install it from hex as below:

- Add `ex_nrel` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:ex_nrel, "~> 0.2.0"}]
  end
  ```

- Ensure `ex_nrel` is started before your application:

  ```elixir
  def application do
  [applications: [:ex_nrel]]
  end
  ```

## Usage

### Configuration

In your configuration, add the following block:

```
config :ex_nrel,
  api_key: System.get_env("NREL_API_KEY"),
  format: "json"
```

Output can be either `json` or `xml`. You can also specify `format` as part of your queries in any of the API calls to get the data of specific format. For example, `ExNrel.Electricity.UtilityRate.get(lat: 39.323, lon: -94.23, format: "json")` explicitly returns `json` overriding the default configuration.

ExNrel supports following APIs offered by NREL.

### [Buildings](http://developer.nrel.gov/docs/buildings/)

#### [Commerial Building Resources](http://developer.nrel.gov/docs/buildings/commercial-building-resource-database-v1/) (resources, events and vocabularies)

```elixir
iex> ExNrel.Buildings.CBR.get(portal: "Energy")

iex> ExNrel.Buildings.CBR.events(portal: 5)

iex> ExNrel.Buildings.CBR.vocabularies(name: "audience-types")
```

### [Electricity](http://developer.nrel.gov/docs/electricity/)

#### [Energy Incentives (Version 2)](http://developer.nrel.gov/docs/electricity/energy-incentives-v2/)

```elixir
iex> ExNrel.Electricity.EnergyIncentives.get(lat: 39.323, lon: -94.23)

iex> ExNrel.Electricity.EnergyIncentives.get(lat: 39.323, lon: -94.23, category: "hvac")

iex> ExNrel.Electricity.EnergyIncentives.get(lat: 39.323, lon: -94.23, category: "hvac", technology: "air_conditioners")

iex> ExNrel.Electricity.EnergyIncentives.get(address: "1712 Main Street, Kansas City")
```

#### [Utility Rates](http://developer.nrel.gov/docs/electricity/utility-rates-v3/)

```elixir
iex> ExNrel.Electricity.UtilityRate.get(lat: 39.323, lon: -94.23)

iex> ExNrel.Electricity.UtilityRate.get(address: "1712 Main Street, Kansas City")
```

#### [Utility Rates by Census Region](http://developer.nrel.gov/docs/electricity/census-rate-v3/)

```elixir
iex> ExNrel.Electricity.CensusRate.get(id: 101, lat: 39.323, lon: -94.23)

iex> ExNrel.Electricity.CensusRate.get(id: 101, address: "1712 Main Street, Kansas City")
```

### [Solar](http://developer.nrel.gov/docs/solar/)

#### [PVWatts (Version 5)](https://developer.nrel.gov/docs/solar/pvwatts-v5/)

```elixir
iex> ExNrel.Solar.PVWatts.get(lat: 39.323, lon: -94.23)

iex> ExNrel.Solar.PVWatts.get(address: "1712 Main Street, Kansas City")

iex> ExNrel.Solar.PVWatts.get(lat: 39.323, lon: -94.23, timeframe: "hourly")
```

#### [Solar Dataset Query](http://developer.nrel.gov/docs/solar/data-query-v1/)

```elixir
iex> ExNrel.Solar.Dataset.get(lat: 39.323, lon: -94.23, radius: 20)

iex> ExNrel.Solar.Dataset.get(address: "1712 Main Street, Kansas City")

iex> ExNrel.Solar.Dataset.get(lat: 39.323, lon: -94.23, all: 1)
```

#### [Solar Resource Data](http://developer.nrel.gov/docs/solar/solar-resource-v1/)

```elixir
iex> ExNrel.Solar.Resources.get(lat: 39.323, lon: -94.23)

iex> ExNrel.Solar.Resources.get(address: "1712 Main Street, Kansas City")
```

### API Response

The response from the API is parsed through a simple parser. For JSON, the `poison` package does the job and for XML, currently ExNrel returns the body as string.

The response can be one of:

```elixir
{:ok, body, [total_limit: api_rate_limit, remaining_limit: api_remaining_limit]}

{:error, %{reason: "failure_reason"}}
```

## Contribution

- You can add support for remaining APIs or fix the bug in existing ones.
- ~~The XML parsing is not in-place.~~
- ~~Rate limiting headers might be useful to handle rate limiting issues.~~ (Part of response in ExNrel >= 0.2.0)

## Author

- [techgaun](https://github.com/techgaun)
