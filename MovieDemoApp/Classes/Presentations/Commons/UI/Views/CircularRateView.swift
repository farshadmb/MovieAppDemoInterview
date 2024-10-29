//
//  CircularRateView.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/29/24.
//

import Foundation
import UIKit
import PureLayout

@IBDesignable
class CircularRateView: UIView {
    
    @IBInspectable
    var lineWidth: Float = 8 {
        didSet {
            let width = CGFloat(lineWidth)
            backgroundCircleLayer.lineWidth = width
            valueCircleLayer.lineWidth = width
        }
    }
    
    var lineColor = UIColor(rgb: 0x34C759) {
        didSet {
            backgroundCircleLayer.strokeColor = lineColor.cgColor
            valueCircleLayer.strokeColor = lineColor.cgColor
            valueLabel.textColor = lineColor
        }
    }
    
    @IBInspectable
    var rate: Double = 0 {
        didSet {
            valueLabel.text = formatNumber(number: rate)
            valueCircleLayer.strokeEnd = rate / maxRate
        }
    }
    
    var maxRate: Double = 10.0 {
        didSet {
            valueCircleLayer.strokeEnd = rate / maxRate
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
    
    private var backgroundCircleLayer = CAShapeLayer()
    
    private var valueCircleLayer = CAShapeLayer()
    
    private var valueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCircularLayers()
    }
    
    private func setup() {
        setupLabel()
        setupLayers()
    }
    
    private func setupLabel() {
        addSubview(valueLabel)
        valueLabel.textColor = lineColor
        valueLabel.textAlignment = .center
        valueLabel.text = formatNumber(number: rate)
        valueLabel.autoCenterInSuperview()
    }
    
    private func setupLayers() {
        backgroundCircleLayer.strokeColor = lineColor.cgColor
        backgroundCircleLayer.lineWidth = CGFloat(lineWidth)
        backgroundCircleLayer.opacity = 0.3
        backgroundCircleLayer.fillColor = UIColor.clear.cgColor
        backgroundCircleLayer.strokeStart = 0
        backgroundCircleLayer.strokeEnd = 1
        layer.addSublayer(backgroundCircleLayer)
        
        valueCircleLayer.strokeColor = lineColor.cgColor
        valueCircleLayer.lineWidth = CGFloat(lineWidth)
        valueCircleLayer.lineCap = .round
        valueCircleLayer.lineJoin = .round
        valueCircleLayer.fillColor = UIColor.clear.cgColor
        valueCircleLayer.strokeStart = 0
        valueCircleLayer.strokeEnd = rate / maxRate
        
        layer.addSublayer(valueCircleLayer)
    }
    
    private func updateCircularLayers() {
        // get the self coordinate
        let frame = bounds
        let cornerRadius = min(frame.width, frame.height) / 2
        let path = UIBezierPath(roundedRect: frame, cornerRadius: cornerRadius)
        
        valueCircleLayer.frame = frame
        backgroundCircleLayer.frame = frame
        
        valueCircleLayer.path = path.cgPath
        backgroundCircleLayer.path = path.cgPath
    }
    
    private func formatNumber(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        // Optional: Customize the formatter further
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current

        let formattedNumber = formatter.string(from: NSNumber(value: number)) ?? "\(number)"
        return formattedNumber
    }
    
}
