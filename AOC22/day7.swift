//
//  day7.swift
//  AOC22
//
//  Created by Lennard on 07.12.22.
//

import Foundation

func day7_1(fileContent: String) -> Int {
    let root = Dir(name: "/", size: 0, content: [], parent: nil)
    var wd = root
    for line in fileContent.components(separatedBy: .newlines)[1...] {
        let commands = line.components(separatedBy: " ")
        if commands[0] == "$" {
            if commands[1] == "cd" {
                wd = commands[2] == ".." ? wd.parent! : wd.content.first(where: {file in file.name == commands[2]})! as! Dir
            }
        } else {
            if commands[0] == "dir" {
                wd.content.append(Dir(name: commands[1], size: 0, content: [], parent: wd))
            } else {
                wd.content.append(File(name: commands[1], size: Int(commands[0])!))
            }
        }
    }
    return _calcSize(dir: root).smallDirCount
}

func _calcSize(dir: Dir) -> (size: Int, smallDirCount: Int) {
    var result = (size: 0, smallDirCount: 0)
    for file in dir.content {
        if let subDir = file as? Dir {
            let reponse = _calcSize(dir: subDir)
            result.size += reponse.size
            result.smallDirCount += reponse.smallDirCount
        } else {
            result.size += file.size
        }
    }
    dir.size = result.size
    if result.size <= 100000 {
        result.smallDirCount += result.size
    }
    return result
}

func day7_2(fileContent: String) -> Int {
    let root = Dir(name: "/", size: 0, content: [], parent: nil)
    var wd = root
    for line in fileContent.components(separatedBy: .newlines)[1...] {
        let commands = line.components(separatedBy: " ")
        if commands[0] == "$" {
            if commands[1] == "cd" {
                wd = commands[2] == ".." ? wd.parent! : wd.content.first(where: {file in file.name == commands[2]})! as! Dir
            }
        } else {
            if commands[0] == "dir" {
                wd.content.append(Dir(name: commands[1], size: 0, content: [], parent: wd))
            } else {
                wd.content.append(File(name: commands[1], size: Int(commands[0])!))
            }
        }
    }
    _calcSize(dir: root)
    let targetSize = 30000000 - (70000000 - root.size)
    return _findSmallDir(dir: root, target: targetSize)
}

func _findSmallDir(dir: Dir, target: Int) -> Int {
    var subDirSizes :[Int] = []
    for file in dir.content {
        if let subDir = file as? Dir {
            if subDir.size >= target {
                subDirSizes.append(_findSmallDir(dir: subDir, target: target))
            }
        }
    }
    return subDirSizes.min() ?? dir.size
}

class File {
    var name :String
    var size :Int
    
    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }
}

class Dir :File {
    var content :[File]
    var parent :Dir?
    
    init(name: String, size: Int, content: [File], parent: Dir?) {
        self.content = content
        self.parent = parent
        super.init(name: name, size: size)
    }
}
