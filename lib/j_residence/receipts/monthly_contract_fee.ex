defmodule JResidence.Receipts.MonthlyContractFee do
  alias JResidence.Bookings.MonthlyContract
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "monthly_contract_fees" do
    field :deposit, :decimal
    field :advance_payment, :decimal
    field :keycard_fees, :decimal
    field :other_labels, :string
    field :other_fees, :decimal
    field :total, :decimal

    belongs_to :monthly_contract, MonthlyContract

    timestamps()
  end

  @doc false
  def changeset(monthly_contract_fee, attrs) do
    monthly_contract_fee
    |> cast(attrs, [:deposit, :advance_payment, :keycard_fees, :other_labels, :other_fees, :total])
    |> validate_required([:deposit, :advance_payment, :keycard_fees])
  end
end
