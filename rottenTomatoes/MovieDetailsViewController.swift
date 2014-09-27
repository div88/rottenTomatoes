//
//  MovieDetailsViewController.swift
//  rottenTomatoes
//
//  Created by Divya Prabhakar on 9/24/14.
//  Copyright (c) 2014 Divya_Prabhakar. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieDetailTitleLabel: UILabel!
    @IBOutlet weak var posterDetailView: UIImageView!
    @IBOutlet weak var movieDetailDescriptionLabel: UILabel!
   
    @IBOutlet weak var mpaRatingLabel: UILabel!
    @IBOutlet weak var criticsScoreLabel: UILabel!
    @IBOutlet weak var audienceScoreLabel: UILabel!
    var movieDetails:NSDictionary!
   // var toPass:String!
    
    //var detailViewMovieName: NSString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        println("\(movieDetails)")
        
        self.title = movieDetails["title"] as String!
        
        var yearVal:Int = 0;
        yearVal = movieDetails["year"] as Int!
        
        var currentMovieTitle:String = ""
        currentMovieTitle=movieDetails["title"] as String!
        movieDetailTitleLabel.text = currentMovieTitle + "(" + String(yearVal) + ")"
        movieDetailDescriptionLabel.text = movieDetails["synopsis"] as? String
        
        var posters = movieDetails["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        let originalPosterUrl = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori", options: NSStringCompareOptions.LiteralSearch, range: nil)
        println("Original Poster URl  is----------\(originalPosterUrl)")
        posterDetailView.setImageWithURL(NSURL(string: originalPosterUrl))
        //var posterUrl = "http://content9.flixster.com/movie/11/17/85/11178575_ori.jpg"
        
        var ratingsDetails = movieDetails["ratings"] as NSDictionary
        
        var criticsScore = ratingsDetails["critics_score"] as Int!
        criticsScoreLabel.text = String(criticsScore) + ","
        var audienceScore = ratingsDetails["audience_score"] as Int!
        audienceScoreLabel.text = String(audienceScore)
        
        mpaRatingLabel.text = movieDetails["mpaa_rating"] as? String
        
        
        // Do any additional setup after loading the view.
     //   movieDetailTitleLabel.text = toPass
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
