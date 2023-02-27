defmodule JResidenceWeb.MonthlyContractLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Bookings
  alias JResidence.Bookings.MonthlyContract

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :monthly_contracts, Bookings.list_monthly_contracts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Monthly contract")
    |> assign(:monthly_contract, Bookings.get_monthly_contract!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Monthly contract")
    |> assign(:monthly_contract, %MonthlyContract{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Monthly contracts")
    |> assign(:monthly_contract, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.MonthlyContractLive.FormComponent, {:saved, monthly_contract}}, socket) do
    {:noreply, stream_insert(socket, :monthly_contracts, monthly_contract)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    monthly_contract = Bookings.get_monthly_contract!(id)
    {:ok, _} = Bookings.delete_monthly_contract(monthly_contract)

    {:noreply, stream_delete(socket, :monthly_contracts, monthly_contract)}
  end
end
