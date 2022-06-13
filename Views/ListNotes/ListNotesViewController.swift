//
//  ViewController.swift
//  MyNotesApp
//
//  Created by Mehmet Bilir on 13.06.2022.
//

import UIKit

protocol ListNotesDelegate:class {
    func refreshNotes()
    func deleteNote(with id: UUID)
}

class ListNotesViewController: UIViewController {

    @IBOutlet weak var notesCountLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController()
    
    private var allNotes:[Note] = [] {
        didSet{
            notesCountLbl.text = "\(allNotes.count) \(allNotes.count == 1 ? "Note" : "Notes")"
            filteredNotes = allNotes

        }
    }
    
    private var filteredNotes : [Note] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.shadowImage = UIImage()
        tableView.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        
    }
    
    private func indexForNote(id:UUID, in list:[Note]) -> IndexPath {
        let row = Int(list.firstIndex(where: {$0.id == id}) ?? 0)
        return IndexPath(row: row, section: 0)
    }
    
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
    }

    @IBAction func createNewNoteClicked(_ sender: UIButton) {
        goToeditNote(createNote())
        
    }
    private func goToeditNote(_ note:Note) {
        let controller = storyboard?.instantiateViewController(withIdentifier: EditNoteViewController.identifier) as! EditNoteViewController
        controller.note = note
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    private func createNote() -> Note {
        let note = Note()
        
        allNotes.insert(note, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        return note
    }
    private func fetchNotesFromStorage() {
        
    }
    
    private func deleteNoteFromStorage(_ note:Note) {
        
        deleteNote(with: note.id)
        
    }
    private func searchNotesFromStorage(_ text:String) {
        
    }
    
    
}

extension ListNotesViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListNoteTableViewCell.identifier, for: indexPath) as! ListNoteTableViewCell
        cell.setup(note: filteredNotes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToeditNote(filteredNotes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNoteFromStorage(filteredNotes[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}



extension ListNotesViewController:UISearchControllerDelegate,UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search("")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else {return}
        searchNotesFromStorage(query)
    }
    
    func search(_ query:String) {
        if query.count >= 1 {
            filteredNotes = allNotes.filter{
                $0.text.lowercased().contains(query.lowercased()) }
            
        }else {
            filteredNotes = allNotes
        }
        tableView.reloadData()
    }
}

extension ListNotesViewController:ListNotesDelegate {
    func refreshNotes() {
        allNotes = allNotes.sorted { $0.lastUpdated > $1.lastUpdated}
        tableView.reloadData()
    }
    
    func deleteNote(with id: UUID) {
        let indexPath = indexForNote(id: id, in: filteredNotes)
        filteredNotes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        allNotes.remove(at: indexForNote(id: id, in: allNotes).row)
    }
    
    
}
