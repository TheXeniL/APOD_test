//
//  ConfigManager.swift
//  APOD
//
//  Created by Nikita Elizarov on 29.01.2022.
//

import Foundation

/// API keys are not usually stored in the application but are fetched from the server at a runtime, but
/// to ensure some way of safety of reverse engineering we will be storing it in the Configs file and won't commit to git

final class ConfigManager: ConfigManagerProtocol {

    func retrieveNASAApiKey() -> String? {
        guard let filePath = Bundle.main.path(forResource: "Configs", ofType: "plist") else {
            print("Couldn't find file 'Configs.plist'.")
            return nil
        }

        let plist = NSDictionary(contentsOfFile: filePath)

        guard let value = plist?.object(forKey: "NASA_API_KEY") as? String else {
            print("Couldn't find key 'NASA_API_KEY' in 'Configs.plist'.")
            return nil
        }

        return value
    }
}
