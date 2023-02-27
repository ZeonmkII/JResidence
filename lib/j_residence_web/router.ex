defmodule JResidenceWeb.Router do
  use JResidenceWeb, :router

  import JResidenceWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {JResidenceWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JResidenceWeb do
    pipe_through :browser

    get "/", PageController, :home

    # ================================== Tenants ==================================
    # Customer
    live "/customers", CustomerLive.Index, :index
    live "/customers/new", CustomerLive.Index, :new
    live "/customers/:id/edit", CustomerLive.Index, :edit

    live "/customers/:id", CustomerLive.Show, :show
    live "/customers/:id/show/edit", CustomerLive.Show, :edit

    # Daily Customer
    live "/daily_customers", DailyCustomerLive.Index, :index
    live "/daily_customers/new", DailyCustomerLive.Index, :new
    live "/daily_customers/:id/edit", DailyCustomerLive.Index, :edit

    live "/daily_customers/:id", DailyCustomerLive.Show, :show
    live "/daily_customers/:id/show/edit", DailyCustomerLive.Show, :edit

    # Monthly Customer
    live "/monthly_customers", MonthlyCustomerLive.Index, :index
    live "/monthly_customers/new", MonthlyCustomerLive.Index, :new
    live "/monthly_customers/:id/edit", MonthlyCustomerLive.Index, :edit

    live "/monthly_customers/:id", MonthlyCustomerLive.Show, :show
    live "/monthly_customers/:id/show/edit", MonthlyCustomerLive.Show, :edit

    # ================================= Facilities ================================
    # Building
    live "/buildings", BuildingLive.Index, :index
    live "/buildings/new", BuildingLive.Index, :new
    live "/buildings/:id/edit", BuildingLive.Index, :edit

    live "/buildings/:id", BuildingLive.Show, :show
    live "/buildings/:id/show/edit", BuildingLive.Show, :edit

    # Floor
    live "/floors", FloorLive.Index, :index
    live "/floors/new", FloorLive.Index, :new
    live "/floors/:id/edit", FloorLive.Index, :edit

    live "/floors/:id", FloorLive.Show, :show
    live "/floors/:id/show/edit", FloorLive.Show, :edit

    # Room
    live "/rooms", RoomLive.Index, :index
    live "/rooms/new", RoomLive.Index, :new
    live "/rooms/:id/edit", RoomLive.Index, :edit

    live "/rooms/:id", RoomLive.Show, :show
    live "/rooms/:id/show/edit", RoomLive.Show, :edit

    # ================================== Booking ==================================
    # Daily Booking
    live "/daily_bookings", DailyBookingLive.Index, :index
    live "/daily_bookings/new", DailyBookingLive.Index, :new
    live "/daily_bookings/:id/edit", DailyBookingLive.Index, :edit

    live "/daily_bookings/:id", DailyBookingLive.Show, :show
    live "/daily_bookings/:id/show/edit", DailyBookingLive.Show, :edit

    # Daily Check-In
    live "/daily_check_ins", DailyCheckInLive.Index, :index
    live "/daily_check_ins/new", DailyCheckInLive.Index, :new
    live "/daily_check_ins/:id/edit", DailyCheckInLive.Index, :edit

    live "/daily_check_ins/:id", DailyCheckInLive.Show, :show
    live "/daily_check_ins/:id/show/edit", DailyCheckInLive.Show, :edit

    # Monthly Booking
    live "/monthly_bookings", MonthlyBookingLive.Index, :index
    live "/monthly_bookings/new", MonthlyBookingLive.Index, :new
    live "/monthly_bookings/:id/edit", MonthlyBookingLive.Index, :edit

    live "/monthly_bookings/:id", MonthlyBookingLive.Show, :show
    live "/monthly_bookings/:id/show/edit", MonthlyBookingLive.Show, :edit

    # Monthly Contract
    live "/monthly_contracts", MonthlyContractLive.Index, :index
    live "/monthly_contracts/new", MonthlyContractLive.Index, :new
    live "/monthly_contracts/:id/edit", MonthlyContractLive.Index, :edit

    live "/monthly_contracts/:id", MonthlyContractLive.Show, :show
    live "/monthly_contracts/:id/show/edit", MonthlyContractLive.Show, :edit

    # ================================== Invoice ==================================
    # Daily Booking Fee
    live "/daily_booking_fees", DailyBookingFeeLive.Index, :index
    live "/daily_booking_fees/new", DailyBookingFeeLive.Index, :new
    live "/daily_booking_fees/:id/edit", DailyBookingFeeLive.Index, :edit

    live "/daily_booking_fees/:id", DailyBookingFeeLive.Show, :show
    live "/daily_booking_fees/:id/show/edit", DailyBookingFeeLive.Show, :edit

    # Daily Invoice
    live "/daily_invoices", DailyInvoiceLive.Index, :index
    live "/daily_invoices/new", DailyInvoiceLive.Index, :new
    live "/daily_invoices/:id/edit", DailyInvoiceLive.Index, :edit

    live "/daily_invoices/:id", DailyInvoiceLive.Show, :show
    live "/daily_invoices/:id/show/edit", DailyInvoiceLive.Show, :edit

    # Monthly Booking Fee
    live "/monthly_booking_fees", MonthlyBookingFeeLive.Index, :index
    live "/monthly_booking_fees/new", MonthlyBookingFeeLive.Index, :new
    live "/monthly_booking_fees/:id/edit", MonthlyBookingFeeLive.Index, :edit

    live "/monthly_booking_fees/:id", MonthlyBookingFeeLive.Show, :show
    live "/monthly_booking_fees/:id/show/edit", MonthlyBookingFeeLive.Show, :edit

    # Monthly Invoice
    live "/monthly_invoices", MonthlyInvoiceLive.Index, :index
    live "/monthly_invoices/new", MonthlyInvoiceLive.Index, :new
    live "/monthly_invoices/:id/edit", MonthlyInvoiceLive.Index, :edit

    live "/monthly_invoices/:id", MonthlyInvoiceLive.Show, :show
    live "/monthly_invoices/:id/show/edit", MonthlyInvoiceLive.Show, :edit

    # ================================== Receipt ==================================
  end

  # Other scopes may use custom stacks.
  # scope "/api", JResidenceWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:j_residence, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: JResidenceWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", JResidenceWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{JResidenceWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", JResidenceWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{JResidenceWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", JResidenceWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{JResidenceWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
