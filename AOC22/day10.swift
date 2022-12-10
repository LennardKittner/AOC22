//
//  day10.swift
//  AOC22
//
//  Created by Lennard on 10.12.22.
//

import Foundation

func day10_1(fileContent: String) -> Int {
    let instructions = fileContent.components(separatedBy: .newlines).map({line in
        let args = line.components(separatedBy: " ")
        return (cmd: args[0], lit: Int(args.last ?? "0") ?? 0)
    })
    var signal = 0
    var x = 1
    var pc = 0
    var skip = 0
    var execution = false
    for cycle in 1...Int.max {
        if skip > 0 {
            skip--
        }
        if execution && skip == 0 {
            x += instructions[pc++].lit
            execution = false
        }
        if  pc == instructions.count {
            break
        }
        if !execution && instructions[pc].cmd == "noop" {
            pc++
        } else if !execution && instructions[pc].cmd == "addx" {
            execution = true
            skip += 2
        }
        if cycle == 20 || (cycle-20) % 40 == 0 {
            signal += cycle * x
        }
    }
    return signal
}

func day10_2(fileContent: String) -> Int {
    let instructions = fileContent.components(separatedBy: .newlines).map({line in
        let args = line.components(separatedBy: " ")
        return (cmd: args[0], lit: Int(args.last ?? "0") ?? 0)
    })
    var x = 1
    var pc = 0
    var skip = 0
    var execution = false
    var crt = Array(repeating: Array(repeating: false, count: 40), count: 6)
    for cycle in 1...Int.max {
        if skip > 0 {
            skip--
        }
        if execution && skip == 0 {
            x += instructions[pc++].lit
            execution = false
        }
        if  pc == instructions.count {
            break
        }
        if !execution && instructions[pc].cmd == "noop" {
            pc++
        } else if !execution && instructions[pc].cmd == "addx" {
            execution = true
            skip += 2
        }
        crt[(cycle-1) / 40][(cycle-1) % 40] = abs((cycle-1) % 40 - x) < 2 ? true : false
    }
    print(crt.reduce("", {acc, line in
        acc + line.reduce("", {a, c in
            a + (c ? "#" : ".")
        }) + "\n"
    }))
    return 0
}
