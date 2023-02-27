defmodule JResidenceWeb.DailyCustomerLive.FormComponent do
  use JResidenceWeb, :live_component

  alias JResidence.Tenants

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage daily_customer records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="daily_customer-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:b_current]} type="text" label="B current" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Daily customer</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{daily_customer: daily_customer} = assigns, socket) do
    changeset = Tenants.change_daily_customer(daily_customer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"daily_customer" => daily_customer_params}, socket) do
    changeset =
      socket.assigns.daily_customer
      |> Tenants.change_daily_customer(daily_customer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"daily_customer" => daily_customer_params}, socket) do
    save_daily_customer(socket, socket.assigns.action, daily_customer_params)
  end

  defp save_daily_customer(socket, :edit, daily_customer_params) do
    case Tenants.update_daily_customer(socket.assigns.daily_customer, daily_customer_params) do
      {:ok, daily_customer} ->
        notify_parent({:saved, daily_customer})

        {:noreply,
         socket
         |> put_flash(:info, "Daily customer updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_daily_customer(socket, :new, daily_customer_params) do
    case Tenants.create_daily_customer(daily_customer_params) do
      {:ok, daily_customer} ->
        notify_parent({:saved, daily_customer})

        {:noreply,
         socket
         |> put_flash(:info, "Daily customer created successfully")
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
