//
//  EditNoteViewController.swift
//  MyNotesApp
//
//  Created by Mehmet Bilir on 14.06.2022.
//

import UIKit

class EditNoteViewController: UIViewController {
    static let identifier = "EditNoteViewController"
    var note : Note!
    weak var delegate: ListNotesDelegate?

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = note?.text
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    private func updateNote(){
        note.lastUpdated = Date()
        CoreDataManager.shared.save()
        delegate?.refreshNotes()
    }
    
    private func deleteNote(){
        if let id = note.id {
            delegate?.deleteNote(with: id)
        }
        CoreDataManager.shared.deleteNote(note)

    }
    
    
    

   

}

extension EditNoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView:UITextView) {
        note?.text = textView.text
        if note?.title.isEmpty ?? true {
            deleteNote()
        }else {
            updateNote()
        }
    }
}
