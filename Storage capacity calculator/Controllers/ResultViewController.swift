//
//  ResultViewController.swift
//  Storage capacity calculator
//
//  Created by ak77m on 13.10.2020.
//

import UIKit

final class ResultViewController: UIViewController {
 
    @IBOutlet private weak var tableView: UITableView!
    
    var magazines : Int?
    var system : Int?  // 0-DA3s, 1-DA3, 2-DA4
    var result = Result()
    var spec : [ResultData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        result.magazinesNumber = magazines ?? 0
        result.systemName = system
        result.magazinesSets = result.optimalSet()
        spec = result.createSpecification()
        
        title = "System : \(result.systemNameString) (\(result.magazinesInSets) pcs)"
    }

    @IBAction private func summaryInfo(_ sender: UIBarButtonItem) {
        let info = result.summary(spec)
        let message = """

        Magazines: \(info[0]) pcs
         
        Overall system height : \(info[1]) U
        Data Archiver : \(info[2]) U
        Other equipment : \(4) U

        Total weight : \(info[3]) kg
        """
        popupWindow(title: "System: \(result.systemNameString)", alert: message)
    }
    
    func popupWindow(title name: String, alert message: String) {
        let alert = UIAlertController(title: name, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "< Back", style: .default)
        alert.message = message
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spec.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! ResultTableViewCell
       
        let info = spec[indexPath.row]
        cell.modelName.text = info.name
        cell.model.text = info.model
        cell.quantity.text = String(info.quantity)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        tableView.deselectRow(at: indexPath, animated: true)
        
        let info = spec[indexPath.row]
        let message  = """
        \(info.name)

        Height for 1 pcs: \(info.height) U
        Weight for 1 pcs: \(info.weight) kg
        """
        popupWindow(title: info.model, alert: message)
    }
}

