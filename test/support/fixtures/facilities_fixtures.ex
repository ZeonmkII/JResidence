defmodule JResidence.FacilitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JResidence.Facilities` context.
  """

  @doc """
  Generate a building.
  """
  def building_fixture(attrs \\ %{}) do
    {:ok, building} =
      attrs
      |> Enum.into(%{
        address: "some address",
        calc_type_electric: "120.5",
        calc_type_water: "120.5",
        name: "some name",
        phone: "some phone",
        tax_id: "some tax_id",
        unit_price_eletric: "120.5",
        unit_price_water: "120.5"
      })
      |> JResidence.Facilities.create_building()

    building
  end

  @doc """
  Generate a floor.
  """
  def floor_fixture(attrs \\ %{}) do
    {:ok, floor} =
      attrs
      |> Enum.into(%{
        floor_number: "some floor_number"
      })
      |> JResidence.Facilities.create_floor()

    floor
  end
end
