ExUnit.start
defmodule ServerTest do
  use ExUnit.Case, async: true
  doctest ElixirMaze

  setup_all context do
    IO.puts "Setting up : #{inspect(context[:case])}"
    :ok
  end

  test "Server creates maze." do
    maze =
      Maze.Server.create_maze(
        {
          :init,
          rows = 15,
          columns = 20,
          name ='My Maze',
          goal_position = [20,15],
          start_position = [1,1],
          paint_mode = :build,
          paint_interval = 200
        })

      assert maze.rows == 15
      assert maze.columns == 20
      assert maze.name == 'My Maze'
      assert maze.goal_position == %Maze.Position{x: 20, y: 15}
      assert maze.start_position == %Maze.Position{x: 1, y: 1}
      assert is_pid maze.build_path_state_pid
      assert is_pid maze.solve_path_state_pid

  end
end
