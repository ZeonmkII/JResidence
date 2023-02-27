defmodule JResidence.TenantsTest do
  use JResidence.DataCase

  alias JResidence.Tenants

  describe "customers" do
    alias JResidence.Tenants.Customer

    import JResidence.TenantsFixtures

    @invalid_attrs %{address: nil, date_of_birth: nil, date_of_expiryphoto: nil, date_of_issue: nil, emergency_contact: nil, first_name: nil, first_name_alt: nil, id_number: nil, issue_by: nil, last_name: nil, last_name_alt: nil, line: nil, nationality: nil, occupation: nil, phone: nil, religion: nil, sex: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Tenants.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Tenants.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{address: "some address", date_of_birth: "some date_of_birth", date_of_expiryphoto: "some date_of_expiryphoto", date_of_issue: "some date_of_issue", emergency_contact: "some emergency_contact", first_name: "some first_name", first_name_alt: "some first_name_alt", id_number: "some id_number", issue_by: "some issue_by", last_name: "some last_name", last_name_alt: "some last_name_alt", line: "some line", nationality: "some nationality", occupation: "some occupation", phone: "some phone", religion: "some religion", sex: "some sex"}

      assert {:ok, %Customer{} = customer} = Tenants.create_customer(valid_attrs)
      assert customer.address == "some address"
      assert customer.date_of_birth == "some date_of_birth"
      assert customer.date_of_expiryphoto == "some date_of_expiryphoto"
      assert customer.date_of_issue == "some date_of_issue"
      assert customer.emergency_contact == "some emergency_contact"
      assert customer.first_name == "some first_name"
      assert customer.first_name_alt == "some first_name_alt"
      assert customer.id_number == "some id_number"
      assert customer.issue_by == "some issue_by"
      assert customer.last_name == "some last_name"
      assert customer.last_name_alt == "some last_name_alt"
      assert customer.line == "some line"
      assert customer.nationality == "some nationality"
      assert customer.occupation == "some occupation"
      assert customer.phone == "some phone"
      assert customer.religion == "some religion"
      assert customer.sex == "some sex"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tenants.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{address: "some updated address", date_of_birth: "some updated date_of_birth", date_of_expiryphoto: "some updated date_of_expiryphoto", date_of_issue: "some updated date_of_issue", emergency_contact: "some updated emergency_contact", first_name: "some updated first_name", first_name_alt: "some updated first_name_alt", id_number: "some updated id_number", issue_by: "some updated issue_by", last_name: "some updated last_name", last_name_alt: "some updated last_name_alt", line: "some updated line", nationality: "some updated nationality", occupation: "some updated occupation", phone: "some updated phone", religion: "some updated religion", sex: "some updated sex"}

      assert {:ok, %Customer{} = customer} = Tenants.update_customer(customer, update_attrs)
      assert customer.address == "some updated address"
      assert customer.date_of_birth == "some updated date_of_birth"
      assert customer.date_of_expiryphoto == "some updated date_of_expiryphoto"
      assert customer.date_of_issue == "some updated date_of_issue"
      assert customer.emergency_contact == "some updated emergency_contact"
      assert customer.first_name == "some updated first_name"
      assert customer.first_name_alt == "some updated first_name_alt"
      assert customer.id_number == "some updated id_number"
      assert customer.issue_by == "some updated issue_by"
      assert customer.last_name == "some updated last_name"
      assert customer.last_name_alt == "some updated last_name_alt"
      assert customer.line == "some updated line"
      assert customer.nationality == "some updated nationality"
      assert customer.occupation == "some updated occupation"
      assert customer.phone == "some updated phone"
      assert customer.religion == "some updated religion"
      assert customer.sex == "some updated sex"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Tenants.update_customer(customer, @invalid_attrs)
      assert customer == Tenants.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Tenants.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Tenants.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Tenants.change_customer(customer)
    end
  end
end
