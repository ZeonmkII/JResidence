defmodule JResidence.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :id_number, :string
      add :first_name, :string
      add :first_name_alt, :string
      add :last_name, :string
      add :last_name_alt, :string
      add :date_of_birth, :string
      add :religion, :string
      add :nationality, :string
      add :sex, :string
      add :address, :string
      add :issue_by, :string
      add :date_of_issue, :string
      add :date_of_expiry, :string
      add :photo, :string
      add :phone, :string
      add :line, :string
      add :occupation, :string
      add :emergency_contact, :string

      timestamps()
    end
  end
end
