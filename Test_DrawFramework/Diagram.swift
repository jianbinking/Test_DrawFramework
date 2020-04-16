import Foundation
import UIKit

extension Sequence where Element == CGFloat {
    /// 等比缩小，最小值为1
    func normalize() -> [CGFloat] {
        let maxVal = self.reduce(0) { (r, n) -> CGFloat in
            return CGFloat.maximum(r, n)
        }
        return self.map { $0 / maxVal }
    }
}

/// 图形属性
enum Attribute {
    case FillColor(UIColor)
    case StrokeColor(UIColor)
}

/// 基本形状
enum Primitive {
    case Ellipse
    case Rectangle
    case Text(String)
}

/// 图标本体
indirect enum Diagram {
    case Primitive(CGSize, Primitive)//基本图形
    case Beside(Diagram, Diagram)//横向
    case Blow(Diagram, Diagram)//纵向
    case Attributed(Attribute, Diagram)//属性
    case Align(CGVector, Diagram)//对齐
}

extension Diagram {
    /// 图标大小
    var size: CGSize {
        switch self {
        case .Primitive(let size, _):
            return size
        case .Beside(let l, let r):
            return .init(width: l.size.width + r.size.width, height: max(l.size.height, r.size.height))
        case .Blow(let t, let b):
            return .init(width: max(t.size.width, b.size.width), height: t.size.height + b.size.height)
        case .Attributed(_, let x):
            return x.size
        case .Align(_, let x):
            return x.size
        }
    }
}

/// 空图形
private let empty: Diagram = .Primitive(.zero, .Rectangle)

extension Diagram {

    static func rect(width: CGFloat, height: CGFloat) -> Diagram {
        return .Primitive(.init(width: width, height: height), .Rectangle)
    }

    static func circle(diameter: CGFloat) -> Diagram {
        return .Primitive(.init(width: diameter, height: diameter), .Ellipse)
    }

    static func text(txt: String, width: CGFloat, height: CGFloat) -> Diagram {
        return .Primitive(.init(width: width, height: height), .Text(txt))
    }

    static func square(side: CGFloat) -> Diagram {
        return rect(width: side, height: side)
    }
    
    /// 横向链接
    /// - Parameter diagrams: 要连接的图形数组
    static func hcat(diagrams: [Diagram]) -> Diagram {
        return diagrams.reduce(empty, { $0.appendRight($1) })
    }
    
    /// 纵向连接
    /// - Parameter diagrams: 要连接的图形数组
    static func vcat(diagrams: [Diagram]) -> Diagram {
        return diagrams.reduce(empty, { $0.appendBottom($1) })
    }
    
}

extension Diagram {
    static func barGraph(input:[(String, Double)]) -> Diagram {
        let nValues = input.map {CGFloat($0.1)}.normalize()
        let bars = self.hcat(diagrams: nValues.map {
            value in
            return Diagram.rect(width: 1, height: CGFloat(input.count) * value).fill(color: .green).stroke(color: .black).alignBottom()
        })
        let labels = self.hcat(diagrams: input.map {
            pairs in
            return Diagram.text(txt: pairs.0, width: 1, height: 0.6).stroke(color: .red).alignTop()
        })
        
        return bars.appendBottom(labels).alignBottom()
    }
    
    static func vGraph(input:[(String, Double)]) -> Diagram {
        let nValues = input.map {CGFloat($0.1)}.normalize()
        let bars = self.vcat(diagrams: nValues.map {
            value in
            return Diagram.rect(width: CGFloat(input.count) * value, height: 1).fill(color: .green).stroke(color: .black).alignRight()
        })
        let labels = self.vcat(diagrams: input.map {
            pairs in
            return Diagram.text(txt: pairs.0, width: 1.5, height: 1).stroke(color: .red).alignBottom()
        })
        
        return bars.appendRight(labels).alignRight()
    }
}

///形变扩展
extension Diagram {
    func fill(color: UIColor) -> Diagram {
        return .Attributed(.FillColor(color), self)
    }
    
    func stroke(color: UIColor) -> Diagram {
        return .Attributed(.StrokeColor(color), self)
    }
    
    func alignTop() -> Diagram {
        return .Align(.init(dx: 0.5, dy: 0), self)
    }
    
    func alignBottom() -> Diagram {
        return .Align(.init(dx: 0.5, dy: 1), self)
    }
    
    func alignRight() -> Diagram {
        return .Align(.init(dx: 1, dy: 0.5), self)
    }
    
    func alignLeft() -> Diagram {
        return .Align(.init(dx: 0, dy: 0.5), self)
    }
    
    func appendRight(_ r: Diagram) -> Diagram {
        return .Beside(self, r)
    }
    
    func appendLeft(_ l: Diagram) -> Diagram {
        return .Beside(l, self)
    }
    
    func appendTop(_ t: Diagram) -> Diagram {
        return .Blow(t, self)
    }
    
    func appendBottom(_ b: Diagram) -> Diagram {
        return .Blow(self, b)
    }
    
}



