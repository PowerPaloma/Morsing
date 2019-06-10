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
    private var sequence: [Int] = []
    private var actualSequence: [Int] = []
    private var isSound = false
    private var isVibrating = false
    
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
    
//    fileprivate lazy var tutorialView: CutOutShape = {
//
//        let object = translateView.arrowImage
//
//        let view = CutOutShape(frame: self.view.frame,
//                               fristObjectLocation: object.getPosition(inView: self.view),
//                               withRadius: object.frame.width)
//        view.nextButton.addTarget(self, action: #selector(goNext(_:)), for: UIControl.Event.touchUpInside)
//
//        return view
//    }()
    
//    fileprivate lazy var dimmingDynamicView: DimmingView = {
//        let object = translateView.arrowImage
//        let location = object.getPosition(inView: self.view)
//        let roundedPath = UIBezierPath(ovalIn: CGRect(x: location.x, y: location.y, width: 65, height: 65))
//
//        let view = DimmingView(frame: self.view.frame, opacity: 0.7, visiblePath: roundedPath)
//        view.nextButton.addTarget(self, action: #selector(goNext(_:)), for: UIControl.Event.touchUpInside)
//        return view
//    }()
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgoundGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        translateView.layoutSubviews()

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
        translateView.spaceLetterButton.addTarget(self, action: #selector(spaceLetter), for: .touchUpInside)
        translateView.spaceWordButton.addTarget(self, action: #selector(spaceWord), for: .touchUpInside)
        translateView.dotButton.addTarget(self, action: #selector(dot), for: .touchUpInside)
        translateView.hyButton.addTarget(self, action: #selector(hy), for: .touchUpInside)
        translateView.returnButton.addTarget(self, action: #selector(returnKeyboard), for: .touchUpInside)
        translateView.backSpaceButton.addTarget(self, action: #selector(backspace), for: .touchUpInside)
        translateView.inputTextView.delegate = self
    }
     
    fileprivate func addViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(translateView)
        isSound = UserDefaults.standard.bool(forKey: "isSound")
        isVibrating = UserDefaults.standard.bool(forKey: "isVibrating")
        
        
    }
    
    fileprivate func tutorial(){
        //view.addSubview(dimmingDynamicView)
        //dimmingDynamicView.fillSuperview()

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
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isOpaque = false
        
    }
    fileprivate func tabBarSetup(){
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.isOpaque = false
        
    }
    //actions custon keyboard
    @objc private func spaceLetter(){
        translateView.inputTextView.text = translateView.inputTextView.text + " "
        let result = TranslateManager.shared.translate(morseToText: sequence)
        if result.succes{
            if let character = result.characters{
                translateView.responseTextView.text = character
            }
        }else{
            showAlert(title: "Character not identified!", menssage: nil, dismissTime: UInt64(3))
            translateView.inputTextView.text = String(translateView.inputTextView.text.dropLast(actualSequence.count+1))
            var splited = sequence.split(separator: 2)
            sequence = Array(splited.removeLast())
        }
        sequence.append(2)
        actualSequence.removeAll()
    }
    
    @objc private func spaceWord(){
        translateView.inputTextView.text = translateView.inputTextView.text + "/"
        translateView.responseTextView.text += " "
        sequence.append(3)
        actualSequence.removeAll()
    }
    
    @objc private func dot(){
        if isSound {
            self.player = SoundManager.shared.soundOf(message: [0])
            player?.play()
        }
        translateView.inputTextView.text += "."
        actualSequence.append(0)
        sequence.append(0)
    }
    
    @objc private func hy(){
        if isSound {
            self.player = SoundManager.shared.soundOf(message: [1])
            player?.play()
        }
        translateView.inputTextView.text += "-"
        sequence.append(1)
        actualSequence.append(1)
    }
    
    @objc private func returnKeyboard(){
        translateView.inputTextView.resignFirstResponder()
    }
    
    @objc private func backspace(){
        if actualSequence.isEmpty{
            if sequence.last == 2 || sequence.last == 3 {
                let result = TranslateManager.shared.translate(morseToText: sequence)
                if result.succes{
                    if let character = result.characters{
                        translateView.responseTextView.text = character
                    }
                }
            }
            sequence.removeLast()
        }else{
            actualSequence.removeLast()
            sequence.removeLast()
        }
        translateView.inputTextView.text = String(translateView.inputTextView.text.dropLast())
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
    
    @objc func goNext(_ sender: UIButton){
//        tutorialView.moveTo(element: translateView.copyButton, paternView: self.view)
//        self.dimmingDynamicView.visiblePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(location.x-50, location.y-50,
//            100, 100)];
        let object = translateView.copyButton
        let position = object.getPosition(inView: self.view)
        //self.dimmingDynamicView.visiblePath = UIBezierPath(rect: CGRect(x: position.x, y: position.y, width: 65, height: 65))
    }
    

}
extension TranslateViewController: UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return !isTranslateToMorse
    }
    
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
