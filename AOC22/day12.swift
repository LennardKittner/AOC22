//
//  day12.swift
//  AOC22
//
//  Created by Lennard on 12.12.22.
//

import Foundation
//12min + 9:35
func day12_1(fileContent: String) -> Int {
    let grid :[[Character]] = fileContent.components(separatedBy: .newlines).map({line in line.reduce([], {acc, s in
        var a = acc
        a.append(s)
        return a
    })})
    let cordToInt = {(cord: (x: Int, y: Int)) -> Int in
        return cord.x + cord.y * grid.count
    }
    let intToCord = {(int: Int) -> (x: Int, y: Int) in
        return (x: int % grid.count, y: int / grid.count)
    }
    
    var next :[(x: Int, y: Int)] = []
    var distance :[Int : Int] = [:]
    var s :(x: Int, y: Int) = (0, 0)
    var e :(x: Int, y: Int) = (0, 0)
    for x in 0..<grid.count {
        for y in 0..<grid.first!.count {
            if grid[x][y] == "E" {
                e = (x: x, y: y)
            } else if grid[x][y] == "S" {
                s = (x: x, y: y)
            }
        }
    }
    next.append(s)
    distance[cordToInt(s)] = 0
    while !next.isEmpty {
        let curr = next.popLast()!
        let heigth = grid[curr.x][curr.y]
        var dirs :[(x: Int, y: Int)] = []
        if (grid.get(index: curr.x-1)?.get(index: curr.y)?.day12Code() ?? Int.max) <= (heigth.day12Code() + 1) {
            dirs.append((curr.x-1, curr.y))
        }
        if (grid.get(index: curr.x+1)?.get(index: curr.y)?.day12Code() ?? Int.max) <= (heigth.day12Code() + 1) {
            dirs.append((curr.x+1, curr.y))
        }
        if (grid.get(index: curr.x)?.get(index: curr.y-1)?.day12Code() ?? Int.max) <= (heigth.day12Code() + 1) {
            dirs.append((curr.x, curr.y-1))
        }
        if (grid.get(index: curr.x)?.get(index: curr.y+1)?.day12Code() ?? Int.max) <= (heigth.day12Code() + 1) {
            dirs.append((curr.x, curr.y+1))
        }
        
        for dir in dirs {
            if distance[cordToInt(dir)] ?? Int.max > distance[cordToInt(curr)]! + 1 {
                next.append(dir)
                distance[cordToInt(dir)] = distance[cordToInt(curr)]! + 1
            }
        }
    }
    
    return distance[cordToInt(e)]!
}

func day12_2(fileContent: String) -> Int {
    let grid :[[Character]] = fileContent.components(separatedBy: .newlines).map({line in line.reduce([], {acc, s in
        var a = acc
        a.append(s)
        return a
    })})
    let cordToInt = {(cord: (x: Int, y: Int)) -> Int in
        return cord.x + cord.y * grid.count
    }
    let intToCord = {(int: Int) -> (x: Int, y: Int) in
        return (x: int % grid.count, y: int / grid.count)
    }
    
    var next :[(x: Int, y: Int)] = []
    var distance :[Int : Int] = [:]
    var s :(x: Int, y: Int) = (0, 0)
    var e :(x: Int, y: Int) = (0, 0)
    for x in 0..<grid.count {
        for y in 0..<grid.first!.count {
            if grid[x][y] == "E" {
                e = (x: x, y: y)
            } else if grid[x][y] == "S" {
                s = (x: x, y: y)
            }
        }
    }
    next.append(e)
    distance[cordToInt(e)] = 0
    while !next.isEmpty {
        let curr = next.popLast()!
        let heigth = grid[curr.x][curr.y]
        var dirs :[(x: Int, y: Int)] = []
        if (grid.get(index: curr.x-1)?.get(index: curr.y)?.day12Code() ?? 0) >= (heigth.day12Code() - 1) {
            dirs.append((curr.x-1, curr.y))
        }
        if (grid.get(index: curr.x+1)?.get(index: curr.y)?.day12Code() ?? 0) >= (heigth.day12Code() - 1) {
            dirs.append((curr.x+1, curr.y))
        }
        if (grid.get(index: curr.x)?.get(index: curr.y-1)?.day12Code() ?? 0) >= (heigth.day12Code() - 1) {
            dirs.append((curr.x, curr.y-1))
        }
        if (grid.get(index: curr.x)?.get(index: curr.y+1)?.day12Code() ?? 0) >= (heigth.day12Code() - 1) {
            dirs.append((curr.x, curr.y+1))
        }
        
        for dir in dirs {
            if distance[cordToInt(dir)] ?? Int.max > distance[cordToInt(curr)]! + 1 {
                next.append(dir)
                distance[cordToInt(dir)] = distance[cordToInt(curr)]! + 1
            }
        }
    }
    
    var distancesToA :[Int] = []
    for x in 0..<grid.count {
        for y in 0..<grid.first!.count {
            if grid[x][y] == "a" || grid[x][y] == "S" {
                distancesToA.append(distance[cordToInt((x, y))] ?? Int.max)
            }
        }
    }
    
    return distancesToA.min()!
}

extension Character {
    func day12Code() -> Int {
        if self == "E" {
            return Int("z".first!.asciiValue!)
        }
        if self == "S" {
            return Int("a".first!.asciiValue!)
        }
        return Int(self.asciiValue ?? UInt8.max)
    }
}
