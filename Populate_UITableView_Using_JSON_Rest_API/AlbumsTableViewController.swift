//
//  AlbumsTableViewController.swift
//  Populate_UITableView_Using_JSON_Rest_API
//
//  Created by Toleen Jaradat on 7/25/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albums = [Album]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateAlbums()
        
        }

    private func populateAlbums() {
        
        let albumAPI = "http://jsonplaceholder.typicode.com/photos"
        
        guard let url = NSURL(string: albumAPI) else {
            
            fatalError("Invalid URL")
        }
        
        let session = NSURLSession.sharedSession()
        
        
        session.dataTaskWithURL(url) { (data :NSData?, response :NSURLResponse?, error :NSError?) in
            
            let jsonAlbumsArray = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [AnyObject]
            
            
            for item in jsonAlbumsArray {
                
                let album = Album()
                album.title = item.valueForKey("title") as! String
                album.thumbnailUrl = item.valueForKey("thumbnailUrl") as! String
                
                self.albums.append(album)
                
            }
          
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                
            })
            
            }.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.albums.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath)
        
        let album = self.albums[indexPath.row]
        
        guard NSURL(string: album.thumbnailUrl) != nil else {
            fatalError("Invalid URL")
        }
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue) {
        
            guard let imageURL = NSURL(string: album.thumbnailUrl) else {
                fatalError("Invalid URL")
            }
            
            let imageData = NSData(contentsOfURL: imageURL)
            
            let image = UIImage(data: imageData!)

            dispatch_async(dispatch_get_main_queue(), {
                
                cell.imageView?.image = image
                print(album.thumbnailUrl)
                cell.textLabel?.text = album.title

            })
            
        }
        
        return cell

        }
    
}