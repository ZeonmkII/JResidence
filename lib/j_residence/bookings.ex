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

  alias JResidence.Bookings.DailyCheckIn

  @doc """
  Returns the list of daily_check_ins.

  ## Examples

      iex> list_daily_check_ins()
      [%DailyCheckIn{}, ...]

  """
  def list_daily_check_ins do
    Repo.all(DailyCheckIn)
  end

  @doc """
  Gets a single daily_check_in.

  Raises `Ecto.NoResultsError` if the Daily check in does not exist.

  ## Examples

      iex> get_daily_check_in!(123)
      %DailyCheckIn{}

      iex> get_daily_check_in!(456)
      ** (Ecto.NoResultsError)

  """
  def get_daily_check_in!(id), do: Repo.get!(DailyCheckIn, id)

  @doc """
  Creates a daily_check_in.

  ## Examples

      iex> create_daily_check_in(%{field: value})
      {:ok, %DailyCheckIn{}}

      iex> create_daily_check_in(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_daily_check_in(attrs \\ %{}) do
    %DailyCheckIn{}
    |> DailyCheckIn.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a daily_check_in.

  ## Examples

      iex> update_daily_check_in(daily_check_in, %{field: new_value})
      {:ok, %DailyCheckIn{}}

      iex> update_daily_check_in(daily_check_in, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_daily_check_in(%DailyCheckIn{} = daily_check_in, attrs) do
    daily_check_in
    |> DailyCheckIn.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a daily_check_in.

  ## Examples

      iex> delete_daily_check_in(daily_check_in)
      {:ok, %DailyCheckIn{}}

      iex> delete_daily_check_in(daily_check_in)
      {:error, %Ecto.Changeset{}}

  """
  def delete_daily_check_in(%DailyCheckIn{} = daily_check_in) do
    Repo.delete(daily_check_in)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking daily_check_in changes.

  ## Examples

      iex> change_daily_check_in(daily_check_in)
      %Ecto.Changeset{data: %DailyCheckIn{}}

  """
  def change_daily_check_in(%DailyCheckIn{} = daily_check_in, attrs \\ %{}) do
    DailyCheckIn.changeset(daily_check_in, attrs)
  end
end
