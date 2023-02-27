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

  describe "daily_check_ins" do
    alias JResidence.Bookings.DailyCheckIn

    import JResidence.BookingsFixtures

    @invalid_attrs %{
      check_in: nil,
      check_out: nil,
      deposit: nil,
      duration_day: nil,
      from: nil,
      remarks: nil,
      room_number: nil,
      time_in: nil,
      time_out: nil,
      to: nil
    }

    test "list_daily_check_ins/0 returns all daily_check_ins" do
      daily_check_in = daily_check_in_fixture()
      assert Bookings.list_daily_check_ins() == [daily_check_in]
    end

    test "get_daily_check_in!/1 returns the daily_check_in with given id" do
      daily_check_in = daily_check_in_fixture()
      assert Bookings.get_daily_check_in!(daily_check_in.id) == daily_check_in
    end

    test "create_daily_check_in/1 with valid data creates a daily_check_in" do
      valid_attrs = %{
        check_in: ~D[2023-01-18],
        check_out: ~D[2023-01-20],
        deposit: "120.5",
        duration_day: 2,
        from: "some from",
        remarks: "some remarks",
        room_number: "some room_number",
        time_in: ~T[14:00:00],
        time_out: ~T[14:00:00],
        to: "some to"
      }

      assert {:ok, %DailyCheckIn{} = daily_check_in} = Bookings.create_daily_check_in(valid_attrs)
      assert daily_check_in.check_in == ~D[2023-01-18]
      assert daily_check_in.check_out == ~D[2023-01-20]
      assert daily_check_in.deposit == Decimal.new("120.5")
      assert daily_check_in.duration_day == 2
      assert daily_check_in.from == "some from"
      assert daily_check_in.remarks == "some remarks"
      assert daily_check_in.room_number == "some room_number"
      assert daily_check_in.time_in == ~T[14:00:00]
      assert daily_check_in.time_out == ~T[14:00:00]
      assert daily_check_in.to == "some to"
    end

    test "create_daily_check_in/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bookings.create_daily_check_in(@invalid_attrs)
    end

    test "update_daily_check_in/2 with valid data updates the daily_check_in" do
      daily_check_in = daily_check_in_fixture()

      update_attrs = %{
        check_in: ~D[2023-01-10],
        check_out: ~D[2023-01-19],
        deposit: "456.7",
        duration_day: 9,
        from: "some updated from",
        remarks: "some updated remarks",
        room_number: "some updated room_number",
        time_in: ~T[15:01:01],
        time_out: ~T[15:01:01],
        to: "some updated to"
      }

      assert {:ok, %DailyCheckIn{} = daily_check_in} =
               Bookings.update_daily_check_in(daily_check_in, update_attrs)

      assert daily_check_in.check_in == ~D[2023-01-10]
      assert daily_check_in.check_out == ~D[2023-01-19]
      assert daily_check_in.deposit == Decimal.new("456.7")
      assert daily_check_in.duration_day == 9
      assert daily_check_in.from == "some updated from"
      assert daily_check_in.remarks == "some updated remarks"
      assert daily_check_in.room_number == "some updated room_number"
      assert daily_check_in.time_in == ~T[15:01:01]
      assert daily_check_in.time_out == ~T[15:01:01]
      assert daily_check_in.to == "some updated to"
    end

    test "update_daily_check_in/2 with invalid data returns error changeset" do
      daily_check_in = daily_check_in_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Bookings.update_daily_check_in(daily_check_in, @invalid_attrs)

      assert daily_check_in == Bookings.get_daily_check_in!(daily_check_in.id)
    end

    test "delete_daily_check_in/1 deletes the daily_check_in" do
      daily_check_in = daily_check_in_fixture()
      assert {:ok, %DailyCheckIn{}} = Bookings.delete_daily_check_in(daily_check_in)
      assert_raise Ecto.NoResultsError, fn -> Bookings.get_daily_check_in!(daily_check_in.id) end
    end

    test "change_daily_check_in/1 returns a daily_check_in changeset" do
      daily_check_in = daily_check_in_fixture()
      assert %Ecto.Changeset{} = Bookings.change_daily_check_in(daily_check_in)
    end
  end
end
