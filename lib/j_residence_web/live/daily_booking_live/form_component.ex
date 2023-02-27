defmodule JResidenceWeb.DailyBookingLive.FormComponent do
  use JResidenceWeb, :live_component

  alias JResidence.Bookings

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage daily_booking records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="daily_booking-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:check_in]} type="date" label="Check in" />
        <.input field={@form[:check_out]} type="date" label="Check out" />
        <.input field={@form[:duration_day]} type="number" label="Duration day" />
        <.input field={@form[:remarks]} type="text" label="Remarks" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Daily booking</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{daily_booking: daily_booking} = assigns, socket) do
    changeset = Bookings.change_daily_booking(daily_booking)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"daily_booking" => daily_booking_params}, socket) do
    changeset =
      socket.assigns.daily_booking
      |> Bookings.change_daily_booking(daily_booking_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"daily_booking" => daily_booking_params}, socket) do
    save_daily_booking(socket, socket.assigns.action, daily_booking_params)
  end

  defp save_daily_booking(socket, :edit, daily_booking_params) do
    case Bookings.update_daily_booking(socket.assigns.daily_booking, daily_booking_params) do
      {:ok, daily_booking} ->
        notify_parent({:saved, daily_booking})

        {:noreply,
         socket
         |> put_flash(:info, "Daily booking updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_daily_booking(socket, :new, daily_booking_params) do
    case Bookings.create_daily_booking(daily_booking_params) do
      {:ok, daily_booking} ->
        notify_parent({:saved, daily_booking})

        {:noreply,
         socket
         |> put_flash(:info, "Daily booking created successfully")
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
