//
//  VoiceViewController.swift
//  EasyShare
//
//  Created by Stephen on 9/21/17.
//  Copyright © 2017 Appkoder. All rights reserved.
//

import UIKit
import AVFoundation
import Social
import MessageUI

class VoiceViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UITextViewDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        if result == .cancelled
        {
            print("your message was sent successfully")
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playButton.isEnabled = false
        stopButton.isEnabled = false
        
        let fileMgr = FileManager.default
        
        let dirPaths = fileMgr.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        
        let soundFileURL = dirPaths[0].appendingPathComponent("sound.caf")
        
        let recordSettings =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
             AVEncoderBitRateKey: 16,
             AVNumberOfChannelsKey: 2,
             AVSampleRateKey: 44100.0] as [String : Any]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(
                AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL,
                                                settings: recordSettings as [String : AnyObject])
            audioRecorder?.prepareToRecord()
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
    }

    @IBAction func recordAudio(_ sender: Any) {
        if audioRecorder?.isRecording == false {
            playButton.isEnabled = false
            stopButton.isEnabled = true
            audioRecorder?.record()
        }
    }
    
    @IBAction func stopAudio(_ sender: Any) {
        stopButton.isEnabled = false
        playButton.isEnabled = true
        recordButton.isEnabled = true
        
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
    }

    @IBAction func playAudio(_ sender: Any) {
        if audioRecorder?.isRecording == false {
            stopButton.isEnabled = true
            recordButton.isEnabled = false
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf:
                    (audioRecorder?.url)!)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func shareWithSms(_ sender: Any) {
        if MFMessageComposeViewController.canSendText()
        {
            let smsVC = MFMessageComposeViewController()
            smsVC.messageComposeDelegate = self
            //smsVC.body = textview.text
            smsVC.recipients = ["8373837383", "8283930203"]
            
            smsVC.addAttachmentURL((audioRecorder?.url)!, withAlternateFilename: "sound.caf")
            present(smsVC, animated: true)
        }
    }
    
    @IBAction func shareWithEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail()
        {
            let emailVC = MFMailComposeViewController()
            emailVC.mailComposeDelegate = self
            emailVC.setSubject("Cool App")
            emailVC.setToRecipients(["dee@email.com"])
            emailVC.setMessageBody("Hi Sir,", isHTML: true)
            
            if let fileData = NSData(contentsOfFile: (audioRecorder?.url.path)!) {
                //println("File data loaded.")
                emailVC.addAttachmentData(fileData as Data, mimeType: "audio/wav", fileName: "swifts")
            }
            present(emailVC, animated: true)
        }
        else{
            
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if result == .saved
        {
            
        }else if result == .sent{
            
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audio Record Encode Error")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
