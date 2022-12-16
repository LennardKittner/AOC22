//
//  day14.swift
//  AOC22
//
//  Created by Lennard on 14.12.22.
//

import Foundation

func day14_1(fileContent: String) -> Int {
    let rocks = fileContent.components(separatedBy: .newlines).map({line in line.components(separatedBy: " -> ").map({cord in
        let cords = cord.components(separatedBy: ",")
        return (x: Int(cords.first!)!, y: Int(cords.last!)!)
    })})
    var grid = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)
    let airT = 0
    let rockT = 1
    let sandT = 2
    let restedSandT = 3
    var sandCount = 0
    for rock in rocks {
        var prev = rock.first!
        var curr = rock.first!
        for i in 1..<rock.count {
            prev = curr
            curr = rock[i]
            if prev.x == curr.x {
                for j in 0...abs(prev.y-curr.y) {
                    grid[prev.x][min(prev.y, curr.y) + j] = rockT
                }
            } else {
                for j in 0...abs(prev.x-curr.x) {
                    grid[min(prev.x, curr.x) + j][prev.y] = rockT
                }
            }
        }
    }
    var sandCords = (x: 500, y: 0)
    sandCount = 1
    while true {
        if sandCords.y >= 999 {
            sandCount -= 1
            break
        }
        if grid[sandCords.x][sandCords.y+1] == airT {
            sandCords.y += 1
            continue
        }
        if grid[sandCords.x-1][sandCords.y+1] == airT {
            sandCords.x -= 1
            sandCords.y += 1
            continue
        }
        if grid[sandCords.x+1][sandCords.y+1] == airT {
            sandCords.x += 1
            sandCords.y += 1
            continue
        }
        grid[sandCords.x][sandCords.y] = restedSandT
        sandCords = (500, 0)
        sandCount += 1
    }
    /*
    for y in 0...200 {
        var row = ""
        for x in 450...800 {
            if grid[x][y] == airT {
                row += "."
            } else if grid[x][y] == rockT {
                row += "#"
            } else if grid[x][y] == restedSandT {
                row += "o"
            }
        }
        print(row)
    }*/
    return sandCount
}

func day14_2(fileContent: String) -> Int {
    var maxY = -1
    let rocks = fileContent.components(separatedBy: .newlines).map({line in line.components(separatedBy: " -> ").map({cord in
        let cords = cord.components(separatedBy: ",")
        maxY = max(maxY, Int(cords.last!)!)
        return (x: Int(cords.first!)!, y: Int(cords.last!)!)
    })})
    var grid = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)
    let airT = 0
    let rockT = 1
    let sandT = 2
    let restedSandT = 3
    var sandCount = 0
    for x in 0..<grid.count {
        grid[x][maxY+2] = rockT
    }
    for rock in rocks {
        var prev = rock.first!
        var curr = rock.first!
        for i in 1..<rock.count {
            prev = curr
            curr = rock[i]
            if prev.x == curr.x {
                for j in 0...abs(prev.y-curr.y) {
                    grid[prev.x][min(prev.y, curr.y) + j] = rockT
                }
            } else {
                for j in 0...abs(prev.x-curr.x) {
                    grid[min(prev.x, curr.x) + j][prev.y] = rockT
                }
            }
        }
    }
    var sandCords = (x: 500, y: 0)
    sandCount = 1
    while true {
        if grid[500][0] == restedSandT {
            sandCount -= 1
            break
        }
        if grid[sandCords.x][sandCords.y+1] == airT {
            sandCords.y += 1
            continue
        }
        if grid[sandCords.x-1][sandCords.y+1] == airT {
            sandCords.x -= 1
            sandCords.y += 1
            continue
        }
        if grid[sandCords.x+1][sandCords.y+1] == airT {
            sandCords.x += 1
            sandCords.y += 1
            continue
        }
        grid[sandCords.x][sandCords.y] = restedSandT
        sandCords = (500, 0)
        sandCount += 1
    }
    /*
    for y in 0...9 {
        var row = ""
        for x in 494...503 {
            row += grid[x][y].description
        }
        print(row)
    }
     */
    return sandCount
}
