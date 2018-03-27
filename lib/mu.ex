defmodule Mu do
  def fibonacci(n) do
    List.first(HOF.repeat([0, 1], &fibonacci/2, n))
  end

  defp fibonacci(a, b) do
    [b, a + b]
  end
end
