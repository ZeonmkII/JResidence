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

  @doc """
  Generate a daily_invoice.
  """
  def daily_invoice_fixture(attrs \\ %{}) do
    {:ok, daily_invoice} =
      attrs
      |> Enum.into(%{
        deposit: "120.5",
        keycard_fees: "120.5",
        other_fees: "120.5",
        other_labels: "some other_labels",
        remaining: "120.5",
        total: "120.5"
      })
      |> JResidence.Invoices.create_daily_invoice()

    daily_invoice
  end

  @doc """
  Generate a monthly_booking_fee.
  """
  def monthly_booking_fee_fixture(attrs \\ %{}) do
    {:ok, monthly_booking_fee} =
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
      |> JResidence.Invoices.create_monthly_booking_fee()

    monthly_booking_fee
  end

  @doc """
  Generate a monthly_invoice.
  """
  def monthly_invoice_fixture(attrs \\ %{}) do
    {:ok, monthly_invoice} =
      attrs
      |> Enum.into(%{
        advance_payment: "120.5",
        bill_cycle: ~D[2023-02-26],
        electric_end: "120.5",
        electric_start: "120.5",
        other_fees: "120.5",
        other_labels: "some other_labels",
        total: "120.5",
        water_end: "120.5",
        water_start: "120.5",
        water_unit: "120.5"
      })
      |> JResidence.Invoices.create_monthly_invoice()

    monthly_invoice
  end
end
