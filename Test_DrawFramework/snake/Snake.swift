//
//  Snake.swift
//  Test_DrawFramework
//
//  Created by Doby on 2020/4/16.
//  Copyright © 2020 Doby. All rights reserved.
//

import Foundation

struct Position: Equatable {
    let x: Int
    let y: Int
    
    func next(direc: Direction) -> Position {
        switch direc {
        case .up:
            return .init(x: x, y: y-1)
        case .down:
            return .init(x: x, y: y+1)
        case .left:
            return .init(x: x-1, y: y)
        case .right:
            return .init(x: x, y: y+1)
        }
    }
    
    static func == (l: Position, r: Position) -> Bool {
        return l.x == r.x && l.y == r.y
    }
}

enum Direction {
    case up, down, left, right
}

class BodyItem {
    let pos: Position
    var pre: BodyItem?
    var next: BodyItem?
    
    init(position: Position) {
        self.pos = position
    }
}

struct Snake {
    
    var bodyQueue: DoubleSideQueue<Position>
    
    init(head: Position, length: Int) {
        self.bodyQueue = .init()
        for _ in 0 ..< length {
            
        }
    }
    
    
    mutating func move(to: Position) {
        
    }
    
    func isPositionInBody(_ pos: Position) -> Bool {
        return bodyQueue.contains(pos)
    }
}
