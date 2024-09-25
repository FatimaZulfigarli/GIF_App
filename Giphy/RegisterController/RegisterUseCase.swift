//
//  RegisterUseCase.swift
//  Giphy
//
//  Created by Fatya on 25.09.24.
//

import Foundation

protocol RegisterUseCase {
    func register(email: String, password: String, fullname: String, completion: @escaping (Result<RegistrationData, Error>) -> Void)
    func signInWithGoogle(completion: @escaping (Result<UserProfile, Error>) -> Void)
}
