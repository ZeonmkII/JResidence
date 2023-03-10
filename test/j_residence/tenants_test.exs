defmodule JResidence.TenantsTest do
  use JResidence.DataCase

  alias JResidence.Tenants

  describe "customers" do
    alias JResidence.Tenants.Customer

    import JResidence.TenantsFixtures

    @invalid_attrs %{
      address: nil,
      date_of_birth: nil,
      date_of_expiry: nil,
      date_of_issue: nil,
      emergency_contact: nil,
      first_name: nil,
      first_name_alt: nil,
      id_number: nil,
      issue_by: nil,
      last_name: nil,
      last_name_alt: nil,
      line: nil,
      nationality: nil,
      occupation: nil,
      phone: nil,
      photo: nil,
      religion: nil,
      sex: nil
    }

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Tenants.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Tenants.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{
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
      }

      assert {:ok, %Customer{} = customer} = Tenants.create_customer(valid_attrs)
      assert customer.address == "some address"
      assert customer.date_of_birth == "some date_of_birth"
      assert customer.date_of_expiry == "some date_of_expiry"
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
      assert customer.photo == "some id_number.jpg"
      assert customer.religion == "some religion"
      assert customer.sex == "some sex"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tenants.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()

      update_attrs = %{
        address: "some updated address",
        date_of_birth: "some updated date_of_birth",
        date_of_expiry: "some updated date_of_expiry",
        date_of_issue: "some updated date_of_issue",
        emergency_contact: "some updated emergency_contact",
        first_name: "some updated first_name",
        first_name_alt: "some updated first_name_alt",
        id_number: "some updated id_number",
        issue_by: "some updated issue_by",
        last_name: "some updated last_name",
        last_name_alt: "some updated last_name_alt",
        line: "some updated line",
        nationality: "some updated nationality",
        occupation: "some updated occupation",
        phone: "some updated phone",
        photo: "some updated photo",
        religion: "some updated religion",
        sex: "some updated sex"
      }

      assert {:ok, %Customer{} = customer} = Tenants.update_customer(customer, update_attrs)
      assert customer.address == "some updated address"
      assert customer.date_of_birth == "some updated date_of_birth"
      assert customer.date_of_expiry == "some updated date_of_expiry"
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
      assert customer.photo == "some updated id_number.jpg"
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

  describe "daily_customers" do
    alias JResidence.Tenants.DailyCustomer

    import JResidence.TenantsFixtures

    @invalid_attrs %{b_current: nil}

    test "list_daily_customers/0 returns all daily_customers" do
      daily_customer = daily_customer_fixture()
      assert Tenants.list_daily_customers() == [daily_customer]
    end

    test "get_daily_customer!/1 returns the daily_customer with given id" do
      daily_customer = daily_customer_fixture()
      assert Tenants.get_daily_customer!(daily_customer.id) == daily_customer
    end

    test "create_daily_customer/1 with valid data creates a daily_customer" do
      valid_attrs = %{b_current: "some b_current"}

      assert {:ok, %DailyCustomer{} = daily_customer} = Tenants.create_daily_customer(valid_attrs)
      assert daily_customer.b_current == "some b_current"
    end

    test "create_daily_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tenants.create_daily_customer(@invalid_attrs)
    end

    test "update_daily_customer/2 with valid data updates the daily_customer" do
      daily_customer = daily_customer_fixture()
      update_attrs = %{b_current: "some updated b_current"}

      assert {:ok, %DailyCustomer{} = daily_customer} = Tenants.update_daily_customer(daily_customer, update_attrs)
      assert daily_customer.b_current == "some updated b_current"
    end

    test "update_daily_customer/2 with invalid data returns error changeset" do
      daily_customer = daily_customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Tenants.update_daily_customer(daily_customer, @invalid_attrs)
      assert daily_customer == Tenants.get_daily_customer!(daily_customer.id)
    end

    test "delete_daily_customer/1 deletes the daily_customer" do
      daily_customer = daily_customer_fixture()
      assert {:ok, %DailyCustomer{}} = Tenants.delete_daily_customer(daily_customer)
      assert_raise Ecto.NoResultsError, fn -> Tenants.get_daily_customer!(daily_customer.id) end
    end

    test "change_daily_customer/1 returns a daily_customer changeset" do
      daily_customer = daily_customer_fixture()
      assert %Ecto.Changeset{} = Tenants.change_daily_customer(daily_customer)
    end
  end

  describe "monthly_customers" do
    alias JResidence.Tenants.MonthlyCustomer

    import JResidence.TenantsFixtures

    @invalid_attrs %{b_contract: nil, b_current: nil, b_tenant: nil}

    test "list_monthly_customers/0 returns all monthly_customers" do
      monthly_customer = monthly_customer_fixture()
      assert Tenants.list_monthly_customers() == [monthly_customer]
    end

    test "get_monthly_customer!/1 returns the monthly_customer with given id" do
      monthly_customer = monthly_customer_fixture()
      assert Tenants.get_monthly_customer!(monthly_customer.id) == monthly_customer
    end

    test "create_monthly_customer/1 with valid data creates a monthly_customer" do
      valid_attrs = %{b_contract: "some b_contract", b_current: "some b_current", b_tenant: "some b_tenant"}

      assert {:ok, %MonthlyCustomer{} = monthly_customer} = Tenants.create_monthly_customer(valid_attrs)
      assert monthly_customer.b_contract == "some b_contract"
      assert monthly_customer.b_current == "some b_current"
      assert monthly_customer.b_tenant == "some b_tenant"
    end

    test "create_monthly_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tenants.create_monthly_customer(@invalid_attrs)
    end

    test "update_monthly_customer/2 with valid data updates the monthly_customer" do
      monthly_customer = monthly_customer_fixture()
      update_attrs = %{b_contract: "some updated b_contract", b_current: "some updated b_current", b_tenant: "some updated b_tenant"}

      assert {:ok, %MonthlyCustomer{} = monthly_customer} = Tenants.update_monthly_customer(monthly_customer, update_attrs)
      assert monthly_customer.b_contract == "some updated b_contract"
      assert monthly_customer.b_current == "some updated b_current"
      assert monthly_customer.b_tenant == "some updated b_tenant"
    end

    test "update_monthly_customer/2 with invalid data returns error changeset" do
      monthly_customer = monthly_customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Tenants.update_monthly_customer(monthly_customer, @invalid_attrs)
      assert monthly_customer == Tenants.get_monthly_customer!(monthly_customer.id)
    end

    test "delete_monthly_customer/1 deletes the monthly_customer" do
      monthly_customer = monthly_customer_fixture()
      assert {:ok, %MonthlyCustomer{}} = Tenants.delete_monthly_customer(monthly_customer)
      assert_raise Ecto.NoResultsError, fn -> Tenants.get_monthly_customer!(monthly_customer.id) end
    end

    test "change_monthly_customer/1 returns a monthly_customer changeset" do
      monthly_customer = monthly_customer_fixture()
      assert %Ecto.Changeset{} = Tenants.change_monthly_customer(monthly_customer)
    end
  end
end
