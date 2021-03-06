//
//  BookFinderViewController.swift
//  GoogleBooks
//
//  Created by Thilina Hewagama on 2021-02-12.
//

import UIKit

class BookFinderViewController: UIViewController {

    var debounceTimer:Timer?
    var viewModel = BookFinderViewModel()

    @IBOutlet weak var tblBooks:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //hide empty cells
        self.tblBooks.tableFooterView = UIView()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "show_info" {
            let bookInfoViewModel = BookInfoViewModel(volumeId: sender as! String)
            (segue.destination as! BookInfoViewController).viewModel = bookInfoViewModel
        }

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
        let book = self.viewModel.books[indexPath.row]
        self.performSegue(withIdentifier: "show_info", sender: book.id)
    }

}

//MARK: UISearchBarDelegate

extension BookFinderViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.debounceTimer?.invalidate()
        self.debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in

            self.viewModel.searchText = searchText
            self.viewModel.loadBooks(completion: {errorString in

                DispatchQueue.main.async {
                    if let errorString = errorString {
                        print(errorString)
                    } else {
                        self.tblBooks.reloadData()
                    }
                }

            })

        }

    }

}

//MARK: UIScrollViewDelegate

extension BookFinderViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == self.tblBooks, (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height,
            !viewModel.isLoadingData else { return }

        self.viewModel.loadBooks(loadMore: true, completion: {errorString in

            DispatchQueue.main.async {
                if let errorString = errorString {
                    print(errorString)
                } else {
                    self.tblBooks.reloadData()
                }
            }

        })


    }

}
