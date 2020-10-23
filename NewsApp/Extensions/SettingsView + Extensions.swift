//
//  SettingsView + Extensions.swift
//  NewsApp
//
//  Created by Pavel Bondar on 23.10.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

// MARK: - UIPickerViewDataSource
extension SettingsView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return presenter.country.count
        default: return presenter.category.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return presenter.country[row].uppercased()
        default: return presenter.category[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: presenter.saveCountry(row)
        default: presenter.saveCategory(row)
        }
    }
}

// MARK: - UIPickerViewDelegate
extension SettingsView: UIPickerViewDelegate {}
