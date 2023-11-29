import 'dart:ui';

class ConfigData {
  String? background;
  String? backGifts;
  String? chooseSize;
  String? rightButtonActive;
  String? rightButton;
  String? leftButtonActive;
  String? leftButton;
  String? logo;
  String? qrBack;
  String? backBonus;
  String? instruction;
  String? qrScreenInfo;
  String? balance_button;
  String? get_bonus_button;
  String? home_bar_item;
  String? gift_bar_item;
  String? instruction_bar_item;
  String? color;
  String? size;
  String? bonus;
  List<num>? textColor;
  List<num>? mainColor;
  List<num>? activeColorMenuBar;
  List<num>? inactiveColorMenuBar;

  ConfigData(
      {this.background,
      this.chooseSize,
      this.backGifts,
      this.rightButton,
      this.leftButtonActive,
      this.leftButton,
      this.rightButtonActive,
      this.logo,
      this.qrBack,
      this.backBonus,
      this.instruction,
      this.qrScreenInfo,
      this.balance_button,
      this.get_bonus_button,
      this.home_bar_item,
      this.gift_bar_item,
      this.instruction_bar_item,
      this.color,
      this.size,
      this.bonus,
      this.textColor,
      this.mainColor,
      this.activeColorMenuBar,
      this.inactiveColorMenuBar});

  ConfigData.fromJson(Map<String, dynamic> json) {
    background = json['background'];
    chooseSize = json['chooseSize'];
    backGifts = json['backGifts'];
    rightButtonActive = json['rightButtonActive'];
    leftButton = json['leftButton'];
    leftButtonActive = json['leftButtonActive'];
    rightButton = json['rightButton'];
    backBonus = json['backBonus'];
    logo = json['logo'];
    qrBack = json['qrBack'];
    instruction = json['instruction'];
    qrScreenInfo = json['qrScreenInfo'];
    balance_button = json['balance_button'];
    get_bonus_button = json['get_bonus_button'];
    home_bar_item = json['home_bar_item'];
    gift_bar_item = json['gift_bar_item'];
    instruction_bar_item = json['instruction_bar_item'];
    color = json['color'];
    size = json['size'];
    bonus = json['bonus'];
    textColor = json['textColor'].cast<num>();
    mainColor = json['mainColor'].cast<num>();
    activeColorMenuBar = json['activeColorMenuBar'].cast<num>();
    inactiveColorMenuBar = json['inactiveColorMenuBar'].cast<num>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['background'] = background;
    data['chooseSize'] = chooseSize;
    data['backGifts'] = backGifts;
    data['rightButtonActive'] = rightButtonActive;
    data['leftButtonActive'] = leftButtonActive;
    data['leftButton'] = leftButton;
    data['background'] = background;
    data['backBonus'] = backBonus;
    data['logo'] = logo;
    data['qrBack'] = qrBack;
    data['logo'] = logo;
    data['instruction'] = instruction;
    data['qrScreenInfo'] = qrScreenInfo;
    data['balance_button'] = balance_button;
    data['get_bonus_button'] = get_bonus_button;
    data['home_bar_item'] = home_bar_item;
    data['gift_bar_item'] = gift_bar_item;
    data['instruction_bar_item'] = instruction_bar_item;
    data['color'] = color;
    data['size'] = size;
    data['bonus'] = bonus;
    data['textColor'] = textColor;
    data['mainColor'] = mainColor;
    data['activeColorMenuBar'] = activeColorMenuBar;
    data['inactiveColorMenuBar'] = inactiveColorMenuBar;
    return data;
  }

  Color getColor(List<num>? color) {
    var outputColor = Color.fromRGBO(
        color?[0] == null ? 255 : color![0] as int,
        color?[1] == null ? 255 : color![1] as int,
        color?[2] == null ? 255 : color![2] as int,
        color?[3] == null ? 255 : color![3] as double);
    return outputColor;
  }
}
