//
//  Song.swift
//  SongsPlayer
//
//  Created by JUAN ANDRÉS CÁRDENAS DIAZ on 17/04/16.
//  Copyright © 2016 JUAN ANDRÉS CÁRDENAS DIAZ. All rights reserved.
//

import Foundation


struct Song {
    
    var name: String?
    var artist: String?
    var cover: String?
    var audio : String?
    var audioExtension : String?
    
    init(name: String?, artist: String?, cover: String?, audio: String?, audioExtension: String?) {
        
        self.name = name
        self.artist = artist
        self.cover = cover
        self.audio = audio
        self.audioExtension = audioExtension
    }
}