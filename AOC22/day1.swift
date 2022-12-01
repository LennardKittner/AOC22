//
//  day1.swift
//  AOC22
//
//  Created by Lennard on 30.11.22.
//

import Foundation

func day1_1(fileContent: String) -> Int {
    let foods = fileContent.components(separatedBy: "\n").map({e in
        Int(e) ?? 0})
    var elves :[[Int]] = [[]]
    var j = 0
    for i in 0..<foods.count {
        if foods[i] == 0 {
            j += 1
            elves.append([])
        }
        elves[j].append(foods[i])
    }
    var sums :[Int] = []
    for i in 0..<elves.count {
        sums.append(0)
        for f in elves[i] {
            sums[i] += f
        }
    }
    return sums.max() ?? 0
}

func day1_2(fileContent: String) -> Int {
    let foods = fileContent.components(separatedBy: "\n").map({e in
        Int(e) ?? 0})
    var elves :[[Int]] = [[]]
    var j = 0
    for i in 0..<foods.count {
        if foods[i] == 0 {
            j += 1
            elves.append([])
        }
        elves[j].append(foods[i])
    }
    var sums :[Int] = []
    for i in 0..<elves.count {
        sums.append(0)
        for f in elves[i] {
            sums[i] += f
        }
    }
    sums.sort()
    return (sums.popLast() ?? 0) + (sums.popLast() ?? 0) + (sums.popLast() ?? 0)
}
