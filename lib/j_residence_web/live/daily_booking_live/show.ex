defmodule JResidenceWeb.DailyBookingLive.Show do
  use JResidenceWeb, :live_view

  alias JResidence.Bookings

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:daily_booking, Bookings.get_daily_booking!(id))}
  end

  defp page_title(:show), do: "Show Daily booking"
  defp page_title(:edit), do: "Edit Daily booking"
end
