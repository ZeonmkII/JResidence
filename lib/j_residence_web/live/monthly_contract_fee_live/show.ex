defmodule JResidenceWeb.MonthlyContractFeeLive.Show do
  use JResidenceWeb, :live_view

  alias JResidence.Receipts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:monthly_contract_fee, Receipts.get_monthly_contract_fee!(id))}
  end

  defp page_title(:show), do: "Show Monthly contract fee"
  defp page_title(:edit), do: "Edit Monthly contract fee"
end
