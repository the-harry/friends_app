defmodule Mix.Tasks.Start do
  use Mix.Task

  @shortdoc "Starts [FRIENDS APP]"
  def run(_), do: FriendsApp.init()
end
