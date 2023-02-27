defmodule JResidence.Bookings do
  @moduledoc """
  The Bookings context.
  """

  import Ecto.Query, warn: false
  alias JResidence.Repo

  alias JResidence.Bookings.DailyBooking

  @doc """
  Returns the list of daily_bookings.

  ## Examples

      iex> list_daily_bookings()
      [%DailyBooking{}, ...]

  """
  def list_daily_bookings do
    Repo.all(DailyBooking)
  end

  @doc """
  Gets a single daily_booking.

  Raises `Ecto.NoResultsError` if the Daily booking does not exist.

  ## Examples

      iex> get_daily_booking!(123)
      %DailyBooking{}

      iex> get_daily_booking!(456)
      ** (Ecto.NoResultsError)

  """
  def get_daily_booking!(id), do: Repo.get!(DailyBooking, id)

  @doc """
  Creates a daily_booking.

  ## Examples

      iex> create_daily_booking(%{field: value})
      {:ok, %DailyBooking{}}

      iex> create_daily_booking(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_daily_booking(attrs \\ %{}) do
    %DailyBooking{}
    |> DailyBooking.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a daily_booking.

  ## Examples

      iex> update_daily_booking(daily_booking, %{field: new_value})
      {:ok, %DailyBooking{}}

      iex> update_daily_booking(daily_booking, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_daily_booking(%DailyBooking{} = daily_booking, attrs) do
    daily_booking
    |> DailyBooking.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a daily_booking.

  ## Examples

      iex> delete_daily_booking(daily_booking)
      {:ok, %DailyBooking{}}

      iex> delete_daily_booking(daily_booking)
      {:error, %Ecto.Changeset{}}

  """
  def delete_daily_booking(%DailyBooking{} = daily_booking) do
    Repo.delete(daily_booking)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking daily_booking changes.

  ## Examples

      iex> change_daily_booking(daily_booking)
      %Ecto.Changeset{data: %DailyBooking{}}

  """
  def change_daily_booking(%DailyBooking{} = daily_booking, attrs \\ %{}) do
    DailyBooking.changeset(daily_booking, attrs)
  end
end
