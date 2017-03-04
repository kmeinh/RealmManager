//
//  DatabaseWrapper+Logging.swift
//  Database
//
//  Created by Konstantin Deichmann on 03/03/2017.
//  Copyright © 2017 Konstantin Deichmann. All rights reserved.
//

import Foundation

// MARK: - LogLevel

enum LogLevel		: Int {

	case debug		= 0
	case warning
	case error
	case none
}

// MARK: - Log

struct Log {

	static let shared 	= Log()

	var logLevel		= LogLevel.none

	private static func log(level: LogLevel, msg: Any) {
		guard (self.shared.logLevel.rawValue < level.rawValue) else {
			return
		}

		print("DatabaseWrapper: \(msg)")
	}

	static func debug(_ msg: Any) {
		self.log(level: .debug, msg: msg)
	}

	static func warning(_ msg: Any) {
		self.log(level: .warning, msg: msg)
	}

	static func error(_ msg: Any) {
		self.log(level: .error, msg: msg)
	}
}
