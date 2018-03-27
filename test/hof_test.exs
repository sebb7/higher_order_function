defmodule HofTest do
  use ExUnit.Case

  test "simple input + output" do
    assert HOF.repeat([1, 2, 3], fn a, b, c -> [a + 2, b + 2, c + 2] end, 0) ==
      [1, 2, 3]
    assert HOF.repeat([1, 2, 3], fn a, b, c -> [a + 2, b + 2, c + 2] end, 1) ==
      [3, 4, 5]
    assert HOF.repeat([1, 2, 3], fn a, b, c -> [a * 2, b * 2, c * 2] end, 2) ==
      [4, 8, 12]
  end

  test "receive message as function repeat/3 is run once" do
    HOF.repeat([0, 0], &send_msg_pass_same_list/2, 1)
    assert_received {:ok, _}
  end

  test "receive no message when repeat/3 is run with 0 reps" do
    HOF.repeat([0, 0], &send_msg_pass_same_list/2, 0)
    refute_receive {:ok, _}
  end

  test "receive as many messages as many times repeat/3 is run" do
    reps = Enum.random(0..1000)
    HOF.repeat([0, 0], &send_msg_pass_same_list/2, reps)

    case reps do
      0 ->
        refute_receive {:ok, _}
      _ ->
        for _n <- 1..reps, do: assert_received {:ok, _}
    end
  end

  defp send_msg_pass_same_list(a, b) do
    send self(), {:ok, [a, b]}
    [a, b]
  end
end
