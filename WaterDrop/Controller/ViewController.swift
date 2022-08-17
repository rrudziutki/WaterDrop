//
//  ViewController.swift
//  WaterDrop
//
//  Created by Remigiusz Makuchowski on 04/08/2022.
//

import UIKit

class ViewController: UIViewController {
    var backgroundImage: UIImageView!
    var droplet: UIImageView!
    //MARK: - Timer
    var timer: Timer!
    var timerLabel: UILabel!
    var minutes = 15
    var seconds = 0
    //MARK: - Time Labels
    var fromTimeLabel: UILabel!
    var toTimeLabel: UILabel!
    var byTimeLabel: UILabel!
    //MARK: - Time Pickers
    var fromPicker: UIPickerView!
    var toPicker: UIPickerView!
    var byPicker: UIPickerView!
    //MARK: - Buttons
    var startButton: UIButton!
    var stopButton: UIButton!
    var isCounting = false {
        didSet {
            startButton.setNeedsUpdateConfiguration()
            stopButton.setNeedsUpdateConfiguration()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buildUI()
        fromPicker.delegate = self; toPicker.delegate = self ; byPicker.delegate = self
        fromPicker.dataSource = self; toPicker.dataSource = self ; byPicker.dataSource = self
        
        fromPicker.selectRow(8, inComponent: 0, animated: true)
        toPicker.selectRow(16, inComponent: 0, animated: true)
        byPicker.selectRow(2, inComponent: 0, animated: true)
    }
}
