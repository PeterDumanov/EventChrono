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
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.eventCellNibName, bundle: nil), forCellReuseIdentifier: K.eventCellIdentifier)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            for cell in self.tableView.visibleCells {
                if let timerCell = cell as? EventCell {
                    timerCell.updateLabel()
                }
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadEvents()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.eventCellIdentifier, for: indexPath) as! EventCell
        let event = events[indexPath.row]
        
        cell.eventLabel.text = event.name!
        cell.eventDate = event.date!
        cell.updateLabel()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = events[indexPath.row]
        let alert = UIAlertController(title: selectedEvent.name, message: selectedEvent.date?.formatted(), preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ок", style: .default) {_ in
            tableView.deselectRow(at: indexPath, animated: true)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Delete") { [weak self] (_, _, completionHandler) in
            self!.context.delete(self!.events[indexPath.row])

            do {
                try self!.context.save()
            } catch {
                print(error.localizedDescription)
            }
            
            self!.events.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.addEventSegue, sender: self)
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
