//
//  AddNewEventViewController.swift
//  EventChrono
//
//  Created by Petr Dumanov on 10.03.2025.
//

import UIKit
import CoreData

class AddNewEventViewController: UIViewController {

    @IBOutlet weak var eventNameTextField: UITextField!
    
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameTextField.delegate = self
    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
        if eventNameTextField.text != "" {
            let newEvent = Event(context: context)
            newEvent.name = eventNameTextField.text
            newEvent.date = eventDatePicker.date
            do {
                try context.save()
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

extension AddNewEventViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
