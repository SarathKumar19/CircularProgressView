//
//  CircularProgressView.swift
//  CircularProgressView
//
//  Created by Sarath Kumar G on 26/10/21.
//  Copyright © 2021 Sarath. All rights reserved.
//

import UIKit

class CircularProgressView: UIView {
	private var startAngle: CGFloat = 0
	private var endAngle: CGFloat = .pi * 2

	private var ringRadius: CGFloat?
	private var ringWidth: CGFloat = 10
	private var ringColor = UIColor.green
	private var ringCapStyle = CGLineCap.round

	var percent: CGFloat = 0 {
		didSet {
			self.setNeedsDisplay()
		}
	}

	var relativeCenterPoint: CGPoint {
		return self.convert(self.center, from: self.superview)
	}

	var radius: CGFloat {
		if let ringRadius = ringRadius {
			return ringRadius
		}
		return (min(self.frame.width, self.frame.height) - self.ringWidth) / 2
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		self.setDefaults()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setDefaults()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func draw(_ rect: CGRect) {
		let path = UIBezierPath(
			arcCenter: self.relativeCenterPoint,
			radius: self.radius,
			startAngle: self.startAngle,
			endAngle: (self.endAngle - self.startAngle) * (self.percent / 100) + self.startAngle,
			clockwise: true
		)
		path.lineWidth = self.ringWidth
		path.lineCapStyle = self.ringCapStyle
		self.ringColor.setStroke()
		path.stroke()
	}

	deinit {
		print("\(self.classForCoder) deinitialized")
	}
}

extension CircularProgressView {
	func setDefaults() {
		self.startAngle = -.pi / 2
		self.endAngle = self.startAngle + (.pi * 2)
		self.backgroundColor = .clear
	}

	func configure(
		ringColor: UIColor,
		ringWidth: CGFloat,
		ringCapStyle: CGLineCap,
		radius: CGFloat? = nil
	) {
		self.ringRadius = radius
		self.ringWidth = ringWidth
		self.ringColor = ringColor
		self.ringCapStyle = ringCapStyle
	}
}
