//
//  NetworkSession.swift
//  OmdbMovieApp
//
//  Created by Şafak Can Baş on 26.07.2021.
//

import Foundation
class NetworkSession {
    typealias QueryResult = ([OmdbMovies]?, String) -> Void
    var searchResult : [OmdbMovies] = []
    var errorMessage = ""
    
   
    func fetchMovieList(with name: String, completion: @escaping QueryResult) {
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=1e5b671a&s=\(name)&type=movie")!,  completionHandler: {data, response, error in
            self.searchResult.removeAll()
            guard let data = data, error == nil else {return}
            
            var result: MovieResult?
            do {
                result = try JSONDecoder().decode(MovieResult.self, from: data)
            } catch {
                self.errorMessage = error.localizedDescription
            }
            
            if let result = result {
            self.searchResult = result.Search
        }
            DispatchQueue.main.async {
            completion(self.searchResult,self.errorMessage )
            }
            
        }).resume()
    }
}
