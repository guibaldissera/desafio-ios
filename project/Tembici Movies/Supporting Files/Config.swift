//
//  Config.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 09/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import Foundation

class Config {

    static var ServerURL: URL {
        guard let urlProperty = Bundle.main.object(forInfoDictionaryKey: "ServerURL") as? String else {
            fatalError("Fail to get ServerURL property")
        }
        guard let url = URL(string: urlProperty) else {
            fatalError("Invalid ServerURL property")
        }
        return url
    }

    static var ServerToken: String {
        guard let token = Bundle.main.object(forInfoDictionaryKey: "ServerToken") as? String else {
            fatalError("Fail to get TokenAPI property")
        }
        return token
    }
}
