//
//  YakMeadow.swift
//  YikYak
//
//  Created by DevMountain on 9/27/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

class YakMeadow: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        YakController.shared.herdAllYaks { (yaks) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return YakController.shared.yaks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yakCell", for: indexPath)
        let yak = YakController.shared.yaks[indexPath.row]
        cell.textLabel?.text = yak.text
        cell.detailTextLabel?.text = yak.author
        
        return cell
    }

    func presentYakker(title: String, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Get Yakky 🤤"
        }
        alertController.addTextField { (authorTextField) in
            authorTextField.placeholder = "We don't recommend putting in your real name"
        }
        let yikAction = UIAlertAction(title: "Yak", style: .default) { (_) in
            
            guard let bodyText = alertController.textFields?.first?.text,
                let author = alertController.textFields?[1].text else {return}
            YakController.shared.birthYoungYak(text: bodyText, author: author, completion: { (_) in
                DispatchQueue.main.async {
                   self.tableView.reloadData()
                }
                })
        }
        let dimissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(dimissAction)
        alertController.addAction(yikAction)
        
        self.present(alertController, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toYakPen"{
            let destinationVC = segue.destination as? YakPen
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let yak = YakController.shared.yaks[indexPath.row]
            destinationVC?.yak = yak
        }
    }
    
    @IBAction func tapYak(_ sender: Any) {
        self.presentYakker(title: "Yik Me", message: nil)
    }
    
    @IBAction func refreshTheYaks(_ sender: Any) {
        YakController.shared.herdAllYaks { (yaks) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}
