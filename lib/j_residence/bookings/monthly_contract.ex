defmodule JResidence.Bookings.MonthlyContract do
  alias JResidence.Tenants.MonthlyCustomer
  alias JResidence.Facilities.Room
  alias JResidence.Bookings.MonthlyBooking
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "monthly_contracts" do
    field :date_signed, :date
    field :check_in, :date
    field :check_out, :date
    field :duration_month, :integer
    field :duration_day, :integer
    field :room_number, :string
    field :rent_fees, :decimal
    field :service_fees, :decimal
    field :deposit, :decimal
    field :advance_payment, :decimal
    field :keycard_fees, :decimal
    field :keycard_number, :string
    field :other_labels, :string
    field :other_fees, :decimal
    field :meter_water, :decimal
    field :meter_electric, :decimal
    field :remarks, :string

    belongs_to :monthly_customer, MonthlyCustomer
    belongs_to :monthly_booking, MonthlyBooking
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(monthly_contract, attrs) do
    monthly_contract
    |> cast(attrs, [
      :date_signed,
      :check_in,
      :check_out,
      :duration_month,
      :duration_day,
      :room_number,
      :rent_fees,
      :service_fees,
      :deposit,
      :advance_payment,
      :keycard_fees,
      :keycard_number,
      :other_labels,
      :other_fees,
      :meter_water,
      :meter_electric,
      :remarks
    ])
    |> validate_required([
      :date_signed,
      :check_in,
      :check_out,
      :room_number,
      :rent_fees,
      :deposit,
      :advance_payment,
      :keycard_fees,
      :keycard_number,
      :meter_water,
      :meter_electric
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
