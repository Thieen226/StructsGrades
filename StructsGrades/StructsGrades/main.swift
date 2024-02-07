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
    var fullName = data[0]
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
    
    print(studentData)
}
print("Ok")





