//
//  OmdbMovies.swift
//  OmdbMovieApp
//
//  Created by Şafak Can Baş on 26.07.2021.
//

import Foundation

struct MovieResult: Codable {
    let Search : [OmdbMovies]
}

struct OmdbMovies: Codable {
    let Title : String?
    let Year : String?
    let imdbID : String?
    let movieType : String?
    let Poster : String?
    
    private enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, movieType = "Type", Poster
    }
}
