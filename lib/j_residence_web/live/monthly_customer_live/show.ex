defmodule JResidenceWeb.MonthlyCustomerLive.Show do
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
     |> assign(:monthly_customer, Tenants.get_monthly_customer!(id))}
  end

  defp page_title(:show), do: "Show Monthly customer"
  defp page_title(:edit), do: "Edit Monthly customer"
end
