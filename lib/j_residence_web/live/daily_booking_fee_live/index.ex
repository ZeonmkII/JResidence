defmodule JResidenceWeb.DailyBookingFeeLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Invoices
  alias JResidence.Invoices.DailyBookingFee

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :daily_booking_fees, Invoices.list_daily_booking_fees())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Daily booking fee")
    |> assign(:daily_booking_fee, Invoices.get_daily_booking_fee!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Daily booking fee")
    |> assign(:daily_booking_fee, %DailyBookingFee{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Daily booking fees")
    |> assign(:daily_booking_fee, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.DailyBookingFeeLive.FormComponent, {:saved, daily_booking_fee}}, socket) do
    {:noreply, stream_insert(socket, :daily_booking_fees, daily_booking_fee)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    daily_booking_fee = Invoices.get_daily_booking_fee!(id)
    {:ok, _} = Invoices.delete_daily_booking_fee(daily_booking_fee)

    {:noreply, stream_delete(socket, :daily_booking_fees, daily_booking_fee)}
  end
end
