//
//  day13.swift
//  AOC22
//
//  Created by Lennard on 13.12.22.
//

import Foundation

func day13_1(fileContent: String) -> Int {
    let pairs = fileContent.components(separatedBy: "\n\n").map({line in line.components(separatedBy: .newlines)}).map({pair in [_parse(string: pair.first!)!, _parse(string: pair.last!)!]})
    var result = 0
    for (i, pair) in pairs.enumerated() {
        if _compare(a1: pair.first!, a2: pair.last!) < 0 {
            result += i+1
        }
    }
    return result
}

func day13_2(fileContent: String) -> Int {
    let input = fileContent + "\n[[2]]\n[[6]]"
    var packets = input.components(separatedBy: .newlines).filter({line in !line.isEmpty}).map({line in _parse(string: line)!})
    let seperator = (s1: packets[packets.count-1], s2: packets[packets.count-2])
    packets = packets.sorted(by: {a1, a2 in _compare(a1: a1, a2: a2) <= 0})
    var result = packets.firstIndex(where: {a in seperator.s1.description == a.description})! + 1
    result *= packets.firstIndex(where: {a in seperator.s2.description == a.description})! + 1
    return result
}
class ArrayOfArrays :CustomStringConvertible {
    var int :Int?
    var array :[ArrayOfArrays]?
    public var description: String {
        return toString()
    }
 
    init(int: Int?, array: [ArrayOfArrays]?) {
        self.int = int
        self.array = array
    }
    
    func toString() -> String {
        if int != nil {
            return int!.description
        }
        if array != nil {
            var tmp = array!.reduce("", {acc, arr in acc + arr.toString() + ", "})
            if !tmp.isEmpty {
                tmp.removeLast()
                tmp.removeLast()
            }
            return "[" + tmp + "]"
        }
        return "NIL"
    }
}

func _compare(a1: ArrayOfArrays, a2: ArrayOfArrays) -> Int {
    if a1.array == nil && a2.array == nil {
        return a1.int! - a2.int!
    }
    if a1.int == nil && a2.int == nil {
        for i in 0..<a1.array!.count {
            if a2.array!.count <= i {
                return 1
            }
            let ret = _compare(a1: a1.array![i], a2: a2.array![i])
            if ret != 0 {
                return ret
            }
        }
        return a1.array!.count - a2.array!.count
    }
    if a1.array == nil {
        return _compare(a1: ArrayOfArrays(int: nil, array: [a1]), a2: a2)
    }
    if a2.array == nil {
        return _compare(a1: a1, a2: ArrayOfArrays(int: nil, array: [a2]))
    }
    print("WHY")
    return 1
}

func _parse(string: String) -> ArrayOfArrays? {
    var currStack :[ArrayOfArrays] = []
    var intString = ""
    var head :ArrayOfArrays? = nil
    for (i, c) in string.enumerated() {
        if i == 1 {
            head = currStack.first!
        }
        switch c {
            case "[":
                currStack.append(ArrayOfArrays(int: nil, array: []))
                if currStack.count > 1 {
                    currStack[currStack.count-2].array!.append(currStack.last!)
                }
            case "]":
                if !intString.isEmpty {
                    currStack.last!.array?.append(ArrayOfArrays(int: Int(intString)!, array: nil))
                    intString = ""
                }
                currStack.removeLast()
            case ",":
                if !intString.isEmpty {
                    currStack.last!.array?.append(ArrayOfArrays(int: Int(intString)!, array: nil))
                    intString = ""
                }
            default:
                intString.append(c)
        }
    }
    return head
}
