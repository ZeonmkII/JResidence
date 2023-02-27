defmodule JResidenceWeb.MonthlyBookingLive.FormComponent do
  use JResidenceWeb, :live_component

  alias JResidence.Bookings

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage monthly_booking records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="monthly_booking-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:check_in]} type="date" label="Check in" />
        <.input field={@form[:check_out]} type="date" label="Check out" />
        <.input field={@form[:duration_month]} type="number" label="Duration month" />
        <.input field={@form[:duration_day]} type="number" label="Duration day" />
        <.input field={@form[:remarks]} type="text" label="Remarks" />
        <.input field={@form[:rent_fees]} type="number" label="Rent fees" step="any" />
        <.input field={@form[:service_fees]} type="number" label="Service fees" step="any" />
        <.input field={@form[:deposit]} type="number" label="Deposit" step="any" />
        <.input field={@form[:advance_payment]} type="number" label="Advance payment" step="any" />
        <.input field={@form[:keycard_fees]} type="number" label="Keycard fees" step="any" />
        <.input field={@form[:other_labels]} type="text" label="Other labels" />
        <.input field={@form[:other_fees]} type="number" label="Other fees" step="any" />
        <.input field={@form[:remaining]} type="number" label="Remaining" step="any" />
        <.input field={@form[:total]} type="number" label="Total" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Monthly booking</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{monthly_booking: monthly_booking} = assigns, socket) do
    changeset = Bookings.change_monthly_booking(monthly_booking)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"monthly_booking" => monthly_booking_params}, socket) do
    changeset =
      socket.assigns.monthly_booking
      |> Bookings.change_monthly_booking(monthly_booking_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"monthly_booking" => monthly_booking_params}, socket) do
    save_monthly_booking(socket, socket.assigns.action, monthly_booking_params)
  end

  defp save_monthly_booking(socket, :edit, monthly_booking_params) do
    case Bookings.update_monthly_booking(socket.assigns.monthly_booking, monthly_booking_params) do
      {:ok, monthly_booking} ->
        notify_parent({:saved, monthly_booking})

        {:noreply,
         socket
         |> put_flash(:info, "Monthly booking updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_monthly_booking(socket, :new, monthly_booking_params) do
    case Bookings.create_monthly_booking(monthly_booking_params) do
      {:ok, monthly_booking} ->
        notify_parent({:saved, monthly_booking})

        {:noreply,
         socket
         |> put_flash(:info, "Monthly booking created successfully")
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
