//
//  URL+Directoryies.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation

extension URL {
    
    static func applicationSupportDirectoryURL() throws -> URL {
       return try getSearchingPath(for: .applicationSupportDirectory)
    }
    
    static func documentDirectoryURL() throws -> URL {
        return try getSearchingPath(for: .documentDirectory)
    }
    
    static func cacheDirectoryURL() throws -> URL {
        return try getSearchingPath(for: .cachesDirectory)
    }
    
    static func getSearchingPath(for searchingPath: FileManager.SearchPathDirectory = .applicationSupportDirectory) throws -> URL {
        guard let path = FileManager.default.urls(for: searchingPath, in: .userDomainMask).last else {
            throw POSIXError(.ENOENT)
        }
        
        try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
        
        return path
    }
    
}
