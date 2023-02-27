defmodule JResidenceWeb.CustomerLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.TenantsFixtures

  @create_attrs %{address: "some address", date_of_birth: "some date_of_birth", date_of_expiryphoto: "some date_of_expiryphoto", date_of_issue: "some date_of_issue", emergency_contact: "some emergency_contact", first_name: "some first_name", first_name_alt: "some first_name_alt", id_number: "some id_number", issue_by: "some issue_by", last_name: "some last_name", last_name_alt: "some last_name_alt", line: "some line", nationality: "some nationality", occupation: "some occupation", phone: "some phone", religion: "some religion", sex: "some sex"}
  @update_attrs %{address: "some updated address", date_of_birth: "some updated date_of_birth", date_of_expiryphoto: "some updated date_of_expiryphoto", date_of_issue: "some updated date_of_issue", emergency_contact: "some updated emergency_contact", first_name: "some updated first_name", first_name_alt: "some updated first_name_alt", id_number: "some updated id_number", issue_by: "some updated issue_by", last_name: "some updated last_name", last_name_alt: "some updated last_name_alt", line: "some updated line", nationality: "some updated nationality", occupation: "some updated occupation", phone: "some updated phone", religion: "some updated religion", sex: "some updated sex"}
  @invalid_attrs %{address: nil, date_of_birth: nil, date_of_expiryphoto: nil, date_of_issue: nil, emergency_contact: nil, first_name: nil, first_name_alt: nil, id_number: nil, issue_by: nil, last_name: nil, last_name_alt: nil, line: nil, nationality: nil, occupation: nil, phone: nil, religion: nil, sex: nil}

  defp create_customer(_) do
    customer = customer_fixture()
    %{customer: customer}
  end

  describe "Index" do
    setup [:create_customer]

    test "lists all customers", %{conn: conn, customer: customer} do
      {:ok, _index_live, html} = live(conn, ~p"/customers")

      assert html =~ "Listing Customers"
      assert html =~ customer.address
    end

    test "saves new customer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/customers")

      assert index_live |> element("a", "New Customer") |> render_click() =~
               "New Customer"

      assert_patch(index_live, ~p"/customers/new")

      assert index_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#customer-form", customer: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/customers")

      html = render(index_live)
      assert html =~ "Customer created successfully"
      assert html =~ "some address"
    end

    test "updates customer in listing", %{conn: conn, customer: customer} do
      {:ok, index_live, _html} = live(conn, ~p"/customers")

      assert index_live |> element("#customers-#{customer.id} a", "Edit") |> render_click() =~
               "Edit Customer"

      assert_patch(index_live, ~p"/customers/#{customer}/edit")

      assert index_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#customer-form", customer: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/customers")

      html = render(index_live)
      assert html =~ "Customer updated successfully"
      assert html =~ "some updated address"
    end

    test "deletes customer in listing", %{conn: conn, customer: customer} do
      {:ok, index_live, _html} = live(conn, ~p"/customers")

      assert index_live |> element("#customers-#{customer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#customers-#{customer.id}")
    end
  end

  describe "Show" do
    setup [:create_customer]

    test "displays customer", %{conn: conn, customer: customer} do
      {:ok, _show_live, html} = live(conn, ~p"/customers/#{customer}")

      assert html =~ "Show Customer"
      assert html =~ customer.address
    end

    test "updates customer within modal", %{conn: conn, customer: customer} do
      {:ok, show_live, _html} = live(conn, ~p"/customers/#{customer}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Customer"

      assert_patch(show_live, ~p"/customers/#{customer}/show/edit")

      assert show_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#customer-form", customer: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/customers/#{customer}")

      html = render(show_live)
      assert html =~ "Customer updated successfully"
      assert html =~ "some updated address"
    end
  end
end
