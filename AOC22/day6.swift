//
//  day6.swift
//  AOC22
//
//  Created by Lennard on 06.12.22.
//

import Foundation

func day6_1(fileContent: String) -> Int {
    var buffer :[Character] = []
    var packetMarker = -1
    for (i, c) in fileContent.enumerated() {
        if buffer.count == 3 && !buffer.contains(c) {
            packetMarker = i+1
            break
        } else if buffer.count <= 3 && buffer.contains(c) {
            let j = buffer.firstIndex(of: c)
            buffer.removeFirst(j!+1)
        }
        if buffer.count == 3 {
            buffer.removeFirst()
        }
        buffer.append(c)
    }
    return packetMarker
}

func day6_2(fileContent: String) -> Int {
    var buffer :[Character] = []
    var packetMarker = -1
    for (i, c) in fileContent.enumerated() {
        if buffer.count == 13 && !buffer.contains(c) {
            packetMarker = i+1
            break
        } else if buffer.count <= 13 && buffer.contains(c) {
            let j = buffer.firstIndex(of: c)
            buffer.removeFirst(j!+1)
        }
        if buffer.count == 13 {
            buffer.removeFirst()
        }
        buffer.append(c)
    }
    return packetMarker
}
