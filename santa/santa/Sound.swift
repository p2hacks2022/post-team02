//
//  Sound.swift
//  santa
//
//  Created by saya shinbo on 2022/12/18.
//

import Foundation
import AVFoundation

class soundplay: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?

    func playAudio() {
        guard let url = Bundle.main.url(forResource: "xmassongbgm", withExtension: "mp3") else { return }
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        audioPlayer?.delegate = self
        audioPlayer?.play()
       // audioPlayer?.numberOfLoops = -1 //ループ再生
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Did finish Playing")
    }
}
