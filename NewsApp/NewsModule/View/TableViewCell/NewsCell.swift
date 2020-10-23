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
    
    func setupCell(article: Article) {
        imageArticle.sd_setImage(with: article.urlToImage) { (image, error, cache, urls) in
            if (error != nil) {
                let source = article.source.name?.prefix(1).lowercased()
                self.imageArticle.image = UIImage(systemName: "\(source ?? "x").square")
            } else {
                self.imageArticle.image = image
            }
        }
        titleLable.text = article.title
    }
}
