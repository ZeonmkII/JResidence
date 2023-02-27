defmodule JResidence.InvoicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JResidence.Invoices` context.
  """

  @doc """
  Generate a daily_booking_fee.
  """
  def daily_booking_fee_fixture(attrs \\ %{}) do
    {:ok, daily_booking_fee} =
      attrs
      |> Enum.into(%{
        booking_fees: "120.5",
        deposit: "120.5",
        other_fees: "120.5",
        other_labels: "some other_labels",
        remaining: "120.5",
        room_fees: "120.5",
        total: "120.5"
      })
      |> JResidence.Invoices.create_daily_booking_fee()

    daily_booking_fee
  end
end
