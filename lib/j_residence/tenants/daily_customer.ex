defmodule JResidence.Tenants.DailyCustomer do
  alias JResidence.Tenants.Customer
  alias JResidence.Bookings.{DailyCheckIn, DailyBooking}
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "daily_customers" do
    field :b_current, :string

    belongs_to :customer, Customer

    has_many :daily_bookings, DailyBooking
    has_many :daily_check_ins, DailyCheckIn

    timestamps()
  end

  @doc false
  def changeset(daily_customer, attrs) do
    daily_customer
    |> cast(attrs, [:b_current])
    |> validate_required([:b_current])
  end
end
