//
//  day9.swift
//  AOC22
//
//  Created by Lennard on 09.12.22.
//

import Foundation

func day9_1(fileContent: String) -> Int {
    let commands = fileContent.components(separatedBy: .newlines).map({line in
        let args = line.components(separatedBy: " ")
        return (direction: args[0], steps: Int(args[1])!)
    })
    let cordToInt = {(cord: (x: Int, y: Int)) -> Int in
        return cord.x + cord.y * 100000
    }
    let intToCord = {(int: Int) -> (x: Int, y: Int) in
        return (x: int % 100000, y: int / 100000)
    }
    
    var visited = Set<Int>()
    var head = (x: 0, y: 0)
    var tail = (x: 0, y: 0)
    visited.insert(cordToInt(tail))
    for command in commands {
        for _ in 0..<command.steps {
            switch (command.direction) {
                case "R": head.x += 1
                case "L": head.x -= 1
                case "D": head.y -= 1
                case "U": head.y += 1
                default:
                    print("Error")
            }
            if head.x  == tail.x && abs(head.y - tail.y) >= 2 {
                tail.y += head.y > tail.y ? 1 : -1
            } else if head.y  == tail.y && abs(head.x - tail.x) >= 2 {
                tail.x += head.x > tail.x ? 1 : -1
            } else if (abs(head.y - tail.y) >= 2)  || abs(head.x - tail.x) >= 2 {
                tail.y += head.y > tail.y ? 1 : -1
                tail.x += head.x > tail.x ? 1 : -1
            }
            visited.insert(cordToInt(tail))
        }
    }
    return visited.count
}

func day9_2(fileContent: String) -> Int {
    let commands = fileContent.components(separatedBy: .newlines).map({line in
        let args = line.components(separatedBy: " ")
        return (direction: args[0], steps: Int(args[1])!)
    })
    let cordToInt = {(cord: (x: Int, y: Int)) -> Int in
        return cord.x + cord.y * 100000
    }
    let intToCord = {(int: Int) -> (x: Int, y: Int) in
        return (x: int % 100000, y: int / 100000)
    }
    
    var visited = Set<Int>()
    var rope = Array(repeating: (x: 0, y: 0), count: 10)
    visited.insert(cordToInt(rope.last!))
    for command in commands {
        for _ in 0..<command.steps {
            switch (command.direction) {
                case "R": rope[0].x += 1
                case "L": rope[0].x -= 1
                case "D": rope[0].y -= 1
                case "U": rope[0].y += 1
                default:
                    print("Error")
            }
            for i in 1..<rope.count {
                var head = rope[i-1]
                if head.x  == rope[i].x && abs(head.y - rope[i].y) >= 2 {
                    rope[i].y += head.y > rope[i].y ? 1 : -1
                } else if head.y  == rope[i].y && abs(head.x - rope[i].x) >= 2 {
                    rope[i].x += head.x > rope[i].x ? 1 : -1
                } else if (abs(head.y - rope[i].y) >= 2)  || abs(head.x - rope[i].x) >= 2 {
                    rope[i].y += head.y > rope[i].y ? 1 : -1
                    rope[i].x += head.x > rope[i].x ? 1 : -1
                }
            }
            visited.insert(cordToInt(rope.last!))
        }
    }
    return visited.count

}
