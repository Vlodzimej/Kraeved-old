//
//  HistoricalEventsManager.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 21.11.2022.
//

import Foundation

protocol HistoricalEventsManagerProtocol: AnyObject {
    func getHistoricalEvents(completion: @escaping ([MetaObject<HistoricalEventData>]) -> Void)
}

class HistoricalEventsManager: HistoricalEventsManagerProtocol {
    
    static let shared = HistoricalEventsManager()
    
    private let apiManager: APIManager
    
    private init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func getHistoricalEvents(completion: @escaping ([MetaObject<HistoricalEventData>]) -> Void) {
        let response: [BusinessObject] = [
            BusinessObject(id: UUID(), title: "Открытие музея космонавтики", metatype: .historicalEvent, content:
                """
                {
                    "imageUrl": "https://s4.stc.all.kpcdn.net/family/wp-content/uploads/2022/03/den_kosmonaftiki_oblogka_960-960x540.jpg",
                    "text": "13 июня 1961 года Ю. А. Гагарин заложил первый камень в фундамент здания будущего музея. Музей был открыт для посетителей 3 октября 1967 года[1]. Архитекторы — Б. Г. Бархин, Е. И. Киреев, Н. Г. Орлова, В. А. Строгий, К. Д. Фомин. Мозаика «Покорители космоса» в вестибюле музея создана А. Васнецовым из смальты и натурального камня. В 1960 году музей был определён научно-методическим центром по координации деятельности музеев СССР космического профиля, а в 1979 году получил статус научно-исследовательского учреждения. В 1993 году Государственный музей истории космонавтики имени К. Э. Циолковского был отнесен к крупнейшим культурно-просветительным учреждениям, имеющим особенную общественную значимость. С 21 июня 1973 года на территории калужского музея космонавтики экспонируется подлинный экземпляр ракетно-космического комплекса «Восток», находившийся в резерве во время старта гагаринского «Востока-1»."
                }
                """
            )
        ]
        
        let historicalEvents: [MetaObject<HistoricalEventData>] = response.map { $0.convertToMetaObject() }
        completion(historicalEvents)
        
        
//        let events: [MetaObject<HistoricalEventData>] = [
//            HistoryEvent(title: "Открытие музея космонавтики", imageUrl: "https://s4.stc.all.kpcdn.net/family/wp-content/uploads/2022/03/den_kosmonaftiki_oblogka_960-960x540.jpg", text: ""),
//            HistoryEvent(title: "Калугу посетила императрица Екатерина II", imageUrl: "https://cdnn21.img.ria.ru/images/93750/25/937502585_0:0:1509:1509_1920x0_80_0_0_4440551018846f40b977d2507a8e9e26.jpg", text: "15 декабря 1775 года, Калугу посетила императрица Екатерина II. Императрица прибыла в сопровождении митрополита Платона и блестящей свиты. К её приезду в городе местным купечеством были выстроены Триумфальные ворота (разобраны в 1935 г.). Екатерина пробыла в городе один день, после чего посетила Полотняный завод и 17 декабря отбыла в Москву. В память об этом визите были выбиты две медали, на одной из которых царица изображена в калужском наряде[53]."),
//            HistoryEvent(title: "Открытие института имени Горького", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Alexander_Herzen%27s_Birthplace%284%29.jpg/548px-Alexander_Herzen%27s_Birthplace%284%29.jpg", text: "Литерату́рный институ́т имени А. М. Го́рького (Литинститут, ЛИ имени А. М. Горького) — федеральное (во времена СССР — всесоюзное) высшее учебное заведение для подготовки литературных работников. Находится в Москве, в усадьбе на Тверском бульваре. Основан в 1933 году, современное название получил в 1936 году. До 1992 года по ведомственной принадлежности относился к Союзу писателей СССР, с 1992 по 2014 год находился в ведении Министерства образования и науки, с 2014 года — Министерства культуры Российской Федерации."),
//            HistoryEvent(title: "Межпланетная станция «Марс-3»", imageUrl: "https://starwalk.space/gallery/images/mars-the-ultimate-guide/1920x1080.jpg", text: "Советская автоматическая межпланетная станция «Марс-3» впервые в мире совершила мягкую посадку на поверхность Марса.")
//        ]
    }
    
}
