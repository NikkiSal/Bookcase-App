//
//  BookViewController.swift
//  BookCase

import UIKit

protocol BookViewControllerDelegate: AnyObject { //AnyObject defines the protocol as classonly
    func saveBook(_ book:Book)
}

class BookViewController: UIViewController {
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var isbnStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outerStackView: UIStackView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var isbnTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    weak var delegate:BookViewControllerDelegate?
    var book:Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = book {
            bookCover.image = book.cover
            titleTextField.text = book.title
            authorTextField.text = book.author
            isbnTextField.text = book.isbn
            notesTextView.text = book.notes
            navigationItem.title = "Edit book" // because add book doesn't make sense now
        }
    }
    @IBAction func touchCancel(_ sender: Any) {
        dismissMe()
    }
    
    @IBAction func touchSave(_ sender: Any) {
        let bookToSave = Book(title: titleTextField.text!,
                              author: authorTextField.text!,
                              rating: 3,
                              isbn: isbnTextField.text!,
                              notes: notesTextView.text!)
        delegate?.saveBook(bookToSave)
        dismissMe()
    }
    
    func dismissMe() {
        if presentingViewController != nil {
            //was presented via modal segue
            dismiss(animated: true, completion: nil) // a viewController can request itself to be dismissed with this method
        } else {
            // was pushed onto navigation stack
            navigationController!.popViewController(animated: true)
        }
    }
    
    
    @objc func keyboardFrameChanges(notification:Notification) {
         //@objc is because of #selector
        
        guard let userInfo = notification.userInfo,
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        let offset = self.view.frame.height - keyboardFrame.origin.y // this is to define the which is how much it should go up, which is the height of the root view - the height of the keyboard
        
        scrollView.contentInset.bottom =  offset
        scrollView.verticalScrollIndicatorInsets.bottom = offset
        if let textView = firstResponder as? UITextView, let textViewSuperview = textView.superview { // reference to the stackview and its superview
            let textViewFrame =  outerStackView.convert(textView.frame, from: textViewSuperview) // convert the coordinates
            scrollView.scrollRectToVisible(textViewFrame, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChanges), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    } // for object:nil, you can choose to recieve notification from a specific publisher
    
    override func viewDidDisappear(_ animated: Bool) { //when scene is no longer active, we want the viewController to stop recieving notifications
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

extension BookViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // this is dismissing the keyboard when you press the return key
        return true // it doesn't matter if this returns true or false
    }
}
