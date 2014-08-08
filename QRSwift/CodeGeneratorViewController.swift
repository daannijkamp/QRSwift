//
//  CodeGeneratorViewController.swift
//  QRSwift
//
//  Created by Daan Nijkamp on 08-08-14.
//  Copyright (c) 2014 Daan Nijkamp. All rights reserved.
//

import UIKit

class CodeGeneratorViewController: UIViewController {

    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createQRCodeForString(codeString: NSString) -> CIImage {
        
        // Convert Input string to a UTF-8 encoded NSData object
        var stringData:NSData = codeString.dataUsingEncoding(NSUTF8StringEncoding)
        
        // Create the filter
        var codeFilter: CIFilter = CIFilter(name: "CIQRCodeGenerator")
        
        // Set the message content and error-correction level (H = 30 error resilience)
        codeFilter.setValue(stringData, forKey: "inputMessage")
        codeFilter.setValue("H", forKey: "inputCorrectionLevel")
        
        // Default output is a low res image, convert it to a higher res image 
        // Solution by http://stackoverflow.com/a/22557182
        var lowresQRImage: CIImage = codeFilter.outputImage
        var transform: CGAffineTransform = CGAffineTransformMakeScale(5.0, 5.0)
        var highresQRImage: CIImage = lowresQRImage.imageByApplyingTransform(transform)
        
        // Send the image back
        return highresQRImage
        
    }

    @IBAction func handleGenerateButtonPressed(sender: UIBarButtonItem) {
        
        // Use the conten of the inputTextField as a string
        var stringToEncode: NSString = self.inputTextField.text
        
        // Create QR Code image from input String
        var qrCode:CIImage = self.createQRCodeForString(stringToEncode)
        
        // Convert it to a UIImage
        var qrCodeImage: UIImage = UIImage(CIImage: qrCode)
        
        // Set the image
        qrCodeImageView.image = qrCodeImage
        
        // Hide Keyboard after generate button pressed
        self.inputTextField.resignFirstResponder()
        
    }
   

}
