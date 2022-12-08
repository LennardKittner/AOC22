//
//  day8.swift
//  AOC22
//
//  Created by Lennard on 08.12.22.
//

import Foundation

func day8_1(fileContent: String) -> Int {
    let grid = fileContent.components(separatedBy: .newlines).map({line in line.map({tree in Int(String(tree))!})})
    let cordToInt = {(cord: (x: Int, y: Int)) -> Int in
        return cord.x + cord.y * grid.count
    }
    let intToCord = {(int: Int) -> (x: Int, y: Int) in
        return (x: int % grid.count, y: int / grid.count)
    }
    
    var visible = Set<Int>()
    for x in 1..<grid.count-1 {
        var max = -1
        for y in 0..<grid.first!.count {
            if grid[x][y] > max {
                max = grid[x][y]
                visible.insert(cordToInt((x: x, y: y)))
            }
        }
        max = -1
        for y in (0..<grid.first!.count).reversed() {
            if grid[x][y] > max {
                max = grid[x][y]
                visible.insert(cordToInt((x: x, y: y)))
            }
        }
    }
    for y in 1..<grid.first!.count-1 {
        var max = -1
        for x in 0..<grid.count {
            if grid[x][y] > max {
                max = grid[x][y]
                visible.insert(cordToInt((x: x, y: y)))
            }
        }
        max = -1
        for x in (0..<grid.count).reversed() {
            if grid[x][y] > max {
                max = grid[x][y]
                visible.insert(cordToInt((x: x, y: y)))
            }
        }
    }
    return visible.count+4 // the +4 is becuase of the corners
}

func day8_2(fileContent: String) -> Int {
    let grid = fileContent.components(separatedBy: .newlines).map({line in line.map({tree in Int(String(tree))!})})
    let cordToInt = {(cord: (x: Int, y: Int)) -> Int in
        return cord.x + cord.y * grid.count
    }
    let intToCord = {(int: Int) -> (x: Int, y: Int) in
        return (x: int % grid.count, y: int / grid.count)
    }
    var scenicScore = 0
    for x in 1..<grid.count-1 {
        for y in 1..<grid.first!.count-1 {
            var height = grid[x][y]
            var score = 1
            for currX in x+1..<grid.count {
                if grid[currX][y] >= height || currX == grid.count-1  {
                    score *= currX - x
                    break
                }
            }
            for currX in (0..<x).reversed() {
                if grid[currX][y] >= height || currX == 0  {
                    score *= abs(currX - x)
                    break
                }
            }
            for currY in y+1..<grid.first!.count {
                if grid[x][currY] >= height || currY == grid.count-1  {
                    score *= currY - y
                    break
                }
            }
            for currY in (0..<y).reversed() {
                if grid[x][currY] >= height || currY == 0  {
                    score *= abs(currY - y)
                    break
                }
            }
            if score > scenicScore {
                scenicScore = score
            }
        }
    }
    return scenicScore
}
