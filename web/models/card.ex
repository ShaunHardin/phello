defmodule Phello.Card do
  use Phello.Web, :model

  schema "cards" do
    field :name, :string
    field :description, :string
    belongs_to :board, Phello.Board

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :board_id])
    |> validate_required([:name, :description, :board_id])
  end
end
