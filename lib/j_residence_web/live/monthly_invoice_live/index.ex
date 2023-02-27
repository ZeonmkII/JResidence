defmodule JResidenceWeb.MonthlyInvoiceLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Invoices
  alias JResidence.Invoices.MonthlyInvoice

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :monthly_invoices, Invoices.list_monthly_invoices())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Monthly invoice")
    |> assign(:monthly_invoice, Invoices.get_monthly_invoice!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Monthly invoice")
    |> assign(:monthly_invoice, %MonthlyInvoice{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Monthly invoices")
    |> assign(:monthly_invoice, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.MonthlyInvoiceLive.FormComponent, {:saved, monthly_invoice}}, socket) do
    {:noreply, stream_insert(socket, :monthly_invoices, monthly_invoice)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    monthly_invoice = Invoices.get_monthly_invoice!(id)
    {:ok, _} = Invoices.delete_monthly_invoice(monthly_invoice)

    {:noreply, stream_delete(socket, :monthly_invoices, monthly_invoice)}
  end
end
