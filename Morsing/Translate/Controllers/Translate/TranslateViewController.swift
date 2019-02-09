//
//  TranslateViewController.swift
//  Morsing
//
//  Created by Levy Cristian  on 11/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import AVFoundation

class TranslateViewController: UIViewController {
    
    public var isTranslateToMorse: Bool = false
    private var player: AVQueuePlayer?
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .clear
        scroll.bounces = true
        scroll.alwaysBounceVertical = true
        scroll.keyboardDismissMode = .onDrag
        return scroll
    }()
    fileprivate lazy var translateView: TranslateView = {
        let view = TranslateView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgoundGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUp()
    }
    
    fileprivate func setUp(){
        tabBarSetup()
        addViews()
        setUPConstraints()
        translateView.setUP()
        _ = isTranslateToMorse ? (navigationBarSetup(name: "Morse"), translateView.setUPMorse()) :  (navigationBarSetup(name: "Text"), translateView.setUPText())
        
        translateView.tap.addTarget(self, action: #selector(chageArrow))
        translateView.hearButton.addTarget(self, action: #selector(soundAction), for: .touchUpInside)
        translateView.copyButton.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
        translateView.inputTextView.delegate = self
    }
     
    fileprivate func addViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(translateView)
        
    }
    
    fileprivate func setUPConstraints(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        translateView.translatesAutoresizingMaskIntoConstraints = false
        translateView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        translateView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        translateView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        translateView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1, constant: 0).isActive = true
        

    }

    fileprivate func navigationBarSetup(name: String) {
        
        navigationItem.title = name
        navigationController?.navigationBar.tintColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isOpaque = false
        
    }
    fileprivate func tabBarSetup(){
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.isOpaque = false
        
    }
    @objc private func chageArrow(){
        if isTranslateToMorse {
            isTranslateToMorse = false
            navigationItem.title = "Text"
            translateView.setUPText()
        }else{
            isTranslateToMorse = true
            navigationItem.title = "Morse"
            translateView.setUPMorse()
        }
    }
    @objc private func soundAction(){
        let morsePartial = translateView.responseTextView.text.replacingOccurrences(of: "-", with: "1")
        let morse = morsePartial.replacingOccurrences(of: ".", with: "0")
        let morseArray: [Int?] = Array(morse).map { (char) -> Int? in
            guard let num =  Int(String(char)) else {return nil}
            return num
        }
        guard let morseSound = morseArray as? [Int] else {return}
        self.player = SoundManager.shared.soundOf(message: morseSound)
        self.player?.play()
    }
    @objc private func copyAction(){
       UIPasteboard.general.string = translateView.responseTextView.text
        self.showAlert(title: "Morse code was copy", menssage: nil, dismissTime: 2)
    }
    

}
extension TranslateViewController: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type something..."
            textView.textColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:0.5)
            translateView.responseTextView.text = "Response goes here"
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red:0.20, green:0.30, blue:0.36, alpha:0.5) {
            textView.text = nil
            textView.textColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:1.0)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {

        if isTranslateToMorse{
            
        }else{
            let result = TranslateManager.shared.translate(textToMorse: textView.text)
            if result.success{
                translateView.responseTextView.text = result.morse
            }else{
                guard let invalidChar = result.invalidChar else {return}
                 textView.text = textView.text.replacingOccurrences(of: "\(invalidChar)", with: "", options: .literal, range: nil)
                self.showAlert(title: "Worng Format", menssage: " \" \(String(invalidChar)) \" is an invalid Character", dismissTime: UInt64(2.5))

            }
        }
    }
}
