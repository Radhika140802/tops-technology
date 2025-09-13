


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
