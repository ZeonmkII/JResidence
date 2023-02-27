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

  alias JResidence.Invoices.DailyInvoice

  @doc """
  Returns the list of daily_invoices.

  ## Examples

      iex> list_daily_invoices()
      [%DailyInvoice{}, ...]

  """
  def list_daily_invoices do
    Repo.all(DailyInvoice)
  end

  @doc """
  Gets a single daily_invoice.

  Raises `Ecto.NoResultsError` if the Daily invoice does not exist.

  ## Examples

      iex> get_daily_invoice!(123)
      %DailyInvoice{}

      iex> get_daily_invoice!(456)
      ** (Ecto.NoResultsError)

  """
  def get_daily_invoice!(id), do: Repo.get!(DailyInvoice, id)

  @doc """
  Creates a daily_invoice.

  ## Examples

      iex> create_daily_invoice(%{field: value})
      {:ok, %DailyInvoice{}}

      iex> create_daily_invoice(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_daily_invoice(attrs \\ %{}) do
    %DailyInvoice{}
    |> DailyInvoice.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a daily_invoice.

  ## Examples

      iex> update_daily_invoice(daily_invoice, %{field: new_value})
      {:ok, %DailyInvoice{}}

      iex> update_daily_invoice(daily_invoice, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_daily_invoice(%DailyInvoice{} = daily_invoice, attrs) do
    daily_invoice
    |> DailyInvoice.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a daily_invoice.

  ## Examples

      iex> delete_daily_invoice(daily_invoice)
      {:ok, %DailyInvoice{}}

      iex> delete_daily_invoice(daily_invoice)
      {:error, %Ecto.Changeset{}}

  """
  def delete_daily_invoice(%DailyInvoice{} = daily_invoice) do
    Repo.delete(daily_invoice)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking daily_invoice changes.

  ## Examples

      iex> change_daily_invoice(daily_invoice)
      %Ecto.Changeset{data: %DailyInvoice{}}

  """
  def change_daily_invoice(%DailyInvoice{} = daily_invoice, attrs \\ %{}) do
    DailyInvoice.changeset(daily_invoice, attrs)
  end

  alias JResidence.Invoices.MonthlyBookingFee

  @doc """
  Returns the list of monthly_booking_fees.

  ## Examples

      iex> list_monthly_booking_fees()
      [%MonthlyBookingFee{}, ...]

  """
  def list_monthly_booking_fees do
    Repo.all(MonthlyBookingFee)
  end

  @doc """
  Gets a single monthly_booking_fee.

  Raises `Ecto.NoResultsError` if the Monthly booking fee does not exist.

  ## Examples

      iex> get_monthly_booking_fee!(123)
      %MonthlyBookingFee{}

      iex> get_monthly_booking_fee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_monthly_booking_fee!(id), do: Repo.get!(MonthlyBookingFee, id)

  @doc """
  Creates a monthly_booking_fee.

  ## Examples

      iex> create_monthly_booking_fee(%{field: value})
      {:ok, %MonthlyBookingFee{}}

      iex> create_monthly_booking_fee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_monthly_booking_fee(attrs \\ %{}) do
    %MonthlyBookingFee{}
    |> MonthlyBookingFee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a monthly_booking_fee.

  ## Examples

      iex> update_monthly_booking_fee(monthly_booking_fee, %{field: new_value})
      {:ok, %MonthlyBookingFee{}}

      iex> update_monthly_booking_fee(monthly_booking_fee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_monthly_booking_fee(%MonthlyBookingFee{} = monthly_booking_fee, attrs) do
    monthly_booking_fee
    |> MonthlyBookingFee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a monthly_booking_fee.

  ## Examples

      iex> delete_monthly_booking_fee(monthly_booking_fee)
      {:ok, %MonthlyBookingFee{}}

      iex> delete_monthly_booking_fee(monthly_booking_fee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_monthly_booking_fee(%MonthlyBookingFee{} = monthly_booking_fee) do
    Repo.delete(monthly_booking_fee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking monthly_booking_fee changes.

  ## Examples

      iex> change_monthly_booking_fee(monthly_booking_fee)
      %Ecto.Changeset{data: %MonthlyBookingFee{}}

  """
  def change_monthly_booking_fee(%MonthlyBookingFee{} = monthly_booking_fee, attrs \\ %{}) do
    MonthlyBookingFee.changeset(monthly_booking_fee, attrs)
  end
end
