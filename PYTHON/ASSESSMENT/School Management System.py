class SchoolManagement:
    def __init__(self):
        self.students = {}  # Key: student ID, Value: student info dict
        self.next_student_id = 1001  # Starting point for student IDs

    def _generate_student_id(self):
        student_id = self.next_student_id
        self.next_student_id += 1
        return student_id

    def new_admission(self):
        name = input("Enter student name: ")
        try:
            age = int(input("Enter age (5-18): "))
            if age < 5 or age > 18:
                print("Invalid age. Must be between 5 and 18.")
                return
        except ValueError:
            print("Invalid input for age.")
            return

        try:
            student_class = int(input("Enter class (1-12): "))
            if student_class < 1 or student_class > 12:
                print("Invalid class. Must be between 1 and 12.")
                return
        except ValueError:
            print("Invalid input for class.")
            return

        mobile = input("Enter guardian's 10-digit mobile number: ")
        if not mobile.isdigit() or len(mobile) != 10:
            print("Invalid mobile number. Must be exactly 10 digits.")
            return

        student_id = self._generate_student_id()
        self.students[student_id] = {
            'name': name,
            'age': age,
            'class': student_class,
            'mobile': mobile
        }

        print(f"Admission successful. Student ID: {student_id}")

    def view_student(self):
        try:
            student_id = int(input("Enter student ID to view: "))
            student = self.students.get(student_id)
            if student:
                print("\n--- Student Details ---")
                print(f"Student ID: {student_id}")
                print(f"Name: {student['name']}")
                print(f"Age: {student['age']}")
                print(f"Class: {student['class']}")
                print(f"Guardian Mobile: {student['mobile']}")
            else:
                print("Student not found.")
        except ValueError:
            print("Invalid student ID.")

    def update_student(self):
        try:
            student_id = int(input("Enter student ID to update: "))
            if student_id not in self.students:
                print("Student not found.")
                return

            print("What would you like to update?")
            print("1. Mobile Number")
            print("2. Class")
            choice = input("Enter choice (1/2): ")

            if choice == '1':
                new_mobile = input("Enter new 10-digit mobile number: ")
                if not new_mobile.isdigit() or len(new_mobile) != 10:
                    print("Invalid mobile number.")
                    return
                self.students[student_id]['mobile'] = new_mobile
                print("Mobile number updated successfully.")
            elif choice == '2':
                try:
                    new_class = int(input("Enter new class (1-12): "))
                    if new_class < 1 or new_class > 12:
                        print("Invalid class.")
                        return
                    self.students[student_id]['class'] = new_class
                    print("Class updated successfully.")
                except ValueError:
                    print("Invalid input for class.")
            else:
                print("Invalid choice.")
        except ValueError:
            print("Invalid student ID.")

    def remove_student(self):
        try:
            student_id = int(input("Enter student ID to remove: "))
            if student_id in self.students:
                del self.students[student_id]
                print("Student record removed.")
            else:
                print("Student not found.")
        except ValueError:
            print("Invalid student ID.")

    def run(self):
        while True:
            print("\n--- School Management System ---")
            print("1. New Admission")
            print("2. View Student Details")
            print("3. Update Student Info")
            print("4. Remove Student Record")
            print("5. Exit System")

            choice = input("Enter your choice: ")

            if choice == '1':
                self.new_admission()
            elif choice == '2':
                self.view_student()
            elif choice == '3':
                self.update_student()
            elif choice == '4':
                self.remove_student()
            elif choice == '5':
                print("Exiting system.")
                break
            else:
                print("Invalid choice. Please try again.")

if __name__ == "__main__":
    system = SchoolManagement()
    system.run()
