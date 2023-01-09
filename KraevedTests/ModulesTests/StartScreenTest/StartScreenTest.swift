//
//  StartScreenTest.swift
//  KraevedTests
//
//  Created by Владимир Амелькин on 09.01.2023.
//

import XCTest
@testable import Kraeved

final class StartScreenTest: XCTestCase {
    
    var presenter: StartScreenPresenter!
    var view: StartScreenViewControllerMock?
    var interactor: StartScreenInteractorMock?
    var router: BaseRouterMock?
    var phoneFormViewMock: PhoneFormViewMock?
    var codeFormViewMock: CodeFormViewMock?
    var output: StartScreenModuleOutputMock?

    override func setUpWithError() throws {
        view = StartScreenViewControllerMock()
        interactor = StartScreenInteractorMock()
        router = BaseRouterMock()
        output = StartScreenModuleOutputMock()
        
        guard let interactor = interactor, let router = router else { return }
        presenter = StartScreenPresenter(interactor: interactor, router: router, output: output)
        presenter.view = view
        
        phoneFormViewMock = PhoneFormViewMock()
        phoneFormViewMock?.delegate = presenter
        
        codeFormViewMock = CodeFormViewMock()
        codeFormViewMock?.delegate = presenter
    }
    
    override func tearDownWithError() throws {
        presenter = nil
    }
    
    func testDismiss() {
        presenter.dismiss()
        XCTAssertTrue(router?.isDismissed ?? false)
    }
    
    func testSendPhone() {
        phoneFormViewMock?.sendPhone()
        XCTAssertTrue(view?.isCodeFormShown ?? false)
    }
    
    func testSendCode() {
        phoneFormViewMock?.sendPhone()
        codeFormViewMock?.sendCode()
        XCTAssertEqual("7777777777 7777", "\(interactor?.phone ?? "") \(interactor?.code ?? "")")
    }
}

class StartScreenViewControllerMock: StartScreenViewProtocol {
    var isCodeFormShown: Bool = false
    
    func showCodeForm() {
        isCodeFormShown = true
    }
}

class StartScreenInteractorMock: StartScreenInteractorProtocol {
    var phone: String?
    var code: String?
    
    func login(phone: String, code: String) {
        self.phone = phone
        self.code = code
    }
}

class PhoneFormViewMock: PhoneFormViewProtocol {
    var delegate: PhoneFormViewDelegate?
    
    func sendPhone() {
        delegate?.sendPhone("7777777777")
    }
}

class CodeFormViewMock: CodeFormViewProtocol {
    var delegate: CodeFormViewDelegate?
    
    func sendCode() {
        delegate?.sendCode("7777")
    }
}

class StartScreenModuleOutputMock: StartScreenModuleOutput {
    var isLoggedCalled = false
    
    func logged() {
        isLoggedCalled = true
    }
}
