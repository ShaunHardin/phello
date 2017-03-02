defmodule Phello.CardTest do
  use Phello.ModelCase

  alias Phello.Card

  @valid_attrs %{description: "some content", name: "some content", board_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Card.changeset(%Card{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Card.changeset(%Card{}, @invalid_attrs)
    refute changeset.valid?
  end
end
