defmodule JResidenceWeb.MonthlyCustomerLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.TenantsFixtures

  @create_attrs %{b_contract: "some b_contract", b_current: "some b_current", b_tenant: "some b_tenant"}
  @update_attrs %{b_contract: "some updated b_contract", b_current: "some updated b_current", b_tenant: "some updated b_tenant"}
  @invalid_attrs %{b_contract: nil, b_current: nil, b_tenant: nil}

  defp create_monthly_customer(_) do
    monthly_customer = monthly_customer_fixture()
    %{monthly_customer: monthly_customer}
  end

  describe "Index" do
    setup [:create_monthly_customer]

    test "lists all monthly_customers", %{conn: conn, monthly_customer: monthly_customer} do
      {:ok, _index_live, html} = live(conn, ~p"/monthly_customers")

      assert html =~ "Listing Monthly customers"
      assert html =~ monthly_customer.b_contract
    end

    test "saves new monthly_customer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_customers")

      assert index_live |> element("a", "New Monthly customer") |> render_click() =~
               "New Monthly customer"

      assert_patch(index_live, ~p"/monthly_customers/new")

      assert index_live
             |> form("#monthly_customer-form", monthly_customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#monthly_customer-form", monthly_customer: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/monthly_customers")

      html = render(index_live)
      assert html =~ "Monthly customer created successfully"
      assert html =~ "some b_contract"
    end

    test "updates monthly_customer in listing", %{conn: conn, monthly_customer: monthly_customer} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_customers")

      assert index_live |> element("#monthly_customers-#{monthly_customer.id} a", "Edit") |> render_click() =~
               "Edit Monthly customer"

      assert_patch(index_live, ~p"/monthly_customers/#{monthly_customer}/edit")

      assert index_live
             |> form("#monthly_customer-form", monthly_customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#monthly_customer-form", monthly_customer: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/monthly_customers")

      html = render(index_live)
      assert html =~ "Monthly customer updated successfully"
      assert html =~ "some updated b_contract"
    end

    test "deletes monthly_customer in listing", %{conn: conn, monthly_customer: monthly_customer} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_customers")

      assert index_live |> element("#monthly_customers-#{monthly_customer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#monthly_customers-#{monthly_customer.id}")
    end
  end

  describe "Show" do
    setup [:create_monthly_customer]

    test "displays monthly_customer", %{conn: conn, monthly_customer: monthly_customer} do
      {:ok, _show_live, html} = live(conn, ~p"/monthly_customers/#{monthly_customer}")

      assert html =~ "Show Monthly customer"
      assert html =~ monthly_customer.b_contract
    end

    test "updates monthly_customer within modal", %{conn: conn, monthly_customer: monthly_customer} do
      {:ok, show_live, _html} = live(conn, ~p"/monthly_customers/#{monthly_customer}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Monthly customer"

      assert_patch(show_live, ~p"/monthly_customers/#{monthly_customer}/show/edit")

      assert show_live
             |> form("#monthly_customer-form", monthly_customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#monthly_customer-form", monthly_customer: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/monthly_customers/#{monthly_customer}")

      html = render(show_live)
      assert html =~ "Monthly customer updated successfully"
      assert html =~ "some updated b_contract"
    end
  end
end
