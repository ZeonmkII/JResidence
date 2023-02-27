defmodule JResidenceWeb.FloorLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.FacilitiesFixtures

  @create_attrs %{floor_number: "some floor_number"}
  @update_attrs %{floor_number: "some updated floor_number"}
  @invalid_attrs %{floor_number: nil}

  defp create_floor(_) do
    floor = floor_fixture()
    %{floor: floor}
  end

  describe "Index" do
    setup [:create_floor]

    test "lists all floors", %{conn: conn, floor: floor} do
      {:ok, _index_live, html} = live(conn, ~p"/floors")

      assert html =~ "Listing Floors"
      assert html =~ floor.floor_number
    end

    test "saves new floor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/floors")

      assert index_live |> element("a", "New Floor") |> render_click() =~
               "New Floor"

      assert_patch(index_live, ~p"/floors/new")

      assert index_live
             |> form("#floor-form", floor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#floor-form", floor: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/floors")

      html = render(index_live)
      assert html =~ "Floor created successfully"
      assert html =~ "some floor_number"
    end

    test "updates floor in listing", %{conn: conn, floor: floor} do
      {:ok, index_live, _html} = live(conn, ~p"/floors")

      assert index_live |> element("#floors-#{floor.id} a", "Edit") |> render_click() =~
               "Edit Floor"

      assert_patch(index_live, ~p"/floors/#{floor}/edit")

      assert index_live
             |> form("#floor-form", floor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#floor-form", floor: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/floors")

      html = render(index_live)
      assert html =~ "Floor updated successfully"
      assert html =~ "some updated floor_number"
    end

    test "deletes floor in listing", %{conn: conn, floor: floor} do
      {:ok, index_live, _html} = live(conn, ~p"/floors")

      assert index_live |> element("#floors-#{floor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#floors-#{floor.id}")
    end
  end

  describe "Show" do
    setup [:create_floor]

    test "displays floor", %{conn: conn, floor: floor} do
      {:ok, _show_live, html} = live(conn, ~p"/floors/#{floor}")

      assert html =~ "Show Floor"
      assert html =~ floor.floor_number
    end

    test "updates floor within modal", %{conn: conn, floor: floor} do
      {:ok, show_live, _html} = live(conn, ~p"/floors/#{floor}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Floor"

      assert_patch(show_live, ~p"/floors/#{floor}/show/edit")

      assert show_live
             |> form("#floor-form", floor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#floor-form", floor: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/floors/#{floor}")

      html = render(show_live)
      assert html =~ "Floor updated successfully"
      assert html =~ "some updated floor_number"
    end
  end
end
