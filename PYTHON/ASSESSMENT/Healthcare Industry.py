class ClinicAppointment:
    def __init__(self):
        self.slots = ["10am", "11am", "12pm", "2pm", "3pm"]
        self.appointments = {}
    
    def add_doctor(self, doctor_name):
        if doctor_name not in self.appointments:
            self.appointments[doctor_name] = {slot: [] for slot in self.slots}
    
    def book_appointment(self, name, age, mobile, doctor, slot):
        if doctor not in self.appointments:
            return f" Doctor {doctor} not available."

        if slot not in self.appointments[doctor]:
            return f" Invalid slot {slot}. Choose from {self.slots}"

        if len(self.appointments[doctor][slot]) >= 3:
            return f" Slot {slot} with Dr.{doctor} is full."

        for s in self.slots:
            for appt in self.appointments[doctor][s]:
                if appt['mobile'] == mobile:
                    return f" You already have an appointment with Dr.{doctor}."

        self.appointments[doctor][slot].append({
            "name": name,
            "age": age,
            "mobile": mobile
        })
        return f" Appointment confirmed with Dr.{doctor} at {slot}."
    
    def view_appointment(self, mobile):
        for doctor, slots in self.appointments.items():
            for slot, patients in slots.items():
                for appt in patients:
                    if appt["mobile"] == mobile:
                        return f"📋 Appointment: {appt['name']} (Age {appt['age']}) with Dr.{doctor} at {slot}"
        return " No appointment found with this mobile number."

    def cancel_appointment(self, mobile):
        for doctor, slots in self.appointments.items():
            for slot, patients in slots.items():
                for appt in patients:
                    if appt["mobile"] == mobile:
                        self.appointments[doctor][slot].remove(appt)
                        return f"🗑️ Appointment with Dr.{doctor} at {slot} cancelled."
        return " No appointment found to cancel."

    def show_doctor_availability(self, doctor):
        if doctor not in self.appointments:
            return f" Doctor {doctor} not available."

        availability = {}
        for slot, patients in self.appointments[doctor].items():
            availability[slot] = 3 - len(patients)
        
        return availability



clinic = ClinicAppointment()

# Add some doctors
clinic.add_doctor("Sharma")
clinic.add_doctor("Patel")

while True:
    print("\n===== Clinic Appointment System =====")
    print("1. Book Appointment")
    print("2. View Appointment")
    print("3. Cancel Appointment")
    print("4. Doctor Availability")
    print("5. Exit")
    
    choice = input("Enter choice: ")

    if choice == "1":
        name = input("Enter patient name: ")
        age = int(input("Enter patient age: "))
        mobile = input("Enter mobile number: ")
        doctor = input("Enter preferred doctor (Sharma/Patel): ")
        print("Available Slots:", clinic.slots)
        slot = input("Choose a slot: ")
        print(clinic.book_appointment(name, age, mobile, doctor, slot))

    elif choice == "2":
        mobile = input("Enter your mobile number: ")
        print(clinic.view_appointment(mobile))

    elif choice == "3":
        mobile = input("Enter your mobile number: ")
        print(clinic.cancel_appointment(mobile))

    elif choice == "4":
        doctor = input("Enter doctor name (Sharma/Patel): ")
        print("Availability:", clinic.show_doctor_availability(doctor))

    elif choice == "5":
        print("👋 Exiting system. Goodbye!")
        break

    else:
        print("❌ Invalid choice. Please try again.")
