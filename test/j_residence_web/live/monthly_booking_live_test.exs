defmodule JResidenceWeb.MonthlyBookingLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.BookingsFixtures

  @create_attrs %{advance_payment: "120.5", check_in: "2023-02-26", check_out: "2023-02-26", deposit: "120.5", duration_day: 42, duration_month: 42, keycard_fees: "120.5", other_fees: "120.5", other_labels: "some other_labels", remaining: "120.5", remarks: "some remarks", rent_fees: "120.5", service_fees: "120.5", total: "120.5"}
  @update_attrs %{advance_payment: "456.7", check_in: "2023-02-27", check_out: "2023-02-27", deposit: "456.7", duration_day: 43, duration_month: 43, keycard_fees: "456.7", other_fees: "456.7", other_labels: "some updated other_labels", remaining: "456.7", remarks: "some updated remarks", rent_fees: "456.7", service_fees: "456.7", total: "456.7"}
  @invalid_attrs %{advance_payment: nil, check_in: nil, check_out: nil, deposit: nil, duration_day: nil, duration_month: nil, keycard_fees: nil, other_fees: nil, other_labels: nil, remaining: nil, remarks: nil, rent_fees: nil, service_fees: nil, total: nil}

  defp create_monthly_booking(_) do
    monthly_booking = monthly_booking_fixture()
    %{monthly_booking: monthly_booking}
  end

  describe "Index" do
    setup [:create_monthly_booking]

    test "lists all monthly_bookings", %{conn: conn, monthly_booking: monthly_booking} do
      {:ok, _index_live, html} = live(conn, ~p"/monthly_bookings")

      assert html =~ "Listing Monthly bookings"
      assert html =~ monthly_booking.other_labels
    end

    test "saves new monthly_booking", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_bookings")

      assert index_live |> element("a", "New Monthly booking") |> render_click() =~
               "New Monthly booking"

      assert_patch(index_live, ~p"/monthly_bookings/new")

      assert index_live
             |> form("#monthly_booking-form", monthly_booking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#monthly_booking-form", monthly_booking: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/monthly_bookings")

      html = render(index_live)
      assert html =~ "Monthly booking created successfully"
      assert html =~ "some other_labels"
    end

    test "updates monthly_booking in listing", %{conn: conn, monthly_booking: monthly_booking} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_bookings")

      assert index_live |> element("#monthly_bookings-#{monthly_booking.id} a", "Edit") |> render_click() =~
               "Edit Monthly booking"

      assert_patch(index_live, ~p"/monthly_bookings/#{monthly_booking}/edit")

      assert index_live
             |> form("#monthly_booking-form", monthly_booking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#monthly_booking-form", monthly_booking: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/monthly_bookings")

      html = render(index_live)
      assert html =~ "Monthly booking updated successfully"
      assert html =~ "some updated other_labels"
    end

    test "deletes monthly_booking in listing", %{conn: conn, monthly_booking: monthly_booking} do
      {:ok, index_live, _html} = live(conn, ~p"/monthly_bookings")

      assert index_live |> element("#monthly_bookings-#{monthly_booking.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#monthly_bookings-#{monthly_booking.id}")
    end
  end

  describe "Show" do
    setup [:create_monthly_booking]

    test "displays monthly_booking", %{conn: conn, monthly_booking: monthly_booking} do
      {:ok, _show_live, html} = live(conn, ~p"/monthly_bookings/#{monthly_booking}")

      assert html =~ "Show Monthly booking"
      assert html =~ monthly_booking.other_labels
    end

    test "updates monthly_booking within modal", %{conn: conn, monthly_booking: monthly_booking} do
      {:ok, show_live, _html} = live(conn, ~p"/monthly_bookings/#{monthly_booking}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Monthly booking"

      assert_patch(show_live, ~p"/monthly_bookings/#{monthly_booking}/show/edit")

      assert show_live
             |> form("#monthly_booking-form", monthly_booking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#monthly_booking-form", monthly_booking: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/monthly_bookings/#{monthly_booking}")

      html = render(show_live)
      assert html =~ "Monthly booking updated successfully"
      assert html =~ "some updated other_labels"
    end
  end
end
