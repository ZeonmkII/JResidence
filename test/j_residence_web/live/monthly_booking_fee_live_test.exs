defmodule JResidenceWeb.MonthlyBookingFeeLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.InvoicesFixtures

  @create_attrs %{booking_fees: "120.5", deposit: "120.5", other_fees: "120.5", other_labels: "some other_labels", remaining: "120.5", room_fees: "120.5", total: "120.5"}
  @update_attrs %{booking_fees: "456.7", deposit: "456.7", other_fees: "456.7", other_labels: "some updated other_labels", remaining: "456.7", room_fees: "456.7", total: "456.7"}
  @invalid_attrs %{booking_fees: nil, deposit: nil, other_fees: nil, other_labels: nil, remaining: nil, room_fees: nil, total: nil}

  defp create_monthly_booking_fee(_) do
    monthly_booking_fee = monthly_booking_fee_fixture()
    %{monthly_booking_fee: monthly_booking_fee}
  end

  describe "Index" do
    setup [:create_monthly_booking_fee]

    test "lists all monthly_booking_fees", %{conn: conn, monthly_booking_fee: monthly_booking_fee} do
      {:ok, _index_live, html} = live(conn, ~p"/monthly_booking_fees")

      assert html =~ "Listing Monthly booking fees"
      assert html =~ monthly_booking_fee.other_labels
    end

    test "saves new monthly_booking_fee", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_booking_fees")

      assert index_live |> element("a", "New Monthly booking fee") |> render_click() =~
               "New Monthly booking fee"

      assert_patch(index_live, ~p"/monthly_booking_fees/new")

      assert index_live
             |> form("#monthly_booking_fee-form", monthly_booking_fee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#monthly_booking_fee-form", monthly_booking_fee: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/monthly_booking_fees")

      html = render(index_live)
      assert html =~ "Monthly booking fee created successfully"
      assert html =~ "some other_labels"
    end

    test "updates monthly_booking_fee in listing", %{conn: conn, monthly_booking_fee: monthly_booking_fee} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_booking_fees")

      assert index_live |> element("#monthly_booking_fees-#{monthly_booking_fee.id} a", "Edit") |> render_click() =~
               "Edit Monthly booking fee"

      assert_patch(index_live, ~p"/monthly_booking_fees/#{monthly_booking_fee}/edit")

      assert index_live
             |> form("#monthly_booking_fee-form", monthly_booking_fee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#monthly_booking_fee-form", monthly_booking_fee: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/monthly_booking_fees")

      html = render(index_live)
      assert html =~ "Monthly booking fee updated successfully"
      assert html =~ "some updated other_labels"
    end

    test "deletes monthly_booking_fee in listing", %{conn: conn, monthly_booking_fee: monthly_booking_fee} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_booking_fees")

      assert index_live |> element("#monthly_booking_fees-#{monthly_booking_fee.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#monthly_booking_fees-#{monthly_booking_fee.id}")
    end
  end

  describe "Show" do
    setup [:create_monthly_booking_fee]

    test "displays monthly_booking_fee", %{conn: conn, monthly_booking_fee: monthly_booking_fee} do
      {:ok, _show_live, html} = live(conn, ~p"/monthly_booking_fees/#{monthly_booking_fee}")

      assert html =~ "Show Monthly booking fee"
      assert html =~ monthly_booking_fee.other_labels
    end

    test "updates monthly_booking_fee within modal", %{conn: conn, monthly_booking_fee: monthly_booking_fee} do
      {:ok, show_live, _html} = live(conn, ~p"/monthly_booking_fees/#{monthly_booking_fee}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Monthly booking fee"

      assert_patch(show_live, ~p"/monthly_booking_fees/#{monthly_booking_fee}/show/edit")

      assert show_live
             |> form("#monthly_booking_fee-form", monthly_booking_fee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#monthly_booking_fee-form", monthly_booking_fee: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/monthly_booking_fees/#{monthly_booking_fee}")

      html = render(show_live)
      assert html =~ "Monthly booking fee updated successfully"
      assert html =~ "some updated other_labels"
    end
  end
end
