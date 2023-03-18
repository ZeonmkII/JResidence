defmodule JResidenceWeb.CustomerLive.Search do
  use JResidenceWeb, :live_view

  alias JResidence.Tenants

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        page_title: "ค้นหาข้อมูลลูกค้า",
        id_number: "",
        customers: list_customers(),
        error: false,
        error_msg: "",
        debug: false
      )

    {:ok, socket}
  end

  def handle_event("update", %{"input_id_number" => id_number}, socket) do
    socket = assign(socket, id_number: id_number)
    {:noreply, socket}
  end

  def handle_event("submit", %{"input_id_number" => id_number}, socket) do
    case Tenants.get_customer_by_id_number(id_number) do
      nil ->
        {:noreply,
         socket
         |> assign(error: true, error_msg: "⚠️ ไม่พบข้อมูลผู้ใช้ เลขประจำตัวประชาชน : #{id_number}")}

      customer ->
        {:noreply,
          push_navigate(socket, to: ~p"/customers/dashboard/#{customer.id_number}")}
    end
  end

  def handle_event("new_customer", _assign, socket) do
    {:noreply, push_navigate(socket, to: ~p"/customers/new")}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    {:ok, _} = Tenants.delete_customer(id)

    {:noreply, assign(socket, :customers, list_customers())}
  end

  defp list_customers do
    Tenants.list_customers()
  end
end
