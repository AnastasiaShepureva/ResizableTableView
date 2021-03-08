//
//  ViewController.swift
//  ResizableTableView
//
//  Created by Anastasia Shepureva on 08.03.2021.
//

import UIKit

class ViewController: UIViewController {
    var cellsCount: Int = 1
    let cellHeight: CGFloat = 50
    let maxTableViewHeight: CGFloat = 400
    var currentTableViewHeight: CGFloat!
    
    @IBOutlet weak var stretchebleHeight: NSLayoutConstraint!
    
    @IBOutlet weak var addCellBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var removeCellBarButtonItem: UIBarButtonItem!
    
    @IBAction func removeCell(_ sender: UIBarButtonItem) {
        guard cellsCount != 1 else {return}
        cellsCount -= 1
        
        if stretchebleHeight.constant > currentTableViewHeight {
            UIView.animate(withDuration: 0.3) {[self] in
                stretchebleHeight.constant -= cellHeight
            }
        }
        

        stretchableTableView.beginUpdates()
        let indexPath = IndexPath(row: cellsCount, section: 0)
        stretchableTableView.deleteRows(at: [indexPath], with: .fade)
        stretchableTableView.endUpdates()

    }
    
    @IBAction func addCell(_ sender: UIBarButtonItem) {
        cellsCount += 1
        
        if stretchebleHeight.constant < maxTableViewHeight {
            UIView.animate(withDuration: 0.3) {[self] in
                stretchebleHeight.constant += cellHeight
            }
        }
        
        stretchableTableView.beginUpdates()
        let indexPath = IndexPath(row: cellsCount - 1, section: 0)
        stretchableTableView.insertRows(at: [indexPath], with: .fade)
        stretchableTableView.endUpdates()
        
        stretchableTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    @IBOutlet weak var stretchableTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTableViewHeight = stretchebleHeight.constant
    }


    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "My cell \(String(describing: indexPath.row + 1))"
    
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Stretcheble TableView"
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
}
