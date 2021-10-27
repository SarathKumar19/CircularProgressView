//
//  ViewController.swift
//  CircularProgressView
//
//  Created by Sarath Kumar G on 26/10/21.
//  Copyright © 2021 Sarath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	private var timer: Timer?
	private var circularProgressView: CircularProgressView!
	private var controlButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		self.addProgressView()
		self.addProgressControlButton()
	}

	deinit {
		print("\(self.classForCoder) deinitialized")
	}
}

private extension ViewController {
	func addProgressView() {
		self.circularProgressView = CircularProgressView(frame: self.view.bounds)
		self.circularProgressView.backgroundColor = .clear
		self.circularProgressView.setDefaults()
		self.view.addSubview(self.circularProgressView)
	}

	func addProgressControlButton() {
		let button = UIButton()
		button.isSelected = false
		button.backgroundColor = .systemBlue
		button.setTitle("Play", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = 5
		button.addTarget(
			self,
			action: #selector(self.handleControlButtonTap),
			for: .touchUpInside
		)
		self.controlButton = button
		self.view.addSubview(self.controlButton)

		self.circularProgressView.translatesAutoresizingMaskIntoConstraints = false
		self.controlButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.controlButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
			self.controlButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.controlButton.widthAnchor.constraint(equalToConstant: 100),
			self.controlButton.heightAnchor.constraint(equalToConstant: 44)
		])
	}

	func addTimer() {
		self.timer = Timer.scheduledTimer(
			timeInterval: 0.1,
			target: self,
			selector: #selector(self.incrementProgressValue),
			userInfo: nil,
			repeats: true
		)
		self.timer?.fire()
	}

	func resetTimer() {
		timer?.invalidate()
		timer = nil
	}
}

@objc private extension ViewController {
	func handleControlButtonTap() {
		if self.controlButton.isSelected {
			self.resetTimer()
			self.controlButton.setTitle("Play", for: .normal)
		} else {
			self.addTimer()
			self.controlButton.setTitle("Pause", for: .normal)
		}
		self.controlButton.isSelected.toggle()
	}

	func incrementProgressValue() {
		guard self.circularProgressView.percent < 100 else {
			self.circularProgressView.percent = 0
			self.circularProgressView.setDefaults()
			self.handleControlButtonTap()
			self.resetTimer()
			return
		}
		self.circularProgressView.percent += 1
	}
}
