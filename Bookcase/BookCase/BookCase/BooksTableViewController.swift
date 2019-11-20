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
    // This is for other action in swipe
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Exterminate") { (contextAction, sourceView, completionHandler) in
            self.booksManager.removeBooks(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        let cancelAction = UIContextualAction(
        style: .destructive,
        title: "Cancel") { (contextAction, sourceView, completionHandler) in
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction,cancelAction])
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
     
    */

    
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            booksManager.removeBooks(at: indexPath.row) //update data source first before dealing with table view
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow, // to see which row it is selected
            let viewController = segue.destination as? BookViewController { // get a reference to the BookViewController
            viewController.delegate = self
            viewController.book = booksManager.getBook(at: selectedIndexPath.row)
        }
        //because the segue was setup in InterfaceBuilder, the instantiated of the new viewcontroller was done automatically, so we don't have a reference to this new viewController. Good thing is that view controllers have a method,this is called when any new viewcontrollers are instantiated but before the segue is performed.
        else if let navContorller = segue.destination as? UINavigationController, //the destination property is the detination view controller for the segue, this destination property will be the navigation controller because the viewcontroller is in the navigation controller
            let viewController = navContorller.topViewController as? BookViewController { //navigation controllers have a property called the topViewController that contain the first view controller in a stack and this is our bookViewController
            viewController.delegate = self
        }
        
    }
    
    @IBAction func changedSegment(_ sender: UISegmentedControl) {
        guard let sortOrder = SortOrder(rawValue: sender.selectedSegmentIndex)
            else {return}
        booksManager.sortOrder = sortOrder
        tableView.reloadData()
    }
    
    
}

extension BooksTableViewController:BookViewControllerDelegate {
    func saveBook(_ book:Book) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            //Update book
            booksManager.updateBook(at: selectedIndexPath.row, with: book)
        } else {
            //Add book
            booksManager.addBook(book)
        }
        tableView.reloadData() // update the table
    }
}
