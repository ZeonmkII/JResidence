defmodule JResidence.TenantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JResidence.Tenants` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        address: "some address",
        date_of_birth: "some date_of_birth",
        date_of_expiryphoto: "some date_of_expiryphoto",
        date_of_issue: "some date_of_issue",
        emergency_contact: "some emergency_contact",
        first_name: "some first_name",
        first_name_alt: "some first_name_alt",
        id_number: "some id_number",
        issue_by: "some issue_by",
        last_name: "some last_name",
        last_name_alt: "some last_name_alt",
        line: "some line",
        nationality: "some nationality",
        occupation: "some occupation",
        phone: "some phone",
        religion: "some religion",
        sex: "some sex"
      })
      |> JResidence.Tenants.create_customer()

    customer
  end
end
