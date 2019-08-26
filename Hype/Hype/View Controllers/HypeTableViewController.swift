//
//  HypeTableViewController.swift
//  Hype
//
//  Created by Mitch Merrell on 8/26/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class HypeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    func loadData() {
        HypeController.shared.fetchHypes { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HypeController.shared.hypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hypeCell", for: indexPath)
        let hype = HypeController.shared.hypes[indexPath.row]
        
        cell.textLabel?.text = hype.hypeText
        cell.detailTextLabel?.text = "\(hype.timestamp)"

        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    func presentAddHypeAlert() {
        let alertController = UIAlertController(title: "Get Hype", message: "What is hype will never die", preferredStyle: .alert)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "What's hype-ening today?"
        }
        
        let addHypeAction = UIAlertAction(title: "Add Hype", style: .default) { (_) in
            guard let hypeText = alertController.textFields?.first?.text else { return }
            
            if hypeText != "" {
                HypeController.shared.saveHype(with: hypeText, completion: { (success) in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(addHypeAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAddHypeAlert()
    }
    
    
    
}
