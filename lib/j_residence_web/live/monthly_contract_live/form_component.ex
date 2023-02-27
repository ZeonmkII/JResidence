defmodule JResidenceWeb.MonthlyContractLive.FormComponent do
  use JResidenceWeb, :live_component

  alias JResidence.Bookings

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage monthly_contract records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="monthly_contract-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:date_signed]} type="date" label="Date signed" />
        <.input field={@form[:check_in]} type="date" label="Check in" />
        <.input field={@form[:check_out]} type="date" label="Check out" />
        <.input field={@form[:duration_month]} type="number" label="Duration month" />
        <.input field={@form[:duration_day]} type="number" label="Duration day" />
        <.input field={@form[:room_number]} type="text" label="Room number" />
        <.input field={@form[:rent_fees]} type="number" label="Rent fees" step="any" />
        <.input field={@form[:service_fees]} type="number" label="Service fees" step="any" />
        <.input field={@form[:deposit]} type="number" label="Deposit" step="any" />
        <.input field={@form[:advance_payment]} type="number" label="Advance payment" step="any" />
        <.input field={@form[:keycard_fees]} type="number" label="Keycard fees" step="any" />
        <.input field={@form[:keycard_number]} type="text" label="Keycard number" />
        <.input field={@form[:other_labels]} type="text" label="Other labels" />
        <.input field={@form[:other_fees]} type="number" label="Other fees" step="any" />
        <.input field={@form[:meter_water]} type="number" label="Meter water" step="any" />
        <.input field={@form[:meter_electric]} type="number" label="Meter electric" step="any" />
        <.input field={@form[:remarks]} type="text" label="Remarks" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Monthly contract</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{monthly_contract: monthly_contract} = assigns, socket) do
    changeset = Bookings.change_monthly_contract(monthly_contract)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"monthly_contract" => monthly_contract_params}, socket) do
    changeset =
      socket.assigns.monthly_contract
      |> Bookings.change_monthly_contract(monthly_contract_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"monthly_contract" => monthly_contract_params}, socket) do
    save_monthly_contract(socket, socket.assigns.action, monthly_contract_params)
  end

  defp save_monthly_contract(socket, :edit, monthly_contract_params) do
    case Bookings.update_monthly_contract(socket.assigns.monthly_contract, monthly_contract_params) do
      {:ok, monthly_contract} ->
        notify_parent({:saved, monthly_contract})

        {:noreply,
         socket
         |> put_flash(:info, "Monthly contract updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_monthly_contract(socket, :new, monthly_contract_params) do
    case Bookings.create_monthly_contract(monthly_contract_params) do
      {:ok, monthly_contract} ->
        notify_parent({:saved, monthly_contract})

        {:noreply,
         socket
         |> put_flash(:info, "Monthly contract created successfully")
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
