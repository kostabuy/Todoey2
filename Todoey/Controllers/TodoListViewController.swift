//
//  ViewController.swift
//  Todoey
//
//  Created by hpq on 3/7/18.
//  Copyright © 2018 AlRuk. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //These strings will be the data for the table view cells
    var itemArray = [Item]()                // TURING THE ARRY INTO CLASS FROM MODEL ...!!!
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        
        let newItem2 = Item()
        newItem2.title = "Vyt Eggis"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Stratogem"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellRowAtIndexPath")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        // cell.accessoryType = item.done == true ? .checkmark : .none
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)       // Prints the number
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        //changing the highlight behaviour
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user click the Add button on our AIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}













/* TableView is divided into sections. Each section contains some number of rows. IndexPath contains information about which row in which section the function is asking about. Base on this numbers you are configuring the cell to display the data for given row. Application is executing this function when it needs to display a row. For example you scroll the tableview down and next cell will appear on the screen. To configure this cell with, for example, correct texts, it's asking you what should be displayed on row which is at this position (section and row).
 
 Also, to improve performance you should create the cell using tableView.dequeueReusableCellWithIdentifier function instead of Cell's init. */
