defmodule JResidenceWeb.MonthlyBookingFeeLive.FormComponent do
  use JResidenceWeb, :live_component

  alias JResidence.Invoices

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage monthly_booking_fee records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="monthly_booking_fee-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:booking_fees]} type="number" label="Booking fees" step="any" />
        <.input field={@form[:deposit]} type="number" label="Deposit" step="any" />
        <.input field={@form[:room_fees]} type="number" label="Room fees" step="any" />
        <.input field={@form[:other_labels]} type="text" label="Other labels" />
        <.input field={@form[:other_fees]} type="number" label="Other fees" step="any" />
        <.input field={@form[:remaining]} type="number" label="Remaining" step="any" />
        <.input field={@form[:total]} type="number" label="Total" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Monthly booking fee</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{monthly_booking_fee: monthly_booking_fee} = assigns, socket) do
    changeset = Invoices.change_monthly_booking_fee(monthly_booking_fee)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"monthly_booking_fee" => monthly_booking_fee_params}, socket) do
    changeset =
      socket.assigns.monthly_booking_fee
      |> Invoices.change_monthly_booking_fee(monthly_booking_fee_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"monthly_booking_fee" => monthly_booking_fee_params}, socket) do
    save_monthly_booking_fee(socket, socket.assigns.action, monthly_booking_fee_params)
  end

  defp save_monthly_booking_fee(socket, :edit, monthly_booking_fee_params) do
    case Invoices.update_monthly_booking_fee(socket.assigns.monthly_booking_fee, monthly_booking_fee_params) do
      {:ok, monthly_booking_fee} ->
        notify_parent({:saved, monthly_booking_fee})

        {:noreply,
         socket
         |> put_flash(:info, "Monthly booking fee updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_monthly_booking_fee(socket, :new, monthly_booking_fee_params) do
    case Invoices.create_monthly_booking_fee(monthly_booking_fee_params) do
      {:ok, monthly_booking_fee} ->
        notify_parent({:saved, monthly_booking_fee})

        {:noreply,
         socket
         |> put_flash(:info, "Monthly booking fee created successfully")
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
