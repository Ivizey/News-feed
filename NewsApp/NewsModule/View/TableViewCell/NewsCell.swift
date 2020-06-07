//
//  NewsCell.swift
//  NewsApp
//
//  Created by Pavel Bondar on 11.02.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet private weak var imageNews: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func setImage(image: UIImage?) {
        imageNews.image = image ?? UIImage()
    }
    
    func setTitle(title: String?) {
        titleLabel.text = title ?? ""
    }
    
    func setDescription(description: String?) {
        descriptionLabel.text = description ?? ""
    }
}
