//
//  BookCell.swift
//  GoogleBooks
//
//  Created by Thilina Hewagama on 2021-02-12.
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblAuthor:UILabel!
    @IBOutlet weak var lblDescription:UILabel!
    @IBOutlet weak var ivBook:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configure(book: Book) {
        self.lblTitle.text = book.authorText
        self.lblAuthor.text = book.authorText
        self.lblDescription.text = book.descriptionText
        self.ivBook.loadImageFromCache(with: book.smallThumbnailUrlString as NSString)
    }

}
