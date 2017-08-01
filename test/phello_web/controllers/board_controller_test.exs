defmodule PhelloWeb.BoardControllerTest do
  use PhelloWeb.ConnCase

  alias Phello.Tracking

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:board) do
    {:ok, board} = Tracking.create_board(@create_attrs)
    board
  end

  describe "index" do
    test "lists all boards", %{conn: conn} do
      conn = get conn, board_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing boards"
    end
  end

  describe "new board" do
    test "renders form", %{conn: conn} do
      conn = get conn, board_path(conn, :new)
      assert html_response(conn, 200) =~ "New board"
    end
  end

  describe "create board" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, board_path(conn, :create), board: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == board_path(conn, :show, id)

      conn = get conn, board_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show board"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, board_path(conn, :create), board: @invalid_attrs
      assert html_response(conn, 200) =~ "New board"
    end
  end

  describe "edit board" do
    setup [:create_board]

    test "renders form for editing chosen board", %{conn: conn, board: board} do
      conn = get conn, board_path(conn, :edit, board)
      assert html_response(conn, 200) =~ "Edit board"
    end
  end

  describe "update board" do
    setup [:create_board]

    test "redirects when data is valid", %{conn: conn, board: board} do
      conn = put conn, board_path(conn, :update, board), board: @update_attrs
      assert redirected_to(conn) == board_path(conn, :show, board)

      conn = get conn, board_path(conn, :show, board)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, board: board} do
      conn = put conn, board_path(conn, :update, board), board: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit board"
    end
  end

  describe "delete board" do
    setup [:create_board]

    test "deletes chosen board", %{conn: conn, board: board} do
      conn = delete conn, board_path(conn, :delete, board)
      assert redirected_to(conn) == board_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, board_path(conn, :show, board)
      end
    end
  end

  defp create_board(_) do
    board = fixture(:board)
    {:ok, board: board}
  end
end

