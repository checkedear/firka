import 'dart:typed_data';

import 'package:majesticons_flutter/majesticons_flutter.dart';

enum ClassIcon {
  mathematics(r'mate(k|matika)'),
  grammar(r'magyar nyelv|nyelvtan'),
  literature(r'irodalom'),
  history(r'tor(i|tenelem)'),
  geography(r'foldrajz'),
  art(r'rajz|muvtori|muveszet|vizualis'),
  physics(r'fizika'),
  music(r'^enek|zene|szolfezs|zongora|korus'),
  pe(r'^tes(i|tneveles)|sport|edzeselmelet'),
  chemistry(r'kemia'),
  biology(r'biologia'),
  env(r'kornyezet|termeszet ?(tudomany|ismeret)|hon( es nep)?ismeret'),
  religion(r'(hit|erkolcs)tan|vallas|etika|bibliaismeret'),
  economics(r'penzugy|gazdasag'),
  it(r'informatika|szoftver|iroda|digitalis'),
  code(r'prog|alkalmazas'),
  networking(r'halozat'),
  theatre(r'szinhaz'),
  film(r'film|media'),
  electricalEngineering(r'elektro(tech)?nika'),
  mechanicalEngineering(r'gepesz|mernok|ipar'),
  technika(r'technika'),
  dance(r'tanc'),
  philosophy(r'filozofia'),
  ofo(r'osztaly(fonoki|kozosseg)|kozossegi|neveles'),
  diligence(r'szorgalom'),
  attitude(r'magatartas'),
  language(r'angol|nemet|francia|olasz|orosz|spanyol|latin|kinai|nyelv'),
  linux(r'linux'),
  database(r'adatbazis.*'),
  applications(r'asztali alkalmazasok'),
  project(r'projekt');

  final String descriptor;

  const ClassIcon(this.descriptor);
}

Map<ClassIcon, Uint8List> _iconMap = {
  .economics: Majesticon.coinsSolid,
  .mathematics: Majesticon.calculatorSolid,
  .grammar: Majesticon.bookSolid,
  .literature: Majesticon.bookOpenSolid,
  .history: Majesticon.compass2Solid,
  .geography: Majesticon.globeEarth2Solid,
  .art: Majesticon.editPen2Solid,
  .music: Majesticon.musicNoteSolid,
  .chemistry: Majesticon.testTubeFilledSolid,
  .biology: Majesticon.covidSolid,
  .it: Majesticon.laptopSolid,
  .code: Majesticon.curlyBracesSolid,
  .networking: Majesticon.cloudSolid,
  .technika: Majesticon.ruler2Solid,
  .language: Majesticon.tooltipsSolid,
  .database: Majesticon.dataSolid,
  .film: Majesticon.tvOldLine,
};

ClassIcon? getIconType(String uid, String className, String category) {
  className = className
      .replaceAll("ö", "o")
      .replaceAll("ü", "u")
      .replaceAll("ó", "o")
      .replaceAll("ő", "o")
      .replaceAll("ú", "u")
      .replaceAll("é", "e")
      .replaceAll("á", "a")
      .replaceAll("ű", "u")
      .replaceAll("í", "i")
      .toLowerCase();

  for (var icon in ClassIcon.values) {
    if (RegExp(icon.descriptor).hasMatch(className)) {
      return icon;
    }
  }

  return null;
}

Uint8List getIconData(ClassIcon? icon) {
  if (icon == null) return Majesticon.alertCircleSolid;

  var iconData = _iconMap[icon];
  iconData ??= Majesticon.alertCircleSolid;

  return iconData;
}
