defmodule JResidenceWeb.BuildingLive.Show do
  use JResidenceWeb, :live_view

  alias JResidence.Facilities

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:building, Facilities.get_building!(id))}
  end

  defp page_title(:show), do: "Show Building"
  defp page_title(:edit), do: "Edit Building"
end
