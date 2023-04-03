//
//  MovieController.swift
//  A4_TableView
//
//  Created by Gaurang Naik on 2023-03-28.
//

import UIKit

class ViewController : UIViewController, UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet var tableView:UITableView!
    //var mylist = MovieList()
    var mylist = ContactList()
    var selectedIndex = 0
    
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
     //   print("View appear called")
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
        return mylist.Contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! CustomTableViewCell
        
        tableView.rowHeight = 70
        
//        cell.Title.text = mylist.movies.movies[indexPath.row].Title
//        cell.Rating.text = mylist.movies.movies[indexPath.row].Rated
//        cell.Year.text = mylist.movies.movies[indexPath.row].Year
        
        cell.ContactName.text = mylist.Contacts[indexPath.row].FirstName + mylist.Contacts[indexPath.row].LastName
        cell.PrimaryNumber.text = mylist.Contacts[indexPath.row].PrimaryPhone
        
        selectedIndex = indexPath.row
        
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
    
    @IBAction func AddMovie(_ sender : UIBarButtonItem){
        
        let alert = UIAlertController(title: "Add new Movie", message: "Add your favorite movie", preferredStyle: .alert)
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
            dst.selectedMovieIndex = 0
            dst.contactlist = mylist
        case "modify":
            let dst = segue.destination as! DetailsViewController
            dst.contactlist = mylist
            dst.selectedMovieIndex = tableView.indexPathForSelectedRow?.row
            
        default:
            preconditionFailure("Error in switch \(segue.identifier)")
        }
    }
    
    
}


