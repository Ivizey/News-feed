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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // MARK: - select rows in the view picker
        countryPicker.selectRow(presenter.selectedCountry() ?? 0, inComponent: 0, animated: true)
        countryPicker.selectRow(presenter.selectedCategory() ?? 0, inComponent: 1, animated: true)
    }
    
    @IBAction private func confirmButton(_ sender: UIButton) {
        // MARK: - go to the news feed view
        presenter.goToPopView()
    }
}
