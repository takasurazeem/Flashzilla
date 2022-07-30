//
//  FileManager+Extension.swift
//  Bucket List
//
//  Created by Takasur Azeem on 08/07/2022.
//

import Foundation

extension FileManager {
    
    static var documentsDirectory: URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
}
