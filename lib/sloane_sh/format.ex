defmodule SloaneSH.Format do
  @moduledoc """
  Functions to format various literals into human readable forms.
  """

  @millisecond 1000
  @second @millisecond ** 2
  @minute 60 * @second
  @hour 60 * @minute

  @max_depth 2

  def time(micro, depth \\ 0)
  def time(_micro, depth) when depth >= @max_depth, do: []

  time_units = [
    {@hour, "h"},
    {@minute, "m"},
    {@second, "s"},
    {@millisecond, "ms"}
  ]

  for {division, unit} <- time_units do
    def time(micro, depth) when micro >= unquote(division) do
      count = "#{div(micro, unquote(division))}#{unquote(unit)}"
      rem = rem(micro, unquote(division))
      [count, time(rem, depth + 1)]
    end
  end

  def time(micro, _depth) do
    "#{micro}μs"
  end
end
