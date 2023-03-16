defmodule JResidenceWeb.CustomerLive.Dashboard do
  use JResidenceWeb, :live_view

  alias JResidence.Tenants
  alias JResidence.Bookings

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _, socket) do
    {
      :noreply,
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:customer, Tenants.get_customer_by_id_number(id))
      |> assign(:monthly_bookings, list_monthly_bookings(id))
      |> assign(:contracts, list_monthly_contracts(id))
      |> assign(:daily_bookings, list_daily_bookings(id))
      |> assign(:today, get_current_date())
      |> assign(:show_customer_info, false)
      |> assign(:show_daily_bookings, true)
      |> assign(:show_contracts, true)
      |> assign(:debug, true)
      |> assign(:show_monthly_bookings, true)
      |> assign(:checkins, list_daily_check_ins(id))
      |> assign(:show_checkins, true)
    }
  end

  # ******************************************
  # ********** Handle Event Session **********
  # ******************************************

  def handle_event("toggle_customer_info", _session, socket) do
    case socket.assigns.show_customer_info do
      true -> {:noreply, socket |> assign(:show_customer_info, false)}
      false -> {:noreply, socket |> assign(:show_customer_info, true)}
    end
  end

  def handle_event("toggle_monthly_bookings", _session, socket) do
    case socket.assigns.show_monthly_bookings do
      true -> {:noreply, socket |> assign(:show_monthly_bookings, false)}
      false -> {:noreply, socket |> assign(:show_monthly_bookings, true)}
    end
  end

  def handle_event("toggle_daily_bookings", _session, socket) do
    case socket.assigns.show_daily_bookings do
      true -> {:noreply, socket |> assign(:show_daily_bookings, false)}
      false -> {:noreply, socket |> assign(:show_daily_bookings, true)}
    end
  end

  def handle_event("toggle_contracts", _session, socket) do
    case socket.assigns.show_contracts do
      true -> {:noreply, socket |> assign(:show_contracts, false)}
      false -> {:noreply, socket |> assign(:show_contracts, true)}
    end
  end

  def handle_event("toggle_check_ins", _session, socket) do
    case socket.assigns.show_checkins do
      true -> {:noreply, socket |> assign(:show_checkins, false)}
      false -> {:noreply, socket |> assign(:show_checkins, true)}
    end
  end

  def handle_event("book_monthly", %{"value" => id}, socket) do
    {:noreply,
     push_navigate(socket,
       to: "#"
       #    to: Routes.monthly_booking_create_path(socket, :new, id: id)
     )}
  end

  def handle_event("walkin_monthly", %{"value" => id}, socket) do
    {:noreply,
     push_navigate(socket,
       to: Routes.contract_create_path(socket, :new, %{id: id, booking_id: ""})
     )}
  end

  def handle_event("book_daily", %{"value" => id}, socket) do
    {:noreply,
     push_navigate(socket,
       to: Routes.daily_booking_create_path(socket, :new, id: id)
     )}
  end

  def handle_event("walkin_daily", %{"value" => id}, socket) do
    {:noreply,
     push_navigate(socket,
       to: Routes.checkin_create_path(socket, :new, %{id: id, booking_id: ""})
     )}
  end

  def handle_event("make_contract", %{"id" => id}, socket) do
    {:noreply,
     push_navigate(socket,
       to:
         Routes.contract_create_path(socket, :edit, %{
           id: socket.assigns.customer.uuid,
           booking_id: id
         })
     )}
  end

  def handle_event("make_check_in", %{"id" => id}, socket) do
    {:noreply,
     push_navigate(socket,
       to:
         Routes.checkin_create_path(socket, :edit, %{
           id: socket.assigns.customer.uuid,
           booking_id: id
         })
     )}
  end

  def handle_event("renew_contract", %{"id" => id}, socket) do
    {:noreply, push_navigate(socket, to: Routes.contract_renew_path(socket, :new, %{id: id}))}
  end

  def handle_event("renew_checkin", %{"id" => _id}, socket) do
    {:noreply, socket}
  end

  def handle_event("edit_m_booking", %{"id" => _id}, socket) do
    {:noreply, socket}
  end

  def handle_event("edit_d_booking", %{"id" => _id}, socket) do
    {:noreply, socket}
  end

  def handle_event("edit_contract", %{"id" => _id}, socket) do
    {:noreply, socket}
  end

  def handle_event("edit_checkin", %{"id" => _id}, socket) do
    {:noreply, socket}
  end

  def handle_event("delete_m_booking", %{"id" => id}, socket) do
    Booking.delete_monthly_booking(id)
    {:noreply, push_patch(socket, to: "#")}
  end

  def handle_event("delete_d_booking", %{"id" => id}, socket) do
    Booking.delete_daily_booking(id)
    {:noreply, push_patch(socket, to: "#")}
  end

  def handle_event("delete_contract", %{"id" => id}, socket) do
    Booking.delete_contract(id)
    {:noreply, push_patch(socket, to: "#")}
  end

  def handle_event("delete_checkin", %{"id" => id}, socket) do
    Booking.delete_checkin(id)
    {:noreply, push_patch(socket, to: "#")}
  end

  # ******************************************
  # ************* Assign Session *************
  # ******************************************
  # Change from list function

  defp page_title(:show), do: "🖥️ Customer Dashboard"
  defp page_title(:edit), do: "✍🏻 แก้ไขข้อมูลลูกค้า"

  # defp get_monthly_booking(id) do
  #   Bookings.get_monthly_booking!(id)
  # end

  # defp get_monthly_contract(id) do
  #   Bookings.get_monthly_contract!(id)
  # end

  # defp get_daily_booking(id) do
  #   Bookings.get_daily_booking!(id)
  # end

  # defp get_daily_check_in(id) do
  #   Bookings.get_daily_check_in!(id)
  # end

  defp list_monthly_bookings(id) do
    _node = Tenants.list_monthly_bookings_for_customer(id)
    # |> Enum.map(fn x ->
    #   val =
    #     %Booking.MonthlyBooking{}
    #     |> Booking.MonthlyBooking.changeset(x.properties)

    #   val.changes
    # end)
  end

  defp list_daily_bookings(id) do
    _node = Tenants.list_daily_bookings_for_customer(id)
    # |> Enum.map(fn x ->
    #   val =
    #     %Booking.DailyBooking{}
    #     |> Booking.DailyBooking.changeset(x.properties)

    #   val.changes
    # end)
  end

  defp list_daily_check_ins(id) do
    _node = Tenants.list_checkins_for_customer(id)
    # |> Enum.map(fn x ->
    #   val =
    #     %Booking.Checkin{}
    #     |> Booking.Checkin.changeset(x.properties)

    #   val.changes
    # end)
  end

  defp list_monthly_contracts(id) do
    _node = Tenants.list_contracts_for_customer(id)
    # |> Enum.map(fn x ->
    #   val =
    #     %Booking.Contract{}
    #     |> Booking.Contract.changeset(x.properties)

    #   val.changes
    # end)
  end

  defp get_current_date() do
    _date = Date.utc_today()
  end
end
