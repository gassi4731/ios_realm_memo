//
//  EditViewController.swift
//  ios_realm_memo
//
//  Created by Yo Higashida on 2021/04/19.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    let realm = try! Realm()
    var memoId = Int()
    var isNew = Bool()

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("edit",memoId)
        
        titleTextField.delegate = self
        contentTextView.delegate = self
        
        if isNew {
            let memo: Memo? = read()
            
            if let memo = memo {
                titleTextField.text = memo.title
                contentTextView.text = memo.content
            }
        }
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        let title: String = titleTextField.text!
        let content: String = contentTextView.text!
        
        let memo: Memo? = read()
        
        if isNew, let memo = memo {
            try! realm.write {
                memo.title = title
                memo.content = content
            }
        } else {
            let newMemo = Memo()
            newMemo.title = title
            newMemo.content = content
            
            try! realm.write {
                realm.add(newMemo)
            }
        }
        
        let alert: UIAlertController = UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: {_ in
                self.navigationController?.popViewController(animated: true)
                self.titleTextField.text = ""
                self.contentTextView.text = ""
            })
        )
        
        present(alert, animated: true, completion: nil)
    }
    
    func read() -> Memo? {
        return realm.objects(Memo.self)[memoId]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
    }
    
}
