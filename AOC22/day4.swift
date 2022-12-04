//
//  day4.swift
//  AOC22
//
//  Created by Lennard on 04.12.22.
//

import Foundation

func day4_1(fileContent: String) -> Int {
    let pairs = fileContent.components(separatedBy: .newlines).map({l in
        let p = l.components(separatedBy: ",")
        let range1 = p[0].components(separatedBy: "-").map({s in Int(s)!})
        let range2 = p[1].components(separatedBy: "-").map({s in Int(s)!})
        return (r1: range1[0]...range1[1], r2: range2[0]...range2[1])
    })
    var count = 0
    for pair in pairs {
        var contains = 0
        for n in pair.r1 {
            if pair.r2.contains(n) {
                contains++
            }
        }
        if contains == pair.r1.count {
            count++
            continue
        }
        contains = 0
        for n in pair.r2 {
            if pair.r1.contains(n) {
                contains++
            }
        }
        if contains == pair.r2.count {
            count++
        }
    }
    return count
}

func day4_2(fileContent: String) -> Int {
    let pairs = fileContent.components(separatedBy: .newlines).map({l in
        let p = l.components(separatedBy: ",")
        let range1 = p[0].components(separatedBy: "-").map({s in Int(s)!})
        let range2 = p[1].components(separatedBy: "-").map({s in Int(s)!})
        return (r1: range1[0]...range1[1], r2: range2[0]...range2[1])
    })
    var count = 0
    for pair in pairs {
        var contains = 0
        for n in pair.r1 {
            if pair.r2.contains(n) {
                contains++
            }
        }
        if contains > 0 {
            count++
            continue
        }
        contains = 0
        for n in pair.r2 {
            if pair.r1.contains(n) {
                contains++
            }
        }
        if contains > 0 {
            count++
        }
    }
    return count
}
