defmodule JResidenceWeb.DailyInvoiceLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.InvoicesFixtures

  @create_attrs %{deposit: "120.5", keycard_fees: "120.5", other_fees: "120.5", other_labels: "some other_labels", remaining: "120.5", total: "120.5"}
  @update_attrs %{deposit: "456.7", keycard_fees: "456.7", other_fees: "456.7", other_labels: "some updated other_labels", remaining: "456.7", total: "456.7"}
  @invalid_attrs %{deposit: nil, keycard_fees: nil, other_fees: nil, other_labels: nil, remaining: nil, total: nil}

  defp create_daily_invoice(_) do
    daily_invoice = daily_invoice_fixture()
    %{daily_invoice: daily_invoice}
  end

  describe "Index" do
    setup [:create_daily_invoice]

    test "lists all daily_invoices", %{conn: conn, daily_invoice: daily_invoice} do
      {:ok, _index_live, html} = live(conn, ~p"/daily_invoices")

      assert html =~ "Listing Daily invoices"
      assert html =~ daily_invoice.other_labels
    end

    test "saves new daily_invoice", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_invoices")

      assert index_live |> element("a", "New Daily invoice") |> render_click() =~
               "New Daily invoice"

      assert_patch(index_live, ~p"/daily_invoices/new")

      assert index_live
             |> form("#daily_invoice-form", daily_invoice: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#daily_invoice-form", daily_invoice: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/daily_invoices")

      html = render(index_live)
      assert html =~ "Daily invoice created successfully"
      assert html =~ "some other_labels"
    end

    test "updates daily_invoice in listing", %{conn: conn, daily_invoice: daily_invoice} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_invoices")

      assert index_live |> element("#daily_invoices-#{daily_invoice.id} a", "Edit") |> render_click() =~
               "Edit Daily invoice"

      assert_patch(index_live, ~p"/daily_invoices/#{daily_invoice}/edit")

      assert index_live
             |> form("#daily_invoice-form", daily_invoice: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#daily_invoice-form", daily_invoice: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/daily_invoices")

      html = render(index_live)
      assert html =~ "Daily invoice updated successfully"
      assert html =~ "some updated other_labels"
    end

    test "deletes daily_invoice in listing", %{conn: conn, daily_invoice: daily_invoice} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_invoices")

      assert index_live |> element("#daily_invoices-#{daily_invoice.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#daily_invoices-#{daily_invoice.id}")
    end
  end

  describe "Show" do
    setup [:create_daily_invoice]

    test "displays daily_invoice", %{conn: conn, daily_invoice: daily_invoice} do
      {:ok, _show_live, html} = live(conn, ~p"/daily_invoices/#{daily_invoice}")

      assert html =~ "Show Daily invoice"
      assert html =~ daily_invoice.other_labels
    end

    test "updates daily_invoice within modal", %{conn: conn, daily_invoice: daily_invoice} do
      {:ok, show_live, _html} = live(conn, ~p"/daily_invoices/#{daily_invoice}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Daily invoice"

      assert_patch(show_live, ~p"/daily_invoices/#{daily_invoice}/show/edit")

      assert show_live
             |> form("#daily_invoice-form", daily_invoice: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#daily_invoice-form", daily_invoice: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/daily_invoices/#{daily_invoice}")

      html = render(show_live)
      assert html =~ "Daily invoice updated successfully"
      assert html =~ "some updated other_labels"
    end
  end
end
