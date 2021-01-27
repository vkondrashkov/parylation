//
// 
//  CalendarView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 27.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import UIKit

final class CalendarView: UIViewController {
    var viewModel: CalendarViewModel!

    private let headerTitleLabel = UILabel()
    private let headerSubtitleLabel = UILabel()

    override func loadView() {
        view = UIView()

        view.addSubview(headerTitleLabel)
        headerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }

        view.addSubview(headerSubtitleLabel)
        headerSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .white

        headerTitleLabel.font = .systemFont(ofSize: 28, weight: .heavy)
        headerTitleLabel.text = L10n.calendarTitle
        headerTitleLabel.textColor = Color.gigas

        headerSubtitleLabel.font = .systemFont(ofSize: 24, weight: .ultraLight)
        let subtitleText = L10n.calendarSubtitle
        let accent = L10n.calendarSubtitleAccent
        let headerSubtitleText = NSMutableAttributedString(
            string: subtitleText + accent,
            attributes: [
                .font: UIFont.systemFont(ofSize: 24, weight: .ultraLight)
            ]
        )
        headerSubtitleText.addAttributes([
            .font: UIFont.systemFont(ofSize: 24, weight: .semibold)
        ], range: NSRange(location: subtitleText.count, length: accent.count))
        headerSubtitleLabel.attributedText = headerSubtitleText
        headerSubtitleLabel.textColor = .black
    }

    private func bindViewModel() { }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
