//
//  AddNewEventViewController.swift
//  EventChrono
//
//  Created by Petr Dumanov on 10.03.2025.
//

import UIKit
import CoreData

class AddNewEventViewController: UIViewController {
    
    @IBOutlet weak var addEventTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let addCellTypes: [AddEventCell.AddEventCellType] = [.text, .date]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEventTableView.delegate = self
        addEventTableView.dataSource = self
        addEventTableView.register(UINib(nibName: K.addEventCellNibName, bundle: nil), forCellReuseIdentifier: K.addEventCellIdentifier)
    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        guard let eventNameTextField = (addEventTableView.visibleCells as! [AddEventCell]).first(where: {$0.cellType == .text})?.eventNameTextField, let eventDatePicker = (addEventTableView.visibleCells as! [AddEventCell]).first(where: {$0.cellType == .date})?.eventDatePicker else {
            fatalError()
        }
        
        if eventNameTextField.text != "" {
            let newEvent = Event(context: context)
            newEvent.name = eventNameTextField.text
            newEvent.date = eventDatePicker.date
            do {
                try context.save()
                eventNameTextField.text = ""
                showToast(message: "Saved", color: UIColor.systemGreen)
            }
            catch {
                showToast(message: error.localizedDescription, color: UIColor.systemRed)
            }
            
        }
    }
    
    func showToast(message: String, color: UIColor) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = color.withAlphaComponent(0.9)
        toastLabel.alpha = 0
        toastLabel.layer.cornerRadius = 5
        toastLabel.clipsToBounds = true
        
        let screenWidth = view.frame.width
        let labelHeight: CGFloat = 50
        let bottomPadding: CGFloat = 100
        
        toastLabel.frame = CGRect(x: 20, y: view.frame.height - bottomPadding, width: screenWidth - 40, height: labelHeight)
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 2.0, animations: {
                toastLabel.alpha = 0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}

extension AddNewEventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.addEventCellIdentifier, for: indexPath) as! AddEventCell
        
        cell.cellType = addCellTypes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
