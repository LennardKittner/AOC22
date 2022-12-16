//
//  day16.swift
//  AOC22
//
//  Created by Lennard on 16.12.22.
//

import Foundation

// Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
func day16_1(fileContent: String) -> Int {
    let valves = fileContent.components(separatedBy: .newlines).map({line in
        let a = line.components(separatedBy: "Valve ")
        let a1 = a.last!.components(separatedBy: " has flow rate=")
        let valve = a1.first!
        var a2 = a1.last!.components(separatedBy: "; tunnels lead to valves ")
        if a2.count == 1 {
            a2 = a1.last!.components(separatedBy: "; tunnel leads to valve ")
        }
        let flow = Int(a2.first!)!
        let tunnels = a2.last!.components(separatedBy: ", ")
        return (valve: valve, flow: flow, tunnels: tunnels)
    })
    let valvesWithFlow = valves.filter({valve in valve.flow > 0}).sorted(by: {v1, v2 in v1.flow > v2.flow})
    var valveMap :[String : (valve: String, flow: Int, tunnels: [String])] = [:]
    for v in valves {
        valveMap[v.valve] = v
    }
    
    var shortesPath :[String : [String : Int]] = [:]
    for v in valvesWithFlow {
        shortesPath[v.valve] = [:]
        shortesPath[v.valve]![v.valve] = 0
        var next = [v.valve]
        while !next.isEmpty {
            let curr = valveMap[next.popLast()!]!
            for tunnel in curr.tunnels {
                if shortesPath[v.valve]![curr.valve]! + 1 < shortesPath[v.valve]![tunnel] ?? Int.max {
                    shortesPath[v.valve]![tunnel] = shortesPath[v.valve]![curr.valve]! + 1
                    next.append(tunnel)
                }
            }
        }
    }
    var satartRoom = "AA"
    if valveMap.keys.contains(satartRoom){
        shortesPath[satartRoom] = [:]
        shortesPath[satartRoom]![satartRoom] = 0
        var next = [satartRoom]
        while !next.isEmpty {
            let curr = valveMap[next.popLast()!]!
            for tunnel in curr.tunnels {
                if shortesPath[satartRoom]![curr.valve]! + 1 < shortesPath[satartRoom]![tunnel] ?? Int.max {
                    shortesPath[satartRoom]![tunnel] = shortesPath[satartRoom]![curr.valve]! + 1
                    next.append(tunnel)
                }
            }
        }
    }
       
    return _calcPressure(seq: ["AA", "DD", "BB", "JJ", "HH", "EE", "CC"], shortesPath: shortesPath, valveMap: valveMap)
}

func _calcPressure(seq: [String], shortesPath: [String : [String : Int]], valveMap: [String : (valve: String, flow: Int, tunnels: [String])]) -> Int {
    var minute = 0
    var presure = 0
    minute += shortesPath[seq[0]]![seq[1]]!
    for i in 1..<seq.count-1 {
        if minute > 30 {
            return presure
        }
        minute += 1
        presure += (30 - minute) * valveMap[seq[i]]!.flow
        minute += shortesPath[seq[i]]![seq[i+1]]!
        if minute > 30 {
            break
        }
    }
    if minute < 30 {
        presure += (30 - minute) * valveMap[seq.last!]!.flow
    }
    return presure
}


func day16_2(fileContent: String) -> Int {
    return 0
}
