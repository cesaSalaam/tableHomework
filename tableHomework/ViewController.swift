//
//  ViewController.swift
//  tableHomework
//
//  Created by Lifoma Salaam on 2/10/16.
//  Copyright © 2016 CesaSalaam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var smileyFaceLabel: UILabel!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var newNameTextField: UITextField!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var myArray:[String] = ["Cesa","Saboor","Khabeer"]
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        //stops keyboard when return is touched
        newNameTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func editingBeganTextField(sender: UITextField) {
        
        self.smileyFaceLabel.text = ":("
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //resigns keyboard when background is touched
        self.view.endEditing(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        //sets number of sections in table
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // returns the number of rows in section
        return myArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //loads data into cells
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = myArray[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // allows rows to be able to move when editing is on
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let itemToMove = myArray[fromIndexPath.row] // saves data that going to move
        myArray.removeAtIndex(fromIndexPath.row) // deletes data that moving from array
        myArray.insert(itemToMove, atIndex: toIndexPath.row)// reinserts data in to new position in array
    }
    
    @IBAction func editToggle(sender: UIBarButtonItem) {
        myTableView.setEditing(!myTableView.editing, animated: true)//changes into editing mode
        sender.title = myTableView.editing ? "Stop editing" : "Edit" //changes the label on edit button
    }

    @IBAction func addToggle(sender: UIBarButtonItem) {
        //add data into table
        
        let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
        let tempInput = newNameTextField.text
        if tempInput!.stringByTrimmingCharactersInSet(whitespaceSet) == "" {
            // this statement stops user from being able to add white spaces to table
            return
        }
        if newNameTextField.hasText(){
            //adds data to tabel
            myArray.append(newNameTextField.text!)
            myTableView.reloadData()
            self.smileyFaceLabel.text = ":)"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == .Delete {
            self.myArray.removeAtIndex(indexPath.row) // remove data from array
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

