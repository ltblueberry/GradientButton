//
//  GradientButton.swift
//  GradientButton
//
//  Created by ltblueberry on 06/08/2019.
//  Copyright © 2019 ltblueberry. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class GradientButton: UIButton {
    // MARK: Public Properties

    /// This property is used to set the font label
    public var buttonFont: UIFont {
        return UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }

    /// This property is used to set title color
    public var foregroundColor: UIColor {
        return UIColor.white
    }

    /// This property is used to set left gradient color of the button
    public var topColor: UIColor {
        return UIColor.blue
    }

    /// This property is used to set default right gradient color of the button
    public var bottomColor: UIColor {
        return UIColor.blue
    }

    public var glowingColor: UIColor {
        return UIColor.blue
    }

    // MARK: Private Properties

    /// Glowing
    private var glowingLayer: CAShapeLayer!
    private var glowingOpacity: Float = 0.35
    private var glowingRadius: CGFloat = 10.0

    // MARK: Initialization and deinitialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyStyle()
    }

    // MARK: NSObject UIKit Additions

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyStyle()
    }

    // MARK: Private Methods

    private func applyStyle() {
        titleLabel?.font = buttonFont
        setTitleColor(foregroundColor, for: .normal)
        applyGradient()
        applyGlowing()
    }

    private func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.cornerRadius = 8.0
        gradientLayer.masksToBounds = true
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        
        layer.insertSublayer(gradientLayer, at: 0)
    }

    private func applyGlowing() {
        if glowingLayer != nil {
            glowingLayer.removeFromSuperlayer()
        }
        glowingLayer = CAShapeLayer()

        let cornerRadius = layer.cornerRadius
        glowingLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        glowingLayer.fillColor = backgroundColor?.cgColor

        glowingLayer.shadowColor = glowingColor.cgColor
        glowingLayer.shadowPath = glowingLayer.path
        glowingLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        glowingLayer.shadowOpacity = glowingOpacity
        glowingLayer.shadowRadius = glowingRadius

        layer.insertSublayer(glowingLayer, at: 0)
    }

    // MARK: - Public Methods

    public func enable() {
        isEnabled = true
        alpha = 1.0
    }

    public func disable() {
        isEnabled = false
        alpha = 0.15
    }
}
