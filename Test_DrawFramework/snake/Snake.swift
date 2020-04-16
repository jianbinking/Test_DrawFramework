//
//  Snake.swift
//  Test_DrawFramework
//
//  Created by Doby on 2020/4/16.
//  Copyright © 2020 Doby. All rights reserved.
//

import UIKit

extension CGPoint {
    
    func next(direc: Direction, scale: CGFloat) -> CGPoint {
        switch direc {
        case .up:
            return .init(x: x, y: y - scale)
        case .down:
            return .init(x: x, y: y + scale)
        case .left:
            return .init(x: x - scale, y: y)
        case .right:
            return .init(x: x + scale, y: y)
        }
    }
    
    func blockFrame(scale: CGFloat) -> CGRect {
        return .init(x: x - scale / 2, y: y - scale / 2, width: scale, height: scale)
    }
}

enum Direction: Int {
    case up, down, left, right
    
    var reverseDirection: Direction {
        switch self {
        case .up:       return .down
        case .down:     return .up
        case .left:     return .right
        case .right:    return .left
        }
    }
    
    var description: String {
        switch self {
        case .up:       return "上"
        case .down:     return "下"
        case .left:     return "左"
        case .right:    return "右"
        }
    }
}

struct Snake {
    
    let scale: CGFloat
    var bodyQueue: DoubleSideQueue<CGPoint>
    var head: CGPoint {
        return bodyQueue.first!
    }
    var direction: Direction = .right
    
    var nextStep: CGPoint {
        return self.head.next(direc: direction, scale: scale)
    }
    
    init(scale: CGFloat, head: CGPoint, length: Int) {
        self.scale = scale
        self.bodyQueue = .init()
        var pos = head
        for _ in 0 ..< length {
            bodyQueue.pushTail(pos)
            pos = pos.next(direc: direction.reverseDirection, scale: scale)
        }
    }
    
    var bodyPath: CGPath {
        let bezier = UIBezierPath()
        for body in bodyQueue {
            bezier.append(UIBezierPath.init(rect: body.blockFrame(scale: scale)))
        }
        return bezier.cgPath
    }
    
    
    var length: Int {
        return bodyQueue.count
    }
    
    mutating func move(changeDirection: Direction? = nil, eat: Bool = false) {
        if let direc = changeDirection {
            if direc == direction.reverseDirection {
                print("反了")
                return
            }
            direction = direc
        }
        print("往\(direction.description)")
        bodyQueue.pushHead(bodyQueue.head!.next(direc: direction, scale: scale))
        if !eat {
            bodyQueue.popTail()
        }
        else {
            print("吃了")
        }
    }
    
    func isPositionInBody(_ pos: CGPoint) -> Bool {
        return bodyQueue.contains(pos)
    }
}
