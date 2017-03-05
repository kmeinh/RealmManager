//
//  RealmManager+Object.swift
//  Database
//
//  Created by Konstantin Deichmann on 03/03/2017.
//  Copyright © 2017 Konstantin Deichmann. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - DatabaseEntity

extension Object			: DatabaseEntity {}

@objc public protocol DatabaseEntity {

	/// This function should always be called in a DatabaseWrapper write-Block
	/// This function is called directly before `self` is getting deleted
	@objc optional func deleteChildEntity()
}

// MARK: - CRUD - Create, Read, Update, Delete

public extension Object {

	public func save(update: Bool = true) {
		Log.debug("Add Object: \(self)")
		RealmManager.realm?.add(self, update: update)
	}

	public func delete() {
		Log.debug("Delete Object: \(self)")
		(self as DatabaseEntity).deleteChildEntity?()
		RealmManager.realm?.delete(self)
	}
}

public extension Sequence where Iterator.Element: Object {

	public func save(update: Bool = true) {
		Log.debug("Add Objects: \(self)")
		RealmManager.realm?.add(self)
	}

	public func delete() {
		Log.debug("Delete Objects: \(self)")

		self.forEach { (entity: Object) in
			(entity as DatabaseEntity).deleteChildEntity?()
			entity.delete()
		}
	}
}
