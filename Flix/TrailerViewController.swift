//
//  TrailerViewController.swift
//  Flix
//
//  Created by John Cheshire on 2/19/22.
//

import UIKit
import WebKit


class TrailerViewController: UIViewController {
    
    let urlBase: String = "https://www.youtube.com/embed/"
    
    var movie: Int = 0
    
    var trailers = [[String:Any]]()
    
    private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.movie)
        
        let dbURL: String = "https://api.themoviedb.org/3/movie/"
        let dbURLLast: String = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        let movie: String = String(self.movie)
        print(movie)
        
        let url = URL(string: dbURL + movie + dbURLLast)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 self.trailers = dataDictionary["results"] as! [[String:Any]]
                 showWebView()

             }
        }
        task.resume()
        
        
        func showWebView() {
            if self.trailers.count == 0 {
                print("No trailers")
                print(self.trailers)
            }
            else{
            let movieCode: String = self.trailers[0]["key"] as! String
            let url_trailer: URL = URL(string: urlBase + movieCode)!
            
            
            view.addSubview(webView)
            webView.load(URLRequest(url: url_trailer))
            }
        }

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    


}
