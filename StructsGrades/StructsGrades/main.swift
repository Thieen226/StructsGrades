//
//  main.swift
//  StructsGrades
//
//  Created by StudentAM on 2/7/24.
//

import Foundation
import CSV

struct Students{
    var fullName: String
    var grades: [String]
    var averageGrades: Double
}

do{
    //input stream to get data from the grades.csv file
    let stream = InputStream(fileAtPath: "/Users/studentam/Desktop/grades.csv")
    
    //creating a variable to grab the data from stream variable
    let csv = try CSVReader(stream: stream!)
    
    //as long as there is a row, the while loop will grab the data from the stream
    while let row = csv.next(){
        //append the data from grades.csv to struct
        
    }
}
catch{
    print("There was an error trrying to read the file!")
}

