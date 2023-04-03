//
//  Movies.swift
//  A4_TableView
//
//  Created by Cambrian on 2023-03-22.
//

import Foundation

class MovieList {
    var movies: Movies!
    
    init(){
        if let url = Bundle.main.url(forResource: "movie", withExtension: "json"){
            do {
                
                let data = try Data(contentsOf: url)

                let decoder = JSONDecoder()
                
                movies = try decoder.decode(Movies.self, from: data)
                                
            } catch {
                   fatalError("cannot convert JSON to movies: \(error)")
            }
        } else {
            print("something went wrong when geting url")
        }
    }
}
