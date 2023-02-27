defmodule JResidence.InvoicesTest do
  use JResidence.DataCase

  alias JResidence.Invoices

  describe "daily_booking_fees" do
    alias JResidence.Invoices.DailyBookingFee

    import JResidence.InvoicesFixtures

    @invalid_attrs %{
      booking_fees: nil,
      deposit: nil,
      other_fees: nil,
      other_labels: nil,
      remaining: nil,
      room_fees: nil,
      total: nil
    }

    test "list_daily_booking_fees/0 returns all daily_booking_fees" do
      daily_booking_fee = daily_booking_fee_fixture()
      assert Invoices.list_daily_booking_fees() == [daily_booking_fee]
    end

    test "get_daily_booking_fee!/1 returns the daily_booking_fee with given id" do
      daily_booking_fee = daily_booking_fee_fixture()
      assert Invoices.get_daily_booking_fee!(daily_booking_fee.id) == daily_booking_fee
    end

    test "create_daily_booking_fee/1 with valid data creates a daily_booking_fee" do
      valid_attrs = %{
        booking_fees: "120.5",
        deposit: "120.5",
        other_fees: "120.5",
        other_labels: "some other_labels",
        remaining: "120.5",
        room_fees: "120.5",
        total: "120.5"
      }

      assert {:ok, %DailyBookingFee{} = daily_booking_fee} =
               Invoices.create_daily_booking_fee(valid_attrs)

      assert daily_booking_fee.booking_fees == Decimal.new("120.5")
      assert daily_booking_fee.deposit == Decimal.new("120.5")
      assert daily_booking_fee.other_fees == Decimal.new("120.5")
      assert daily_booking_fee.other_labels == "some other_labels"
      assert daily_booking_fee.remaining == Decimal.new("0.0")
      assert daily_booking_fee.room_fees == Decimal.new("120.5")
      assert daily_booking_fee.total == Decimal.new("120.5")
    end

    test "create_daily_booking_fee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Invoices.create_daily_booking_fee(@invalid_attrs)
    end

    test "update_daily_booking_fee/2 with valid data updates the daily_booking_fee" do
      daily_booking_fee = daily_booking_fee_fixture()

      update_attrs = %{
        booking_fees: "456.7",
        deposit: "456.7",
        other_fees: "456.7",
        other_labels: "some updated other_labels",
        remaining: "456.7",
        room_fees: "456.7",
        total: "456.7"
      }

      assert {:ok, %DailyBookingFee{} = daily_booking_fee} =
               Invoices.update_daily_booking_fee(daily_booking_fee, update_attrs)

      assert daily_booking_fee.booking_fees == Decimal.new("456.7")
      assert daily_booking_fee.deposit == Decimal.new("456.7")
      assert daily_booking_fee.other_fees == Decimal.new("456.7")
      assert daily_booking_fee.other_labels == "some updated other_labels"
      assert daily_booking_fee.remaining == Decimal.new("0.0")
      assert daily_booking_fee.room_fees == Decimal.new("456.7")
      assert daily_booking_fee.total == Decimal.new("456.7")
    end

    test "update_daily_booking_fee/2 with invalid data returns error changeset" do
      daily_booking_fee = daily_booking_fee_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Invoices.update_daily_booking_fee(daily_booking_fee, @invalid_attrs)

      assert daily_booking_fee == Invoices.get_daily_booking_fee!(daily_booking_fee.id)
    end

    test "delete_daily_booking_fee/1 deletes the daily_booking_fee" do
      daily_booking_fee = daily_booking_fee_fixture()
      assert {:ok, %DailyBookingFee{}} = Invoices.delete_daily_booking_fee(daily_booking_fee)

      assert_raise Ecto.NoResultsError, fn ->
        Invoices.get_daily_booking_fee!(daily_booking_fee.id)
      end
    end

    test "change_daily_booking_fee/1 returns a daily_booking_fee changeset" do
      daily_booking_fee = daily_booking_fee_fixture()
      assert %Ecto.Changeset{} = Invoices.change_daily_booking_fee(daily_booking_fee)
    end
  end
end
