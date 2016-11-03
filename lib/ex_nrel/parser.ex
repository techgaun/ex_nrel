defmodule ExNrel.Parser do
  @moduledoc """
  Generic parser to parse all the NREL api responses

  ToDO: XML support
  """

  @type status_code :: integer
  @type response :: {:ok, [struct]} | {:ok, struct} | :ok | {:error, map, status_code} | {:error, map} | any

  @doc """
  Parses the response from NREL API calls based on output format

  XML format is parsed by floki and we try our best to convert it into poison.decode! like structure
  but it does not always work because of variations in response of different API endpoints.
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

  # TODO: fix _parse_recursive to be elixir-y :P
  defp parse_success_response(body, "xml") do
    result = body
      |> Floki.parse
    case result do
      [_h | [{"response", _, body}]] ->
        body
        |> Enum.reduce(%{}, fn {k, _, v}, acc ->
          Map.put(acc, k, _parse_recursive(v))
        end)
      _ ->
        result
    end
  end
  defp parse_success_response(body, _), do: body |> Poison.decode!

  defp _parse_recursive([v]) when is_bitstring(v), do: v
  defp _parse_recursive(v) when is_list(v) do
    v
    |> Enum.reduce(%{}, fn {k, _, v}, acc ->
      v = _parse_recursive(k, v)
      if Map.has_key?(acc, k) do
        existing_val = Map.get(acc, k)
        if existing_val |> is_list do
          Map.put(acc, k, existing_val ++ [v])
        else
          Map.put(acc, k, [existing_val] ++ [v])
        end
      else
        Map.put(acc, k, v)
      end
    end)
  end
  defp _parse_recursive(_k, v) do
    _parse_recursive(v)
  end

  defp process_headers(headers) when is_list(headers) and length(headers) > 0 do
    {_, total} = List.keyfind(headers, "X-RateLimit-Limit", 0)
    {_, rem} = List.keyfind(headers, "X-RateLimit-Remaining", 0)
    [total_limit: String.to_integer(total), remaining_limit: String.to_integer(rem)]
  end
  defp process_headers(_), do: [total_limit: 0, remaining_limit: 0]
end
