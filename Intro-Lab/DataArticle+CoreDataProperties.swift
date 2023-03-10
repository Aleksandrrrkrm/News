

import Foundation
import CoreData


extension DataArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataArticle> {
        return NSFetchRequest<DataArticle>(entityName: "DataArticle")
    }

    @NSManaged public var descriptionTitle: String?
    @NSManaged public var mainTitle: String?
    @NSManaged public var publishedAt: Date?
    @NSManaged public var url: String?

}

extension DataArticle : Identifiable {

}
