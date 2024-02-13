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
    print("There was an error trrying to read the file!")
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
            lowestGrade()
            
        case "7":
            highestGrade()
            
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
}

func allStudentsGrades(){
    for student in studentData.indices{
        let allNames = studentData[student].name
        let allGrades = studentData[student].grades.joined(separator: ", ")
        print("\(allNames) grades are \(allGrades)")
    }
}

func averageClassGrade(){
    var numOfAssn : Double = 0.0
    var allGrades : Double = 0.0
    var averageClass : Double = 0.0
    for student in studentData.indices{
        allGrades = studentData[student].averageGrades
        numOfAssn += 1
        averageClass = allGrades/numOfAssn
        print("The class average is: \(averageClass)")
    }
    
}

func assignmentAverage(){
    
}

func lowestGrade(){
    
}

func highestGrade(){
    
}

func filterByRange(){
    
}

func changeGrade(){
    
}


