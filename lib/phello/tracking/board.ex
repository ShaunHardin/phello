defmodule Phello.Tracking.Board do
  use Phello.Schema
  import Ecto.Changeset

  schema "boards" do
    field :name, :string

    has_many :cards, Phello.Tracking.Card
    timestamps()
  end

  def changeset(%Phello.Tracking.Board{} = board, attrs) do
    board
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
