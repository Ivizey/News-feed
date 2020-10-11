//
//  ArticleViewController.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var publishedLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        presenter.setArticle()
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        presenter.goToWeb()
    }
}

extension DetailViewController: DetailViewProtocol {
    func setArticle(article: Article?) {
        titleLabel.text = article?.title
        descriptionLabel.text = article?.description
        authorLabel.text = article?.author
        publishedLabel.text = presenter.setDate(article?.publishedAt)
        sourceLabel.text = article?.source.name
        image.load(url: article?.urlToImage)
    }
}
