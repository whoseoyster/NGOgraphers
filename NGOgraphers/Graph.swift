//
//  Graph.swift
//  NGOgraphers
//
//  Created by Rishab Ramanathan on 7/22/17.
//  Copyright © 2017 Rishab Ramanathan. All rights reserved.
//

import UIKit

let π:CGFloat = CGFloat(Double.pi)

//class SingleGraph: UIView {
//    
//    @IBInspectable var percentage: CGFloat = 0
//    @IBInspectable var outlineColor: UIColor = UIColor.gray
//    @IBInspectable var counterColor: UIColor = UIColor.orange
//    @IBInspectable var lineWidth: CGFloat = 3.0
//    
//    var originalPath = UIBezierPath()
//    var circleLayer: CAShapeLayer!
//    
//    override func draw(_ rect: CGRect) {
//        // 1
//        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
//        
//        // 2
//        let radius: CGFloat = max(bounds.width, bounds.height)
//        
//        
//        let pathGray = UIBezierPath(arcCenter: center,
//                                    radius: radius/2 - lineWidth/2,
//                                    startAngle: π ,
//                                    endAngle: π + 2*π,
//                                    clockwise: true)
//        
//        // 6
//        pathGray.lineWidth = lineWidth
//        outlineColor.setStroke()
//        pathGray.stroke()
//        
//        // 4
//        let startAngle: CGFloat = 3*π/2
//        let endAngle: CGFloat = startAngle + percentage*2*π
//        
//        // 5
//        let path = UIBezierPath(arcCenter: center,
//                                radius: radius/2 - lineWidth/2,
//                                startAngle: startAngle,
//                                endAngle: endAngle,
//                                clockwise: true)
//        
//        // 6
//        
//        // Setup the CAShapeLayer with the path, colors, and line width
//        circleLayer = CAShapeLayer()
//        circleLayer.path = path.cgPath
//        circleLayer.fillColor = UIColor.clear.cgColor
//        circleLayer.strokeColor = counterColor.cgColor
//        circleLayer.lineWidth = lineWidth;
//        circleLayer.lineCap = kCALineCapRound
//        
//        // Don't draw the circle initially
//        circleLayer.strokeEnd = 0.0
//        
//        // Add the circleLayer to the view's layer's sublayers
//        layer.addSublayer(circleLayer)
//    }
//    
//    func animateCircle(duration: TimeInterval) {
//        // We want to animate the strokeEnd property of the circleLayer
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        
//        // Set the animation duration appropriately
//        animation.duration = duration
//        
//        // Animate from 0 (no circle) to 1 (full circle)
//        animation.fromValue = 0
//        animation.toValue = 1
//        
//        // Do a linear animation (i.e. the speed of the animation stays the same)
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//        
//        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
//        // right value when the animation ends.
//        circleLayer.strokeEnd = 1.0
//        
//        // Do the actual animation
//        circleLayer.add(animation, forKey: "animateCircle")
//    }
//}



class LinearGraph: UIView {
    
    @IBInspectable var percentage: CGFloat = 0.7
    @IBInspectable var outlineColor: UIColor = UIColor(red: (0/255), green: (158/255), blue: (194/255), alpha: 1.0)
    @IBInspectable var counterColor: UIColor = UIColor(red: (255/255), green: (184/255), blue: (0/255), alpha: 1.0)
    @IBInspectable var back_needed:Bool = true
    @IBInspectable var reverse:Bool = false
    
    var originalPath = UIBezierPath()
    var pathLayer2: CAShapeLayer!
    
    
    override func draw(_ rect: CGRect) {
        
        if back_needed {
            var path: UIBezierPath = UIBezierPath()
            path.move(to: CGPoint(x:10, y:bounds.height/2))
            path.addLine(to: CGPoint(x:bounds.width-10, y:bounds.height/2))
            
            // Create a CAShape Layer
            var pathLayer: CAShapeLayer = CAShapeLayer()
            pathLayer.frame = bounds
            pathLayer.path = path.cgPath
            pathLayer.strokeColor = outlineColor.cgColor
            pathLayer.fillColor = nil
            pathLayer.lineWidth = 15.0
            pathLayer.lineJoin = kCALineJoinBevel
            pathLayer.lineCap = kCALineCapRound
            
            // Add layer to views layer
            layer.addSublayer(pathLayer)
        }
        
        originalPath = UIBezierPath()
        if !reverse {
            originalPath.move(to: CGPoint(x:10, y:bounds.height/2))
        } else {
            originalPath.move(to: CGPoint(x:bounds.width-10, y:bounds.height/2))
        }
        
        // Create a CAShape Layer
        pathLayer2 = CAShapeLayer()
        pathLayer2.frame = bounds
        pathLayer2.strokeColor = counterColor.cgColor
        pathLayer2.fillColor = nil
        pathLayer2.lineWidth = 10.0
        pathLayer2.lineJoin = kCALineJoinBevel
        pathLayer2.lineCap = kCALineCapRound
        pathLayer2.strokeEnd = 0.0
        
        // Add layer to views layer
        layer.addSublayer(pathLayer2)
        
    }
    
    func animateLine(duration: TimeInterval) {
        
        if reverse {
            originalPath.addLine(to: CGPoint(x:bounds.width-(percentage*(bounds.width-20)+10), y:bounds.height/2))
        } else {
            originalPath.addLine(to: CGPoint(x:(percentage*(bounds.width-20)+10), y:bounds.height/2))
        }
        pathLayer2.path = originalPath.cgPath
        // Basic Animation
        var pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = duration
        pathAnimation.fromValue = NSNumber(value: 0.0)
        pathAnimation.toValue = NSNumber(value:1.0)
        
        pathLayer2.strokeEnd = 1.0
        
        // Add Animation
        pathLayer2.add(pathAnimation, forKey: "strokeEnd")
        
    }
}
