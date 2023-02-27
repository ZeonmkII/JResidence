defmodule JResidenceWeb.DailyCustomerLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.TenantsFixtures

  @create_attrs %{b_current: "some b_current"}
  @update_attrs %{b_current: "some updated b_current"}
  @invalid_attrs %{b_current: nil}

  defp create_daily_customer(_) do
    daily_customer = daily_customer_fixture()
    %{daily_customer: daily_customer}
  end

  describe "Index" do
    setup [:create_daily_customer]

    test "lists all daily_customers", %{conn: conn, daily_customer: daily_customer} do
      {:ok, _index_live, html} = live(conn, ~p"/daily_customers")

      assert html =~ "Listing Daily customers"
      assert html =~ daily_customer.b_current
    end

    test "saves new daily_customer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_customers")

      assert index_live |> element("a", "New Daily customer") |> render_click() =~
               "New Daily customer"

      assert_patch(index_live, ~p"/daily_customers/new")

      assert index_live
             |> form("#daily_customer-form", daily_customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#daily_customer-form", daily_customer: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/daily_customers")

      html = render(index_live)
      assert html =~ "Daily customer created successfully"
      assert html =~ "some b_current"
    end

    test "updates daily_customer in listing", %{conn: conn, daily_customer: daily_customer} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_customers")

      assert index_live |> element("#daily_customers-#{daily_customer.id} a", "Edit") |> render_click() =~
               "Edit Daily customer"

      assert_patch(index_live, ~p"/daily_customers/#{daily_customer}/edit")

      assert index_live
             |> form("#daily_customer-form", daily_customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#daily_customer-form", daily_customer: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/daily_customers")

      html = render(index_live)
      assert html =~ "Daily customer updated successfully"
      assert html =~ "some updated b_current"
    end

    test "deletes daily_customer in listing", %{conn: conn, daily_customer: daily_customer} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_customers")

      assert index_live |> element("#daily_customers-#{daily_customer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#daily_customers-#{daily_customer.id}")
    end
  end

  describe "Show" do
    setup [:create_daily_customer]

    test "displays daily_customer", %{conn: conn, daily_customer: daily_customer} do
      {:ok, _show_live, html} = live(conn, ~p"/daily_customers/#{daily_customer}")

      assert html =~ "Show Daily customer"
      assert html =~ daily_customer.b_current
    end

    test "updates daily_customer within modal", %{conn: conn, daily_customer: daily_customer} do
      {:ok, show_live, _html} = live(conn, ~p"/daily_customers/#{daily_customer}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Daily customer"

      assert_patch(show_live, ~p"/daily_customers/#{daily_customer}/show/edit")

      assert show_live
             |> form("#daily_customer-form", daily_customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#daily_customer-form", daily_customer: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/daily_customers/#{daily_customer}")

      html = render(show_live)
      assert html =~ "Daily customer updated successfully"
      assert html =~ "some updated b_current"
    end
  end
end
