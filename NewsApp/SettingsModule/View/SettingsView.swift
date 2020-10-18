//
//  SettingsView.swift
//  NewsApp
//
//  Created by Pavel Bondar on 12.10.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class SettingsView: UIViewController {
    @IBOutlet private weak var countryPicker: UIPickerView!
    var presenter: SettingsViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let country = String(UserDefaults.standard.string(forKey: "Country") ?? "ua")
        let category = String(UserDefaults.standard.string(forKey: "Category") ?? "general")
        
        countryPicker.selectRow(presenter.country.firstIndex(of: country) ?? 0, inComponent: 0, animated: true)
        countryPicker.selectRow(presenter.category.firstIndex(of: category) ?? 0, inComponent: 1, animated: true)
    }
    
    @IBAction private func confirmButton(_ sender: UIButton) {
        presenter.goToPopView()
    }
}

extension SettingsView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return presenter.country.count
        } else {
            return presenter.category.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return presenter.country[row].uppercased()
        } else {
            return presenter.category[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            presenter.saveCountry(row)
        } else {
            presenter.saveCategory(row)
        }
    }
}

extension SettingsView: UIPickerViewDelegate {}
