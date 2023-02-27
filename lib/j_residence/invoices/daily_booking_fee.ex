defmodule JResidence.Invoices.DailyBookingFee do
  alias JResidence.Bookings.DailyBooking
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "daily_booking_fees" do
    field :booking_fees, :decimal
    field :deposit, :decimal
    field :room_fees, :decimal
    field :other_labels, :string
    field :other_fees, :decimal
    field :remaining, :decimal
    field :total, :decimal

    belongs_to :daily_booking, DailyBooking

    timestamps()
  end

  @doc false
  def changeset(daily_booking_fee, attrs) do
    daily_booking_fee
    |> cast(attrs, [
      :booking_fees,
      :deposit,
      :room_fees,
      :other_labels,
      :other_fees,
      :remaining,
      :total
    ])
    |> validate_required([:booking_fees, :deposit])
    |> calculate_remainder()
  end

  defp calculate_remainder(changeset) do
    total = get_field(changeset, :total)
    booking_fees = get_field(changeset, :booking_fees)

    case is_nil(total) do
      true ->
        changeset

      false ->
        remainder = Decimal.sub(total, booking_fees)
        put_change(changeset, :remaining, remainder)
    end
  end
end
