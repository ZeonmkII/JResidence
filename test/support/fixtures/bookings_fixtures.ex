defmodule JResidence.BookingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JResidence.Bookings` context.
  """

  @doc """
  Generate a daily_booking.
  """
  def daily_booking_fixture(attrs \\ %{}) do
    {:ok, daily_booking} =
      attrs
      |> Enum.into(%{
        check_in: ~D[2023-02-26],
        check_out: ~D[2023-02-26],
        duration_day: 42,
        remarks: "some remarks"
      })
      |> JResidence.Bookings.create_daily_booking()

    daily_booking
  end
end
