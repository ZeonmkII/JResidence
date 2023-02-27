defmodule JResidenceWeb.DailyBookingLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Bookings
  alias JResidence.Bookings.DailyBooking

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :daily_bookings, Bookings.list_daily_bookings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Daily booking")
    |> assign(:daily_booking, Bookings.get_daily_booking!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Daily booking")
    |> assign(:daily_booking, %DailyBooking{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Daily bookings")
    |> assign(:daily_booking, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.DailyBookingLive.FormComponent, {:saved, daily_booking}}, socket) do
    {:noreply, stream_insert(socket, :daily_bookings, daily_booking)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    daily_booking = Bookings.get_daily_booking!(id)
    {:ok, _} = Bookings.delete_daily_booking(daily_booking)

    {:noreply, stream_delete(socket, :daily_bookings, daily_booking)}
  end
end
