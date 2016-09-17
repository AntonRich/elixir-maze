defmodule ElixirMaze do
  use Application


  alias Maze.{Position, Room, Painter}
  # @width Painter.room_size *
  # @height 1024
  # @scale 4

  # def scale, do: @scale

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @doc ~S"""
  Parses the given `line` into a command.

  ## Examples

  iex> 1+1
  2

  """
  def start(_type, _args) do
    import Supervisor.Spec, warn: false


   # built_maze = Maze.initialize() |>  Maze.set_goal_and_start( [7,8], [2, 3]) |> Maze.build
   # build_path = built_maze.build_path |> Enum.reverse


    # canvas_options = [
    #   width: built_maze.columns * Painter.room_size * Painter.scale,
    #   height: built_maze.rows * Painter.room_size * Painter.scale,
    #   paint_interval: 500,
    #   painter_module: Maze.Painter,
    #   painter_state: %{maze: built_maze},
    #   brushes: %{
    #     black: {0, 0, 0, 255},
    #     red: {150, 0, 0, 255},
    #     green: {0, 150, 0, 255},
    #     blue: {0, 0, 150, 255},
    #     cyan: {0, 251, 255, 255},
    #     yellow: {255, 255, 0, 255}
    # ]


# Define workers and child supervisors to be supervised
    children =
      if Mix.env != :test do
        [
          # Starts a worker by calling: ElixirMaze.Worker.start_link(arg1, arg2, arg3)
          # worker(ElixirMaze.Worker, [arg1, arg2, arg3]),
          # supervisor(
          #   Supervisor,
          #   [ [worker(Turtles.Turtle, [ ], restart: :transient)],
          #     [name: Turtles.TurtleSupervisor, strategy: :simple_one_for_one] ]
          # ),
          # worker(Maze.Canvas, [built_maze,{@width, @height}, [name: Maze.Canvas]]),
          worker(Maze.Server, [test: 10 ]),
          # worker(
          #   Maze.Clock,
          #
          #   [
          #     build_path,
          #     0
          #     # Turtles.World,
          #     # {@width, @height},
          #     # turtle_starter,
          #     # [name: Turtles.Clock]
          #   ]
          # ),
          # worker(Canvas.GUI, [canvas_options])
        ]
      else
        [ ]
      end


    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirMaze.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
