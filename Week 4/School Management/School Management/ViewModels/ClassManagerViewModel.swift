import Foundation
import Combine

class ClassManagerViewModel: ObservableObject {
    @Published var students: [Student] = [
        Student(id: "SESEIU24007", name: "Trần Phương Hà", className: "PHSE24IU41", dateOfBirth: "05/04/2006"),
        Student(id: "SESEIU24002", name: "Phạm Công Anh", className: "PHSE24IU01", dateOfBirth: "19/08/2006"),
        Student(id: "SESEIU24001", name: "Võ Châu Anh", className: "PHSE24IU41", dateOfBirth: "06/11/2006")
    ]
    
    @Published var subjects: [Subject] = [
        Subject(id: "PH062IU", name: "iOS Programming Fundamentals", credits: 3),
        Subject(id: "PH065IU", name: "Geolocation App Development for iOS", credits: 3),
        Subject(id: "PH074IU", name: "Project 4", credits: 1)
    ]
    
    @Published var teachers: [Teacher] = [
        Teacher(id: "PH012", name: "Trương Thị Ngọc Phượng", subjectsCanTeach: [
            Subject(id: "PH062IU", name: "iOS Programming Fundamentals", credits: 3),
            Subject(id: "PH065IU", name: "Geolocation App Development for iOS", credits: 3)
        ])
    ]
    
    @Published var studentSubjects: [StudentSubject] = [
        StudentSubject(idStudent: "SESEIU24007", idSubject: "PH062IU", grade: 8.5),
        StudentSubject(idStudent: "SESEIU24007", idSubject: "PH065IU", grade: 7.8),
        StudentSubject(idStudent: "SESEIU24002", idSubject: "PH062IU", grade: 4.2),
        StudentSubject(idStudent: "SESEIU24001", idSubject: "PH065IU", grade: 9.2)
    ]
    
    // Add student
    func addStudent(id: String, name: String, className: String, dob: String) {
        guard !id.isEmpty, !name.isEmpty else { return }
        let newStudent = Student(id: id, name: name, className: className, dateOfBirth: dob)
        students.append(newStudent)
    }
    
    // Add subject
    func addSubject(id: String, name: String, credits: Int) {
        guard !id.isEmpty, !name.isEmpty else { return }
        let newSubject = Subject(id: id, name: name, credits: credits)
        subjects.append(newSubject)
    }
    
    // Assign/Add a subject that the student must take in the semester
    func assignSubject(idStudent: String, idSubject: String, grade: Double = 0.0) {
        if !studentSubjects.contains(where: { $0.idStudent == idStudent && $0.idSubject == idSubject }) {
            let record = StudentSubject(idStudent: idStudent, idSubject: idSubject, grade: grade)
            studentSubjects.append(record)
        }
    }
    
    // Update grade/mark for a student's subject
    func updateGrade(idStudent: String, idSubject: String, newGrade: Double) {
        if let index = studentSubjects.firstIndex(where: { $0.idStudent == idStudent && $0.idSubject == idSubject }) {
            studentSubjects[index].grade = newGrade
        }
    }
    
    // Statistic A: Students whose GPA > 8.0
    func getStudentsWithGPA(above threshold: Double) -> [(student: Student, gpa: Double)] {
        var results: [(Student, Double)] = []
        for student in students {
            let enrollments = studentSubjects.filter { $0.idStudent == student.id }
            guard !enrollments.isEmpty else { continue }
            let totalScore = enrollments.reduce(0.0) { $0 + $1.grade }
            let gpa = totalScore / Double(enrollments.count)
            if gpa > threshold {
                results.append((student, gpa))
            }
        }
        return results
    }
    
    // Statistic B: List of students failed in each subject (< 5.0)
    func getFailedStudentsBySubject() -> [Subject: [Student]] {
        var dict: [Subject: [Student]] = [:]
        for subject in subjects {
            let failedRecords = studentSubjects.filter { $0.idSubject == subject.id && $0.isFailed }
            let failedStudents = failedRecords.compactMap { rec in
                students.first(where: { $0.id == rec.idStudent })
            }
            dict[subject] = failedStudents
        }
        return dict
    }
}
