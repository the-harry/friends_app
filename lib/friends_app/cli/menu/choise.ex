defmodule FriendsApp.CLI.Menu.Choise do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.CLI.Menu.Items
  alias FriedsApp.DB.CSV

  def start do
    Shell.cmd("clear")
    Shell.info("Please pick an option:")

    menu_items = Items.all()
    find_menu_item_by_index = &Enum.at(menu_items, &1, :error)

    menu_items
    |> Enum.map(& &1.label)
    |> display_options()
    |> generate_question()
    |> Shell.prompt()
    |> parse_answer()
    |> find_menu_item_by_index.()
    |> confirm_menu_item()
    # |> validate_menu_index()
    |> confirm_message()
    |> CSV.perform()
  end

  defp display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)

    options
  end

  defp generate_question(options) do
    options = Enum.join(1..Enum.count(options), ",")

    "Please choose a number between: #{options}\n"
  end

  defp parse_answer(answer) do
    case Integer.parse(answer) do
      :error -> invalid_option()
      {option, _} -> option - 1
    end
  end

  defp confirm_menu_item(chosen_menu_item) do
    case chosen_menu_item do
      :error -> invalid_option()
      _ -> chosen_menu_item
    end
  end

  # defp validate_menu_index(index) do
  #   IO.puts("INDEX: #{index}")
  #
  #   case index < 1 do
  #     true -> invalid_option()
  #     _ -> index
  #   end
  # end

  defp confirm_message(chosen_menu_item) do
    Shell.cmd("clear")
    Shell.info("You choose: #{chosen_menu_item.label}")

    if Shell.yes?("Do you confim this action?") do
      Shell.info("... #{chosen_menu_item.label} ...")
      chosen_menu_item
    else
      start()
    end
  end

  defp invalid_option() do
    Shell.cmd("clear")
    Shell.info("Error, invalid option!")
    Shell.prompt("Press enter to try again...")
    start()
  end
end
