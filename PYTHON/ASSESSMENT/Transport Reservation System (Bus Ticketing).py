class BusReservation:
    def __init__(self):
        self.routes = {
            "Mumbai to Pune": 500,
            "Delhi to Jaipur": 600,
            "Chennai to Bangalore": 550,
            "Hyderabad to Goa": 700
        }
        self.tickets = {}  # Key: ticket_id, Value: ticket_info dict
        self.route_seats = {route: [] for route in self.routes}  # Track seat assignments
        self.next_ticket_id = 1001  # Unique ticket ID counter

    def show_routes(self):
        print("\n--- Available Bus Routes ---")
        for route, price in self.routes.items():
            print(f"{route} - ₹{price}")

    def book_ticket(self):
        name = input("Enter passenger name: ")
        try:
            age = int(input("Enter age: "))
        except ValueError:
            print("Invalid age.")
            return

        mobile = input("Enter 10-digit mobile number: ")
        if not mobile.isdigit() or len(mobile) != 10:
            print("Invalid mobile number.")
            return

        self.show_routes()
        route = input("Enter route exactly as shown above: ")
        if route not in self.routes:
            print("Invalid route selected.")
            return

        if len(self.route_seats[route]) >= 40:
            print("Sorry, all seats are booked for this route.")
            return

        seat_number = len(self.route_seats[route]) + 1
        ticket_id = self.next_ticket_id
        self.next_ticket_id += 1

        ticket_info = {
            'name': name,
            'age': age,
            'mobile': mobile,
            'route': route,
            'seat_number': seat_number,
            'price': self.routes[route]
        }

        self.tickets[ticket_id] = ticket_info
        self.route_seats[route].append(seat_number)

        print(f"Ticket booked successfully! Your Ticket ID is {ticket_id}, Seat No: {seat_number}")

    def view_ticket(self):
        try:
            ticket_id = int(input("Enter Ticket ID: "))
        except ValueError:
            print("Invalid Ticket ID.")
            return

        ticket = self.tickets.get(ticket_id)
        if ticket:
            print("\n--- Ticket Details ---")
            print(f"Ticket ID: {ticket_id}")
            print(f"Passenger Name: {ticket['name']}")
            print(f"Age: {ticket['age']}")
            print(f"Mobile: {ticket['mobile']}")
            print(f"Route: {ticket['route']}")
            print(f"Seat Number: {ticket['seat_number']}")
            print(f"Price: ₹{ticket['price']}")
        else:
            print("Ticket not found.")

    def cancel_ticket(self):
        try:
            ticket_id = int(input("Enter Ticket ID to cancel: "))
        except ValueError:
            print("Invalid Ticket ID.")
            return

        ticket = self.tickets.pop(ticket_id, None)
        if ticket:
            route = ticket['route']
            seat_number = ticket['seat_number']
            self.route_seats[route].remove(seat_number)
            print("Ticket cancelled successfully.")
        else:
            print("Ticket not found.")

    def run(self):
        while True:
            print("\n--- Bus Ticket Reservation System ---")
            print("1. Show Available Routes")
            print("2. Book Ticket")
            print("3. View Ticket")
            print("4. Cancel Ticket")
            print("5. Exit")

            choice = input("Enter your choice: ")
            if choice == '1':
                self.show_routes()
            elif choice == '2':
                self.book_ticket()
            elif choice == '3':
                self.view_ticket()
            elif choice == '4':
                self.cancel_ticket()
            elif choice == '5':
                print("Exiting system.")
                break
            else:
                print("Invalid choice. Please try again.")
if __name__ == "__main__":
    system = BusReservation()
    system.run()
 


 