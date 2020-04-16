//
//  DrawView.swift
//  Test_DrawFramework
//
//  Created by Doby on 2020/4/16.
//  Copyright © 2020 Doby. All rights reserved.
//

import UIKit

class DrawView: UIView {
    let diagram: Diagram
    
    init(frame: CGRect, diagram: Diagram) {
        self.diagram = diagram
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        ctx.draw(bounds: self.bounds, diagram)
    }
}
