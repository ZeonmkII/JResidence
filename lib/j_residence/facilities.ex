defmodule JResidence.Facilities do
  @moduledoc """
  The Facilities context.
  """

  import Ecto.Query, warn: false
  alias JResidence.Repo

  alias JResidence.Facilities.Building

  @doc """
  Returns the list of buildings.

  ## Examples

      iex> list_buildings()
      [%Building{}, ...]

  """
  def list_buildings do
    Repo.all(Building)
  end

  @doc """
  Gets a single building.

  Raises `Ecto.NoResultsError` if the Building does not exist.

  ## Examples

      iex> get_building!(123)
      %Building{}

      iex> get_building!(456)
      ** (Ecto.NoResultsError)

  """
  def get_building!(id), do: Repo.get!(Building, id)

  @doc """
  Creates a building.

  ## Examples

      iex> create_building(%{field: value})
      {:ok, %Building{}}

      iex> create_building(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_building(attrs \\ %{}) do
    %Building{}
    |> Building.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a building.

  ## Examples

      iex> update_building(building, %{field: new_value})
      {:ok, %Building{}}

      iex> update_building(building, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_building(%Building{} = building, attrs) do
    building
    |> Building.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a building.

  ## Examples

      iex> delete_building(building)
      {:ok, %Building{}}

      iex> delete_building(building)
      {:error, %Ecto.Changeset{}}

  """
  def delete_building(%Building{} = building) do
    Repo.delete(building)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking building changes.

  ## Examples

      iex> change_building(building)
      %Ecto.Changeset{data: %Building{}}

  """
  def change_building(%Building{} = building, attrs \\ %{}) do
    Building.changeset(building, attrs)
  end

  alias JResidence.Facilities.Floor

  @doc """
  Returns the list of floors.

  ## Examples

      iex> list_floors()
      [%Floor{}, ...]

  """
  def list_floors do
    Repo.all(Floor)
  end

  @doc """
  Gets a single floor.

  Raises `Ecto.NoResultsError` if the Floor does not exist.

  ## Examples

      iex> get_floor!(123)
      %Floor{}

      iex> get_floor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_floor!(id), do: Repo.get!(Floor, id)

  @doc """
  Creates a floor.

  ## Examples

      iex> create_floor(%{field: value})
      {:ok, %Floor{}}

      iex> create_floor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_floor(attrs \\ %{}) do
    %Floor{}
    |> Floor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a floor.

  ## Examples

      iex> update_floor(floor, %{field: new_value})
      {:ok, %Floor{}}

      iex> update_floor(floor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_floor(%Floor{} = floor, attrs) do
    floor
    |> Floor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a floor.

  ## Examples

      iex> delete_floor(floor)
      {:ok, %Floor{}}

      iex> delete_floor(floor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_floor(%Floor{} = floor) do
    Repo.delete(floor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking floor changes.

  ## Examples

      iex> change_floor(floor)
      %Ecto.Changeset{data: %Floor{}}

  """
  def change_floor(%Floor{} = floor, attrs \\ %{}) do
    Floor.changeset(floor, attrs)
  end
end
