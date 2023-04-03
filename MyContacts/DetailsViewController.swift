//
//  DetailsViewController.swift
//  A4_TableView
//
//  Created by Gaurang Naik on 2023-04-01.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var formTitle:UINavigationItem!
    
    var contactlist:ContactList!
    var selectedMovieIndex:Int!
    
    @IBOutlet weak var titleTextfield:UITextField!
    @IBOutlet weak var yearTextfield:UITextField!
    @IBOutlet weak var ratingTextfield:UITextField!
    @IBOutlet weak var runtimeTextfield:UITextField!
    @IBOutlet weak var directorTextfield:UITextField!
    @IBOutlet weak var actorTextfield:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //setting the border to actor textview to have similar look to text fields
        actorTextfield.layer.borderColor = CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        actorTextfield.layer.borderWidth = 1.0
        actorTextfield.layer.cornerRadius = 5
        
        if(selectedMovieIndex > 0){
            formTitle.title = "Modify Movie"
            titleTextfield.text! = movielist.movies.movies[selectedMovieIndex].Title
            yearTextfield.text! = movielist.movies.movies[selectedMovieIndex].Year
            ratingTextfield.text! = movielist.movies.movies[selectedMovieIndex].Rated
            runtimeTextfield.text! = movielist.movies.movies[selectedMovieIndex].Runtime
            directorTextfield.text! = movielist.movies.movies[selectedMovieIndex].Director
            actorTextfield.text! = formattedActors(actors: movielist.movies.movies[selectedMovieIndex].Actors)
        }
        else{
            formTitle.title = "Add Movie"
        }
        
    }
    
    @IBAction func SaveMovie(){
        
        if(selectedMovieIndex > 0) {
            
            let existingMovie = movielist.movies.movies[selectedMovieIndex]
            existingMovie.Title  = titleTextfield.text!
            existingMovie.Year = yearTextfield.text!
            existingMovie.Rated = ratingTextfield.text!
            existingMovie.Runtime = runtimeTextfield.text!
            existingMovie.Director = directorTextfield.text!
            existingMovie.Actors = actorTextfield.text!
            
            if(existingMovie.Title == "" || existingMovie.Rated == "" || existingMovie.Year == "")
            {
                let alert = UIAlertController(title: "Missing mandatory fields", message: " Title , Rating and year are mandatory fields.\nPlease fill in the same and try again.", preferredStyle: .alert)
                let alertOkAction = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(alertOkAction)
                self.present(alert, animated: true)
                return
            }
            movielist.movies.movies.remove(at: selectedMovieIndex)
            movielist.movies.movies.insert(existingMovie, at: selectedMovieIndex)
            
            let alert = UIAlertController(title: "Modified the movie", message: " \(existingMovie.Title) is modified as per your request. Thank you.", preferredStyle: .alert)
            let alertOkAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(alertOkAction)
            self.present(alert, animated: true)
            clearTextfields()
          //  print("modify movie called")
            return
        }
        else {
            let newMovie = Movie()
            newMovie.Title = titleTextfield.text!
            newMovie.Year = yearTextfield.text!
            newMovie.Rated = ratingTextfield.text!
            newMovie.Runtime = runtimeTextfield.text!
            newMovie.Director = directorTextfield.text!
            newMovie.Actors = actorTextfield.text!
            
            if(newMovie.Title == "" || newMovie.Rated == "" || newMovie.Year == "")
            {
                let alert = UIAlertController(title: "Missing mandatory fields", message: " Title , Rating and year are mandatory fields.\nPlease fill in the same and try again.", preferredStyle: .alert)
                let alertOkAction = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(alertOkAction)
                self.present(alert, animated: true)
                return
            }
            
            let result = movielist.movies.movies.first(where: {$0.Title == newMovie.Title})
            
            if(result != nil)
            {
                let alert = UIAlertController(title: "Duplicate entry", message: " \(newMovie.Title) is already present in your movie list. Please add another movie.", preferredStyle: .alert)
                let alertOkAction = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(alertOkAction)
                self.present(alert, animated: true)
                return
                
            }
            
            movielist.movies.movies.append(newMovie)
            
            let alert = UIAlertController(title: "Saved the movie", message: " \(newMovie.Title) is added to your movie list. Thank you.", preferredStyle: .alert)
            let alertOkAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(alertOkAction)
            self.present(alert, animated: true)
            clearTextfields()
          //  print("save movie called")
            return
        }
    }
    
    func clearTextfields(){
        titleTextfield.text = ""
        yearTextfield.text = ""
        ratingTextfield.text = ""
        runtimeTextfield.text = ""
        directorTextfield.text = ""
        actorTextfield.text = ""
    }
    
    func formattedActors(actors:String) -> String {
        
        return " "+actors.replacingOccurrences(of: ",", with:"\n")
    }
    

    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
   // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
       
        
        switch segue.identifier{
            
        case "add":
            let dst = segue.destination as! ViewController
            dst.mylist.movies.movies = mylist.movies.movies
        default:
            preconditionFailure("Error in switch")
            
        }
        
    }*/
    
    
    
   

}
