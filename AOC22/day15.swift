//
//  day15.swift
//  AOC22
//
//  Created by Lennard on 15.12.22.
//

import Foundation

func day15_1(fileContent: String) -> Int {
    // Sensor at x=2, y=18: closest beacon is at x=-2, y=15
    let sensors = fileContent.components(separatedBy: .newlines).map({line in
        let a = line.components(separatedBy: ": closest beacon is at x=")
        let sensor = a.first!.components(separatedBy: "Sensor at x=").last!.components(separatedBy: ", y=").map({cord in Int(cord)!})
        let beacon = a.last!.components(separatedBy: ", y=").map({cord in Int(cord)!})
        return (sx: sensor.first!, sy: sensor.last!, bx: beacon.first!, by: beacon.last!)
    })
    let cordToInt = {(cord: (x: Int, y: Int)) -> Int in
        return cord.x + cord.y * 10000000
    }
    let intToCord = {(int: Int) -> (x: Int, y: Int) in
        return (x: int % 10000000, y: int / 10000000)
    }
    var noBeacon = Set<Int>()
    var beacons = Set<Int>()
    let row = 2000000
    for sensor in sensors {
        beacons.insert(cordToInt((sensor.bx, sensor.by)))
    }
    
    for sensor in sensors {
        let distance = _manhattanDistance(sensor)
        if abs(sensor.sy-row) > distance {
            continue
        }
        let y = row-sensor.sy
        for x in -(distance-abs(y))...(distance-abs(y)) {
            let cord = (x: x + sensor.sx, y: y + sensor.sy)
            if cord.y == row && !beacons.contains(cordToInt(cord)){
                noBeacon.insert(cordToInt(cord))
            }
        }
    }
    return noBeacon.count
}

func _manhattanDistance(_ sb: (sx: Int, sy: Int, bx: Int, by: Int)) -> Int {
    return _manhattanDistance(x1: sb.sx, y1: sb.sy, x2: sb.bx, y2: sb.by)
}

func _manhattanDistance(x1: Int, y1: Int, x2: Int, y2: Int) -> Int {
    return abs(x1-x2) + abs(y1-y2)
}

func _overlap(a: (min: Int, max: Int), b: (min: Int, max: Int)) -> Bool {
    if a.min >= b.min && a.min <= b.max {
        return true
    }
    if a.max >= b.min && a.max <= b.max {
        return true
    }
    return false
}

func _merge(a: (min: Int, max: Int), b: (min: Int, max: Int)) -> (min: Int, max: Int) {
    return (min(a.min, b.min), max(a.max, b.max))
}

func day15_2(fileContent: String) -> Int {
    // Sensor at x=2, y=18: closest beacon is at x=-2, y=15
    let sensors = fileContent.components(separatedBy: .newlines).map({line in
        let a = line.components(separatedBy: ": closest beacon is at x=")
        let sensor = a.first!.components(separatedBy: "Sensor at x=").last!.components(separatedBy: ", y=").map({cord in Int(cord)!})
        let beacon = a.last!.components(separatedBy: ", y=").map({cord in Int(cord)!})
        return (sx: sensor.first!, sy: sensor.last!, bx: beacon.first!, by: beacon.last!)
    }).map({sensor in
        let d = _manhattanDistance(sensor)
        return (sx: sensor.sx, sy: sensor.sy, d: d)
    })

    let bound = 4000000
    for sensor in sensors {
        for y in -sensor.d-1...sensor.d+1 {
            let d = abs(y)-sensor.d-1
            let p1 = (x: sensor.sx + d, y: sensor.sy + y)
            let p2 = (x: sensor.sx - d, y: sensor.sy + y)
            
            if p1.x >= 0 && p1.x <= bound && p1.y >= 0 && p1.y <= bound {
                var contained = false
                for ss in sensors {
                    if _manhattanDistance(x1: ss.sx, y1: ss.sy, x2: p1.x, y2: p1.y) <= ss.d {
                        contained = true
                    }
                }
                if !contained {
                    return p1.x*4000000+p1.y
                }
            }
            
            if p2.x >= 0 && p2.x <= bound && p2.y >= 0 && p2.y <= bound {
                var contained = false
                for ss in sensors {
                    if _manhattanDistance(x1: ss.sx, y1: ss.sy, x2: p2.x, y2: p2.y) <= ss.d {
                        contained = true
                    }
                }
                if !contained {
                    return p2.x*4000000+p2.y
                }
            }
            
        }
    }
    
    return -1
}
