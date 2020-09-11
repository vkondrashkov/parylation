//
//  Array2D+Collection.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 9/2/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond

extension Array2D: Sequence {
    public typealias Iterator = IndexingIterator<[Array2D.Section]>

    public func makeIterator() -> Iterator {
      return sections.makeIterator()
    }
}

extension Array2D: Collection {
    public typealias Index = Int

    public var startIndex: Index {
      return sections.startIndex
    }

    public var endIndex: Index {
      return sections.endIndex
    }

    public subscript(position: Index) -> Iterator.Element {
      precondition(indices.contains(position), "out of bounds")
      let element = sections[position]
      return element
    }

    public func index(after i: Index) -> Index {
      return sections.index(after: i)
    }
}

extension Array2D: SectionedDataSourceChangesetConvertible {
    public typealias Changeset = OrderedCollectionChangeset<Array2D>
    
    public var asSectionedDataSourceChangeset: OrderedCollectionChangeset<Array2D> {
        return OrderedCollectionChangeset(collection: self, patch: [])
    }
}
