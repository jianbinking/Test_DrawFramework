//
//  OtherDrawView.swift
//  Test_DrawFramework
//
//  Created by Doby on 2020/4/17.
//  Copyright © 2020 Doby. All rights reserved.
//

import UIKit

class OtherDrawView: UIView {
    
    let drawable: DrawableProtocol
    
    init(drawable: DrawableProtocol, frame: CGRect) {
        self.drawable = drawable
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawable.draw(at: rect)
    }
}
