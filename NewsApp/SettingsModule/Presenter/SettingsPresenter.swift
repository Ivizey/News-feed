//
//  SettingsPresenter.swift
//  NewsApp
//
//  Created by Pavel Bondar on 12.10.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

protocol SettingsViewPresenterProtocol {
    func goToPopView()
    func saveCountry(_ index: Int)
    func saveCategory(_ index: Int)
    var country: [String] { get set }
    var category: [String] { get set }
}

class SettingsPresenter: SettingsViewPresenterProtocol {
    var router: RouterProtocol?
    var defaults: UserDefaults
    var country: [String]
    var category: [String]
    
    required init(router: RouterProtocol, defaults: UserDefaults) {
        self.router = router
        self.defaults = defaults
        self.country = ["ae 🇦🇪", "ar 🇦🇷", "at 🏴󠁷󠁳󠁡󠁴󠁿", "au 🇦🇺", "be 🇧🇪", "bg 🇧🇬", "br 🇧🇷", "ca 🇨🇦", "ch 🇨🇭", "cn 🇨🇳", "co 🇨🇴", "cu 🇨🇺", "cz 🇨🇿", "de 🇩🇪", "eg 🇪🇬", "fr 🇫🇷", "gb 🇬🇧", "gr 🇬🇷", "hk 🇭🇰", "hu 🇭🇺", "id 🇮🇩", "ie 🇮🇪", "il 🇮🇱", "in 🇮🇳", "it 🇮🇹", "jp 🇯🇵", "kr 🇰🇷", "lt 🇱🇹", "lv 🇱🇻", "ma 🇲🇦", "mx 🇲🇽", "my 🇲🇾", "ng 🇳🇬", "nl 🇳🇱", "no 🇳🇴", "nz 🇳🇿", "ph 🇵🇭", "pl 🇵🇱", "pt 🇵🇹", "ro 🇷🇴", "rs 🇷🇸", "ru 🇷🇺", "sa 🇸🇦", "se 🇸🇪", "sg 🇸🇬", "si 🇸🇮", "sk 🇸🇰", "th 🇹🇭", "tr 🇹🇷", "tw 🇹🇼", "ua 🇺🇦", "us 🇺🇸", "ve 🇻🇪", "za 🇿🇦"]
        self.category = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    }
    
    func goToPopView() {
        NotificationCenter.default.post(name: NSNotification.Name("tapApplyAction"), object: nil)
        router?.popToRoot()
    }
    
    func saveCountry(_ index: Int) {
        defaults.set(country[index], forKey: "Country")
    }
    
    func saveCategory(_ index: Int) {
        defaults.set(category[index], forKey: "Category")
    }
}
