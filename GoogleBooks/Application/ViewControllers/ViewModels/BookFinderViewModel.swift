//
//  BookFinderViewModel.swift
//  GoogleBooks
//
//  Created by Thilina Hewagama on 2021-02-12.
//

import Foundation

class BookFinderViewModel {

    var books = [Book]()

    func loadBooks(completion:@escaping (String?) -> ()) {

        let urlString = Config.baseUrl + Constants.Paths.volumes
        var urlComponents = URLComponents(string: urlString)!

        //Get Params
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "floswers")
        ]

        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"

        let session = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            if let data = data {

                do{
                    let results = try JSONDecoder().decode(SearchResult.self, from: data)
                    self.books = results.items
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
