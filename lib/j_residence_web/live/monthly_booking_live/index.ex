defmodule JResidenceWeb.MonthlyBookingLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Bookings
  alias JResidence.Bookings.MonthlyBooking

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :monthly_bookings, Bookings.list_monthly_bookings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Monthly booking")
    |> assign(:monthly_booking, Bookings.get_monthly_booking!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Monthly booking")
    |> assign(:monthly_booking, %MonthlyBooking{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Monthly bookings")
    |> assign(:monthly_booking, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.MonthlyBookingLive.FormComponent, {:saved, monthly_booking}}, socket) do
    {:noreply, stream_insert(socket, :monthly_bookings, monthly_booking)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    monthly_booking = Bookings.get_monthly_booking!(id)
    {:ok, _} = Bookings.delete_monthly_booking(monthly_booking)

    {:noreply, stream_delete(socket, :monthly_bookings, monthly_booking)}
  end
end
