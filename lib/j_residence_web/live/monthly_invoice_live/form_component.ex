defmodule JResidenceWeb.MonthlyInvoiceLive.FormComponent do
  use JResidenceWeb, :live_component

  alias JResidence.Invoices

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage monthly_invoice records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="monthly_invoice-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:bill_cycle]} type="date" label="Bill cycle" />
        <.input field={@form[:advance_payment]} type="number" label="Advanced payment" step="any" />
        <.input field={@form[:water_start]} type="number" label="Water start" step="any" />
        <.input field={@form[:water_end]} type="number" label="Water end" step="any" />
        <.input field={@form[:water_unit]} type="number" label="Water unit" step="any" />
        <.input field={@form[:electric_start]} type="number" label="Electric start" step="any" />
        <.input field={@form[:electric_end]} type="number" label="Electric end" step="any" />
        <.input field={@form[:other_labels]} type="text" label="Other labels" />
        <.input field={@form[:other_fees]} type="number" label="Other fees" step="any" />
        <.input field={@form[:total]} type="number" label="Total" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Monthly invoice</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{monthly_invoice: monthly_invoice} = assigns, socket) do
    changeset = Invoices.change_monthly_invoice(monthly_invoice)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"monthly_invoice" => monthly_invoice_params}, socket) do
    changeset =
      socket.assigns.monthly_invoice
      |> Invoices.change_monthly_invoice(monthly_invoice_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"monthly_invoice" => monthly_invoice_params}, socket) do
    save_monthly_invoice(socket, socket.assigns.action, monthly_invoice_params)
  end

  defp save_monthly_invoice(socket, :edit, monthly_invoice_params) do
    case Invoices.update_monthly_invoice(socket.assigns.monthly_invoice, monthly_invoice_params) do
      {:ok, monthly_invoice} ->
        notify_parent({:saved, monthly_invoice})

        {:noreply,
         socket
         |> put_flash(:info, "Monthly invoice updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_monthly_invoice(socket, :new, monthly_invoice_params) do
    case Invoices.create_monthly_invoice(monthly_invoice_params) do
      {:ok, monthly_invoice} ->
        notify_parent({:saved, monthly_invoice})

        {:noreply,
         socket
         |> put_flash(:info, "Monthly invoice created successfully")
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
