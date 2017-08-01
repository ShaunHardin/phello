defmodule Phello.Tracking.Card do
  use Phello.Schema

  schema "cards" do
    field :name, :string
    field :description, :string
    belongs_to :board, Phello.Tracking.Board

    timestamps()
  end

  def changeset(%Phello.Tracking.Card{} = card, attrs) do
    card
    |> cast(attrs, [:name, :description, :board_id])
    |> validate_required([:name, :description, :board_id])
  end
end
