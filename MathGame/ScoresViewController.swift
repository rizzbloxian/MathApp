//
//  ScoresViewController.swift
//  MathGame
//
//  Created by Saeed Rahman on 2/10/2025.
//

import UIKit

class ScoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    

    // decides how many rows are displayed in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (GameData.recentScores.count <= 11) {
            return GameData.recentScores.count
        }else {
            return 11
        }
        
    }
    
    // displays information into table view cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(GameData.recentScores[indexPath.row])
        return cell
        
    }
    
    @IBOutlet weak var scoresTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
