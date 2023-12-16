enum PetAgeType { baby, adult, old }

PetAgeType getPetAgeType({required String description}) {
  if (description == 'น้อยกว่า 1 ปี') {
    return PetAgeType.baby;
  } else if (description == '1 - 7 ปี') {
    return PetAgeType.adult;
  } else if (description == 'มากกว่า 7 ปี') {
    return PetAgeType.old;
  } else {
    return PetAgeType.adult;
  }
}

String getPetAgeTypeName({required String petAgeType}) {
  if (petAgeType == 'baby') {
    return 'น้อยกว่า 1 ปี';
  } else if (petAgeType == 'adult') {
    return '1 - 7 ปี';
  } else if (petAgeType == 'old') {
    return 'มากกว่า 7 ปี';
  } else {
    return '1 - 7 ปี';
  }
}
