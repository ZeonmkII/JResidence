defmodule JResidence.Invoices.DailyInvoice do
  alias JResidence.Bookings.DailyCheckIn
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "daily_invoices" do
    field :deposit, :decimal
    field :keycard_fees, :decimal
    field :other_fees, :decimal
    field :other_labels, :string
    field :remaining, :decimal
    field :total, :decimal

    belongs_to :daily_check_in, DailyCheckIn

    timestamps()
  end

  @doc false
  def changeset(daily_invoice, attrs) do
    daily_invoice
    |> cast(attrs, [:deposit, :keycard_fees, :other_labels, :other_fees, :remaining, :total])
    |> validate_required([:deposit])
    |> calculate_remainder()
  end

  defp calculate_remainder(changeset) do
    total = get_field(changeset, :total)
    deposit = get_field(changeset, :deposit)

    case is_nil(total) do
      true ->
        changeset

      false ->
        remainder = Decimal.sub(total, deposit)
        put_change(changeset, :remaining, remainder)
    end
  end
end
