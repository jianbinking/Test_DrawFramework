//
//  SnakeDrawView.swift
//  Test_DrawFramework
//
//  Created by Doby on 2020/4/16.
//  Copyright © 2020 Doby. All rights reserved.
//

import UIKit

class SnakeDrawView: UIView {
    
    let snake: Snake
    
    init(snake: Snake, frame: CGRect) {
        self.snake = snake
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let ctx = UIGraphicsGetCurrentContext() {
            
            //hline
            for x in 0 ..< Int(rect.width) {
                ctx.move(to: .init(x: x, y: 0))
                ctx.addLine(to: CGPoint.init(x: CGFloat(x), y: rect.height))
            }
            for y in 0 ..< Int(rect.height) {
                ctx.move(to: .init(x: 0, y: y))
                ctx.addLine(to: CGPoint.init(x: rect.width, y: CGFloat(y)))
            }
            
            
            ctx.saveGState()
            
            UIColor.green.setFill()
            
            
            
            ctx.restoreGState()
            
            UIColor.white.setFill()
            UIColor.black.setStroke()
            ctx.strokePath()
            
        }
    }
    
}
