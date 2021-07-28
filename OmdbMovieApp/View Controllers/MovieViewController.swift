//
//  ViewController.swift
//  OmdbMovieApp
//
//  Created by Şafak Can Baş on 25.07.2021.
//

import UIKit
import Firebase

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let networkSession = NetworkSession()
    var movies = [OmdbMovies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OmdbMoviesCellTableViewCell.nib(), forCellReuseIdentifier: OmdbMoviesCellTableViewCell.identifier)
        tableView.backgroundColor = .black
        Analytics.logEvent("moview_VC_lunched", parameters: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavigationControllerTopBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.showNavigationControllerTopBar()
    }
    
    func searchMovies() {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text, !text.isEmpty else {return}
        let query = text.replacingOccurrences(of: " ", with: "%20")
        
        networkSession.fetchMovieList(with: query) { [weak self] results, error in
            if let results = results, !results.isEmpty {
                self?.movies = results
                self?.tableView.reloadData()
            }
            else {
                self?.showAlertAction(title: "Error", message: error)
            }
        }
    }
    
    func pushToMoviewDetailViewController(selected movie: OmdbMovies) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MovieDetailViewController") as MovieDetailViewController
        viewController.movie = movie
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension MovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchMovies()
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OmdbMoviesCellTableViewCell.identifier, for: indexPath) as! OmdbMoviesCellTableViewCell
        cell.selectionStyle = .none
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Analytics.logEvent("selected_movie", parameters: ["selected": movies[indexPath.row]])
        pushToMoviewDetailViewController(selected: movies[indexPath.row])
    }
}
