//
//  main.swift
//  AOC22
//
//  Created by Lennard on 30.11.22.
//

import Foundation

if CommandLine.argc < 3 {
    print("To few arguemtns.")
    exit(1)
}

let day = Int(CommandLine.arguments[1]) ?? 0
let WD = CommandLine.arguments[2]

let path = WD + "day\(day).txt"

if var fileContent = try? String(contentsOfFile: path) {
    if fileContent.last == "\n" {
        fileContent.removeLast()
    }
    if fileContent.last == "\r" {
        fileContent.removeLast()
        fileContent.removeLast()
    }
    let now = Date().timeIntervalSince1970
    
    switch day {
        case 1: print(day1_1(fileContent: fileContent))
                print(day1_2(fileContent: fileContent))
        case 2: print(day2_1(fileContent: fileContent))
                print(day2_2(fileContent: fileContent))
        case 3: print(day3_1(fileContent: fileContent))
                print(day3_2(fileContent: fileContent))
        case 4: print(day4_1(fileContent: fileContent))
                print(day4_2(fileContent: fileContent))
        case 5: print(day5_1(fileContent: fileContent))
                print(day5_2(fileContent: fileContent))
        case 6: print(day6_1(fileContent: fileContent))
                print(day6_2(fileContent: fileContent))
        case 7: print(day7_1(fileContent: fileContent))
                print(day7_2(fileContent: fileContent))
        case 8: print(day8_1(fileContent: fileContent))
                print(day8_2(fileContent: fileContent))
        case 9: print(day9_1(fileContent: fileContent))
                print(day9_2(fileContent: fileContent))
        case 10: print(day10_1(fileContent: fileContent))
                 print(day10_2(fileContent: fileContent))
        case 11: print(day11_1(fileContent: fileContent))
                 print(day11_2(fileContent: fileContent))
        case 12: print(day12_1(fileContent: fileContent))
                 print(day12_2(fileContent: fileContent))
        default:
            print("Day not found.")
    }
    print("Time: \((Date().timeIntervalSince1970 - now) * 1000)ms")
} else {
    print("Input not found")
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
            range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    func get(index: Int) -> Element? {
        if index >= self.count || index < 0 {
            return nil
        }
        return self[index]
    }
}

extension String {
    func groups(for regex: NSRegularExpression) -> [[String]] {
        let text = self
        let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
        return matches.map { match in
            return (0..<match.numberOfRanges).map {
                let rangeBounds = match.range(at: $0)
                guard let range = Range(rangeBounds, in: text) else {
                    return ""
                }
                return String(text[range])
            }
        }
    }
}

extension Int {
    static postfix func ++(i: inout Self) -> Self {
        let c = i
        i += 1
        return c
    }
    static prefix func ++(i: inout Self) -> Self {
        i += 1
        return i
    }
    static postfix func --(i: inout Self) -> Self {
        let c = i
        i -= 1
        return c
    }
    static prefix func --(i: inout Self) -> Self {
        i -= 1
        return i
    }
}

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}

extension Array where Element: Equatable {
    func containsParts(_ parts: [Element]) -> Bool {
        return parts.reduce(true, {acc, element in acc && self.contains(element)})
    }
    func get(index: Int) -> Element? {
        if index >= self.count || index < 0 {
            return nil
        }
        return self[index]
    }
}
