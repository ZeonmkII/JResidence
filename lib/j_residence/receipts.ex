defmodule JResidence.Receipts do
  @moduledoc """
  The Receipts context.
  """

  import Ecto.Query, warn: false
  alias JResidence.Repo

  alias JResidence.Receipts.MonthlyContractFee

  @doc """
  Returns the list of monthly_contract_fees.

  ## Examples

      iex> list_monthly_contract_fees()
      [%MonthlyContractFee{}, ...]

  """
  def list_monthly_contract_fees do
    Repo.all(MonthlyContractFee)
  end

  @doc """
  Gets a single monthly_contract_fee.

  Raises `Ecto.NoResultsError` if the Monthly contract fee does not exist.

  ## Examples

      iex> get_monthly_contract_fee!(123)
      %MonthlyContractFee{}

      iex> get_monthly_contract_fee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_monthly_contract_fee!(id), do: Repo.get!(MonthlyContractFee, id)

  @doc """
  Creates a monthly_contract_fee.

  ## Examples

      iex> create_monthly_contract_fee(%{field: value})
      {:ok, %MonthlyContractFee{}}

      iex> create_monthly_contract_fee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_monthly_contract_fee(attrs \\ %{}) do
    %MonthlyContractFee{}
    |> MonthlyContractFee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a monthly_contract_fee.

  ## Examples

      iex> update_monthly_contract_fee(monthly_contract_fee, %{field: new_value})
      {:ok, %MonthlyContractFee{}}

      iex> update_monthly_contract_fee(monthly_contract_fee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_monthly_contract_fee(%MonthlyContractFee{} = monthly_contract_fee, attrs) do
    monthly_contract_fee
    |> MonthlyContractFee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a monthly_contract_fee.

  ## Examples

      iex> delete_monthly_contract_fee(monthly_contract_fee)
      {:ok, %MonthlyContractFee{}}

      iex> delete_monthly_contract_fee(monthly_contract_fee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_monthly_contract_fee(%MonthlyContractFee{} = monthly_contract_fee) do
    Repo.delete(monthly_contract_fee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking monthly_contract_fee changes.

  ## Examples

      iex> change_monthly_contract_fee(monthly_contract_fee)
      %Ecto.Changeset{data: %MonthlyContractFee{}}

  """
  def change_monthly_contract_fee(%MonthlyContractFee{} = monthly_contract_fee, attrs \\ %{}) do
    MonthlyContractFee.changeset(monthly_contract_fee, attrs)
  end
end
