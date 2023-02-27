defmodule JResidence.FacilitiesTest do
  use JResidence.DataCase

  alias JResidence.Facilities

  describe "buildings" do
    alias JResidence.Facilities.Building

    import JResidence.FacilitiesFixtures

    @invalid_attrs %{address: nil, calc_type_electric: nil, calc_type_water: nil, name: nil, phone: nil, tax_id: nil, unit_price_eletric: nil, unit_price_water: nil}

    test "list_buildings/0 returns all buildings" do
      building = building_fixture()
      assert Facilities.list_buildings() == [building]
    end

    test "get_building!/1 returns the building with given id" do
      building = building_fixture()
      assert Facilities.get_building!(building.id) == building
    end

    test "create_building/1 with valid data creates a building" do
      valid_attrs = %{address: "some address", calc_type_electric: "120.5", calc_type_water: "120.5", name: "some name", phone: "some phone", tax_id: "some tax_id", unit_price_eletric: "120.5", unit_price_water: "120.5"}

      assert {:ok, %Building{} = building} = Facilities.create_building(valid_attrs)
      assert building.address == "some address"
      assert building.calc_type_electric == Decimal.new("120.5")
      assert building.calc_type_water == Decimal.new("120.5")
      assert building.name == "some name"
      assert building.phone == "some phone"
      assert building.tax_id == "some tax_id"
      assert building.unit_price_eletric == Decimal.new("120.5")
      assert building.unit_price_water == Decimal.new("120.5")
    end

    test "create_building/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Facilities.create_building(@invalid_attrs)
    end

    test "update_building/2 with valid data updates the building" do
      building = building_fixture()
      update_attrs = %{address: "some updated address", calc_type_electric: "456.7", calc_type_water: "456.7", name: "some updated name", phone: "some updated phone", tax_id: "some updated tax_id", unit_price_eletric: "456.7", unit_price_water: "456.7"}

      assert {:ok, %Building{} = building} = Facilities.update_building(building, update_attrs)
      assert building.address == "some updated address"
      assert building.calc_type_electric == Decimal.new("456.7")
      assert building.calc_type_water == Decimal.new("456.7")
      assert building.name == "some updated name"
      assert building.phone == "some updated phone"
      assert building.tax_id == "some updated tax_id"
      assert building.unit_price_eletric == Decimal.new("456.7")
      assert building.unit_price_water == Decimal.new("456.7")
    end

    test "update_building/2 with invalid data returns error changeset" do
      building = building_fixture()
      assert {:error, %Ecto.Changeset{}} = Facilities.update_building(building, @invalid_attrs)
      assert building == Facilities.get_building!(building.id)
    end

    test "delete_building/1 deletes the building" do
      building = building_fixture()
      assert {:ok, %Building{}} = Facilities.delete_building(building)
      assert_raise Ecto.NoResultsError, fn -> Facilities.get_building!(building.id) end
    end

    test "change_building/1 returns a building changeset" do
      building = building_fixture()
      assert %Ecto.Changeset{} = Facilities.change_building(building)
    end
  end
end
