//
//  MovieDetailViewController.swift
//  OmdbMovieApp
//
//  Created by Şafak Can Baş on 27.07.2021.
//

import UIKit
import WebKit
import Firebase

class MovieDetailViewController: UIViewController {
    var movie : OmdbMovies?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.logEvent("movie_detail_VC_lunched", parameters: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWebView()
    }
    
    func loadWebView() {
        if let movie = movie, (movie.imdbID != nil) {
            guard let url = URL(string: "https://www.imdb.com/title/\(movie.imdbID!)/") else {return}
            webView.load(URLRequest(url: url))
        }
    }
}

