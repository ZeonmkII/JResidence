defmodule JResidenceWeb.DailyCustomerLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Tenants
  alias JResidence.Tenants.DailyCustomer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :daily_customers, Tenants.list_daily_customers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Daily customer")
    |> assign(:daily_customer, Tenants.get_daily_customer!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Daily customer")
    |> assign(:daily_customer, %DailyCustomer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Daily customers")
    |> assign(:daily_customer, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.DailyCustomerLive.FormComponent, {:saved, daily_customer}}, socket) do
    {:noreply, stream_insert(socket, :daily_customers, daily_customer)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    daily_customer = Tenants.get_daily_customer!(id)
    {:ok, _} = Tenants.delete_daily_customer(daily_customer)

    {:noreply, stream_delete(socket, :daily_customers, daily_customer)}
  end
end
