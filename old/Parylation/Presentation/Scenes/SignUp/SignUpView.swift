//
//  SignUpView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

final class SignUpView: UIViewController {
    var viewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        
    }
}
