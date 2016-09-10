defmodule Maze.Room do

  defstruct position: %Maze.Position{}, visits_from: [], available_exits: [], used_exits: []


  @doc ~S"""
    Parses the given `line` into a command.

    ## Examples

        iex> 1+1
        2

    """

  def find_room(rooms, x, y) do
   Enum.find(rooms, fn(room) ->
                    (room.position.x == x) && (room.position.y ==y ) end)
  end

   @doc ~S"""
    Parses the given `line` into a command.

    ## Examples

        iex> 1+1
        2

    """



  def find_room(rooms, position) do
   Enum.find(rooms, fn(room) -> room.position == position end)
  end


  def visited?(room) do
    Enum.any? room.visits_from
  end


  def all_rooms_visited?(rooms)  do
    Enum.all?(rooms, fn(room) ->  visited?(room) end )
  end

  def times_used_to_exits(room) do
   Enum.group_by(room.available_exits, fn(exit) ->
                                         Enum.count(room.used_exits, fn(e) ->
                                          e == exit end     ) end)
   end

   def less_used_available_exits(room) do
      less_used_number = room
                         |> Maze.Room.times_used_to_exits
                         |> Map.keys
                         |> Enum.min
      Maze.Room.times_used_to_exits(room)[less_used_number]
   end

   def unused_available_exits(room) do
     Maze.Room.times_used_to_exits(room)[0] || []
   end

end

