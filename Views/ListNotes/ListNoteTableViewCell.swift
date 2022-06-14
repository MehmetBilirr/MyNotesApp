//
//  ListNoteTableViewCell.swift
//  MyNotesApp
//
//  Created by Mehmet Bilir on 14.06.2022.
//

import UIKit

class ListNoteTableViewCell: UITableViewCell {
    static let identifier = "ListNoteTableViewCell"
    
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(note: Note) {
        titleLbl.text = note.title
        descriptionLbl.text = note.desc
        print("\(note.desc)")
    }

}
