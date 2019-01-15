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

class PracticingViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var player: AVQueuePlayer?
    var data: [Item] = []
    var currentIndex = 0
    var firtAccess = false
    var isLetter: Bool!
    var indexItem = 0
    
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
        reset.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        reset.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
        return reset
    }()
    
    lazy var doneButton: UIButton = {
        let done = UIButton()
        done.translatesAutoresizingMaskIntoConstraints = false
        done.setTitle("Done", for: UIControl.State.normal)
        done.setTitleColor(UIColor.getActionColor(), for: UIControl.State.normal)
        done.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        done.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        return done
    }()
    
    lazy var backButton: UIButton = {
        let back = UIButton()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.setTitle("Back", for: UIControl.State.normal)
        back.setTitleColor(UIColor.getActionColor(), for: UIControl.State.normal)
        back.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        back.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return back
    }()
    
    lazy var nextButton: UIButton = {
        let next = UIButton()
        next.translatesAutoresizingMaskIntoConstraints = false
        next.setTitle("Next", for: UIControl.State.normal)
        next.setTitleColor(UIColor.getActionColor(), for: UIControl.State.normal)
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
        character.font = UIFont.boldSystemFont(ofSize: 300)
        character.applyGradientWith(startColor: UIColor(red:0.11, green:0.90, blue:0.89, alpha:1.0), endColor: UIColor(red:0.71, green:0.53, blue:0.97, alpha:1.0))
        return character
    }()
    
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
        collection.backgroundColor = UIColor.getBackgroundViewColor()
        collection.alwaysBounceVertical = false
        collection.alwaysBounceHorizontal = false
        collection.showsHorizontalScrollIndicator = false
        let collectionViewLayout = collection.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.scrollDirection = .horizontal
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.getBackgroundViewColor()
        characterLabel.text = self.data[indexItem].text
        settingCollection()
        addviews()
        settingConstraints()
        settingsGestures()

    }
    
    // MARK: - Settings
    
    private func addviews(){
        view.addSubview(custonNaviBar)
        view.addSubview(custonToolBar)
        view.addSubview(tapView)
        view.addSubview(soundButton)
        view.addSubview(codeCollectionView)
        view.addSubview(characterLabel)
        custonNaviBar.addSubview(doneButton)
        custonNaviBar.addSubview(resetButton)
        custonToolBar.addSubview(backButton)
        custonToolBar.addSubview(nextButton)
        view.bringSubviewToFront(custonToolBar)
    }
    
    private func settingsGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(sender:)))
        longPress.minimumPressDuration = 0.5
        tap.delegate = self
        tapView.addGestureRecognizer(tap)
        tapView.addGestureRecognizer(longPress)
    }
    
    private func settingCollection(){
        codeCollectionView.delegate = self
        codeCollectionView.dataSource = self
        codeCollectionView.register(CodeCollectionViewCell.self, forCellWithReuseIdentifier: "CodeCollectionViewCell")
        
    }
    
    private func settingConstraints(){
        // constraints in toolBar
        if let superview = custonToolBar.superview{
            custonToolBar.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
            custonToolBar.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
            custonToolBar.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
            custonToolBar.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.06).isActive = true
        }
        //constraints in custonNavBar
        if let superview = custonNaviBar.superview{
            custonNaviBar.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
            custonNaviBar.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
            custonNaviBar.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            custonNaviBar.heightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        }
        //constraints in doneButton
        doneButton.trailingAnchor.constraint(equalTo: custonNaviBar.trailingAnchor, constant: -8).isActive = true
        doneButton.leadingAnchor.constraint(greaterThanOrEqualTo: resetButton.trailingAnchor, constant: 8).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: custonNaviBar.centerYAnchor, constant: 8).isActive = true
        //constraints in resetButton
        resetButton.leadingAnchor.constraint(equalTo: custonNaviBar.leadingAnchor, constant: 8).isActive = true
        resetButton.centerYAnchor.constraint(equalTo: doneButton.centerYAnchor).isActive = true
        //constraints soundButton
        if let superview = soundButton.superview{
            soundButton.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
             soundButton.topAnchor.constraint(equalTo: custonNaviBar.bottomAnchor, constant: 20).isActive = true
            soundButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
            soundButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
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
            codeCollectionView.topAnchor.constraint(equalTo: characterLabel.bottomAnchor, constant: 10).isActive = true
            codeCollectionView.heightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07).isActive = true
        }
        //constraints in characterLabel
        if let superview = characterLabel.superview{
            characterLabel.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
            characterLabel.topAnchor.constraint(equalTo: custonNaviBar.bottomAnchor, constant: 16).isActive = true
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
        dismiss(animated: true, completion: nil)
    }
    
    @objc func nextAction(){
        currentIndex = 0
        self.indexItem += 1
        if (indexItem > data.count - 1){
            self.indexItem = 0
            characterLabel.text = data[indexItem].text
            codeCollectionView.reloadData()
        }else{
            characterLabel.text = data[indexItem].text
            codeCollectionView.reloadData()
        }
    }
    
    @objc func backAction(){
        self.indexItem -= 1
        if (indexItem < 0){
            self.indexItem = data.count - 1
            characterLabel.text = data[indexItem].text
            codeCollectionView.reloadData()
        }else{
            characterLabel.text = data[indexItem].text
            codeCollectionView.reloadData()
        }
    }
    
    @objc func soundAction(){
        speakTheCode(message: data[indexItem].morse)
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer? = nil) {
        toCount(isTap: true)
    }
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            toCount(isTap: false)
        default:
            break
        }
    }
    
    
    // MARK: - Help Functions
    
    private func getItem(FromCoreDataInIndex index: Int) -> NSManagedObject? {
        guard let result = CoreDataManager.shared.fetching(isLetterData: isLetter) else {return nil}
        return result[index]
    }
    
    private func toCount(isTap: Bool){
        speakTheCode(message: isTap ? [0]: [1])
        guard let itemCoreData: NSManagedObject = getItem(FromCoreDataInIndex: indexItem), let done =  itemCoreData.getDone(isLetter: isLetter) else {return}
        let item = data[indexItem]
        let aux = isTap ? 0 : 1
        if(!done && item.morse[currentIndex] == aux){
            let cell = codeCollectionView.cellForItem(at: IndexPath.init(row: currentIndex, section: 0)) as! CodeCollectionViewCell
            cell.codeImage.image = UIImage.init(named: "dotGreen")
            if (currentIndex == item.morse.count - 1){
                itemCoreData.set(done: true, isLetter: isLetter)
            }
            self.currentIndex += 1
            
        }else{
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
        }
        if (currentIndex == item.morse.count - 1){
            self.resetButton.isHighlighted = true
        }
    }
    
    private func speakTheCode(message: [Int]) {
        var audioItems: [AVPlayerItem] = []
        guard let longPath = Bundle.main.path(forResource: "beep_long", ofType: "mp3"),
            let shortPath = Bundle.main.path(forResource: "beep_short", ofType: "mp3") else {
                print("Path is not availabel")
                return
        }
        for code in message {
            if code == 1 {
                let longBeep = AVPlayerItem(url: URL(fileURLWithPath: longPath))
                audioItems.append(longBeep)
            } else {
                let shortBeep = AVPlayerItem(url: URL(fileURLWithPath: shortPath))
                audioItems.append(shortBeep)
            }
        }
        player = AVQueuePlayer(items: audioItems)
        player?.play()
    }
}

extension NSManagedObject {
    
    func getDone(isLetter: Bool) -> Bool?{
        if isLetter {
            guard let l = self as? Letters else {return nil}
            return l.done
        }else{
            guard let n = self as? Numbers else {return nil}
            return n.done
        }
    }
    
    func set(done: Bool, isLetter: Bool){
        if isLetter {
            guard let l = self as? Letters else {return}
            l.done = done
        }else{
            guard let n = self as? Numbers else {return}
            n.done = done
        }
    }
    
}
