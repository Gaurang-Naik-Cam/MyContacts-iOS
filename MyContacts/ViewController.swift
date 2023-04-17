//
//  MovieController.swift
//  A4_TableView
//
//  Created by Gaurang Naik on 2023-03-28.
//

import UIKit

class ViewController : UIViewController, UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var searchBar:UISearchBar!
    
    var mylist = ContactList()
    var selectedIndex = 0
    var searchArray = ContactList()
    var isSeaching = false
    
    
    @IBAction func toggleEditMode(_ sender:UIBarButtonItem){
        
        tableView.isEditing = !tableView.isEditing
        
        let senderName = sender.title!
        
        if(senderName == "Edit"){
            sender.title! = "Done"
            tableView.setEditing(true, animated: true)
        }
        
        if(senderName == "Done"){
            sender.title! = "Edit"
            tableView.setEditing(false, animated: true)
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        print("View appear called")
        print(mylist.Contacts.count)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //code
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(isSeaching){
            return searchArray.Contacts.count
            
        }
        else{
            return mylist.Contacts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! CustomTableViewCell
        
        tableView.rowHeight = 70
        if(isSeaching){
            
            cell.ContactName.text = searchArray.Contacts[indexPath.row].FirstName + " " + searchArray.Contacts[indexPath.row].LastName
            cell.PrimaryNumber.text = searchArray.Contacts[indexPath.row].PrimaryPhone
        }
        else{
            
            cell.ContactName.text = mylist.Contacts[indexPath.row].FirstName + " " + mylist.Contacts[indexPath.row].LastName
            cell.PrimaryNumber.text = mylist.Contacts[indexPath.row].PrimaryPhone
            
            
            selectedIndex = indexPath.row
        }
        
        return cell
    }
    
    
    func move(from fromIndexPath:IndexPath, to toIndexPath:IndexPath) {
        let tempMovieRow = mylist.Contacts[fromIndexPath.row]
        delete(at: fromIndexPath)
        mylist.Contacts.insert(tempMovieRow, at: toIndexPath.row)
            
    }
    
    func delete(at indexPath:IndexPath){
        let row = indexPath.row
        mylist.Contacts.remove(at: row)
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        move(from: sourceIndexPath, to: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView:UITableView, commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if(editingStyle == .delete){
            delete(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
           
        }
    }
    
    @IBAction func AddContact(_ sender : UIBarButtonItem){
        
        let alert = UIAlertController(title: "Add new Contact", message: "Add a new contact to your list", preferredStyle: .alert)
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let alertOkAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(alertOkAction)
        alert.addAction(alertCancelAction)
        self.present(alert, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier{
            
        case "add":
            let dst = segue.destination as! DetailsViewController
            dst.selectedIndex = -1
            dst.contactlist = mylist
        case "modify":
            let dst = segue.destination as! DetailsViewController
            dst.contactlist = mylist
            dst.selectedIndex = tableView.indexPathForSelectedRow?.row
            
        default:
            preconditionFailure("Error in switch \(segue.identifier)")
        }
    }
    
}

extension ViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        searchArray.Contacts = mylist.Contacts.filter({$0.FirstName.lowercased().prefix(searchText.count) ==  searchText.lowercased() || $0.LastName.lowercased().prefix(searchText.count) == searchText.lowercased()})
        isSeaching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSeaching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}

