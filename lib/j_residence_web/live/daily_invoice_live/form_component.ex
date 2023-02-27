defmodule JResidenceWeb.DailyInvoiceLive.FormComponent do
  use JResidenceWeb, :live_component

  alias JResidence.Invoices

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage daily_invoice records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="daily_invoice-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:deposit]} type="number" label="Deposit" step="any" />
        <.input field={@form[:keycard_fees]} type="number" label="Keycard fees" step="any" />
        <.input field={@form[:other_labels]} type="text" label="Other labels" />
        <.input field={@form[:other_fees]} type="number" label="Other fees" step="any" />
        <.input field={@form[:remaining]} type="number" label="Remaining" step="any" />
        <.input field={@form[:total]} type="number" label="Total" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Daily invoice</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{daily_invoice: daily_invoice} = assigns, socket) do
    changeset = Invoices.change_daily_invoice(daily_invoice)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"daily_invoice" => daily_invoice_params}, socket) do
    changeset =
      socket.assigns.daily_invoice
      |> Invoices.change_daily_invoice(daily_invoice_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"daily_invoice" => daily_invoice_params}, socket) do
    save_daily_invoice(socket, socket.assigns.action, daily_invoice_params)
  end

  defp save_daily_invoice(socket, :edit, daily_invoice_params) do
    case Invoices.update_daily_invoice(socket.assigns.daily_invoice, daily_invoice_params) do
      {:ok, daily_invoice} ->
        notify_parent({:saved, daily_invoice})

        {:noreply,
         socket
         |> put_flash(:info, "Daily invoice updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_daily_invoice(socket, :new, daily_invoice_params) do
    case Invoices.create_daily_invoice(daily_invoice_params) do
      {:ok, daily_invoice} ->
        notify_parent({:saved, daily_invoice})

        {:noreply,
         socket
         |> put_flash(:info, "Daily invoice created successfully")
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
