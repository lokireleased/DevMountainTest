//
//  MovieController.swift
//  DevMountainTest
//
//  Created by tyson ericksen on 11/22/19.
//  Copyright © 2019 tyson ericksen. All rights reserved.
//

import UIKit


//a41bb0a6d709f7857ffd959b8ab77bfb
//https://api.themoviedb.org/3/movie/550?api_key=a41bb0a6d709f7857ffd959b8ab77bfb

//https://api.themoviedb.org/3/search/movie?api_key=a41bb0a6d709f7857ffd959b8ab77bfb&language=en-US&query=550&page=1&include_adult=false

//https://api.themoviedb.org/3/movie?api_key=a41bb0a6d709f7857ffd959b8ab77bfb&query=Star%20wars
class MovieController {
    
    static func fetchMovie(searchText: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        
        guard let baseURL = URL(string: "https://api.themoviedb.org") else { completion(.failure(.invalidURL));  return }
        let movieURL = baseURL.appendingPathComponent("3").appendingPathComponent("search").appendingPathComponent("movie")
        var components = URLComponents(url: movieURL, resolvingAgainstBaseURL: true)
        let apiQueryItems = URLQueryItem(name: "api_key", value: "a41bb0a6d709f7857ffd959b8ab77bfb")
        let movieQueryItem = URLQueryItem(name: "query", value: searchText)
        components?.queryItems = [apiQueryItems, movieQueryItem]
        guard let finalURL = components?.url else { completion(.failure(.invalidURL)); return }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                completion(.failure(.severError))
            }
            
            guard let data = data else { completion(.failure(.noData)); return }
            do {
                let topLevel = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let movies = topLevel.results
              completion(.success(movies))
            } catch {
                print(error, error.localizedDescription)
                completion(.failure(.noData))
            }
        }.resume()
    }
    
//    http://image.tmdb.org/t/p/w500/(imageEndpoint)
    
    static func fetchImage(_ movie: Movie, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        guard let url = URL(string: movie.poster_path) else { completion(.failure(.invalidURL)); return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                completion(.failure(.severError))
            }
            
            guard let data = data else { completion(.failure(.noData)); return }
            guard let image = UIImage(data: data) else { completion(.failure(.noData)); return }
            completion(.success(image))
        }.resume()
    }
    
    enum MovieError: LocalizedError {
        case invalidURL
        case severError
        case noData
    }
}
