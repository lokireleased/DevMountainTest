//
//  Movie.swift
//  DevMountainTest
//
//  Created by tyson ericksen on 11/22/19.
//  Copyright © 2019 tyson ericksen. All rights reserved.
//

import Foundation


struct TopLevelDictionary: Codable {
    
    let results: [Movie]
    
//    struct ResultsLevel: Codable {
//        let movies: Movie
//    }
}

struct Movie: Codable {
    
    let title: String
    let overview: String
    let poster_path: String 
    let vote_average: Double
    
}




