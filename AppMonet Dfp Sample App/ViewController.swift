//
//  ViewController.swift
//  AppMonet Dfp Sample App
//
//  Created by Jose Portocarrero on 3/13/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AppMonet_Dfp

class ViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate {
    @IBOutlet weak var mrectContainer: UIView!

    var bannerView: DFPBannerView!
    var interstitial: DFPInterstitial!

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // DFP BannerView setup
        bannerView = DFPBannerView(adSize: kGADAdSizeMediumRectangle)
        bannerView.adUnitID = "<BANNER_AD_UNIT>"
        bannerView.rootViewController = self
        bannerView.delegate = self
        addBannerViewToView(bannerView)

        // DFP Interstitial setup
        interstitial = createInterstitial()
    }

    // MARK: GADInterstitialDelegate

    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        showToast(controller: self, message: "Interstitial Loaded", seconds: 1)
    }

    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        showToast(controller: self, message: "Interstitial Failed", seconds: 1)
    }

    // MARK: GADBannerViewDelegate

    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        showToast(controller: self, message: "Ad Loaded", seconds: 1)
    }

    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        showToast(controller: self, message: "Ad Failed", seconds: 1)
    }

    // MARK: Buttons

    @IBAction func loadMrect(_ sender: Any) {
        // Header Bidding - AddBids
        AppMonet.addBids(bannerView, andDfpAdRequest: DFPRequest(), andTimeout: 1500) { (request) in
            // pass the DFPReqeust object coming from block to DFPBannerView load method.
            self.bannerView.load(request)
        }
    }

    @IBAction func loadInterstitial(_ sender: Any) {
        if (interstitial.hasBeenUsed) {
            interstitial = createInterstitial()
        }
        interstitial.load(DFPRequest())
    }

    @IBAction func showInterstitial(_ sender: Any) {
        if (interstitial.isReady) {
            interstitial.present(fromRootViewController: self)
        } else {
            showToast(controller: self, message: "Interstitial Is Not Ready", seconds: 1)
        }
    }

    // MARK: Private

    private func showToast(controller: UIViewController, message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15

        controller.present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }

    func createInterstitial() -> DFPInterstitial {
        let interstitial = DFPInterstitial(adUnitID: "<INTERSTITIAL_AD_UNIT>")
        interstitial.delegate = self
        return interstitial
    }

    private func addBannerViewToView(_ bannerView: DFPBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        mrectContainer.addSubview(bannerView)
    }
}

