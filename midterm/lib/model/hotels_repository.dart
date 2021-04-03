// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'hotel.dart';

class HotelsRepository {
  static List<Hotel> loadHotels() {
    const allHotels = <Hotel>[
      Hotel(
        id: 0,
        isFeatured: true,
        name: 'Vagabond sack',
        price: 120,
      ),
      Hotel(
        id: 1,
        isFeatured: true,
        name: 'Stella sunglasses',
        price: 58,
      ),
      Hotel(
        id: 2,
        isFeatured: true,
        name: 'Whitney belt',
        price: 35,
      ),
      Hotel(
        id: 3,
        isFeatured: true,
        name: 'Garden strand',
        price: 98,
      ),
    ];
    return allHotels;
  }
}
