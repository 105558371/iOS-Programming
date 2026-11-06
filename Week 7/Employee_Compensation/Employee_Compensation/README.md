# Lab 7 - Assignment 2 - Employee Compensation Management System
**Course:** iOS Programming Fundamentals with Swift  
**Lecturer:** Truong Thi Ngoc Phuong  

---

## 📸 App Screenshots & Validation Evidence

### 1. Main Directory & Benefits View
![Main Screen](screenshots/main_screen.png)

### 2. Profile Details & Calculation Breakdown
![Detail Screen](screenshots/detail_screen.png)

### 3. Rejection Test Evidence (Validation Guard Active)
![Rejected Operation](screenshots/rejected_operation.png)

---

## 🛠 Project Structure
- `EnumsAndErrors.swift` - Domain enums (`EmploymentStatus`) & custom validation errors (`PayrollError`)
- `EmployeeModels.swift` - Core class model hierarchy (`Employee` base class, `FullTimeEmployee`, `PartTimeEmployee`, `ContractEmployee`) with encapsulation, inheritance, & polymorphism
- `PayrollViewModel.swift` - ObservableObject managing app state, employee directory, & automated validation test suites
- `Views.swift` - SwiftUI user interface components (`ContentView` & `EmployeeDetailView`)
