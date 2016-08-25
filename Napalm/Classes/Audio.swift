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
    public enum SimpleAudioFileType: String {
        
        /**
         For 'simple' audio files with the .wav extension
        */
        case wav
        
        /**
         For 'simple' audio files with the .caf extension
        */
        case caf
        
        /**
         For 'simple' audio files with the .aif extension
        */
        case aif
    }
    
    /**
     This enum is used in setting the proper file type in the playAudio function.
    */
    public enum AudioFileType: String {
        
        /**
         For audio files with the .m4a extension
        */
        case m4a
        
        /**
         For audio files with the .mp3 extension
        */
        case mp3
        
        /**
         For audio files with the .acc extension
         */
        case acc
        
        /**
         For audio files with the .m4b extension
         */
        case m4b
        
        /**
         For audio files with the .m4p extension
         */
        case m4p
        
        /**
         For audio files with the .m4v extension
         */
        case m4v
        
        /**
         For audio files with the .m4r extension
         */
        case m4r
        
        /**
         For audio files with the .mp4 extension
         */
        case mp4
        
        /**
         For audio files with the .ac3 extension
         */
        case ac3
        
        /**
         For audio files with the .eac3 extension
         */
        case eac3
        
        /**
         For audio files with the .ilbc extension
         */
        case ilbc
        
        /**
         For audio files with the .lbc extension
         */
        case lbc
        
        /**
         For audio files with the .ima4 extension
         */
        case ima4
    }
    
    /**
     Plays an audio file with the name and file extension passed in. Uses the simple audio types of .wav, .caf and .aif that are supported by AudioServices.
     
     - parameter fileName: This is the name of the file *without* the extension.
     - parameter fileExtension: The extension of the file. This comes from the SimpleAudioFileType enum.
     */
    public class func playSimpleAudio(withFileName fileName: String, andExtension fileExtension: SimpleAudioFileType) {
        
        var sound: SystemSoundID = 0
        
        guard let path = Bundle.main().pathForResource(fileName, ofType: fileExtension.rawValue) else {
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
        
        guard let path = Bundle.main().pathForResource(fileName, ofType: fileExtension.rawValue) else {
            return
        }
        
        let urlPath = URL(fileURLWithPath: path)
        
        player.removeAllItems()
        player.insert(AVPlayerItem(url: urlPath), after: nil)
        player.play()
    }
}

