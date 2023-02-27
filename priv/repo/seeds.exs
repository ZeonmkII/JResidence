# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     JResidence.Repo.insert!(%JResidence.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
total_floors = 7
rooms_per_floor = 13

total_customers = 20
total_bookings = 50

generate_fake_info = true
debug_log = true

alias JResidence.Receipts
alias JResidence.Tenants
alias JResidence.Tenants.Customer
alias JResidence.Bookings
alias JResidence.Invoices
alias JResidence.Facilities.{Building, Floor, Room}
alias JResidence.Repo

# Collapse the module for easier reading
defmodule SeedBookings do
  @moduledoc """
  Provides functions to generate fake customers and Bookings; only to be used in seed.exs
  """

  @doc """
  Generate building, Floors and Rooms
  ## Parameters
    - total_floors: Integer
    - total_floors: Integer
  """
  def generate_facilities(total_floors, rooms_per_floor) do
    # ******************* Generate Buildings ************************
    # ***************************************************************
    building_input = %{
      address: "some address",
      calc_type_electric: "120.5",
      calc_type_water: "120.5",
      name: "some name",
      phone: "some phone",
      tax_id: "some tax_id",
      unit_price_eletric: "120.5",
      unit_price_water: "120.5"
    }

    {:ok, building_result} =
      %Building{}
      |> Building.changeset(building_input)
      |> Repo.insert()

    # ********************* Generate Floors *************************
    # ***************************************************************
    Enum.each(1..total_floors, fn floor ->
      floor_input = %{
        floor_number: Integer.to_string(floor)
      }

      {:ok, floor_result} =
        %Floor{}
        |> Floor.changeset(floor_input)
        |> Ecto.Changeset.put_assoc(:building, building_result)
        |> Repo.insert()

      # ******************** Generate Rooms *************************
      # *************************************************************
      Enum.each(1..rooms_per_floor, fn room ->
        room_prefix = floor * 100

        room_input = %{
          room_number: Integer.to_string(room_prefix + room),
          b_booked: "false",
          b_occupied: "false"
        }

        {:ok, _room_result} =
          %Room{}
          |> Room.changeset(room_input)
          |> Ecto.Changeset.put_assoc(:floor, floor_result)
          |> Repo.insert()
      end)
    end)
  end

  @doc """
  Generate fake Customers
  ## Parameters
    - total_customers: Integer
  """
  def generate_customer(total_customers) do
    Enum.each(1..total_customers, fn _customer ->
      customer_input = %{
        id_number: Faker.UUID.v4(),
        first_name: Faker.Person.first_name(),
        last_name: Faker.Person.last_name(),
        date_of_birth: Date.to_string(Faker.Date.date_of_birth(18..50)),
        religion: Enum.random(["Buddhism", "Christian", "Islam", "Hindu"]),
        nationality: Faker.country(),
        sex: Enum.random(["Male", "Female"]),
        address: Faker.Address.street_address(true),
        issue_by: Faker.Person.name(),
        date_of_issue: Date.to_string(Faker.Date.between(~D[1990-01-01], ~D[2000-01-01])),
        date_of_expiry: Date.to_string(Faker.Date.between(~D[1990-01-01], ~D[2000-01-01])),
        phone: Faker.Phone.EnUs.phone(),
        line: Faker.Team.creature(),
        occupation: Faker.Commerce.department(),
        emergency_contact: Faker.Phone.EnUs.phone()
      }

      {:ok, _customer_result} =
        %Customer{}
        |> Customer.changeset(customer_input)
        |> Repo.insert()
    end)
  end

  @doc """
  Generate fake Bookings.
  Including all possible path:
  Daily/Walkin, Daily/PreBooked, Monthly/Walkin, Monthly/PreBooked
  ## Parameters
    - total_bookings: Integer
  """
  def generate_bookings(total_bookings) do
    Enum.each(1..total_bookings, fn
      _booking ->
        # ------------------------ Common Values ---------------------------
        date_in = Faker.Date.between(~D[2023-01-01], ~D[2023-05-31])
        date_out = Faker.Date.between(~D[2023-06-01], ~D[2023-08-31])
        {:ok, time_in} = Time.new(:rand.uniform(12), :rand.uniform(59), 0, 0)
        rent_fees = Float.to_string(8888 / :rand.uniform(10))
        service_fees = Float.to_string(3333 / :rand.uniform(10))
        deposit = Float.to_string(555 / :rand.uniform(10))
        advance_payment = Float.to_string(444 / :rand.uniform(10))
        keycard_fees = Float.to_string(875 / :rand.uniform(10))

        # ------------------------ Random Booking --------------------------
        booking_type = Enum.random(["Daily", "Monthly"])
        booking_path = Enum.random(["Walkin", "Pre-Booked"])

        # ------------------------ Random Customer -------------------------
        import Ecto.Query

        customer_query = from(Customer, order_by: fragment("RANDOM()"), limit: 1)
        [customer] = Repo.all(customer_query)

        # ------------------------- Random Room ----------------------------

        room_query = from(Room, order_by: fragment("RANDOM()"), limit: 1)
        [room] = Repo.all(room_query)

        # ------------------- Generate Fake Data Structs -------------------

        daily_customer_data = %{
          b_current: "true"
        }

        monthly_customer_data = %{
          b_contract: "true",
          b_current: "true",
          b_tenant: "true"
        }

        daily_booking_data = %{
          check_in: date_in,
          check_out: date_out
        }

        daily_check_in_data = %{
          check_in: date_in,
          check_out: date_out,
          time_in: time_in,
          room_number: room.room_number,
          from: Faker.Commerce.department(),
          to: Faker.Commerce.department()
        }

        monthly_booking_data = %{
          check_in: date_in,
          check_out: date_out,
          rent_fees: rent_fees,
          deposit: deposit,
          advance_payment: advance_payment,
          keycard_fees: keycard_fees,
          service_fees: service_fees
        }

        monthly_contract_data = %{
          date_signed: date_in,
          check_in: date_in,
          check_out: date_out,
          room_number: room.room_number,
          rent_fees: rent_fees,
          deposit: deposit,
          advance_payment: advance_payment,
          keycard_fees: keycard_fees,
          keycard_number: Faker.UUID.v4(),
          meter_water: Float.to_string(223 / :rand.uniform(10)),
          meter_electric: Float.to_string(777 / :rand.uniform(10)),
          service_fees: service_fees
        }

        daily_booking_fee_data = %{
          booking_fees: Float.to_string(400 / :rand.uniform(10)),
          deposit: deposit,
          room_fees: Float.to_string(200 / :rand.uniform(10)),
          total: Float.to_string(200 / :rand.uniform(10) * 5 + 500)
        }

        daily_invoice_data = %{
          deposit: deposit,
          keycard_fee: Float.to_string(200 / :rand.uniform(10)),
          total: Float.to_string(200 / :rand.uniform(10) * 5 + 500)
        }

        monthly_booking_fee_data = %{
          booking_fees: Float.to_string(400 / :rand.uniform(10)),
          deposit: deposit,
          room_fees: Float.to_string(200 / :rand.uniform(10)),
          total: Float.to_string(200 / :rand.uniform(10) * 5 + 500)
        }

        monthly_invoice_data = %{
          bill_cycle: date_in,
          advance_payment: advance_payment,
          water_start: Float.to_string(111 / :rand.uniform(10)),
          water_end: Float.to_string(222 / :rand.uniform(10)),
          water_unit: Float.to_string(334 / :rand.uniform(10)),
          electric_start: Float.to_string(447 / :rand.uniform(10)),
          electric_end: Float.to_string(558 / :rand.uniform(10))
        }

        monthly_contract_fee_data = %{
          deposit: deposit,
          advance_payment: advance_payment,
          keycard_fees: keycard_fees
        }

        cond do
          # -------------------------- Daily + Walk-in -------------------------
          # --                                                                --
          # --------------------------------------------------------------------
          booking_type == "Daily" && booking_path == "Walkin" ->
            {:ok, daily_customer} = Tenants.create_daily_customer(daily_customer_data)
            {:ok, daily_check_in} = Bookings.create_daily_check_in(daily_check_in_data)
            {:ok, daily_invoice} = Invoices.create_daily_invoice(daily_invoice_data)

            Ecto.Changeset.change(daily_customer, customer_id: customer.id)
            |> Repo.update!()

            Ecto.Changeset.change(daily_check_in, %{
              daily_customer_id: daily_customer.id,
              room_id: room.id
            })
            |> Repo.update!()

            Ecto.Changeset.change(daily_invoice, daily_check_in_id: daily_check_in.id)
            |> Repo.update!()

          # ------------------------ Daily + Pre-Booked ------------------------
          # --                                                                --
          # --------------------------------------------------------------------
          booking_type == "Daily" && booking_path == "Pre-Booked" ->
            # อธิบาย Step การทำงานคร่าวๆ
            # 1. สร้าง Record ใน Bookings และออกใบ 'ค่าจอง' (Booking Invoice)
            {:ok, daily_customer} = Tenants.create_daily_customer(daily_customer_data)
            {:ok, daily_booking} = Bookings.create_daily_booking(daily_booking_data)
            {:ok, daily_booking_fee} = Invoices.create_daily_booking_fee(daily_booking_fee_data)

            # ใส่ Foreign Key ของ "เจ้าของ" (parent) แล้วเซฟลง Database
            Ecto.Changeset.change(daily_customer, customer_id: customer.id)
            |> Repo.update!()

            Ecto.Changeset.change(daily_booking, %{
              daily_customer_id: daily_customer.id,
              room_id: room.id
            })
            |> Repo.update!()

            Ecto.Changeset.change(daily_booking_fee, daily_booking_id: daily_booking.id)
            |> Repo.update!()

            # 2. สร้าง Record ใน Check-in และออกใบ 'ค่าห้องพักรายวัน' (Daily Invoice)
            #    จริงๆตรงนี้ คือควรจะดึงค่า Booking นั้นๆออกมาจาก DB แล้วค่อยเอามาใส่
            #    แต่เราใช้ Faker อยู่ดี เลยดึง struct 'daily_check_in_data' ที่ gen ไว้แล้วมาใช้ตรงๆ
            {:ok, daily_check_in} = Bookings.create_daily_check_in(daily_check_in_data)
            {:ok, daily_invoice} = Invoices.create_daily_invoice(daily_invoice_data)

            # ใส่ Foreign Key และเซฟลง DB
            Ecto.Changeset.change(daily_check_in, %{
              daily_customer_id: daily_customer.id,
              daily_booking_id: daily_booking.id,
              room_id: room.id
            })
            |> Repo.update!()

            Ecto.Changeset.change(daily_invoice, daily_check_in_id: daily_check_in.id)
            |> Repo.update!()

          # ------------------------- Monthly + Walk-in ------------------------
          # --                                                                --
          # --------------------------------------------------------------------
          booking_type == "Monthly" && booking_path == "Walkin" ->
            {:ok, monthly_customer} = Tenants.create_monthly_customer(monthly_customer_data)
            {:ok, monthly_contract} = Bookings.create_monthly_contract(monthly_contract_data)
            {:ok, monthly_invoice} = Invoices.create_monthly_invoice(monthly_invoice_data)

            {:ok, monthly_contract_fee} =
              Receipts.create_monthly_contract_fee(monthly_contract_fee_data)

            Ecto.Changeset.change(monthly_customer, customer_id: customer.id)
            |> Repo.update!()

            Ecto.Changeset.change(monthly_contract, %{
              monthly_customer_id: monthly_customer.id,
              room_id: room.id
            })
            |> Repo.update!()

            Ecto.Changeset.change(monthly_invoice, monthly_contract_id: monthly_contract.id)
            |> Repo.update!()

            Ecto.Changeset.change(monthly_contract_fee, monthly_contract_id: monthly_contract.id)
            |> Repo.update!()

          # ----------------------- Monthly + Pre-Booked -----------------------
          # --                                                                --
          # --------------------------------------------------------------------
          booking_type == "Monthly" && booking_path == "Pre-Booked" ->
            {:ok, monthly_customer} = Tenants.create_monthly_customer(monthly_customer_data)
            {:ok, monthly_booking} = Bookings.create_monthly_booking(monthly_booking_data)

            {:ok, monthly_booking_fee} =
              Invoices.create_monthly_booking_fee(monthly_booking_fee_data)

            Ecto.Changeset.change(monthly_customer, customer_id: customer.id)
            |> Repo.update!()

            Ecto.Changeset.change(monthly_booking, %{
              monthly_customer_id: monthly_customer.id,
              room_id: room.id
            })
            |> Repo.update!()

            Ecto.Changeset.change(monthly_booking_fee, monthly_booking_id: monthly_booking.id)
            |> Repo.update!()

            {:ok, monthly_contract} = Bookings.create_monthly_contract(monthly_contract_data)
            {:ok, monthly_invoice} = Invoices.create_monthly_invoice(monthly_invoice_data)

            Ecto.Changeset.change(monthly_contract, %{
              monthly_customer_id: monthly_customer.id,
              monthly_booking_id: monthly_booking.id,
              room_id: room.id
            })
            |> Repo.update!()

            Ecto.Changeset.change(monthly_invoice, monthly_contract_id: monthly_contract.id)
            |> Repo.update!()

            {:ok, monthly_contract_fee} =
              Receipts.create_monthly_contract_fee(monthly_contract_fee_data)

            Ecto.Changeset.change(monthly_contract_fee, monthly_contract_id: monthly_contract.id)
            |> Repo.update!()
        end
    end)
  end
end

# [1] Generate the Building/Floors/Rooms (required)
SeedBookings.generate_facilities(total_floors, rooms_per_floor)

if debug_log do
  IO.puts(">>> SEED >>> #{total_floors} Floors, #{total_floors * rooms_per_floor} Rooms created!")
end

# [2] If 'generate_fake_info' flag is ON
if generate_fake_info do
  # [2.1] generate (fake) Customers
  SeedBookings.generate_customer(total_customers)

  if debug_log do
    IO.puts(">>> SEED >>> #{total_customers} Customers created!")
  end

  # [2.2] generate (fake) Bookings
  SeedBookings.generate_bookings(total_bookings)

  if debug_log do
    IO.puts(">>> SEED >>> #{total_bookings} Bookings created!")
  end
end
