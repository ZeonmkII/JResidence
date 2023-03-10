defmodule JResidenceWeb.BuildingLive.FormComponent do
  use JResidenceWeb, :live_component

  alias JResidence.Facilities

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage building records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="building-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:tax_id]} type="text" label="Tax" />
        <.input field={@form[:phone]} type="text" label="Phone" />
        <.input field={@form[:calc_type_water]} type="number" label="Calc type water" step="any" />
        <.input field={@form[:calc_type_electric]} type="number" label="Calc type electric" step="any" />
        <.input field={@form[:unit_price_water]} type="number" label="Unit price water" step="any" />
        <.input field={@form[:unit_price_eletric]} type="number" label="Unit price eletric" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Building</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{building: building} = assigns, socket) do
    changeset = Facilities.change_building(building)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"building" => building_params}, socket) do
    changeset =
      socket.assigns.building
      |> Facilities.change_building(building_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"building" => building_params}, socket) do
    save_building(socket, socket.assigns.action, building_params)
  end

  defp save_building(socket, :edit, building_params) do
    case Facilities.update_building(socket.assigns.building, building_params) do
      {:ok, building} ->
        notify_parent({:saved, building})

        {:noreply,
         socket
         |> put_flash(:info, "Building updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_building(socket, :new, building_params) do
    case Facilities.create_building(building_params) do
      {:ok, building} ->
        notify_parent({:saved, building})

        {:noreply,
         socket
         |> put_flash(:info, "Building created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
