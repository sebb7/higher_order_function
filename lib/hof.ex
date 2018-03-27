defmodule HOF do
  def repeat(list_of_args, _function, 0) do
    list_of_args
  end
  def repeat(list_of_args, function, reps) do
    new_list_of_args = apply(function, list_of_args)
    repeat(new_list_of_args, function, reps - 1)
  end
end
