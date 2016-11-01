defmodule ExNrel.PVWatts.Api do
  use ExNrel.Api

  def get(opts \\ []) do
    format = opts[:format] || "json"
    do_get("pvwatts/v5.#{format}", Keyword.delete(opts, :format))
  end
end
