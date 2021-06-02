defmodule Benefits.Helper.EctoEnum do
  @moduledoc """
  Helper to handle EctoEnums.
  """

  def string_values(enum) do
    enum.__valid_values__() |> Enum.filter(fn(v) -> is_binary(v) end)
  end

  def random_string_value(enum) do
    enum
    |> string_values()
    |> Enum.random()
  end
end
