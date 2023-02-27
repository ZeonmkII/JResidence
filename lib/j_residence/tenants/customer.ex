defmodule JResidence.Tenants.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "customers" do
    field :address, :string
    field :date_of_birth, :string
    field :date_of_expiryphoto, :string
    field :date_of_issue, :string
    field :emergency_contact, :string
    field :first_name, :string
    field :first_name_alt, :string
    field :id_number, :string
    field :issue_by, :string
    field :last_name, :string
    field :last_name_alt, :string
    field :line, :string
    field :nationality, :string
    field :occupation, :string
    field :phone, :string
    field :religion, :string
    field :sex, :string

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:id_number, :first_name, :first_name_alt, :last_name, :last_name_alt, :date_of_birth, :religion, :nationality, :sex, :address, :issue_by, :date_of_issue, :date_of_expiryphoto, :phone, :line, :occupation, :emergency_contact])
    |> validate_required([:id_number, :first_name, :first_name_alt, :last_name, :last_name_alt, :date_of_birth, :religion, :nationality, :sex, :address, :issue_by, :date_of_issue, :date_of_expiryphoto, :phone, :line, :occupation, :emergency_contact])
  end
end
