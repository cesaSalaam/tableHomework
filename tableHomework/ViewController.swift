//
//  ViewController.swift
//  tableHomework
//
//  Created by Lifoma Salaam on 2/10/16.
//  Copyright © 2016 CesaSalaam. All rights reserved.
//

import UIKit
import CoreData

//Cesa Salaam

//@02764560

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var smileyFaceLabel: UILabel!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var newNameTextField: UITextField!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var people = [NSManagedObject]()
    
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
        return people.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //loads data into cells
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            let person = people[indexPath.row]
            cell.textLabel!.text = person.valueForKey("name") as? String
        return cell
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // allows rows to be able to move when editing is on
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let itemToMove = people[fromIndexPath.row] // saves data that going to move
        people.removeAtIndex(fromIndexPath.row) // deletes data that moving from array
        people.insert(itemToMove, atIndex: toIndexPath.row)// reinserts data in to new position in array
    }
    
    @IBAction func editToggle(sender: UIBarButtonItem) {
        myTableView.setEditing(!myTableView.editing, animated: true)//changes into editing mode
        sender.title = myTableView.editing ? "editing" : "Edit" //changes the label on edit button
    }

    func saveName(name: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Person",
            inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        person.setValue(name, forKey: "name")
        
        //4
        do {
            try managedContext.save()
            //5
            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    @IBAction func addToggle(sender: UIBarButtonItem) {
        //add data into table
        if newNameTextField.hasText() == false{
            //creates an alert to add data
            //adds data into the persistant storage
        let alert = UIAlertController(title: "New Name",
            message: "Add a new name",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
                style: .Default,
                handler: { (action:UIAlertAction) -> Void in
                    
                    let textField = alert.textFields!.first
                    self.saveName(textField!.text!)
                    self.myTableView.reloadData()
            })
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
            return
        }
        else{
            // adds data through text field
            let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
            let tempInput = newNameTextField.text
            if tempInput!.stringByTrimmingCharactersInSet(whitespaceSet) == "" {
            // this statement stops user from being able to add white spaces to table
            return
        }
            if newNameTextField.hasText(){
            //adds data to tabel
                
            saveName(newNameTextField.text!)
                
            myTableView.reloadData()
                
            self.smileyFaceLabel.text = ":)"
                
            newNameTextField.text = ""
            }
            
        return
            
        }
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == .Delete {
            //self.people.removeAtIndex(indexPath.row) // remove data from array
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let moc = appDelegate.managedObjectContext
            
            // 3
            moc.deleteObject(people[indexPath.row])
            appDelegate.saveContext()
            
            // 4
            people.removeAtIndex(indexPath.row)
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

