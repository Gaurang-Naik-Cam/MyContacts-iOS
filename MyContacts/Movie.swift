//
//  Movie.swift
//  A4_TableView
//
//  Created by Cambrian on 2023-03-22.
//

import Foundation

struct Movies: Codable {
    var movies: [Movie]
}

class Movie: Codable {
    var Title: String
    var Year: String
    var Rated: String
    var Runtime: String
    var Director: String
    var Actors: String
    
    init() {
        self.Title = ""
        self.Year = ""
        self.Rated = ""
        self.Runtime = ""
        self.Director = ""
        self.Actors = ""
    }
}
