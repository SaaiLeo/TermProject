//
//  OnBoardingPageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit

class OnBoardingPageViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnBoardingSlide] = []
    var currentPage: Int = 0 {
        didSet{
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            }else{
                nextButton.setTitle("Next", for: .normal)
            }
            pageControl.currentPage = currentPage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides.append(OnBoardingSlide(image:#imageLiteral(resourceName: "onBording1.png"), title: "Pokemon Chief", description: "Enjoy your food that are prepared by our pokemon"))
        slides.append(OnBoardingSlide(image: #imageLiteral(resourceName: "pokemonIcecream.png"), title: "Yummies", description: "We serve not only the look but also the taste."))
        
        pageControl.numberOfPages = slides.count

    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let scene = storyboard?.instantiateViewController(withIdentifier: "LoginPageViewController") as! LoginPageViewController
            
            scene.modalPresentationStyle = .fullScreen
            scene.modalTransitionStyle = .crossDissolve
            present(scene, animated: true)
        }else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnBoardingPageViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier, for: indexPath) as! OnBoardingCollectionViewCell
        
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
