//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by John Cheshire on 2/8/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    var movie: [String:Any]!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView! {
        didSet {
            posterView.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBAction func tapPoster(_ sender: UITapGestureRecognizer) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af.setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropView.af.setImage(withURL: backdropUrl!)

        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // find selexted movie

        // pass to movie details
        let trailerViewController = segue.destination as! TrailerViewController
        

        trailerViewController.movie = self.movie["id"] as! Int


    }
    
}
