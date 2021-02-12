//
//  BookInfoView.swift
//  GoogleBooks
//
//  Created by Thilina Hewagama on 2021-02-12.
//

import Foundation

class BookInfoViewModel {

    var volumeId: String
    var book: Book?

    init(volumeId: String) {
        self.volumeId = volumeId
    }

    func loadBook(completion:@escaping (String?) -> ()) {

        let urlString = Config.baseUrl + Constants.Paths.volumes + "/" + self.volumeId
        let urlComponents = URLComponents(string: urlString)!

        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"

        let session = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            if let data = data {

                do{
                    self.book = try JSONDecoder().decode(Book.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil)
                    }
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
