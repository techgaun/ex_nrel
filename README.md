# ExNrel

> NREL(https://developer.nrel.gov/) Api client for Elixir

## Installation

You can install it from hex as below:

  1. Add `ex_nrel` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ex_nrel, "~> 0.1.0"}]
    end
    ```

  2. Ensure `ex_nrel` is started before your application:

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

Output can be either `json` or `xml`. Currently, the `xml` output returns the string itself so necessary parsing must be done by the SDK user. You can also specify `format` as part of your queries in any of the API calls to get the data of specific format. For example, `ExNrel.Electricity.UtilityRate.get(lat: 39.323, lon: -94.23, format: "json")` explicitly returns `json` overriding the default configuration.

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

## Contribution

- You can add support for remaining APIs or fix the bug in existing ones.
- The XML parsing is not in-place.
- Rate limiting headers might be useful to handle rate limiting issues.

## Author

- [techgaun](https://github.com/techgaun)
