//
//  ViewController.swift
//  MyNotesApp
//
//  Created by Mehmet Bilir on 13.06.2022.
//

import UIKit

class ListNotesViewController: UIViewController {

    @IBOutlet weak var notesCountLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func createNewNoteClicked(_ sender: UIButton) {
    }
    
}

