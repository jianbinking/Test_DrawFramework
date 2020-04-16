//
//  SnakeDrawView.swift
//  Test_DrawFramework
//
//  Created by Doby on 2020/4/16.
//  Copyright © 2020 Doby. All rights reserved.
//

import UIKit

class SnakeDrawView: UIView {
    
    var snake: Snake
    let scale: CGFloat
    
    var food: CGPoint
    
    var timer: Timer?
    
    var fail = true
    let btnStart: UIButton
    
    init(frame: CGRect, scale: CGFloat = 10) {
        self.scale = scale
        let head = CGPoint.init(x: frame.width / 2, y: frame.height / 2)
        self.snake = Snake.init(scale: scale, head: head, length: 3)
        self.food = head.next(direc: .right, scale: scale * 3)
        self.btnStart = UIButton.init(type: .custom)
        super.init(frame: frame)
        self.backgroundColor = .yellow
        
        for i in 0..<4 {
            let direc = Direction.init(rawValue: i)!
            let btn = UIButton(type: .system)
            btn.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
            var rc = CGRect.init(x: 0, y: 0, width: frame.width / 3, height: frame.height / 3)
            switch direc {
            case .up:
                rc.origin = .init(x: rc.width, y: 0)
            case .down:
                rc.origin = .init(x: rc.width, y: frame.height - rc.height)
            case .left:
                rc.origin = .init(x: 0, y: rc.height)
            case .right:
                rc.origin = .init(x: frame.width - rc.width, y: rc.height)
            }
            btn.frame = rc
            self.addSubview(btn)
            btn.tag = i
            btn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
        self.btnStart.frame = self.bounds
        self.btnStart.setTitle("开始", for: .normal)
        self.btnStart.setTitleColor(.blue, for: .normal)
        self.btnStart.addTarget(self, action: #selector(startBtnTapped), for: .touchUpInside)
        self.addSubview(self.btnStart)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let ctx = UIGraphicsGetCurrentContext() {
                        
            //画蛇
            ctx.saveGState()
            UIColor.green.setFill()
            ctx.addPath(snake.bodyPath)
            ctx.fillPath()
            ctx.restoreGState()
            //画吃的
            ctx.saveGState()
            UIColor.red.setFill()
            ctx.addPath(UIBezierPath.init(rect: CGRect.init(origin: food, size: CGSize.init(width: scale, height: scale)).offsetBy(dx: -scale / 2, dy: -scale / 2)).cgPath)
            ctx.fillPath()
            ctx.restoreGState()
            
            UIColor.black.setStroke()
            
            self.addLines(ctx: ctx, isHorizonal: true, from: rect.midY + scale / 2, to: rect.maxY, by: self.scale)
            self.addLines(ctx: ctx, isHorizonal: true, from: rect.midY - scale / 2, to: rect.minY, by: -self.scale)
            self.addLines(ctx: ctx, isHorizonal: false, from: rect.midX + scale / 2, to: rect.maxX, by: self.scale)
            self.addLines(ctx: ctx, isHorizonal: false, from: rect.midX - scale / 2, to: rect.minX, by: -self.scale)
            
            ctx.strokePath()
            
        }
    }
    
    private func addLines(ctx: CGContext, isHorizonal: Bool, from: CGFloat, to: CGFloat, by: CGFloat) {
        for p in stride(from: from, to: to, by: by) {
            if isHorizonal {
                ctx.move(to: .init(x: 0, y: p))
                ctx.addLine(to: CGPoint.init(x: self.bounds.maxX, y: p))
            } else {
                ctx.move(to: .init(x: p, y: 0))
                ctx.addLine(to: CGPoint.init(x: p, y: self.bounds.maxY))
            }
        }
    }
    
    @objc func buttonTapped(_ btn: UIButton) {
        
        let direc = Direction.init(rawValue: btn.tag)!
        self.move(to: direc)
    }
    
    @objc func startBtnTapped() {
        fail = false
        self.btnStart.isHidden = true
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {
            [unowned self] timer in
            self.move(to: nil)
        })
    }
    
    private func move(to: Direction? = nil) {
        
        guard !fail else {
            return
        }
        
        
        var eat = false
        let nextPos = self.snake.nextStep
        
        if snake.isPositionInBody(nextPos) || !self.bounds.contains(nextPos) {
            fail = true
            self.timer?.invalidate()
            self.timer = nil
            self.btnStart.isHidden = false
            return
        }
        
        if nextPos == food {
            eat = true
            food = self.radomFood()
        }
        
        self.snake.move(changeDirection: to, eat: eat)
        self.setNeedsDisplay()
    }
    
    private func radomFood() -> CGPoint {
        
        let xabs = Int.random(in: 0...1) == 1 ? 1 : -1
        let yabs = Int.random(in: 0...1) == 1 ? 1 : -1
        let xoff = Int.random(in: 0...Int(self.bounds.width / 2 / scale))
        let yoff = Int.random(in: 0...Int(self.bounds.width / 2 / scale))
        
        let fd = CGPoint.init(x: CGFloat(xabs * xoff) * scale + self.bounds.midX, y: CGFloat(yabs * yoff) * scale + self.bounds.midY)
        if fd == food {
            return self.radomFood()
        }
        return fd
    }
    
}
