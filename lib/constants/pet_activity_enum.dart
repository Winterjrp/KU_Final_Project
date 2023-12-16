enum ActivityLevel { inactive, moderateActive, veryActive }

ActivityLevel getActivityLevel(String description) {
  if (description ==
      'อยู่นิ่งๆ เคลื่อนตัวเพื่อไปกินอาหาร/น้ำ, ขับถ่ายหรือออกกำลังกายน้อยกว่า 1 ชม./วัน (Inactive)') {
    return ActivityLevel.inactive;
  } else if (description == 'ออกกำลังกาย 1 - 3 ชม./วัน (Moderate active)') {
    return ActivityLevel.moderateActive;
  } else if (description == 'ออกกำลังกายมากกว่า 3 ชม./วัน (Very active)') {
    return ActivityLevel.veryActive;
  } else {
    return ActivityLevel.moderateActive;
  }
}

String getActivityLevelName(String activityType) {
  if (activityType == 'inactive') {
    return 'อยู่นิ่งๆ เคลื่อนตัวเพื่อไปกินอาหาร/น้ำ, ขับถ่ายหรือออกกำลังกายน้อยกว่า 1 ชม./วัน (Inactive)';
  } else if (activityType == 'moderateActive') {
    return 'ออกกำลังกาย 1 - 3 ชม./วัน (Moderate active)';
  } else if (activityType == 'veryActive') {
    return 'ออกกำลังกายมากกว่า 3 ชม./วัน (Very active)';
  } else {
    return 'ออกกำลังกาย 1 - 3 ชม./วัน (Moderate active)';
  }
}
