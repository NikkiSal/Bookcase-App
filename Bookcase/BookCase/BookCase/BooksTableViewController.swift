//
//  BooksTableViewController.swift
//  BookCase
//
//  Copyright © 2019 Myph. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController {
    
    var booksManager = BooksManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return booksManager.bookCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        let book = booksManager.getBook(at: indexPath.row)
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.author
        cell.imageView?.image = book.cover

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //because the segue was setup in InterfaceBuilder, the instantiated of the new viewcontroller was done automatically, so we don't have a reference to this new viewController. Good thing is that view controllers have a method
        // this is called when any new viewcontrollers are instantiated but before the segue is performed.
        if let navContorller = segue.destination as? UINavigationController, //the destination property is the detination view controller for the segue, this destination property will be the navigation controller because the viewcontroller is in the navigation controller
            let viewController = navContorller.topViewController as? BookViewController { //navigation controllers have a property called the topViewController that contain the first view controller in a stack and this is our bookViewController
            viewController.delegate = self
        }
        
    }
    
}

extension BooksTableViewController:BookViewControllerDelegate {
    func saveBook(_ book:Book) {
        booksManager.addBook(book)
        tableView.reloadData() // update the table
    }
}
