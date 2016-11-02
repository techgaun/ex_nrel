defmodule ExNrel.Api do
  @moduledoc """
  API entrypoint that performs the API calls to the NREL API endpoints.

  TODO: Add examples
  """

  defmacro __using__(_opts) do
    quote do
      alias ExNrel.Parser
      import ExNrel.Utils
      use HTTPoison.Base

      @base_url "https://developer.nrel.gov/api"

      def build_url(path_arg, query_params) do
        {format, query_params} = query_params
          |> Map.pop(:format, "json")
        "#{@base_url}/#{path_arg}.#{format}?#{URI.encode_query(query_params)}"
      end

      def do_get(path_arg, query_params) when is_list(query_params), do: do_get(path_arg, Enum.into(query_params, %{}))
      def do_get(path_arg, query_params) do
        query_params = query_params
          |> Map.put(:api_key, api_key)
        path_arg
        |> build_url(query_params)
        |> __MODULE__.get(request_headers)
        |> Parser.parse(query_params[:format] || output_format)
      end
    end
  end
end
