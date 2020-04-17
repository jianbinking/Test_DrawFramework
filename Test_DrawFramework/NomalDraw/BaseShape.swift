//
//  BaseShape.swift
//  Test_DrawFramework
//
//  Created by Doby on 2020/4/17.
//  Copyright © 2020 Doby. All rights reserved.
//

import UIKit

protocol DrawableProtocol {
    var size: CGSize { get }
    func draw(at rect: CGRect)
}

struct Rectangle: DrawableProtocol {
    let size: CGSize
    func draw(at rect: CGRect) {
        UIGraphicsGetCurrentContext()?.fill(size.fit(vector: .init(dx: 0.5, dy: 0.5), rect))
    }
}

struct Ellipse: DrawableProtocol {
    let size: CGSize
    func draw(at rect: CGRect) {
        UIGraphicsGetCurrentContext()?.fillEllipse(in: size.fit(vector: .init(dx: 0.5, dy: 0.5), rect))
    }
}

struct Text: DrawableProtocol {
    let str: String
    var size: CGSize {
        return .init(width: 1, height: 0.6)
    }
    func draw(at rect: CGRect) {
        
        let strAttr = NSAttributedString.init(string: str, attributes: [
            .font: UIFont.systemFont(ofSize: 12)
        ])
        let rc = strAttr.size().center(in: rect)
        strAttr.draw(in: rc)
    }
}
