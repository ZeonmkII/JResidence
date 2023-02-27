defmodule JResidenceWeb.DailyCheckInLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Bookings
  alias JResidence.Bookings.DailyCheckIn

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :daily_check_ins, Bookings.list_daily_check_ins())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Daily check in")
    |> assign(:daily_check_in, Bookings.get_daily_check_in!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Daily check in")
    |> assign(:daily_check_in, %DailyCheckIn{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Daily check ins")
    |> assign(:daily_check_in, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.DailyCheckInLive.FormComponent, {:saved, daily_check_in}}, socket) do
    {:noreply, stream_insert(socket, :daily_check_ins, daily_check_in)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    daily_check_in = Bookings.get_daily_check_in!(id)
    {:ok, _} = Bookings.delete_daily_check_in(daily_check_in)

    {:noreply, stream_delete(socket, :daily_check_ins, daily_check_in)}
  end
end
