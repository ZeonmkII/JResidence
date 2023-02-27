defmodule JResidenceWeb.MonthlyCustomerLive.Index do
  use JResidenceWeb, :live_view

  alias JResidence.Tenants
  alias JResidence.Tenants.MonthlyCustomer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :monthly_customers, Tenants.list_monthly_customers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Monthly customer")
    |> assign(:monthly_customer, Tenants.get_monthly_customer!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Monthly customer")
    |> assign(:monthly_customer, %MonthlyCustomer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Monthly customers")
    |> assign(:monthly_customer, nil)
  end

  @impl true
  def handle_info({JResidenceWeb.MonthlyCustomerLive.FormComponent, {:saved, monthly_customer}}, socket) do
    {:noreply, stream_insert(socket, :monthly_customers, monthly_customer)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    monthly_customer = Tenants.get_monthly_customer!(id)
    {:ok, _} = Tenants.delete_monthly_customer(monthly_customer)

    {:noreply, stream_delete(socket, :monthly_customers, monthly_customer)}
  end
end
