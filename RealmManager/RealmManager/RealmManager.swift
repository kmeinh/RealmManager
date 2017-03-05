//
//  RealmManager.swift
//  Database
//
//  Created by Konstantin Deichmann on 03/03/2017.
//  Copyright © 2017 Konstantin Deichmann. All rights reserved.
//

import Foundation

// MARK: - DatabaseWrapper

struct RealmManager {

	// MARK: - Write Queue

	fileprivate static let writeDispatchQueue		= DispatchQueue(label: "RealmManager.write.queue")

	// MARK: - Realm

	static var realm: Realm? {
		do {
			return try Realm()
		} catch {
			Log.error("Cannot create Realm with error: \(error)")
			return nil
		}
	}
}

// MARK: - Setup

extension RealmManager {

	static func setup(configuration: Realm.Configuration? = nil) {
		let config = Realm.Configuration(schemaVersion: 0, migrationBlock: { (migration: Migration, oldSchemaVersion: UInt64) in
			Log.debug("Executing empty migration Block for old SchemeVersion: \(oldSchemaVersion)")
		})

		Realm.Configuration.defaultConfiguration = (configuration ?? config)
	}
}

// MARK: - Write

extension RealmManager {

	// MARK: - Dispatch Sync Write Block

	fileprivate static func write(block: ((_ realm: Realm) -> Void)) {
		self.writeDispatchQueue.sync {
			guard let realm = self.realm else {
				return
			}

			do {
				try realm.write {
					block(realm)
				}
			} catch {
				Log.error("Cannot write in realm with error: \(error)")
			}
		}
	}

	// MARK: - Save

	static func save(_ saveBlock: (() -> Void), completion completionBlock: (() -> Void)?) {
		self.write { (realm: Realm) in
			saveBlock()

			DispatchQueue.main.async {
				completionBlock?()
			}
		}
	}
}
