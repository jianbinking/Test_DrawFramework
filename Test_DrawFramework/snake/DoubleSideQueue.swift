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
        return right.first
    }
    var tail: Element? {
        if let p = right.last {
            return p
        }
        return left.first
    }
    
    mutating func pushHead(_ pos: Element) {
        left.append(pos)
    }
    
    @discardableResult mutating func popHead() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
    
    mutating func pushTail(_ pos: Element) {
        right.append(pos)
    }
    
    @discardableResult mutating func popTail() -> Element? {
        if right.isEmpty {
            right = left.reversed()
            left.removeAll()
        }
        return right.popLast()
    }
}

extension DoubleSideQueue: Collection {
    
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return left.count + right.count
    }
    
    func index(after i: Int) -> Int {
        precondition(i < endIndex)
        return i + 1
    }
    
    subscript(position: Int) -> Element {
        precondition((0..<endIndex).contains(position), "out of range")
        if position < left.count {
            return left[left.count - position - 1]
        } else {
            return right[position - left.count]
        }
    }

}
