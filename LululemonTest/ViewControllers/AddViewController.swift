//
//  AppDelegate.swift
//  LuluLemonTest
//
//  Created by Derefaa Cline on 5/10/23.
//
import UIKit
import CoreData

class AddViewController: UIViewController {

    @IBOutlet weak var btnAddUpdate: UIButton!
    @IBOutlet weak var txtName: UITextField!
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var item:Item?
    
    let addViewModel = AddViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUphideKeyboard()
    }
    // show keyboard for user to type in 
    func setUphideKeyboard() {
        let tapGest = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGest)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if item != nil {
            txtName.text = item?.name
            btnAddUpdate.setTitle("Update", for: .normal)
        }
        txtName.becomeFirstResponder() //open keyboard
    }
    
    // button to save the item
    
    @IBAction func save(_ sender: UIButton) {
        
        let name = txtName.text
        guard let insertName = name else {
            print("please enter name")
            return
        }
        if item != nil{
            item?.name = insertName
            addViewModel.updateItem(item: item!)
        
        }else {
            addViewModel.saveItem(itemName: insertName)
        }
        
        navigationController?.popViewController(animated: true)
    }

}
