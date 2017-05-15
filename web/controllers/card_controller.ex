defmodule Phello.CardController do
  require Logger
  use Phello.Web, :controller

  alias Phello.Card

  def index(conn, _params) do
    cards = Repo.all(Card)
    render(conn, "index.html", cards: cards)
  end

  def new(conn, params) do
    board_id = params["board_id"]
    changeset = Card.changeset(%Card{board_id: board_id})
    render(conn, "new.html", changeset: changeset, board_id: board_id)
  end

  def create(conn, %{"card" => card_params}) do
    changeset = Card.changeset(%Card{}, card_params)

    case Repo.insert(changeset) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card created successfully.")
        |> redirect(to: board_path(conn, :show, card.board_id))
      {:error, changeset} ->
        Logger.debug("Changeset: #{inspect(changeset)}")
        Logger.debug("Data: #{inspect(changeset.data)}")
        render(conn, "new.html", changeset: changeset, board_id: card_params["board_id"])
    end
  end

  def show(conn, %{"id" => id}) do
    card = Repo.get!(Card, id)
    render(conn, "show.html", card: card)
  end

  def edit(conn, %{"id" => id}) do
    card = Repo.get!(Card, id)
    changeset = Card.changeset(card)
    render(conn, "edit.html", card: card, changeset: changeset)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Repo.get!(Card, id)
    changeset = Card.changeset(card, card_params)

    case Repo.update(changeset) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card updated successfully.")
        |> redirect(to: board_path(conn, :show, card.board_id))
      {:error, changeset} ->
        render(conn, "edit.html", card: card, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "board_id" => board_id}) do
    card = Repo.get!(Card, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(card)

    conn
    |> put_flash(:info, "Card deleted successfully.")
    |> redirect(to: board_path(conn, :index, board_id))
  end
end
