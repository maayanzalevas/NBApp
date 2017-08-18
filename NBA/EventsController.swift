//
//  EventsController.swift
//  NBA
//
//  Created by Kalinin Andrey on 8/2/17.
//  Copyright © 2017 Kalinin Andrey. All rights reserved.
//

import UIKit

class EventsController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet fileprivate var tableView: UITableView!
    
    var  events:[Event]?  {
        didSet{
            tableView?.reloadData()
        }
    }
    
// MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func refreshAction() {
        guard let loader = DataLoaderManager.loader(type: .espn, gameId: "400900331") else {
            return
        }
        loader.startGameLoading(completionHandler: { (game, error) in
            if error == nil && game != nil {
                self.events = game!.events
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
// MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = events?.count {
            return count
        }
        else {
            return 0
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        cell.event = events![indexPath.row]
        
        return cell
    }
}
