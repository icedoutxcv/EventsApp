//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by icedoutxcv on 06/10/2020.
//

import Foundation
import UIKit

final class AddEventViewModel {
    enum Mode {
        case add
        case edit(Event)
    }
    
    let title = "Add"
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    private(set) var cells: [AddEventViewModel.Cell] = []
    weak var coordinator: AddEventCoordinator?
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
    private let cellBuilder: EventsCellBuilder
    private let eventService: EventServiceProtocol
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    init(cellBuilder: EventsCellBuilder, eventService: EventServiceProtocol = EventService()) {
        self.cellBuilder = cellBuilder
        self.eventService = eventService
    }
    
    func tappedDone() {
        
        guard let name = nameCellViewModel?.subtitle,
              let dateString = dateCellViewModel?.subtitle,
              let image = backgroundImageCellViewModel?.image,
              let date = dateFormatter.date(from: dateString)
        else { return }
        eventService.perform(.add, data: EventService.EventInputData(name: name, date: date, image: image))
        coordinator?.didFinishSaveEvent()
        
    }
    
    func viewDidLoad() {
        setupCells()
        onUpdate()
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else { return }
            coordinator?.showImagePicker {
                image in
                titleSubtitleCellViewModel.update(image)
            }
        }
    }
    
    deinit {
        print("add event view model deallocated")
    }
}

private extension AddEventViewModel {
    func setupCells() {
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date) {[weak self] in
            self?.onUpdate()
        }
        backgroundImageCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.image) {[weak self] in
            self?.onUpdate()
        }

        guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let imageCellViewModel = backgroundImageCellViewModel else {
            return
        }
        
        cells = [
            .titleSubtitle(nameCellViewModel),
            .titleSubtitle(dateCellViewModel),
            .titleSubtitle(imageCellViewModel),
        ]
    }
}


