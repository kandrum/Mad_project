//
//  GradientView.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/16/23.
//

import UIKit

class GradientView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(red: 0.4627, green: 0.8392, blue: 1.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        // Add the gradient layer to the view's layer
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
