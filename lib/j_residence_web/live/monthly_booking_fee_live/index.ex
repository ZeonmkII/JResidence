defmodule JResidenceWeb.MonthlyBookingFeeLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Invoices
  alias JResidence.Invoices.MonthlyBookingFee

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :monthly_booking_fees, Invoices.list_monthly_booking_fees())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Monthly booking fee")
    |> assign(:monthly_booking_fee, Invoices.get_monthly_booking_fee!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Monthly booking fee")
    |> assign(:monthly_booking_fee, %MonthlyBookingFee{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Monthly booking fees")
    |> assign(:monthly_booking_fee, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.MonthlyBookingFeeLive.FormComponent, {:saved, monthly_booking_fee}}, socket) do
    {:noreply, stream_insert(socket, :monthly_booking_fees, monthly_booking_fee)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    monthly_booking_fee = Invoices.get_monthly_booking_fee!(id)
    {:ok, _} = Invoices.delete_monthly_booking_fee(monthly_booking_fee)

    {:noreply, stream_delete(socket, :monthly_booking_fees, monthly_booking_fee)}
  end
end
