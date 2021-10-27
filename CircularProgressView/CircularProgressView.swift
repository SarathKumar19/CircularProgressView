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

	var percent: CGFloat = 0 {
		didSet {
			self.setNeedsDisplay()
		}
	}

	var relativeCenterPoint: CGPoint {
		return self.convert(self.center, from: self.superview)
	}

	var radius: CGFloat {
		return min(self.frame.width, self.frame.height) / 2
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		self.setDefaults()
	}

	func setDefaults() {
		self.startAngle = -.pi / 2
		self.endAngle = self.startAngle + (.pi * 2)
		self.backgroundColor = .clear
	}

	override func draw(_ rect: CGRect) {
		let path = UIBezierPath(
			arcCenter: self.relativeCenterPoint,
			radius: 100,
			startAngle: self.startAngle,
			endAngle: (self.endAngle - self.startAngle) * (self.percent / 100) + self.startAngle,
			clockwise: true
		)
		path.lineWidth = 20
		path.lineCapStyle = .round
		UIColor.green.setStroke()
		path.stroke()
	}

	deinit {
		print("\(self.classForCoder) deinitialized")
	}
}

