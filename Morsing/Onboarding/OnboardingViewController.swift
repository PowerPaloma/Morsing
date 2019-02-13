//
//  OnboardingViewController.swift
//  Morsing
//
//  Created by Levy Cristian  on 05/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    lazy var onboardingCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: UIControl.State.normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(nextDidClicked), for: UIControl.Event.touchUpInside)
        button.setTitleColor(.black, for: UIControl.State.normal)
        button.setTitleColor(UIColor(red:0.12, green:0.27, blue:0.24, alpha:1.0), for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: UIControl.State.normal)
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(skipDidClicked), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor(red:0.12, green:0.27, blue:0.24, alpha:1.0), for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [skipButton, nextButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var getStarted: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: UIControl.State.normal)
        button.setTitleColor(.red, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(getStart), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor(red:0.12, green:0.27, blue:0.24, alpha:1.0), for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var content : [Onboard] = {
        var array = [Onboard]()
        let material: Onboard = Onboard(title: "De tudo um pouco 💫",
                                        description: "Tenha acesso a diversas matérias de diversos conteúdos de forma prática e fácil.",
                                        assetName: "material",
                                        assetKind: .image)
        let Progresso: Onboard = Onboard(title: "Acompanhe o seu progresso 🚀",
                                         description: "Veja como você está se saindo nas suas matérias e obtenha várias recompensas.",
                                         assetName: "progresso",
                                         assetKind: .image)
        let inicio: Onboard = Onboard(title: "Eai, bora comreça? 🎉",
                                      description: "Venha ver como você é capaz de aprender de verdade a matéria que você tanto gosta.",
                                      assetName: "inicio",
                                      assetKind: .image)
        array.append(material)
        array.append(Progresso)
        array.append(inicio)
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgoundGray
        initialSetup()
        // Do any additional setup after loading the view.
    }
    
    private func initialSetup(){
        addView()
        setUpCollectionViewConstraints()
        setUpPageControlConstraints()
        setUpButtons()
        
        onboardingCollectionView.dataSource = self
        onboardingCollectionView.delegate = self
        onboardingCollectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
    }
    
    private func addView(){
        view.addSubview(onboardingCollectionView)
        view.addSubview(pageControl)
        view.addSubview(buttonsStackView)
    }
    
    fileprivate func setUpCollectionViewConstraints(){
        onboardingCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        onboardingCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
    }
    
    fileprivate func setUpPageControlConstraints(){
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalToSystemSpacingBelow: onboardingCollectionView.safeAreaLayoutGuide.bottomAnchor, multiplier: 1).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: onboardingCollectionView.centerXAnchor).isActive = true
        
    }
    
    fileprivate func setUpButtons() {
        buttonsStackView.anchor(top: pageControl.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets.zero, size: .zero)
        
    }
    
    func addGetSButton(){
        
        nextButton.removeFromSuperview()
        buttonsStackView.addArrangedSubview(getStarted)
        
    }
    
    func removeGetSButton(){
        getStarted.removeFromSuperview()
        buttonsStackView.addArrangedSubview(nextButton)
    }
    @objc fileprivate func nextDidClicked(){
        if ( pageControl.currentPage + 1 ) < content.count {
            let indexPath = IndexPath(row: pageControl.currentPage+1, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = pageControl.currentPage + 1
        }
    }
    
    @objc fileprivate func skipDidClicked(){
        let indexPath = IndexPath(row: content.count-1, section: 0)
        onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = content.count-1
        
    }
    
    @objc fileprivate func getStart(){
   
        let tabBarController = UITabBarController()
        tabBarController.setup()
        UserDefaults.standard.set(true, forKey: "launchedBefore")
        
        
        present(tabBarController, animated: true, completion: nil)
        
    }
    
}
