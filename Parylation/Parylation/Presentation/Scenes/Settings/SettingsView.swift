//
// 
//  SettingsView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import Bond
import ReactiveKit
import UIKit

final class SettingsView: UIViewController {
    var viewModel: SettingsViewModel!

    override func loadView() {
        view = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }

    private func setupUI() { }

    private func bindViewModel() { } 
}
