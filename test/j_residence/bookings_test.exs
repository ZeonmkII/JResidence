defmodule JResidence.BookingsTest do
  use JResidence.DataCase

  alias JResidence.Bookings

  describe "daily_bookings" do
    alias JResidence.Bookings.DailyBooking

    import JResidence.BookingsFixtures

    @invalid_attrs %{check_in: nil, check_out: nil, duration_day: nil, remarks: nil}

    test "list_daily_bookings/0 returns all daily_bookings" do
      daily_booking = daily_booking_fixture()
      assert Bookings.list_daily_bookings() == [daily_booking]
    end

    test "get_daily_booking!/1 returns the daily_booking with given id" do
      daily_booking = daily_booking_fixture()
      assert Bookings.get_daily_booking!(daily_booking.id) == daily_booking
    end

    test "create_daily_booking/1 with valid data creates a daily_booking" do
      valid_attrs = %{
        check_in: ~D[2023-01-18],
        check_out: ~D[2023-01-20],
        duration_day: 2,
        remarks: "some remarks"
      }

      assert {:ok, %DailyBooking{} = daily_booking} = Bookings.create_daily_booking(valid_attrs)
      assert daily_booking.check_in == ~D[2023-01-18]
      assert daily_booking.check_out == ~D[2023-01-20]
      assert daily_booking.duration_day == 2
      assert daily_booking.remarks == "some remarks"
    end

    test "create_daily_booking/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bookings.create_daily_booking(@invalid_attrs)
    end

    test "update_daily_booking/2 with valid data updates the daily_booking" do
      daily_booking = daily_booking_fixture()

      update_attrs = %{
        check_in: ~D[2023-01-10],
        check_out: ~D[2023-01-19],
        duration_day: 9,
        remarks: "some updated remarks"
      }

      assert {:ok, %DailyBooking{} = daily_booking} =
               Bookings.update_daily_booking(daily_booking, update_attrs)

      assert daily_booking.check_in == ~D[2023-01-10]
      assert daily_booking.check_out == ~D[2023-01-19]
      assert daily_booking.duration_day == 9
      assert daily_booking.remarks == "some updated remarks"
    end

    test "update_daily_booking/2 with invalid data returns error changeset" do
      daily_booking = daily_booking_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Bookings.update_daily_booking(daily_booking, @invalid_attrs)

      assert daily_booking == Bookings.get_daily_booking!(daily_booking.id)
    end

    test "delete_daily_booking/1 deletes the daily_booking" do
      daily_booking = daily_booking_fixture()
      assert {:ok, %DailyBooking{}} = Bookings.delete_daily_booking(daily_booking)
      assert_raise Ecto.NoResultsError, fn -> Bookings.get_daily_booking!(daily_booking.id) end
    end

    test "change_daily_booking/1 returns a daily_booking changeset" do
      daily_booking = daily_booking_fixture()
      assert %Ecto.Changeset{} = Bookings.change_daily_booking(daily_booking)
    end
  end
end
