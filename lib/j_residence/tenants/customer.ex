defmodule JResidence.Tenants.Customer do
  alias JResidence.Tenants.DailyCustomer
  alias JResidence.Tenants.MonthlyCustomer
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "customers" do
    field :id_number, :string
    field :first_name, :string
    field :first_name_alt, :string
    field :last_name, :string
    field :last_name_alt, :string
    field :date_of_birth, :string
    field :religion, :string
    field :nationality, :string
    field :sex, :string
    field :address, :string
    field :issue_by, :string
    field :date_of_issue, :string
    field :date_of_expiry, :string
    field :photo, :string
    field :phone, :string
    field :line, :string
    field :occupation, :string
    field :emergency_contact, :string

    has_many :daily_customers, DailyCustomer
    has_many :monthly_customers, MonthlyCustomer

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [
      :id_number,
      :first_name,
      :first_name_alt,
      :last_name,
      :last_name_alt,
      :date_of_birth,
      :religion,
      :nationality,
      :sex,
      :address,
      :issue_by,
      :date_of_issue,
      :date_of_expiry,
      :photo,
      :phone,
      :line,
      :occupation,
      :emergency_contact
    ])
    |> validate_required([:id_number, :first_name, :last_name, :phone])
    |> unique_constraint(:id_number)
    |> add_photo()
  end

  defp add_photo(changeset) do
    id = get_field(changeset, :id_number)

    case is_nil(id) do
      true -> changeset
      false -> put_change(changeset, :photo, id <> ".jpg")
    end
  end
end
