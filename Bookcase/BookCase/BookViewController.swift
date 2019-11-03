//
//  BookViewController.swift
//  BookCase
//
//  Created by Marzieh on 2019-10-31.
//  Copyright © 2019 Myph. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var isbnStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // you can put an infoButton and make the isbn isHidden here
    }
    
    @objc func keyboardFrameChanges(notification:Notification) {
         //@objc is because of #selector
        
        guard let userInfo = notification.userInfo else { return }
        guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        var offset:CGFloat = 0
        if let firstResponder = firstResponder {
            let frFrame = self.view.convert(firstResponder.frame, from: firstResponder) // because it was in stackview, we have to convert it to the root view coordinates
            let frMaxY = frFrame.maxY // the max y coordinate of the first responder frame
            if frMaxY > keyboardFrame.origin.y {
                offset = frMaxY - keyboardFrame.origin.y
            }
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
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true) //goes on a hunt on its subview hierarchy to find the first responder, then requests it to resign
    }
}

extension BookViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // this is dismissing the keyboard when you press the return key
        return true // it doesn't matter if this returns true or false
    }
}
