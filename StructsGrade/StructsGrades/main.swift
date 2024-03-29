//
//  main.swift
//  StructsGrades
//
//  Created by StudentAM on 2/7/24.
//

import Foundation
import CSV

//create variables and datatype to read and store CSV file
struct Students{
    var name: String
    var grades: [String]
    var averageGrades: Double
}

//variable to store Students struct in every element in the array
var studentData : [Students] = []

do{
    //input stream to get data from the grades.csv file
    let stream = InputStream(fileAtPath: "/Users/studentam/Desktop/grades.csv")
    
    //creating a variable to grab the data from stream variable
    let csv = try CSVReader(stream: stream!)
    
    //as long as there is a row, the while loop will grab the data from the stream
    while let row = csv.next(){
        //add row to manageData to separate the data
        manageData(row)
    }
}
catch{
    print("There was an error trying to read the file!")
}

func manageData( _ data: [String]){
    //create variables to store different data
    let fullName = data[0]
    var grades: [String] = []
    var averageGrades: Double = 0.0
    var numOfAssignment: Double = 0.0
    var totalGrades: Double = 0.0
    
    //use for-in loop to grab all the grades and append it to the grades array
    for gradeIndex in data.indices{
        //skip the name
        if gradeIndex > 0{
            grades.append(data[gradeIndex])
            numOfAssignment += 1.0
        }
    }
    //grab the grades in the grades array
    for grade in grades{
        //convert grade from string to double to calculate average
        if let gradeValue = Double(grade){
            totalGrades += gradeValue
        }
    }
    let average = totalGrades/numOfAssignment
    
    //add average grades to the variable
    averageGrades += average
    
    //create a variable to store all the student's data and add it to struct
    let tempStudent: Students = Students(name: fullName, grades: grades, averageGrades: averageGrades)
    
    //append all the student's data for each student
    studentData.append(tempStudent)
}

//create variable
var disMenu : Bool = true
var numOfStudent : Double = 0.0
var allGrades : Double = 0.0
var average : Double = 0.0

while disMenu{
    print("Welcome to the Grade Manager! \n"
        + "What would you like to do? (Enter the number): \n"
        + "1. Display grade of a single student \n"
        + "2. Display all grades for a student \n"
        + "3. Display all grades for ALL students \n"
        + "4. Find the average grade of the class \n"
        + "5. Find the average grade of an assignment \n"
        + "6. Find the lowest grade in the class \n"
        + "7. Find the highest grade of the class \n"
        + "8. Filter students by grade range \n"
        + "9. Change grade of specific assignment \n"
        + "10. Quit")
    
    if let userInput = readLine(){
        switch userInput{
        case "1":
            disStudentGrades(showAverage: true)
            
        case "2":
            disStudentGrades(showAverage: false)
            
        case "3":
            allStudentsGrades()
            
        case "4":
            averageClassGrade()
            
        case "5":
            assignmentAverage()
            
        case "6":
            gradeRank(lowest: true)
            
        case "7":
            gradeRank(lowest: false)
            
        case "8":
            filterByRange()
            
        case "9":
            changeGrade()
            
        case "10":
            print("Have a great rest of your day!")
            
            //when the user choose option 9, stop showing menu options
            disMenu = false
            
        default:
            print("Enter a appropriate option!")
            disMenu = true
        }
    }
}
func disStudentGrades(showAverage: Bool){
    print("Which student would you like to choose?")
    if let nameInput = readLine(){
        
        //use for-in loop to access each student's name in studentData
        for studentName in studentData.indices{
            if nameInput.lowercased() == studentData[studentName].name.lowercased(){
                if showAverage{
                    print("\(nameInput.capitalized)'s grades in this class is \(studentData[studentName].averageGrades)")
                }
                else{
                    //separate each grade with a comma
                    let showAllGrades = studentData[studentName].grades.joined(separator: ", ")
                    print("\(nameInput.capitalized)'s grades in this class are \(showAllGrades)")
                }
                //return to go back the top of the function
                return
            }
        }
    }
    print("Student not found!")
    return
}

func allStudentsGrades(){
    //use for-in loop to access names and grades of students
    for student in studentData.indices{
        let allNames = studentData[student].name
        //separate each grade with a comma and convert the array into string
        let allGrades = studentData[student].grades.joined(separator: ", ")
        print("\(allNames) grades are \(allGrades)")
    }
}

func averageClassGrade(){
    //reset variable
    numOfStudent = 0
    allGrades = 0
    average = 0
    //use for-in loop to access all the average grades of students
    //then add all the average grades together
    for student in studentData.indices{
        allGrades += studentData[student].averageGrades
        numOfStudent += 1
        
    }
    //find average grade
    average = allGrades/numOfStudent
    print("The class average is: "  + String(format:"%.2f", average))
}

func assignmentAverage(){
    //reset variable
    numOfStudent = 0
    allGrades = 0
    average = 0
    print("Which assingment would you like to get the average of (1-10)?")
    //careful when chosing assignment 10 because the last student only has 9 assignments
    if let userInput = readLine(), let assnInput = Int(userInput), assnInput > 0, assnInput <= 10{
        for student in studentData.indices {
            //access the grade inside the struct
            //index cannot be 10 since it will be out of bound
            let assignmentIndex = studentData[student].grades[assnInput - 1]
            allGrades += Double(assignmentIndex)!
            numOfStudent += 1
        }
        //find average of the assignment
        average = allGrades/numOfStudent
        print("The average for assignment #\(assnInput) is " + String(format: "%.2f", average))
    }
    else{
        print("Please choose a correct assignment number!")
        return
    }
}

func gradeRank(lowest: Bool){
    //use min to find the lowest average grade in the struct
    if let lowestStudent = studentData.min(by: {$0.averageGrades < $1.averageGrades}){
        if lowest{
            print("\(lowestStudent.name) is the student with the lowest grade: \(lowestStudent.averageGrades)")
        }
    }
    //use max to find the highest average grade in the struct
    if let highestStudent = studentData.max(by: {$0.averageGrades < $1.averageGrades}){
        if !lowest{
            print("\(highestStudent.name) is the student with the highest grade: \(highestStudent.averageGrades)")
        }
    }
}

func filterByRange(){
    print("Enter the low range you would like to use:")
    //grab the low range input and convert it to double
    if let userInput = readLine(), let lowRange = Double(userInput){
        print("Enter the high range you would like to use:")
         //grab the high range input and convert it to double
        if let userInput = readLine(), let highRange = Double(userInput){
            if highRange < lowRange{
                print("Higher range cannot be smaller than lower range!")
            }
            else{
                //then use filter to find average grades within the range
                let gradeRange = studentData.filter({$0.averageGrades > lowRange && $0.averageGrades < highRange})
                //then access the gradeRange variable to print the names and grades of students
                for student in gradeRange{
                    print("\(student.name): \(student.averageGrades)")
                }
            }
        }
        else{
            print("Enter an appropriate range!")
            return
        }
    }
}

func changeGrade(){
    //choose the student that need to change grade
    print("Which student would you like to choose?")
    if let nameInput = readLine(){
        for student in studentData.indices{
            if nameInput.lowercased() == studentData[student].name.lowercased(){
                //then find which assignment to change grade
                print("Which assignment would you like to change the grade of (1-10)?")
                if let userInput = readLine(), let assnChosen = Int(userInput), assnChosen > 0, assnChosen <= 10{
                    //use if to check whether the input is within the given range of assignment
                    if assnChosen <= studentData[student].grades.count{
                        //create variables to store name and grade
                        let studentName = studentData[student].name
                        var studentGrade = studentData[student].grades[assnChosen - 1]
                        print("Current grade for \(studentName) in assignment #\(assnChosen) is \(studentGrade)")
                        print("Enter new grade: ")
                        //grab the new grade input
                        if let userInput = readLine(), let gradeInput = Double(userInput){
                            
                            //change the old grade to new grade
                            studentData[student].grades[assnChosen - 1] = String(gradeInput)
                            //calculate the new average
                            allGrades = 0.0
                            average = 0.0
                            for grade in studentData[student].grades{
                                if let gradeValue = Double(grade){
                                    allGrades += gradeValue
                                }
                            }
                            //divided allGrades by the number of grades
                            average = allGrades/Double(studentData[student].grades.count)
                            studentData[student].averageGrades = average
                            print("Grade for \(studentName) in assignment #\(assnChosen) is updated to \(gradeInput)")
                        }
                        else{
                            print("Please enter an appropriate number!")
                            return
                        }
                    }
                }
                else{
                    print("Please enter an approprapriate number!")
                    return
                }
            }
        }
    }
    else{
        print("Student not found!")
        return
    }
}


