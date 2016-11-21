//
//  MovieAPIViewController.swift
//  SampleApp
//
//  Created by Downey, Eric on 11/15/16.
//  Copyright © 2016 Eric Downey. All rights reserved.
//

import UIKit
import Alamofire

struct Movie {
    var title: String?
    var year: String?
    var posterUrl: String?
    
    init?(json: [String: Any]?) {
        title = json?["Title"] as? String
        year = json?["Year"] as? String
        posterUrl = json?["Poster"] as? String
    }
}

class MovieAPIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movies: [Movie] = [] {
        didSet {
            movieTableView?.reloadData()
        }
    }
    
    @IBOutlet var movieTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://www.omdbapi.com/?r=json&s=Christmas").responseJSON(completionHandler: handleMovieJSONData)
    }
    
    private func handleMovieJSONData(with response: DataResponse<Any>) {
        let query = response.result.value as? [String: Any]
        let searchResults = query?["Search"] as? [[String: Any]]
        
        if let results = searchResults?.flatMap({
            Movie(json: $0)
        }) {
            movies = results
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if var destination = segue.destination as? SelectedMovie,
            let indexPath = movieTableView?.indexPathForSelectedRow {
            destination.movie = movies[indexPath.row]
        }
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = movies[indexPath.row].title
        cell.detailTextLabel?.text = movies[indexPath.row].year
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: UIView.areAnimationsEnabled)
    }
}
