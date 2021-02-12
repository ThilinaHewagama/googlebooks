//
//  Book.swift
//  GoogleBooks
//
//  Created by Thilina Hewagama on 2021-02-12.
//

import Foundation

struct Book: Decodable {
    var id: String
    var volumeInfo: VolumeInfo?
    var searchInfo: SearchInfo?
}

extension Book {

    var titleText: String {
        self.volumeInfo?.title ?? ""
    }

    var authorText: String {
        get{

            if let authors = self.volumeInfo?.authors, authors.count > 0 {
                return authors.joined(separator: ",")
            } else {
                return ""
            }

        }
    }

    var descriptionText:String {
        self.searchInfo?.textSnippet ?? ""
    }

    var thumbnailUrlString: String {
        (self.volumeInfo?.imageLinks?.smallThumbnail ?? "")
    }

}

struct VolumeInfo:Decodable {
    var title: String
    var authors:[String]?
    var imageLinks: ImageLinks?
}

struct SearchInfo: Decodable {
    var textSnippet: String?
}

struct ImageLinks: Decodable {
    var smallThumbnail: String
}
