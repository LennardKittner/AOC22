//
//  day5.swift
//  AOC22
//
//  Created by Lennard on 05.12.22.
//

import Foundation

func day5_1(fileContent: String) -> String {
    let lines = fileContent.components(separatedBy: .newlines)
    var stacks :[[Character]] = Array(repeating: [], count: lines[0].count/4)
    var endOfStacks = 0
    for j in 0..<lines.count {
        if lines[j+1].isEmpty {
            endOfStacks = j+2
            break
        }
        stacks.append([])
        for i in stride(from: 1, to: lines[j].count, by: 4) {
            if lines[j][i] == " " {
                continue
            }
            stacks[i/4].insert(lines[j][i], at: 0)
        }
    }
    for i in endOfStacks..<lines.count {
        var line = lines[i]
        line.removeSubrange(line.startIndex..<line.index(line.startIndex, offsetBy: 5))
        var components = line.components(separatedBy: " from ")
        let times = Int(components[0])!
        components = components[1].components(separatedBy: " to ")
        let from = Int(components[0])! - 1
        let to = Int(components[1])! - 1
        
        for _ in 0..<times {
            stacks[to].append(stacks[from].popLast()!)
        }
    }
    var result = ""
    for stack in stacks {
        if !stack.isEmpty {
            result.append(stack.last!)
        }
    }
    return result
}

func day5_2(fileContent: String) -> String {
    let lines = fileContent.components(separatedBy: .newlines)
    var stacks :[[Character]] = Array(repeating: [], count: lines[0].count/4)
    var endOfStacks = 0
    for j in 0..<lines.count {
        if lines[j+1].isEmpty {
            endOfStacks = j+2
            break
        }
        stacks.append([])
        for i in stride(from: 1, to: lines[j].count, by: 4) {
            if lines[j][i] == " " {
                continue
            }
            stacks[i/4].insert(lines[j][i], at: 0)
        }
    }
    for i in endOfStacks..<lines.count {
        var line = lines[i]
        line.removeSubrange(line.startIndex..<line.index(line.startIndex, offsetBy: 5))
        var components = line.components(separatedBy: " from ")
        let times = Int(components[0])!
        components = components[1].components(separatedBy: " to ")
        let from = Int(components[0])! - 1
        let to = Int(components[1])! - 1
        
        stacks[to].append(contentsOf: stacks[from][(stacks[from].count-times)..<stacks[from].count])
        for _ in 0..<times {
            stacks[from].popLast()
        }
    }
    var result = ""
    for stack in stacks {
        if !stack.isEmpty {
            result.append(stack.last!)
        }
    }
    return result
}
