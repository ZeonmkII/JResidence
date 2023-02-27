defmodule JResidenceWeb.MonthlyContractFeeLive.FormComponent do
  use JResidenceWeb, :live_component

  alias JResidence.Receipts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage monthly_contract_fee records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="monthly_contract_fee-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:deposit]} type="number" label="Deposit" step="any" />
        <.input field={@form[:advance_payment]} type="number" label="Advance payment" step="any" />
        <.input field={@form[:keycard_fees]} type="number" label="Keycard fees" step="any" />
        <.input field={@form[:other_labels]} type="text" label="Other labels" />
        <.input field={@form[:other_fees]} type="number" label="Other fees" step="any" />
        <.input field={@form[:total]} type="number" label="Total" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Monthly contract fee</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{monthly_contract_fee: monthly_contract_fee} = assigns, socket) do
    changeset = Receipts.change_monthly_contract_fee(monthly_contract_fee)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"monthly_contract_fee" => monthly_contract_fee_params}, socket) do
    changeset =
      socket.assigns.monthly_contract_fee
      |> Receipts.change_monthly_contract_fee(monthly_contract_fee_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"monthly_contract_fee" => monthly_contract_fee_params}, socket) do
    save_monthly_contract_fee(socket, socket.assigns.action, monthly_contract_fee_params)
  end

  defp save_monthly_contract_fee(socket, :edit, monthly_contract_fee_params) do
    case Receipts.update_monthly_contract_fee(socket.assigns.monthly_contract_fee, monthly_contract_fee_params) do
      {:ok, monthly_contract_fee} ->
        notify_parent({:saved, monthly_contract_fee})

        {:noreply,
         socket
         |> put_flash(:info, "Monthly contract fee updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_monthly_contract_fee(socket, :new, monthly_contract_fee_params) do
    case Receipts.create_monthly_contract_fee(monthly_contract_fee_params) do
      {:ok, monthly_contract_fee} ->
        notify_parent({:saved, monthly_contract_fee})

        {:noreply,
         socket
         |> put_flash(:info, "Monthly contract fee created successfully")
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
