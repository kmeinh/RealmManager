//
//  ViewController.swift
//  Database
//
//  Created by Konstantin Deichmann on 03/03/2017.
//  Copyright © 2017 Konstantin Deichmann. All rights reserved.
//

import UIKit
import RealmManager

class Entity 			: Object {

	override var description: String {
		return "\(self.identifier)"
	}

	dynamic var identifier 	: Int = 0
	dynamic var name		: String?

	override static func primaryKey() -> String? {
		return "identifier"
	}
}

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		var entities = [Entity]()

		for i in 0...1000 {
			let entity = Entity()
			entity.identifier = i
			entity.name = "Entity #\(i)"
			entities.append(entity)
		}

		RealmManager.save({
			entities.save()
		}, completion: {
			print("done")
		})
	}
}
