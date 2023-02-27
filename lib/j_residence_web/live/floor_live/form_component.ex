defmodule JResidenceWeb.FloorLive.FormComponent do
  use JResidenceWeb, :live_component

  alias JResidence.Facilities

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage floor records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="floor-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:floor_number]} type="text" label="Floor number" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Floor</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{floor: floor} = assigns, socket) do
    changeset = Facilities.change_floor(floor)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"floor" => floor_params}, socket) do
    changeset =
      socket.assigns.floor
      |> Facilities.change_floor(floor_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"floor" => floor_params}, socket) do
    save_floor(socket, socket.assigns.action, floor_params)
  end

  defp save_floor(socket, :edit, floor_params) do
    case Facilities.update_floor(socket.assigns.floor, floor_params) do
      {:ok, floor} ->
        notify_parent({:saved, floor})

        {:noreply,
         socket
         |> put_flash(:info, "Floor updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_floor(socket, :new, floor_params) do
    case Facilities.create_floor(floor_params) do
      {:ok, floor} ->
        notify_parent({:saved, floor})

        {:noreply,
         socket
         |> put_flash(:info, "Floor created successfully")
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
