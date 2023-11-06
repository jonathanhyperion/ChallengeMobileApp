//
//  SurveyEnvironment.swift
//  ChallengeMobileApp
//

import Foundation

class SurveyEnviroment: ObservableObject {
    @Published var survey: SurveyItemList?

    func resetValues() {
        survey = nil
    }
}
