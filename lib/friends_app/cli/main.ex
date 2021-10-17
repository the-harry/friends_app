defmodule FriedsApp.CLI.Main do
  alias Mix.Shell.IO, as: Shell

  def start_app do
    Shell.cmd("clear")
    welcome_message()
    Shell.prompt("Hit enter to continue...")
    menu_choise()
  end

  defp welcome_message do
    Shell.info("----------------- FRIENDS APP -----------------")
    Shell.info("\tWelcome to your personal agenda.")
    Shell.info("-----------------------------------------------")
  end

  defp menu_choise do
    FriendsApp.CLI.Menu.Choise.start()
  end
end
