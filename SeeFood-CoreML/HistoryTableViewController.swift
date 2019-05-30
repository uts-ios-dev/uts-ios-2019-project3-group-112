

//
//  HistoryTableViewController.swift
//  SeeFood-CoreML
//
//  Created by Xiaoran Luo on 30/5/19.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
     var scoresFromData: [Score] = [Score]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let retrievedScores = appDelegate.getScore()
        
        if retrievedScores.count != 0{
            scoresFromData = retrievedScores.map({
                convertEntityScoreToScore(score: $0)
            })
            
            animate()
        }
    }
    
    
    func convertEntityScoreToScore(score: ScoreEntity) -> Score {
        let newScore = Score(playerName: score.playerName!  )
        return newScore
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scoresFromData.count
    }
    
    //using data to set the cell's textLabel and detailTextLable
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = scoresFromData[indexPath.row].playerName
        return cell
    }
    
    // animation of displaying table view
    func animate(){
        tableView.reloadData()
        let visibleCells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in visibleCells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayOffset: Double = 0.0
        for cell in visibleCells{
            UIView.animate(withDuration: 3,
                           delay: delayOffset * 0.05,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            cell.transform = CGAffineTransform.identity
            }) { (success: Bool) in
                if success{
                }
            }
            delayOffset += 1
        }
    }
    
    /*
     
     }
     //    override func viewWillAppear(_ animated: Bool) {
     //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     //        let retrievedScores = appDelegate.getScore()
     //
     //        //        for score in retrievedScores{
     //        //            scoresFromData.append(convertEntityScoreToScore(score: score))
     //        //        }
     //
     //        scoresFromData = retrievedScores.map({
     //            convertEntityScoreToScore(score: $0)
     //        }).sorted(by: {$0.score > $1.score})
     //
     //        animate()
     //    }
     //
     //    //    func loadHighScore() {
     //    //        do {
     //    //            var scoreboard = try
     //    //            scoreboard.sort(by: { $0.score > $1.score })
     //    //            highScore = scoreboard[0].score
     //    //        } catch {
     //    //            highScore = 0
     //    //        }
     //    //    }
     //    //
     //    //
     //    func convertEntityScoreToScore(score: ScoreEntity) -> Score {
     //        let newScore = Score(playerName: score.playerName! , score: score.score )
     //        return newScore
     //    }
     //    var scoresFromData: [Score] = [Score]()
     //
     //
     //
     //
     //    // MARK: - Table view data source
     //
     //  func numberOfSections(in tableView: UITableView) -> Int {
     //        // #warning Incomplete implementation, return the number of sections
     //        return 1
     //    }
     //
     //     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     //        // #warning Incomplete implementation, return the number of rows
     ////        return scoresFromData.count
     //        return 10
     //    }
     //
     //
     //   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     //        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
     //        cell.textLabel?.text = scoresFromData[indexPath.row].playerName
     //        cell.detailTextLabel?.text = String(scoresFromData[indexPath.row].score)
     //
     //
     //        return cell
     //    }
     //
     //    func animate(){
     //        tableView.reloadData()
     //        let visibleCells = tableView.visibleCells
     //        let tableViewHeight = tableView.bounds.size.height
     //
     //        for cell in visibleCells {
     //            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
     //        }
     //        var delayOffset: Double = 0.0
     //        for cell in visibleCells{
     //            UIView.animate(withDuration: 3,
     //                           delay: delayOffset * 0.05,
     //                           usingSpringWithDamping: 0.8,
     //                           initialSpringVelocity: 0,
     //                           options: .curveEaseInOut,
     //                           animations: {
     //                            cell.transform = CGAffineTransform.identity
     //            }) { (success: Bool) in
     //                if success{
     //
     //                }
     //            }
     //            delayOffset += 1
     //        }
     //
     //    }
     //    /*
     //    // MARK: - Navigation
     //
     //    // In a storyboard-based application, you will often want to do a little preparation before navigation
     //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //        // Get the new view controller using segue.destination.
     //        // Pass the selected object to the new view controller.
     //    }
     //    */
     //
     //}*/
    
}
