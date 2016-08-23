//
//  Audio.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//
//
//  Copyright (c) 2016 Caleb Kleveter
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import AudioToolbox
import AVFoundation

/**
 For easily playing audio files.
*/
public class NPFAudio {
    
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
     
     - parameter fileName: This is the name of the file *without* the extension.
     - parameter fileExtension: The extension of the file. This comes from the SimpleAudioFileType enum.
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
     
     - parameter fileName: This is the name of the file *without* the extension.
     - parameter fileExtension: The extension of the file. This comes from the AudioFileType enum.
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

