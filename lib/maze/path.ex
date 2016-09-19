defmodule Maze.Path  do
  alias Maze.{Room,Painter}

    defstruct maze: nil,
              path: nil,
              current_position: nil,
              current_room: nil,
              previous_position: nil,
              previous_room: nil

    def empty do
      %__MODULE__{ }
    end
    # Client API
    def start_link(maze) do
      Agent.start_link(fn  -> init(maze) end, name: __MODULE__)
    end

    def get_path do

      Agent.get(__MODULE__,fn state -> state end)
      # {:lala,:koko}
    end

    def move_to_next_position do
      Agent.get_and_update(__MODULE__, fn state ->
        new_previous_position = List.first state.path
        new_previous_room = Room.find_room(state.maze.rooms, new_previous_position)
        rest_of_path =  List.delete( state.path, List.first state.path)
        [ new_current_position | rest_of_rest_of_path ] = rest_of_path
        new_current_room = Room.find_room(state.maze.rooms, new_current_position)

        new_state = %__MODULE__{ maze: state.maze,
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
      first_room = Room.find_room(maze.rooms, first_position)

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