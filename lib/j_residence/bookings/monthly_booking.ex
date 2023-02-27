defmodule JResidence.Bookings.MonthlyBooking do
  alias JResidence.Facilities.Room
  alias JResidence.Tenants.MonthlyCustomer
  alias JResidence.Bookings.MonthlyContract
  alias JResidence.Invoices.MonthlyBookingFee
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "monthly_bookings" do
    field :check_in, :date
    field :check_out, :date
    field :duration_month, :integer
    field :duration_day, :integer
    field :remarks, :string
    field :rent_fees, :decimal
    field :service_fees, :decimal
    field :deposit, :decimal
    field :advance_payment, :decimal
    field :keycard_fees, :decimal
    field :other_labels, :string
    field :other_fees, :decimal
    field :remaining, :decimal
    field :total, :decimal

    belongs_to :monthly_customer, MonthlyCustomer
    belongs_to :room, Room

    has_one :monthly_contract, MonthlyContract
    has_one :monthly_booking_fee, MonthlyBookingFee

    timestamps()
  end

  @doc false
  def changeset(monthly_booking, attrs) do
    monthly_booking
    |> cast(attrs, [
      :check_in,
      :check_out,
      :duration_month,
      :duration_day,
      :remarks,
      :rent_fees,
      :service_fees,
      :deposit,
      :advance_payment,
      :keycard_fees,
      :other_labels,
      :other_fees,
      :remaining,
      :total
    ])
    |> validate_required([
      :check_in,
      :check_out,
      :rent_fees,
      :deposit,
      :advance_payment,
      :keycard_fees
    ])
    |> add_duration()
  end

  defp add_duration(changeset) do
    check_in = get_field(changeset, :check_in)
    check_out = get_field(changeset, :check_out)

    case is_nil(check_in) do
      true ->
        changeset

      false ->
        total = Date.diff(check_out, check_in)

        # How many FULL months, that customer stayed (stay less than a month -> zero)
        # TODO fix the logic
        months = div(total, 30)
        changeset = put_change(changeset, :duration_month, months)
        days = total - months * 30
        put_change(changeset, :duration_day, days)
    end
  end
end
