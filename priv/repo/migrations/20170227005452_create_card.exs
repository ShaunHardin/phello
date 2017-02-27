defmodule Phello.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :name, :string
      add :description, :text
      add :board_id, references(:boards, on_delete: :nothing)

      timestamps()
    end
    create index(:cards, [:board_id])

  end
end
