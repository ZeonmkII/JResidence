defmodule JResidenceWeb.DailyCustomerLive.Show do
  use JResidenceWeb, :live_view

  alias JResidence.Tenants

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:daily_customer, Tenants.get_daily_customer!(id))}
  end

  defp page_title(:show), do: "Show Daily customer"
  defp page_title(:edit), do: "Edit Daily customer"
end
