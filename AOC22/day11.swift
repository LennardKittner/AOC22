//
//  day11.swift
//  AOC22
//
//  Created by Lennard on 11.12.22.
//

import Foundation

func day11_1(fileContent: String) -> Int {
    return _day11(fileContent: fileContent, releave: true, turns: 20)
}

func day11_2(fileContent: String) -> Int {
    return _day11(fileContent: fileContent, releave: false, turns: 10000)
}

func _day11(fileContent: String, releave: Bool, turns: Int) -> Int {
    let monkeys = fileContent.components(separatedBy: "\n\n").map({m in
        m.components(separatedBy: .newlines)[1...].map({attr in attr.trimmingCharacters(in: .whitespaces)})
    }).map({monkey in
        var inventory :[Int] = monkey[0].components(separatedBy: "Starting items: ").last!.components(separatedBy: ", ").map({s in Int(s)!})
        var operation :(op: Character, val: Int, old: Bool)
        var test :(val: Int, t: Int, f: Int)
        let op = monkey[1].components(separatedBy: "Operation: new = old ").last!.components(separatedBy: .whitespaces)
        operation = (op: op.first!.first! , val: Int(op[1]) ?? 0, old: op[1] == "old")
        let te = Int(monkey[2].components(separatedBy: "Test: divisible by ").last!)!
        let ta1 = Int(monkey[3].components(separatedBy: "If true: throw to monkey ").last!)!
        let ta2 = Int(monkey[4].components(separatedBy: "If false: throw to monkey ").last!)!
        test = (val: te, t: ta1, f: ta2)
        return Monkey(inventory: inventory, operation: operation, test: test, releave: releave)
    })
    let lcm = monkeys.reduce(1, {acc, monkey in acc * monkey.test.val})
    for i in 0..<monkeys.count {
        monkeys[i].mokeys = monkeys
        monkeys[i].lcm = lcm
    }
    for _ in 1...turns {
        monkeys.forEach({monkey in monkey.turn()})
    }
    var inspections = monkeys.map({monkey in monkey.inspections}).sorted()
    return inspections.popLast()! * inspections.popLast()!

}

class Monkey {
    var inventory :[Int]
    var operation :(op: Character, val: Int, old: Bool)
    var test :(val: Int, t: Int, f: Int)
    var inspections :Int = 0
    var mokeys :[Monkey]!
    var releave :Bool
    var lcm: Int!
    
    init(inventory: [Int], operation: (op: Character, val: Int, old: Bool), test: (val: Int, t: Int, f: Int), releave: Bool) {
        self.inventory = inventory
        self.operation = operation
        self.test = test
        self.releave = releave
    }
    
    func turn() {
        inventory = inventory.map({item in
            if operation.op == "+" {
                if operation.old {
                    return 2*item
                } else {
                    return item + operation.val
                }
            } else if operation.op == "*" {
                if operation.old {
                    return item*item
                } else {
                    return item * operation.val
                }
            }
            return Int.max
        }).map({item in item % lcm})
        if releave {
            inventory = inventory.map({item in item/3})
        }
        inspections += inventory.count
        for item in inventory {
            if item % test.val == 0 {
                mokeys[test.t].inventory.append(item)
            } else {
                mokeys[test.f].inventory.append(item)
            }
        }
        inventory.removeAll()
    }
}
