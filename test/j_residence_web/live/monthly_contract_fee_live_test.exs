defmodule JResidenceWeb.MonthlyContractFeeLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.ReceiptsFixtures

  @create_attrs %{advance_payment: "120.5", deposit: "120.5", keycard_fees: "120.5", other_fees: "120.5", other_labels: "some other_labels", total: "120.5"}
  @update_attrs %{advance_payment: "456.7", deposit: "456.7", keycard_fees: "456.7", other_fees: "456.7", other_labels: "some updated other_labels", total: "456.7"}
  @invalid_attrs %{advance_payment: nil, deposit: nil, keycard_fees: nil, other_fees: nil, other_labels: nil, total: nil}

  defp create_monthly_contract_fee(_) do
    monthly_contract_fee = monthly_contract_fee_fixture()
    %{monthly_contract_fee: monthly_contract_fee}
  end

  describe "Index" do
    setup [:create_monthly_contract_fee]

    test "lists all monthly_contract_fees", %{conn: conn, monthly_contract_fee: monthly_contract_fee} do
      {:ok, _index_live, html} = live(conn, ~p"/monthly_contract_fees")

      assert html =~ "Listing Monthly contract fees"
      assert html =~ monthly_contract_fee.other_labels
    end

    test "saves new monthly_contract_fee", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_contract_fees")

      assert index_live |> element("a", "New Monthly contract fee") |> render_click() =~
               "New Monthly contract fee"

      assert_patch(index_live, ~p"/monthly_contract_fees/new")

      assert index_live
             |> form("#monthly_contract_fee-form", monthly_contract_fee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#monthly_contract_fee-form", monthly_contract_fee: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/monthly_contract_fees")

      html = render(index_live)
      assert html =~ "Monthly contract fee created successfully"
      assert html =~ "some other_labels"
    end

    test "updates monthly_contract_fee in listing", %{conn: conn, monthly_contract_fee: monthly_contract_fee} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_contract_fees")

      assert index_live |> element("#monthly_contract_fees-#{monthly_contract_fee.id} a", "Edit") |> render_click() =~
               "Edit Monthly contract fee"

      assert_patch(index_live, ~p"/monthly_contract_fees/#{monthly_contract_fee}/edit")

      assert index_live
             |> form("#monthly_contract_fee-form", monthly_contract_fee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#monthly_contract_fee-form", monthly_contract_fee: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/monthly_contract_fees")

      html = render(index_live)
      assert html =~ "Monthly contract fee updated successfully"
      assert html =~ "some updated other_labels"
    end

    test "deletes monthly_contract_fee in listing", %{conn: conn, monthly_contract_fee: monthly_contract_fee} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_contract_fees")

      assert index_live |> element("#monthly_contract_fees-#{monthly_contract_fee.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#monthly_contract_fees-#{monthly_contract_fee.id}")
    end
  end

  describe "Show" do
    setup [:create_monthly_contract_fee]

    test "displays monthly_contract_fee", %{conn: conn, monthly_contract_fee: monthly_contract_fee} do
      {:ok, _show_live, html} = live(conn, ~p"/monthly_contract_fees/#{monthly_contract_fee}")

      assert html =~ "Show Monthly contract fee"
      assert html =~ monthly_contract_fee.other_labels
    end

    test "updates monthly_contract_fee within modal", %{conn: conn, monthly_contract_fee: monthly_contract_fee} do
      {:ok, show_live, _html} = live(conn, ~p"/monthly_contract_fees/#{monthly_contract_fee}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Monthly contract fee"

      assert_patch(show_live, ~p"/monthly_contract_fees/#{monthly_contract_fee}/show/edit")

      assert show_live
             |> form("#monthly_contract_fee-form", monthly_contract_fee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#monthly_contract_fee-form", monthly_contract_fee: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/monthly_contract_fees/#{monthly_contract_fee}")

      html = render(show_live)
      assert html =~ "Monthly contract fee updated successfully"
      assert html =~ "some updated other_labels"
    end
  end
end
