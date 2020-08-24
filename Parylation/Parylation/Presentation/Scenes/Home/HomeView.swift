//
//  HomeView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

final class HomeView: UIViewController {
    var viewModel: HomeViewModel!
    
    private let headerBackgroundView = UIView()
    private let headerContentView = UIView()
    private let greetingsTitleLabel = UILabel()
    private let greetingsSubtitleLabel = UILabel()
    private let planButton = UIButton()
    
    override func loadView() {
        view = UIView()
        
        view.addSubview(headerBackgroundView)
        headerBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.lessThanOrEqualTo(view.snp.centerY)
        }
        
        let headerMaskView = UIView()
        headerMaskView.backgroundColor = Color.whisper
        view.insertSubview(headerMaskView, belowSubview: headerBackgroundView)
        headerMaskView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(headerBackgroundView.snp.centerY)
        }
        
        headerBackgroundView.addSubview(headerContentView)
        headerContentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.bottom.equalToSuperview().offset(-30)
        }
        
        headerContentView.addSubview(greetingsTitleLabel)
        greetingsTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        headerContentView.addSubview(greetingsSubtitleLabel)
        greetingsSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(greetingsTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        headerContentView.addSubview(planButton)
        planButton.snp.makeConstraints {
            $0.top.equalTo(greetingsSubtitleLabel.snp.bottom).offset(20)
            $0.height.equalTo(60)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        headerBackgroundView.backgroundColor = Color.whisper
        headerBackgroundView.layer.cornerRadius = 40
        if #available(iOS 13.0, *) {
            headerBackgroundView.layer.cornerCurve = .continuous
        }
        
        greetingsTitleLabel.font = .systemFont(ofSize: 28, weight: .heavy)
        greetingsTitleLabel.text = "Hey, Vladislav!" // localize
        greetingsTitleLabel.textColor = Color.gigas
        
        greetingsSubtitleLabel.font = .systemFont(ofSize: 24, weight: .ultraLight)
        let subtitleText = "Let's plan your " // localize
        let date = "Monday"
        let greetingsSubtitleText = NSMutableAttributedString(
            string: subtitleText + date,
            attributes: [
                .font: UIFont.systemFont(ofSize: 24, weight: .ultraLight)
            ]
        )
        greetingsSubtitleText.addAttributes([
            .font: UIFont.systemFont(ofSize: 24, weight: .semibold)
        ], range: NSRange(location: subtitleText.count, length: date.count))
        greetingsSubtitleLabel.attributedText = greetingsSubtitleText
        greetingsSubtitleLabel.textColor = .black
        
        planButton.setTitle("WRITE IMPORTANT THINGS", for: .normal)
        planButton.setTitleColor(.black, for: .normal)
        planButton.backgroundColor = Color.marigoldYellow
        planButton.layer.cornerRadius = 20
        if #available(iOS 13.0, *) {
            planButton.layer.cornerCurve = .continuous
        }
        planButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        planButton.layer.applyShadow(
            color: Color.marigoldYellow,
            alpha: 0.5,
            x: 0,
            y: 5,
            blur: 20,
            spread: -20
        )
    }

    private func bindViewModel() {

    }
}
