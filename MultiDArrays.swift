//
// BoardFoot.swift
//
//  Created by Nicolas Riscalas
//  Created on 2023-03-05
//  Version 1.0
//  Copyright (c) 2023 Nicolas Riscalas. All rights reserved.
//
//  Generates random numbers on a Gaussian distribution
import Foundation

// This function was copied from somewhere else since generating a guassian number doesn't work in swift.
func gaussianRandom(mean: Double, standardDeviation: Double) -> Double {
    var randNormal: Double
    repeat {
        let num1 = Double.random(in: 0...1)
        let num2 = Double.random(in: 0...1)
        let randStdNormal = sqrt(-2.0 * log(num1)) * sin(2.0 * .pi * num2)
        randNormal = mean + standardDeviation * randStdNormal
    } while randNormal > 100.0 || randNormal < 0.0
    return randNormal
}

// This function generates an array with random marks for each student and assignment
func generateStudentMarks(students: [String], assignments: [String]) -> [[String]] {
    var marks = [[String]]()
    let meanVal = 75.0
    let standardDeviationVal = 10.0
    // Add first value
    marks.append(["Name"] + assignments)
    // for loop handling the students
    for student in students {
        var studentMarks = [student]
        for _ in assignments {
            // generate the random number
            let randomMark = String(gaussianRandom(mean: meanVal, standardDeviation: standardDeviationVal))
            // Add random mark
            studentMarks.append(randomMark)
        }
        // Add row with marks for student
        marks.append(studentMarks)
    }
    return marks
}

// This function converts a 2D array to a CSV string
func arrayToCSV(_ array: [[String]]) -> String {
    return array.map { row in row.joined(separator: ",") }.joined(separator: "\n")
}

// Main program
func main() {
    // File names
    let studentFileName = "students.txt"
    let assignmentFileName = "assignments.txt"
    let outputFileName = "Unit1-08-Output.csv"

    do {
        // get the contents of the file
        let studentFileContents = try String(contentsOfFile: studentFileName)
        let assignmentFileContents = try String(contentsOfFile: assignmentFileName)
        // split the file into an array spliting by new line
        let students = studentFileContents.split(separator: "\n").map(String.init)
        let assignments = assignmentFileContents.split(separator: "\n").map(String.init)
        // generate the marks then make the valus a csv string
        let studentMarks = generateStudentMarks(students: students, assignments: assignments)
        let csvString = arrayToCSV(studentMarks)
        // display the string then write to the file
        print(csvString)
        try csvString.write(toFile: outputFileName, atomically: true, encoding: .utf8)
    } catch {
        print("An error occurred: \(error.localizedDescription)")
    }
}

main()
