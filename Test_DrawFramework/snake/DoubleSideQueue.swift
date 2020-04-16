//
//  DoubleSideQueue.swift
//  Test_DrawFramework
//
//  Created by Doby on 2020/4/16.
//  Copyright © 2020 Doby. All rights reserved.
//

import Foundation

struct DoubleSideQueue<Element: Equatable> {
    
    var left: [Element] = []
    var right: [Element] = []
    
    var head: Element? {
        if let p = left.last {
            return p
        }
        return right.last
    }
    var tail: Element? {
        if let p = right.last {
            return p
        }
        return left.last
    }
    var length: Int {
        return left.count + right.count
    }
    
    mutating func appendHead(_ pos: Element) {
        left.append(pos)
    }
    
    @discardableResult mutating func popHead() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
    
    mutating func appendTail(_ pos: Element) {
        right.append(pos)
    }
    
    @discardableResult mutating func popTail() -> Element? {
        if right.isEmpty {
            right = left.reversed()
            left.removeAll()
        }
        return right.popLast()
    }
    
    func contains(_ e: Element) -> Bool {
        return left.contains(e) || right.contains(e)
    }
}
