//
//  DrawExtension.swift
//  Test_DrawFramework
//
//  Created by Doby on 2020/4/16.
//  Copyright © 2020 Doby. All rights reserved.
//

import Foundation
import UIKit

extension CGContext {
    func draw(bounds: CGRect, _ diagram: Diagram) {
        switch diagram {
        case .Primitive(let size, let primitive):
            let frame = size.fit(vector: .init(dx: 0.5, dy: 0.5), bounds)
            switch primitive {
            case .Ellipse:
                fillEllipse(in: frame)
            case .Rectangle:
                fill(frame)
            case .Text(let txt):
                let font = UIFont.systemFont(ofSize: 12)
                let paragraph = NSMutableParagraphStyle()
                paragraph.alignment = .center
                let strAttr = NSAttributedString.init(string: txt, attributes: [
                    .font: font,
                    .paragraphStyle: paragraph
                ])
                strAttr.draw(in: frame)
            }
        case .Beside(let l, let r):
            let (lFrame, rFrame) = bounds.split(ratio: l.size.width / diagram.size.width, edge: .minXEdge)
            draw(bounds: lFrame, l)
            draw(bounds: rFrame, r)
        case .Blow(let top, let bottom):
            let (tFrame, bFrame) = bounds.split(ratio: top.size.height / diagram.size.height, edge: .minYEdge)
            draw(bounds: tFrame, top)
            draw(bounds: bFrame, bottom)
        case .Attributed(let attr, let d):
        saveGState()
            switch attr {
            case let .FillColor(color):
                color.setFill()
            case let .StrokeColor(color):
                color.setStroke()
            }
            draw(bounds: bounds, d)
            restoreGState()
        case .Align(let v, let d):
            let frame = d.size.fit(vector: v, bounds)
            draw(bounds: frame, d)
        }
    }
}
