defmodule JResidence.Invoices.MonthlyInvoice do
  alias JResidence.Bookings.MonthlyContract
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "monthly_invoices" do
    field :bill_cycle, :date
    field :advanced_payment, :decimal
    field :water_start, :decimal
    field :water_end, :decimal
    field :water_unit, :decimal
    field :electric_start, :decimal
    field :electric_end, :decimal
    field :other_labels, :string
    field :other_fees, :decimal
    field :total, :decimal

    belongs_to :monthly_contract, MonthlyContract

    timestamps()
  end

  @doc false
  def changeset(monthly_invoice, attrs) do
    monthly_invoice
    |> cast(attrs, [
      :bill_cycle,
      :advanced_payment,
      :water_start,
      :water_end,
      :water_unit,
      :electric_start,
      :electric_end,
      :other_labels,
      :other_fees,
      :total
    ])
    |> validate_required([
      :bill_cycle,
      :advanced_payment,
      :water_start,
      :water_end,
      :water_unit,
      :electric_start,
      :electric_end
    ])
  end
end
