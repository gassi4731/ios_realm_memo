//
//  Memo.swift
//  ios_realm_memo
//
//  Created by Yo Higashida on 2021/04/19.
//

import Foundation
import RealmSwift

class Memo: Object {
    @objc dynamic var title: String=""
    @objc dynamic var content: String=""
    @objc dynamic var updateData: Date=Date()
}
