defmodule ExNrel.Utils do
  @moduledoc false

  def api_key, do: Application.get_env(:ex_nrel, :api_key)
  def user_agent, do: [{"User-agent", "ExNrel"}]
  def compression, do: [{"Content-Encoding", "gzip"}]
  def request_headers, do: user_agent ++ compression
end
