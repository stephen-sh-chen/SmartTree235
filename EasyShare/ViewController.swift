//
//  ViewController.swift
//  EasyShare
//
//  Created by Appkoder on 05/10/2016.
//  Copyright © 2016 Appkoder. All rights reserved.
//

import UIKit
import Social
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var textview: UITextView!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var otherButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textview.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }

    @IBAction func facebook(_ sender: AnyObject) {
        
        let facebookShare = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        if let facebookShare = facebookShare
        {
            facebookShare.add(imgView.image!)
            facebookShare.setInitialText(textview.text)
            
            present(facebookShare, animated: true)
        }
    }

    @IBAction func twitter(_ sender: AnyObject) {
        
        let twitterShare = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        if let twitterShare = twitterShare
        {
            twitterShare.add(imgView.image!)
            twitterShare.setInitialText(textview.text)
            
            present(twitterShare, animated: true)
        }
    }

    @IBAction func email(_ sender: AnyObject) {
        
        if MFMailComposeViewController.canSendMail()
        {
            let emailVC = MFMailComposeViewController()
            emailVC.mailComposeDelegate = self
            emailVC.setSubject("Cool App")
            emailVC.setToRecipients(["dee@email.com"])
            emailVC.setMessageBody(textview.text, isHTML: true)
            
            let imageData = UIImagePNGRepresentation(imgView.image!)
            emailVC.addAttachmentData(imageData!, mimeType: "image/png", fileName: "picture.png")
            
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
    
    @IBAction func sms(_ sender: AnyObject) {
        
        if MFMessageComposeViewController.canSendText()
        {
            let smsVC = MFMessageComposeViewController()
            smsVC.messageComposeDelegate = self
            smsVC.body = textview.text
            smsVC.recipients = ["8373837383", "8283930203"]
            
            let imageData = UIImagePNGRepresentation(imgView.image!)
            smsVC.addAttachmentData(imageData!, typeIdentifier: "identifier", filename: "picture.png")
            
            present(smsVC, animated: true)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        if result == .cancelled
        {
            print("your message was sent successfully")
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    @IBAction func share(_ sender: AnyObject) {
        
        let shareVC = UIActivityViewController(activityItems: [imgView.image!, textview.text], applicationActivities: [])
        
        shareVC.popoverPresentationController?.barButtonItem = shareButton
        
        present(shareVC, animated: false)
    }
    
    @IBAction func others(_ sender: AnyObject) {
        
        let shareVC = UIActivityViewController(activityItems: [imgView.image!, textview.text], applicationActivities: [])
        
        shareVC.popoverPresentationController?.barButtonItem = shareButton
        
        present(shareVC, animated: false)
    }
}

