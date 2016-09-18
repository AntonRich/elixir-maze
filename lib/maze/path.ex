defmodule Maze.Path do
  alias Maze.Painter
  # defmodule Changes do
    #   defstruct clears: [ ], plants: [ ], turtles: [ ]
    #
    def empty do
      %__MODULE__{ }
    end
    # end




    defstruct  path: nil,
    current_position: nil,
    current_room: nil,
    previous_position: nil,
    previous_room: nil


    # Client API
    def start_link(maze, options = [ name: __MODULE__]) do
      Agent.start_link(fn  -> init(maze) end, options)
    end

    def get_path do
      Agent.get(__MODULE__, &(&1))
    end

    def move_to_next_position do
      Agent.get_and_update(__MODULE__, fn state ->
        new_previous_position = List.first state.path
        new_previous_room = Room.find_room(state.maze.rooms, new_previous_position)
        rest_of_path =  List.delete( state.path, List.first state.path)
        [ new_current_position | rest_of_rest_of_path ] = rest_of_path
        new_current_room = Room.find_room(state.maze.rooms, new_current_position)

        new_state = %__MODULE__{ maze: maze,
          path: rest_of_path,
          current_position: new_current_position,
          current_room: new_current_room,
          previous_position: new_previous_position,
          previous_room:  new_previous_room
        }

        {state, new_state}

      end)
    end
    #



    # Server API

    defp init(maze) do
      path = maze.build_path |> Enum.reverse
      first_position = path  |> List.first
      %__MODULE__{
        maze: maze,
        path: path ,
        current_position: first_position ,
        current_room: first_room,
        previous_position: nil,
        previous_room: nil
      }
    end



end
