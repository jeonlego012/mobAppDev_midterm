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

import 'package:flutter/foundation.dart';

class Hotel {
  const Hotel({
    @required this.id,
    @required this.name,
    @required this.location,
    @required this.stars,
    @required this.phoneNumber,
    @required this.description,
  })  : assert(id != null),
        assert(name != null),
        assert(location != null),
        assert(stars != null),
        assert(phoneNumber != null),
        assert(description != null);

  final int id;
  final String name, location, phoneNumber, description;
  final int stars;

  String get assetName => 'assets/hotel_images/$id.jpg';

  /*@override
  String nameToString() => "$name (id=$id)";*/
}
