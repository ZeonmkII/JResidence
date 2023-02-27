defmodule JResidenceWeb.MonthlyCustomerLive.FormComponent do
  use JResidenceWeb, :live_component

  alias JResidence.Tenants

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage monthly_customer records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="monthly_customer-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:b_contract]} type="text" label="B contract" />
        <.input field={@form[:b_current]} type="text" label="B current" />
        <.input field={@form[:b_tenant]} type="text" label="B tenant" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Monthly customer</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{monthly_customer: monthly_customer} = assigns, socket) do
    changeset = Tenants.change_monthly_customer(monthly_customer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"monthly_customer" => monthly_customer_params}, socket) do
    changeset =
      socket.assigns.monthly_customer
      |> Tenants.change_monthly_customer(monthly_customer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"monthly_customer" => monthly_customer_params}, socket) do
    save_monthly_customer(socket, socket.assigns.action, monthly_customer_params)
  end

  defp save_monthly_customer(socket, :edit, monthly_customer_params) do
    case Tenants.update_monthly_customer(socket.assigns.monthly_customer, monthly_customer_params) do
      {:ok, monthly_customer} ->
        notify_parent({:saved, monthly_customer})

        {:noreply,
         socket
         |> put_flash(:info, "Monthly customer updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_monthly_customer(socket, :new, monthly_customer_params) do
    case Tenants.create_monthly_customer(monthly_customer_params) do
      {:ok, monthly_customer} ->
        notify_parent({:saved, monthly_customer})

        {:noreply,
         socket
         |> put_flash(:info, "Monthly customer created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
