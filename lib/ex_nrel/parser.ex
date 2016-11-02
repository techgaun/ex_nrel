defmodule ExNrel.Parser do
  @moduledoc """
  Generic parser to parse all the NREL api responses

  ToDO: XML support
  """

  @type status_code :: integer
  @type response :: {:ok, [struct]} | {:ok, struct} | :ok | {:error, map, status_code} | {:error, map} | any

  @doc """
  Parses the response from NREL API calls
  """
  @spec parse(tuple, String.t) :: response
  def parse(response, format) do
    case response do
      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}} when status in [200, 201] ->
        {:ok, parse_success_response(body, format)}

      {:ok, %HTTPoison.Response{body: _, headers: _, status_code: 204}} ->
        :ok

      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}} ->
        {:error, body, status}

      {:error, %HTTPoison.Error{id: _, reason: reason}} ->
        {:error, %{reason: reason}}
      _ ->
        response
    end
  end

  defp parse_success_response(body, "xml"), do: body
  defp parse_success_response(body, _), do: body |> Poison.decode!
end
