defmodule JResidenceWeb.DailyBookingFeeLiveTest do
  use JResidenceWeb.ConnCase

  import Phoenix.LiveViewTest
  import JResidence.InvoicesFixtures

  @create_attrs %{booking_fees: "120.5", deposit: "120.5", other_fees: "120.5", other_labels: "some other_labels", remaining: "120.5", room_fees: "120.5", total: "120.5"}
  @update_attrs %{booking_fees: "456.7", deposit: "456.7", other_fees: "456.7", other_labels: "some updated other_labels", remaining: "456.7", room_fees: "456.7", total: "456.7"}
  @invalid_attrs %{booking_fees: nil, deposit: nil, other_fees: nil, other_labels: nil, remaining: nil, room_fees: nil, total: nil}

  defp create_daily_booking_fee(_) do
    daily_booking_fee = daily_booking_fee_fixture()
    %{daily_booking_fee: daily_booking_fee}
  end

  describe "Index" do
    setup [:create_daily_booking_fee]

    test "lists all daily_booking_fees", %{conn: conn, daily_booking_fee: daily_booking_fee} do
      {:ok, _index_live, html} = live(conn, ~p"/daily_booking_fees")

      assert html =~ "Listing Daily booking fees"
      assert html =~ daily_booking_fee.other_labels
    end

    test "saves new daily_booking_fee", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_booking_fees")

      assert index_live |> element("a", "New Daily booking fee") |> render_click() =~
               "New Daily booking fee"

      assert_patch(index_live, ~p"/daily_booking_fees/new")

      assert index_live
             |> form("#daily_booking_fee-form", daily_booking_fee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#daily_booking_fee-form", daily_booking_fee: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/daily_booking_fees")

      html = render(index_live)
      assert html =~ "Daily booking fee created successfully"
      assert html =~ "some other_labels"
    end

    test "updates daily_booking_fee in listing", %{conn: conn, daily_booking_fee: daily_booking_fee} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_booking_fees")

      assert index_live |> element("#daily_booking_fees-#{daily_booking_fee.id} a", "Edit") |> render_click() =~
               "Edit Daily booking fee"

      assert_patch(index_live, ~p"/daily_booking_fees/#{daily_booking_fee}/edit")

      assert index_live
             |> form("#daily_booking_fee-form", daily_booking_fee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#daily_booking_fee-form", daily_booking_fee: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/daily_booking_fees")

      html = render(index_live)
      assert html =~ "Daily booking fee updated successfully"
      assert html =~ "some updated other_labels"
    end

    test "deletes daily_booking_fee in listing", %{conn: conn, daily_booking_fee: daily_booking_fee} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_booking_fees")

      assert index_live |> element("#daily_booking_fees-#{daily_booking_fee.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#daily_booking_fees-#{daily_booking_fee.id}")
    end
  end

  describe "Show" do
    setup [:create_daily_booking_fee]

    test "displays daily_booking_fee", %{conn: conn, daily_booking_fee: daily_booking_fee} do
      {:ok, _show_live, html} = live(conn, ~p"/daily_booking_fees/#{daily_booking_fee}")

      assert html =~ "Show Daily booking fee"
      assert html =~ daily_booking_fee.other_labels
    end

    test "updates daily_booking_fee within modal", %{conn: conn, daily_booking_fee: daily_booking_fee} do
      {:ok, show_live, _html} = live(conn, ~p"/daily_booking_fees/#{daily_booking_fee}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Daily booking fee"

      assert_patch(show_live, ~p"/daily_booking_fees/#{daily_booking_fee}/show/edit")

      assert show_live
             |> form("#daily_booking_fee-form", daily_booking_fee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#daily_booking_fee-form", daily_booking_fee: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/daily_booking_fees/#{daily_booking_fee}")

      html = render(show_live)
      assert html =~ "Daily booking fee updated successfully"
      assert html =~ "some updated other_labels"
    end
  end
end
