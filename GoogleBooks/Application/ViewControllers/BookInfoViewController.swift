//
//  BookInfoViewController.swift
//  GoogleBooks
//
//  Created by Thilina Hewagama on 2021-02-12.
//

import UIKit

class BookInfoViewController: UIViewController {

    var viewModel: BookInfoViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.loadBook(completion: {errorString in

            DispatchQueue.main.async {

                if let errorString = errorString {
                    let alert = UIAlertController(title: "Oops", message: errorString, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {_ in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.showBookInfo()
                }
            }

        })

    }
    
    func showBookInfo() {
        print("Show me more..")
    }

}
