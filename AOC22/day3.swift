//
//  day3.swift
//  AOC22
//
//  Created by Lennard on 03.12.22.
//

import Foundation

func day3_1(fileContent: String) -> Int {
    let rucksacks = fileContent.components(separatedBy: .newlines)
    var sum = 0
    for rucksack in rucksacks {
        var duplicates = Set<Character>()
        for i in 0..<(rucksack.count/2) {
            let char = rucksack[i]
            for j in (rucksack.count/2)..<rucksack.count {
                if (rucksack[j] == char) {
                    duplicates.insert(char)
                }
            }
        }
        for c in duplicates {
            if c.isUppercase {
                sum += Int(c.asciiValue! - "A".first!.asciiValue!) + 27
            } else {
                sum += Int(c.asciiValue! - "a".first!.asciiValue!) + 1
            }
        }
    }
    return sum
}

func day3_2(fileContent: String) -> Int {
    let rucksacks = fileContent.components(separatedBy: .newlines)
    var sum = 0
    for r in stride(from: 0, to: rucksacks.count, by: 3)  {
        var duplicates = Set<Character>()
        for i in 0..<rucksacks[r].count {
            let char = rucksacks[r][i]
            for j in 0..<rucksacks[r+1].count {
                if (rucksacks[r+1][j] == char) {
                    duplicates.insert(char)
                }
            }
        }
        var badge: Character = "A"
        for c in duplicates {
            for j in 0..<rucksacks[r+2].count {
                if (rucksacks[r+2][j] == c) {
                    badge = c
                }
            }
        }
        if badge.isUppercase {
            sum += Int(badge.asciiValue! - "A".first!.asciiValue!) + 27
        } else {
            sum += Int(badge.asciiValue! - "a".first!.asciiValue!) + 1
        }
    }
    return sum
}
