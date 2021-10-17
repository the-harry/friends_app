defmodule FriendsApp.CLI.Menu.Items do
  alias FriendsApp.CLI.Menu

  def all do
    [
      %Menu{label: "Create friend", id: :create},
      %Menu{label: "List friends", id: :read},
      %Menu{label: "Update friend", id: :update},
      %Menu{label: "Delete friend", id: :delete}
    ]
  end
end
