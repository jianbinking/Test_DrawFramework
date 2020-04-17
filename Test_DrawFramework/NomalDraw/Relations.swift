//
//  Relations.swift
//  Test_DrawFramework
//
//  Created by Doby on 2020/4/17.
//  Copyright © 2020 Doby. All rights reserved.
//

import UIKit

infix operator |||: AdditionPrecedence
infix operator ---: AdditionPrecedence


func ||| (l: DrawableProtocol, r: DrawableProtocol) -> DrawableProtocol {
    return RelationBeside.init(left: l, right: r)
}

func --- (t: DrawableProtocol, b: DrawableProtocol) -> DrawableProtocol {
    return RelationBlow.init(top: t, bottom: b)
}

extension DrawableProtocol {
    
    func fill(_ color: UIColor) -> DrawableProtocol {
        return RelationAttribute.init(backgroundColor: color, element: self)
    }
    
    func align(_ vector: CGVector) -> DrawableProtocol {
        return RelationAlign.init(vector: vector, element: self)
    }
    
}

struct RelationBeside: DrawableProtocol {
    let left: DrawableProtocol
    let right: DrawableProtocol
    
    var size: CGSize {
        return .init(width: left.size.width + right.size.width, height: max(left.size.height, right.size.height))
    }
    
    func draw(at rect: CGRect) {
        let (lFrame, rFrame) = rect.split(ratio: left.size.width / size.width, edge: .minXEdge)
        left.draw(at: lFrame)
        right.draw(at: rFrame)
    }
}

struct RelationBlow: DrawableProtocol {
    let top: DrawableProtocol
    let bottom: DrawableProtocol
    var size: CGSize {
        return .init(width: max(top.size.width, bottom.size.width), height: top.size.height + bottom.size.height)
    }
    
    func draw(at rect: CGRect) {
        let (tFrame, bFrame) = rect.split(ratio: top.size.height / size.height, edge: .minYEdge)
        top.draw(at: tFrame)
        bottom.draw(at: bFrame)
    }
}

struct RelationAttribute: DrawableProtocol {
    let backgroundColor: UIColor
    let element: DrawableProtocol
    
    var size: CGSize {
        return element.size
    }
    
    func draw(at rect: CGRect) {
        if let ctx = UIGraphicsGetCurrentContext() {

            ctx.saveGState()
            ctx.setFillColor(backgroundColor.cgColor)
            element.draw(at: rect)
            ctx.restoreGState()
        }
    }
}

struct RelationAlign: DrawableProtocol {
    let vector: CGVector
    let element: DrawableProtocol
    
    var size: CGSize {
        return element.size
    }
    
    func draw(at rect: CGRect) {
        element.draw(at: size.fit(vector: vector, rect))
    }
}
