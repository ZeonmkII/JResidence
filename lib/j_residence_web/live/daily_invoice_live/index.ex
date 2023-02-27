defmodule JResidenceWeb.DailyInvoiceLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Invoices
  alias JResidence.Invoices.DailyInvoice

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :daily_invoices, Invoices.list_daily_invoices())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Daily invoice")
    |> assign(:daily_invoice, Invoices.get_daily_invoice!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Daily invoice")
    |> assign(:daily_invoice, %DailyInvoice{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Daily invoices")
    |> assign(:daily_invoice, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.DailyInvoiceLive.FormComponent, {:saved, daily_invoice}}, socket) do
    {:noreply, stream_insert(socket, :daily_invoices, daily_invoice)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    daily_invoice = Invoices.get_daily_invoice!(id)
    {:ok, _} = Invoices.delete_daily_invoice(daily_invoice)

    {:noreply, stream_delete(socket, :daily_invoices, daily_invoice)}
  end
end
