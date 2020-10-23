//
//  HeaderView.swift
//  NewsApp
//
//  Created by Pavel Bondar on 11.10.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    @IBOutlet private var view: UIView!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: HeaderView.self)
        bundle.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setStatus(status: String, country: String) {
        statusLabel.text = status
        countryLabel.text = country
    }
}
