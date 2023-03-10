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
        date_of_expiry: "some date_of_expiry",
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
        photo: "some photo",
        religion: "some religion",
        sex: "some sex"
      })
      |> JResidence.Tenants.create_customer()

    customer
  end

  @doc """
  Generate a daily_customer.
  """
  def daily_customer_fixture(attrs \\ %{}) do
    {:ok, daily_customer} =
      attrs
      |> Enum.into(%{
        b_current: "some b_current"
      })
      |> JResidence.Tenants.create_daily_customer()

    daily_customer
  end

  @doc """
  Generate a monthly_customer.
  """
  def monthly_customer_fixture(attrs \\ %{}) do
    {:ok, monthly_customer} =
      attrs
      |> Enum.into(%{
        b_contract: "some b_contract",
        b_current: "some b_current",
        b_tenant: "some b_tenant"
      })
      |> JResidence.Tenants.create_monthly_customer()

    monthly_customer
  end
end
