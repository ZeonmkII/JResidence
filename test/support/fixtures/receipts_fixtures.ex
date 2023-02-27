defmodule JResidence.ReceiptsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JResidence.Receipts` context.
  """

  @doc """
  Generate a monthly_contract_fee.
  """
  def monthly_contract_fee_fixture(attrs \\ %{}) do
    {:ok, monthly_contract_fee} =
      attrs
      |> Enum.into(%{
        advance_payment: "120.5",
        deposit: "120.5",
        keycard_fees: "120.5",
        other_fees: "120.5",
        other_labels: "some other_labels",
        total: "120.5"
      })
      |> JResidence.Receipts.create_monthly_contract_fee()

    monthly_contract_fee
  end
end
