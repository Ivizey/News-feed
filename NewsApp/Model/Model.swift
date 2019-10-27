//
//  Model.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10/27/19.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import Foundation

var articles:[Article] = []

var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}

func loadNews() {
    let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&from=2019-09-27&sortBy=publishedAt&apiKey=84a521a08cf141aa8bbe269df5f99439")
    let session = URLSession(configuration: .default)
    let downloadTask = session.downloadTask(with: url!) { (urlFile, responce, error) in
        if urlFile != nil {
            
            try? FileManager.default.copyItem(at: urlFile!, to: urlToData)
            print(urlToData)
            parseNews()
            print(articles.count)
        }
    }
    
    downloadTask.resume()
}

func parseNews() {
    let data = try? Data(contentsOf: urlToData)
    guard data != nil else {return}
    
    let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
    guard rootDictionaryAny != nil else { return }
    
    let rootDictionary = rootDictionaryAny as? Dictionary<String, Any>
    guard rootDictionary != nil else { return }
    
    if let array = rootDictionary!["articles"] as? [Dictionary<String, Any>] {
        var returnArray: [Article] = []
        
        for dict in array {
            let newArticle = Article(dictionary: dict)
            returnArray.append(newArticle)
        }
        articles = returnArray
    }
}
