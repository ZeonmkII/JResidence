defmodule JResidence.Tenants.MonthlyCustomer do
  alias JResidence.Bookings.MonthlyBooking
  alias JResidence.Tenants.Customer
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "monthly_customers" do
    field :b_contract, :string
    field :b_current, :string
    field :b_tenant, :string

    belongs_to :customer, Customer

    has_many :monthly_bookings, MonthlyBooking

    timestamps()
  end

  @doc false
  def changeset(monthly_customer, attrs) do
    monthly_customer
    |> cast(attrs, [:b_contract, :b_current, :b_tenant])
    |> validate_required([:b_contract, :b_current, :b_tenant])
  end
end
