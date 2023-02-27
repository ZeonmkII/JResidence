defmodule JResidence.Invoices do
  @moduledoc """
  The Invoices context.
  """

  import Ecto.Query, warn: false
  alias JResidence.Repo

  alias JResidence.Invoices.DailyBookingFee

  @doc """
  Returns the list of daily_booking_fees.

  ## Examples

      iex> list_daily_booking_fees()
      [%DailyBookingFee{}, ...]

  """
  def list_daily_booking_fees do
    Repo.all(DailyBookingFee)
  end

  @doc """
  Gets a single daily_booking_fee.

  Raises `Ecto.NoResultsError` if the Daily booking fee does not exist.

  ## Examples

      iex> get_daily_booking_fee!(123)
      %DailyBookingFee{}

      iex> get_daily_booking_fee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_daily_booking_fee!(id), do: Repo.get!(DailyBookingFee, id)

  @doc """
  Creates a daily_booking_fee.

  ## Examples

      iex> create_daily_booking_fee(%{field: value})
      {:ok, %DailyBookingFee{}}

      iex> create_daily_booking_fee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_daily_booking_fee(attrs \\ %{}) do
    %DailyBookingFee{}
    |> DailyBookingFee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a daily_booking_fee.

  ## Examples

      iex> update_daily_booking_fee(daily_booking_fee, %{field: new_value})
      {:ok, %DailyBookingFee{}}

      iex> update_daily_booking_fee(daily_booking_fee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_daily_booking_fee(%DailyBookingFee{} = daily_booking_fee, attrs) do
    daily_booking_fee
    |> DailyBookingFee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a daily_booking_fee.

  ## Examples

      iex> delete_daily_booking_fee(daily_booking_fee)
      {:ok, %DailyBookingFee{}}

      iex> delete_daily_booking_fee(daily_booking_fee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_daily_booking_fee(%DailyBookingFee{} = daily_booking_fee) do
    Repo.delete(daily_booking_fee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking daily_booking_fee changes.

  ## Examples

      iex> change_daily_booking_fee(daily_booking_fee)
      %Ecto.Changeset{data: %DailyBookingFee{}}

  """
  def change_daily_booking_fee(%DailyBookingFee{} = daily_booking_fee, attrs \\ %{}) do
    DailyBookingFee.changeset(daily_booking_fee, attrs)
  end
end
