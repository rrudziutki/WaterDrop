//
//  ViewController.swift
//  WaterDrop
//
//  Created by Remigiusz Makuchowski on 08/08/2022.
//

import UIKit

extension ViewController {
    
    func buildUI() {
        let layout = view.layoutMarginsGuide
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        backgroundImage = UIImageView(frame: view.frame)
        backgroundImage.image = UIImage(named: "calculate_background")
        view.addSubview(backgroundImage)
        
        droplet = UIImageView()
        droplet.image = UIImage(named: "drop")
        droplet.contentMode = .scaleAspectFill
        droplet.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(droplet)
        
        //MARK: - From
        fromTimeLabel = UILabel()
        fromTimeLabel.text = "From:"
        fromTimeLabel.font = .boldSystemFont(ofSize: 26)
        fromTimeLabel.textColor = .blueDrop
        fromTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fromTimeLabel)
        
        fromPicker = UIPickerView()
        fromPicker.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        fromPicker.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        fromPicker.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
        fromPicker.setContentCompressionResistancePriority(UILayoutPriority(1), for: .horizontal)
        fromPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fromPicker)
        
        //MARK: - To
        toTimeLabel = UILabel()
        toTimeLabel.text = "To:"
        toTimeLabel.font = .boldSystemFont(ofSize: 26)
        toTimeLabel.textColor = .blueDrop
        toTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toTimeLabel)
        
        toPicker = UIPickerView()
        toPicker.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        toPicker.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        toPicker.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
        toPicker.setContentCompressionResistancePriority(UILayoutPriority(1), for: .horizontal)
        toPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toPicker)
        
        //MARK: - By
        byTimeLabel = UILabel()
        byTimeLabel.text = "By:"
        byTimeLabel.font = .boldSystemFont(ofSize: 26)
        byTimeLabel.textColor = .blueDrop
        byTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(byTimeLabel)
        
        byPicker = UIPickerView()
        byPicker.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        byPicker.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        byPicker.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
        byPicker.setContentCompressionResistancePriority(UILayoutPriority(1), for: .horizontal)
        byPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(byPicker)
        
        //MARK: - Buttons
        startButton = {
            let button = UIButton()
            var config = UIButton.Configuration.filled()
            config.cornerStyle = .large
            config.baseBackgroundColor = .systemCyan
            config.title = "START"
            button.addAction(
                UIAction { _ in
                    self.isCounting = true
                }, for: .touchUpInside)
            button.configurationUpdateHandler = { [unowned self] button in
                var config = button.configuration
                config?.title = !self.isCounting ? "START" : "Started..."
                button.isEnabled = !self.isCounting
                button.configuration = config
            }
            button.translatesAutoresizingMaskIntoConstraints = false
            button.configuration = config
            return button
        }()
        view.addSubview(startButton)
        
        stopButton = {
            let button = UIButton()
            var config = UIButton.Configuration.filled()
            config.cornerStyle = .large
            config.baseBackgroundColor = .systemRed
            config.title = "STOP"
            button.addAction(
                UIAction { _ in
                    self.isCounting = false
                }, for: .touchUpInside)
            button.configurationUpdateHandler = { [unowned self] button in
                let config = button.configuration
                button.isEnabled = self.isCounting
                button.configuration = config
            }
            button.translatesAutoresizingMaskIntoConstraints = false
            button.configuration = config
            return button
        }()
        view.addSubview(stopButton)
        
        //MARK: - Constraint
        NSLayoutConstraint.activate([
            droplet.widthAnchor.constraint(lessThanOrEqualToConstant: screenWidth * 0.2),
            droplet.heightAnchor.constraint(lessThanOrEqualToConstant: screenHeight * 0.2),
            
            droplet.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
            droplet.topAnchor.constraint(equalTo: layout.topAnchor),
            
            fromTimeLabel.centerXAnchor.constraint(equalTo: fromPicker.centerXAnchor),
            fromTimeLabel.topAnchor.constraint(equalTo: droplet.bottomAnchor, constant: 20),
            
            fromPicker.rightAnchor.constraint(equalTo: layout.centerXAnchor),
            fromPicker.leftAnchor.constraint(equalTo: layout.leftAnchor),
            fromPicker.topAnchor.constraint(equalTo: fromTimeLabel.bottomAnchor),
            fromPicker.bottomAnchor.constraint(equalTo: byTimeLabel.topAnchor),
            
            toTimeLabel.leftAnchor.constraint(equalTo: layout.centerXAnchor, constant: screenWidth * 0.2),
            toTimeLabel.topAnchor.constraint(equalTo: droplet.bottomAnchor, constant: 20),
            
            toPicker.rightAnchor.constraint(equalTo: layout.rightAnchor),
            toPicker.leftAnchor.constraint(equalTo: layout.centerXAnchor),
            toPicker.topAnchor.constraint(equalTo: toTimeLabel.bottomAnchor),
            toPicker.bottomAnchor.constraint(equalTo: byTimeLabel.topAnchor),
            
            byTimeLabel.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
            byTimeLabel.centerYAnchor.constraint(equalTo: layout.centerYAnchor, constant: screenHeight * 0.05),
            
            byPicker.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
            byPicker.topAnchor.constraint(equalTo: byTimeLabel.bottomAnchor),
            byPicker.bottomAnchor.constraint(equalTo: startButton.topAnchor ,constant: -10),
            
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.heightAnchor.constraint(equalToConstant: 44),
            startButton.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 10),
            startButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -10),
            
            stopButton.widthAnchor.constraint(equalToConstant: 100),
            stopButton.heightAnchor.constraint(equalToConstant: 44),
            stopButton.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -10),
            stopButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -10),
        ])
    }
}
