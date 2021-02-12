//
//  BookInfoViewController.swift
//  GoogleBooks
//
//  Created by Thilina Hewagama on 2021-02-12.
//

import UIKit

class BookInfoViewController: UIViewController {

    var viewModel: BookInfoViewModel!

    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblAuthors:UILabel!
    @IBOutlet weak var lblNoPreview:UILabel!
    @IBOutlet weak var ivBook:UIImageView!
    @IBOutlet weak var tvDescription: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblNoPreview.isHidden = true

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

        if let book = self.viewModel.book {

            self.lblTitle.text = book.titleText
            self.lblAuthors.text = book.authorText
            self.ivBook.loadImageFromCache(with: book.thumbnailUrlString as NSString)
            self.lblNoPreview.isHidden = (book.thumbnailUrlString.count != 0)
            self.tvDescription.text = book.descriptionText

        }

    }

}
