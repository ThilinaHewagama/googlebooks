//
//  BookFinderViewController.swift
//  GoogleBooks
//
//  Created by Thilina Hewagama on 2021-02-12.
//

import UIKit

class BookFinderViewController: UIViewController {

    var viewModel = BookFinderViewModel()

    @IBOutlet weak var tblBooks:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.loadBooks(completion: {errorString in

            if let errorString = errorString {
                print(errorString)
            } else {
                self.tblBooks.reloadData()
            }

        })

    }

}

//MARK: UITableViewDataSource

extension BookFinderViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        cell.configure(book: self.viewModel.books[indexPath.row])
        return cell

    }

}

//MARK: UITableViewDelegate

extension BookFinderViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}

