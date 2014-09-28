//
//  MoviesViewController.swift
//  rottenTomatoes
//
//  Created by Divya Prabhakar on 9/22/14.
//  Copyright (c) 2014 Divya_Prabhakar. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary] = []
    
    var refreshControl:UIRefreshControl!  // An optional variable
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=t44mrahhjbugmmyu5exzfuby&limit=20&country=us"
        var request = NSURLRequest(URL: NSURL(string: url))
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
                //println("object: \(object)")
                self.movies = object["movies"] as [NSDictionary]
                self.tableView.reloadData()
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // var cell = UITableViewCell()
      //  println("I'm at row: \(indexPath.row)")
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
      
        var movie = movies[indexPath.row]
        //println("\(movie)")
        
        var movieId = movie["id"] as? String
        //println("Movie: \(movieId)")
        
        cell.movieTitleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        
        
        cell.posterView.setImageWithURL(NSURL(string: posterUrl))
        //println("You selected cell #\(indexPath.row)!")
      //  cell.textLabel!.text = "Hello, I'm at row: \(indexPath.row), section: \(indexPath.section)"
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showMovieDetail") {
           // let index = tableView.indexPathForSelectedRow()?.length
            
           let selectedIndex = self.tableView.indexPathForCell(sender as UITableViewCell)
            var selectedRow = selectedIndex?.row
            // println(selectedRow!)
            //let index = self.tableView.indexPathForSelectedRow().row
           // println("row \(selectedIndex) was selected")
           // let cellRow = tableView.indexPathForSelectedRow().row
            //let selectedIndex = self.tableView.indexPathForCell(sender as UITableViewCell)
            
            
             //println("Hello, I'm at row: \(tableView.indexPath.row), section: \(tableView.indexPath.section)")
          //  println("the selected row is \(selectedIndex) and \(cellRow)")
            
            let MovieDetailsVC:MovieDetailsViewController = segue.destinationViewController as MovieDetailsViewController
                var movie = movies[selectedRow!]
                var title = movie["title"] as String!
                //println("Movie is: \(movie) and naem is \(title)")
                MovieDetailsVC.movieDetails = movie as NSDictionary!
            
                /*if sender as UITableView == self.searchDisplayController!.searchResultsTableView {
                    let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
                    let destinationTitle = self.filteredCandies[indexPath.row].name
                    candyDetailViewController.title = destinationTitle
                } else {*/
            
           // var movie = movies[indexPath.row]
           // let indexPath = self.tableView.indexPathForSelectedRow()
            //var destinationTitle = movies[indexPath!.row]["title"] as? String
           // (segue.destinationViewController as MovieDetailsViewController).posterDetailView = blogPost.url
            //(segue.destinationViewController as MovieDetailsViewController).blogPostTitle = blogPost.title
            
           /* var movieIndex = tableView!.indexPathForSelectedRow()!.row
            var selectedMovie = self.movies[movieIndex]
//            MovieDetailsViewController.title = selectedMovie
                    var indexPath = self.tableView.indexPathForSelectedRow()!
                    var destinationTitle = movies[indexPath.row]["title"] as? String
                    MovieDetailsViewController.title = destinationTitle*/
               // }
            
        }
    }
    
   /* override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "showMovieDetail") {
            var svc = segue!.destinationViewController as MovieDetailsViewController;
            
            var svcToPass = movie["title"] as? String
            println("SVC to Pass: \(svcToPass)")
    
    
    // var svc = segue!.destinationViewController as MovieDetailsViewController;
    
    //svc.toPass = cell.movieTitleLabel.text
    //println("SVC to Pass: \(svc.toPass)")
    
        }
    }*/
    
    
   /* - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMovieDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    MovieDetailsViewController *destViewController = segue.destinationViewController;
    destViewController.movieName = [movie objectAtIndex:indexPath.row];
    }
    }*/
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    

}
