//
//  NewsCell.swift
//  NewsApp
//
//  Created by Pavel Bondar on 06.10.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    @IBOutlet private weak var imageArticle: UIImageView!
    @IBOutlet private weak var titleLable: UILabel!
    
    func setupCell(image: URL?, title: String?) {
        imageArticle.sd_setImage(with: image) { (image, error, cache, urls) in
            if (error != nil) {
                self.imageArticle.image = UIImage()
            } else {
                self.imageArticle.image = image
            }
        }
        titleLable.text = title
    }
}
