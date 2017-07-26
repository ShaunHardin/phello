defmodule Phello.Tracking do
  @moduledoc """
  The boundary for the Tracking system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Phello.Repo

  alias Phello.Tracking.Board

  def list_boards do
    Repo.all(Board)
  end

  def get_board!(id) do
    Repo.get!(Board, id)
    |> Repo.preload([:cards])
  end

  def create_board(attrs \\ %{}) do
    %Board{}
    |> change_board(attrs)
    |> Repo.insert()
  end

  def update_board(id, attrs \\ %{}) do
    board = get_board!(id)
    change_board(board, attrs)
    |> Repo.update()
  end

  def delete_board!(id) do
    get_board!(id)
    |> Repo.delete
  end

  def change_board(%Board{} = board, attrs) do
    Board.changeset(board, attrs)
  end

  alias Phello.Tracking.Card

  def list_cards do
    Repo.all(Card)
  end

  def get_card!(id), do: Repo.get!(Card, id)

  def create_card(attrs \\ %{}) do
    %Card{}
    |> change_card(attrs)
    |> Repo.insert()
  end

  def update_card(id, attrs \\ %{}) do
    card = get_card!(id)
    change_card(card, attrs)
    |> Repo.update()
  end

  def delete_card!(id) do
    get_card!(id)
    |> Repo.delete()
  end

  def change_card(%Card{} = card, attrs) do
    Card.changeset(card, attrs)
  end
end
