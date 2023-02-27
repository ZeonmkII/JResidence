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

  describe "daily_invoices" do
    alias JResidence.Invoices.DailyInvoice

    import JResidence.InvoicesFixtures

    @invalid_attrs %{
      deposit: nil,
      keycard_fees: nil,
      other_fees: nil,
      other_labels: nil,
      remaining: nil,
      total: nil
    }

    test "list_daily_invoices/0 returns all daily_invoices" do
      daily_invoice = daily_invoice_fixture()
      assert Invoices.list_daily_invoices() == [daily_invoice]
    end

    test "get_daily_invoice!/1 returns the daily_invoice with given id" do
      daily_invoice = daily_invoice_fixture()
      assert Invoices.get_daily_invoice!(daily_invoice.id) == daily_invoice
    end

    test "create_daily_invoice/1 with valid data creates a daily_invoice" do
      valid_attrs = %{
        deposit: "120.5",
        keycard_fees: "120.5",
        other_fees: "120.5",
        other_labels: "some other_labels",
        remaining: "120.5",
        total: "120.5"
      }

      assert {:ok, %DailyInvoice{} = daily_invoice} = Invoices.create_daily_invoice(valid_attrs)
      assert daily_invoice.deposit == Decimal.new("120.5")
      assert daily_invoice.keycard_fees == Decimal.new("120.5")
      assert daily_invoice.other_fees == Decimal.new("120.5")
      assert daily_invoice.other_labels == "some other_labels"
      assert daily_invoice.remaining == Decimal.new("0.0")
      assert daily_invoice.total == Decimal.new("120.5")
    end

    test "create_daily_invoice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Invoices.create_daily_invoice(@invalid_attrs)
    end

    test "update_daily_invoice/2 with valid data updates the daily_invoice" do
      daily_invoice = daily_invoice_fixture()

      update_attrs = %{
        deposit: "456.7",
        keycard_fees: "456.7",
        other_fees: "456.7",
        other_labels: "some updated other_labels",
        remaining: "456.7",
        total: "456.7"
      }

      assert {:ok, %DailyInvoice{} = daily_invoice} =
               Invoices.update_daily_invoice(daily_invoice, update_attrs)

      assert daily_invoice.deposit == Decimal.new("456.7")
      assert daily_invoice.keycard_fees == Decimal.new("456.7")
      assert daily_invoice.other_fees == Decimal.new("456.7")
      assert daily_invoice.other_labels == "some updated other_labels"
      assert daily_invoice.remaining == Decimal.new("0.0")
      assert daily_invoice.total == Decimal.new("456.7")
    end

    test "update_daily_invoice/2 with invalid data returns error changeset" do
      daily_invoice = daily_invoice_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Invoices.update_daily_invoice(daily_invoice, @invalid_attrs)

      assert daily_invoice == Invoices.get_daily_invoice!(daily_invoice.id)
    end

    test "delete_daily_invoice/1 deletes the daily_invoice" do
      daily_invoice = daily_invoice_fixture()
      assert {:ok, %DailyInvoice{}} = Invoices.delete_daily_invoice(daily_invoice)
      assert_raise Ecto.NoResultsError, fn -> Invoices.get_daily_invoice!(daily_invoice.id) end
    end

    test "change_daily_invoice/1 returns a daily_invoice changeset" do
      daily_invoice = daily_invoice_fixture()
      assert %Ecto.Changeset{} = Invoices.change_daily_invoice(daily_invoice)
    end
  end

  describe "monthly_booking_fees" do
    alias JResidence.Invoices.MonthlyBookingFee

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

    test "list_monthly_booking_fees/0 returns all monthly_booking_fees" do
      monthly_booking_fee = monthly_booking_fee_fixture()
      assert Invoices.list_monthly_booking_fees() == [monthly_booking_fee]
    end

    test "get_monthly_booking_fee!/1 returns the monthly_booking_fee with given id" do
      monthly_booking_fee = monthly_booking_fee_fixture()
      assert Invoices.get_monthly_booking_fee!(monthly_booking_fee.id) == monthly_booking_fee
    end

    test "create_monthly_booking_fee/1 with valid data creates a monthly_booking_fee" do
      valid_attrs = %{
        booking_fees: "120.5",
        deposit: "120.5",
        other_fees: "120.5",
        other_labels: "some other_labels",
        remaining: "120.5",
        room_fees: "120.5",
        total: "120.5"
      }

      assert {:ok, %MonthlyBookingFee{} = monthly_booking_fee} =
               Invoices.create_monthly_booking_fee(valid_attrs)

      assert monthly_booking_fee.booking_fees == Decimal.new("120.5")
      assert monthly_booking_fee.deposit == Decimal.new("120.5")
      assert monthly_booking_fee.other_fees == Decimal.new("120.5")
      assert monthly_booking_fee.other_labels == "some other_labels"
      assert monthly_booking_fee.remaining == Decimal.new("0.0")
      assert monthly_booking_fee.room_fees == Decimal.new("120.5")
      assert monthly_booking_fee.total == Decimal.new("120.5")
    end

    test "create_monthly_booking_fee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Invoices.create_monthly_booking_fee(@invalid_attrs)
    end

    test "update_monthly_booking_fee/2 with valid data updates the monthly_booking_fee" do
      monthly_booking_fee = monthly_booking_fee_fixture()

      update_attrs = %{
        booking_fees: "456.7",
        deposit: "456.7",
        other_fees: "456.7",
        other_labels: "some updated other_labels",
        remaining: "456.7",
        room_fees: "456.7",
        total: "456.7"
      }

      assert {:ok, %MonthlyBookingFee{} = monthly_booking_fee} =
               Invoices.update_monthly_booking_fee(monthly_booking_fee, update_attrs)

      assert monthly_booking_fee.booking_fees == Decimal.new("456.7")
      assert monthly_booking_fee.deposit == Decimal.new("456.7")
      assert monthly_booking_fee.other_fees == Decimal.new("456.7")
      assert monthly_booking_fee.other_labels == "some updated other_labels"
      assert monthly_booking_fee.remaining == Decimal.new("0.0")
      assert monthly_booking_fee.room_fees == Decimal.new("456.7")
      assert monthly_booking_fee.total == Decimal.new("456.7")
    end

    test "update_monthly_booking_fee/2 with invalid data returns error changeset" do
      monthly_booking_fee = monthly_booking_fee_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Invoices.update_monthly_booking_fee(monthly_booking_fee, @invalid_attrs)

      assert monthly_booking_fee == Invoices.get_monthly_booking_fee!(monthly_booking_fee.id)
    end

    test "delete_monthly_booking_fee/1 deletes the monthly_booking_fee" do
      monthly_booking_fee = monthly_booking_fee_fixture()

      assert {:ok, %MonthlyBookingFee{}} =
               Invoices.delete_monthly_booking_fee(monthly_booking_fee)

      assert_raise Ecto.NoResultsError, fn ->
        Invoices.get_monthly_booking_fee!(monthly_booking_fee.id)
      end
    end

    test "change_monthly_booking_fee/1 returns a monthly_booking_fee changeset" do
      monthly_booking_fee = monthly_booking_fee_fixture()
      assert %Ecto.Changeset{} = Invoices.change_monthly_booking_fee(monthly_booking_fee)
    end
  end

  describe "monthly_invoices" do
    alias JResidence.Invoices.MonthlyInvoice

    import JResidence.InvoicesFixtures

    @invalid_attrs %{advanced_payment: nil, bill_cycle: nil, electric_end: nil, electric_start: nil, other_fees: nil, other_labels: nil, total: nil, water_end: nil, water_start: nil, water_unit: nil}

    test "list_monthly_invoices/0 returns all monthly_invoices" do
      monthly_invoice = monthly_invoice_fixture()
      assert Invoices.list_monthly_invoices() == [monthly_invoice]
    end

    test "get_monthly_invoice!/1 returns the monthly_invoice with given id" do
      monthly_invoice = monthly_invoice_fixture()
      assert Invoices.get_monthly_invoice!(monthly_invoice.id) == monthly_invoice
    end

    test "create_monthly_invoice/1 with valid data creates a monthly_invoice" do
      valid_attrs = %{advanced_payment: "120.5", bill_cycle: ~D[2023-02-26], electric_end: "120.5", electric_start: "120.5", other_fees: "120.5", other_labels: "some other_labels", total: "120.5", water_end: "120.5", water_start: "120.5", water_unit: "120.5"}

      assert {:ok, %MonthlyInvoice{} = monthly_invoice} = Invoices.create_monthly_invoice(valid_attrs)
      assert monthly_invoice.advanced_payment == Decimal.new("120.5")
      assert monthly_invoice.bill_cycle == ~D[2023-02-26]
      assert monthly_invoice.electric_end == Decimal.new("120.5")
      assert monthly_invoice.electric_start == Decimal.new("120.5")
      assert monthly_invoice.other_fees == Decimal.new("120.5")
      assert monthly_invoice.other_labels == "some other_labels"
      assert monthly_invoice.total == Decimal.new("120.5")
      assert monthly_invoice.water_end == Decimal.new("120.5")
      assert monthly_invoice.water_start == Decimal.new("120.5")
      assert monthly_invoice.water_unit == Decimal.new("120.5")
    end

    test "create_monthly_invoice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Invoices.create_monthly_invoice(@invalid_attrs)
    end

    test "update_monthly_invoice/2 with valid data updates the monthly_invoice" do
      monthly_invoice = monthly_invoice_fixture()
      update_attrs = %{advanced_payment: "456.7", bill_cycle: ~D[2023-02-27], electric_end: "456.7", electric_start: "456.7", other_fees: "456.7", other_labels: "some updated other_labels", total: "456.7", water_end: "456.7", water_start: "456.7", water_unit: "456.7"}

      assert {:ok, %MonthlyInvoice{} = monthly_invoice} = Invoices.update_monthly_invoice(monthly_invoice, update_attrs)
      assert monthly_invoice.advanced_payment == Decimal.new("456.7")
      assert monthly_invoice.bill_cycle == ~D[2023-02-27]
      assert monthly_invoice.electric_end == Decimal.new("456.7")
      assert monthly_invoice.electric_start == Decimal.new("456.7")
      assert monthly_invoice.other_fees == Decimal.new("456.7")
      assert monthly_invoice.other_labels == "some updated other_labels"
      assert monthly_invoice.total == Decimal.new("456.7")
      assert monthly_invoice.water_end == Decimal.new("456.7")
      assert monthly_invoice.water_start == Decimal.new("456.7")
      assert monthly_invoice.water_unit == Decimal.new("456.7")
    end

    test "update_monthly_invoice/2 with invalid data returns error changeset" do
      monthly_invoice = monthly_invoice_fixture()
      assert {:error, %Ecto.Changeset{}} = Invoices.update_monthly_invoice(monthly_invoice, @invalid_attrs)
      assert monthly_invoice == Invoices.get_monthly_invoice!(monthly_invoice.id)
    end

    test "delete_monthly_invoice/1 deletes the monthly_invoice" do
      monthly_invoice = monthly_invoice_fixture()
      assert {:ok, %MonthlyInvoice{}} = Invoices.delete_monthly_invoice(monthly_invoice)
      assert_raise Ecto.NoResultsError, fn -> Invoices.get_monthly_invoice!(monthly_invoice.id) end
    end

    test "change_monthly_invoice/1 returns a monthly_invoice changeset" do
      monthly_invoice = monthly_invoice_fixture()
      assert %Ecto.Changeset{} = Invoices.change_monthly_invoice(monthly_invoice)
    end
  end
end
