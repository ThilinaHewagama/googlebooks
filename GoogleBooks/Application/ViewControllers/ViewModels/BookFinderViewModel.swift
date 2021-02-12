//
//  BookFinderViewModel.swift
//  GoogleBooks
//
//  Created by Thilina Hewagama on 2021-02-12.
//

import Foundation

class BookFinderViewModel {

    var books = [Book]()

    func loadBooks(key: String?, completion:@escaping (String?) -> ()) {

        let urlString = Config.baseUrl + Constants.Paths.volumes
        var urlComponents = URLComponents(string: urlString)!

        //Get Params
        if let key = key {
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: key)
            ]
        }

        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"

        let session = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            if let data = data {

                do{
                    let results = try JSONDecoder().decode(SearchResult.self, from: data)
                    self.books = results.items ?? []
                    completion(nil)
                }catch let DecodingError.dataCorrupted(context) {
                    print(context)
                }catch let DecodingError.keyNotFound(key, context) {
                    print("key: \(key) not founr in \(context.debugDescription)")
                }
                catch let DecodingError.valueNotFound(value, context) {
                    print("value: \(value) not found in \(context.debugDescription)")
                }
                catch let DecodingError.typeMismatch(type, context){
                    print("Type: \(type) mismatch: \(context.debugDescription)")
                }
                catch{
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
