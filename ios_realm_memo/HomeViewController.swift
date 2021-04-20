//
//  HomeViewController.swift
//  ios_realm_memo
//
//  Created by Yo Higashida on 2021/04/19.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    let realm = try! Realm()
    var memos: Results<Memo>!
    var memoId = Int()
    var isNew = Bool()
    
    @IBOutlet var memoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memos = realm.objects(Memo.self)
        
        memoTable.dataSource = self
        memoTable.delegate = self
        
        self.memoTable.reloadData()
        print("aaa")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memos = realm.objects(Memo.self)
        self.memoTable.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! MemoTableViewCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd", options: 0, locale: Locale(identifier: "ja_JP"))
        let title: String = memos[indexPath.row].title
        let content: String = memos[indexPath.row].content
        let updateDate: String = formatter.string(from: memos[indexPath.row].updateData)
        cell.setup(title: title, content: content, updateDate: updateDate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        memoId = indexPath.row
        performSegue(withIdentifier: "goEdit", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEdit" {
            let svc = segue.destination as! EditViewController
            svc.memoId = memoId
            svc.isNew = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}
