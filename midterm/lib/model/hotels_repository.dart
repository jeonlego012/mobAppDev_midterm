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
    var allHotels = <Hotel>[
      Hotel(
        id: 0,
        name: 'Inter-Burgo Hotel',
        location: '1-1-13 Shimbashi, Minato Ward',
        stars: 4,
        phoneNumber: '053-380-0114',
        description:
            'This hotel is located in front of the Daegu City Fair Ground, 15-minute drive from both the Daegu International Airport and Dong-Daegu train station. Due to its location, Inter-Burgo EXCO Hotel is popular among exhibitions and fair visitors. There are a total of 303 guest rooms, including 36 suites, modernly furnished and equipped with direct dial telephones, bottled mineral water, wake-up call service and international TV channels.',
        isFavorite: false,
      ),
      Hotel(
        id: 1,
        name: 'APA Hotel',
        location: '2-3, Hibino, Mihama-ku, Chiba-shi',
        stars: 4,
        phoneNumber: '+81 570-070-111',
        description:
            'For travelers who want to take in the sights and sounds of Tokyo, APA Hotel & Resort Tokyo Bay Makuhari is the perfect choice. From here, guests can enjoy easy access to all that the lively city has to offer. With its convenient location, the hotel offers easy access to the must-see destinations.',
        isFavorite: false,
      ),
      Hotel(
        id: 2,
        name: 'Hyatt Place',
        location: '27-03 43RD AVE, Long Island City',
        stars: 3,
        phoneNumber: '+1 929-208-3100',
        description:
            'Situated in the Long Island City area, HYATT PLACE LONG ISLAND CITY/NY is the perfect place to experience Long Island City (NY) and its surroundings. From here, guests can make the most of all that the lively city has to offer. With its convenient location, the property offers easy access to the must-see destinations.',
        isFavorite: false,
      ),
      Hotel(
        id: 3,
        name: 'Novotel Peace Hotel',
        location: 'Beijing, Dongcheng, Jinyu Hutong',
        stars: 4,
        phoneNumber: '+861065128833',
        description:
            'This city center accommodation is ideal for both corporate and leisure travelers who want comfort and easy access to what Beijing has to offer. Novotel Peace Beijing Hotel is situated in a modern shopping and business district of Wangfujing. Guests will find themselves only steps away from world-famous attractions such as the Forbidden City and Tiananmen Square.',
        isFavorite: false,
      ),
      Hotel(
        id: 4,
        name: 'Millennium Hilton',
        location: '123 Charoennakorn Road, Klongsan',
        stars: 5,
        phoneNumber: '+66 2 442 2000',
        description:
            'Towering majestically over the Chao Praya River, this award-winning hotel boasts unrivaled river and city views. Boasting its own private pier, Millennium Hilton Bangkok offers frequent shuttle boats to the Saphan Taksin skytrain station and River City shopping center. Attractions such as the Grand Palace, Temple of Dawn, and the Reclining Buddha are all a quick boat ride away.',
        isFavorite: false,
      ),
      Hotel(
        id: 5,
        name: 'Hotel Artemide',
        location: '22, Nazionale Street, Termini Central Station',
        stars: 4,
        phoneNumber: '+39 06 489911',
        description:
            'Well-placed in the sightseeing, restaurants, culture area of Rome city, Artemide Hotel provides a most conducive spot for you to take a break from your busy days. The excitement of the city center is only 0.0 Km away. A haven of rest and relaxation, the hotel will offer total renewal just steps away from the numerous attractions such as St Paul\'s Within the Walls, Sartoria Italiana Quattro Fontane, Minerva Tours Rome.',
        isFavorite: false,
      ),
      Hotel(
        id: 6,
        name: 'Radisson Blu Waterfront Hotel',
        location: 'Nils Ericsons Plan 4, City Center',
        stars: 4,
        phoneNumber: '+46 8 505 060 00',
        description:
            'Conveniently located in Stockholm, Radisson Blu Waterfront Hotel Stockholm is a great base from which to explore this vibrant city. From here, guests can enjoy easy access to all that the lively city has to offer. For those of you who want to venture out, Stockholm Waterfront Arena, Stockholm City Hall, Stadshuset are just some of the attractions available to visitors.',
        isFavorite: false,
      ),
      Hotel(
        id: 7,
        name: 'Holiday Inn',
        location: 'Hofwisenstrasse 30 Rumlang, Kloten',
        stars: 4,
        phoneNumber: '+41 44 809 34 00',
        description:
            'Offering a free shuttle service from and to the airport, the Holiday Inn Express Zürich Airport offers air-conditioned rooms with flat-screen TV and free coffee and tea. The airport is just 5 km away, and the Zurich fairgrounds are also close by. The centre of Zurich can be reached within 20 minutes, and the nearest train station is a 5-minute walk from the hotel.',
        isFavorite: false,
      ),
    ];
    return allHotels;
  }
}
