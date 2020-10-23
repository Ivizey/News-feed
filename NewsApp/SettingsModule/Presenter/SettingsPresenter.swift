//
//  SettingsPresenter.swift
//  NewsApp
//
//  Created by Pavel Bondar on 12.10.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation
// MARK: - SettingsViewPresenterProtocol
protocol SettingsViewPresenterProtocol {
    func goToPopView()
    func saveCountry(_ index: Int)
    func saveCategory(_ index: Int)
    func selectedCountry() -> Int?
    func selectedCategory() -> Int?
    var country: [String] { get }
    var category: [String] { get }
}
// MARK: - SettingsPresenter
class SettingsPresenter: SettingsViewPresenterProtocol {
    var router: RouterProtocol?
    var country: [String]
    var category: [String]
    
    required init(router: RouterProtocol) {
        self.router = router
        self.country = ["ae 🇦🇪", "ar 🇦🇷", "at 🏴󠁷󠁳󠁡󠁴󠁿", "au 🇦🇺", "be 🇧🇪", "bg 🇧🇬", "br 🇧🇷", "ca 🇨🇦", "ch 🇨🇭", "cn 🇨🇳", "co 🇨🇴", "cu 🇨🇺", "cz 🇨🇿", "de 🇩🇪", "eg 🇪🇬", "fr 🇫🇷", "gb 🇬🇧", "gr 🇬🇷", "hk 🇭🇰", "hu 🇭🇺", "id 🇮🇩", "ie 🇮🇪", "il 🇮🇱", "in 🇮🇳", "it 🇮🇹", "jp 🇯🇵", "kr 🇰🇷", "lt 🇱🇹", "lv 🇱🇻", "ma 🇲🇦", "mx 🇲🇽", "my 🇲🇾", "ng 🇳🇬", "nl 🇳🇱", "no 🇳🇴", "nz 🇳🇿", "ph 🇵🇭", "pl 🇵🇱", "pt 🇵🇹", "ro 🇷🇴", "rs 🇷🇸", "ru 🇷🇺", "sa 🇸🇦", "se 🇸🇪", "sg 🇸🇬", "si 🇸🇮", "sk 🇸🇰", "th 🇹🇭", "tr 🇹🇷", "tw 🇹🇼", "ua 🇺🇦", "us 🇺🇸", "ve 🇻🇪", "za 🇿🇦"]
        self.category = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    }
    // MARK: - go to the news feed view
    func goToPopView() {
        NotificationCenter.default.post(name: NSNotification.Name("tapApplyAction"), object: nil)
        router?.popToRoot()
    }
    // MARK: - save country setting
    func saveCountry(_ index: Int) {
        UserDefaults.standard.set(country[index], forKey: "Country")
    }
    // MARK: - save category setting
    func saveCategory(_ index: Int) {
        UserDefaults.standard.set(category[index], forKey: "Category")
    }
    // MARK: - return index of selected country
    func selectedCountry() -> Int? {
        return country.firstIndex(of: UserDefaults.standard.string(forKey: "Country") ?? "ua")
    }
    // MARK: - return index of selected category
    func selectedCategory() -> Int? {
        return category.firstIndex(of: UserDefaults.standard.string(forKey: "Category") ?? "general")
    }
}
