defmodule JResidenceWeb.MonthlyContractFeeLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Receipts
  alias JResidence.Receipts.MonthlyContractFee

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :monthly_contract_fees, Receipts.list_monthly_contract_fees())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Monthly contract fee")
    |> assign(:monthly_contract_fee, Receipts.get_monthly_contract_fee!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Monthly contract fee")
    |> assign(:monthly_contract_fee, %MonthlyContractFee{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Monthly contract fees")
    |> assign(:monthly_contract_fee, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.MonthlyContractFeeLive.FormComponent, {:saved, monthly_contract_fee}}, socket) do
    {:noreply, stream_insert(socket, :monthly_contract_fees, monthly_contract_fee)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    monthly_contract_fee = Receipts.get_monthly_contract_fee!(id)
    {:ok, _} = Receipts.delete_monthly_contract_fee(monthly_contract_fee)

    {:noreply, stream_delete(socket, :monthly_contract_fees, monthly_contract_fee)}
  end
end
