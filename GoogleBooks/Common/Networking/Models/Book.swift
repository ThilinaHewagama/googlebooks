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

        if let description = self.volumeInfo?.description {
            return description
        } else if let textSnippet = self.searchInfo?.textSnippet {
            return textSnippet
        } else {
            return ""
        }

    }

    var smallThumbnailUrlString: String {
        (self.volumeInfo?.imageLinks?.smallThumbnail ?? "")
    }

    var thumbnailUrlString: String {
        (self.volumeInfo?.imageLinks?.thumbnail ?? "")
    }

}

struct VolumeInfo:Decodable {
    var title: String
    var authors:[String]?
    var imageLinks: ImageLinks?
    var description: String?
}

struct SearchInfo: Decodable {
    var textSnippet: String?
}

struct ImageLinks: Decodable {
    var smallThumbnail: String?
    var thumbnail: String?
}
