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
      {:ok, %HTTPoison.Response{body: body, headers: headers, status_code: status}} when status in [200, 201] ->
        {:ok, parse_success_response(body, format), process_headers(headers)}

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

  defp process_headers(headers) when is_list(headers) and length(headers) > 0 do
    {_, total} = List.keyfind(headers, "X-RateLimit-Limit", 0)
    {_, rem} = List.keyfind(headers, "X-RateLimit-Remaining", 0)
    [total_limit: String.to_integer(total), remaining_limit: String.to_integer(rem)]
  end
  defp process_headers(_), do: [total_limit: 0, remaining_limit: 0]
end
