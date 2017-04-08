//
//  Article.swift
//  SPNewsApp
//
//  Created by Stepan Paholyk on 4/8/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

import UIKit

class Article: NSObject {
    
    var kAuthor: String?
    var kTitle: String?
    var kDescription: String?
    var kUrl: String?
    var kUrlToImage: String?
    var KPublishedAt: String?
    var kImage: UIImage? // ?
    
    
    init(withServer response:[String:Any]) {
        super.init()
        self.kTitle = response["title"] as? String
        self.kAuthor = response["author"] as? String
        self.kDescription = response["description"] as? String
        self.kUrl = response["url"] as? String
        
        if let publishedTime = response["publishedAt"] as? String {
            self.KPublishedAt = setupCorrectDateDisplaying(withString: publishedTime)
        } else {
            self.KPublishedAt = ""
        }
        
        self.kUrlToImage = response["urlToImage"] as? String
    }
    
    func setupCorrectDateDisplaying(withString strDate: String) -> String {
        let dateFormatter = DateFormatter()
        
        let postDate = dateFormatter.datefromSwapiString(dateString: strDate)
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        return dateFormatter.string(from: postDate!)
    }
    
}

extension DateFormatter {
    func datefromSwapiString(dateString: String) -> Date? {
        self.locale = Locale(identifier: "en_US_POSIX")
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.timeZone = TimeZone(abbreviation: "UTC")
        return self.date(from: dateString)
    }
}
