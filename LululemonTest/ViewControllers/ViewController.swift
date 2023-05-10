//
//  AppDelegate.swift
//  LuluLemonTest
//
//  Created by Derefaa Cline on 5/10/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    // key classes are intalized here 
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    let viewModel = ListModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        segment.selectedSegmentIndex = 0
        addOrEditHobby()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // get the data base reloaded
        super.viewWillAppear(animated)
        viewModel.getDatabaseInfo(num: segment.selectedSegmentIndex)
        tblView.reloadData()
    }
    

   
    @IBAction func segmentChanged(_ sender: Any) {
    
        viewModel.getDatabaseInfo(num: segment.selectedSegmentIndex)
        tblView.reloadData()
    }
    
    // the butoon to take to the add screen
    func addOrEditHobby() {
        let btn = UIBarButtonItem.init(title: "ADD", style: .plain, target: self, action: #selector(openAddNeworEditHobbyVC))
        navigationItem.rightBarButtonItem = btn
    }
    
    
    @objc func openAddNeworEditHobbyVC() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddViewController")
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getCount()
    }
    // table to view the data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let person = viewModel.getName(index: indexPath.row)
        let name = person ?? "NA"
        let dispayString = name
        cell?.textLabel?.text = dispayString
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let addController = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController
        addController?.item = viewModel.itemArray[indexPath.row]
        self.navigationController?.pushViewController(addController!, animated: true)
        
    }
    // ability to edit the rows
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // function to edit the rows and delete that function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = viewModel.itemArray[indexPath.row]
            appdelegate.getViewContext().delete(person)
            viewModel.itemArray.remove(at: indexPath.row)
            tblView.deleteRows(at: [indexPath], with: .fade)
            appdelegate.saveContext()
            tblView.reloadData()
        }
    }
    
}
