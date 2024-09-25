//
//  LoginUseCase.swift
//  Giphy
//
//  Created by Fatya on 25.09.24.
//

import Foundation

protocol LoginUseCase {
    func login(email: String, password: String, completion: @escaping (Bool) -> Void)
}
