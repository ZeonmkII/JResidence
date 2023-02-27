defmodule JResidence.ReceiptsTest do
  use JResidence.DataCase

  alias JResidence.Receipts

  describe "monthly_contract_fees" do
    alias JResidence.Receipts.MonthlyContractFee

    import JResidence.ReceiptsFixtures

    @invalid_attrs %{advance_payment: nil, deposit: nil, keycard_fees: nil, other_fees: nil, other_labels: nil, total: nil}

    test "list_monthly_contract_fees/0 returns all monthly_contract_fees" do
      monthly_contract_fee = monthly_contract_fee_fixture()
      assert Receipts.list_monthly_contract_fees() == [monthly_contract_fee]
    end

    test "get_monthly_contract_fee!/1 returns the monthly_contract_fee with given id" do
      monthly_contract_fee = monthly_contract_fee_fixture()
      assert Receipts.get_monthly_contract_fee!(monthly_contract_fee.id) == monthly_contract_fee
    end

    test "create_monthly_contract_fee/1 with valid data creates a monthly_contract_fee" do
      valid_attrs = %{advance_payment: "120.5", deposit: "120.5", keycard_fees: "120.5", other_fees: "120.5", other_labels: "some other_labels", total: "120.5"}

      assert {:ok, %MonthlyContractFee{} = monthly_contract_fee} = Receipts.create_monthly_contract_fee(valid_attrs)
      assert monthly_contract_fee.advance_payment == Decimal.new("120.5")
      assert monthly_contract_fee.deposit == Decimal.new("120.5")
      assert monthly_contract_fee.keycard_fees == Decimal.new("120.5")
      assert monthly_contract_fee.other_fees == Decimal.new("120.5")
      assert monthly_contract_fee.other_labels == "some other_labels"
      assert monthly_contract_fee.total == Decimal.new("120.5")
    end

    test "create_monthly_contract_fee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Receipts.create_monthly_contract_fee(@invalid_attrs)
    end

    test "update_monthly_contract_fee/2 with valid data updates the monthly_contract_fee" do
      monthly_contract_fee = monthly_contract_fee_fixture()
      update_attrs = %{advance_payment: "456.7", deposit: "456.7", keycard_fees: "456.7", other_fees: "456.7", other_labels: "some updated other_labels", total: "456.7"}

      assert {:ok, %MonthlyContractFee{} = monthly_contract_fee} = Receipts.update_monthly_contract_fee(monthly_contract_fee, update_attrs)
      assert monthly_contract_fee.advance_payment == Decimal.new("456.7")
      assert monthly_contract_fee.deposit == Decimal.new("456.7")
      assert monthly_contract_fee.keycard_fees == Decimal.new("456.7")
      assert monthly_contract_fee.other_fees == Decimal.new("456.7")
      assert monthly_contract_fee.other_labels == "some updated other_labels"
      assert monthly_contract_fee.total == Decimal.new("456.7")
    end

    test "update_monthly_contract_fee/2 with invalid data returns error changeset" do
      monthly_contract_fee = monthly_contract_fee_fixture()
      assert {:error, %Ecto.Changeset{}} = Receipts.update_monthly_contract_fee(monthly_contract_fee, @invalid_attrs)
      assert monthly_contract_fee == Receipts.get_monthly_contract_fee!(monthly_contract_fee.id)
    end

    test "delete_monthly_contract_fee/1 deletes the monthly_contract_fee" do
      monthly_contract_fee = monthly_contract_fee_fixture()
      assert {:ok, %MonthlyContractFee{}} = Receipts.delete_monthly_contract_fee(monthly_contract_fee)
      assert_raise Ecto.NoResultsError, fn -> Receipts.get_monthly_contract_fee!(monthly_contract_fee.id) end
    end

    test "change_monthly_contract_fee/1 returns a monthly_contract_fee changeset" do
      monthly_contract_fee = monthly_contract_fee_fixture()
      assert %Ecto.Changeset{} = Receipts.change_monthly_contract_fee(monthly_contract_fee)
    end
  end
end
