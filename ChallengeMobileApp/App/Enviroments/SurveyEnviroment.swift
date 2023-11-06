//
//  SurveyEnvironment.swift
//  ChallengeMobileApp
//

import Foundation

class SurveyEnviroment: ObservableObject {
    @Published var survey: SurveyItemList?
    @Published var surveyList: [SurveyItemList] = []

    func resetValues() {
        survey = nil
    }
    
    func reset() {
        survey = nil
        surveyList = []
    }
}
