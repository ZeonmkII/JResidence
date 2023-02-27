defmodule JResidenceWeb.MonthlyContractLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.BookingsFixtures

  @create_attrs %{advance_payment: "120.5", check_in: "2023-02-26", check_out: "2023-02-26", date_signed: "2023-02-26", deposit: "120.5", duration_day: 42, duration_month: 42, keycard_fees: "120.5", keycard_number: "some keycard_number", meter_electric: "120.5", meter_water: "120.5", other_fees: "120.5", other_labels: "some other_labels", remarks: "some remarks", rent_fees: "120.5", room_number: "some room_number", service_fees: "120.5"}
  @update_attrs %{advance_payment: "456.7", check_in: "2023-02-27", check_out: "2023-02-27", date_signed: "2023-02-27", deposit: "456.7", duration_day: 43, duration_month: 43, keycard_fees: "456.7", keycard_number: "some updated keycard_number", meter_electric: "456.7", meter_water: "456.7", other_fees: "456.7", other_labels: "some updated other_labels", remarks: "some updated remarks", rent_fees: "456.7", room_number: "some updated room_number", service_fees: "456.7"}
  @invalid_attrs %{advance_payment: nil, check_in: nil, check_out: nil, date_signed: nil, deposit: nil, duration_day: nil, duration_month: nil, keycard_fees: nil, keycard_number: nil, meter_electric: nil, meter_water: nil, other_fees: nil, other_labels: nil, remarks: nil, rent_fees: nil, room_number: nil, service_fees: nil}

  defp create_monthly_contract(_) do
    monthly_contract = monthly_contract_fixture()
    %{monthly_contract: monthly_contract}
  end

  describe "Index" do
    setup [:create_monthly_contract]

    test "lists all monthly_contracts", %{conn: conn, monthly_contract: monthly_contract} do
      {:ok, _index_live, html} = live(conn, ~p"/monthly_contracts")

      assert html =~ "Listing Monthly contracts"
      assert html =~ monthly_contract.keycard_number
    end

    test "saves new monthly_contract", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_contracts")

      assert index_live |> element("a", "New Monthly contract") |> render_click() =~
               "New Monthly contract"

      assert_patch(index_live, ~p"/monthly_contracts/new")

      assert index_live
             |> form("#monthly_contract-form", monthly_contract: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#monthly_contract-form", monthly_contract: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/monthly_contracts")

      html = render(index_live)
      assert html =~ "Monthly contract created successfully"
      assert html =~ "some keycard_number"
    end

    test "updates monthly_contract in listing", %{conn: conn, monthly_contract: monthly_contract} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_contracts")

      assert index_live |> element("#monthly_contracts-#{monthly_contract.id} a", "Edit") |> render_click() =~
               "Edit Monthly contract"

      assert_patch(index_live, ~p"/monthly_contracts/#{monthly_contract}/edit")

      assert index_live
             |> form("#monthly_contract-form", monthly_contract: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#monthly_contract-form", monthly_contract: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/monthly_contracts")

      html = render(index_live)
      assert html =~ "Monthly contract updated successfully"
      assert html =~ "some updated keycard_number"
    end

    test "deletes monthly_contract in listing", %{conn: conn, monthly_contract: monthly_contract} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_contracts")

      assert index_live |> element("#monthly_contracts-#{monthly_contract.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#monthly_contracts-#{monthly_contract.id}")
    end
  end

  describe "Show" do
    setup [:create_monthly_contract]

    test "displays monthly_contract", %{conn: conn, monthly_contract: monthly_contract} do
      {:ok, _show_live, html} = live(conn, ~p"/monthly_contracts/#{monthly_contract}")

      assert html =~ "Show Monthly contract"
      assert html =~ monthly_contract.keycard_number
    end

    test "updates monthly_contract within modal", %{conn: conn, monthly_contract: monthly_contract} do
      {:ok, show_live, _html} = live(conn, ~p"/monthly_contracts/#{monthly_contract}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Monthly contract"

      assert_patch(show_live, ~p"/monthly_contracts/#{monthly_contract}/show/edit")

      assert show_live
             |> form("#monthly_contract-form", monthly_contract: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#monthly_contract-form", monthly_contract: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/monthly_contracts/#{monthly_contract}")

      html = render(show_live)
      assert html =~ "Monthly contract updated successfully"
      assert html =~ "some updated keycard_number"
    end
  end
end
