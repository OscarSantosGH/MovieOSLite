//
//  MODetailsCurveShapeView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 4/15/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MODetailsCurveShapeView: UIView {

    var curveLayer = CAShapeLayer()
    let bezierPath = UIBezierPath()
    var oldPath:CGPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawShape(){
            layoutIfNeeded()
            self.layer.sublayers?.removeAll()
            createShapeLayer()
    }
    
    private func createShapeLayer(){
        bezierPath.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        bezierPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        bezierPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        bezierPath.addCurve(to: CGPoint(x: bounds.minX + 0.5 * bounds.width, y: bounds.minY + 0.8 * bounds.height), controlPoint1: CGPoint(x: bounds.maxX, y: bounds.minY), controlPoint2: CGPoint(x: bounds.minX + 0.76 * bounds.width, y: bounds.minY + 0.8 * bounds.height))
        bezierPath.addCurve(to: CGPoint(x: bounds.minX, y: bounds.minY), controlPoint1: CGPoint(x: bounds.minX + 0.2 * bounds.width, y: bounds.minY + 0.8 * bounds.height), controlPoint2: CGPoint(x: bounds.minX, y: bounds.minY))
        bezierPath.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        bezierPath.close()
        
        curveLayer.path = bezierPath.cgPath
        curveLayer.fillColor = UIColor.systemBackground.cgColor
        oldPath = curveLayer.path
        self.layer.addSublayer(curveLayer)
    }
    
    
    func animateShape(value:CGFloat, offsetStop:CGFloat){
        let positiveVal = value < 0 ? 0 : value
        let offsetPos = positiveVal > offsetStop ? 1 : positiveVal / offsetStop
        let reverse = (offsetPos - 1) * -1
        let progress = reverse * 0.8
        let bezierPath2 = UIBezierPath()
        bezierPath2.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        bezierPath2.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        bezierPath2.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        bezierPath2.addCurve(to: CGPoint(x: bounds.minX + 0.5 * bounds.width, y: bounds.minY + progress * bounds.height), controlPoint1: CGPoint(x: bounds.maxX, y: bounds.minY), controlPoint2: CGPoint(x: bounds.minX + 0.76 * bounds.width, y: bounds.minY + progress * bounds.height))
        bezierPath2.addCurve(to: CGPoint(x: bounds.minX, y: bounds.minY), controlPoint1: CGPoint(x: bounds.minX + 0.2 * bounds.width, y: bounds.minY + progress * bounds.height), controlPoint2: CGPoint(x: bounds.minX, y: bounds.minY))
        bezierPath2.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        bezierPath2.close()
        
        let basicAnim = CABasicAnimation(keyPath: "path")
        basicAnim.isRemovedOnCompletion = false
        basicAnim.fillMode = CAMediaTimingFillMode.forwards
        basicAnim.duration = 0.2
        basicAnim.fromValue = oldPath
        basicAnim.toValue = bezierPath2.cgPath
        
        oldPath = bezierPath2.cgPath
        curveLayer.add(basicAnim, forKey: "myPath")
    }

}
