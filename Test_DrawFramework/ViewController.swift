//
//  ViewController.swift
//  Test_DrawFramework
//
//  Created by Doby on 2020/4/16.
//  Copyright © 2020 Doby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let cities = [
            ("上海", 14.01),
            ("北京", 13.3),
            ("郑州", 10.53),
            ("焦作", 7.33),
            ("深圳", 20),
            ("广州", 16.3)
        ]
        
        let ex = Diagram.barGraph(input: cities)
        
        let dw = DrawView.init(frame: .init(x: 50, y: 100, width: 200, height: 200), diagram: ex)
        dw.backgroundColor = .yellow
        self.view.addSubview(dw)
        
        let ex2 = Diagram.vGraph(input: cities)
        
        var blue = Diagram.square(side: 3).fill(color: .blue)
        var red = Diagram.rect(width: 3, height: 5).fill(color: .red)
        red = red.appendBottom(Diagram.circle(diameter: 2).fill(color: .purple).alignTop())
        var circle = Diagram.circle(diameter: 2).fill(color: .green)
        let ex3 = Diagram.hcat(diagrams: [blue, red, circle])
        
        let dw2 = DrawView.init(frame: .init(x: 50, y: 350, width: 200, height: 200), diagram: ex3)
        dw2.backgroundColor = .yellow
        self.view.addSubview(dw2)
        
    }


}

