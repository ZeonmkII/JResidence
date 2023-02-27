defmodule JResidenceWeb.FloorLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Facilities
  alias JResidence.Facilities.Floor

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :floors, Facilities.list_floors())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Floor")
    |> assign(:floor, Facilities.get_floor!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Floor")
    |> assign(:floor, %Floor{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Floors")
    |> assign(:floor, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.FloorLive.FormComponent, {:saved, floor}}, socket) do
    {:noreply, stream_insert(socket, :floors, floor)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    floor = Facilities.get_floor!(id)
    {:ok, _} = Facilities.delete_floor(floor)

    {:noreply, stream_delete(socket, :floors, floor)}
  end
end
