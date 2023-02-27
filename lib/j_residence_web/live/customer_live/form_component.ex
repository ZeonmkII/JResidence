defmodule JResidenceWeb.CustomerLive.FormComponent do
  use JResidenceWeb, :live_component

  alias JResidence.Tenants

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage customer records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="customer-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:id_number]} type="text" label="Id number" />
        <.input field={@form[:first_name]} type="text" label="First name" />
        <.input field={@form[:first_name_alt]} type="text" label="First name alt" />
        <.input field={@form[:last_name]} type="text" label="Last name" />
        <.input field={@form[:last_name_alt]} type="text" label="Last name alt" />
        <.input field={@form[:date_of_birth]} type="text" label="Date of birth" />
        <.input field={@form[:religion]} type="text" label="Religion" />
        <.input field={@form[:nationality]} type="text" label="Nationality" />
        <.input field={@form[:sex]} type="text" label="Sex" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:issue_by]} type="text" label="Issue by" />
        <.input field={@form[:date_of_issue]} type="text" label="Date of issue" />
        <.input field={@form[:date_of_expiry]} type="text" label="Date of expiry" />
        <.input field={@form[:photo]} type="text" label="Photo" />
        <.input field={@form[:phone]} type="text" label="Phone" />
        <.input field={@form[:line]} type="text" label="Line" />
        <.input field={@form[:occupation]} type="text" label="Occupation" />
        <.input field={@form[:emergency_contact]} type="text" label="Emergency contact" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Customer</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{customer: customer} = assigns, socket) do
    changeset = Tenants.change_customer(customer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"customer" => customer_params}, socket) do
    changeset =
      socket.assigns.customer
      |> Tenants.change_customer(customer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"customer" => customer_params}, socket) do
    save_customer(socket, socket.assigns.action, customer_params)
  end

  defp save_customer(socket, :edit, customer_params) do
    case Tenants.update_customer(socket.assigns.customer, customer_params) do
      {:ok, customer} ->
        notify_parent({:saved, customer})

        {:noreply,
         socket
         |> put_flash(:info, "Customer updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_customer(socket, :new, customer_params) do
    case Tenants.create_customer(customer_params) do
      {:ok, customer} ->
        notify_parent({:saved, customer})

        {:noreply,
         socket
         |> put_flash(:info, "Customer created successfully")
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
