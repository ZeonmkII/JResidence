defmodule JResidenceWeb.BuildingLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Facilities
  alias JResidence.Facilities.Building

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :buildings, Facilities.list_buildings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Building")
    |> assign(:building, Facilities.get_building!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Building")
    |> assign(:building, %Building{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Buildings")
    |> assign(:building, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.BuildingLive.FormComponent, {:saved, building}}, socket) do
    {:noreply, stream_insert(socket, :buildings, building)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    building = Facilities.get_building!(id)
    {:ok, _} = Facilities.delete_building(building)

    {:noreply, stream_delete(socket, :buildings, building)}
  end
end
