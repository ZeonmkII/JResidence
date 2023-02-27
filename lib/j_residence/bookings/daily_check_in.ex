defmodule JResidence.Bookings.DailyCheckIn do
  alias JResidence.Tenants.DailyCustomer
  alias JResidence.Bookings.DailyBooking
  alias JResidence.Facilities.Room
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "daily_check_ins" do
    field :check_in, :date
    field :check_out, :date
    field :time_in, :time
    field :time_out, :time
    field :duration_day, :integer
    field :room_number, :string
    field :deposit, :decimal
    field :from, :string
    field :to, :string
    field :remarks, :string

    belongs_to :daily_customer, DailyCustomer
    belongs_to :daily_booking, DailyBooking
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(daily_check_in, attrs) do
    daily_check_in
    |> cast(attrs, [
      :check_in,
      :check_out,
      :time_in,
      :time_out,
      :duration_day,
      :room_number,
      :deposit,
      :from,
      :to,
      :remarks
    ])
    |> validate_required([
      :check_in,
      :check_out,
      :time_in,
      :room_number,
      :from,
      :to
    ])
    |> add_duration()
  end

  defp add_duration(changeset) do
    check_in = get_field(changeset, :check_in)
    check_out = get_field(changeset, :check_out)

    case is_nil(check_in && check_out) do
      true -> changeset
      false -> put_change(changeset, :duration_day, Date.diff(check_out, check_in))
    end
  end
end
