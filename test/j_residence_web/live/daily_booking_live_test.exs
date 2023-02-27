defmodule JResidenceWeb.DailyBookingLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.BookingsFixtures

  @create_attrs %{check_in: "2023-02-26", check_out: "2023-02-26", duration_day: 42, remarks: "some remarks"}
  @update_attrs %{check_in: "2023-02-27", check_out: "2023-02-27", duration_day: 43, remarks: "some updated remarks"}
  @invalid_attrs %{check_in: nil, check_out: nil, duration_day: nil, remarks: nil}

  defp create_daily_booking(_) do
    daily_booking = daily_booking_fixture()
    %{daily_booking: daily_booking}
  end

  describe "Index" do
    setup [:create_daily_booking]

    test "lists all daily_bookings", %{conn: conn, daily_booking: daily_booking} do
      {:ok, _index_live, html} = live(conn, ~p"/daily_bookings")

      assert html =~ "Listing Daily bookings"
      assert html =~ daily_booking.remarks
    end

    test "saves new daily_booking", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_bookings")

      assert index_live |> element("a", "New Daily booking") |> render_click() =~
               "New Daily booking"

      assert_patch(index_live, ~p"/daily_bookings/new")

      assert index_live
             |> form("#daily_booking-form", daily_booking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#daily_booking-form", daily_booking: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/daily_bookings")

      html = render(index_live)
      assert html =~ "Daily booking created successfully"
      assert html =~ "some remarks"
    end

    test "updates daily_booking in listing", %{conn: conn, daily_booking: daily_booking} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_bookings")

      assert index_live |> element("#daily_bookings-#{daily_booking.id} a", "Edit") |> render_click() =~
               "Edit Daily booking"

      assert_patch(index_live, ~p"/daily_bookings/#{daily_booking}/edit")

      assert index_live
             |> form("#daily_booking-form", daily_booking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#daily_booking-form", daily_booking: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/daily_bookings")

      html = render(index_live)
      assert html =~ "Daily booking updated successfully"
      assert html =~ "some updated remarks"
    end

    test "deletes daily_booking in listing", %{conn: conn, daily_booking: daily_booking} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_bookings")

      assert index_live |> element("#daily_bookings-#{daily_booking.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#daily_bookings-#{daily_booking.id}")
    end
  end

  describe "Show" do
    setup [:create_daily_booking]

    test "displays daily_booking", %{conn: conn, daily_booking: daily_booking} do
      {:ok, _show_live, html} = live(conn, ~p"/daily_bookings/#{daily_booking}")

      assert html =~ "Show Daily booking"
      assert html =~ daily_booking.remarks
    end

    test "updates daily_booking within modal", %{conn: conn, daily_booking: daily_booking} do
      {:ok, show_live, _html} = live(conn, ~p"/daily_bookings/#{daily_booking}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Daily booking"

      assert_patch(show_live, ~p"/daily_bookings/#{daily_booking}/show/edit")

      assert show_live
             |> form("#daily_booking-form", daily_booking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#daily_booking-form", daily_booking: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/daily_bookings/#{daily_booking}")

      html = render(show_live)
      assert html =~ "Daily booking updated successfully"
      assert html =~ "some updated remarks"
    end
  end
end
