//
//  BookFinderViewModel.swift
//  GoogleBooks
//
//  Created by Thilina Hewagama on 2021-02-12.
//

import Foundation

class BookFinderViewModel {

    var books = [Book]()
    var isLoadingData = false
    var searchText: String?

    func loadBooks(loadMore:Bool = false, completion:@escaping (String?) -> ()) {

        isLoadingData = true

        let urlString = Config.baseUrl + Constants.Paths.volumes
        var urlComponents = URLComponents(string: urlString)!

        //Get Params
        if let key = searchText {

            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: key),
                URLQueryItem(name: "maxResults", value: Config.maxResults)
            ]

            if loadMore {
                urlComponents.queryItems?.append(URLQueryItem(name: "startIndex", value: "\(books.count)"))
            }

        }

        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"

        let session = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            self.isLoadingData = false

            if let data = data {

                do{
                    let results = try JSONDecoder().decode(SearchResult.self, from: data)
                    let books = results.items ?? []

                    if loadMore {
                        self.books.append(contentsOf: books)
                    } else {
                        self.books = books
                    }

                    completion(nil)
                }catch{
                    completion(error.localizedDescription)
                }

            } else if let error = error {
                completion(error.localizedDescription)
            } else {
                completion("Something went wrong!")
            }

        }

        session.resume()

    }

}
