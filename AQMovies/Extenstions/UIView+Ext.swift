//
//  UIView+Ext.swift
//  AQMovies
//
//  Created by Ali on 2/26/22.
//

import UIKit

extension UIView
{
    func gradient(gradientLayer: CAGradientLayer  = CAGradientLayer(), colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint, opacity: Float, location: [NSNumber]?) {
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.opacity = opacity
        gradientLayer.locations = location
        layer.addSublayer(gradientLayer)
    }
}
