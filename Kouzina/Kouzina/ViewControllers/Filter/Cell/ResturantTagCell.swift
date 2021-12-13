//
//  ResturantTagCell.swift
//  Kouzina
//
//  Created by Anas Soltani on 21/11/21.
//

import UIKit

class ResturantTagCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tagListView: TagListView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func addTagView(tags:[String]) {
        tags.forEach { tag in
            tagListView.addTag(tag)
        }
        
        tagListView.delegate = self
//        tagListView.minWidth = 100
        tagListView.textFont = UIFont(name: "Inter-SemiBold", size: 14)!
        tagListView.tagBackgroundColor = UIColor(hexString: "28282B")
        tagListView.textColor = .white
        
        tagListView.selectedTextColor = .white
        tagListView.tagSelectedBackgroundColor = UIColor(hexString: "53E88B")
        
        tagListView.cornerRadius = 15
        tagListView.paddingY = 15
        tagListView.paddingX = 20
    }
}

extension ResturantTagCell: TagListViewDelegate {
    
    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}

