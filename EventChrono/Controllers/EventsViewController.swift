//
//  EventsViewController.swift
//  EventChrono
//
//  Created by Petr Dumanov on 10.03.2025.
//

import UIKit
import CoreData

class EventsViewController: UITableViewController {
    
    private var events = [Event]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadEvents()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! EventCell
        let event = events[indexPath.row]
        
        cell.eventLabel.text = event.name!
        cell.setEventDate(date: event.date!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddEvent", sender: self)
    }
    
    func loadEvents(with request: NSFetchRequest<Event> = Event.fetchRequest(), predicate: NSPredicate? = nil) {
        
        request.predicate = predicate
        
        do {
            events = try context.fetch(request)
        }
        catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
}
