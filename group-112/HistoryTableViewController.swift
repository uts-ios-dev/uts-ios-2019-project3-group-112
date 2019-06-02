


import UIKit

class HistoryTableViewController: UITableViewController {
    
//     var scoresFromData: [Result] = [Result]()
     var resultsFromData: [Result] = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let retrievedResults = appDelegate.getResult()

        if retrievedResults.count != 0{
            resultsFromData = retrievedResults.map({
                convertEntityResultToResult(result: $0)
            })

            animate()
        }
    }

    func convertEntityResultToResult(result: ResultEntity) -> Result {
        let newResult = Result( sDesc: result.sDesc!, sImage: result.sImage!  )
        return newResult
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultsFromData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = resultsFromData[indexPath.row].sDesc
        cell.imageView?.image = UIImage(data: resultsFromData[indexPath.row].sImage)
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
}