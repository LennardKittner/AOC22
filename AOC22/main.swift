//
//  main.swift
//  AOC22
//
//  Created by Lennard on 30.11.22.
//

import Foundation

if CommandLine.argc < 3 {
    print("To few arguemtns.")
    exit(1)
}

let day = Int(CommandLine.arguments[1]) ?? 0
let WD = CommandLine.arguments[2]

let path = WD + "day\(day).txt"

if let fileContent = try? String(contentsOfFile: path) {
    switch day {
        case 1: print(day1_1(fileContent: fileContent))
                print(day1_2(fileContent: fileContent))
        case 2: print(day2_1(fileContent: fileContent))
                print(day2_2(fileContent: fileContent))
        default:
            print("Day not found.")
    }
}

