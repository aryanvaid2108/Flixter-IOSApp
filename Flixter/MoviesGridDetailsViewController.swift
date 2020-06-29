//
//  MoviesGridDetailsViewController.swift
//  Flixter
//
//  Created by Aryan Vaid on 5/25/20.
//  Copyright © 2020 Aryan Vaid. All rights reserved.
//

import UIKit
import AlamofireImage
class MoviesGridDetailsViewController: UIViewController {

    var movie: [String:Any]!
    var key = ""
    var results = [[String:Any]]()
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetails()
        // ***** API Call *****
        let baseURL = "https://image.tmdb.org/t/p/w780"
                      let posterPath = movie["poster_path"] as! String
                      let posterURL = URL(string: baseURL + posterPath)
                      posterView.af.setImage(withURL: posterURL!)
                      
                      let backdropPath = movie["backdrop_path"] as! String
                      let backdropURL = URL(string: baseURL + backdropPath)
                      backdropView.af.setImage(withURL: backdropURL!)
                      
                      let movieID = movie["id"] as! NSNumber
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.results = dataDictionary["results"] as! [[String:Any]]
            self.key = self.results[0]["key"] as! String
        }
    }
    task.resume()
}
    func setDetails() {
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        yearLabel.text = movie["release_date"] as? String
        yearLabel.sizeToFit()
        descriptionLabel.text = movie["overview"] as? String
        descriptionLabel.sizeToFit()
    }
    
    @IBAction func onTap(_ sender: Any) {
        performSegue(withIdentifier: "trailerSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TrailerViewController
        vc.key = key
    }
}
