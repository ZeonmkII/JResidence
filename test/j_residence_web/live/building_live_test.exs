defmodule JResidenceWeb.BuildingLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.FacilitiesFixtures

  @create_attrs %{address: "some address", calc_type_electric: "120.5", calc_type_water: "120.5", name: "some name", phone: "some phone", tax_id: "some tax_id", unit_price_eletric: "120.5", unit_price_water: "120.5"}
  @update_attrs %{address: "some updated address", calc_type_electric: "456.7", calc_type_water: "456.7", name: "some updated name", phone: "some updated phone", tax_id: "some updated tax_id", unit_price_eletric: "456.7", unit_price_water: "456.7"}
  @invalid_attrs %{address: nil, calc_type_electric: nil, calc_type_water: nil, name: nil, phone: nil, tax_id: nil, unit_price_eletric: nil, unit_price_water: nil}

  defp create_building(_) do
    building = building_fixture()
    %{building: building}
  end

  describe "Index" do
    setup [:create_building]

    test "lists all buildings", %{conn: conn, building: building} do
      {:ok, _index_live, html} = live(conn, ~p"/buildings")

      assert html =~ "Listing Buildings"
      assert html =~ building.address
    end

    test "saves new building", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/buildings")

      assert index_live |> element("a", "New Building") |> render_click() =~
               "New Building"

      assert_patch(index_live, ~p"/buildings/new")

      assert index_live
             |> form("#building-form", building: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#building-form", building: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/buildings")

      html = render(index_live)
      assert html =~ "Building created successfully"
      assert html =~ "some address"
    end

    test "updates building in listing", %{conn: conn, building: building} do
      {:ok, index_live, _html} = live(conn, ~p"/buildings")

      assert index_live |> element("#buildings-#{building.id} a", "Edit") |> render_click() =~
               "Edit Building"

      assert_patch(index_live, ~p"/buildings/#{building}/edit")

      assert index_live
             |> form("#building-form", building: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#building-form", building: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/buildings")

      html = render(index_live)
      assert html =~ "Building updated successfully"
      assert html =~ "some updated address"
    end

    test "deletes building in listing", %{conn: conn, building: building} do
      {:ok, index_live, _html} = live(conn, ~p"/buildings")

      assert index_live |> element("#buildings-#{building.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#buildings-#{building.id}")
    end
  end

  describe "Show" do
    setup [:create_building]

    test "displays building", %{conn: conn, building: building} do
      {:ok, _show_live, html} = live(conn, ~p"/buildings/#{building}")

      assert html =~ "Show Building"
      assert html =~ building.address
    end

    test "updates building within modal", %{conn: conn, building: building} do
      {:ok, show_live, _html} = live(conn, ~p"/buildings/#{building}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Building"

      assert_patch(show_live, ~p"/buildings/#{building}/show/edit")

      assert show_live
             |> form("#building-form", building: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#building-form", building: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/buildings/#{building}")

      html = render(show_live)
      assert html =~ "Building updated successfully"
      assert html =~ "some updated address"
    end
  end
end
