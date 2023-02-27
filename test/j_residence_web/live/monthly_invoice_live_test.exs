defmodule JResidenceWeb.MonthlyInvoiceLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.InvoicesFixtures

  @create_attrs %{advanced_payment: "120.5", bill_cycle: "2023-02-26", electric_end: "120.5", electric_start: "120.5", other_fees: "120.5", other_labels: "some other_labels", total: "120.5", water_end: "120.5", water_start: "120.5", water_unit: "120.5"}
  @update_attrs %{advanced_payment: "456.7", bill_cycle: "2023-02-27", electric_end: "456.7", electric_start: "456.7", other_fees: "456.7", other_labels: "some updated other_labels", total: "456.7", water_end: "456.7", water_start: "456.7", water_unit: "456.7"}
  @invalid_attrs %{advanced_payment: nil, bill_cycle: nil, electric_end: nil, electric_start: nil, other_fees: nil, other_labels: nil, total: nil, water_end: nil, water_start: nil, water_unit: nil}

  defp create_monthly_invoice(_) do
    monthly_invoice = monthly_invoice_fixture()
    %{monthly_invoice: monthly_invoice}
  end

  describe "Index" do
    setup [:create_monthly_invoice]

    test "lists all monthly_invoices", %{conn: conn, monthly_invoice: monthly_invoice} do
      {:ok, _index_live, html} = live(conn, ~p"/monthly_invoices")

      assert html =~ "Listing Monthly invoices"
      assert html =~ monthly_invoice.other_labels
    end

    test "saves new monthly_invoice", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_invoices")

      assert index_live |> element("a", "New Monthly invoice") |> render_click() =~
               "New Monthly invoice"

      assert_patch(index_live, ~p"/monthly_invoices/new")

      assert index_live
             |> form("#monthly_invoice-form", monthly_invoice: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#monthly_invoice-form", monthly_invoice: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/monthly_invoices")

      html = render(index_live)
      assert html =~ "Monthly invoice created successfully"
      assert html =~ "some other_labels"
    end

    test "updates monthly_invoice in listing", %{conn: conn, monthly_invoice: monthly_invoice} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_invoices")

      assert index_live |> element("#monthly_invoices-#{monthly_invoice.id} a", "Edit") |> render_click() =~
               "Edit Monthly invoice"

      assert_patch(index_live, ~p"/monthly_invoices/#{monthly_invoice}/edit")

      assert index_live
             |> form("#monthly_invoice-form", monthly_invoice: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#monthly_invoice-form", monthly_invoice: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/monthly_invoices")

      html = render(index_live)
      assert html =~ "Monthly invoice updated successfully"
      assert html =~ "some updated other_labels"
    end

    test "deletes monthly_invoice in listing", %{conn: conn, monthly_invoice: monthly_invoice} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_invoices")

      assert index_live |> element("#monthly_invoices-#{monthly_invoice.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#monthly_invoices-#{monthly_invoice.id}")
    end
  end

  describe "Show" do
    setup [:create_monthly_invoice]

    test "displays monthly_invoice", %{conn: conn, monthly_invoice: monthly_invoice} do
      {:ok, _show_live, html} = live(conn, ~p"/monthly_invoices/#{monthly_invoice}")

      assert html =~ "Show Monthly invoice"
      assert html =~ monthly_invoice.other_labels
    end

    test "updates monthly_invoice within modal", %{conn: conn, monthly_invoice: monthly_invoice} do
      {:ok, show_live, _html} = live(conn, ~p"/monthly_invoices/#{monthly_invoice}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Monthly invoice"

      assert_patch(show_live, ~p"/monthly_invoices/#{monthly_invoice}/show/edit")

      assert show_live
             |> form("#monthly_invoice-form", monthly_invoice: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#monthly_invoice-form", monthly_invoice: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/monthly_invoices/#{monthly_invoice}")

      html = render(show_live)
      assert html =~ "Monthly invoice updated successfully"
      assert html =~ "some updated other_labels"
    end
  end
end
