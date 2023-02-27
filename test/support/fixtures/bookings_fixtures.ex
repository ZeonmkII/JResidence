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

  @doc """
  Generate a daily_check_in.
  """
  def daily_check_in_fixture(attrs \\ %{}) do
    {:ok, daily_check_in} =
      attrs
      |> Enum.into(%{
        check_in: ~D[2023-02-26],
        check_out: ~D[2023-02-26],
        deposit: "120.5",
        duration_day: 42,
        from: "some from",
        remarks: "some remarks",
        room_number: "some room_number",
        time_in: ~T[14:00:00],
        time_out: ~T[14:00:00],
        to: "some to"
      })
      |> JResidence.Bookings.create_daily_check_in()

    daily_check_in
  end
end
