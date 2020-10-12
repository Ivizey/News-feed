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
    let country = ["ae 🇦🇪", "ar 🇦🇷", "at 🏴󠁷󠁳󠁡󠁴󠁿", "au 🇦🇺", "be 🇧🇪", "bg 🇧🇬", "br 🇧🇷", "ca 🇨🇦", "ch 🇨🇭", "cn 🇨🇳", "co 🇨🇴", "cu 🇨🇺", "cz 🇨🇿", "de 🇩🇪", "eg 🇪🇬", "fr 🇫🇷", "gb 🇬🇧", "gr 🇬🇷", "hk 🇭🇰", "hu 🇭🇺", "id 🇮🇩", "ie 🇮🇪", "il 🇮🇱", "in 🇮🇳", "it 🇮🇹", "jp 🇯🇵", "kr 🇰🇷", "lt 🇱🇹", "lv 🇱🇻", "ma 🇲🇦", "mx 🇲🇽", "my 🇲🇾", "ng 🇳🇬", "nl 🇳🇱", "no 🇳🇴", "nz 🇳🇿", "ph 🇵🇭", "pl 🇵🇱", "pt 🇵🇹", "ro 🇷🇴", "rs 🇷🇸", "ru 🇷🇺", "sa 🇸🇦", "se 🇸🇪", "sg 🇸🇬", "si 🇸🇮", "sk 🇸🇰", "th 🇹🇭", "tr 🇹🇷", "tw 🇹🇼", "ua 🇺🇦", "us 🇺🇸", "ve 🇻🇪", "za 🇿🇦"]
    let category = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }
}

extension SettingsView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return country.count
        } else {
            return category.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return country[row].uppercased()
        } else {
            return category[row]
        }
    }
}

extension SettingsView: UIPickerViewDelegate {}
