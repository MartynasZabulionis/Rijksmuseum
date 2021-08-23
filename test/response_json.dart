import 'dart:convert';

final artObjectsResponseJson = jsonEncode({
  "elapsedMilliseconds": 0,
  "count": 727625,
  "countFacets": {"hasimage": 506807, "ondisplay": 8402},
  "artObjects": [
    {
      "links": {
        "self": "http://www.rijksmuseum.nl/api/en/collection/BK-17496",
        "web": "http://www.rijksmuseum.nl/en/collection/BK-17496"
      },
      "id": "en-BK-17496",
      "objectNumber": "BK-17496",
      "title": "Blue Macaw",
      "hasImage": true,
      "principalOrFirstMaker": "Meissener Porzellan Manufaktur",
      "longTitle": "Blue Macaw, Meissener Porzellan Manufaktur, 1731",
      "showImage": true,
      "permitDownload": true,
      "webImage": {
        "guid": "fb490c6f-638a-44a8-81d3-ea27a04eae46",
        "offsetPercentageX": 0,
        "offsetPercentageY": 0,
        "width": 1822,
        "height": 2500,
        "url":
            "https://lh3.ggpht.com/5sc-SGzzgobkHnmnykUi4B1PqMtadoFqXOhYLQmsAI0Mcs_FeCoXT6loaiAUhr_zKvp2iyXntDxVhCzeVwjFulsjzRE=s0"
      },
      "headerImage": {
        "guid": "a355f7dd-d274-4797-9d71-e8f2fb0661ec",
        "offsetPercentageX": 0,
        "offsetPercentageY": 0,
        "width": 1822,
        "height": 437,
        "url":
            "https://lh3.ggpht.com/uXIT4pKPtocEUVmq6KZNWz4tSygyUZPi7HCCTq4big12nOUFBxJCIBM8vrDwepAM62ABjG-V6JnALRGgxJqWCfBLTQ=s0"
      },
      "productionPlaces": []
    }
  ]
}).toString();

final artObjectDetailsResponseJson = String.fromCharCodes(utf8.encode(jsonEncode({
  "elapsedMilliseconds": 200,
  "artObject": {
    "links": {"search": "http://www.rijksmuseum.nl/api/nl/collection"},
    "id": "en-NG-NM-7687",
    "priref": "363166",
    "objectNumber": "NG-NM-7687",
    "language": "en",
    "title": "Clock and gunpowder horn",
    "copyrightHolder": null,
    "webImage": {
      "guid": "05f438f9-f42d-4fec-ad6f-0feb3b08fed2",
      "offsetPercentageX": 50,
      "offsetPercentageY": 58,
      "width": 1672,
      "height": 2500,
      "url":
          "https://lh3.ggpht.com/lAJ1wnr_hEOncOfh9eKzvaS8w-fhLLq5yGlzHBctnjgyOzsbuP4cGIqP4q0A-YvnyXBhJi96il6NIZNhRVW-BVg2lW0=s0"
    },
    "colors": [
      {"percentage": 28, "hex": "#B2B2B1"},
      {"percentage": 28, "hex": " #CFCFCF"},
      {"percentage": 18, "hex": " #3E3630"},
      {"percentage": 13, "hex": " #58514A"},
      {"percentage": 4, "hex": " #75736E"},
      {"percentage": 3, "hex": " #969696"},
      {"percentage": 3, "hex": " #1D1A17"}
    ],
    "colorsWithNormalization": [
      {"originalHex": "#B2B2B1", "normalizedHex": "#B5BFCC"},
      {"originalHex": " #CFCFCF", "normalizedHex": "#B5BFCC"},
      {"originalHex": " #3E3630", "normalizedHex": "#000000"},
      {"originalHex": " #58514A", "normalizedHex": "#737C84"},
      {"originalHex": " #75736E", "normalizedHex": "#737C84"},
      {"originalHex": " #969696", "normalizedHex": "#737C84"},
      {"originalHex": " #1D1A17", "normalizedHex": "#000000"}
    ],
    "normalizedColors": [
      {"percentage": 36, "hex": "#696969"},
      {"percentage": 32, "hex": " #A9A9A9"},
      {"percentage": 28, "hex": " #D3D3D3"},
      {"percentage": 3, "hex": " #000000"}
    ],
    "normalized32Colors": [],
    "titles": [],
    "description":
        "Raderuurwerk van ijzer met zeven tandraderen en een omkleedsel van ijzeren platen. Het ijzeren omkleedsel is gedeeltelijk weggeroest, de wijzerplaat is verloren en er is maar één wijzer aanwezig en een cirkelvormig onderdeel van  buigzaam ijzer. Het cirkelvormige onderdeel is geheel verroest. Mogelijk is dit onderdeel de veer? Zie De Veer, 27 oct. en 3 dec. 1596.",
    "labelText": null,
    "objectTypes": ["clockwork", "clock", "mechanical clock"],
    "objectCollection": [],
    "makers": [
      {
        "name": "anonymous",
        "unFixedName": "anonymous",
        "placeOfBirth": null,
        "dateOfBirth": null,
        "dateOfBirthPrecision": null,
        "dateOfDeath": null,
        "dateOfDeathPrecision": null,
        "placeOfDeath": null,
        "occupation": [],
        "roles": ["clockmaker"],
        "nationality": null,
        "biography": null,
        "productionPlaces": ["Germany"],
        "qualification": null
      },
      {
        "name": "anonymous",
        "unFixedName": "anonymous",
        "placeOfBirth": null,
        "dateOfBirth": null,
        "dateOfBirthPrecision": null,
        "dateOfDeath": null,
        "dateOfDeathPrecision": null,
        "placeOfDeath": null,
        "occupation": [],
        "roles": ["clockmaker"],
        "nationality": null,
        "biography": null,
        "productionPlaces": ["France"],
        "qualification": null
      }
    ],
    "principalMakers": [
      {
        "name": "anonymous",
        "unFixedName": "anonymous",
        "placeOfBirth": null,
        "dateOfBirth": null,
        "dateOfBirthPrecision": null,
        "dateOfDeath": null,
        "dateOfDeathPrecision": null,
        "placeOfDeath": null,
        "occupation": [],
        "roles": ["clockmaker"],
        "nationality": null,
        "biography": null,
        "productionPlaces": ["Low Countries"],
        "qualification": null
      }
    ],
    "plaqueDescriptionDutch":
        "In 1596 overwinterden Willem Barentsz, Jacob van Heemskerck en vijftien anderen in een zelfgebouwd huis op het eiland Nova Zembla voor de Russische kust. Opgesloten in het huis tijdens de poolnacht hadden de mannen geen besef van dag en nacht. Een klok aan de muur gaf de tijd aan, tot deze op 3 december 1596 definitief vastvroor. ",
    "plaqueDescriptionEnglish":
        "In 1596, Willem Barentsz, Jacob van Heemskerck and fifteen others spent the winter in an improvised shelter on the island of Nova Zembla off the north coast of Russia. Confined to their hut in the middle of the Polar winter, the men had no sense of night or day. A clock on the wall told the time, until it finally froze to a halt on 3 December 1596. ",
    "principalMaker": "anonymous",
    "artistRole": null,
    "associations": [],
    "acquisition": {"method": "transfer", "date": "1885-03-01T00:00:00", "creditLine": null},
    "exhibitions": [],
    "materials": ["iron (metal)"],
    "techniques": ["forging"],
    "productionPlaces": ["Low Countries", "Germany", "France"],
    "dating": {
      "presentingDate": "c. 1590 - c. 1596",
      "sortingDate": 1590,
      "period": 16,
      "yearEarly": 1590,
      "yearLate": 1596
    },
    "classification": {
      "iconClassIdentifier": [],
      "iconClassDescription": [],
      "motifs": [],
      "events": ["Overwintering op Nova Zembla"],
      "periods": ["15961597"],
      "places": ["Nova Zembla", "Behouden Huys"],
      "people": ["Barendsz., Willem", "Heemskerck, Jacob van"],
      "objectNumbers": ["NG-NM-7687"]
    },
    "hasImage": true,
    "historicalPersons": ["Barendsz., Willem", "Heemskerck, Jacob van"],
    "inscriptions": [],
    "documentation": [],
    "catRefRPK": [],
    "principalOrFirstMaker": "anonymous",
    "dimensions": [
      {"unit": "cm", "type": "height", "part": null, "value": "38.9"},
      {"unit": "cm", "type": "width", "part": null, "value": "20.5"},
      {"unit": "cm", "type": "depth", "part": null, "value": "16.4"}
    ],
    "physicalProperties": [],
    "physicalMedium": "forging",
    "longTitle": "Clock and gunpowder horn, anonymous, c. 1590 - c. 1596",
    "subTitle": "h 38.9cm × w 20.5cm × d 16.4cm",
    "scLabelLine": "anonymous, c. 1590 - c. 1596, forging",
    "label": {
      "title": "Clock and gunpowder horn",
      "makerLine": null,
      "description":
          "This clock was originally intended as merchandise for sale or as a gift. It was hung up in the ‘Save House’ as the only means of providing a sense of time during the long, polar nights. On 3 December 1596, it froze. Barentsz and Van Heemskerck shoved a parting letter into the gunpowder horn when they left. Three centuries later, the horn was rediscovered with the letter still inside. The letter cannot be exhibited due to its fragility.",
      "notes": "NG-NM-7687 t/m 7689, NG-NM-7836 en NG-NM-7764. Multimediatour",
      "date": "2018-05-01"
    },
    "showImage": true,
    "location": "HG-2.9"
  },
  "artObjectPage": {
    "id": "en-NG-NM-7687",
    "similarPages": [],
    "lang": "en",
    "objectNumber": "NG-NM-7687",
    "tags": [],
    "plaqueDescription":
        "In 1596, Willem Barentsz, Jacob van Heemskerck and fifteen others spent the winter in an improvised shelter on the island of Nova Zembla off the north coast of Russia. Confined to their hut in the middle of the Polar winter, the men had no sense of night or day. A clock on the wall told the time, until it finally froze to a halt on 3 December 1596. ",
    "audioFile1": null,
    "audioFileLabel1": null,
    "audioFileLabel2": null,
    "createdOn": "0001-01-01T00:00:00",
    "updatedOn": "2012-09-18T14:06:30.6999803+00:00",
    "adlibOverrides": {"titel": null, "maker": null, "etiketText": null}
  }
}).toString()));
