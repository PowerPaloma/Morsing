//
//  PracticingViewController.swift
//  Morsing
//
//  Created by Paloma Bispo on 11/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
import CoreData
import Lottie


class PracticingViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var player: AVQueuePlayer?
    var data: [NSManagedObject] = []
    var currentIndex = 0
    var firtAccess = false
    var isLetter: Bool!
    var indexItem = 0
    var isFirstTime = true
    var backTutorial = 0
    
    
    
    lazy var custonToolBar: UIView = {
        let toolBar = UIView()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.backgroundColor = UIColor.white
        toolBar.layer.shadowColor = UIColor.black.cgColor
        toolBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        toolBar.layer.shadowOpacity = 0.4
        toolBar.layer.shadowRadius = 5.0
        return toolBar
    }()
    
//    lazy var tutorialBackgroundView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor(red: 107/255, green: 107/255, blue: 107/255, alpha: 0.65)
//        return view
//    }()

    
//    lazy var tutorialLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        let text = NSMutableAttributedString()
//            .appendWith(weight: .regular, ofSize: 16, "Hey buddy! It's a pleasure have you here. Let's learn morse code? It's very simple. Just use ")
//            .appendWith(weight: .bold, ofSize: 16, "tap for dot")
//            .appendWith(weight: .regular, ofSize: 16, " and ")
//            .appendWith(weight: .bold, ofSize: 16, "long press for hairline. ")
//            .appendWith(weight: .regular, ofSize: 16, "Good luck!")
//
//        label.attributedText = text
//        label.numberOfLines = 0
//        return label
//    }()
    
    lazy var opaqueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var custonNaviBar: UIView = {
       let nav = UIView()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = UIColor.white
        return nav
    }()
    
    lazy var resetButton: UIButton = {
        let reset = UIButton()
        reset.translatesAutoresizingMaskIntoConstraints = false
        reset.setTitle("Reset", for: UIControl.State.normal)
        reset.setTitleColor(UIColor(red: 226/255, green: 17/255, blue: 17/255, alpha: 1.0), for: UIControl.State.normal)
        reset.setTitleColor(UIColor(red: 226/255, green: 17/255, blue: 17/255, alpha: 0.3), for: UIControl.State.highlighted)
        reset.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        reset.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
        return reset
    }()
    
    lazy var doneButton: UIButton = {
        let done = UIButton()
        done.translatesAutoresizingMaskIntoConstraints = false
        done.setTitle("Exit", for: UIControl.State.normal)
        done.setTitleColor(UIColor(red: 226/255, green: 17/255, blue: 17/255, alpha: 1.0), for: UIControl.State.normal)
        done.setTitleColor(UIColor(red: 226/255, green: 17/255, blue: 17/255, alpha: 0.3), for: UIControl.State.highlighted)
        done.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        done.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        return done
    }()
    
    lazy var backButton: UIButton = {
        let back = UIButton()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.setTitle("Back", for: UIControl.State.normal)
        back.setTitleColor(UIColor.getActionColor(alpha: 1.0), for: UIControl.State.normal)
        back.setTitleColor(UIColor.getActionColor(alpha: 0.3), for: UIControl.State.highlighted)
        back.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        back.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return back
    }()
    
    lazy var nextButton: UIButton = {
        let next = UIButton()
        next.translatesAutoresizingMaskIntoConstraints = false
        next.setTitle("Next", for: UIControl.State.normal)
        next.setTitleColor(UIColor.getActionColor(alpha: 1.0), for: UIControl.State.normal)
        next.setTitleColor(UIColor.getActionColor(alpha: 0.3), for: UIControl.State.highlighted)
        next.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        next.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        return next
    }()
    
    lazy var soundButton: UIButton = {
        let sound = UIButton()
        sound.translatesAutoresizingMaskIntoConstraints = false
        sound.clipsToBounds = true
        sound.layer.cornerRadius = 10
        sound.setImage(UIImage(named: "sound"), for: .normal)
        sound.addTarget(self, action: #selector(soundAction), for: .touchUpInside)
        return sound
    }()
    
    lazy var characterLabel: UILabel = {
        let character = UILabel()
        character.translatesAutoresizingMaskIntoConstraints = false
        character.text = "A"
        character.sizeToFit()
        character.font = UIFont.boldSystemFont(ofSize: 330)
        let starColor = UIColor(cgColor: AppGradientsVariantions.Default.rawValue[0])
        let endColor = UIColor(cgColor: AppGradientsVariantions.Default.rawValue[1])
        _ = character.applyGradientWith(startColor: starColor, endColor: endColor)
        return character
    }()
    
    lazy var tapHereLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = UIColor.getActionColor(alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
//    fileprivate var skipButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Got it", for: UIControl.State.normal)
//        button.backgroundColor = .clear
//        button.addTarget(self, action: #selector(dismissTutorial), for: UIControl.Event.touchUpInside)
//        button.setTitleColor(.purple, for: UIControl.State.normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    lazy var tapView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        // shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3.0
        return view
    }()
    
    lazy var codeCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = .clear
        collection.alwaysBounceVertical = false
        collection.alwaysBounceHorizontal = false
        collection.showsHorizontalScrollIndicator = false
        let collectionViewLayout = collection.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.scrollDirection = .horizontal
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var animationView: LOTAnimationView = {
        let animationView = LOTAnimationView(name: "done", bundle: Bundle.main)
        animationView.animationSpeed = 0.7
        animationView.contentMode = .scaleAspectFit
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        settingCollection()
        addviews()
        settingConstraints()
        settingsGestures()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        if(touch.view == self.tapView){
            self.tapView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        if(touch.view == self.tapView){
            self.tapView.backgroundColor = UIColor.white
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        if(touch.view == self.tapView){
            self.tapView.backgroundColor = UIColor.white
        }
    }
    
    // MARK: - Settings
    
    private func initialSetup(){
        view.backgroundColor = .backgoundGray
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.isFirstTime = UserDefaults.standard.bool(forKey: "isFirstTime")
        characterLabel.text = self.data[indexItem].getCharacter(isLetter: isLetter)
        guard let itemCoreData: NSManagedObject = getItem(FromCoreDataInIndex: indexItem), let done =  itemCoreData.getDone(isLetter: isLetter) else {return}
        if done {
            self.resetButton.isHighlighted = false
            self.resetButton.isEnabled = true
        }else{
            self.resetButton.isHighlighted = true
            self.resetButton.isEnabled = false
        }
    }
    
    private func addviews(){
        tapView.addSubview(tapHereLabel)
        view.addSubview(custonNaviBar)
        view.addSubview(custonToolBar)
        view.addSubview(soundButton)
        view.addSubview(codeCollectionView)
        view.addSubview(characterLabel)
        custonNaviBar.addSubview(doneButton)
        custonNaviBar.addSubview(resetButton)
        custonToolBar.addSubview(backButton)
        custonToolBar.addSubview(nextButton)
        view.addSubview(tapView)
        view.bringSubviewToFront(custonToolBar)
        
        if !isFirstTime {
            setupTutorial()
        }
        
    }
    
    private func setupTutorial() {
        view.addSubview(opaqueView)
        view.bringSubviewToFront(tapView)
        view.bringSubviewToFront(codeCollectionView)
        if let isDot = isDot(inIndex: 0){
            self.backTutorial = isDot ? 0 : 1
            tapHereLabel.text = isDot ? "Tap in this area to\n perform the point!" : "Press this area to\n perform the hairline!"
        }
    }
    
    private func isDot(inIndex index: Int) -> Bool? {
        if let morseArray = data[indexItem].getMorse(isLetter: isLetter) {
            return morseArray[index] == 0
        }
        return nil
    }
    
    private func settingsGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissTutorial))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(sender:)))
        longPress.minimumPressDuration = 0.5
        tap.delegate = self
        
        opaqueView.addGestureRecognizer(tapDismiss)
        tapView.addGestureRecognizer(tap)
        tapView.addGestureRecognizer(longPress)
    }
    
    private func settingCollection(){
        codeCollectionView.delegate = self
        codeCollectionView.dataSource = self
        codeCollectionView.register(CodeCollectionViewCell.self, forCellWithReuseIdentifier: "CodeCollectionViewCell")
        
    }
    
    private func settingConstraints(){
        if !isFirstTime {
        opaqueView.fillSuperview(safeArea: false)
        
        tapHereLabel.centerXAnchor.constraint(equalTo: tapView.centerXAnchor).isActive = true
        tapHereLabel.centerYAnchor.constraint(equalTo: tapView.centerYAnchor).isActive = true
        tapHereLabel.trailingAnchor.constraint(equalTo: tapView.trailingAnchor, constant: -24).isActive = true
        tapHereLabel.leadingAnchor.constraint(equalTo: tapView.leadingAnchor, constant: 24).isActive = true
        }
        
        // constraints in toolBar
        if let superview = custonToolBar.superview{
            custonToolBar.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
            custonToolBar.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
            custonToolBar.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            custonToolBar.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.06).isActive = true
        }
        //constraints in custonNavBar
        if let superview = custonNaviBar.superview{
            custonNaviBar.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
            custonNaviBar.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
            custonNaviBar.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            custonNaviBar.heightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        }
        //constraints in resetButton
        resetButton.trailingAnchor.constraint(equalTo: custonNaviBar.trailingAnchor, constant: -16).isActive = true
        resetButton.leadingAnchor.constraint(greaterThanOrEqualTo: doneButton.trailingAnchor, constant: 8).isActive = true
        resetButton.centerYAnchor.constraint(equalTo: custonNaviBar.centerYAnchor, constant: 8).isActive = true
        //constraints in doneButton
        doneButton.leadingAnchor.constraint(equalTo: custonNaviBar.leadingAnchor, constant: 16).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: resetButton.centerYAnchor).isActive = true
        //constraints soundButton
        if let superview = soundButton.superview{
            soundButton.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
             soundButton.topAnchor.constraint(equalTo: custonNaviBar.bottomAnchor, constant: 20).isActive = true
            soundButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
            soundButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
            //constraints settingButton
        }
        //constraints backButton
        backButton.leadingAnchor.constraint(equalTo: soundButton.leadingAnchor, constant: 8).isActive = true
        backButton.centerYAnchor.constraint(equalTo: custonToolBar.centerYAnchor).isActive = true
        //constraints nextButton
        nextButton.trailingAnchor.constraint(equalTo: custonToolBar.trailingAnchor, constant: -16).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: custonToolBar.centerYAnchor).isActive = true
        //constraints in tapView
        if let superview = tapView.superview{
            tapView.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            tapView.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
            tapView.bottomAnchor.constraint(equalTo: custonToolBar.topAnchor, constant: 6).isActive = true
            tapView.heightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25).isActive = true
        }
        //constraints in CodeCollection
        if let superview = codeCollectionView.superview{
            codeCollectionView.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            codeCollectionView.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
            codeCollectionView.bottomAnchor.constraint(equalTo: tapView.topAnchor, constant: -10).isActive = true
            codeCollectionView.topAnchor.constraint(equalTo: characterLabel.bottomAnchor, constant: 12).isActive = true
            codeCollectionView.heightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07).isActive = true
        }
        //constraints in characterLabel
        if let superview = characterLabel.superview{
            characterLabel.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
            characterLabel.topAnchor.constraint(equalTo: soundButton.bottomAnchor, constant: 4).isActive = true
        }
    }
    

    // MARK: - Actions
    
    @objc func resetAction(){
        guard let item = getItem(FromCoreDataInIndex: indexItem) else {return}
        item.set(done: false, isLetter: isLetter)
        currentIndex = 0
        codeCollectionView.reloadData()
    }
    
    @objc func doneAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func settingAction(){
        
    }
    
    @objc func nextAction(){
        currentIndex = 0
        self.indexItem += 1
        if (indexItem > data.count - 1){
            self.indexItem = 0
            characterLabel.text = data[indexItem].getCharacter(isLetter: isLetter)
            codeCollectionView.reloadData()
        }else{
            characterLabel.text = data[indexItem].getCharacter(isLetter: isLetter)
            codeCollectionView.reloadData()
        }
    }
    
    @objc func backAction(){
        self.indexItem -= 1
        if (indexItem < 0){
            self.indexItem = data.count - 1
            characterLabel.text = data[indexItem].getCharacter(isLetter: isLetter)
            codeCollectionView.reloadData()
        }else{
            characterLabel.text = data[indexItem].getCharacter(isLetter: isLetter)
            codeCollectionView.reloadData()
        }
    }
    
    @objc func soundAction(){
        guard let morse = data[indexItem].getMorse(isLetter: isLetter) else {return}
        self.player = SoundManager.shared.soundOf(message: morse)
        player?.play()
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer? = nil) {
//        UIView.animate(withDuration: 0.5) {
//            self.tapView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
//            self.tapView.backgroundColor = UIColor.white
//        }
        //tapHereLabel.isHidden = true
        manageGesture(isTap: true)
    }
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        //tapHereLabel.isHidden = true
        switch sender.state {
        case .began:
            manageGesture(isTap: false)
        default:
            break
        }
    }
    
    @objc private func dismissTutorial() {
        UIView.animate(withDuration: 1, animations: {
            self.opaqueView.alpha = 0
            //self.tutorialView.frame.origin.y = UIScreen.main.bounds.height
        }) { (_) in
            self.opaqueView.removeFromSuperview()
        }
    }
    
    
    // MARK: - Help Functions
    
    private func getItem(FromCoreDataInIndex index: Int) -> NSManagedObject? {
        guard let result = CoreDataManager.shared.fetching(isLetterData: isLetter) else {return nil}
        return result[index]
    }
    
    private func manageGesture(isTap: Bool){
        guard let itemCoreData: NSManagedObject = getItem(FromCoreDataInIndex: indexItem), let done =  itemCoreData.getDone(isLetter: isLetter) else {return}
        let item = data[indexItem]
        let aux = isTap ? 0 : 1
        guard let morse = item.getMorse(isLetter: isLetter) else {return}
        let isSound = UserDefaults.standard.bool(forKey: "isSound")
        let isVibrating = UserDefaults.standard.bool(forKey: "isVibrating")
        if(!done && morse[currentIndex] == aux){
            if isSound{
                self.player = SoundManager.shared.soundOf(message: isTap ? [0]: [1])
                player?.play()
            }
            if isVibrating {
                UIImpactFeedbackGenerator().impactOccurred()
            }
            let cell = codeCollectionView.cellForItem(at: IndexPath.init(row: currentIndex, section: 0)) as! CodeCollectionViewCell
            if !isFirstTime {
                cell.codeImage.alpha = 1.0
                if currentIndex != morse.count - 1 {
                    guard let isDot = isDot(inIndex: currentIndex + 1) else { return }
                    if backTutorial == 0, !isDot {
                        tapHereLabel.text = "Great job! Now hold down to execute the hairline"
                    } else if backTutorial == 1, isDot {
                        tapHereLabel.text = "Great job! Now tap to execute the hairline"
                    } else {
                        tapHereLabel.text = "Great job! Now you know what to do, hum?"
                    }
                    backTutorial = isTap ? 0 : 1
                } else {
                    if let letter = item.getCharacter(isLetter: isLetter) {
                        tapHereLabel.text = "Terrific! You know the letter \(letter) in morse code, keep going!"
                    } else {
                        tapHereLabel.text = "Terrific! You know a new letter in morse code, keep going!"
                    }
                    
                    
                }
                
            }
            
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                cell.codeImage.image = isTap ? UIImage.init(named: "dotColorful") : UIImage.init(named: "hyColorful")
            }, completion: nil)
            
            if (currentIndex == morse.count - 1){
                itemCoreData.set(done: true, isLetter: isLetter)
                self.resetButton.isHighlighted = false
                self.resetButton.isEnabled = true
                if !isFirstTime {
                    cell.codeImage.alpha = 1.0
                    view.bringSubviewToFront(characterLabel)
                    UserDefaults.standard.set(true, forKey: "isFirstTime")
                    let when = DispatchTime.now().uptimeNanoseconds + 3000000000 // 4 secs
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: when)) {
                        UIView.animate(withDuration: 2, animations: {
                            self.opaqueView.alpha = 0
                            self.tapHereLabel.alpha = 0
                        }, completion: { (_) in
                            self.tapHereLabel.removeFromSuperview()
                            self.opaqueView.removeFromSuperview()
                            self.view.sendSubviewToBack(self.tapView)
                        })
                    }
                    
                } else {
                    self.view.addSubview(animationView)
                    animationView.center = self.view.center
                    animationView.play(fromFrame: 0, toFrame: 21, withCompletion: { (finished) in
                        /// Animation finished
                        self.animationView.removeFromSuperview()
                    })

                }

                            }
            self.currentIndex += 1
            
        }else{
            if isVibrating {
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            }
        }
        if (currentIndex == morse.count - 1){
            self.resetButton.isHighlighted = true
            
        }
    }
}
