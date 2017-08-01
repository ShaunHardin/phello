defmodule PhelloWeb.CardController do
  use PhelloWeb, :controller

  alias Phello.Tracking
  alias Phello.Tracking.Card

  def index(conn, _params) do
    cards = Tracking.list_cards()
    render(conn, "index.html", cards: cards)
  end

  def new(conn, params) do
    board_id = params["board_id"]
    changeset = Tracking.change_card(%Card{}, %{board_id: board_id})
    render(conn, "new.html", changeset: changeset, board_id: board_id)
  end

  def create(conn, %{"card" => card_params}) do
    case Tracking.create_card(card_params) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card created successfully.")
        |> redirect(to: board_path(conn, :show, card.board_id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, board_id: card_params["board_id"])
    end
  end

  def show(conn, %{"id" => id}) do
    card = Tracking.get_card!(id)
    render(conn, "show.html", card: card)
  end

  def edit(conn, %{"id" => id}) do
    card = Tracking.get_card!(id)
    changeset = Tracking.change_card(card, %{})
    render(conn, "edit.html", card: card, changeset: changeset)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Tracking.get_card!(id)

    case Tracking.update_card(card_params) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card updated successfully.")
        |> redirect(to: board_path(conn, :show, card.board_id))
      {:error, changeset} ->
        render(conn, "edit.html", card: card, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "board_id" => board_id}) do
    Tracking.delete_card!(id)

    conn
    |> put_flash(:info, "Card deleted successfully.")
    |> redirect(to: board_path(conn, :index, board_id))
  end
end
