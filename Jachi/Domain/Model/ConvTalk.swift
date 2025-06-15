//
//  ConvTalk.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 15/06/25.
//

import Foundation

class ConvTalk {
    var id: UUID
    var hanzi: String
    var pinyin: String
    var translate: String
    var highlight: String

    init(
        hanzi: String, pinyin: String, translate: String, highlight: String = ""
    ) {
        self.id = UUID()
        self.hanzi = hanzi
        self.pinyin = pinyin
        self.translate = translate
        self.highlight = highlight
    }
}

extension ConvTalk {

    static let emptyTalk = ConvTalk(
        hanzi: "", pinyin: "", translate: "", highlight: "")
    
    // TODO: OUR List Pronounce

    static let talkUser1 = ConvTalk(
        hanzi: "你好，我要买一份牛肉丸", pinyin: "Nǐ hǎo, wǒ yào mǎi yí fèn niú ròu wán",
        translate: "Hello, I’d like to buy a portion of beef meatballs.",
        highlight: "一份牛肉丸")
    
    static let talkAuntie1 = ConvTalk(
        hanzi: "一份四十四块", pinyin: "Yí fèn sìshísì kuài",
        translate: "One portion is forty-four yuan.",
        highlight: "")
    
    static let talkUser2 = ConvTalk(
        hanzi: "一公斤三十块？有促销吗？", pinyin: "Yì gōng jīn sānshí kuài? Yǒu cùxiāo ma?",
        translate: "Thirty yuan per kilogram? Is there a promotion?",
        highlight: "有促销")
    
    static let talkAuntie2 = ConvTalk(
        hanzi: "要买几份？", pinyin: "Yào mǎi jǐ fèn?",
        translate: "How many portions do you want to buy?",
        highlight: "")
    
    static let talkUser3 = ConvTalk(
        hanzi: "两份八十块可以吗？", pinyin: "Liǎng fèn bāshí kuài kěyǐ ma?",
        translate: "Is eighty yuan for two portions okay?",
        highlight: "两份八十")
    
    static let talkAuntie3 = ConvTalk(
        hanzi: "三分七十块，我们的东西是精选的", pinyin: "Sān fèn qīshí kuài, wǒmen de dōng xi shì jīngxuǎn de",
        translate: "Three portions for seventy yuan — our products are carefully selected.",
        highlight: "")
    
    static let talkUser4 = ConvTalk(
        hanzi: "好的阿姨，用微信支付可以吗？", pinyin: "Hǎo de āyí, yòng Wēixìn zhīfù kěyǐ ma?",
        translate: "Alright, auntie, can I pay with WeChat Pay?",
        highlight: "用微信支付")
    
    static let talkAuntie4 = ConvTalk(
        hanzi: "可以", pinyin: "Kěyǐ",
        translate: "Yes",
        highlight: "")
    
    static let talkUser5 = ConvTalk(
        hanzi: "好的，这给您阿姨，谢谢", pinyin: "Hǎo de, zhè gěi nín āyí, xièxie",
        translate: "Alright, here you go, auntie. Thank you.",
        highlight: "")
}
