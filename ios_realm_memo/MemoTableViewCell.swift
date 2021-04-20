//
//  MemoTableViewCell.swift
//  ios_realm_memo
//
//  Created by Yo Higashida on 2021/04/19.
//

import UIKit

class MemoTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var updateDateLabel: UILabel!
    
    func setup(title: String, content: String, updateDate: String) {
        titleLabel.text = title
        contentLabel.text = content
        updateDateLabel.text = updateDate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
