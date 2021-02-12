//
//  UIImageView+Extension.swift
//  GoogleBooks
//
//  Created by Thilina Hewagama on 2021-02-12.
//

import Foundation
import UIKit


//Better to use singleton
let cache = NSCache<NSString,UIImage>()

extension UIImageView {

    func loadImageFromCache(with urlString: NSString) {

        self.image = nil

        if let cachedImage = cache.object(forKey: urlString) {
            self.image = cachedImage
        } else {

            if let url = URL(string: urlString as String) {
                URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in

                    if let data = data, let image = UIImage(data: data) {

                        DispatchQueue.main.async {
                            self.image = image
                        }

                    }

                }).resume()
            }

        }

    }

}
