//
//  CGSize+Extension.swift
//  Test_DrawFramework
//
//  Created by Doby on 2020/4/16.
//  Copyright © 2020 Doby. All rights reserved.
//

import Foundation
import UIKit


func *(l: CGFloat, r:CGSize) -> CGSize {
    return .init(width: l * r.width, height: l * r.height)
}

func /(l: CGSize, r: CGSize) -> CGSize {
    return .init(width: l.width / r.width, height: l.height / r.height)
}

func * (l: CGSize, r: CGSize) -> CGSize {
    return .init(width: l.width * r.width, height: l.height * r.height)
}

func - (l: CGSize, r: CGSize) -> CGSize {
    return .init(width: l.width - r.width, height: l.height - r.height)
}

func - (l: CGPoint, r: CGPoint) -> CGPoint {
    return .init(x: l.x - r.x, y: l.y - r.y)
}

extension CGSize {
    var point: CGPoint {
        return .init(x: width, y: height)
    }
    
    func fit(vector: CGVector, _ rect: CGRect) -> CGRect {
        let scaleSize = rect.size / self
        let scale = min(scaleSize.width, scaleSize.height)
        let size = scale * self
        let space = vector.size * (size - rect.size)
        return .init(origin: rect.origin - space.point, size: size)
    }
    
    func center(in rect: CGRect, xoff: CGFloat = 0, yoff: CGFloat = 0) -> CGRect {
        var rc = CGRect.init(x: rect.midX - width / 2, y: rect.midY - height / 2, width: width, height: height)
        rc.origin.x += xoff / 2
        rc.origin.y += yoff / 2
        return rc
    }
}

extension CGVector {
    var point: CGPoint {
        return .init(x: dx, y: dy)
    }
    var size: CGSize {
        return .init(width: dx, height: dy)
    }
}

extension CGRectEdge {
    var isHorizontal: Bool {
        return self == .maxXEdge || self == .minXEdge
    }
}

extension CGRect {
    func split(ratio: CGFloat, edge: CGRectEdge) -> (CGRect, CGRect) {
        let length = edge.isHorizontal ? width : height
        return divided(atDistance: length * ratio, from: edge)
    }
}
