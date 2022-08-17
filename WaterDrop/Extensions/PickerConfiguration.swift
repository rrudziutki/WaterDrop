//
//  PickerConfiguration.swift
//  WaterDrop
//
//  Created by Remigiusz Makuchowski on 08/08/2022.
//

import UIKit

//MARK: - DataSource
extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView != byPicker {
            return DatePickerData.hourArray.count
        } else {
            return DatePickerData.byMinutesArray.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView != byPicker {
            return DatePickerData.hourArray[row]
        } else {
            return "\(DatePickerData.byMinutesArray[row]) min."
        }
    }
    
}

//MARK: - Delegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == byPicker {
            minutes = DatePickerData.byMinutesArray[row]
            seconds = 0
            timerLabel.text = "\(minutes):0\(seconds)"
        }
    }
}

