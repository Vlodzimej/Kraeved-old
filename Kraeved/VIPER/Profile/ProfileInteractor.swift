//
//  ProfileInteractor.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 27.11.2022.
//

import Foundation

//MARK: - ProfileInteractorProtocol
protocol ProfileInteractorProtocol: AnyObject {
    var defaultUser: User { get set }
}

//MARK: - ProfileInteractor
class ProfileInteractor: ProfileInteractorProtocol {

    //MARK: Properties
    weak var presenter: ProfilePresenterProtocol?
    
    var defaultUser = User(username: "Default User", email: "default@mail.ru", phone: 9105968117, score: 100)

    //MARK: Init
    init() {
    }

    //MARK: Private Methods

    //MARK: Public Methods
}
