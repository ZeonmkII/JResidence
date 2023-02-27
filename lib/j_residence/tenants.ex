defmodule JResidence.Tenants do
  @moduledoc """
  The Tenants context.
  """

  import Ecto.Query, warn: false
  alias JResidence.Repo

  alias JResidence.Tenants.Customer

  @doc """
  Returns the list of customers.

  ## Examples

      iex> list_customers()
      [%Customer{}, ...]

  """
  def list_customers do
    Repo.all(Customer)
  end

  @doc """
  Gets a single customer.

  Raises `Ecto.NoResultsError` if the Customer does not exist.

  ## Examples

      iex> get_customer!(123)
      %Customer{}

      iex> get_customer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer!(id), do: Repo.get!(Customer, id)

  @doc """
  Creates a customer.

  ## Examples

      iex> create_customer(%{field: value})
      {:ok, %Customer{}}

      iex> create_customer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer(attrs \\ %{}) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a customer.

  ## Examples

      iex> update_customer(customer, %{field: new_value})
      {:ok, %Customer{}}

      iex> update_customer(customer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_customer(%Customer{} = customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a customer.

  ## Examples

      iex> delete_customer(customer)
      {:ok, %Customer{}}

      iex> delete_customer(customer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_customer(%Customer{} = customer) do
    Repo.delete(customer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking customer changes.

  ## Examples

      iex> change_customer(customer)
      %Ecto.Changeset{data: %Customer{}}

  """
  def change_customer(%Customer{} = customer, attrs \\ %{}) do
    Customer.changeset(customer, attrs)
  end

  alias JResidence.Tenants.DailyCustomer

  @doc """
  Returns the list of daily_customers.

  ## Examples

      iex> list_daily_customers()
      [%DailyCustomer{}, ...]

  """
  def list_daily_customers do
    Repo.all(DailyCustomer)
  end

  @doc """
  Gets a single daily_customer.

  Raises `Ecto.NoResultsError` if the Daily customer does not exist.

  ## Examples

      iex> get_daily_customer!(123)
      %DailyCustomer{}

      iex> get_daily_customer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_daily_customer!(id), do: Repo.get!(DailyCustomer, id)

  @doc """
  Creates a daily_customer.

  ## Examples

      iex> create_daily_customer(%{field: value})
      {:ok, %DailyCustomer{}}

      iex> create_daily_customer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_daily_customer(attrs \\ %{}) do
    %DailyCustomer{}
    |> DailyCustomer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a daily_customer.

  ## Examples

      iex> update_daily_customer(daily_customer, %{field: new_value})
      {:ok, %DailyCustomer{}}

      iex> update_daily_customer(daily_customer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_daily_customer(%DailyCustomer{} = daily_customer, attrs) do
    daily_customer
    |> DailyCustomer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a daily_customer.

  ## Examples

      iex> delete_daily_customer(daily_customer)
      {:ok, %DailyCustomer{}}

      iex> delete_daily_customer(daily_customer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_daily_customer(%DailyCustomer{} = daily_customer) do
    Repo.delete(daily_customer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking daily_customer changes.

  ## Examples

      iex> change_daily_customer(daily_customer)
      %Ecto.Changeset{data: %DailyCustomer{}}

  """
  def change_daily_customer(%DailyCustomer{} = daily_customer, attrs \\ %{}) do
    DailyCustomer.changeset(daily_customer, attrs)
  end

  alias JResidence.Tenants.MonthlyCustomer

  @doc """
  Returns the list of monthly_customers.

  ## Examples

      iex> list_monthly_customers()
      [%MonthlyCustomer{}, ...]

  """
  def list_monthly_customers do
    Repo.all(MonthlyCustomer)
  end

  @doc """
  Gets a single monthly_customer.

  Raises `Ecto.NoResultsError` if the Monthly customer does not exist.

  ## Examples

      iex> get_monthly_customer!(123)
      %MonthlyCustomer{}

      iex> get_monthly_customer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_monthly_customer!(id), do: Repo.get!(MonthlyCustomer, id)

  @doc """
  Creates a monthly_customer.

  ## Examples

      iex> create_monthly_customer(%{field: value})
      {:ok, %MonthlyCustomer{}}

      iex> create_monthly_customer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_monthly_customer(attrs \\ %{}) do
    %MonthlyCustomer{}
    |> MonthlyCustomer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a monthly_customer.

  ## Examples

      iex> update_monthly_customer(monthly_customer, %{field: new_value})
      {:ok, %MonthlyCustomer{}}

      iex> update_monthly_customer(monthly_customer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_monthly_customer(%MonthlyCustomer{} = monthly_customer, attrs) do
    monthly_customer
    |> MonthlyCustomer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a monthly_customer.

  ## Examples

      iex> delete_monthly_customer(monthly_customer)
      {:ok, %MonthlyCustomer{}}

      iex> delete_monthly_customer(monthly_customer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_monthly_customer(%MonthlyCustomer{} = monthly_customer) do
    Repo.delete(monthly_customer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking monthly_customer changes.

  ## Examples

      iex> change_monthly_customer(monthly_customer)
      %Ecto.Changeset{data: %MonthlyCustomer{}}

  """
  def change_monthly_customer(%MonthlyCustomer{} = monthly_customer, attrs \\ %{}) do
    MonthlyCustomer.changeset(monthly_customer, attrs)
  end
end
