//
//  day2.swift
//  AOC22
//
//  Created by Lennard on 01.12.22.
//

import Foundation

func day2_1(fileContent: String) -> Int {
    let values :[Character : Int] = ["A" : 1, "B" : 2, "C" : 3, "X" : 1, "Y" : 2, "Z" : 3]
    let matchup = ["A X" : 3, "A Y" : 6, "A Z" : 0, "B X" : 0,"B Y" : 3, "B Z" : 6, "C X" : 6, "C Y" : 0, "C Z" : 3]
    return _day2(values, matchup, fileContent: fileContent)
}

func day2_2(fileContent: String) -> Int {
    let values :[Character : Int] = ["X" : 0, "Y" : 3, "Z" : 6]
    let matchup = ["A X" : 3, "A Y" : 1, "A Z" : 2, "B X" : 1,"B Y" : 2, "B Z" : 3, "C X" : 2, "C Y" : 3, "C Z" : 1]
    return _day2(values, matchup, fileContent: fileContent)
}

func _day2(_ values: [Character : Int], _ matchup: [String : Int], fileContent: String) -> Int {
    var score = 0
    let gmaes = fileContent.components(separatedBy: .newlines)
    
    for game in gmaes {
        score += values[game.last!] ?? 0
        score += matchup[game] ?? 0
    }
    return score
}
