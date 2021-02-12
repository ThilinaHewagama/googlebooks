//
//  SearchResult.swift
//  GoogleBooks
//
//  Created by Thilina Hewagama on 2021-02-12.
//

import Foundation

struct SearchResult: Decodable {
    var totalItems: Int?
    var items:[Book]?
}
