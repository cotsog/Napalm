//
//  Audio.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//

import Foundation
import AudioToolbox
import AVFoundation

public class NPFAudio {
    
    public init() {}
    
    /**
     This enum is used in setting the proper file type in the playSimpleAudio function.
     */
    public enum SimpleAudioFileType {
        case wav
        case caf
        case aif
    }
    
    /**
     This enum is used in setting the proper file type in the playAudio function.
     */
    public enum AudioFileType {
        case m4a
        case mp3
        case acc
        case m4b
        case m4p
        case m4v
        case m4r
        case mp4
        case ac3
        case eac3
        case ilbc
        case lbc
        case ima4
    }
    
    /**
     Plays an audio file with the name and file extension passed in. Uses the simple audio types of .wav, .caf and .aif that are supported by AudioServices.
     */
    public class func playSimpleAudio(withFileName fileName: String, andExtension fileExtension: SimpleAudioFileType) {
        
        var sound: SystemSoundID = 0
        
        var fileExtension: String {
            switch fileExtension {
            case .wav: return "wav"
            case .caf: return "caf"
            case .aif: return "aif"
            }
        }
        
        guard let path = Bundle.main().pathForResource(fileName, ofType: fileExtension) else {
            return
        }
        
        let urlPath = URL(fileURLWithPath: path)
        
        AudioServicesCreateSystemSoundID(urlPath, &sound)
        AudioServicesPlaySystemSound(sound)
    }
    
    /**
     Plays an audio file with the name and file extension passed in. Uses the audio types that are not supported by AudioServices such as .m4a and .mp3.
     */
    public class func playAudio(withFileName fileName: String, andExtension fileExtension: AudioFileType) {
        
        let player = AVQueuePlayer()
        
        var fileExtension: String {
            switch fileExtension {
            case .m4a: return "m4a"
            case .mp3: return "mp3"
            case .acc: return "acc"
            case .m4b: return "m4b"
            case .m4p: return "m4p"
            case .m4v: return "m4v"
            case .mp4: return "mp4"
            case .ac3: return "ac3"
            case .eac3: return "eac3"
            case .ilbc: return "ilbc"
            case .lbc: return "lbc"
            case .ima4: return "ima4"
            case .m4r: return "m4r"
            }
        }
        
        guard let path = Bundle.main().pathForResource(fileName, ofType: fileExtension) else {
            return
        }
        
        let urlPath = URL(fileURLWithPath: path)
        
        player.removeAllItems()
        player.insert(AVPlayerItem(url: urlPath), after: nil)
        player.play()
    }
}

